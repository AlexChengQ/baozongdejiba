/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.platform.controller;

import java.io.*;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.platform.util.DateUtils;
import com.bylz.quantumCloud.platform.util.SensitiveWordUtil;
import com.bylz.quantumCloud.platform.util.TemplateSendEmail;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.bylz.quantumCloud.service.PlatformBlockService;
import com.bylz.quantumCloud.service.SensitiveWordService;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.record.formula.functions.T;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.platform.util.FileUploadUtils;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 论坛主题Controller层
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
@Controller
@RequestMapping("/qcode/forumtopic")
public class ForumTopicController extends BaseController {

    public static final String FORUMTOPIC_COMMUNITY = "forumtopic/community";
    public static final String FORUMTOPIC_COMMUNITY_HOME = "forumtopic/communityHome";

    public static final String FORUMTOPIC_COMMUNITYDETAIL = "forumtopic/communityDetail";
    public static final int MAXCUT = 60;

    @Autowired
    public ForumTopicService forumTopicService;

    /**
     * 邮件service
     */
    @Autowired
    private TemplateSendEmail templateEmail;

    @Autowired
    private SensitiveWordService sensitiveWordService;

    @Autowired
    private PlatformBlockService platformBlockService;

    @Autowired
    private EduStatisticsService eduStatisticsService;

    /**
     * 论坛首页
     */
    @RequestMapping(value = "/index.html")
    public String communityIndex(ModelMap model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        List<String> list = forumTopicService.getIsApproval(filter);
        if (list.size() == 1 && "1".equals(list.get(0))) {
            filter.put("applyStatus", "1");
        }

        if (StringUtils.isBlank((String) request.getParameter("content"))) {
            model.put("content", "");
        } else {
            filter.put("content", request.getParameter("content"));
            model.put("content", request.getParameter("content"));
        }

        filter.setStatementKey("selectIndexList");
        model.put("title", filter.get("title"));
        model.put("pager", forumTopicService.findPager(filter).getReturnObj());
        filter.clear();
        model.put("blockList",platformBlockService.findList(filter).getReturnObj());

        return FORUMTOPIC_COMMUNITY_HOME;
    }

    /**
     * 论坛主题页面
     */
    @RequestMapping(value = "/community.html")
    public String community(ModelMap model, HttpServletRequest request) {

        QueryFilter filter = new QueryFilter(request);
        String belonged = request.getParameter("belonged");
        if (StringUtils.isNotBlank(request.getParameter("isOutSearch"))) {//判断是否板块外搜索
            filter.put("isOutSearch", "1");
            model.put("isOutSearch", "1");
        } else {
            filter.put("belonged", belonged);
            filter.put("isOutSearch", "0");
            model.put("isOutSearch", "0");
        }

        if (StringUtils.isBlank((String) request.getParameter("content"))) {
            model.put("content", "");
        } else {
            filter.put("content", request.getParameter("content"));
            model.put("content", request.getParameter("content"));
        }

        if(StringUtils.isNotBlank((String) request.getParameter("timeOrderV"))) {
            filter.put("timeOrder",request.getParameter("timeOrderV"));
            model.put("timeOrder",request.getParameter("timeOrderV"));
        }else {
            model.put("timeOrder","");
        }

        if(StringUtils.isNotBlank((String) request.getParameter("repTimeV"))) {
            filter.put("repTime",request.getParameter("repTimeV"));
            model.put("repTime",request.getParameter("repTimeV"));
        }else {
            model.put("timeOrder","");
        }

        List<String> list = forumTopicService.getIsApproval(filter);
        if (list.size() == 1 && "1".equals(list.get(0))) {
            filter.put("applyStatus", "1");
        }

        filter.setStatementKey("selectIndexList");
        model.put("title", filter.get("title"));
        model.put("pager", forumTopicService.findPager(filter).getReturnObj());
        model.put("labelList", forumTopicService.getAllLabel(filter));
        model.put("emailSend", request.getParameter("emailSend"));
        filter.clear();
        model.put("blockList",platformBlockService.findList(filter).getReturnObj());

        String toWhere = "";
        if (StringUtils.isNotBlank(belonged)) {
            model.put("belonged", belonged);
            filter.put("id",belonged);
            model.put("blockDesc",platformBlockService.findOne(filter).getReturnObj());
            return FORUMTOPIC_COMMUNITY;
        } else {
            return FORUMTOPIC_COMMUNITY_HOME;
        }


    }

