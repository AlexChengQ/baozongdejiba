package com.bylz.quantumCloud.education.api;

import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.FileUploadUtils;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.education.util.JPushUtils;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.TutorialReviewService;
import com.bylz.quantumCloud.service.VideoInfoService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
@Controller
@RequestMapping("/api/Tutorial")
public class TutorialReviewApiController extends BaseController {

    @Autowired
    public TutorialReviewService tutorialReviewService;

    @Autowired
    private VideoInfoService videoInfoService;

    @Autowired
    private ForumTopicService forumTopicService;

    @Autowired
    private QcodeUserService qcodeuserservice;

    /**
     * 添加教程回复
     */
    @RequestMapping(value = "/addEduTutorialReply.json")
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


            if(map.get("content") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getEquipment");
            Map userMap = qcodeuserservice.findOne(filter).getReturnObj();
            filter.clear();
            LinkedList<String> linkedList = new LinkedList<String>();
            linkedList.add(userMap.get("equipmentId").toString());
            Map extraMap = new HashMap();
            String title = "";

            TutorialReviewVo forumReplyVo = new TutorialReviewVo();

            //回复人id
            forumReplyVo.setUserId(userInfor.getId());
            //回复人name
            forumReplyVo.setUserName(userInfor.getName());
            forumReplyVo.setForumTopicId(Long.parseLong(map.get("forumTopicId").toString()));
            forumReplyVo.setContent(map.get("content").toString());
            forumReplyVo.setParentId(map.get("parentId").toString());
            forumReplyVo.setpIds(map.get("pIds").toString());
            if(StringUtils.isNotBlank((String)map.get("repdUserId"))) {
                forumReplyVo.setRepdUserId((String)map.get("repdUserId"));
                extraMap.put("id",map.get("forumTopicId").toString());
                extraMap.put("pushType","2");//视频回复被回复
                title = userInfor.getName()+"回复了你的评论";
            }

            //添加论坛回复
            tutorialReviewService.addForumReply(forumReplyVo);
            if(StringUtils.isNotBlank(forumReplyVo.getParentId())) {
                String repdUserId = forumReplyVo.getRepdUserId();
                filter.put("userId",repdUserId);
                filter.put("opType","3");
                forumTopicService.addNotOnlineData(filter);
            }

            JPushUtils.jPushClient.sendPush(JPushUtils.buildPushObject_android_and_ios(linkedList,title,map.get("content").toString(),extraMap));
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }

