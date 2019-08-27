package com.bylz.quantumCloud.education.controller;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.FileUploadUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.bylz.quantumCloud.service.VideoInfoService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/12
 */
@Controller
@RequestMapping("/UserInfo")
public class UseInfoController {

    @Autowired
    private QcodeUserService qcodeUserService;

    @Autowired
    private UpdateUserScoreService updateUserScoreService;

    @Autowired
    private VideoInfoService videoInfoService;

    /**
     * 获得用户信息
     * @param num
     * @return
     */
    @RequestMapping("/getUserStdLogAndBouns.json")
    @ResponseBody
    public QcodeUser getUserStdLogAndBouns(int num) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(qcodeUser == null) {
            AppContextHolder.getSession().setAttribute("USER_INFO",null);
            return null;
        }
        qcodeUser = qcodeUserService.getQcodeUserInfo(qcodeUser,num);
        return qcodeUser;
    }



    /**
     * 修改用户信息
     * @param user
     * @param multipartFile
     * @return
     */
    @RequestMapping("/updUserInfo.json")
    @ResponseBody
    public ResponseData updUserInfo(QcodeUser user, MultipartFile multipartFile) {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        int hasSignIn = userInfor.getSignIn();
        if(multipartFile != null) {
            String relativePath = AppContextHolder.getFileSavePath()+userInfor.getFace();
            FileUploadUtils.delPreImg(relativePath);

            String realPath = FileUploadUtils.uploadPic(userInfor,multipartFile);
            user.setFace(realPath);
        }else {
            user.setFace(userInfor.getFace());
        }
        try {
            user.setId(userInfor.getId());
            qcodeUserService.updUserInfo(user);
            userInfor = qcodeUserService.getQcodeUser(userInfor);
            userInfor.setSignIn(hasSignIn);
            AppContextHolder.getSession().setAttribute("USER_INFO",userInfor);
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }


    /**
     * 修改密码
     * @param oldPwd
     * @param pwd
     * @return
     */
    @RequestMapping("/updPwd.json")
    @ResponseBody
    public ResponseData updPwd(String oldPwd,String pwd) {
        QcodeUser user = AppContextHolder.getCurrentUser();
        String MD5OldPwd = new Md5Hash(oldPwd).toHex();
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(MD5OldPwd.equals(qcodeUser.getPwd())) {
            qcodeUserService.updPassword(pwd,user.getId());
            return ResponseData.SUCCESS_NO_DATA;
        }
        return new ResponseData(false,"原密码不正确");
    }


    /**
     * 获得我的回答数和勋章数
     */
    @RequestMapping("/getAnswerNum.json")
    @ResponseBody
    public Map<String,Integer> getAnswerNum() {
        QcodeUser user = AppContextHolder.getCurrentUser();
        return qcodeUserService.getMyAnwserAndBonusNum(user.getId());
    }


    /**
     * 查询user_video和user_exam表中最新数据
     */
    @RequestMapping("/getNewest.json")
    @ResponseBody
    public Map getNewest() {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(qcodeUser == null) {
            return null;
        }
        Map map = qcodeUserService.getNewest(qcodeUser.getId());
        String blockId = map.get("blockid") == null?null:map.get("blockid").toString();
        if(StringUtils.isBlank(blockId)) {
            return map;
        }

        //根据blockID和userId查询用户在此版块下完成数量和总数量
        QueryFilter filter = new QueryFilter();
        filter.put("userId",qcodeUser.getId());
        filter.put("blockId",blockId);
        filter.setStatementKey("getStdFinishVideo");
        Map map1 = videoInfoService.findOne(filter).getReturnObj();
        map.put("finishCount",map1.get("finishcount"));
        map.put("allCount",map1.get("allcount"));
        return map;
    }

    @RequestMapping("/getNewExam.json")
    @ResponseBody
    public Map getNewExam(String videoId) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        filter.put("userId",qcodeUser.getId());
        filter.put("videoId",videoId);
        return qcodeUserService.getNewExam(filter);
    }

    @RequestMapping("/getNewVideo.json")
    @ResponseBody
    public Map getNewVideo(String videoId) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        filter.put("userId",qcodeUser.getId());
        filter.put("videoId",videoId);
        return qcodeUserService.getNewVideo(filter);
    }


    /**
     * 修改用户信息
     * @param user
     * @param multipartFile
     * @return
     */
    @RequestMapping("/api/updUserInfo.json")
    @ResponseBody
    public ResponseData updUserInfoApi(QcodeUser user, MultipartFile multipartFile) {

        ResponseData data = new ResponseData(true);
        String token = user.getApiKey() == null ? null : user.getApiKey();

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

        int hasSignIn = updateUserScoreService.hasSignIn(qcodeUser.getId(),1);
        if(multipartFile != null) {
            String relativePath = AppContextHolder.getFileSavePath()+qcodeUser.getFace();
            FileUploadUtils.delPreImg(relativePath);

            String realPath = FileUploadUtils.uploadPic(qcodeUser,multipartFile);
            user.setFace(realPath);
        }else {
            user.setFace(qcodeUser.getFace());
        }
        try {
            user.setId(qcodeUser.getId());
            qcodeUserService.updUserInfo(user);
            qcodeUser = qcodeUserService.getQcodeUser(qcodeUser);
            qcodeUser.setSignIn(hasSignIn);
            AppContextHolder.getSession().setAttribute("USER_INFO",qcodeUser);
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
    }
}
