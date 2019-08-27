package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 留言表
 * @author liuxiantao
 * @since  2017-12-26
 */
public class QcodeMessage implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**id*/
	private Long id;
	
	/**创建人id*/
	private Long userId;
	
	/**主题*/
	private String title;
	
	/**内容*/
	private String content;
	
	/**创建时间*/
	private Date createTime;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**创建人id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**主题*/
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**内容*/
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	/**创建时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
