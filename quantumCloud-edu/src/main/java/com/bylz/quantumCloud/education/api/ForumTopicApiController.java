/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.education.api;

import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.*;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 论坛主题Controller层
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
@Controller
@RequestMapping("/api/ForumTopic")
public class ForumTopicApiController extends BaseController {

    @Autowired
    public ForumTopicService forumTopicService;

    @Autowired
    private EduStatisticsService eduStatisticsService;

    @Autowired
    private QcodeUserService qcodeuserservice;

    /**
     * 添加论坛
     */
    @RequestMapping(value = "/addForumTopic.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData addForumTopic(HttpServletRequest request) {
        ResponseData data =new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("content") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("title") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            ForumTopicVo forumTopicVo = new ForumTopicVo();

            forumTopicVo.setBelonged("1");
            forumTopicVo.setUserId(userInfor.getId());
            forumTopicVo.setReplyCount("0");
            forumTopicVo.setTitle(map.get("title").toString());
            forumTopicVo.setContent(map.get("content").toString());

            if(StringUtils.isNotBlank((String)map.get("fileUrl"))) {
                forumTopicVo.setTopicFace(map.get("fileUrl").toString());
            }

            forumTopicService.save(forumTopicVo);

            List<ForumLableVo> lableVoList = new ArrayList<>();//固定标签集合
            if(map.get("labels") != null) {
                String[] labels = map.get("labels").toString().split(",");
                Long forumTopicId = Long.valueOf(forumTopicService.getMaxForumId());

                for(int i = 0;i<labels.length;i++) {
                    ForumLableVo forumLableVo = new ForumLableVo();
                    forumLableVo.setForumTopicId(forumTopicId);
                    forumLableVo.setLabel(labels[i]);
                    lableVoList.add(forumLableVo);
                }

            }

            if(map.get("myLabels") != null) {
                List myLabelList = new ArrayList();//自定义标签集合
                String[] myLabels = map.get("myLabels").toString().split(",");

                for(int i = 0;i<myLabels.length;i++) {
                    myLabelList.add(myLabels[i]);
                }

                filter.put("myLabelList",myLabelList);
                filter.put("userId",userInfor.getId());
                int count = forumTopicService.getMaxDicContent(filter);//获得最大标签字典数
                filter.put("maxCount",count);
                forumTopicService.insertLable(filter);//插入字典表
            }

            if(lableVoList.size() > 0) {
                //保存标签
                forumTopicService.saveLable(lableVoList);
            }

            EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
            if(eduStatisticsVo != null) {
                eduStatisticsVo.setPublishForumCount(eduStatisticsVo.getPublishForumCount()+1);
                eduStatisticsService.update(eduStatisticsVo);
            }else {
                filter.clear();
                filter.put("publishForumCount",1);
                filter.setStatementKey("addEduStatistics1");
                eduStatisticsService.save(filter);
            }

            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }

