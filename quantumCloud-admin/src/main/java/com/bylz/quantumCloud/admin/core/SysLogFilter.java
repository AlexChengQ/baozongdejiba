package com.bylz.quantumCloud.admin.core;

import com.alibaba.fastjson.JSON;
import com.bylz.quantumCloud.model.SysLog;
import com.bylz.quantumCloud.model.SysUser;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;

/**
 * 用户操作日志拦截器
 * Created by lpt on 2017/5/9 0009.
 */
public class SysLogFilter implements Filter {
    protected Log logger = LogFactory.getLog(SysLogFilter.class);
    //用户操作日志队列
    public static Queue<SysLog> logs = new LinkedList<SysLog>();

    private String contextPath;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.debug("SysLogFilter--开始记录");
        this.contextPath = filterConfig.getServletContext().getContextPath();
        SaveLogThread t = new SaveLogThread();
        t.start();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest hrequest = (HttpServletRequest) servletRequest;
        //获取访问路径
        String path = hrequest.getServletPath();
        //访问参数
        String params = paramsToString(hrequest.getParameterMap());
        //获取当前用户
        SysUser user = AppContextHolder.getCurrentUser();
        //获取用户ip
        String ip = getIpAddr(hrequest);
        //获取客户端信息
        String agent = hrequest.getHeader("user-agent");
        /*logger.debug(path);
        logger.debug(params);
        logger.debug(agent);
        logger.debug(ip);*/
        SysLog log = new SysLog();
        log.setIp(ip);
        log.setOperation(path);
        log.setOperContent(params);
        log.setUserAgent(agent);
        if(user!=null){
            log.setUserId(user.getId()+"");
            log.setUsername(user.getUsername());
        }
        //时间格式化
        log.setOperDateString(DateFormatUtils.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
        //放入队列
        add(log);

        filterChain.doFilter(servletRequest,servletResponse);
    }

    @Override
    public void destroy() {

    }

    /**
     * 获取ip
     * @param request
     * @return
     */
    protected String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("http_client_ip");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        // 如果是多级代理，那么取第一个ip为客户ip
        if (ip != null && ip.indexOf(",") != -1) {
            ip = ip.substring(ip.lastIndexOf(",") + 1, ip.length()).trim();
        }
        return ip;
    }

    /**
     * 参数Map过滤密码并转成json且去掉双引号
     * @param parameterMap
     * @return
     */
    private String paramsToString(Map parameterMap){
        Map parameter = new HashMap(parameterMap);
        if(parameter==null || parameter.size()==0){
            return "";
        }
        //去掉密码参数
        if(parameter.containsKey("password")){
            parameter.remove("password");
        }
        //转成json
        String params = JSON.toJSONString(parameter);
        //去掉双引号
        params = params.replaceAll("\"","");
        return params;
    }

    /**
     * 增加一个
     * @param log
     */
    public void add(SysLog log){
        logs.add(log);
    }
}
