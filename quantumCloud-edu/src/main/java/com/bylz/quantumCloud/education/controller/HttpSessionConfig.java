package com.bylz.quantumCloud.education.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/6/29
 */
public class HttpSessionConfig extends ServerEndpointConfig.Configurator {
    @Override
    public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response){
        Session session = SecurityUtils.getSubject().getSession();
        config.getUserProperties().put(Session.class.getName(),session);
    }
}
