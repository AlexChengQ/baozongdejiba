//-------------------------------------------------------------------------
// Copyright (c) 2015-2017 HF-STAR-V. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// HF-STAR-V
//
//-------------------------------------------------------------------------

package com.bylz.quantumCloud.education.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.web.filter.authc.AuthenticationFilter;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.DecodeUtil;
import com.bylz.quantumCloud.service.QcodeUserService;

/**
 * @author            liuxiantao
 * @version           1.0
 * @since             2016-8-2
 */

public class AutoLoginAuthenticationFilter extends AuthenticationFilter
{
    private Logger logger = LoggerFactory.getLogger(AutoLoginAuthenticationFilter.class);
    
    @Autowired
    private QcodeUserService qCodeUserService;
    
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
            throws Exception
    {
    	HttpServletRequest httpRequest = (HttpServletRequest)request;
    	String tokenStr = httpRequest.getParameter("token");
    	if ( tokenStr != null) {
    	    
    	        String[] usernamepassword = DecodeUtil.decrypt(tokenStr).split(",");
    	        if (usernamepassword.length >= 2)
    	        {
    	            try{
    	            String email = usernamepassword[0];
                    String password = usernamepassword[1];
                    
                    //根据登录名查询用户
                    QueryFilter filter = new QueryFilter();
                    filter.put("email", email);
                    filter.put("is_disable", QcodeUser.IS_DISABLE_NO);
                    filter.put("deleted",QcodeUser.DELETED_NO);
                    QcodeUser user = qCodeUserService.findOne(filter).getReturnObj();
                    
                    if (user != null && StringUtils.equals(password, user.getPwd())) {
                        if (httpRequest.getHeader("sid") != null)
                            httpRequest.setAttribute("sid", httpRequest.getHeader("sid"));
                        UsernamePasswordToken token = new UsernamePasswordToken(email, password);
                        SecurityUtils.getSubject().login(token);
                        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, user);
                        return true;
                    }
                }catch(Exception e)
                {
                    e.printStackTrace();
                } 
	        }
    	}
        return true;
    }
    

    @Override
    protected boolean isAccessAllowed(ServletRequest request,
            ServletResponse response, Object mappedValue)
    {
        HttpServletRequest httpRequest = ((HttpServletRequest)request);
        HttpServletResponse httpResponse = (HttpServletResponse)response;
        String sid = httpRequest.getHeader("sid");
        Object principal = SecurityUtils.getSubject().getPrincipal();
        logger.debug(httpRequest.getRequestURI());
        logger.debug(sid);
        if (principal != null)
            logger.debug("principal="+principal);
            
        if (sid != null) {
            SimpleCookie simpleCookie = new SimpleCookie();
            simpleCookie.setHttpOnly(true);
            simpleCookie.setPath(httpRequest.getContextPath());
            simpleCookie.setName("sid");
            simpleCookie.setMaxAge(-1);
            simpleCookie.setValue(sid);
            simpleCookie.saveTo(httpRequest, httpResponse);
        }
        
        return super.isAccessAllowed(request, response, mappedValue);
    }


}

