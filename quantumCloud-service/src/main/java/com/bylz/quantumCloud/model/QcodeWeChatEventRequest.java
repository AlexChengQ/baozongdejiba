package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 微信事件请求表
 * @author houdongdong
 * @since  2018-01-31
 */
public class QcodeWeChatEventRequest implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**id*/
	private Integer id;
	
	/**请求唯一标识*/
	private String uniqueIdentification;
	
	/**id*/
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**请求唯一标识*/
	public String getUniqueIdentification() {
		return uniqueIdentification;
	}
	
	public void setUniqueIdentification(String uniqueIdentification) {
		this.uniqueIdentification = uniqueIdentification;
	}
	
}
