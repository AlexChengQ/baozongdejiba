package com.bylz.quantumCloud.education.controller;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.TutorialReviewService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
@Controller
@RequestMapping("/EduTutorial")
public class TutorialReviewController {
    @Autowired
    public TutorialReviewService tutorialReviewService;


    /**
     * 添加教程回复
     */
    @RequestMapping(value = "/addEduTutorialReply.json")
    @ResponseBody
    public ResponseData addForumReply(TutorialReviewVo forumReplyVo) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        if (userInfor != null) {
            //回复人id
            forumReplyVo.setUserId(userInfor.getId());
            //回复人name
            forumReplyVo.setUserName(userInfor.getName());
            //添加论坛回复
            tutorialReviewService.addForumReply(forumReplyVo);
            return ResponseData.SUCCESS_NO_DATA;
        } else {
            return ResponseData.FAILED_NO_DATA;
        }
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
        if(qcodeUser != null) {
            filter.put("userId",qcodeUser.getId());
        }
        filter.setLimit(6);
        filter.setStatementKey("findReplyList");
        return tutorialReviewService.findPager(filter).getReturnObj();
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
        return tutorialReviewService.getParentReply(filter);
    }


     /**
     * 我的回答和评论
     * @return
     */
    @RequestMapping("/askAndanswer.json")
    @ResponseBody
    public List<TutorialReviewVo> askAndanswer(String flag) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        return tutorialReviewService.askAndanswer(qcodeUser.getId(),flag);
    }


    /**
     * 修改观看次数并返回观看次数
     * @param videoId
     * @return
     */
    @RequestMapping("/updReadCount.json")
    @ResponseBody
    public VideoInfoVo updReadCount(long videoId) {
        VideoInfoVo videoInfoVo = tutorialReviewService.addReadCount(videoId);
        return videoInfoVo;
    }


    /**
     * 根据id获取回复所在页码
     * @param replyId
     * @param videoId
     * @return
     */
    @RequestMapping("/getPagerNumById.json")
    @ResponseBody
    public int getPagerNumById(String replyId,String videoId) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        filter.put("userId",user.getId());
        filter.put("videoId",videoId);
        filter.put("id",replyId);
        int replyPagerNum = tutorialReviewService.getPagerNumById(filter);
        int pagNum = 0;
        if(replyPagerNum % 6 == 0) {
            pagNum = replyPagerNum / 6;
        }else {
            pagNum = (replyPagerNum / 6) + 1;
        }
        return pagNum;
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
        int successCount = tutorialReviewService.saveFeedback(filter,files);
        if(successCount == 1) {
            return ResponseData.SUCCESS_NO_DATA;
        }else {
            return ResponseData.FAILED_NO_DATA;
        }
    }


    /**
     * 收藏
     * @param request
     * @return
     */
    @RequestMapping("/collect.json")
    @ResponseBody
    public ResponseData updCollect(HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId",qcodeUser.getId());
        try {
            tutorialReviewService.saveCollect(filter);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }

        return ResponseData.SUCCESS_NO_DATA;
    }


    /**
     * 获取我的收藏
     * @return
     */
    @RequestMapping("/getCollect.json")
    @ResponseBody
    public ResponseData getCollect() {
        QcodeUser user = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(user);
        filter.put("userId",user.getId());
        List<CollectVo> collectVoList = tutorialReviewService.collectList(filter);
        for(CollectVo collectVo : collectVoList) {
            int videoId = collectVo.getVideoId();
            UserVideo userVideo = tutorialReviewService.getUserVideo(filter);
            filter.put("videoId",videoId);
            UserExam userExam = tutorialReviewService.getUserExam(filter);
            if(userVideo == null) {
                collectVo.setIsComplete(0);
            }else if(userExam == null) {
                collectVo.setIsComplete(0);
                collectVo.setLastStdTime(userExam.getDatetime());
            } else {
                collectVo.setLastStdTime(userExam.getDatetime());
                String status = userExam.getStatus();
                int allQuestion = status.lastIndexOf("|")+1;//共有多少题目
                String[] allAnswer = status.split("|");
                if(allAnswer.length != allQuestion) {
                    collectVo.setIsComplete(0);
                }else {
                    int flag = 1;
                    for(int i = 0;i < allAnswer.length;i++) {
                        if("0".equals(allAnswer[i])) {
                            flag = 0;
                            break;
                        }
                    }

                    if(flag == 0) {
                        collectVo.setIsComplete(0);
                    }else {
                        collectVo.setIsComplete(1);
                    }
                }
            }
        }

        ResponseData responseData = new ResponseData(true);
        responseData.setObj(collectVoList);
        return responseData;
    }


    /**
     * 兑换证书
     * @param request
     * @return
     */
    @RequestMapping("/myCertificate.json")
    @ResponseBody
    public ResponseData convertCertificate(HttpServletRequest request) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        if(user == null) {
            return ResponseData.FAILED_NO_DATA;
        }

        if(StringUtils.isBlank(request.getParameter("certificateId"))) {
            return ResponseData.FAILED_NO_DATA;
        }

        filter.put("userId",user.getId());
        String canChangeCertificate = SettingUtil.getSetting("canChangeCertificate",String.class);
        String[] examIdArrays = canChangeCertificate.split(",");
        filter.setStatementKey("getEaxm");
        List<UserExam> list = tutorialReviewService.findList(filter).getReturnObj();

        try {
            int result = tutorialReviewService.saveCertificate(filter,examIdArrays,list);
            if(result == 0) {
                return ResponseData.FAILED_NO_DATA;
            }
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }

        return ResponseData.SUCCESS_NO_DATA;
    }


    /**
     * 收藏
     * @param request
     * @return
     */
    @RequestMapping("/api/collect.json")
    @ResponseBody
    public ResponseData updCollectApi(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        String token = request.getParameter("token") == null ? null : request.getParameter("token");

        if (token == null || "".equals(token)) {
            data.setSuccess(false);
            data.setMessage("key_is_not_null");
            return data;
        }

        QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);

        if(qcodeUser == null) {
            data.setSuccess(false);
            data.setMessage("parameter error");
            return data;
        }

        String userId = qcodeUser.getId().toString();
        if(StringUtils.isBlank(userId)) {
            return new ResponseData(false,"缺少必要参数");
        }


        QueryFilter filter = new QueryFilter(request);
        filter.put("userId",qcodeUser.getId());
        try {
            tutorialReviewService.saveCollect(filter);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }

        return ResponseData.SUCCESS_NO_DATA;
    }


    @RequestMapping("/deleteReply.json")
    @ResponseBody
    public ResponseData deleteReply(Long id) {
        ResponseData data = new ResponseData(true);
        try {
            tutorialReviewService.delete(id);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("删除失败");
            return data;
        }
    }


    @RequestMapping("/videoReplyLike.json")
    @ResponseBody
    public ResponseData videoReplyLike(HttpServletRequest request) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        ResponseData data = new ResponseData(true);
        if(user == null) {
            data.setSuccess(false);
            data.setMessage("没有权限");
            return data;
        }

        String replyId = request.getParameter("replyId") == null?null:request.getParameter("replyId").toString();
        String type = request.getParameter("type") == null?null:request.getParameter("type").toString();
        if(StringUtils.isBlank(replyId)) {
            data.setSuccess(false);
            data.setMessage("缺少参数");
            return data;
        }

        if(StringUtils.isBlank(type)) {
            data.setSuccess(false);
            data.setMessage("缺少参数");
            return data;
        }

        QueryFilter filter = new QueryFilter(request);
        filter.put("likesUserId",user.getId());
        try {
            if("1".equals(type)) {
                tutorialReviewService.save(filter);
                data.setMessage("点赞成功");
            }else {
                filter.setStatementKey("deleteLike");
                tutorialReviewService.delete(filter);
                data.setMessage("取消点赞成功");
            }

            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("点赞失败");
            return data;
        }

    }


    /**
     * 举报评论
     */
    @RequestMapping(value = "/reportTopicReply.json")
    @ResponseBody
    public ResponseData reportTopicReply(HttpServletRequest request) {
        //获取登录信息
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId", userInfor.getId());
        filter.put("catalog",2);
        try {
            tutorialReviewService.reportTopicReply(filter);
            return ResponseData.SUCCESS_NO_DATA;
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }

}
