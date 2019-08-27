package com.bylz.quantumCloud.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.SysUserService;

/**
 * @author lvliang
 * @version 1.0
 * @since 2017-03-20
 */
@Controller
public class LoginController extends BaseController {

	/**
	 * 管理员状态:启用
	 */
	private final static int LOGIN_STATUS = 1;
	
	private final static String ROLE_PREFIX = "ROLE:";

	@Autowired
	private SysUserService sysUserService;
	
    @Autowired
    private CacheManager cacheManager;

	@RequestMapping(value = "/login.html")
	public String login() {
		return "login";
	}

	/**
	 * 平台用户登录
	 * 
	 * @return ResponseData
	 */
	@RequestMapping(value = "/doLogin.json")
	@ResponseBody
	public ResponseData doLogin(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
			return new ResponseData(false, "账号信息不能为空");

		QueryFilter filter = new QueryFilter();
        filter.setStatementKey("login");
        filter.put("username", username);
        SysUser sysUser = sysUserService.findOne(filter).getReturnObj();

		if (null == sysUser)
			return new ResponseData(false, "账号信息不正确");

		String encodePassword = new Md5Hash(password).toHex();
		if (StringUtils.equals(encodePassword, sysUser.getPassword()) && sysUser.getStatus() == LOGIN_STATUS) {
			
			//清除缓存
			String permissionKey = ROLE_PREFIX+username;
            Cache cache=this.cacheManager.getCache("USER_ROLES");
            if(cache!=null){
                cache.evict("USER_ROLES");
            }
            if(cache.get(permissionKey)!=null){
            	cache.evict(permissionKey);
            }
			
			UsernamePasswordToken token = new UsernamePasswordToken(username,
					password);
			if (null!=request.getParameter("rememberMe") && !"".equals(request.getParameter("rememberMe"))){
				token.setRememberMe(true);
			}
			SecurityUtils.getSubject().login(token);
			SecurityUtils.getSubject().getSession()
					.setAttribute(AppContextHolder.USER_INFO, sysUser);

			return ResponseData.SUCCESS_NO_DATA;
		}
		return new ResponseData(false, "账号信息不正确");
	}

	/**
	 * 跳转首页
	 * @author lvliang
	 */
	@RequestMapping(value = "/index.html")
	public String index(HttpSession session) {
		return "/index";
	}

	/**
	 * 退出登录
	 * 
	 * @author lvliang
	 */
	@RequestMapping(value = "/logout.html")
	public String logout(HttpSession session) {
		session.invalidate();
		SecurityUtils.getSubject().logout();
		return "redirect:/";
	}
}