    /**
     * 添加论坛回复
     */
    @RequestMapping(value = "/addForumReply.json")
    @ResponseBody
    public ResponseData addForumReply(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("forumTopicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("parentId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("pIds") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("content") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String forumUserId = map.get("forumUserId") == null?null:map.get("forumUserId").toString();

            ForumReplyVo forumReplyVo = new ForumReplyVo();
            //回复人id
            forumReplyVo.setUserId(userInfor.getId());
            //回复人name
            forumReplyVo.setUserName(userInfor.getName());
            //添加论坛回复
            forumReplyVo.setContent(map.get("content").toString());

            forumReplyVo.setParentId((String)map.get("parentId"));

            forumReplyVo.setpIds((String)map.get("pIds"));

            String repdUserId = map.get("repdUserId") == null?null:map.get("repdUserId").toString();
            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getEquipment");
            Map userMap = qcodeuserservice.findOne(filter).getReturnObj();
            filter.clear();
            LinkedList<String> linkedList = new LinkedList<String>();
            linkedList.add(userMap.get("equipmentId").toString());
            Map extraMap = new HashMap();
            String title = "";
            if(StringUtils.isNotBlank(repdUserId)) {
                forumReplyVo.setRepdUserId(repdUserId);
                extraMap.put("id",map.get("forumTopicId").toString());
                extraMap.put("pushType","2");//回复被回复
                title = userInfor.getName()+"回复了你的评论";
            }

            if(StringUtils.isNotBlank(forumUserId)) {
                extraMap.put("id",map.get("forumTopicId").toString());
                extraMap.put("pushType","2");//帖子被回复
                title = userInfor.getName()+"评论了你的帖子";
            }


            JPushUtils.jPushClient.sendPush(JPushUtils.buildPushObject_android_and_ios(linkedList,title,map.get("content").toString(),extraMap));
            forumReplyVo.setForumTopicId(Long.parseLong(map.get("forumTopicId").toString()));

            forumTopicService.addForumReply(forumReplyVo);

            if(StringUtils.isNotBlank(forumReplyVo.getParentId())) {
                filter.put("userId",forumUserId);
                filter.put("opType","3");
                forumTopicService.addNotOnlineData(filter);
            }

            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }
    /**
     * 论坛回复赞、踩一下
     */
    @RequestMapping(value = "/updReplyLike.json")
    @ResponseBody
    public ResponseData updateReply(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("id") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("forumTopicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            if(map.get("forumReplyId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("approvalCount") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            filter.put("id",map.get("id"));
            filter.put("forumTopicId",map.get("forumTopicId"));
            filter.put("forumReplyId",map.get("forumReplyId"));
            filter.put("approvalCount",map.get("approvalCount"));
            //修改回复
            forumTopicService.updReplyLike(filter);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }
    /**
     * 论坛主题赞、踩一下
     */
    @RequestMapping(value = "/updForumTopicLike.json")
    @ResponseBody
    public ResponseData updForumTopic(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("id") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("forumTopicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            if(map.get("forumReplyId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("approvalCount") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            //修改论坛主题
            forumTopicService.updForumTopicLike(filter);

            if("1".equals(map.get("approvalCount"))) {
                filter.put("opType","4");
                filter.put("userId",map.get("forumUserId").toString());
                forumTopicService.addNotOnlineData(filter);
            }

            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }
    /**
     * 论坛收藏（0：未收藏，1：已收藏）
     */
    @RequestMapping(value = "/updCollect.json")
    @ResponseBody
    public ResponseData updCollect(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setSuccess(false);
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("isCollect") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            if(map.get("forumTopicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            //修改论坛主题
            forumTopicService.updCollect(filter);
            if("1".equals(map.get("isCollect").toString())) {
                filter.put("opType","2");
                filter.put("userId",map.get("forumUserId").toString());
                forumTopicService.addNotOnlineData(filter);
            }
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;

        }

    }
    /**
     * 删除回复
     */
    @RequestMapping(value = "/delReply.json")
    @ResponseBody
    public ResponseData delReply(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();
            String id = map.get("id") == null ? null : map.get("id").toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if (id == null || "".equals(id)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            //删除回复
            forumTopicService.delReply(filter);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }


    /**
     * 关注/取消关注
     * @param request
     * @return
     */
    @RequestMapping(value = "/focusForum.json")
    @ResponseBody
    public ResponseData focusForum(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            QueryFilter queryFilter = new QueryFilter(request);
            queryFilter.put("focusId",userInfor.getId());//关注人id
            forumTopicService.addOrDelFocus(queryFilter);
            if("1".equals(queryFilter.get("flag"))) {
                queryFilter.put("opType","1");
                queryFilter.setStatementKey("addFocus");
                forumTopicService.addNotOnlineData(queryFilter);
            }
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 分享统计
     * @param request
     * @return
     */
    @RequestMapping(value = "/sharStatistics.json")
    @ResponseBody
    public ResponseData sharStatistics(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("sharCount") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            if(map.get("id") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter queryFilter = new QueryFilter(request);
            forumTopicService.sharStatistics(queryFilter);
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 查询论坛右边个人信息
     * @return
     */
    @RequestMapping("/queryUser.json")
    @ResponseBody
    public ResponseData queryForumUser(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("forumUserId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());

            filter.put("forumUserId",(Long)map.get("forumUserId"));
            data.setObj(forumTopicService.queryUser(filter));
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 举报帖子和评论
     */
    @RequestMapping(value = "/reportTopicReply.json")
    @ResponseBody
    public ResponseData reportTopicReply(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取登录信息
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("topicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("replyId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("reportType") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("type") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("reportContent") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());

            forumTopicService.reportTopicReply(filter);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 反馈建议
     * @param request
     * @return
     */
    @RequestMapping("/feedback.json")
    @ResponseBody
    public ResponseData feed(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        QueryFilter filter = new QueryFilter(request);
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("problemType") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("belonged") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }


            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Iterator<String> iter = multipartRequest.getFileNames();
            List<MultipartFile> fileRows = null;
            while (iter.hasNext()) {
                fileRows = multipartRequest.getFiles(iter.next().toString());
            }

            MultipartFile[] multipartFiles = {};
            if(fileRows.size() > 0) {
                multipartFiles = new MultipartFile[fileRows.size()];
                fileRows.toArray(multipartFiles);
            }
            filter.put("userId",userInfor.getId());
            int successCount = forumTopicService.saveFeedback(filter,multipartFiles);

            if(successCount == 1) {
                return data;
            }

            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    @RequestMapping("/upload.json")
    @ResponseBody
    public ResponseData upload(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator<String> iter = multiRequest.getFileNames();
            // 获取multiRequest 中所有的文件名.

            String filePath="";
            while (iter.hasNext()) {
                // 适配名字重复的文件
                try {
                    List<MultipartFile> fileRows = multiRequest.getFiles(iter.next().toString());
                    if (fileRows != null && fileRows.size() != 0) {
                        for (MultipartFile file : fileRows) {
                            if (file != null && !file.isEmpty()) {
                                String fileName = file.getOriginalFilename();
                                String ext = fileName.substring(fileName.indexOf("."),fileName.length());
                                filePath = AppContextHolder.getFileSavePath()+"headFile"+"/"+userInfor.getId()+ DateUtils.formatDatetime(new Date(), DateUtils.DateStyle.YYYYMMDDHHMMSSSSS)+ext;
                                InputStream in = file.getInputStream();
                                FileOutputStream fileOutputStream = new FileOutputStream(filePath);
                                byte buffer[] = new byte[1024];
                                //判断输入流中的数据是否已经读完的标识
                                int len = 0;
                                //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                                while((len=in.read(buffer))>0){
                                    //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                                    fileOutputStream.write(buffer, 0, len);
                                }
                                in.close();
                                fileOutputStream.close();
                            }
                        }
                    }
                }catch (Exception e) {
                    e.printStackTrace();
                    logger.error(e.getMessage());
                    data.setSuccess(false);
                    data.setObj("{'errno':1,'data':[localhost:8080/files/"+filePath+"]}");
                    return data;
                }

            }
            if(("//" + filePath).contains(AppContextHolder.getFileSavePath())){
                filePath = ("//" + filePath).substring(AppContextHolder.getFileSavePath().length() + 1);
            }

            int firstIndex = filePath.indexOf("/");
            filePath = filePath.substring(firstIndex + 1);
            data.setObj("{\"errno\":0,\"data\":[\""+filePath+"\"]}");
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 获得不在线时记录
     * @return
     */
    @RequestMapping("/getAllNotic.json")
    @ResponseBody
    public ResponseData getAllNotic(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try{
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            int count = forumTopicService.getNotOnlineCount(filter);
            data.setObj(count);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }


    }

    /**
     * 置顶
     * @param request
     * @return
     */
    @RequestMapping("/setTop.json")
    @ResponseBody
    public ResponseData setTop(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try{
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("forumTopicId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("topLevel","2");
            forumTopicService.setTop(filter);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }

    /**
     * 删除帖子
     * @param request
     * @return
     */
    @RequestMapping("/delForum.json")
    @ResponseBody
    public ResponseData delForum(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try{
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("id") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            forumTopicService.delForum(filter);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    /**
     * 添加自定义标签
     * @param request
     * @return
     */
    @RequestMapping("/insertLabel.json")
    @ResponseBody
    public ResponseData insertLabel(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try{
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(map.get("labelName") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId",userInfor.getId());
            Map<String,Object> dicMap = forumTopicService.haseDicContent(filter);
            if(Integer.parseInt(dicMap.get("hascount").toString()) > 0 && "1".equals(dicMap.get("deflag"))) {
                data.setSuccess(false);
                data.setMessage("已有此标签");
                return data;
            }else if(Integer.parseInt(dicMap.get("hascount").toString()) > 0 && "0".equals(dicMap.get("deflag"))) {
                data.setSuccess(false);
                data.setMessage("标签正在审核");
                return data;
            }

            int dicCount = forumTopicService.dicContentCount(filter);
            if(dicCount > 4) {
                data.setSuccess(false);
                data.setMessage("每人最多添加5个标签！");
                return data;
            }else {
                data.setObj(dicCount);
                return data;
            }

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }




    /**
     * 的判断当前时间是否为工作日
     * @return
     */
    private boolean isWeek () {
        Calendar calendar = new GregorianCalendar();
        int week = calendar.get(Calendar.DAY_OF_WEEK);
        int h = calendar.get(Calendar.HOUR);
        int m = calendar.get(Calendar.MINUTE);
        String time = h+":"+m;
        if(week == 1 || week == 7) {//周六日
            return false;
        }

        SimpleDateFormat df = new SimpleDateFormat("HH:mm");//设置日期格式
        Date now =null;
        Date beginTime = null;
        Date endTime = null;
        try {
            now = df.parse(df.format(new Date()));
            beginTime = df.parse("07:30");
            endTime = df.parse("17:30");
        } catch (Exception e) {
            e.printStackTrace();
        }

        Boolean flag = belongCalendar(now, beginTime, endTime);
        if(!flag) {
            return false;
        }
        return true;
    }

    /**
     * 判断时间是否在某一时间段
     * @param nowTime
     * @param beginTime
     * @param endTime
     * @return
     */
    private boolean belongCalendar(Date nowTime, Date beginTime, Date endTime) {
        Calendar date = Calendar.getInstance();
        date.setTime(nowTime);

        Calendar begin = Calendar.getInstance();
        begin.setTime(beginTime);

        Calendar end = Calendar.getInstance();
        end.setTime(endTime);

        if (date.after(begin) && date.before(end)) {
            return true;
        } else {
            return false;
        }
    }


    /**
     *查询列表接口(不分页)
     * @param request
     * @return
     */
    @RequestMapping("/forumTopicList.json")
    @ResponseBody
    public ResponseData getForumTopicList(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("selectIndexList");
        filter.put("applyStatus","1");

        List<ForumTopicVo> list = null;
        ResponseData responseData = null;

        try {
            list = forumTopicService.findList(filter).getReturnObj();
        }catch (Exception e) {
            responseData = new ResponseData(false,"获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true,"");
        responseData.setObj(list);
        return responseData;
    }


    /**
     *查询列表接口(分页)
     * @param request
     * @return
     */
    @RequestMapping("/forumTopicListPage.json")
    @ResponseBody
    public ResponseData getForumTopicListPage(HttpServletRequest request) throws Exception {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("selectIndexList");

        Pagination pagination = null;

        try {
            pagination = forumTopicService.findPager(filter).getReturnObj();
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("获取失败");
            e.printStackTrace();
            return data;
        }

        data.setObj(pagination);
        return data;
    }

    /**
     *查询详情接口
     * @return
     */
    @RequestMapping("/forumDetailsById.json")
    @ResponseBody
    public ResponseData getForumDetails(HttpServletRequest request) throws Exception {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        Map map = GetParmFromRequestUtils.getParams(request);
        if (map == null) {
            data.setSuccess(false);
            data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
            return data;
        }

        if(map.get("id") == null || map.get("id").toString() == "") {
            data.setSuccess(false);
            data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
            return data;
        }

        String ip = "";
        if(StringUtils.isNotBlank((String)map.get("IMEI"))) {
            ip = map.get("IMEI").toString();
        }else {
            ip = (String)AppContextHolder.getSession().getAttribute("userIP");
        }

        QcodeUser user = null;

        if(StringUtils.isNotBlank((String)map.get("token"))) {
            user = GetUserIdByApikey.getUserId((String)map.get("token"));
        }

        ForumTopicVo forumTopicParam = new ForumTopicVo();
        forumTopicParam.setId(Long.parseLong(map.get("id").toString()));
        if(user != null) {
            forumTopicParam.setUserId(user.getId());
        }
        ForumTopicVo forumTopicVo = null;
        try {
            forumTopicVo = forumTopicService.getCommunityById(forumTopicParam,ip);
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("获取失败");
            e.printStackTrace();
            return data;
        }

        data.setObj(forumTopicVo);
        return data;
    }


    /**
     * 查询我的帖子/我的回复(不分页)
     * @param request
     * @return
     */
    @RequestMapping("/myForum.json")
    public ResponseData getMyFocus(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);
        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if("1".equals(queryFilter.get("type")) || StringUtils.isBlank((String)queryFilter.get("type"))) {//我的帖子
                queryFilter.setStatementKey("getMyForum");
            }else {
                queryFilter.setStatementKey("getMyReplyForum");
            }
            List<ForumTopicVo> list = forumTopicService.findList(queryFilter).getReturnObj();;
            data.setObj(list);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }

    /**
     * 查询我的帖子/我的回复(分页)
     * @param request
     * @return
     */
    @RequestMapping("/myForumPage.json")
    @ResponseBody
    public ResponseData getMyFocusPage(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(queryFilter.get("type") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            if(queryFilter.get("start") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            queryFilter.put("userId",userInfor.getId());

            if("1".equals(queryFilter.get("type")) || StringUtils.isBlank((String)queryFilter.get("type"))) {//我的帖子
                queryFilter.setStatementKey("getMyForum");
            }else {
                queryFilter.setStatementKey("getMyReplyForum");
            }
            Pagination pagination = forumTopicService.findPager(queryFilter).getReturnObj();;
            data.setObj(pagination);
            return data;



        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    /**
     * 查询关注情况(不分页)
     * @param request
     * @return
     */
    @RequestMapping("/forumFocus.json")
    @ResponseBody
    public ResponseData getMyFocusDetail(HttpServletRequest request) throws Exception {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        QueryFilter filter = new QueryFilter(request);
        String userId = filter.get("userId").toString();
        if(StringUtils.isBlank(userId)) {
            data.setSuccess(false);
            data.setMessage("缺少必要参数");
            return data;
        }
        List<FocusUserVo> list = null;
        if(StringUtils.isNotBlank(filter.get("opType").toString())) {
            forumTopicService.delNoticMessage(filter);
        }

        try {
            filter.setStatementKey("getFocusUserDetails");
            list = forumTopicService.findList(filter).getReturnObj();
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("获取失败");
            e.printStackTrace();
            return data;
        }

        data.setObj(list);
        return data;
    }

    /**
     * 查询关注情况(分页)
     * @param request
     * @return
     */
    @RequestMapping("/forumFocusPage.json")
    @ResponseBody
    public ResponseData getMyFocusDetailPage(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);

        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(filter.get("start") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }


            if(StringUtils.isNotBlank(filter.get("opType").toString())) {
                forumTopicService.delNoticMessage(filter);
            }

            filter.setStatementKey("getFocusUserDetails");
            Pagination list = forumTopicService.findPager(filter).getReturnObj();

            data.setObj(list);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    /**
     * 查询我的收藏(不分页)
     * @param request
     * @return
     */
    @RequestMapping("/myCollect.json")
    @ResponseBody
    public ResponseData getMyCollect(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.setStatementKey("queryCollect");
        String userId = queryFilter.get("userId").toString();
        if(StringUtils.isBlank(userId)) {
            return new ResponseData(false,"缺少必要参数");
        }

        ResponseData responseData = null;
        List<Map> list = null;

        try {
            list = forumTopicService.findList(queryFilter).getReturnObj();
        }catch (Exception e) {
            responseData = new ResponseData(false,"获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true,"");
        responseData.setObj(list);
        return responseData;
    }

    /**
     * 查询我的收藏(分页)
     * @param request
     * @return
     */
    @RequestMapping("/myCollectPage.json")
    @ResponseBody
    public ResponseData getMyCollectPage(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);

        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            queryFilter.setStatementKey("queryCollect");

            Pagination list = forumTopicService.findPager(queryFilter).getReturnObj();

            data.setObj(list);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    /**
     * 达人热帖
     * @param
     * @return
     */
    @RequestMapping("/queryHot.json")
    @ResponseBody
    public ResponseData getHotForumList() {
        QueryFilter filter = new QueryFilter();
        List<ForumTopicVo> list = null;
        ResponseData data = new ResponseData(true);
        data.setObj("");
        try {
            list = forumTopicService.queryHot(filter);
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("获取失败");
            e.printStackTrace();
            return data;
        }

        data.setObj(list);
        return data;
    }


    /**
     * 查询谁点赞，收藏了我的哪些帖子
     * @param
     * @return
     */
    @RequestMapping("/queryMyCollect.json")
    @ResponseBody
    public ResponseData queryMyCollect(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);

        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            if(filter.get("type") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            if(filter.get("start") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            filter.put("userId",userInfor.getId());
            forumTopicService.delNoticMessage(filter);

            if("1".equals(filter.get("type").toString())) {//收藏
                filter.setStatementKey("queryCollectForum");
            }else {
                filter.setStatementKey("queryLikeForumApi");
            }

            List<Object> list = forumTopicService.findList(filter).getReturnObj();

            data.setObj(list);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    /**
     * 查询通知我的评论
     * @param request
     * @return
     */
    @RequestMapping("/queryMyForumReply.json")
    @ResponseBody
    public ResponseData queryMyForumReply(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);

        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            filter.put("userId",userInfor.getId());
            forumTopicService.delNoticMessage(filter);
            filter.setStatementKey("queryLevelOneReplyfv");

            List<ForumReplyVo> list = forumTopicService.findList(filter).getReturnObj();

            data.setObj(list);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    /**
     * 分页查询评论
     */
    @RequestMapping(value = "/getReply.json")
    @ResponseBody
    public ResponseData getReplyApi(HttpServletRequest request) throws Exception {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        Map<String,Object> map = GetParmFromRequestUtils.getParams(request);
        QueryFilter filter = new QueryFilter(request);

        String token = map.get("token") == null ? null : map.get("token").toString();

        QcodeUser qcodeUser = null;
        if (StringUtils.isNotBlank(token)) {
            qcodeUser = GetUserIdByApikey.getUserId(token);
        }


        if(filter.get("forumTopicId") == null) {
            data.setSuccess(false);
            data.setMessage("缺少必要参数");
            return data;
        }

        if(filter.get("start") == null) {
            data.setSuccess(false);
            data.setMessage("缺少必要参数");
            return data;
        }

        if(qcodeUser != null) {
            filter.put("userId",qcodeUser.getId());
        }
        filter.setLimit(6);
        filter.setStatementKey("findReplyList");
        Pagination pagination = forumTopicService.findPager(filter).getReturnObj();
        List list = pagination.getEntityList();
        for(int i = 0;i < list.size();i++) {
            Map<String,Object> map1 = (Map)list.get(i);
            String pIds = map1.get("pids").toString();
            String[] pid = pIds.split(",");
            String[] newPid = {"0"};
            if(pid.length > 2) {
                newPid  = Arrays.copyOfRange(pid,pid.length-2,pid.length);
            }else {
                newPid = pid;
            }

            filter.clear();
            filter.put("pIds",newPid);
            filter.put("pId",map1.get("id"));
            filter.setStatementKey("getParentReply");
            List<Map> list1 = forumTopicService.findList(filter).getReturnObj();
            map1.put("replyList",list1);

        }
        data.setObj(pagination);
        return data;
    }

    /**
     * 分页查询父级评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/getParentReplyApi.json")
    @ResponseBody
    public ResponseData getParentReplyApi(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        QueryFilter filter = new QueryFilter(request);

        if(filter.get("pIds") == null) {
            data.setSuccess(false);
            data.setMessage("缺少必要参数");
            return data;
        }

        if(filter.get("pId") == null) {
            data.setSuccess(false);
            data.setMessage("缺少必要参数");
            return data;
        }

        filter.setLimit(6);
        data.setObj(forumTopicService.getParentReply(filter));
        return data;
    }


    /**
     * 查询精品论坛
     * @param request
     * @return
     * obj={forum_topic_id,content,title,user_id,face,lasttime}
     */
    @RequestMapping("/queryQualityForumTopic.json")
    @ResponseBody
    public ResponseData queryQualityForum(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("qualityforumtopic");
        //查询人数最多的五条评论的id
        Object obj = new Object();
        List<Map> list=null;
        list=forumTopicService.findList(filter).getReturnObj();
        for(int i=0;i<list.size();i++) {
            String facepath= (String) list.get(i).get("face");
            if(facepath==""||facepath==null) {
                facepath="https://qcode.qpanda.cn"+"/assets/forImg/Head.png";
                list.get(i).put("face",facepath);
                System.out.println(facepath);
            }else {
                facepath="https://qcode.qpanda.cn/files/"+facepath;
                list.get(i).put("face",facepath);
                System.out.println(facepath+"else");
            }

        }
        ResponseData responseData = null;
        try {
            obj = list;
        }catch (Exception e) {
            responseData = new ResponseData(false,"获取失败");
            e.printStackTrace();
            return responseData;
        }
        responseData = new ResponseData(true,"");
        responseData.setObj(obj);
        return responseData;
    }



    /**
     * 查询推荐自选
     * @param request
     * @return
     * obj={forum_topic_id,content,title,user_id,face,lasttime}
     */
    @RequestMapping("/recommendedNews.json")
    @ResponseBody
    public ResponseData recommendedNews(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        forumTopicService.delNoticMessage(filter);
        filter.setStatementKey("recommendnews");
        //查询人数最多的五条评论的id
        Object obj = new Object();
        List<Map> list=null;
        list=forumTopicService.findList(filter).getReturnObj();

        ResponseData responseData =new ResponseData(true,"");
        if(list==null) {
        	responseData.setObj("");
        }else {
        	responseData.setObj(list);
        }   
        return responseData;
    }


    @RequestMapping("/getMyLike.json")
    @ResponseBody
    public ResponseData getMyLike(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");

        try {
            Map map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String token = map.get("token") == null ? null : map.get("token").toString();

            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage("key_is_not_null");
                return data;
            }

            QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


            if (userInfor == null) {
                data.setSuccess(false);
                data.setMessage("key_does_not_exist");
                return data;
            }

            QueryFilter filter = new QueryFilter(request);
            filter.put("userId", userInfor.getId());
            filter.setStatementKey("getMyLike");
            data.setObj(forumTopicService.findList(filter).getReturnObj());
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }

    }



}
