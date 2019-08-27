/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 举报Vo
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年07月10日
 */
public class ReportVo implements Serializable {

    private static final long serialVersionUID = -4164812806789014746L;
    /*主键id*/
    private Long id;
    /*帖子id*/
    private Long topicId;
    /*回复id*/
    private Long replyId;
    /*类别（01、帖子02、评论）*/
    private  String type;
    /*举报类型*/
    private  String reportType;
    /*举报内容*/
    private String reportContent;
    /*举报时间*/
    private Date addTime;
    /*帖子名称*/
    private String topicTitle;
    /*回复内容*/
    private String replyContent;
    /*举报人*/
    private String reportUserName;
    /*举报类型名称*/
    private String reportTypeName;
    /*类别名称*/
    private String typeName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTopicId() {
        return topicId;
    }

    public void setTopicId(Long topicId) {
        this.topicId = topicId;
    }

    public Long getReplyId() {
        return replyId;
    }

    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getTopicTitle() {
        return topicTitle;
    }

    public void setTopicTitle(String topicTitle) {
        this.topicTitle = topicTitle;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getReportUserName() {
        return reportUserName;
    }

    public void setReportUserName(String reportUserName) {
        this.reportUserName = reportUserName;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public String getReportTypeName() {
        return reportTypeName;
    }

    public void setReportTypeName(String reportTypeName) {
        this.reportTypeName = reportTypeName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}