    /**
     * 分页查询评论
     */
    @RequestMapping(value = "/getReply.json")
    @ResponseBody
    public ResponseData getReply(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);

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
        Pagination pagination = tutorialReviewService.findPager(filter).getReturnObj();
        List list = pagination.getEntityList();
        for(int i = 0;i < list.size();i++) {
            Map<String,Object> map = (Map)list.get(i);
            String pIds = map.get("pids").toString();
            String[] pid = pIds.split(",");
            String[] newPid = {"0"};
            if(pid.length > 2) {
                newPid  = Arrays.copyOfRange(pid,pid.length-2,pid.length);
            }else {
                newPid = pid;
            }

            filter.clear();
            filter.put("pIds",newPid);
            filter.put("pId",map.get("id"));
            filter.setStatementKey("getParentReply");
            List<Map> list1 = tutorialReviewService.findList(filter).getReturnObj();
            map.put("replyList",list1);

        }
        data.setObj(pagination);
        return data;
    }

    /**
     * 分页查询父级评论
     * @param request
     * @return
     */
    @RequestMapping(value = "/getParentReply.json")
    @ResponseBody
    public ResponseData getParentReply(HttpServletRequest request) {
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
        data.setObj(tutorialReviewService.getParentReply(filter));
        return data;
    }


     /**
     * 我的回答和评论
     * @return
     */
    @RequestMapping("/askAndanswer.json")
    @ResponseBody
    public ResponseData askAndanswer(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
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

            if(map.get("flag") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            data.setObj(tutorialReviewService.askAndanswer(userInfor.getId(),map.get("flag").toString()));
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    /**
     * 修改观看次数并返回观看次数
     * @param videoId
     * @return
     */
    @RequestMapping("/updReadCount.json")
    @ResponseBody
    public ResponseData updReadCount(long videoId) {
        ResponseData data = new ResponseData(true);
        VideoInfoVo videoInfoVo = tutorialReviewService.addReadCount(videoId);
        data.setObj(videoInfoVo);
        return data;
    }


    /**
     * 根据id获取回复所在页码
     * @return
     */
    @RequestMapping("/getPagerNumById.json")
    @ResponseBody
    public ResponseData getPagerNumById(HttpServletRequest request) {
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

            if(map.get("replyId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("videoId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.put("videoId",Integer.parseInt(map.get("videoId").toString()));
            filter.put("id",Integer.parseInt(map.get("replyId").toString()));
            int replyPagerNum = tutorialReviewService.getPagerNumById(filter);
            int pagNum = 0;
            if(replyPagerNum % 6 == 0) {
                pagNum = replyPagerNum / 6;
            }else {
                pagNum = (replyPagerNum / 6) + 1;
            }
            data.setObj(pagNum);
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

            if(map.get("content") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("contactInformation") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            

            filter.put("userId",userInfor.getId());
            int successCount = tutorialReviewService.saveFeedbackApi(filter);
            if(successCount == 1) {
                return data;
            }else {
                data.setSuccess(false);
                return data;
            }
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    @RequestMapping("/uploadImg.json")
    @ResponseBody
    public ResponseData updloadImg(HttpServletRequest request) {

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

            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
            if (null == fileMap) {
                return new ResponseData(false, "请选择上传文件");
            }

            String realPath = "";
            for (MultipartFile multipartFile : fileMap.values()) {
                realPath = FileUploadUtils.uploadPic(userInfor,multipartFile);
            }

            data.setObj(realPath);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }


    }



    /**
     * 获取我的收藏
     * @return
     */
    @RequestMapping("/getCollect.json")
    @ResponseBody
    public ResponseData getCollect(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
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

            QueryFilter filter = new QueryFilter(userInfor);
            filter.put("userId",userInfor.getId());
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
                    collectVo.setLastStdTime(userVideo.getDatetime());
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

            data.setObj(collectVoList);
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }



    /**
     * 收藏
     * @param request
     * @return
     */
    @RequestMapping("/collect.json")
    @ResponseBody
    public ResponseData updCollectApi(HttpServletRequest request) {
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


            String userId = userInfor.getId().toString();
            if(StringUtils.isBlank(userId)) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }


            QueryFilter filter = new QueryFilter(request);

            if(filter.get("title") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            if(filter.get("videoId") == null) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            filter.put("vid",filter.get("videoId"));
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getVideoInfoExamInfoByVid");

            LinkedHashMap<String,Object> map1 = videoInfoService.findOne(filter).getReturnObj();

            if((Long)map1.get("iscollect") != 0 && !"2".equals((String)map.get("isCollect"))) {
                data.setMessage("此视频已收藏");
                data.setSuccess(false);
                return data;
            }

            System.out.println("-----------------------------isCollect:"+(String)map.get("isCollect")+"---------------------------------------");

            tutorialReviewService.saveCollect(filter);
            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }

    /**
     * 兑换证书
     * @param request
     * @return
     */
    @RequestMapping("/myCertificate.json")
    @ResponseBody
    public ResponseData convertCertificateApi(HttpServletRequest request) {
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


            if(StringUtils.isBlank((String)map.get("certificateId"))) {
                data.setSuccess(false);
                data.setMessage("缺少必要参数");
                return data;
            }

            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getCertificateStatus");
            Map<String,Object> certificateMap = tutorialReviewService.findOne(filter).getReturnObj();

            if(certificateMap != null) {
                data.setSuccess(false);
                data.setMessage("不能重复兑换");
                return data;
            }

            String canChangeCertificate = SettingUtil.getSetting("canChangeCertificate",String.class);
            String[] examIdArrays = canChangeCertificate.split(",");
            filter.setStatementKey("getEaxm");
            List<UserExam> list = tutorialReviewService.findList(filter).getReturnObj();

            int result = tutorialReviewService.saveCertificate(filter,examIdArrays,list);
            if(result == 0) {
                data.setMessage("不符合兑换条件");
                data.setSuccess(false);
                return data;
            }

            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }


    @RequestMapping("/getCanChangeCertificate.json")
    @ResponseBody
    public ResponseData getCanChangeCertificate(HttpServletRequest request) {

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

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.setStatementKey("getCertificateStatus");
            data.setObj(tutorialReviewService.findOne(filter).getReturnObj());
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }
    }


    @RequestMapping("/deleteReply.json")
    @ResponseBody
    public ResponseData deleteReply(HttpServletRequest request) {
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
            Long id = map.get("id") == null ? null : Long.parseLong(map.get("id").toString());

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

            QueryFilter filter = new QueryFilter();
            filter.put("id", userInfor.getId());
            tutorialReviewService.delete(id);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }

    }

}
