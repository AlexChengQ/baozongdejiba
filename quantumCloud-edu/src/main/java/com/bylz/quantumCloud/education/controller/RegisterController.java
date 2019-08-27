package com.bylz.quantumCloud.education.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.education.util.StringHelperTools;
import com.bylz.quantumCloud.education.util.sms.SmsValidatorHelper;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.EncryptionUtil;

/**
 * @author JT
 * @version 1.0
 * @since 2017-07-20
 */
@Controller
@RequestMapping("/Register")
public class RegisterController extends BaseController {
	@Autowired
	private QcodeUserService qcodeUserService;
	@Autowired
	private QcodeProjectService qcodeProjectService;
	@Autowired
	private QcodeProjectVersionService qcodeProjectVersionService;
	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private QcodeTaskService qcodeTaskService;
	/*@Autowired
	private TemplateSendEmail templateEmail;*/
	@Autowired
	private QcodeThirdLoginService qcodeThirdLoginService;

	@Autowired
	private UpdateUserScoreService updateUserScoreService;

	@Autowired
	private EduStatisticsService eduStatisticsService;
	/**
	 * 注册页面
	 * 
	 * @param request
	 * @param response
	 * @return 2017-7-20 JT
	 */
	@RequestMapping(value = "/register.html")
	public String register(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
		String forward = request.getParameter("forward");
		if(forward!=null&&!"".equals(forward)){
			model.put("forward", forward);
		}
		return "register";
	}

