package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 平台管理员
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysUser implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**id*/
	private Long id;
	
	/**姓名*/
	private String fullname;
	
	/**登录名*/
	private String username;
	
	/**密码(MD5加密后)*/
	private String password;
	
	/**邮箱*/
	private String email;
	
	/**最后登录时间*/
	private Date lastLoginTime;
	
	/**状态(0:已删除,1:启用,2:禁用)*/
	private Integer status;
	
	/**类型(0:普通管理员,1:超级管理员)*/
	private Integer isSuperadmin;
	
	/**备注*/
	private String remark;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**姓名*/
	public String getFullname() {
		return fullname;
	}
	
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	/**登录名*/
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	/**密码(MD5加密后)*/
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	/**邮箱*/
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	/**最后登录时间*/
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	
	/**状态(0:已删除,1:启用,2:禁用)*/
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	/**类型(0:普通管理员,1:超级管理员)*/
	public Integer getIsSuperadmin() {
		return isSuperadmin;
	}
	
	public void setIsSuperadmin(Integer isSuperadmin) {
		this.isSuperadmin = isSuperadmin;
	}
	
	/**备注*/
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
