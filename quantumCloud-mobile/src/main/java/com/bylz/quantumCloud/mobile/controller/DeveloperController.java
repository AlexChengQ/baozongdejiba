package com.bylz.quantumCloud.mobile.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 开发者 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/Developer")
public class DeveloperController extends BaseController{

	/**
	 * 开发者主页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/developer.html")
	public String developer(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/common/commingsoon";
	}

}
