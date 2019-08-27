package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统角色
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysRole implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**role_id*/
	private Long roleId;
	
	/**上级角色ID,0为顶级*/
	private Long parentId;
	
	/**角色名称*/
	private String roleName;
	
	/**描述*/
	private String descn;
	
	/**是否生效(0:无效,1:有效)*/
	private Integer enabled;
	
	/**role_id*/
	public Long getRoleId() {
		return roleId;
	}
	
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	/**上级角色ID,0为顶级*/
	public Long getParentId() {
		return parentId;
	}
	
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	
	/**角色名称*/
	public String getRoleName() {
		return roleName;
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	/**描述*/
	public String getDescn() {
		return descn;
	}
	
	public void setDescn(String descn) {
		this.descn = descn;
	}
	
	/**是否生效(0:无效,1:有效)*/
	public Integer getEnabled() {
		return enabled;
	}
	
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	
}
