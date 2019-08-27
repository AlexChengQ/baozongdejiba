package com.bylz.quantumCloud.education.websocketserver;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import javax.security.auth.Subject;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/12
 */
public class MyFilterOfListenDog implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        if(!request.getServletPath().equals("/InspectHeart/inspect.json")) {
            Session session = AppContextHolder.getSession();
            if(session != null) {
                session.setAttribute("lastPostTime",System.currentTimeMillis());
                session.setAttribute("invalidTimer",3*1000*60L);
            }
        }

        filterChain.doFilter(servletRequest,servletResponse);
    }

    @Override
    public void destroy() {

    }
}
