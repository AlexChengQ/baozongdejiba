package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/1
 */
public class EduStatisticsVo implements Serializable {
    private static final long serialVersionUID = -3114065197000783145L;

    private int id;

    private int registCount;

    private int viewVideoCount;

    private int publishForumCount;

    private int signInCount;

    private int appDownLoadCount;

    private String type;

    private String addTime;

    private int statisticsCount;

    private int customerCount;

    private String date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRegistCount() {
        return registCount;
    }

    public void setRegistCount(int registCount) {
        this.registCount = registCount;
    }

    public int getViewVideoCount() {
        return viewVideoCount;
    }

    public void setViewVideoCount(int viewVideoCount) {
        this.viewVideoCount = viewVideoCount;
    }

    public int getPublishForumCount() {
        return publishForumCount;
    }

    public void setPublishForumCount(int publishForumCount) {
        this.publishForumCount = publishForumCount;
    }

    public int getSignInCount() {
        return signInCount;
    }

    public void setSignInCount(int signInCount) {
        this.signInCount = signInCount;
    }

    public int getAppDownLoadCount() {
        return appDownLoadCount;
    }

    public void setAppDownLoadCount(int appDownLoadCount) {
        this.appDownLoadCount = appDownLoadCount;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public int getStatisticsCount() {
        return statisticsCount;
    }

    public void setStatisticsCount(int statisticsCount) {
        this.statisticsCount = statisticsCount;
    }

    public int getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(int customerCount) {
        this.customerCount = customerCount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
