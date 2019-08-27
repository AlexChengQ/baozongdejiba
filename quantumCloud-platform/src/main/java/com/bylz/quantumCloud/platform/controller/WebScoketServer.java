package com.bylz.quantumCloud.platform.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/6/28
 */
@ServerEndpoint(value = "/webSocket",configurator = HttpSessionConfig.class)
public class WebScoketServer {

    private static int count; //不在线时数量静态变量。
    private Session session;
    private org.apache.shiro.session.Session shiroSession;
    private static CopyOnWriteArraySet<WebScoketServer> webSocketSet = new CopyOnWriteArraySet<WebScoketServer>();
    private static Map routetab = new HashMap<>();  //用户名和websocket的session绑定的路由表
    private Long userId;      //用户Id
    private static List list = new ArrayList<>();   //在线列表,记录用户
    ForumTopicService forumTopicService = (ForumTopicService) ContextLoader.getCurrentWebApplicationContext().getBean("forumTopicService");

    /**
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session,EndpointConfig config) throws IOException {
        this.session = session;
        shiroSession = (org.apache.shiro.session.Session) config.getUserProperties().get(org.apache.shiro.session.Session.class.getName());
        QcodeUser qcodeUser = (QcodeUser) shiroSession.getAttribute("USER_INFO");
        this.userId = qcodeUser.getId();
        list.add(userId);
        routetab.put(userId,session);
        webSocketSet.add(this);
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        count = forumTopicService.getNotOnlineCount(filter);//查询不在线时的关注，收藏等数量
        singleSend(count+"",(Session) routetab.get(userId));
    }

    /**
     * 接收客户端的message,判断是否有接收人而选择进行广播还是指定发送
     * @param _message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String _message) {
        JSONObject chat = JSON.parseObject(_message);
        JSONObject message = JSON.parseObject(chat.get("message").toString());
        String opType = message.get("opType").toString();
        Long userId = Long.valueOf(message.get("userId").toString());
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        filter.put("opType",opType);
        forumTopicService.addNotOnlineData(filter);//点击时插入不在线表
        count = forumTopicService.getNotOnlineCount(filter);//查询不在线时的关注，收藏等数量
        singleSend(count+"",(Session) routetab.get(userId));
    }

    @OnError
    public void onError(Throwable t) {
        //以下代码省略...
    }

    @OnClose
    public void onClose(Session session, CloseReason reason) {
        webSocketSet.remove(this);
        list.remove(userId);        //从在线列表移除这个用户
        routetab.remove(userId);
    }

    /**
     * 广播消息
     * @param message
     */
    public void broadcast(String message){
        for(WebScoketServer chat: webSocketSet){
            try {
                chat.session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
                continue;
            }
        }
    }

    /**
     * 对特定用户发送消息
     * @param message
     * @param session
     */
    public void singleSend(String message, Session session){
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 组装返回给前台的消息
     * @param message   交互信息
     * @param type      信息类型
     * @return
     */
    public String getMessage(String message, String type){
        JSONObject member = new JSONObject();
        member.put("message", message);
        member.put("type", type);
        return member.toString();
    }
}

