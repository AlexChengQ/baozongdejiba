package com.bylz.quantumCloud.education.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.bylz.quantumCloud.education.util.CreateKeyUtils;
import com.bylz.quantumCloud.education.util.HttpUtils;
import com.bylz.quantumCloud.education.util.qq.QQUser;
import com.bylz.quantumCloud.education.util.qq.QQUtils;
import com.bylz.quantumCloud.education.util.weibo4j.Account;
import com.bylz.quantumCloud.education.util.weibo4j.Oauth;
import com.bylz.quantumCloud.education.util.weibo4j.http.AccessToken;
import com.bylz.quantumCloud.education.util.weibo4j.model.User;
import com.bylz.quantumCloud.education.util.weibo4j.model.WeiboException;
import com.bylz.quantumCloud.education.util.weibo4j.org.json.JSONException;
import com.bylz.quantumCloud.education.util.weibo4j.util.BareBonesBrowserLaunch;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import com.likegene.framework.util.SettingUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.wechat.OAuthInfo;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.bylz.quantumCloud.education.util.wechat.WechatUserInfoBean;

@Controller
public class LoginController extends BaseController {

    @Autowired
    private QcodeUserService qcodeUserService;

    @Autowired
    private QcodeTaskService qcodeTaskService;

    @Autowired
    private QcodeThirdLoginService qcodeThirdLoginService;

    @Autowired
    private RegisterController registerController;

    @Autowired
    private UpdateUserScoreService updateUserScoreService;

    @Autowired
    private TutorialReviewService tutorialReviewService;

    @RequestMapping(value = "/login.html")
    public String login(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        System.out.println("login-normal");
        model.put("weChatLogin", WeChatUtils.getStartURLToGetCode());
//        String takenUrl = "https://api.weibo.com/oauth2/authorize?client_id=client_ID&redirect_uri=weibo_redirect_URI&response_type=code";
//        takenUrl= takenUrl.replace("client_ID", SettingUtil.getSetting("client_ID", String.class));
//        try {
//            takenUrl = takenUrl.replace("weibo_redirect_URI",
//                    URLEncoder.encode(SettingUtil.getSetting("weibo_redirect_URI", String.class), "UTF-8"));
//        } catch (UnsupportedEncodingException e) {
//            logger.error(e.getMessage());
//        }
//
//        model.put("weiboLogin",takenUrl);
//        model.put("qqLogin", QQUtils.getCode());
        return "login-normal";
    }

    @RequestMapping(value = "/login-min.html")
    public String loginmin(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        System.out.println("login-min");
        model.put("weChatLogin", WeChatUtils.getStartURLToGetCode());
        return "login-min";
    }
    
