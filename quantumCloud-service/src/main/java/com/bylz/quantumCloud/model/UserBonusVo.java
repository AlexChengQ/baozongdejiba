package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/11
 */
public class UserBonusVo implements Serializable {

    private static final long serialVersionUID = -7289062430206865039L;

    private int badge1;//分子勋

    private int badge2;//原子勋

    private int badge3;//中子勋

    private int badge4;//质子勋

    private int badge5;//夸克勋

    private int badge6;//量子勋

    private long userId;

    private int score;//兑换了多少积分

    private Date updTime;//更新时间

    private int stdTime;//学习时长

    public int getBadge1() {
        return badge1;
    }

    public void setBadge1(int badge1) {
        this.badge1 = badge1;
    }

    public int getBadge2() {
        return badge2;
    }

    public void setBadge2(int badge2) {
        this.badge2 = badge2;
    }

    public int getBadge3() {
        return badge3;
    }

    public void setBadge3(int badge3) {
        this.badge3 = badge3;
    }

    public int getBadge4() {
        return badge4;
    }

    public void setBadge4(int badge4) {
        this.badge4 = badge4;
    }

    public int getBadge5() {
        return badge5;
    }

    public void setBadge5(int badge5) {
        this.badge5 = badge5;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Date getUpdTime() {
        return updTime;
    }

    public void setUpdTime(Date updTime) {
        this.updTime = updTime;
    }

    public int getBadge6() {
        return badge6;
    }

    public void setBadge6(int badge6) {
        this.badge6 = badge6;
    }

    public int getStdTime() {
        return stdTime;
    }

    public void setStdTime(int stdTime) {
        this.stdTime = stdTime;
    }

}