	/**
	 * 页面注册保存
	 * 
	 * @param request
	 * @return 2017-7-22 JT
	 * @throws MessagingException
	 */
	@RequestMapping(value = "/registerSave.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData registerSave(HttpServletRequest request)
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
			emailFilter.put("userName", email);
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

				EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
				if(eduStatisticsVo != null) {
					eduStatisticsVo.setRegistCount(eduStatisticsVo.getRegistCount()+1);
					eduStatisticsService.update(eduStatisticsVo);
				}else {
					QueryFilter filter = new QueryFilter();
					filter.put("registCount",1);
					filter.setStatementKey("addEduStatistics1");
					eduStatisticsService.save(filter);
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
	 * 第三方用户登录，页面注册保存
	 * 
	 * @param request
	 * @return 
	 * @throws MessagingException
	 *  2018/3/2 houdongdong
	 */
	@RequestMapping(value = "/thirdRegisterSave.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData thirdRegisterSave(HttpServletRequest request)
			throws MessagingException {
		try {
			// 数据获取
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String name = request.getParameter("nickname");
			String appId = request.getParameter("appId");
			
			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("userName", email);
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
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setEmail(email);
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setPwd(password);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(QcodeUser.DELETED_NO);
				qcodeUserAdd.setIsDisable(QcodeUser.IS_DISABLE_NO);
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
	 * 模拟登录
	 * */
	public void autoLogin(QcodeUser qcodeUser){
		UsernamePasswordToken token = new UsernamePasswordToken(qcodeUser.getEmail(),qcodeUser.getPwd());
		SecurityUtils.getSubject().login(token);
		SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
		int hasSignIn = updateUserScoreService.hasSignIn(qcodeUser.getId(),1);
		qcodeUser.setSignIn(hasSignIn);
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
	 * 邮箱验证
	 * 
	 * @param request
	 * @return 2017-7-20 JT
	 */
	@RequestMapping(value = "/checkEmail.html")
	public String checkEmail(ModelMap model, HttpServletRequest request) {
		Map map = new HashMap();
		String code = EncryptionUtil.authcode(request.getParameter("s"),
				"DECODE", "", 0);
		String[] str = code.split(":");
		if (str.length != 2) {
			map.put("type", "error");
			map.put("msg", getMessage("illegal_operation"));
			model.put("msg", map);
			return "login";
		}
		String email = str[0];
		String password = str[1];
		QueryFilter emailFilter = new QueryFilter();
		emailFilter.put("email", email);
		QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
				.getReturnObj();
		if (qcodeUser != null && qcodeUser.getPwd().equals(password)) {
			if (qcodeUser.getIsDisable() == 1) {
				qcodeUser.setIsDisable(0);
				qcodeUserService.update(qcodeUser);
				// 邮箱验证成功时初始化demo项目和默认项目
				initProject(qcodeUser.getId());
				map.put("type", "success");
				map.put("msg", getMessage("account_activation_successful_login"));
				model.put("msg", map);
				return "login";
			} else {
				map.put("type", "info");
				map.put("msg", getMessage("account_is_active_not_repeat"));
				model.put("msg", map);
				return "login";
			}
		} else {
			map.put("type", "error");
			map.put("msg", getMessage("illegal_operation"));
			model.put("msg", map);
			return "login";
		}
	}

	/**
	 * 初始化游客项目
	 * 
	 * @return 2017-7-20 JT
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	@RequestMapping(value = "/guest.html")
	public String guest()
			throws MessagingException {
		Date now1 = new Date(System.currentTimeMillis() - 1000);
		Date now2 = new Date(System.currentTimeMillis());
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
		filter.put("keyname", "ans2");
		SysConfig ans2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "ans3");
		SysConfig ans3 = sysConfigService.findOne(filter).getReturnObj();

		// 初始化demo2项目并创建第一个版本
		QcodeProject qcodeProjectDemo2 = new QcodeProject();
		qcodeProjectDemo2.setRepeat(100);
		qcodeProjectDemo2.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo2.setQubitNum(3);
		qcodeProjectDemo2.setClassicalbitNum(3);
		qcodeProjectDemo2.setCreateTime(now2);
		qcodeProjectDemo2.setName(getMessage("the_3_qubit_grover_search_algorithm"));
		qcodeProjectDemo2.setTaskTypeId(2);
		qcodeProjectDemo2.setUserId((long) 0);
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
		versionDemo2 = r4.getReturnObj();
		QcodeTask task2 = new QcodeTask();
		task2.setAns(ans3.getVal());
		task2.setClassicRegisterName("c");
		task2.setIsDel(0);
		task2.setStatus("3");
		task2.setRepeat(100);
		task2.setStartTime(new Date());
		task2.setTaskId("0");
		task2.setVersionId(versionDemo2.getId());
		task2.setEndTime(new Date());
		qcodeTaskService.save(task2);

		// 初始化demo1项目并创建第一个版本
		QcodeProject qcodeProjectDemo1 = new QcodeProject();
		qcodeProjectDemo1.setRepeat(100);
		qcodeProjectDemo1.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo1.setQubitNum(2);
		qcodeProjectDemo1.setClassicalbitNum(2);
		qcodeProjectDemo1.setCreateTime(now1);
		qcodeProjectDemo1.setName(getMessage("demonstration_of_two_qubit_dj_algorithm"));
		qcodeProjectDemo1.setTaskTypeId(2);
		qcodeProjectDemo1.setUserId((long) 0);
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
		versionDemo1 = r2.getReturnObj();
		QcodeTask task1 = new QcodeTask();
		task1.setAns(ans2.getVal());
		task1.setClassicRegisterName("c");
		task1.setIsDel(0);
		task1.setStatus("3");
		task1.setRepeat(100);
		task1.setStartTime(new Date());
		task1.setTaskId("0");
		task1.setVersionId(versionDemo1.getId());
		task1.setEndTime(new Date());
		qcodeTaskService.save(task1);

		return "redirect:/";
	}

	/**
	 * 初始化用户项目
	 * 
	 * @return 2017-7-20 JT
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	@RequestMapping(value = "/demo.html")
	public String demo()
			throws MessagingException {
		//查询所有已激活用户
		QueryFilter filter = new QueryFilter();
		filter.put("isDisable", 0);
		filter.put("deleted", 0);
		List<QcodeUser> qcodeUserList = qcodeUserService.findList(filter).getReturnObj();
		for(QcodeUser qcodeUser :qcodeUserList){
			initProject(qcodeUser.getId());
		}
		return "redirect:/";
	}
	
	/**
	 * 激活成功创建项目
	 * 
	 * @param id
	 * @2017-8-2下午1:55:07
	 * @JT
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void initProject(Long id) {

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

		//QcodeProjectVersion versionDefault = new QcodeProjectVersion();
		//versionDefault.setCode("");
		//versionDefault.setCreateTime(now3);
		//versionDefault.setIsDel(0);
		//versionDefault.setName("V1");
		//versionDefault.setPic("");
		//versionDefault.setProjectId(qcodeProjectDefault.getId());
		//versionDefault.setSvgXml("");
		//Result r6 = qcodeProjectVersionService.save(versionDefault);
		//if (!r6.isSuccess()) {
		//	logger.info("初始化默认项目版本出错：" + r6.getErrormsg());
		//}
	}


	/**
	 * 页面注册去除验证码
	 *
	 * @param request
	 * @return 2017-7-22 JT
	 * @throws MessagingException
	 */
	@RequestMapping(value = "/registerSaveRemoveCode.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData registerSaveRemoveCode(HttpServletRequest request)
			throws MessagingException {

		ResponseData responseData = new ResponseData(true);
		try {
			// 数据获取
			String email = request.getParameter("email");
			String name = createRandomQcodeUserName();
			String password = request.getParameter("password");
			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("userName", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
					.getReturnObj();

			if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
				return new ResponseData(false, getMessage("mailbox_has_been_registered"));
			}else {
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setEmail(email);
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setToken(apiKey);
				qcodeUserAdd.setPwd(password);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				qcodeUserAdd = result.getReturnObj();
				// 不进行邮箱验证 初始化demo项目和默认项目
				initProject(qcodeUserAdd.getId());
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}

				responseData.setObj(qcodeUserAdd);
				//templateEmail.sendTemplateMail(qcodeUserAdd);
			}
		} catch (DuplicateKeyException e) {
			Result result = new Result();
			if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
				result.addErrormsg(getMessage("id_repeat"));
			}
			return new ResponseData(false, result);
		}

		return responseData;
	}


	@RequestMapping("/checkCode.json")
	@ResponseBody
	public String checkCode(String code) {
		Session session = AppContextHolder.getSession();
		String sessionCode = session.getAttribute("registerValidateCode") != null
				? session.getAttribute("registerValidateCode").toString() : "";
		if (StringHelperTools.isBlank(code)) {
			return "1"; // 验证码为空
		} else if (!code.equalsIgnoreCase(sessionCode)) {
			return "2";// 验证码错误
		} else {
			return "3";
		}

	}


	/**
	 * 发送短信验证码
	 *
	 * @author liq
	 * @since 2016年3月4日
	 */
	@RequestMapping("/sendPhoneMsg.json")
	@ResponseBody
	public ResponseData sendPhoneMsg(String phone, String verCode) {
		Session session = AppContextHolder.getSession();
		ResponseData data = new ResponseData(true);
		String sessionCode = (String) session.getAttribute("registerValidateCode");
		if (StringHelperTools.isBlank(verCode)) {
			data.setCode(1);// 验证码为空
			data.setSuccess(false);
			return data;
		} else if (!verCode.equalsIgnoreCase(sessionCode)) {
			data.setCode(2);// 验证码错误
			data.setSuccess(false);
			return data;
		}
		// 发送短信验证码
		if (SmsValidatorHelper.sendMobileCaptcha(phone, 6)) {
			data.setCode(10000);
			data.setMessage("短信验证码发送成功！有效时间为20分钟！验证码：" + session.getAttribute("TEL_VALID_CODE"));
			session.removeAttribute("validateCode");
		} else {
			data.setCode(10002);
			data.setMessage("短信发送失败");
			data.setSuccess(false);
		}
		return data;
	}


	@RequestMapping("/checkIsExist.json")
	@ResponseBody
	public boolean checkIsExist(String phone) {
		QueryFilter filter = new QueryFilter();
		filter.put("phone",phone);
		boolean flag = qcodeUserService.checkIsExist(filter);
		return flag;
	}

	@RequestMapping("/registerSaveByPhone.json")
	@ResponseBody
	public ResponseData registerSaveByPhone(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		try {
			// 数据获取
			String phone = request.getParameter("phoneNumber");
//			String email = request.getParameter("email");
			String name = createRandomQcodeUserName();
			String password = request.getParameter("password");
			String randomString = (String) request.getSession().getAttribute("registerValidateCode");
			String code = request.getParameter("code");
			String phoneCode = request.getParameter("phonecode");
			if(!randomString.toLowerCase().equals(code.toLowerCase())){
				return new ResponseData(false,getMessage("check_verification_code"));
			}

			// 校验短信验证码
			if (StringHelperTools.isEmpty(phoneCode)) {
				data.setCode(10003);// 请输入短信验证码
				data.setMessage("请输入短信验证码");
				data.setSuccess(false);
				return data;
			}

			int num = SmsValidatorHelper.validateMobileCaptcha(phone, phoneCode);

			//验证码错误
			if (num == 1) {
				data.setCode(10004);
				data.setMessage("短信验证码不正确");
				data.setSuccess(false);
				return data;
			}

			// 验证码输入次数过多,请重新发送
			if (num == 2) {
				data.setCode(10005);
				data.setMessage("短信验证码输入次数过多");
				data.setSuccess(false);
				return data;
			}

			// 短信验证码已过期
			if (num == 3) {
				data.setCode(10006);
				data.setMessage("短信验证码已过期");
				data.setSuccess(false);
				return data;
			}

			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("tel",phone);
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
				qcodeUserAdd.setTel(phone);
				qcodeUserAdd.setEmail("");
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
}
