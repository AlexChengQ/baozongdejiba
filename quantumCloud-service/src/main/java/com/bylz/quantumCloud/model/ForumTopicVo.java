/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 论坛主题实体类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
public class ForumTopicVo implements Serializable {

    private static final long serialVersionUID = -4933871135439754136L;

    /*id*/
    private long id;
    /*论坛主题id*/
    private long forumTopicId;
    /*论坛回复id*/
    private long forumReplyId;

    /*发帖人id*/
    private long userId;

    /*发帖人名称*/
    private String userName;

    /*主题*/
    private String title;

    /*主题内容*/
    private String content;

    /*去除标签主题内容*/
    private String delContent;

    /*回复数*/
    private String replyCount;

    /*发帖时间*/
    private Date addTime;

    /*审核状态（0、未审核，1、已审核）*/
    private String applyStatus;

    /*不赞同数量*/
    private String noApprovalCount;

    /*赞同数量*/
    private String approvalCount;
    /*未审核数量*/
    private int noApplyCount;
    /*是否已赞（0、否，1、是）*/
    private int isApproval;
    /*是否已踩（0、否，1、是）*/
    private int isNoApproval;
    /*是否收藏（0、否，1、是）*/
    private int isCollect;
    /*收藏数量*/
    private String collectCount;

    /*回复list*/
    private List<ForumReplyVo> replyList;

    /*浏览数量*/
    private int seeCount;

    private String topicFace;//封面图

    private List<ForumLableVo> labelList;//论坛属性
    /*分享次数*/
    private String sharCount;

    private String face;//发帖人头像

    private List<ForumCollectVo> collectList;
    /*最新回复时间*/
    private String newReplyTime;

    private String belonged;//所属模块

    private String userTitle;//帖子所属人等级荣誉

    private String blockName;//版块名称

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

    public long getForumReplyId() {
        return forumReplyId;
    }

    public void setForumReplyId(long forumReplyId) {
        this.forumReplyId = forumReplyId;
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

    public String getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(String replyCount) {
        this.replyCount = replyCount;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public List<ForumReplyVo> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<ForumReplyVo> replyList) {
        this.replyList = replyList;
    }

    public String getDelContent() {
        return delContent;
    }

    public void setDelContent(String delContent) {
        this.delContent = delContent;
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

    public int getNoApplyCount() {
        return noApplyCount;
    }

    public void setNoApplyCount(int noApplyCount) {
        this.noApplyCount = noApplyCount;
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

    public int getIsCollect() {
        return isCollect;
    }

    public void setIsCollect(int isCollect) {
        this.isCollect = isCollect;
    }

    public String getCollectCount() {
        return collectCount;
    }

    public void setCollectCount(String collectCount) {
        this.collectCount = collectCount;
    }

    public int getSeeCount() {
        return seeCount;
    }

    public void setSeeCount(int seeCount) {
        this.seeCount = seeCount;
    }

    public String getTopicFace() {
        return topicFace;
    }

    public void setTopicFace(String topicFace) {
        this.topicFace = topicFace;
    }

    public List<ForumLableVo> getLabelList() {
        return labelList;
    }

    public void setLabelList(List<ForumLableVo> labelList) {
        this.labelList = labelList;
    }

    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }

    public String getSharCount() {
        return sharCount;
    }

    public void setSharCount(String sharCount) {
        this.sharCount = sharCount;
    }

    public List<ForumCollectVo> getCollectList() {
        return collectList;
    }

    public void setCollectList(List<ForumCollectVo> collectList) {
        this.collectList = collectList;
    }

    public String getNewReplyTime() {
        return newReplyTime;
    }

    public void setNewReplyTime(String newReplyTime) {
        this.newReplyTime = newReplyTime;
    }

    public String getBelonged() {
        return belonged;
    }

    public void setBelonged(String belonged) {
        this.belonged = belonged;
    }

    public String getUserTitle() {
        return userTitle;
    }

    public void setUserTitle(String userTitle) {
        this.userTitle = userTitle;
    }

    public String getBlockName() {
        return blockName;
    }

    public void setBlockName(String blockName) {
        this.blockName = blockName;
    }
}
