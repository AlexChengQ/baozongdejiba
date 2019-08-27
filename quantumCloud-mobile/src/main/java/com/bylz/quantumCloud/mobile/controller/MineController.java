package com.bylz.quantumCloud.mobile.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.model.QcodeProject;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.service.QcodeUserService;

/**
 * 我的 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/Mine")
public class MineController extends BaseController{
	
	@Autowired
	private QcodeUserService qcodeUserService;
	@Autowired
	private QcodeProjectService qcodeProjectService;
	/**
	 * 我的页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/mine.html")
	public String mine(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
    	//获取当前登陆用户
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	if (qcodeUser != null){
    		QueryFilter filter = new QueryFilter();
    		filter.put("userId", qcodeUser.getId());
    		filter.put("isDel", 0);
    		filter.setStatementKey("selectList_count");
            model.put("count", qcodeProjectService.findOne(filter).getReturnObj());  
    	}
		return "/mine/mine";
	}
	
	/**
	 * 我的项目页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/myProject.html")
	public String myProject(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
		if (qcodeUser != null) {
			QueryFilter filter = new QueryFilter(request);
			filter.put("userId", qcodeUser.getId());
			filter.put("isDel", 0);
			filter.setLimit(8);
			filter.put("order", "create_time desc");
			model.put("pager", qcodeProjectService.findPager(filter).getReturnObj());
		}
		return "/mine/myProject";
	}
	 /**
     * 获取用户所有项目
     * @param model
     * @param request
     * @return
     * @2017-7-25下午8:38:26
     * @JT
     */
	@RequestMapping(value = "/myProject.json")
	@ResponseBody
	public ResponseData project(ModelMap model, HttpServletRequest request) {
		//获取用户
		QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
		QueryFilter filter = new QueryFilter(request);
		filter.put("userId", qcodeUser.getId());
		filter.put("isDel", 0);
		filter.setLimit(8);
		filter.put("order", "create_time desc");
		ResponseData data = new ResponseData(true);

		data.setObj(qcodeProjectService.findPager(filter).getReturnObj());
		return data;
	}
    
    
    /**
     * 删除项目
     * @param request
     * @param response
     * @return
     * @2017-8-2上午10:34:41
     * @JT
     */
	@RequestMapping(value = "/delProject.json")
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData delProject(HttpServletRequest request, HttpServletResponse response) {
		// 获取当前登陆用户
		QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
		if (qcodeUser == null) {
			return new ResponseData(false, getMessage("user_not_logged_in"));
		}
		QueryFilter filter = new QueryFilter(request);
		QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
		if (qcodeProject == null) {
			return new ResponseData(false, getMessage("task_does_not_exist"));
		}
		qcodeProject.setIsDel(1);
		Result result = qcodeProjectService.update(qcodeProject);
		if (!result.isSuccess()) {
			return new ResponseData(false, result.getErrormsg());
		}
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	
	
	/**
	 * 修改密码页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/changePsd.html")
	public String changePsd(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/mine/changePsd";
	}
	
	/**
	 * 修改密码
	 */
	@RequestMapping(value="/changePsd.json",method=RequestMethod.POST)
	@ResponseBody
	public ResponseData changePassword(ModelMap model , HttpServletRequest request ){
		//获取用户
		QcodeUser user = AppContextHolder.getCurrentUser();
		if(user==null){
			return new ResponseData(false, "用户不存在");
		}
		//获取用户密码
		String pwd = user.getPwd();
		//数据获取
		String oldPsd = request.getParameter("oldPsd");
		String password = request.getParameter("password");
		if(oldPsd==null || "".equals(oldPsd)){
			return new ResponseData(false, getMessage("enter_old_password"));
		}else{
			if(!oldPsd.equals(pwd)){
				return new ResponseData(false, getMessage("old_password_input_error"));
			}
		}
		if(password==null || "".equals(password)){
			return new ResponseData(false,getMessage("enter_modify_password"));
		}

		user.setPwd(password);
		qcodeUserService.update(user);

		return ResponseData.SUCCESS_NO_DATA;
	}
	
	/**
	 * 超导量子计算机
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/superQuantumComputer.html")
	public String superQuantumComputer(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/mine/superQuantumComputer";
	}
	
	/**
	 * 半导体量子计算机
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/semiQuantumComputer.html")
	public String semiQuantumComputer(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/mine/semiQuantumComputer";
	}
}
