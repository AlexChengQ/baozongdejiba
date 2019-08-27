package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/8/2
 */
public class ModeratorVo implements Serializable {

    private static final long serialVersionUID = 8492345812890327338L;
    private long id;//id
    private String belonged;//所属版块1：QPanda,2：量子计算
    private String belongedName;//所属版块名称
    private String userName;//版主名字
    private long userId;//版主id
    private Date addTime;//成为版主时间
    private String email;
    private String level;//用户等级


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getBelonged() {
        return belonged;
    }

    public void setBelonged(String belonged) {
        this.belonged = belonged;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getBelongedName() {
        return belongedName;
    }

    public void setBelongedName(String belongedName) {
        this.belongedName = belongedName;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }
}
