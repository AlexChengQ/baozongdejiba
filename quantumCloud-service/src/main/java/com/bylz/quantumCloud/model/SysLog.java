package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统日志
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysLog implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**id*/
	private Long id;
	
	/**操作*/
	private String operation;
	
	/**操作内容*/
	private String operContent;
	
	/**操作人账号*/
	private String userId;
	
	/**操作人*/
	private String username;
	
	/**客户端*/
	private String userAgent;
	
	/**IP*/
	private String ip;
	
	/**操作日期*/
	private Date operDate;

	/**操作日期*/
	private String operDateString;

	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**操作*/
	public String getOperation() {
		return operation;
	}
	
	public void setOperation(String operation) {
		this.operation = operation;
	}
	
	/**操作内容*/
	public String getOperContent() {
		return operContent;
	}
	
	public void setOperContent(String operContent) {
		this.operContent = operContent;
	}
	
	/**操作人账号*/
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**操作人*/
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	/**客户端*/
	public String getUserAgent() {
		return userAgent;
	}
	
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	
	/**IP*/
	public String getIp() {
		return ip;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	/**操作日期*/
	public Date getOperDate() {
		return operDate;
	}
	
	public void setOperDate(Date operDate) {
		this.operDate = operDate;
	}

	/*操作日期String*/
	public String getOperDateString() { return operDateString; }

	public void setOperDateString(String operDateString) {
		this.operDateString = operDateString;
	}
	
}
