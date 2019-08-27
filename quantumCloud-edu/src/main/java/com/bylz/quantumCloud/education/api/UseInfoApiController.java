package com.bylz.quantumCloud.education.api;

import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.FileUploadUtils;
import com.bylz.quantumCloud.education.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.education.util.GetUserIdByApikey;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeThirdLoginService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.UpdateUserScoreService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/12
 */
@Controller
@RequestMapping("/api/UserInfo")
public class UseInfoApiController extends BaseController {

    @Autowired
    private QcodeUserService qcodeUserService;

    @Autowired
    private UpdateUserScoreService updateUserScoreService;

    @Autowired
    private QcodeThirdLoginService qcodeThirdLoginService;

    /**
     * 获得用户信息
     * @return
     */
    @RequestMapping("/getUserStdLogAndBouns.json")
    @ResponseBody
    public ResponseData getUserStdLogAndBouns(HttpServletRequest request) {
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

            if(StringUtils.isBlank((String)map.get("num"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            userInfor = qcodeUserService.getQcodeUserInfo(userInfor,Integer.parseInt((String)map.get("num")));
            userInfor.setToken(userInfor.getApiKey());
            //查询有无签到
            int hasSignIn = updateUserScoreService.hasSignIn(userInfor.getId(),1);

            userInfor.setSignIn(hasSignIn);

            boolean bindWeiXin = bingingWeiXin(userInfor.getId(),"2");
            boolean bindWeiBo = bingingWeiXin(userInfor.getId(),"3");
            boolean bindQQ = bingingWeiXin(userInfor.getId(),"1");
            if(StringUtils.isBlank(userInfor.getTel())) {
                userInfor.setBindingPhone(false);
            }else {
                userInfor.setBindingPhone(true);
            }

            userInfor.setBindingQQ(bindQQ);
            userInfor.setBindingWeiBo(bindWeiBo);
            userInfor.setBindingWeiXin(bindWeiXin);


            data.setObj(userInfor);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    /**
     * 获得用户信息(修改用户头像返回全路径)
     * @return
     */
    @RequestMapping("/getUserStdLogAndBounsNew.json")
    @ResponseBody
    public ResponseData getUserStdLogAndBounsNew(HttpServletRequest request) {
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

            if(StringUtils.isBlank((String)map.get("num"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            userInfor = qcodeUserService.getQcodeUserInfo(userInfor,Integer.parseInt((String)map.get("num")));
            userInfor.setToken(userInfor.getApiKey());
            //查询有无签到
            int hasSignIn = updateUserScoreService.hasSignIn(userInfor.getId(),1);

            userInfor.setSignIn(hasSignIn);

            boolean bindWeiXin = bingingWeiXin(userInfor.getId(),"2");
            boolean bindWeiBo = bingingWeiXin(userInfor.getId(),"3");
            boolean bindQQ = bingingWeiXin(userInfor.getId(),"1");
            userInfor.setBindingPhone(false);
            userInfor.setBindingQQ(bindQQ);
            userInfor.setBindingWeiBo(bindWeiBo);
            userInfor.setBindingWeiXin(bindWeiXin);
            String face = userInfor.getFace();
            try {
                if(!com.alibaba.druid.util.StringUtils.isEmpty(face)) {
                    StringBuffer sb = new StringBuffer();
                    boolean f = face.contains("headFile");
                    if(f) {
                        sb.append(request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/files/");
                        sb.append(face);
                        face = sb.toString();
                    }
                    userInfor.setFace(face);
                }

            }catch (Exception e) {
                e.printStackTrace();
            }

            data.setObj(userInfor);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }



    /**
     * 修改密码
     * @return
     */
    @RequestMapping("/updPwd.json")
    @ResponseBody
    public ResponseData updPwd(HttpServletRequest request) {
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

            if(map.get("oldPwd") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("pwd") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if(map.get("pwd").toString().equals(userInfor.getPwd())) {
                qcodeUserService.updPassword(map.get("pwd").toString(),userInfor.getId());
                return data;
            }else {
                data.setMessage("原密码不正确");
                data.setSuccess(false);
                return data;
            }

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    /**
     * 获得我的回答数和勋章数
     */
    @RequestMapping("/getAnswerNum.json")
    @ResponseBody
    public ResponseData getAnswerNum(HttpServletRequest request) {
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

            data.setObj(qcodeUserService.getMyAnwserAndBonusNum(userInfor.getId()));
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }


    /**
     * 查询user_video和user_exam表中最新数据
     */
    @RequestMapping("/getNewest.json")
    @ResponseBody
    public ResponseData getNewest(HttpServletRequest request) {
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

            Map newestMap = qcodeUserService.getNewest(userInfor.getId());
            data.setObj(newestMap);
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    @RequestMapping("/getNewExam.json")
    @ResponseBody
    public ResponseData getNewExam(HttpServletRequest request) {
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

            if(map.get("videoId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId",userInfor.getId());
            filter.put("videoId",map.get("videoId").toString());
            data.setObj(qcodeUserService.getNewExam(filter));
            return data;

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }

    }

    @RequestMapping("/getNewVideo.json")
    @ResponseBody
    public ResponseData getNewVideo(HttpServletRequest request) {
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

            if (map.get("videoId") == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            QueryFilter filter = new QueryFilter();
            filter.put("userId", userInfor.getId());
            filter.put("videoId", map.get("videoId").toString());
            data.setObj(qcodeUserService.getNewVideo(filter));
            return data;

        } catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            return data;
        }
    }

    /**
     * 修改用户信息
     * @return
     */
    @RequestMapping("/updUserInfo.json")
    @ResponseBody
    public ResponseData updUserInfoApi(HttpServletRequest request) throws UnsupportedEncodingException {

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

            if(StringUtils.isNotBlank((String)map.get("name"))) {
                String name = URLDecoder.decode((String)map.get("name"),"UTF-8");
                userInfor.setName(name);
            }

            if(StringUtils.isNotBlank((String)map.get("orgName"))) {
                String orgName = URLDecoder.decode((String)map.get("orgName"),"UTF-8");
                userInfor.setOrgName(orgName);
            }

            int hasSignIn = updateUserScoreService.hasSignIn(userInfor.getId(),1);

            if(StringUtils.isNotBlank((String)map.get("fileUrl"))) {
                userInfor.setFace((String)map.get("fileUrl"));
            }


            qcodeUserService.updUserInfo(userInfor);
            userInfor = qcodeUserService.getQcodeUser(userInfor);
            userInfor.setSignIn(hasSignIn);
            AppContextHolder.getSession().setAttribute("USER_INFO",userInfor);
            return data;

        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("Program error");
            return data;
        }

    }

    private boolean bingingWeiXin(Long userId,String appType) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.put("appType",appType);
        filter.setStatementKey("selectList_count");
        int count = qcodeThirdLoginService.findOne(filter).getReturnObj();
        if(count > 0) {
            return true;
        }else {
            return false;
        }
    }
}
