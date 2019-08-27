/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.model;

import java.io.Serializable;

import javax.xml.crypto.Data;

/**
 * 批量推送消息Vo
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月03日
 */
public class QcodePushVo implements Serializable {

    private static final long serialVersionUID = -4891965315734074238L;

    /**id*/
    private Long id;
    /*用户id*/
    private Long userId;
    /*用户名称*/
    private String userName;
    /*主题*/
    private  String title;
    /*内容*/
    private String content;
    /*创建时间*/
    private Data createTime;

    private String email;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Data getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Data createTime) {
        this.createTime = createTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
