package com.bylz.quantumCloud.education.websocketserver;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import org.java_websocket.WebSocket;
import org.springframework.stereotype.Controller;

import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:websocket连接池的类，该类用于管理现实中的用户和websocket对象之间的关联
 * @since 2018/8/15
 */
public class ChatServerPool {
    private static final Map<WebSocket,String> userconnections = new HashMap<WebSocket,String>();

    /**
     * 获取用户名
     * @param conn
     */
    public static String getUserByKey(WebSocket conn){
        return userconnections.get(conn);
    }

    /**
     * 获取WebSocket
     * @param user
     */
    public static WebSocket getWebSocketByUser(String user){
        Set<WebSocket> keySet = userconnections.keySet();
        synchronized (keySet) {
            for (WebSocket conn : keySet) {
                String cuser = userconnections.get(conn);
                if(cuser.equals(user)){
                    return conn;
                }
            }
        }
        return null;
    }

    /**
     * 向连接池中添加连接
     * @param user,conn
     */
    public static void addUser(String user, WebSocket conn){
        userconnections.put(conn,user);	//添加连接
    }

    /**
     * 获取所有的在线用户
     * @return
     */
    public static Collection<String> getOnlineUser(){
        List<String> setUsers = new ArrayList<String>();
        Collection<String> setUser = userconnections.values();
        for(String u:setUser){
            setUsers.add("<a onclick=\"toUserMsg('"+u+"');\">"+u+"</a>");
        }
        return setUsers;
    }

    /**
     * 移除连接池中的连接
     * @param conn
     */
    public static boolean removeUser(WebSocket conn){
        if(userconnections.containsKey(conn)){
            userconnections.remove(conn);	//移除连接
            return true;
        }else{
            return false;
        }
    }

    /**
     * 向特定的用户发送数据
     * @param conn,message
     * @param message
     */
    public static void sendMessageToUser(WebSocket conn,String message){
        if(null != conn && null != userconnections.get(conn)){
            conn.send(message);
        }
    }

    /**
     * 向所有的用户发送消息
     * @param message
     */
    public static void sendMessage(String message){
        Set<WebSocket> keySet = userconnections.keySet();
        synchronized (keySet) {
            for (WebSocket conn : keySet) {
                String user = userconnections.get(conn);
                if(user != null){
                    conn.send(message);
                }
            }
        }
    }
}
