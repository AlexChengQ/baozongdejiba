package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2018/6/23
 */
public class DicValueVo implements Serializable {

    private static final long serialVersionUID = -64508353459357254L;

    private String value;//值
    private String text;//文本值
    private Date addTime;//创建时间
    private String userName;//创建人
    private long userId;//创建人id
    private long id;//id
    private String dicName;//字典名称
    private String dicDesc;//字典描述
    private String deflag;//是否有效

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDicName() {
        return dicName;
    }

    public void setDicName(String dicName) {
        this.dicName = dicName;
    }

    public String getDicDesc() {
        return dicDesc;
    }

    public void setDicDesc(String dicDesc) {
        this.dicDesc = dicDesc;
    }

    public String getDeflag() {
        return deflag;
    }

    public void setDeflag(String deflag) {
        this.deflag = deflag;
    }
}
