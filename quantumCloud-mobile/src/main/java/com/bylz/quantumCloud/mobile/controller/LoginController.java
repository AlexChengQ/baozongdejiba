package com.bylz.quantumCloud.mobile.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeProject;
import com.bylz.quantumCloud.model.QcodeProjectVersion;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.QcodeThirdLogin;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.service.QcodeProjectVersionService;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.QcodeThirdLoginService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.SysConfigService;

/**
 * @author JiangTao
 * @version 1.0
 * @since 2017-03-20
 */
@Controller
public class LoginController extends BaseController
{

    @Autowired
    private QcodeUserService qcodeUserService;
    @Autowired
    private SessionDAO sessionDAO;
    @Autowired
    private QcodeTaskService qcodeTaskService;    

	@Autowired
	private QcodeProjectService qcodeProjectService;
	@Autowired
	private QcodeProjectVersionService qcodeProjectVersionService;
	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private QcodeThirdLoginService qcodeThirdLoginService;
	
    
	/**
	 * 平台用户登录
	 * 
	 * @return ResponseData
	 */
	@RequestMapping(value = "/doLogin.json")
	@ResponseBody
	public ResponseData doLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		boolean isThird = BooleanUtils.toBoolean(request.getParameter("isThird"));
    	
        if (isThird) {
            return thirdLogin(request);
        }
		
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(password))
            return new ResponseData(false, "账号信息不能为空");
        
        QcodeUser qcodeUser= getMember(email);
        
        if (null == qcodeUser)
            return new ResponseData(false, "账号信息不正确");

