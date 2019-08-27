package com.bylz.quantumCloud.platform.websocketserver;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;
import org.springframework.web.context.ContextLoader;

import javax.websocket.Session;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/8/15
 */
public class ChatServer extends WebSocketServer {

    private static int countSelf; //不在线时数量静态变量。(自己)
    private static int countToUser; //不在线时数量静态变量。
    ForumTopicService forumTopicService = (ForumTopicService) ContextLoader.getCurrentWebApplicationContext().getBean("forumTopicService");

    public ChatServer(InetSocketAddress address) {
        super(address);
    }

    public ChatServer(int port) throws UnknownHostException {
        super(new InetSocketAddress(port));
    }

    /**
     * 连接建立成功调用的方法
     * @param webSocket,clientHandshake
     */
    @Override
    public void onOpen(WebSocket webSocket, ClientHandshake clientHandshake) {
    }

    @Override
    public void onClose(WebSocket webSocket, int i, String s, boolean b) {
        ChatServerPool.removeUser(webSocket);
    }

    @Override
    public void onMessage(WebSocket webSocket, String _message) {
        JSONObject chat = JSON.parseObject(_message);
        JSONObject message = JSON.parseObject(chat.get("message").toString());

        String userId = message.get("userId").toString();
        String toUserId = message.get("toUserId").toString();
        if(ChatServerPool.getWebSocketByUser(userId) == null) {
            ChatServerPool.addUser(userId,webSocket);					//向连接池添加当前的连接对象
        }
//        if(ChatServerPool.getWebSocketByUser(toUserId) == null && StringUtils.isNotBlank(toUserId)) {
//            ChatServerPool.addUser(toUserId,webSocket);					//向连接池添加当前的连接对象
//        }
        QueryFilter filter = new QueryFilter();
        filter.put("userId",userId);
        countSelf = forumTopicService.getNotOnlineCount(filter);//查询不在线时的关注，收藏等数量
        ChatServerPool.sendMessageToUser(ChatServerPool.getWebSocketByUser(userId),countSelf+"");
        WebSocket socket = ChatServerPool.getWebSocketByUser(toUserId);
        if(null != socket) {
            filter.put("userId",toUserId);
            countToUser = forumTopicService.getNotOnlineCount(filter);//查询不在线时的关注，收藏等数量
            ChatServerPool.sendMessageToUser(ChatServerPool.getWebSocketByUser(toUserId),countToUser+"");
        }
    }

    @Override
    public void onError(WebSocket webSocket, Exception e) {

    }
}
