package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/15
 */
public class ScoreDetailVo implements Serializable {

    private static final long serialVersionUID = 580622025252061833L;

    private int minusScore;

    private int addScore;

    private long userId;

    private Date dateTime;

    private String userName;

    private String detail;

    public int getMinusScore() {
        return minusScore;
    }

    public void setMinusScore(int minusScore) {
        this.minusScore = minusScore;
    }

    public int getAddScore() {
        return addScore;
    }

    public void setAddScore(int addScore) {
        this.addScore = addScore;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
}
