package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 红包表
 * @author JT
 * @since  2018-01-29
 */
public class QcodeRedPacket implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public static final int STATUS_FAIL = 0;
	public static final int STATUS_SUCCESS = 1;
	
	/**id*/
	private Long id;
	
	/**微信openId*/
	private String openId;
	
	/**微信名称*/
	private String wechatName;

	/**用户email*/
	private String userMail;
	
	/**用户Id*/
	private Long userId;
	
	/**量子云用户名称*/
	private String userName;
	
	/**发送状态(0:失败,1:成功)*/
	private Integer status;
	
	/**结果信息*/
	private String reason;
	
	/**金额*/
	private Double moneny;
	
	/**生成时间*/
	private Date createTime;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**微信openId*/
	public String getOpenId() {
		return openId;
	}
	
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	
	/**微信名称*/
	public String getWechatName() {
		return wechatName;
	}
	
	public void setWechatName(String wechatName) {
		this.wechatName = wechatName;
	}
	
	/**用户email*/
	public String getUserMail() {
		return userMail;
	}
	
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	
	/**用户Id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**量子云用户名称*/
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	/**状态(0:失败,1:成功)*/
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	/**结果信息*/
	public String getReason() {
		return reason;
	}
	
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	/**金额*/
	public Double getMoneny() {
		return moneny;
	}
	
	public void setMoneny(Double moneny) {
		this.moneny = moneny;
	}
	
	/**生成时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
