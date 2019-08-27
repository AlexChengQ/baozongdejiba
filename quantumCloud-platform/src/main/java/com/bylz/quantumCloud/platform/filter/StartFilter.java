package com.bylz.quantumCloud.platform.filter;

import com.bylz.quantumCloud.platform.websocketserver.ChatServer;
import org.java_websocket.WebSocketImpl;

import javax.servlet.*;
import java.io.IOException;
import java.net.UnknownHostException;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:启动tomcat时运行此类
 * @since 2018/8/15
 */
public class StartFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.startWebsocketInstantMsg();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

    }

    @Override
    public void destroy() {

    }

    /**
     * 启动即时聊天服务
     */
    public void startWebsocketInstantMsg(){
        WebSocketImpl.DEBUG = false;
        ChatServer s;
        try {
            s = new ChatServer(Integer.parseInt("8887"));
            s.start();
            //System.out.println( "websocket服务器启动,端口" + s.getPort() );
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }
}
