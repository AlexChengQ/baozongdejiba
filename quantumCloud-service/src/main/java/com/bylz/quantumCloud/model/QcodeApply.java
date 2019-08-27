/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 申请表
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
public class QcodeApply  implements Serializable{
    private static final long serialVersionUID = 1L;

    /**id*/
    private Long id;

    /**创建人id*/
    private Long userId;

    /**姓名*/
    private String name;

    /**电话*/
    private String phone;

    /**邮箱*/
    private String email;

    /**使⽤何种虚拟机*/
    private String vmType;

    /**使用目的*/
    private String purpose;

    /**申请状态（0：未申请，1：已申请）*/
    private String applyStatus;

    /**账户名*/
    private String userName;

    /**账户邮箱*/
    private String userEmail;

    /**申请时间*/
    private Date applyTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getVmType() {
        return vmType;
    }

    public void setVmType(String vmType) {
        this.vmType = vmType;
    }

    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    public String getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(String applyStatus) {
        this.applyStatus = applyStatus;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Date applyTime) {
        this.applyTime = applyTime;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
}
