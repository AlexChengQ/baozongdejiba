package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户角色
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysUserRole implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**role_id*/
	private Long roleId;
	
	/**user_id*/
	private Long userId;
	
	/**role_id*/
	public Long getRoleId() {
		return roleId;
	}
	
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	/**user_id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
}
