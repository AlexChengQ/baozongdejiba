package com.bylz.quantumCloud.platform.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.QcodeThirdLogin;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.platform.util.wechat.OAuthInfo;
import com.bylz.quantumCloud.platform.util.wechat.WeChatUtils;
import com.bylz.quantumCloud.platform.util.wechat.WechatUserInfoBean;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.QcodeThirdLoginService;
import com.bylz.quantumCloud.service.QcodeUserService;

/**
 * @author JT
 * @version 1.0
 * @since 2017-07-20
 */
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

    @RequestMapping(value = "/login.html")
    public String login(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        System.out.println("login-normal");
        model.put("weChatLogin", WeChatUtils.getStartURLToGetCode());
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
            return ResponseData.SUCCESS_NO_DATA;
        }
        return new ResponseData(false, getMessage("check_your_credentials"));
    }

    /**
     * 跳转首页
     */
    @RequestMapping(value = "/index.html")
    public String index() {
        return "redirect:/QCode/index.html";
    }

    /**
     * 退出登录
     */
    @RequestMapping(value = "/logout.html")
    public String logout(HttpSession session,String flag) {
        session.invalidate();
        SecurityUtils.getSubject().logout();
        if("forumLogout".equals(flag)) {
            return "forumtopic/community";
        }else {
            return "redirect:/";
        }
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
                registerController.autoLogin(qcodeUser);
            }
            // 登录成功
            return "redirect:/QCode/index.html";
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
    private QcodeUser thirdLoginCheck(WechatUserInfoBean weChatUserInfo) {
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

}