    /**
     * 根据条件获取数据
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/communityList.html")
    public String getForumList(ModelMap model, HttpServletRequest request) {
        //获取当前登陆用户
        QueryFilter filter = new QueryFilter(request);
        String content = null;
        try {
            if(StringUtils.isNotBlank((String)request.getParameter("content"))) {
                content = URLDecoder.decode(request.getParameter("content"), "UTF-8");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        filter.put("content", content);
        String belonged = request.getParameter("belonged");
        filter.put("belonged", belonged);
        filter.setStatementKey("selectIndexList");
        List<String> list = forumTopicService.getIsApproval(filter);
        if (list.size() == 1 && "1".equals(list.get(0))) {
            filter.put("applyStatus", "1");
        }
        filter.put("timeOrder", request.getParameter("timeOrder"));
        filter.put("repTime", request.getParameter("repTime"));
        filter.put("label", request.getParameter("label"));

        model.put("belonged", belonged);
        model.put("timeOrder",request.getParameter("timeOrder"));
        model.put("repTime",request.getParameter("repTime"));
        model.put("title", filter.get("title"));
        model.put("pager", forumTopicService.findPager(filter).getReturnObj());
        filter.clear();
        model.put("blockList",platformBlockService.findList(filter).getReturnObj());
        return "forumtopic/communityList";
    }

    /**
     * 获取论坛详情
     */
    @RequestMapping(value = "/communitydetail.html")
    public String communitydetail(ModelMap model, ForumTopicVo forumTopicParam) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        String ip = (String) AppContextHolder.getSession().getAttribute("userIP");
//        if (qcodeUser != null) {
//            forumTopicParam.setUserId(qcodeUser.getId());
//
//        } else {
//            forumTopicVo = new ForumTopicVo();
//        }

        QueryFilter filter = new QueryFilter();
        List<String> list = forumTopicService.getIsApproval(filter);
        if (list.size() == 1 && "1".equals(list.get(0))) {
            forumTopicParam.setApplyStatus("1");
        }

