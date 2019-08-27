package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:浏览记录实体
 * @since 2018/6/26
 */
public class ForumBrowseVo implements Serializable {
    private static final long serialVersionUID = -679729914310527699L;

    private Long userId;//浏览人id
    private String ip;//浏览人ip
    private String addTime;//浏览时间
    private Long forumTopicId;//浏览主题id

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public Long getForumTopicId() {
        return forumTopicId;
    }

    public void setForumTopicId(Long forumTopicId) {
        this.forumTopicId = forumTopicId;
    }
}
