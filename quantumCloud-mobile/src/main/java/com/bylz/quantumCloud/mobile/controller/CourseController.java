package com.bylz.quantumCloud.mobile.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 教程 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/Course")
public class CourseController extends BaseController{

	/**
	 * 教程主页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/library.html")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/library";
	}

	/**
	 * 欢迎页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/welcome.html")
	public String welcome(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/welcome";
	}
	
	/**
	 * 量子世界页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/world.html")
	public String world(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/world";
	}
	
	/**
	 * 量子力学页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/mechanics.html")
	public String mechanics(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/mechanics";
	}
	
	/**
	 * 量子计算原理页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/theory.html")
	public String theory(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/theory";
	}
	
	/**
	 * 量子算法页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/algorithm.html")
	public String algorithm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/algorithm";
	}
	
	
	
	@RequestMapping(value = "/videoLibrary.html")
	public String videoLibrary(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/course/videoLibrary";
	}
	
	
}