//        String encodePassword = new Md5Hash(password).toHex();
        if (StringUtils.equals(password, qcodeUser.getPwd())){
        	//第三方用户与量子用户绑定
			ResponseData bindQcodeUserResult = bindQcodeUser(request,qcodeUser);
			if(bindQcodeUserResult != null)
				return bindQcodeUserResult;
        	return login(qcodeUser,request);
        }
        return new ResponseData(false, "账号信息不正确");
        
	}

	/**
	 * 第三方与量子用户绑定
	 * */
	private ResponseData bindQcodeUser(HttpServletRequest request,QcodeUser qcodeUser ){
		String appId  = request.getParameter("appId");
		if (!StringUtils.isEmpty(appId)){
			String email = request.getParameter("email");
			Integer appType  =  Integer.valueOf(request.getParameter("appType"));
//			if(qcodeThirdLoginService.isExistingThirdAppAccount(appId, appType)){
//				return new ResponseData(false,getMessage("thirdApp_is_binded"));
//			}
			if(qcodeThirdLoginService.isbinded(email, appType)){
				return new ResponseData(false,getMessage("quantum_is_binded"));
			}
			qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUser.getId());
		}
		return  null;
	}
	
    /**
     * 注册页面
     * @param request
     * @param response
     * @return
     * 2017-6-30
     * JT
     */
    @RequestMapping(value = "/register.html")
	public String register( HttpServletRequest request, HttpServletResponse response) {
		return "/register";
	}
    
    /**
	 * 页面注册保存
	 * 
	 * @param model
	 * @param request
	 * @return 2017-7-22 JT
	 * @throws MessagingException
	 */
	@RequestMapping(value = "/registerSave.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData registerSave(ModelMap model, HttpServletRequest request)
			throws MessagingException {
		try {
			// 数据获取
			String email = request.getParameter("email");
			String name = createRandomQcodeUserName();
			String password = request.getParameter("password");
            String randomString = (String) request.getSession().getAttribute("registerValidateCode");
            String code = request.getParameter("code");
            if(!randomString.toLowerCase().equals(code.toLowerCase())){
            	return new ResponseData(false,getMessage("check_verification_code"));
            }
			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("email", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
					.getReturnObj();
			if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
				return new ResponseData(false, getMessage("mailbox_has_been_registered"));
			}/* else if (qcodeUser != null && qcodeUser.getIsDisable() == 1) {
				// 已注册未激活的账号重新注册
				qcodeUser.setName(name);
				qcodeUser.setOrgName(orgName);
				qcodeUser.setPwd(password);
				qcodeUser.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				qcodeUser.setRegisterTime(new Date());
				result = qcodeUserService.update(qcodeUser);
				// 不进行邮箱验证 初始化demo项目和默认项目
				initProject(qcodeUser.getId());
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}
				//templateEmail.sendTemplateMail(qcodeUser);
			} */else {
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setEmail(email);
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setPwd(password);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				qcodeUserAdd = result.getReturnObj();
				// 不进行邮箱验证 初始化demo项目和默认项目
				initProject(qcodeUserAdd.getId());
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}
				//templateEmail.sendTemplateMail(qcodeUserAdd);
			}
		} catch (DuplicateKeyException e) {
			Result result = new Result();
			if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
				result.addErrormsg(getMessage("id_repeat"));
			}
			return new ResponseData(false, result);
		} /*catch (UnsupportedEncodingException e) {
			logger.error(getMessage("sender_mistake"));
			e.printStackTrace();
		}*/

		return ResponseData.SUCCESS_NO_DATA;
	}
	
	 /**
		 * 第三方登录，页面注册保存
		 * 
		 * @param model
		 * @param request
		 * @return
		 * @author houdongdong
		 * @throws MessagingException
		 */
		@RequestMapping(value = "/thirdRegisterSave.json", method = RequestMethod.POST)
		@ResponseBody
		@Transactional(propagation = Propagation.REQUIRED)
		public ResponseData thirdRegisterSave(ModelMap model, HttpServletRequest request)
				throws MessagingException {
			try {
				// 数据获取
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String name = request.getParameter("name");
				if(StringUtils.isEmpty(name)){
					name = createRandomQcodeUserName();
				}
				String appId = request.getParameter("appId");
				Result result = new Result();

				QueryFilter emailFilter = new QueryFilter();
				emailFilter.put("email", email);
				QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
						.getReturnObj();
				if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
					return new ResponseData(false, getMessage("mailbox_has_been_registered"));
				}/* else if (qcodeUser != null && qcodeUser.getIsDisable() == 1) {
					// 已注册未激活的账号重新注册
					qcodeUser.setName(name);
					qcodeUser.setOrgName(orgName);
					qcodeUser.setPwd(password);
					qcodeUser.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
					qcodeUser.setRegisterTime(new Date());
					result = qcodeUserService.update(qcodeUser);
					// 不进行邮箱验证 初始化demo项目和默认项目
					initProject(qcodeUser.getId());
					if (!result.isSuccess()) {
						return new ResponseData(false, result.getErrormsg());
					}
					//templateEmail.sendTemplateMail(qcodeUser);
				} */else {
					String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
					QcodeUser qcodeUserAdd = new QcodeUser();
					qcodeUserAdd.setEmail(email);
					qcodeUserAdd.setName(name);
					qcodeUserAdd.setPwd(password);
					qcodeUserAdd.setRegisterTime(new Date());
					qcodeUserAdd.setDeleted(QcodeUser.DELETED_NO);
					qcodeUserAdd.setIsDisable(QcodeUser.IS_DISABLE_NO);
					qcodeUserAdd.setApiKey(apiKey);
					qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
					result = qcodeUserService.save(qcodeUserAdd);
					qcodeUserAdd = result.getReturnObj();
					// 不进行邮箱验证 初始化demo项目和默认项目
					initProject(qcodeUserAdd.getId());
					if (!result.isSuccess()) {
						return new ResponseData(false, result.getErrormsg());
					}
					//templateEmail.sendTemplateMail(qcodeUserAdd);
					if(qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUserAdd.getId())){
						autoLogin(qcodeUserAdd);
					}
				}
			} catch (DuplicateKeyException e) {
				Result result = new Result();
				if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
					result.addErrormsg(getMessage("id_repeat"));
				}
				return new ResponseData(false, result);
			} /*catch (UnsupportedEncodingException e) {
				logger.error(getMessage("sender_mistake"));
				e.printStackTrace();
			}*/

			return ResponseData.SUCCESS_NO_DATA;
		}
	
    /**
     * 第三方登录注册页面
     * @param request
     * @param response
     * @return
     * 2017-6-30
     * JT
     */
    @RequestMapping(value = "/thirdRegisterSave.html")
	public String thirdRegisterSave(HttpServletRequest request ,ModelMap model) {
    	String name = request.getParameter("name");  
    	if(StringUtils.isEmpty(name) || "undefined".equals(name)){ //对name不是第三方应用用户名称  的处理
    		name = createRandomQcodeUserName();
    	}
    	model.put("name", name);
    	return "thirdBindUser";
	}
	
    /**
     * 生成随机用户名称
     * */
    private String createRandomQcodeUserName(){
    	Random random = new Random();
		String randomNum = new StringBuffer().append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).toString();
		return new StringBuffer("U").append(randomNum).toString();
    }
	
	 /**
     * 第三方登录
     * @return
     */
	@Transactional(propagation = Propagation.REQUIRED)
    private ResponseData thirdLogin(HttpServletRequest request) {

        String appId = request.getParameter("unionid");
        String appType = request.getParameter("appType");
        String face = request.getParameter("icon");
        String nickname = request.getParameter("name");
        
        QueryFilter filter = new QueryFilter();
        filter.put("appId",appId);
        QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();
        
    	QcodeUser qcodeUser = null;
        //第一次登录
        if (null == qcodeThirdLogin) {
			if (NumberUtils.isNumber(appType)) {
				qcodeThirdLogin = new QcodeThirdLogin();
                qcodeThirdLogin.setAppId(appId);
                qcodeThirdLogin.setAppType(Integer.valueOf(appType));
                qcodeThirdLogin.setFace(face);
                qcodeThirdLogin.setNickname(nickname);
                Result result = qcodeThirdLoginService.save(qcodeThirdLogin);
                if (!result.isSuccess()) {
                	logger.info("第三方登录时创建第三方记录失败");
        		}
            }
			ResponseData responseData =	new ResponseData(false, "登录失败，请重试");
			Map<String, String> thirdUserInfo = new HashMap<>();
			thirdUserInfo.put("appId", appId);
			thirdUserInfo.put("name", nickname);
			responseData.setObj(thirdUserInfo);
			responseData.setCode(303);
			return responseData;
        }
        //之前登录过
        else {
            //没有绑定用户
            if (null == qcodeThirdLogin.getUserId()) {
            	ResponseData responseData =	new ResponseData(false, "登录失败，请重试");
            	Map<String, String> thirdUserInfo = new HashMap<>();
    			thirdUserInfo.put("appId", appId);
    			thirdUserInfo.put("name", nickname);
    			responseData.setObj(thirdUserInfo);
            	responseData.setCode(303);
    			return responseData;
            }
            //已绑定用户
            else {
            	filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
            	qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
            	if(qcodeUser == null){ //查找量子用户失败
            		logger.info("第三方登录时查找量子用户失败,请检查第三方账户与量子用户的绑定关系是否正常，量子用户Id为"+qcodeThirdLogin.getUserId());
            		return new ResponseData(false, "登录失败，请重试");
				}
            }
            //更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
            //没有绑定用户 第三方 微信头像，名称改变
        	if(null == qcodeThirdLogin.getUserId() || ( !face.equals(qcodeThirdLogin.getFace()))  || (!nickname.equals(qcodeThirdLogin.getNickname()))){
        		qcodeThirdLogin.setFace(face);
        		qcodeThirdLogin.setNickname(nickname);
        		qcodeThirdLogin.setUserId(qcodeUser.getId());
        		qcodeThirdLoginService.update(qcodeThirdLogin);
        	}
        }
        
        return login(qcodeUser,request);
    }
	/**
	 * 模拟登录
	 * */
	private void autoLogin(QcodeUser qcodeUser){
		UsernamePasswordToken token = new UsernamePasswordToken(qcodeUser.getEmail(),qcodeUser.getPwd());
		SecurityUtils.getSubject().login(token);
		SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
	}
	
	/**
	 * 激活成功创建项目
	 * 
	 * @param id
	 * @2017-8-2下午1:55:07
	 * @JT
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	private void initProject(Long id) {

		Date now1 = new Date(System.currentTimeMillis() - 1000);
		Date now2 = new Date(System.currentTimeMillis());
		Date now3 = new Date(System.currentTimeMillis() + 1000);
		// 获取初始化数据
		QueryFilter filter = new QueryFilter();
		filter.put("keyname", "demo1");
		SysConfig sysConfig1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "demo2");
		SysConfig sysConfig2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "code1");
		SysConfig code1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "code2");
		SysConfig code2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_name_1");
		SysConfig demoName1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_name_2");
		SysConfig demoName2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_desc_1");
		SysConfig demoDesc1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_desc_2");
		SysConfig demoDesc2 = sysConfigService.findOne(filter).getReturnObj();

		// 初始化demo1项目并创建第一个版本
		QcodeProject qcodeProjectDemo1 = new QcodeProject();
		qcodeProjectDemo1.setRepeat(100);
		qcodeProjectDemo1.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo1.setQubitNum(2);
		qcodeProjectDemo1.setClassicalbitNum(2);
		qcodeProjectDemo1.setCreateTime(now1);
		qcodeProjectDemo1.setName(getMessage("demonstration_of_two_qubit_dj_algorithm"));
		qcodeProjectDemo1.setTaskTypeId(1);
		qcodeProjectDemo1.setUserId(id);
		qcodeProjectDemo1.setNameEnglish(demoName1.getVal());
		qcodeProjectDemo1.setDescEnglish(demoDesc1.getVal());
		qcodeProjectDemo1
				.setDesc(getMessage("qcode_demo1_desc"));
		qcodeProjectDemo1.setIsDel(0);
		qcodeProjectDemo1.setPic("uploadFile/demo2.jpg");
		Result r1 = qcodeProjectService.save(qcodeProjectDemo1);
		if (!r1.isSuccess()) {
			logger.info("初始化demo项目出错：" + r1.getErrormsg());
		}
		qcodeProjectDemo1 = r1.getReturnObj();
		QcodeProjectVersion versionDemo1 = new QcodeProjectVersion();
		versionDemo1.setCode(code1.getVal());
		versionDemo1.setCreateTime(now1);
		versionDemo1.setIsDel(0);
		versionDemo1.setName("V1");
		versionDemo1.setPic("uploadFile/demo2.jpg");
		versionDemo1.setProjectId(qcodeProjectDemo1.getId());
		versionDemo1.setSvgXml(sysConfig1.getVal());
		Result r2 = qcodeProjectVersionService.save(versionDemo1);
		if (!r2.isSuccess()) {
			logger.info("初始化demo项目版本出错：" + r2.getErrormsg());
		}

		// 初始化demo2项目并创建第一个版本
		QcodeProject qcodeProjectDemo2 = new QcodeProject();
		qcodeProjectDemo2.setRepeat(100);
		qcodeProjectDemo2.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo2.setQubitNum(3);
		qcodeProjectDemo2.setClassicalbitNum(3);
		qcodeProjectDemo2.setCreateTime(now2);
		qcodeProjectDemo2.setName(getMessage("the_3_qubit_grover_search_algorithm"));
		qcodeProjectDemo2.setTaskTypeId(1);
		qcodeProjectDemo2.setUserId(id);
		qcodeProjectDemo2.setNameEnglish(demoName2.getVal());
		qcodeProjectDemo2.setDescEnglish(demoDesc2.getVal());
		qcodeProjectDemo2
				.setDesc(getMessage("qcode_demo2_desc"));
		qcodeProjectDemo2.setIsDel(0);
		qcodeProjectDemo2.setPic("uploadFile/demo1.jpg");
		Result r3 = qcodeProjectService.save(qcodeProjectDemo2);
		if (!r3.isSuccess()) {
			logger.info("初始化demo2项目出错：" + r3.getErrormsg());
		}
		qcodeProjectDemo2 = r3.getReturnObj();
		QcodeProjectVersion versionDemo2 = new QcodeProjectVersion();
		versionDemo2.setCode(code2.getVal());
		versionDemo2.setCreateTime(now2);
		versionDemo2.setIsDel(0);
		versionDemo2.setName("V1");
		versionDemo2.setPic("uploadFile/demo1.jpg");
		versionDemo2.setProjectId(qcodeProjectDemo2.getId());
		versionDemo2.setSvgXml(sysConfig2.getVal());
		Result r4 = qcodeProjectVersionService.save(versionDemo2);
		if (!r4.isSuccess()) {
			logger.info("初始化demo2项目版本出错：" + r4.getErrormsg());
		}

		// 初始化默认工作项目
		QcodeProject qcodeProjectDefault = new QcodeProject();
		qcodeProjectDefault.setRepeat(100);
		qcodeProjectDefault.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDefault.setQubitNum(6);
		qcodeProjectDefault.setClassicalbitNum(6);
		qcodeProjectDefault.setCreateTime(now3);
		SimpleDateFormat d1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat d2 = new SimpleDateFormat("HHmmss");
		String name = d1.format(now3) + "_" + d2.format(now3) + "_QEmulator";
		qcodeProjectDefault.setName(name);
		qcodeProjectDefault.setTaskTypeId(1);
		qcodeProjectDefault.setUserId(id);
		qcodeProjectDefault.setIsDel(0);
		Result r5 = qcodeProjectService.save(qcodeProjectDefault);
		if (!r5.isSuccess()) {
			logger.info("初始化默认工作项目出错：" + r5.getErrormsg());
		}
		qcodeProjectDefault = r5.getReturnObj();

		QcodeProjectVersion versionDefault = new QcodeProjectVersion();
		versionDefault.setCode("");
		versionDefault.setCreateTime(now3);
		versionDefault.setIsDel(0);
		versionDefault.setName("V1");
		versionDefault.setPic("");
		versionDefault.setProjectId(qcodeProjectDefault.getId());
		versionDefault.setSvgXml("");
		Result r6 = qcodeProjectVersionService.save(versionDefault);
		if (!r6.isSuccess()) {
			logger.info("初始化默认项目版本出错：" + r6.getErrormsg());
		}
	}



    
    
    @RequestMapping(value = "/loginOut.json")
    @ResponseBody
    public ResponseData loginOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	logger.debug("===============loginOut=============");
    	SecurityUtils.getSubject().getSession().removeAttribute(AppContextHolder.USER_INFO);
    	 SecurityUtils.getSubject().logout();
    	 logger.debug("===============loginOut success=============");
    	return new ResponseData(true,"退出成功");
    }
   

    private QcodeUser getMember(String email) {
        QueryFilter filter = new QueryFilter();
        filter.put("email", email);
        return qcodeUserService.findOne(filter).getReturnObj();
    }
    
    /**
     * shiro 登录操作
     * 
     * 调用前请做member是否为null操作
     * 该私有方法没有验证，避免重复。
     * 如果调用前未做验证，有可能throw nullpointerexception
     * 
     * @param member
     * @return
     */
    private ResponseData login(QcodeUser qcodeUser,HttpServletRequest request) {
		
    	HttpServletRequest httpRequest = (HttpServletRequest)request;
    	
    	Subject subject = SecurityUtils.getSubject();
    	if (subject != null)
    	{
    	    subject.logout();
    	}
    	
    	String tokenStr = qcodeUser.getEmail()+"-"+UUID.randomUUID().toString().substring(12);
        httpRequest.setAttribute("sid", tokenStr);       
        System.out.println(tokenStr.length());
        
        //更新登录用户TOKEN字段
        qcodeUser.setToken(tokenStr);
        
        qcodeUserService.update(qcodeUser);
        
        // 密码修改成功自动登录，session中存放用户信息。登录跳转在android、ios端处理
        UsernamePasswordToken token = new UsernamePasswordToken(qcodeUser.getEmail(), qcodeUser.getPwd());
        SecurityUtils.getSubject().login(token);

        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.TOKEN_STR, tokenStr);
        ResponseData data = new ResponseData(true);
        
        data.setObj(tokenStr);
        
        	//查询用户运行中任务当前状态并同步
      		  QueryFilter filter = new QueryFilter();
              filter.put("status", 0);
              filter.put("userId", qcodeUser.getId());
              filter.setStatementKey("getRunningTask");
              List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
              for(int i=0;i<taskList.size();i++){
              	QcodeTask task = taskList.get(i);
              	HashMap paramAns = new HashMap();
              	paramAns.put("task_id", task.getTaskId());
              	
              	String s2 = qcodeTaskService.queryTask(paramAns);
              	JSONObject json = JSONObject.parseObject(s2);
              	if(json.size()==0){
              		logger.debug("登陆时同步task请求接口失败，http返回空",task.getTaskId());
              	}
              	//任务id
              	String task_id = (String) json.get("taskid");
              	//任务状态
              	String tasksta = (String) json.get("tasksta");
              	switch(tasksta){
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
              		if(ans!=null&&!("".equals(ans))){
              			//有结果且正确
              			task.setStatus(QcodeTask.STATUS_RESULT);
              			task.setAns(ans.toString());
              		}else{
              			//有结果为空，语法错误
              			task.setStatus(QcodeTask.STATUS_ERROR);
              		}
              		
              	    break;  
              	default:
              	    break;
              	}
                  Result result = qcodeTaskService.save(task);
                  if (!result.isSuccess()) {
                  	logger.debug("登陆时同步task，更新task出错",task.getTaskId());
                  } 
              }
        return data;

    }
    
    
    /**
     * 判断用户是否登录
     * @param member
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/checkLogin")
    public ResponseData checkLogin(HttpServletRequest request) {
    	ResponseData data = new ResponseData(true);
    	try {
    		SysUser member=AppContextHolder.getCurrentUser();
    		if(member==null){
    			data.setSuccess(false);
    			data.setCode(401);
    			data.setMessage("/login.html");
    			return data;
    		}
		} catch (Exception e) {
		}
		return data;
    }
    
	/**
	 * 登陆页面
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-30上午11:39:30
	 * @JT
	 */
	@RequestMapping(value = "/login.html")
	public String login( HttpServletRequest request, HttpServletResponse response) {
		//return "login";
		return "/login";
	}
	
	/**
	 * 退出登录
	 * 
	 * @author JT
	 */
	@RequestMapping(value = "/logout.html")
	public String logout(HttpSession session) {
		session.invalidate();
		SecurityUtils.getSubject().logout();
		return "/login";
	}
    
}

