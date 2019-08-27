package com.bylz.quantumCloud.mobile.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 游戏 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/Game")
public class GameController extends BaseController{

	/**
	 * 游戏页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/game.html")
	public String game(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/game/game";
	}
	
	/**
	 * 游戏点击后页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @JT
	 */
	@RequestMapping(value = "/afterClick.html")
	public String afterClick(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/game/afterClick";
	}
}
