//-------------------------------------------------------------------------
// Copyright (c) 2015-2017 HF-STAR-V. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// HF-STAR-V
//
//-------------------------------------------------------------------------

package com.bylz.quantumCloud.mobile.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.web.filter.authc.AuthenticationFilter;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;

/**
 * @author            JT
 * @version           1.0
 * @since             2016-8-2
 */

public class AutoLoginAuthenticationFilter extends AuthenticationFilter
{
    private Logger logger = LoggerFactory.getLogger(AutoLoginAuthenticationFilter.class);
    @Autowired
    private QcodeUserService qcodeUserService;
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
            throws Exception
    {
    	HttpServletRequest httpRequest = (HttpServletRequest)request;
    	String tokenStr = (String) httpRequest.getAttribute("token");
    	logger.debug(tokenStr);
    	if ( tokenStr != null) {
            //根据登录名查询用户
            QueryFilter filter = new QueryFilter();
            filter.put("token", tokenStr);
            QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
            
            if (qcodeUser != null) {
                httpRequest.setAttribute("sid", tokenStr);
                UsernamePasswordToken token = new UsernamePasswordToken(qcodeUser.getEmail(), qcodeUser.getPwd());
                SecurityUtils.getSubject().login(token);
                SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
                SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.TOKEN_STR, tokenStr);
                return true;
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
        
        logger.debug(httpRequest.getRequestURI());
        logger.debug(sid);
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

