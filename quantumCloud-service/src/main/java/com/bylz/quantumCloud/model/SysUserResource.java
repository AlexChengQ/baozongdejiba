package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户资源
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysUserResource implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**id*/
	private Long id;
	
	/**user_id*/
	private Long userId;
	
	/**resource*/
	private String resource;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**user_id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**resource*/
	public String getResource() {
		return resource;
	}
	
	public void setResource(String resource) {
		this.resource = resource;
	}
	
}
