//-------------------------------------------------------------------------
// Copyright (c) 2015-2017 HF-STAR-V. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// HF-STAR-V
//
//-------------------------------------------------------------------------

package com.bylz.quantumCloud.admin.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.web.filter.authc.AuthenticationFilter;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.bylz.quantumCloud.service.SysUserService;

/**
 * @author            liuxiantao
 * @version           1.0
 * @since             2016-8-2
 */

public class AutoLoginAuthenticationFilter extends AuthenticationFilter
{
    private Logger logger = LoggerFactory.getLogger(AutoLoginAuthenticationFilter.class);
    
    @Autowired
    private SysUserService sysUserService;
    
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
            throws Exception
    {
    	HttpServletRequest httpRequest = (HttpServletRequest)request;
    	
    	String tokenStr = httpRequest.getHeader("token");
    	if ( tokenStr != null) {
    	    
//    	        String[] usernamepassword = DecodeUtil.decrypt(tokenStr).split(",");
//    	        if (usernamepassword.length == 3)
//    	        {
//    	            try{
//    	            String username = usernamepassword[0];
//                    String password = usernamepassword[1];
//                   
//                    
//                    //根据登录名查询用户
//                    QueryFilter filter = new QueryFilter();
//                    filter.put("username", username);
//                    filter.put("status", 1);
//                    SysUser acMember = sysUserService.findOne(filter).getReturnObj();
//                    
//                    if (acMember != null && StringUtils.equals(password, acMember.getPassword())) {
//                        if(acMember.getUserType() != null && 
//                                (acMember.getUserType().intValue() == AcMember.USER_TYPE_KF.intValue() 
//                                || acMember.getUserType().intValue() == AcMember.USER_TYPE_SJ.intValue())){
//                            if (httpRequest.getHeader("sid") != null)
//                                httpRequest.setAttribute("sid", httpRequest.getHeader("sid"));
//                            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
//                            SecurityUtils.getSubject().login(token);
//                            SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, acMember);
//                        }
//                        return true;
//                    }
//                }catch(Exception e)
//                {
//                    e.printStackTrace();
//                } 
//	        }
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

