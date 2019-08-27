package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * qcode_user_application
 * @author JT
 * @since  2017-12-28
 */
public class QcodeUserApplication implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public final static Integer LEVEL_ONE = 1;
	public final static Integer LEVEL_TWO = 2;
	public final static Integer LEVEL_THREE = 3;
	
	/**申请状态(0:已拒绝,1:已通过,2:未审核)*/
	public final static Integer STATUS_REFUSE = 0;
	public final static Integer STATUS_AGREE = 1;
	public final static Integer STATUS_WAITING = 2;
	
	
	/**id*/
	private Long id;
	
	/**姓名*/
	private String name;
	
	/**email*/
	private String email;
	
	/**机构*/
	private String orgName;
	
	/**用户等级(1:一级用户,2:二级用户,3:三级用户)*/
	private Integer level;
	
	/**具有基础*/
	private String base;
	
	/**目标*/
	private String target;
	
	/**申请人id*/
	private Long userId;
	
	/**申请状态(0:已拒绝,1:已通过,2:未审核)*/
	private Integer status;
	
	/**创建时间*/
	private Date createTime;
	
	/**审核人id*/
	private Long auditorId;
	
	/**审核时间*/
	private Date auditTime;
	
	/**拒绝理由*/
	private String refuseReason;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**姓名*/
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**emil*/
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	/**机构*/
	public String getOrgName() {
		return orgName;
	}
	
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	/**用户等级(1:一级用户,2:二级用户,3:三级用户)*/
	public Integer getLevel() {
		return level;
	}
	
	public void setLevel(Integer level) {
		this.level = level;
	}
	
	/**具有基础*/
	public String getBase() {
		return base;
	}
	
	public void setBase(String base) {
		this.base = base;
	}
	
	/**目标*/
	public String getTarget() {
		return target;
	}
	
	public void setTarget(String target) {
		this.target = target;
	}
	
	/**申请人id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**申请状态(0:已拒绝,1:已通过,2:未审核)*/
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	/**创建时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	/**审核人id*/
	public Long getAuditorId() {
		return auditorId;
	}
	
	public void setAuditorId(Long auditorId) {
		this.auditorId = auditorId;
	}
	
	/**审核时间*/
	public Date getAuditTime() {
		return auditTime;
	}
	
	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}
	
	/**拒绝理由*/
	public String getRefuseReason() {
		return refuseReason;
	}
	
	public void setRefuseReason(String refuseReason) {
		this.refuseReason = refuseReason;
	}
}
