package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/7/14
 */
public class FeedBackVo implements Serializable {
    private static final long serialVersionUID = 6954955969683682062L;
    private String id;//反馈建议id
    private String belonged;//所属板块
    private String problemType;//问题类型
    private String title;//问题主题
    private String content;//问题描述
    private String type;//预留字段（类型）
    private Date addTime;//添加时间
    private Long userId;//添加人id
    private String userName;//添加人姓名
    private List<RelationFileVo> relationFileList;//关联文件

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBelonged() {
        return belonged;
    }

    public void setBelonged(String belonged) {
        this.belonged = belonged;
    }

    public String getProblemType() {
        return problemType;
    }

    public void setProblemType(String problemType) {
        this.problemType = problemType;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public List<RelationFileVo> getRelationFileList() {
        return relationFileList;
    }

    public void setRelationFileList(List<RelationFileVo> relationFileList) {
        this.relationFileList = relationFileList;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
