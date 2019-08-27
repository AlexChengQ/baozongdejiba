package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/4/23
 */
public class CollectVo implements Serializable {
    private static final long serialVersionUID = -9005995570533304757L;

    private long id;

    private long userId;

    private String title;

    private int videoId;

    private int isComplete;//是否完成0,：未完成，1：已完成

    private String lastStdTime;

    private String img;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public int getIsComplete() {
        return isComplete;
    }

    public void setIsComplete(int isComplete) {
        this.isComplete = isComplete;
    }

    public String getLastStdTime() {
        return lastStdTime;
    }

    public void setLastStdTime(String lastStdTime) {
        this.lastStdTime = lastStdTime;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}
