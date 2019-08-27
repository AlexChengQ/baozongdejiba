/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.education.controller;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.DateUtils;
import com.bylz.quantumCloud.education.util.FileUploadUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
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
@RequestMapping("/qcode/forumtopic")
public class ForumTopicController extends BaseController {

    @Autowired
    public ForumTopicService forumTopicService;


    /**
     * 分页查询评论
     */
    @RequestMapping(value = "/getReply.json")
    @ResponseBody
    public ResponseData getReply(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        if(qcodeUser != null) {
            filter.put("userId",qcodeUser.getId());
        }
        filter.setLimit(6);
        filter.setStatementKey("findReplyList");
        return forumTopicService.findPager(filter).getReturnObj();
    }

    /**
     * 分页查询父级评论
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
    public ResponseData addForumTopic(ForumTopicVo forumTopicVo,String[]labels,String[]myLabels,MultipartFile multipartFile) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        forumTopicVo.setBelonged("1");
        if (userInfor != null) {
            //发帖人id
            forumTopicVo.setUserId(userInfor.getId());
            forumTopicVo.setReplyCount("0");
            if(multipartFile != null) {
                String realPath = FileUploadUtils.uploadPic(userInfor,multipartFile);
                forumTopicVo.setTopicFace(realPath);
            }
            try {
                //添加论坛
                forumTopicService.save(forumTopicVo);
                if(labels != null && labels.length > 0) {
                    Long forumTopicId = Long.valueOf(forumTopicService.getMaxForumId());
                    List<ForumLableVo> lableVoList = new ArrayList<>();//固定标签集合
                    List myLabelList = new ArrayList();//自定义标签集合
                    for(int i = 0;i<labels.length;i++) {
                        ForumLableVo forumLableVo = new ForumLableVo();
                        forumLableVo.setForumTopicId(forumTopicId);
                        forumLableVo.setLabel(labels[i]);
                        lableVoList.add(forumLableVo);
                    }

                    if(myLabels.length > 0) {
                        for(int i = 0;i<myLabels.length;i++) {
                            myLabelList.add(myLabels[i]);
                        }

                        QueryFilter filter = new QueryFilter();
                        int count = forumTopicService.getMaxDicContent(filter);//获得最大标签字典数
                        filter.put("myLabelList",myLabelList);
                        filter.put("userId",userInfor.getId());
                        filter.put("maxCount",count);
                        forumTopicService.insertLable(filter);//插入字典表
                    }
                    //保存标签
                    forumTopicService.saveLable(lableVoList);
                }
                return ResponseData.SUCCESS_NO_DATA;
            }catch (Exception e) {
                e.printStackTrace();
                return ResponseData.FAILED_NO_DATA;
            }
        }else {
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 添加论坛回复
     */
    @RequestMapping(value = "/addForumReply.json")
    @ResponseBody
    public ResponseData addForumReply(ForumReplyVo forumReplyVo,Long forumUserId) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            //回复人id
            forumReplyVo.setUserId(userInfor.getId());
            //回复人name
            forumReplyVo.setUserName(userInfor.getName());
            //添加论坛回复
            forumTopicService.addForumReply(forumReplyVo);
            if(StringUtils.isNotBlank(forumReplyVo.getParentId())) {
                QueryFilter filter = new QueryFilter();
                filter.put("userId",forumUserId);
                filter.put("opType","3");
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
            filter.put("userId",userInfor.getId());
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
            filter.put("userId",userInfor.getId());
            //修改论坛主题
            forumTopicService.updForumTopicLike(filter);
            if("1".equals(filter.get("approvalCount"))) {
                filter.put("opType","4");
                filter.put("userId",request.getParameter("forumUserId"));
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
            filter.put("userId",userInfor.getId());
            //修改论坛主题
            forumTopicService.updCollect(filter);
            if("1".equals(request.getParameter("isCollect"))) {
                filter.put("opType","2");
                filter.put("userId",request.getParameter("forumUserId"));
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
            filter.put("userId",userInfor.getId());
            //删除回复
            forumTopicService.delReply(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }


    /**
     * 关注/取消关注
     * @param request
     * @return
     */
    @RequestMapping(value = "/focusForum.json")
    @ResponseBody
    public ResponseData focusForum(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter queryFilter = new QueryFilter(request);
        queryFilter.put("focusId",userInfor.getId());//关注人id
        try{
            forumTopicService.addOrDelFocus(queryFilter);
            if("1".equals(queryFilter.get("flag"))) {
                queryFilter.put("opType","1");
                queryFilter.setStatementKey("addFocus");
                forumTopicService.addNotOnlineData(queryFilter);
            }
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e){
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
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
     * @param forumUserId
     * @return
     */
    @RequestMapping("/queryUser.json")
    @ResponseBody
    public Map queryForumUser(Long forumUserId) {
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        if(userInfor != null) {
            filter.put("userId",userInfor.getId());
        }
        filter.put("forumUserId",forumUserId);
        return forumTopicService.queryUser(filter);
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
        filter.put("userId",userInfor.getId());
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
     * @param request
     * @param files
     * @return
     */
    @RequestMapping("/feedback.json")
    @ResponseBody
    public ResponseData feed(HttpServletRequest request, @RequestParam("files")MultipartFile[] files) {
        QueryFilter filter = new QueryFilter(request);
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        filter.put("userId",qcodeUser.getId());
        int successCount = forumTopicService.saveFeedback(filter,files);
        if(successCount == 1) {
            return ResponseData.SUCCESS_NO_DATA;
        }else {
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
                                filePath = AppContextHolder.getFileSavePath()+"headFile"+"/"+qcodeUser.getId()+ DateUtils.formatDatetime(new Date(), DateUtils.DateStyle.YYYYMMDDHHMMSSSSS)+ext;
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
                    return "{'errno':1,'data':[localhost:8080/files/"+filePath+"]}";
                }

        }
        if(("//" + filePath).contains(AppContextHolder.getFileSavePath())){
            filePath = ("//" + filePath).substring(AppContextHolder.getFileSavePath().length() + 1);
        }

        int firstIndex = filePath.indexOf("/");
        filePath = filePath.substring(firstIndex + 1);
       return "{\"errno\":0,\"data\":[\""+filePath+"\"]}";
    }

    /**
     * 获得不在线时记录
     * @param userId
     * @return
     */
    @RequestMapping("/getAllNotic.json")
    @ResponseBody
    public int getAllNotic(Long userId) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        int count = forumTopicService.getNotOnlineCount(filter);
        return count;
    }

    /**
     * 置顶
     * @param request
     * @return
     */
    @RequestMapping("/setTop.json")
    @ResponseBody
    public ResponseData setTop(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(qcodeUser == null) {
            return new ResponseData(false,"没有权限！");
        }else {
            try {
                QueryFilter filter = new QueryFilter(request);
                filter.put("topLevel","2");
                forumTopicService.setTop(filter);
            }catch (Exception e) {
                e.printStackTrace();
                e.getMessage();
                return ResponseData.FAILED_NO_DATA;
            }
            return ResponseData.SUCCESS_NO_DATA;
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
        QcodeUser user = AppContextHolder.getCurrentUser();
        if(user == null) {
            return new ResponseData(false,"无权限操作");
        }
        QueryFilter filter = new QueryFilter(request);
        try {
            forumTopicService.delForum(filter);
        }catch (Exception e) {
            return new ResponseData(false,"删除出错");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 添加自定义标签
     * @param request
     * @return
     */
    @RequestMapping("/insertLabel.json")
    @ResponseBody
    public ResponseData insertLabel(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(qcodeUser == null) {
            return new ResponseData(false,"无权限操作");
        }
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId",qcodeUser.getId());
        Map<String,Object> map = forumTopicService.haseDicContent(filter);
        if(Integer.parseInt(map.get("hascount").toString()) > 0 && "1".equals(map.get("deflag"))) {
            return new ResponseData(false,"已有此标签");
        }else if(Integer.parseInt(map.get("hascount").toString()) > 0 && "0".equals(map.get("deflag"))) {
            return new ResponseData(false,"标签正在审核");
        }
        int dicCount = forumTopicService.dicContentCount(filter);
        if(dicCount > 4) {
            return new ResponseData(false,"每人最多添加5个标签！");
        }else {
            return new ResponseData(true,dicCount);
        }
    }


//    @RequestMapping("/sendForumEmail.json")
//    @ResponseBody
//    public void sendForumEmail() throws MessagingException, IOException, TemplateException, InterruptedException {
//        while (true) {
//            List<String> noAuditForum = forumTopicService.noAuditForum();//论坛未审核帖子
//            List<ForumTopicVo> noAuditReplyList = forumTopicService.noAuditReply(new QueryFilter());
//            if(CollectionUtils.isEmpty(noAuditForum) && CollectionUtils.isEmpty(noAuditReplyList)) {
//                break;
//            }
//            if(!isWeek()) {
//                break;
//            }
//            QcodePushVo qcodePushVo = new QcodePushVo();
//            int noAuditReplyCount = 0;
//            String content = "帖子：";
//            for (int i =0;i<noAuditForum.size();i++) {
//                content += noAuditForum.get(i).toString()+","+"\n";
//            }
//
//            content += "未审核回复所对应的帖子：";
//            for (int i=0;i<noAuditReplyList.size();i++) {
//                content += noAuditReplyList.get(i).getTitle()+"("+noAuditReplyList.get(i).getNoApplyCount()+"条未审核回复),"+"\n";
//                noAuditReplyCount +=noAuditReplyList.get(i).getNoApplyCount();
//            }
//
//            content +="(未审核)。";
//            String title = "您有"+noAuditForum.size()+"个帖子"+noAuditReplyCount+"回复未审核";
//            qcodePushVo.setContent(content);
//            qcodePushVo.setTitle(title);
//            String[] email = {"oqc@originqc.com"};
//            templateEmail.sendPushMail(qcodePushVo,email);
//            Thread.sleep(600000);
//        }
//    }


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

}