        if (qcodeUser != null) {
            forumTopicParam.setUserId(qcodeUser.getId());
        }
        ForumTopicVo forumTopicVo = forumTopicService.getCommunityById(forumTopicParam, ip);
        model.put("blockList",platformBlockService.findList(filter).getReturnObj());
        model.put("forumTopicVo", forumTopicVo);
        return FORUMTOPIC_COMMUNITYDETAIL;
    }


    /**
     * 论坛写文章
     */
    @RequestMapping("/communityPublish.html")
    public String communityPublish(Model model, HttpServletRequest request) {
        model.addAttribute("blockList",platformBlockService.findList(new QueryFilter()).getReturnObj());
        model.addAttribute("belonged", request.getParameter("belonged"));
        model.addAttribute("labelList", forumTopicService.getAllLabel(new QueryFilter()));
        model.addAttribute("labelCount", forumTopicService.getAllLabelNoFlag(new QueryFilter()));
        return "forumtopic/communitypublish";
    }

    /**
     * 论坛反馈建议
     */
    @RequestMapping("/communityFeedback.html")
    public String communityFeedback(Model model) {
        return "forumtopic/feedback";
    }

    /**
     * 分页查询评论
     */
    @RequestMapping(value = "/getReply.json")
    @ResponseBody
    public Pagination getReply(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        if (qcodeUser != null) {
            filter.put("userId", qcodeUser.getId());
        }
        filter.setLimit(6);
        filter.setStatementKey("findReplyList");
        return forumTopicService.findPager(filter).getReturnObj();
    }

    /**
     * 分页查询父级评论
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getParentReply.json")
    @ResponseBody
    public Pagination getParentReply(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.setLimit(6);
        return forumTopicService.getParentReply(filter);
    }

    /**
     * 添加论坛
     */
    @RequestMapping(value = "/addForumTopic.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData addForumTopic(ForumTopicVo forumTopicVo, String[] labels, String[] myLabels, MultipartFile multipartFile) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            //发帖人id
            forumTopicVo.setUserId(userInfor.getId());
            forumTopicVo.setReplyCount("0");
            if (multipartFile != null) {
                String realPath = FileUploadUtils.uploadPic(multipartFile);
                forumTopicVo.setTopicFace(realPath);
            }
            try {
                Set<String> set = sensitiveWordService.getSensitiveWordList(new QueryFilter());
                SensitiveWordUtil sensitiveWordUtil = new SensitiveWordUtil(set);
                forumTopicVo.setContent(sensitiveWordUtil.replaceSensitiveWord(forumTopicVo.getContent(), "*"));
                forumTopicVo.setTitle(sensitiveWordUtil.replaceSensitiveWord(forumTopicVo.getTitle(), "*"));
                //添加论坛
                forumTopicService.save(forumTopicVo);
                if (labels != null && labels.length > 0) {
                    Long forumTopicId = Long.valueOf(forumTopicService.getMaxForumId());
                    List<ForumLableVo> lableVoList = new ArrayList<>();//固定标签集合
                    List myLabelList = new ArrayList();//自定义标签集合
                    for (int i = 0; i < labels.length; i++) {
                        ForumLableVo forumLableVo = new ForumLableVo();
                        forumLableVo.setForumTopicId(forumTopicId);
                        forumLableVo.setLabel(labels[i]);
                        lableVoList.add(forumLableVo);
                    }

                    if (myLabels.length > 0) {
                        for (int i = 0; i < myLabels.length; i++) {
                            myLabelList.add(myLabels[i]);
                        }

                        QueryFilter filter = new QueryFilter();
                        int count = forumTopicService.getMaxDicContent(filter);//获得最大标签字典数
                        filter.put("myLabelList", myLabelList);
                        filter.put("userId", userInfor.getId());
                        filter.put("maxCount", count);
                        forumTopicService.insertLable(filter);//插入字典表
                    }
                    //保存标签
                    forumTopicService.saveLable(lableVoList);
                }

                EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
                if(eduStatisticsVo != null) {
                    eduStatisticsVo.setPublishForumCount(eduStatisticsVo.getPublishForumCount()+1);
                    eduStatisticsService.update(eduStatisticsVo);
                }else {
                    QueryFilter filter = new QueryFilter();
                    filter.put("publishForumCount",1);
                    filter.setStatementKey("addEduStatistics1");
                    eduStatisticsService.save(filter);
                }

                return ResponseData.SUCCESS_NO_DATA;
            } catch (Exception e) {
                e.printStackTrace();
                return ResponseData.FAILED_NO_DATA;
            }
        } else {
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 添加论坛回复
     */
    @RequestMapping(value = "/addForumReply.json")
    @ResponseBody
    public ResponseData addForumReply(ForumReplyVo forumReplyVo, Long forumUserId) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            //回复人id
            forumReplyVo.setUserId(userInfor.getId());
            //回复人name
            forumReplyVo.setUserName(userInfor.getName());
            //添加论坛回复
            Set<String> set = sensitiveWordService.getSensitiveWordList(new QueryFilter());
            SensitiveWordUtil sensitiveWordUtil = new SensitiveWordUtil(set);
            forumReplyVo.setContent(sensitiveWordUtil.replaceSensitiveWord(forumReplyVo.getContent(),"*"));
            forumTopicService.addForumReply(forumReplyVo);
            if (StringUtils.isBlank(forumReplyVo.getpIds())) {
                QueryFilter filter = new QueryFilter();
                filter.put("userId", forumUserId);
                filter.put("opType", "3");
                forumTopicService.addNotOnlineData(filter);
            }
            return ResponseData.SUCCESS_NO_DATA;
        } else {
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 论坛回复赞、踩一下
     */
    @RequestMapping(value = "/updReplyLike.json")
    @ResponseBody
    public ResponseData updateReply(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put("userId", userInfor.getId());
            //修改回复
            forumTopicService.updReplyLike(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }

    /**
     * 论坛主题赞、踩一下
     */
    @RequestMapping(value = "/updForumTopicLike.json")
    @ResponseBody
    public ResponseData updForumTopic(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put("userId", userInfor.getId());
            //修改论坛主题
            forumTopicService.updForumTopicLike(filter);
            if ("1".equals(filter.get("approvalCount"))) {
                filter.put("opType", "4");
                filter.put("userId", request.getParameter("forumUserId"));
                forumTopicService.addNotOnlineData(filter);
            }
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }

    /**
     * 论坛收藏（0：未收藏，1：已收藏）
     */
    @RequestMapping(value = "/updCollect.json")
    @ResponseBody
    public ResponseData updCollect(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put("userId", userInfor.getId());
            //修改论坛主题
            forumTopicService.updCollect(filter);
            if ("1".equals(request.getParameter("isCollect"))) {
                filter.put("opType", "2");
                filter.put("userId", request.getParameter("forumUserId"));
                forumTopicService.addNotOnlineData(filter);
            }
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }

    /**
     * 删除回复
     */
    @RequestMapping(value = "/delReply.json")
    @ResponseBody
    public ResponseData delReply(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put("userId", userInfor.getId());
            //删除回复
            forumTopicService.delReply(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }


    /**
     * 关注/取消关注
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/focusForum.json")
    @ResponseBody
    public ResponseData focusForum(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.put("focusId", userInfor.getId());//关注人id
        try {
            forumTopicService.addOrDelFocus(queryFilter);
            if ("1".equals(queryFilter.get("flag"))) {
                queryFilter.put("opType", "1");
                queryFilter.setStatementKey("addFocus");
                forumTopicService.addNotOnlineData(queryFilter);
            }
            return ResponseData.SUCCESS_NO_DATA;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 查询我的帖子/我的回复
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/myForum.html")
    public String getMyFocusIndex(Model model, HttpServletRequest request) {
        QueryFilter queryFilter = new QueryFilter(request);
        if ("1".equals(queryFilter.get("type")) || StringUtils.isBlank((String) queryFilter.get("type"))) {//我的帖子
            queryFilter.setStatementKey("getMyForum");
        } else {
            queryFilter.setStatementKey("getMyReplyForum");
        }
        model.addAttribute("pager", forumTopicService.findPager(queryFilter).getReturnObj());
        model.addAttribute("type", queryFilter.get("type"));
        return "forum/myForumOrReply";
    }

    /**
     * 查询我的收藏
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/myCollect.html")
    public String queryCollect(Model model, HttpServletRequest request) {
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.setStatementKey("queryCollect");
        model.addAttribute("pager", forumTopicService.findPager(queryFilter).getReturnObj());
        return "forum/myCollection";
    }

    /**
     * 分享统计
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/sharStatistics.json")
    @ResponseBody
    public ResponseData sharStatistics(HttpServletRequest request) {
        QueryFilter queryFilter = new QueryFilter(request);
        try {
            forumTopicService.sharStatistics(queryFilter);
            return ResponseData.SUCCESS_NO_DATA;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 查询论坛右边个人信息
     *
     * @param forumUserId
     * @return
     */
    @RequestMapping("/queryUser.json")
    @ResponseBody
    public Map queryForumUser(Long forumUserId) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        if (userInfor != null) {
            filter.put("userId", userInfor.getId());
        }
        filter.put("forumUserId", forumUserId);
        return forumTopicService.queryUser(filter);
    }

    /**
     * 查询谁点赞，收藏了我的哪些帖子
     *
     * @param model
     * @return
     */
    @RequestMapping("/queryMyCollect.html")
    public String queryMyCollect(Model model, HttpServletRequest request) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", userInfor.getId());
        forumTopicService.delNoticMessage(filter);
        String url = "";
        if ("1".equals(request.getParameter("type"))) {//收藏
            filter.setStatementKey("queryCollectForum");
        } else {
            filter.setStatementKey("queryLikeForum");
        }
        model.addAttribute("pager", forumTopicService.findPager(filter).getReturnObj());
        model.addAttribute("type", request.getParameter("type"));
        return "forum/noticeCollect";
    }

    /**
     * 查询通知我的评论
     *
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/queryMyForumReply.html")
    public String queryMyForumReply(Model model, HttpServletRequest request) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", userInfor.getId());
        forumTopicService.delNoticMessage(filter);
        filter.setStatementKey("queryLevelOneReply");
        model.addAttribute("pager", forumTopicService.findPager(filter).getReturnObj());
        return "forum/myForumReply";
    }

    /**
     * 查询关注情况
     *
     * @param
     * @return
     */
    @RequestMapping("/forumFocus.html")
    public String getFocusIndex(Model model, HttpServletRequest request) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", userInfor.getId());
        if (StringUtils.isNotBlank(request.getParameter("opType"))) {
            forumTopicService.delNoticMessage(filter);
        }
        filter.setStatementKey("getFocusUserDetails");
        model.addAttribute("pager", forumTopicService.findPager(filter).getReturnObj());
        model.addAttribute("type", request.getParameter("type"));
        return "forum/focusDetail";
    }

    /**
     * 达人热帖
     *
     * @param model
     * @return
     */
    @RequestMapping("/queryHot.html")
    public String queryHotForum(Model model) {
        QueryFilter filter = new QueryFilter();
        model.addAttribute("hotList", forumTopicService.queryHot(filter));
        return "forumtopic/hotForum";
    }

    /**
     * 举报帖子和评论
     */
    @RequestMapping(value = "/reportTopicReply.json")
    @ResponseBody
    public ResponseData reportTopicReply(HttpServletRequest request) {
        //获取登录信息
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", userInfor.getId());
        try {
            forumTopicService.reportTopicReply(filter);
            return ResponseData.SUCCESS_NO_DATA;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 反馈建议
     *
     * @param request
     * @param files
     * @return
     */
    @RequestMapping("/feedback.json")
    @ResponseBody
    public ResponseData feed(HttpServletRequest request, @RequestParam("files") MultipartFile[] files) {
        QueryFilter filter = new QueryFilter(request);
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        filter.put("userId", qcodeUser.getId());
        int successCount = forumTopicService.saveFeedback(filter, files);
        if (successCount == 1) {
            return ResponseData.SUCCESS_NO_DATA;
        } else {
            return ResponseData.FAILED_NO_DATA;
        }
    }


    @RequestMapping("/upload.json")
    @ResponseBody
    public String upload(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        Iterator<String> iter = multiRequest.getFileNames();
        // 获取multiRequest 中所有的文件名.

        String filePath = "";
        while (iter.hasNext()) {
            // 适配名字重复的文件
            try {
                List<MultipartFile> fileRows = multiRequest.getFiles(iter.next().toString());
                if (fileRows != null && fileRows.size() != 0) {
                    for (MultipartFile file : fileRows) {
                        if (file != null && !file.isEmpty()) {
                            String fileName = file.getOriginalFilename();
                            String ext = fileName.substring(fileName.indexOf("."), fileName.length());
                            filePath = AppContextHolder.getFileSavePath() + "headFile" + "/" + qcodeUser.getId() + DateUtils.formatDatetime(new Date(), DateUtils.DateStyle.YYYYMMDDHHMMSSSSS) + ext;
                            InputStream in = file.getInputStream();
                            FileOutputStream fileOutputStream = new FileOutputStream(filePath);
                            byte buffer[] = new byte[1024];
                            //判断输入流中的数据是否已经读完的标识
                            int len = 0;
                            //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                            while ((len = in.read(buffer)) > 0) {
                                //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                                fileOutputStream.write(buffer, 0, len);
                            }
                            in.close();
                            fileOutputStream.close();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                logger.error(e.getMessage());
                return "{'errno':1,'data':[localhost:8080/files/" + filePath + "]}";
            }

        }
        if (("//" + filePath).contains(AppContextHolder.getFileSavePath())) {
            filePath = ("//" + filePath).substring(AppContextHolder.getFileSavePath().length() + 1);
        }

        int firstIndex = filePath.indexOf("/");
        filePath = filePath.substring(firstIndex + 1);
        return "{\"errno\":0,\"data\":[\"" + filePath + "\"]}";
    }

    /**
     * 获得不在线时记录
     *
     * @param userId
     * @return
     */
    @RequestMapping("/getAllNotic.json")
    @ResponseBody
    public int getAllNotic(Long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId", userId);
        int count = forumTopicService.getNotOnlineCount(filter);
        return count;
    }

    /**
     * 置顶
     *
     * @param request
     * @return
     */
    @RequestMapping("/setTop.json")
    @ResponseBody
    public ResponseData setTop(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, "没有权限！");
        } else {
            try {
                QueryFilter filter = new QueryFilter(request);
                filter.put("topLevel", "2");
                forumTopicService.setTop(filter);
            } catch (Exception e) {
                e.printStackTrace();
                e.getMessage();
                return ResponseData.FAILED_NO_DATA;
            }
            return ResponseData.SUCCESS_NO_DATA;
        }
    }

    /**
     * 删除帖子
     *
     * @param request
     * @return
     */
    @RequestMapping("/delForum.json")
    @ResponseBody
    public ResponseData delForum(HttpServletRequest request) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        if (user == null) {
            return new ResponseData(false, "无权限操作");
        }
        QueryFilter filter = new QueryFilter(request);
        try {
            forumTopicService.delForum(filter);
        } catch (Exception e) {
            return new ResponseData(false, "删除出错");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 添加自定义标签
     *
     * @param request
     * @return
     */
    @RequestMapping("/insertLabel.json")
    @ResponseBody
    public ResponseData insertLabel(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, "无权限操作");
        }
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", qcodeUser.getId());
        Map<String, Object> map = forumTopicService.haseDicContent(filter);
        if (Integer.parseInt(map.get("hascount").toString()) > 0 && "1".equals(map.get("deflag"))) {
            return new ResponseData(false, "已有此标签");
        } else if (Integer.parseInt(map.get("hascount").toString()) > 0 && "0".equals(map.get("deflag"))) {
            return new ResponseData(false, "标签正在审核");
        }
        int dicCount = forumTopicService.dicContentCount(filter);
        if (dicCount > 4) {
            return new ResponseData(false, "每人最多添加5个标签！");
        } else {
            return new ResponseData(true, dicCount);
        }
    }


    @RequestMapping("/sendForumEmail.json")
    @ResponseBody
    public void sendForumEmail() throws MessagingException, IOException, TemplateException, InterruptedException {
        while (true) {
            List<String> noAuditForum = forumTopicService.noAuditForum();//论坛未审核帖子
            List<ForumTopicVo> noAuditReplyList = forumTopicService.noAuditReply(new QueryFilter());
            if (CollectionUtils.isEmpty(noAuditForum) && CollectionUtils.isEmpty(noAuditReplyList)) {
                break;
            }
            if (!isWeek()) {
                break;
            }
            QcodePushVo qcodePushVo = new QcodePushVo();
            int noAuditReplyCount = 0;
            String content = "帖子：";
            for (int i = 0; i < noAuditForum.size(); i++) {
                content += noAuditForum.get(i).toString() + "," + "\n";
            }

            content += "未审核回复所对应的帖子：";
            for (int i = 0; i < noAuditReplyList.size(); i++) {
                content += noAuditReplyList.get(i).getTitle() + "(" + noAuditReplyList.get(i).getNoApplyCount() + "条未审核回复)," + "\n";
                noAuditReplyCount += noAuditReplyList.get(i).getNoApplyCount();
            }

            content += "(未审核)。";
            String title = "您有" + noAuditForum.size() + "个帖子" + noAuditReplyCount + "回复未审核";
            qcodePushVo.setContent(content);
            qcodePushVo.setTitle(title);
            String[] email = {"oqc@originqc.com"};
            templateEmail.sendPushMail(qcodePushVo, email);
            Thread.sleep(600000);
        }
    }


    /**
     * 的判断当前时间是否为工作日
     *
     * @return
     */
    private boolean isWeek() {
        Calendar calendar = new GregorianCalendar();
        int week = calendar.get(Calendar.DAY_OF_WEEK);
        int h = calendar.get(Calendar.HOUR);
        int m = calendar.get(Calendar.MINUTE);
        String time = h + ":" + m;
        if (week == 1 || week == 7) {//周六日
            return false;
        }

        SimpleDateFormat df = new SimpleDateFormat("HH:mm");//设置日期格式
        Date now = null;
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
        if (!flag) {
            return false;
        }
        return true;
    }

    /**
     * 判断时间是否在某一时间段
     *
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
     * 查询列表接口(不分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/forumTopicList.json")
    @ResponseBody
    public ResponseData getForumTopicList(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);
        Map map = getParams(request);
        String belonged = map.get("belonged").toString();
        if (StringUtils.isNotBlank(map.get("isOutSearch").toString())) {//判断是否板块外搜索
            filter.put("isOutSearch", "1");
        } else {
            if (StringUtils.isBlank(belonged)) {
                belonged = "1";
            }
            filter.put("belonged", belonged);
            filter.put("isOutSearch", "0");
        }
        filter.setStatementKey("selectIndexList");
        filter.put("applyStatus", "1");

        List<ForumTopicVo> list = null;
        ResponseData responseData = null;

        try {
            list = forumTopicService.findList(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }


    /**
     * 查询列表接口(分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/forumTopicListPage.json")
    @ResponseBody
    public ResponseData getForumTopicListPage(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("selectIndexList");
        filter.put("applyStatus", "1");

        Pagination pagination = null;
        ResponseData responseData = null;

        try {
            pagination = forumTopicService.findPager(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(pagination);
        return responseData;
    }

    /**
     * 查询详情接口
     *
     * @param forumTopicParam
     * @return
     */
    @RequestMapping("/api/forumDetailsById.json")
    @ResponseBody
    public ResponseData getForumDetails(ForumTopicVo forumTopicParam, HttpServletRequest request) throws Exception {
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        String ip = (String) AppContextHolder.getSession().getAttribute("userIP");
        if (userId != null) {
            forumTopicParam.setUserId(Long.parseLong(userId));
        }
        ResponseData responseData = null;
        ForumTopicVo forumTopicVo = null;
        try {
            forumTopicVo = forumTopicService.getCommunityById(forumTopicParam, ip);
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(forumTopicVo);
        return responseData;
    }


    /**
     * 查询我的帖子/我的回复(不分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/myForum.json")
    public ResponseData getMyFocus(HttpServletRequest request) throws Exception {
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        QueryFilter queryFilter = new QueryFilter(request);
        if ("1".equals(queryFilter.get("type")) || StringUtils.isBlank((String) queryFilter.get("type"))) {//我的帖子
            queryFilter.setStatementKey("getMyForum");
        } else {
            queryFilter.setStatementKey("getMyReplyForum");
        }
        ResponseData responseData = null;
        List<ForumTopicVo> list = null;
        try {
            list = forumTopicService.findList(queryFilter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }
        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }

    /**
     * 查询我的帖子/我的回复(分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/myForumPage.json")
    public ResponseData getMyFocusPage(HttpServletRequest request) throws Exception {
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        QueryFilter queryFilter = new QueryFilter(request);
        if ("1".equals(queryFilter.get("type")) || StringUtils.isBlank((String) queryFilter.get("type"))) {//我的帖子
            queryFilter.setStatementKey("getMyForum");
        } else {
            queryFilter.setStatementKey("getMyReplyForum");
        }
        ResponseData responseData = null;
        Pagination pagination = null;
        try {
            pagination = forumTopicService.findPager(queryFilter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }
        responseData = new ResponseData(true, "");
        responseData.setObj(pagination);
        return responseData;
    }


    /**
     * 查询关注情况(不分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/forumFocus.json")
    @ResponseBody
    public ResponseData getMyFocusDetail(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        ResponseData responseData = null;
        List<FocusUserVo> list = null;
        if (StringUtils.isNotBlank(map.get("opType").toString())) {
            forumTopicService.delNoticMessage(filter);
        }

        try {
            filter.setStatementKey("getFocusUserDetails");
            list = forumTopicService.findList(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }

    /**
     * 查询关注情况(分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/forumFocusPage.json")
    @ResponseBody
    public ResponseData getMyFocusDetailPage(HttpServletRequest request) throws Exception {
        QueryFilter filter = new QueryFilter(request);
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        ResponseData responseData = null;
        Pagination list = null;
        if (StringUtils.isNotBlank(map.get("opType").toString())) {
            forumTopicService.delNoticMessage(filter);
        }

        try {
            filter.setStatementKey("getFocusUserDetails");
            list = forumTopicService.findPager(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }


    /**
     * 查询我的收藏(不分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/myCollect.json")
    @ResponseBody
    public ResponseData getMyCollect(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.setStatementKey("queryCollect");
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }

        ResponseData responseData = null;
        List<Map> list = null;

        try {
            list = forumTopicService.findList(queryFilter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }

    /**
     * 查询我的收藏(分页)
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/myCollectPage.json")
    @ResponseBody
    public ResponseData getMyCollectPage(HttpServletRequest request) throws Exception {
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.setStatementKey("queryCollect");
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }

        ResponseData responseData = null;
        Pagination list = null;

        try {
            list = forumTopicService.findPager(queryFilter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }


    /**
     * 达人热帖
     *
     * @param
     * @return
     */
    @RequestMapping("/api/queryHot.json")
    @ResponseBody
    public ResponseData getHotForumList() {
        QueryFilter filter = new QueryFilter();
        List<ForumTopicVo> list = null;
        ResponseData responseData = null;

        try {
            list = forumTopicService.queryHot(filter);
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }


    /**
     * 查询谁点赞，收藏了我的哪些帖子
     *
     * @param
     * @return
     */
    @RequestMapping("/api/queryMyCollect.json")
    @ResponseBody
    public ResponseData queryMyCollect(HttpServletRequest request) throws Exception {
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", Long.parseLong(userId));
        forumTopicService.delNoticMessage(filter);
        String url = "";
        if ("1".equals(map.get("type").toString())) {//收藏
            filter.setStatementKey("queryCollectForum");
        } else {
            filter.setStatementKey("queryLikeForum");
        }

        List<ForumTopicVo> list = null;
        ResponseData responseData = null;

        try {
            list = forumTopicService.findList(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }


    /**
     * 查询通知我的评论
     *
     * @param request
     * @return
     */
    @RequestMapping("/api/queryMyForumReply.json")
    public ResponseData queryMyForumReply(HttpServletRequest request) throws Exception {
        Map map = getParams(request);
        String userId = map.get("userId").toString();
        if (StringUtils.isBlank(userId)) {
            return new ResponseData(false, "缺少必要参数");
        }
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", Long.parseLong(userId));
        forumTopicService.delNoticMessage(filter);
        filter.setStatementKey("queryLevelOneReply");

        List<ForumReplyVo> list = null;
        ResponseData responseData = null;

        try {
            list = forumTopicService.findList(filter).getReturnObj();
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }

        responseData = new ResponseData(true, "");
        responseData.setObj(list);
        return responseData;
    }

    /**
     * 查询精品论坛
     *
     * @param request
     * @return obj={forum_topic_id,content,title,user_id,face,lasttime}
     */
    @RequestMapping("/api/queryQualityForumTopic.json")
    public ResponseData queryQualityForum(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        forumTopicService.delNoticMessage(filter);
        filter.setStatementKey("qualityforumtopic");
        //查询人数最多的五条评论的id
        Object obj = new Object();
        List<Map> list = null;
        list = forumTopicService.findList(filter).getReturnObj();
        for (int i = 0; i < list.size(); i++) {
            String facepath = (String) list.get(i).get("face");
            if (facepath == "" || facepath == null) {
                facepath = "https://qcode.qpanda.cn" + "/assets/forImg/Head.png";
                list.get(i).put("face", facepath);
                System.out.println(facepath);
            } else {
                facepath = "https://qcode.qpanda.cn/" + facepath;
                list.get(i).put("face", facepath);
                System.out.println(facepath + "else");
            }

        }
        ResponseData responseData = null;
        try {
            obj = list;
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }
        responseData = new ResponseData(true, "");
        responseData.setObj(obj);
        return responseData;
    }


    /**
     * 查询推荐自选
     *
     * @param request
     * @return obj={forum_topic_id,content,title,user_id,face,lasttime}
     */
    @RequestMapping("/api/recommendedNews.json")
    public ResponseData recommendedNews(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        forumTopicService.delNoticMessage(filter);
        filter.setStatementKey("recommendnews");
        //查询人数最多的五条评论的id
        Object obj = new Object();
        List<Map> list = null;
        list = forumTopicService.findList(filter).getReturnObj();
        for (int i = 0; i < list.size(); i++) {
            String facepath = (String) list.get(i).get("topicFace");
            if (facepath == "" || facepath == null) {
                facepath = "";
                list.get(i).put("face", facepath);
                System.out.println(facepath);
            } else {
                facepath = "https://qcode.qpanda.cn/" + facepath;
                list.get(i).put("topicFace", facepath);
                System.out.println(facepath + "else");
            }
        }
        ResponseData responseData = null;
        try {
            obj = list;
        } catch (Exception e) {
            responseData = new ResponseData(false, "获取失败");
            e.printStackTrace();
            return responseData;
        }
        responseData = new ResponseData(true, "");
        responseData.setObj(obj);
        return responseData;
    }


    /**
     * 获取http请求参数
     *
     * @since 2018-1-9
     */
    private Map getParams(HttpServletRequest request) throws Exception {
        Enumeration<String> parameterNames = request.getParameterNames();
        Map map = null;
        if (parameterNames.hasMoreElements()) {//Content-Type:application/x-www-form-urlencoded
            map = new HashMap<String, Object>();
            while (parameterNames.hasMoreElements()) {
                String parameterName = (String) parameterNames.nextElement();
                map.put(parameterName, request.getParameter(parameterName));
            }
            return map;
        }

        StringBuilder sb = new StringBuilder();// 非Content-Type:application/x-www-form-urlencoded的处理
        InputStream is = getRequest().getInputStream();
        BufferedInputStream bis = new BufferedInputStream(is);
        byte[] buffer = new byte[1024];
        int read = 0;
        while ((read = bis.read(buffer)) != -1) {
            sb.append(new String(buffer, 0, read, "UTF-8"));
        }

        if (sb != null && !"".equals(sb + "")) {
            try {
                map = JSONObject.parseObject(sb.toString(), Map.class);
            } catch (com.alibaba.fastjson.JSONException e) { //在异常中对taskTyp=xxx&qprog=xxxx&typ=xxx&repeat=xxx&token=xxxx这种数据的处理
                String sbStr = URLDecoder.decode(sb.toString());
                StringBuffer sbStringBuffer = new StringBuffer();
                sbStringBuffer.append("{\"")
                        .append(sbStr.toString().trim().replaceAll("&", "\",\"").replaceAll("=", "\":\""))
                        .append("\"}");
                map = JSONObject.parseObject(sbStringBuffer.toString(), Map.class);
            }
        }
        return map;
    }

}