    /**
     * 平台用户登录
     *
     * @return ResponseData
     */
    @RequestMapping(value = "/doLogin.json")
    @ResponseBody
    public ResponseData doLogin(HttpServletRequest request) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(password)) {
            return new ResponseData(false, getMessage("login_account_empty"));
        }

        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("login");
        filter.put("email", email);
        QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();

        if (null == qcodeUser || "admin".toUpperCase().equals(qcodeUser.getEmail().toUpperCase())) {
            return new ResponseData(false, getMessage("check_your_credentials"));
        }

        if (qcodeUser.getIsDisable() == 1) {
            return new ResponseData(false, getMessage("login_account_disabled"));
        }

        //		String encodePassword = new Md5Hash(password).toHex();
        if (StringUtils.equals(password, qcodeUser.getPwd())) {

            UsernamePasswordToken token = new UsernamePasswordToken(email, password);
            SecurityUtils.getSubject().login(token);

            qcodeUser.setLoginTime(new Date());

            //插入学习记录表
            filter.put("userId",qcodeUser.getId());
            filter.setStatementKey("insertUserStd");
            Date nowDate = new Date();
            filter.put("loginTime",nowDate);
            qcodeUserService.save(filter);
            SecurityUtils.getSubject().getSession().setAttribute("userStdDate", nowDate);
            int hasSignIn = updateUserScoreService.hasSignIn(qcodeUser.getId(),1);
            qcodeUser.setSignIn(hasSignIn);
            //查看是否版主
            qcodeUser.setIsModerator("0");
            Map isModerator = qcodeUserService.isModerator(qcodeUser.getId());
            if(Integer.parseInt(isModerator.get("ismoder").toString()) > 0) {
                qcodeUser.setIsModerator("1");
                qcodeUser.setBelonged((String)isModerator.get("belonged"));
            }

            SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
            //第三方用户与量子用户绑定
            ResponseData bindQcodeUserResult = bindQcodeUser(request, qcodeUser);
            if (bindQcodeUserResult != null) {
                return bindQcodeUserResult;
            }

            //查询用户运行中任务当前状态并同步
            filter = new QueryFilter();
            filter.put("status", 0);
            filter.put("userId", qcodeUser.getId());
            filter.setStatementKey("getRunningTask");
            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
            for (int i = 0; i < taskList.size(); i++) {
                QcodeTask task = taskList.get(i);
                HashMap paramAns = new HashMap();
                paramAns.put("task_id", task.getTaskId());

                String s2 = qcodeTaskService.queryTask(paramAns);
                JSONObject json = JSONObject.parseObject(s2);
                if (json.size() == 0) {
                    logger.debug("登陆时同步task请求接口失败，http返回空", task.getTaskId());
                }
                //任务id
                String task_id = (String) json.get("taskid");
                //任务状态
                String tasksta = (String) json.get("tasksta");
                switch (tasksta) {
                    case "1":
                        //等待
                        task.setStatus(QcodeTask.STATUS_WAITING);
                        break;
                    case "2":
                        //处理中
                        task.setStatus(QcodeTask.STATUS_PROCESS);
                        break;
                    case "3":
                        JSONObject ans = (JSONObject) json.get("taskrs");
                        if (ans != null && !("".equals(ans))) {
                            //有结果且正确
                            task.setStatus(QcodeTask.STATUS_RESULT);
                            task.setAns(ans.toString());
                        } else {
                            //有结果为空，语法错误
                            task.setStatus(QcodeTask.STATUS_ERROR);
                        }

                        break;
                    default:
                        break;
                }
                Result result = qcodeTaskService.save(task);
                if (!result.isSuccess()) {
                    logger.debug("登陆时同步task，更新task出错", task.getTaskId());
                }
            }

            Timer timer = new Timer();
            timer.schedule(new UserStatusTask(),3000,3000);

            return ResponseData.SUCCESS_NO_DATA;
        }
        return new ResponseData(false, getMessage("check_your_credentials"));
    }

    /**
     * 跳转首页
     */
    @RequestMapping(value = "/index.html")
    public String index() {
        return "redirect:/EDU/index.html";
    }

    /**
     * 退出登录
     */
    @RequestMapping(value = "/logout.html")
    public String logout(HttpSession session,String flag) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        Date loginTime = qcodeUser.getLoginTime();
        Date logoutTime = new Date();
        long stdTime = (logoutTime.getTime() - loginTime.getTime())/(1000*60);
        QueryFilter filter = new QueryFilter();
        filter.put("userId",qcodeUser.getId());
        filter.put("loginTime",loginTime);
        filter.put("stdTime",stdTime);
        filter.setStatementKey("getBonusInfo");
        UserBonusVo userBonusVo = qcodeUserService.findOne(filter).getReturnObj();
        if(userBonusVo != null) {
            filter.setStatementKey("updLoginTimeAndStdTime");
            qcodeUserService.update(filter);
        }else {
            filter.setStatementKey("addLoginTimeAndStdTime");
            qcodeUserService.save(filter);
        }

        session.invalidate();
        SecurityUtils.getSubject().logout();
        return "index";

    }


    /**
     * 微信引导页进入的方法
     */
    @RequestMapping("/loginByWeiXin.html")
    public String loginByWeiXin(HttpServletRequest request, ModelMap model) {
        // 微信接口自带 2 个参数
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        logger.info("code = " + code + ", state = " + state);

        if (code != null && !"".equals(code)) {
            // 授权成功, 微信获取用户openID
            OAuthInfo authInfo = WeChatUtils.getAccess_token(code);
            String access_token = authInfo.getAccess_token();

            if (access_token == null) {
                // Code 使用过 异常
                logger.info("Code 使用过 异常.....");
                return "redirect:" + WeChatUtils.getStartURLToGetCode();
            }
            //微信第三方用户信息
            WechatUserInfoBean weChatUserInfo = WeChatUtils.getWeChatUserInfo(access_token, authInfo.getOpenid());
            // 微信第三方登录检查
            QcodeUser qcodeUser = thirdLoginCheck(weChatUserInfo);

            if (qcodeUser == null) {
                logger.info("尚未绑定账号.....");
                model.put("appId", weChatUserInfo.getUnionid());
                model.put("nickname", weChatUserInfo.getNickname());
                return "thirdBindUser";//账号信息绑定
                //				return "redirect:" + WeChatUtils.getStartURLToGetCode();//继续扫描二维码
            } else { //模拟登录
                if(StringUtils.isEmpty(qcodeUser.getApiKey())) {
                    ResponseData data = CreateKeyUtils.createKey(qcodeUser);
                    if(data.isSuccess()) {
                        qcodeUser.setToken((String)data.getObj());
                        qcodeUser.setApiKey((String)data.getObj());
                    }
                }else {
                    qcodeUser.setToken(qcodeUser.getApiKey());
                }
                registerController.autoLogin(qcodeUser);
            }

            // 登录成功
            return "redirect:/EDU/index.html";
        }
        // 未授权
        return "redirect:" + WeChatUtils.getStartURLToGetCode();
    }


    /**
     * 第三方与量子用户绑定
     */
    private ResponseData bindQcodeUser(HttpServletRequest request, QcodeUser qcodeUser) {
        String appId = request.getParameter("appId");
        if (!StringUtils.isEmpty(appId)) {
            String email = request.getParameter("email");
            Integer appType = Integer.valueOf(request.getParameter("appType"));
            //			if(qcodeThirdLoginService.isExistingThirdAppAccount(appId, appType)){
            //				return new ResponseData(false,getMessage("thirdApp_is_binded"));
            //			}
            if (qcodeThirdLoginService.isbinded(email, appType)) {
                return new ResponseData(false, getMessage("quantum_is_binded"));
            }
            qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUser.getId());
        }
        return null;
    }


    @Transactional(propagation = Propagation.REQUIRED)
    private<T> QcodeUser thirdLoginCheck(WechatUserInfoBean weChatUserInfo) {

        String appId = weChatUserInfo.getUnionid();

        // 数据库中查询微信号是否绑定平台账号
        QueryFilter filter = new QueryFilter();
        filter.put("appId", appId);
        filter.put("appType", QcodeThirdLogin.APPTYPE_WE_CHAT);
        QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();

        QcodeUser qcodeUser = null;
        if (qcodeThirdLogin == null) {//第一次登录
            //创建一条第三方信息
            qcodeThirdLogin = new QcodeThirdLogin();
            qcodeThirdLogin.setAppId(appId);
            qcodeThirdLogin.setFace(weChatUserInfo.getHeadimgurl());
            qcodeThirdLogin.setNickname(weChatUserInfo.getNickname());
            qcodeThirdLogin.setAppType(QcodeThirdLogin.APPTYPE_WE_CHAT);
            qcodeThirdLoginService.save(qcodeThirdLogin);
            return null;
        } else {//之前登录过
            //没有绑定用户
            if (null == qcodeThirdLogin.getUserId()) {
                return null;
            }
            //已绑定用户
            else {
                filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
                qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
            }

            //更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
            //没有绑定用户 第三方 微信头像，名称改变
            if (null == qcodeThirdLogin.getUserId() || (!weChatUserInfo.getHeadimgurl()
                    .equals(qcodeThirdLogin.getFace())) || (!weChatUserInfo.getNickname()
                    .equals(qcodeThirdLogin.getNickname()))) {
                qcodeThirdLogin.setFace(weChatUserInfo.getHeadimgurl());
                qcodeThirdLogin.setNickname(weChatUserInfo.getNickname());
                qcodeThirdLogin.setUserId(qcodeUser.getId());
                qcodeThirdLoginService.update(qcodeThirdLogin);
            }
        }
        return qcodeUser;

    }


    /**
     * 平台用户登录
     *
     * @return ResponseData
     */
    @RequestMapping(value = "/api/doLogin.json")
    @ResponseBody
    public ResponseData doLoginApi(HttpServletRequest request) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        ResponseData responseData = new ResponseData(true);

        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(password)) {
            return new ResponseData(false, getMessage("login_account_empty"));
        }

        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("login");
        filter.put("email", email);
        QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();

        if (null == qcodeUser || "admin".toUpperCase().equals(qcodeUser.getEmail().toUpperCase())) {
            return new ResponseData(false, getMessage("check_your_credentials"));
        }

        if (qcodeUser.getIsDisable() == 1) {
            return new ResponseData(false, getMessage("login_account_disabled"));
        }

        //		String encodePassword = new Md5Hash(password).toHex();
        if (StringUtils.equals(password, qcodeUser.getPwd())) {

            UsernamePasswordToken token = new UsernamePasswordToken(email, password);
            SecurityUtils.getSubject().login(token);

            qcodeUser.setLoginTime(new Date());

            //插入学习记录表
            filter.put("userId",qcodeUser.getId());
            filter.setStatementKey("insertUserStd");
            qcodeUserService.save(filter);


            int hasSignIn = updateUserScoreService.hasSignIn(qcodeUser.getId(),1);
            qcodeUser.setSignIn(hasSignIn);
            //查看是否版主
            qcodeUser.setIsModerator("0");
            Map isModerator = qcodeUserService.isModerator(qcodeUser.getId());
            if(Integer.parseInt(isModerator.get("ismoder").toString()) > 0) {
                qcodeUser.setIsModerator("1");
                qcodeUser.setBelonged((String)isModerator.get("belonged"));
            }

            filter.put("userId",qcodeUser.getId());
            filter.setStatementKey("getCertificateStatus");

            List<Map<String,Object>> certificateMap = tutorialReviewService.findList(filter).getReturnObj();
            qcodeUser.setCertificateMap(certificateMap);
            if(certificateMap.size() > 0) {
               qcodeUser.setCanConvertCertificate(false);
            }else {
               qcodeUser.setCanConvertCertificate(CanConvertCertificate(qcodeUser.getId()));
            }

            boolean bindWeiXin = bingingThird(qcodeUser.getId(),"2");
            boolean bindWeiBo = bingingThird(qcodeUser.getId(),"3");
            boolean bindQQ = bingingThird(qcodeUser.getId(),"1");
            qcodeUser.setBindingPhone(false);
            qcodeUser.setBindingQQ(bindQQ);
            qcodeUser.setBindingWeiXin(bindWeiXin);
            qcodeUser.setBindingWeiBo(bindWeiBo);
            SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
            //第三方用户与量子用户绑定
            ResponseData bindQcodeUserResult = bindQcodeUser(request, qcodeUser);
            if (bindQcodeUserResult != null) {
                return bindQcodeUserResult;
            }

            //查询用户运行中任务当前状态并同步
            filter = new QueryFilter();
            filter.put("status", 0);
            filter.put("userId", qcodeUser.getId());
            filter.setStatementKey("getRunningTask");
            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
            for (int i = 0; i < taskList.size(); i++) {
                QcodeTask task = taskList.get(i);
                HashMap paramAns = new HashMap();
                paramAns.put("task_id", task.getTaskId());

                String s2 = qcodeTaskService.queryTask(paramAns);
                JSONObject json = JSONObject.parseObject(s2);
                if (json.size() == 0) {
                    logger.debug("登陆时同步task请求接口失败，http返回空", task.getTaskId());
                }
                //任务id
                String task_id = (String) json.get("taskid");
                //任务状态
                String tasksta = (String) json.get("tasksta");
                switch (tasksta) {
                    case "1":
                        //等待
                        task.setStatus(QcodeTask.STATUS_WAITING);
                        break;
                    case "2":
                        //处理中
                        task.setStatus(QcodeTask.STATUS_PROCESS);
                        break;
                    case "3":
                        JSONObject ans = (JSONObject) json.get("taskrs");
                        if (ans != null && !("".equals(ans))) {
                            //有结果且正确
                            task.setStatus(QcodeTask.STATUS_RESULT);
                            task.setAns(ans.toString());
                        } else {
                            //有结果为空，语法错误
                            task.setStatus(QcodeTask.STATUS_ERROR);
                        }

                        break;
                    default:
                        break;
                }
                Result result = qcodeTaskService.save(task);
                if (!result.isSuccess()) {
                    logger.debug("登陆时同步task，更新task出错", task.getTaskId());
                }
            }

            ResponseData data = new ResponseData(true);
            if(StringUtils.isEmpty(qcodeUser.getApiKey())) {
                data = CreateKeyUtils.createKey(qcodeUser);
                if(data.isSuccess()) {
                    qcodeUser.setToken((String)data.getObj());
                    qcodeUser.setApiKey((String)data.getObj());
                }
            }else {
                qcodeUser.setToken(qcodeUser.getApiKey());
            }

            responseData.setObj(qcodeUser);

            return responseData;
        }
        return new ResponseData(false, getMessage("check_your_credentials"));
    }


    private boolean CanConvertCertificate(long userId) {
        QueryFilter filter = new QueryFilter();
        String canChangeCertificate = SettingUtil.getSetting("canChangeCertificate",String.class);
        String[] examIdArrays = canChangeCertificate.split(",");
        filter.put("userId",userId);
        filter.setStatementKey("getEaxm");
        List<UserExam> list = tutorialReviewService.findList(filter).getReturnObj();
        Set<String> set = new HashSet<String>();
        boolean can = false;
        for(int i = 0;i < examIdArrays.length;i++) {
            for(int j = 0;j < list.size();j++) {
                int examId = list.get(j).getExamid();
                if(Integer.parseInt(examIdArrays[i]) == examId) {
                    set.add(examId+"");
                }
            }
        }

        if(examIdArrays.length != set.size() ) {
            return false;
        }

        for(int i = 0; i < examIdArrays.length;i++) {
            if(set.contains(examIdArrays[i])) {
                can = true;
            }else {
                can = false;
                break;
            }
        }

        if(!can) {
            return false;
        }

        for(UserExam exam:list) {
            String status = exam.getStatus();
            int allQuestion = status.replace("1","").lastIndexOf("|")+1;//共有多少题目
            String[] allAnswer = status.split("\\|");
            if(allAnswer.length != allQuestion) {
                return false;
            }else {
                int flag = 1;
                for(int i = 0;i < allAnswer.length;i++) {
                    if("0".equals(allAnswer[i])) {
                        flag = 0;
                        break;
                    }
                }

                if(flag == 0) {
                    return false;
                }
            }
        }

        return true;
    }


    private boolean bingingThird(Long userId,String appType) {
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



    @RequestMapping("/loginByWeiBo.html")
    public String loginByWeiBo(HttpServletRequest request, ModelMap model) throws WeiboException,JSONException {
        Oauth oauth = new Oauth();
        String code = request.getParameter("code");

        String state = request.getParameter("state");
        logger.info("code = " + code + ", state = " + state);

        if (code != null && !"".equals(code)) {
            // 授权成功, 微信获取用户openID
            AccessToken accessToken = oauth.getAccessTokenByCode(code);
            String access_token = accessToken.getAccessToken();

            if (access_token == null) {
                // Code 使用过 异常
                logger.info("Code 使用过 异常.....");
                return "redirect:" + WeChatUtils.getStartURLToGetCode();
            }
            //微信第三方用户信息
            Account account = new Account(access_token);
            com.bylz.quantumCloud.education.util.weibo4j.org.json.JSONObject jsonObject = account.getUid();
            String uid = jsonObject.getString("uid");
            User weiboUserInfo = oauth.showUserById(uid,access_token);
            // 微信第三方登录检查
            QcodeUser qcodeUser = thirdLoginCheckByWeiBo(weiboUserInfo);

            if (qcodeUser == null) {
                logger.info("尚未绑定账号.....");
                model.put("appId", weiboUserInfo.getId());
                model.put("nickname", weiboUserInfo.getScreenName());
                return "thirdBindUser";//账号信息绑定
                //				return "redirect:" + WeChatUtils.getStartURLToGetCode();//继续扫描二维码
            } else { //模拟登录
                registerController.autoLogin(qcodeUser);
            }

            // 登录成功
            return "redirect:/EDU/index.html";
        }
        // 未授权
        return "redirect:" + WeChatUtils.getStartURLToGetCode();
    }


    @Transactional(propagation = Propagation.REQUIRED)
    private QcodeUser thirdLoginCheckByWeiBo(User weiBoUserInfo) {

        String appId = weiBoUserInfo.getId();

        // 数据库中查询微信号是否绑定平台账号
        QueryFilter filter = new QueryFilter();
        filter.put("appId", appId);
        filter.put("appType", QcodeThirdLogin.APPTYPE_SINA);
        QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();

        QcodeUser qcodeUser = null;
        if (qcodeThirdLogin == null) {//第一次登录
            //创建一条第三方信息
            qcodeThirdLogin = new QcodeThirdLogin();
            qcodeThirdLogin.setAppId(appId);
            qcodeThirdLogin.setFace(weiBoUserInfo.getProfileImageUrl());
            qcodeThirdLogin.setNickname(weiBoUserInfo.getScreenName());
            qcodeThirdLogin.setAppType(QcodeThirdLogin.APPTYPE_SINA);
            qcodeThirdLoginService.save(qcodeThirdLogin);
            return null;
        } else {//之前登录过
            //没有绑定用户
            if (null == qcodeThirdLogin.getUserId()) {
                return null;
            }
            //已绑定用户
            else {
                filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
                qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
            }

            //更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
            //没有绑定用户 第三方 微信头像，名称改变
            if (null == qcodeThirdLogin.getUserId() || (!weiBoUserInfo.getProfileImageUrl()
                    .equals(qcodeThirdLogin.getFace())) || (!weiBoUserInfo.getScreenName()
                    .equals(qcodeThirdLogin.getNickname()))) {
                qcodeThirdLogin.setFace(weiBoUserInfo.getProfileImageUrl());
                qcodeThirdLogin.setNickname(weiBoUserInfo.getScreenName());
                qcodeThirdLogin.setUserId(qcodeUser.getId());
                qcodeThirdLoginService.update(qcodeThirdLogin);
            }
        }
        return qcodeUser;

    }


    @RequestMapping("/loginByQQ.html")
    public String loginByQQ(HttpServletRequest request, ModelMap model) throws Exception {

        String code = request.getParameter("code");

        String state = request.getParameter("state");
        logger.info("code = " + code + ", state = " + state);

        if (code != null && !"".equals(code)) {
            //授权成功获取accesstoken;
            String result = QQUtils.getAccessByCode(code);
            String access_token = result;
            if (access_token == null) {
                // Code 使用过 异常
                logger.info("Code 使用过 异常.....");
                return "redirect:" + WeChatUtils.getStartURLToGetCode();
            }

            //获取openid
            String openId = QQUtils.getOpenId(access_token);
            String appId = SettingUtil.getSetting("QQ_client_id",String.class);
            QQUser qqUser = QQUtils.getQQUserInfo(appId,access_token,openId);
            QcodeUser qcodeUser = thirdLoginCheckByQQ(qqUser);

            if (qcodeUser == null) {
                logger.info("尚未绑定账号.....");
                model.put("appId", qqUser.getOpenId());
                model.put("nickname", qqUser.getNickname());
                return "thirdBindUser";//账号信息绑定
                //				return "redirect:" + WeChatUtils.getStartURLToGetCode();//继续扫描二维码
            } else { //模拟登录
                registerController.autoLogin(qcodeUser);
            }

            // 登录成功
            return "redirect:/EDU/index.html";
        }
        // 未授权
        return "redirect:" + WeChatUtils.getStartURLToGetCode();


    }

    @Transactional(propagation = Propagation.REQUIRED)
    private QcodeUser thirdLoginCheckByQQ(QQUser qqUser) {

        String appId = qqUser.getOpenId();

        // 数据库中查询微信号是否绑定平台账号
        QueryFilter filter = new QueryFilter();
        filter.put("appId", appId);
        filter.put("appType", QcodeThirdLogin.APPTYPE_QQ);
        QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();

        QcodeUser qcodeUser = null;
        if (qcodeThirdLogin == null) {//第一次登录
            //创建一条第三方信息
            qcodeThirdLogin = new QcodeThirdLogin();
            qcodeThirdLogin.setAppId(appId);
            qcodeThirdLogin.setFace(qqUser.getFigureurl_qq());
            qcodeThirdLogin.setNickname(qqUser.getNickname());
            qcodeThirdLogin.setAppType(QcodeThirdLogin.APPTYPE_QQ);
            qcodeThirdLoginService.save(qcodeThirdLogin);
            return null;
        } else {//之前登录过
            //没有绑定用户
            if (null == qcodeThirdLogin.getUserId()) {
                return null;
            }
            //已绑定用户
            else {
                filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
                qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
            }

            //更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
            //没有绑定用户 第三方 微信头像，名称改变
            if (null == qcodeThirdLogin.getUserId() || (!qqUser.getFigureurl_qq()
                    .equals(qcodeThirdLogin.getFace())) || (!qqUser.getNickname()
                    .equals(qcodeThirdLogin.getNickname()))) {
                qcodeThirdLogin.setFace(qqUser.getFigureurl_qq());
                qcodeThirdLogin.setNickname(qqUser.getNickname());
                qcodeThirdLogin.setUserId(qcodeUser.getId());
                qcodeThirdLoginService.update(qcodeThirdLogin);
            }
        }
        return qcodeUser;

    }


    @RequestMapping("/test.html")
    public String test(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        System.out.println("login-normal");
        model.put("weChatLogin", WeChatUtils.getStartURLToGetCode());
        String takenUrl = "https://api.weibo.com/oauth2/authorize?client_id=client_ID&redirect_uri=weibo_redirect_URI&response_type=code";
        takenUrl= takenUrl.replace("client_ID", SettingUtil.getSetting("client_ID", String.class));
        try {
            takenUrl = takenUrl.replace("weibo_redirect_URI",
                    URLEncoder.encode(SettingUtil.getSetting("weibo_redirect_URI", String.class), "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage());
        }

        model.put("weiboLogin",takenUrl);
        model.put("qqLogin", QQUtils.getCode());
        return "registerbyphone";
    }


    /**
     * 用户登录新版
     *
     * @return ResponseData
     */
    @RequestMapping(value = "/api/doLoginNew.json")
    @ResponseBody
    public ResponseData doLoginApiNew(HttpServletRequest request) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        ResponseData responseData = new ResponseData(true);

        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(password)) {
            return new ResponseData(false, getMessage("login_account_empty"));
        }

        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("login");
        filter.put("email", email);
        QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();

        if (null == qcodeUser.getId() || "admin".toUpperCase().equals(qcodeUser.getEmail().toUpperCase())) {
            return new ResponseData(false, getMessage("check_your_credentials"));
        }

        if (qcodeUser.getIsDisable() == 1) {
            return new ResponseData(false, getMessage("login_account_disabled"));
        }

        //		String encodePassword = new Md5Hash(password).toHex();
        if (StringUtils.equals(password, qcodeUser.getPwd())) {

            UsernamePasswordToken token = new UsernamePasswordToken(email, password);
            SecurityUtils.getSubject().login(token);

            qcodeUser.setLoginTime(new Date());

            int hasSignIn = updateUserScoreService.hasSignIn(qcodeUser.getId(),1);
            qcodeUser.setSignIn(hasSignIn);
            //查看是否版主
            qcodeUser.setIsModerator("0");
            Map isModerator = qcodeUserService.isModerator(qcodeUser.getId());
            if(Integer.parseInt(isModerator.get("ismoder").toString()) > 0) {
                qcodeUser.setIsModerator("1");
                qcodeUser.setBelonged((String)isModerator.get("belonged"));
            }

            filter.put("userId",qcodeUser.getId());
            filter.setStatementKey("getCertificateStatus");

            List<Map<String,Object>> certificateMap = tutorialReviewService.findList(filter).getReturnObj();
            qcodeUser.setCertificateMap(certificateMap);
            if(certificateMap.size() > 0) {
                qcodeUser.setCanConvertCertificate(false);
            }else {
                qcodeUser.setCanConvertCertificate(CanConvertCertificate(qcodeUser.getId()));
            }

            boolean bindWeiXin = bingingThird(qcodeUser.getId(),"2");
            boolean bindWeiBo = bingingThird(qcodeUser.getId(),"3");
            boolean bindQQ = bingingThird(qcodeUser.getId(),"1");
            qcodeUser.setBindingPhone(false);
            qcodeUser.setBindingQQ(bindQQ);
            qcodeUser.setBindingWeiXin(bindWeiXin);
            qcodeUser.setBindingWeiBo(bindWeiBo);
            SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
            //第三方用户与量子用户绑定
            ResponseData bindQcodeUserResult = bindQcodeUser(request, qcodeUser);
            if (bindQcodeUserResult != null) {
                return bindQcodeUserResult;
            }

            //查询用户运行中任务当前状态并同步
            filter = new QueryFilter();
            filter.put("status", 0);
            filter.put("userId", qcodeUser.getId());
            filter.setStatementKey("getRunningTask");
            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
            for (int i = 0; i < taskList.size(); i++) {
                QcodeTask task = taskList.get(i);
                HashMap paramAns = new HashMap();
                paramAns.put("task_id", task.getTaskId());

                String s2 = qcodeTaskService.queryTask(paramAns);
                JSONObject json = JSONObject.parseObject(s2);
                if (json.size() == 0) {
                    logger.debug("登陆时同步task请求接口失败，http返回空", task.getTaskId());
                }
                //任务id
                String task_id = (String) json.get("taskid");
                //任务状态
                String tasksta = (String) json.get("tasksta");
                switch (tasksta) {
                    case "1":
                        //等待
                        task.setStatus(QcodeTask.STATUS_WAITING);
                        break;
                    case "2":
                        //处理中
                        task.setStatus(QcodeTask.STATUS_PROCESS);
                        break;
                    case "3":
                        JSONObject ans = (JSONObject) json.get("taskrs");
                        if (ans != null && !("".equals(ans))) {
                            //有结果且正确
                            task.setStatus(QcodeTask.STATUS_RESULT);
                            task.setAns(ans.toString());
                        } else {
                            //有结果为空，语法错误
                            task.setStatus(QcodeTask.STATUS_ERROR);
                        }

                        break;
                    default:
                        break;
                }
                Result result = qcodeTaskService.save(task);
                if (!result.isSuccess()) {
                    logger.debug("登陆时同步task，更新task出错", task.getTaskId());
                }
            }

            ResponseData data = new ResponseData(true);
            if(StringUtils.isEmpty(qcodeUser.getApiKey())) {
                data = CreateKeyUtils.createKey(qcodeUser);
                if(data.isSuccess()) {
                    qcodeUser.setToken((String)data.getObj());
                    qcodeUser.setApiKey((String)data.getObj());
                }
            }else {
                qcodeUser.setToken(qcodeUser.getApiKey());
            }
            String face = qcodeUser.getFace();
            try {
                if(!StringUtils.isEmpty(face)) {
                    StringBuffer sb = new StringBuffer();
                    boolean f = face.contains("headFile");
                    if(f) {
                        sb.append(request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/files/");
                        sb.append(face);
                        face = sb.toString();
                    }
                    qcodeUser.setFace(face);
                }

            }catch (Exception e) {
                e.printStackTrace();
            }

            responseData.setObj(qcodeUser);

            return responseData;
        }
        return new ResponseData(false, getMessage("check_your_credentials"));
    }

}
