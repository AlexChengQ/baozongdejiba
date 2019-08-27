/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 论坛回复vo
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
public class ForumReplyVo implements Serializable {

    private static final long serialVersionUID = 7378028281322608775L;

    /*id*/
    private long id;

    /*回复主题id*/
    private long forumTopicId;

    /*回复用户id*/
    private long userId;

    /*回复用户名*/
    private String userName;

    /*被回复人id*/
    private String repdUserId;

    /*被回复人name*/
    private String repdUserName;

    /*被回复内容*/
    private String repdContent;

    /*回复内容*/
    private String content;

    /*父id*/
    private String parentId;

    /**
     * 回复时间
     */
    private Date addTime;

    /*审核状态（0、未审核，1、已审核）*/
    private String applyStatus;

    /*不赞同数量*/
    private String noApprovalCount;

    /*赞同数量*/
    private String approvalCount;

    /*下级回复集合*/
    private List<ForumReplyVo> list;
    /*是否已赞（0、否，1、是）*/
    private int isApproval;
    /*是否已踩（0、否，1、是）*/
    private int isNoApproval;

    private String title;//回复帖子主题

    private String userFace;//回复人头像

    private String repdUserFace;//被回复回复人头像

    private String topicFace;//回复主题图片
    /*是否能够删除评论权限 0、否1、是*/
    private String delFlag;
    /*父ids*/
    private String pIds;

    private String type;//0:帖子，1:视频


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getForumTopicId() {
        return forumTopicId;
    }

    public void setForumTopicId(long forumTopicId) {
        this.forumTopicId = forumTopicId;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getRepdUserId() {
        return repdUserId;
    }

    public void setRepdUserId(String repdUserId) {
        this.repdUserId = repdUserId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getRepdUserName() {
        return repdUserName;
    }

    public void setRepdUserName(String repdUserName) {
        this.repdUserName = repdUserName;
    }

    public List<ForumReplyVo> getList() {
        return list;
    }

    public void setList(List<ForumReplyVo> list) {
        this.list = list;
    }

    public String getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(String applyStatus) {
        this.applyStatus = applyStatus;
    }

    public String getNoApprovalCount() {
        return noApprovalCount;
    }

    public void setNoApprovalCount(String noApprovalCount) {
        this.noApprovalCount = noApprovalCount;
    }

    public String getApprovalCount() {
        return approvalCount;
    }

    public void setApprovalCount(String approvalCount) {
        this.approvalCount = approvalCount;
    }

    public int getIsApproval() {
        return isApproval;
    }

    public void setIsApproval(int isApproval) {
        this.isApproval = isApproval;
    }

    public int getIsNoApproval() {
        return isNoApproval;
    }

    public void setIsNoApproval(int isNoApproval) {
        this.isNoApproval = isNoApproval;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUserFace() {
        return userFace;
    }

    public void setUserFace(String userFace) {
        this.userFace = userFace;
    }

    public String getTopicFace() {
        return topicFace;
    }

    public void setTopicFace(String topicFace) {
        this.topicFace = topicFace;
    }

    public String getRepdContent() {
        return repdContent;
    }

    public void setRepdContent(String repdContent) {
        this.repdContent = repdContent;
    }

    public String getRepdUserFace() {
        return repdUserFace;
    }

    public void setRepdUserFace(String repdUserFace) {
        this.repdUserFace = repdUserFace;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getpIds() {
        return pIds;
    }

    public void setpIds(String pIds) {
        this.pIds = pIds;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
