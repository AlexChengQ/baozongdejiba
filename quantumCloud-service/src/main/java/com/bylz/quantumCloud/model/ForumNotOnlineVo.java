package com.bylz.quantumCloud.model;

import java.io.Serializable;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:不在线时数据
 * @since 2018/7/3
 */
public class ForumNotOnlineVo implements Serializable {

    private static final long serialVersionUID = 7807097771208930375L;
    private Long id;//id
    private int focusCount;//关注数量
    private int commentsCount;//评价数量
    private int collectionCount;//收藏数量
    private int pointsCount;//点赞数量
    private int sysCount;//系统通知数量
    private String status;//状态（0,：未读，1：已读）
    private Long userId;//被操作人id


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getFocusCount() {
        return focusCount;
    }

    public void setFocusCount(int focusCount) {
        this.focusCount = focusCount;
    }

    public int getCommentsCount() {
        return commentsCount;
    }

    public void setCommentsCount(int commentsCount) {
        this.commentsCount = commentsCount;
    }

    public int getCollectionCount() {
        return collectionCount;
    }

    public void setCollectionCount(int collectionCount) {
        this.collectionCount = collectionCount;
    }

    public int getPointsCount() {
        return pointsCount;
    }

    public void setPointsCount(int pointsCount) {
        this.pointsCount = pointsCount;
    }

    public int getSysCount() {
        return sysCount;
    }

    public void setSysCount(int sysCount) {
        this.sysCount = sysCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
