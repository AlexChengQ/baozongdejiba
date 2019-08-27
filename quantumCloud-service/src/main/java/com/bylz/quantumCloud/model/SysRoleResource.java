package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 角色资源
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysRoleResource implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**role_id*/
	private Long roleId;
	
	/**resource*/
	private String resource;
	
	/**role_id*/
	public Long getRoleId() {
		return roleId;
	}
	
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	/**resource*/
	public String getResource() {
		return resource;
	}
	
	public void setResource(String resource) {
		this.resource = resource;
	}
	
}
