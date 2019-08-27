package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
public class TutorialReviewVo implements Serializable {
    private static final long serialVersionUID = -1782869481257702765L;

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

    private int myAskNum;//我的问题数

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

    public String getRepdUserName() {
        return repdUserName;
    }

    public void setRepdUserName(String repdUserName) {
        this.repdUserName = repdUserName;
    }

    public String getRepdContent() {
        return repdContent;
    }

    public void setRepdContent(String repdContent) {
        this.repdContent = repdContent;
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

    public List<ForumReplyVo> getList() {
        return list;
    }

    public void setList(List<ForumReplyVo> list) {
        this.list = list;
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

    public String getRepdUserFace() {
        return repdUserFace;
    }

    public void setRepdUserFace(String repdUserFace) {
        this.repdUserFace = repdUserFace;
    }

    public String getTopicFace() {
        return topicFace;
    }

    public void setTopicFace(String topicFace) {
        this.topicFace = topicFace;
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

    public int getMyAskNum() {
        return myAskNum;
    }

    public void setMyAskNum(int myAskNum) {
        this.myAskNum = myAskNum;
    }
}
