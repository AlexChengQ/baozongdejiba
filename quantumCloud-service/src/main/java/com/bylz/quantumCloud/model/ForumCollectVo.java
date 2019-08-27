package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:收藏
 * @since 2018/7/4
 */
public class ForumCollectVo implements Serializable {
    private static final long serialVersionUID = -4542665525099887068L;
    private Long id;//id
    private Long forumTopicId;//收藏帖子id
    private Long userId;//收藏人id
    private String isCollection;//是否收藏
    private Date addTime;//收藏时间
    private String userName;//收藏人姓名
    private String title;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getForumTopicId() {
        return forumTopicId;
    }

    public void setForumTopicId(Long forumTopicId) {
        this.forumTopicId = forumTopicId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getIsCollection() {
        return isCollection;
    }

    public void setIsCollection(String isCollection) {
        this.isCollection = isCollection;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
