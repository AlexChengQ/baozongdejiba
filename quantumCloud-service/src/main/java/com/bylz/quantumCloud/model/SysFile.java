package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 文件
 * @author JT
 * @since  2017-07-20
 */
public class SysFile implements Serializable{
	private static final long serialVersionUID = 1L;
	//剪切图片文件夹
	public static final String CUTFOLDER="cutFolder";

	//产品图片
	public static final String PRODUCTPIC="productPic";
	
	//添加图片 限制  5兆
	public static final Long PIC_SIZE = 5242880l;
	
	/**id*/
	private Long id;
	
	/**文件夹*/
	private String folderId;
	
	/**文件名*/
	private String fileName;
	
	/**描述*/
	private String descn;
	
	/**文件路径*/
	private String path;
	
	/**文件类型*/
	private String type;
	
	/**扩展名*/
	private String extension;
	
	/**文件大小*/
	private Long size;
	
	/**对象主键*/
	private String refId;
	
	/**引用对象*/
	private String refObj;
	
	/**是否锁定(0:否,1:是)*/
	private Integer locked;
	
	/**上传人ID*/
	private Long userId;
	
	/**上传人名称*/
	private String username;
	
	/**扩展字段*/
	private String extField;
	
	/**创建时间*/
	private Date createTime;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**文件夹*/
	public String getFolderId() {
		return folderId;
	}
	
	public void setFolderId(String folderId) {
		this.folderId = folderId;
	}
	
	/**文件名*/
	public String getFileName() {
		return fileName;
	}
	
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	/**描述*/
	public String getDescn() {
		return descn;
	}
	
	public void setDescn(String descn) {
		this.descn = descn;
	}
	
	/**文件路径*/
	public String getPath() {
		return path;
	}
	
	public void setPath(String path) {
		this.path = path;
	}
	
	/**文件类型*/
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	/**扩展名*/
	public String getExtension() {
		return extension;
	}
	
	public void setExtension(String extension) {
		this.extension = extension;
	}
	
	/**文件大小*/
	public Long getSize() {
		return size;
	}
	
	public void setSize(Long size) {
		this.size = size;
	}
	
	/**对象主键*/
	public String getRefId() {
		return refId;
	}
	
	public void setRefId(String refId) {
		this.refId = refId;
	}
	
	/**引用对象*/
	public String getRefObj() {
		return refObj;
	}
	
	public void setRefObj(String refObj) {
		this.refObj = refObj;
	}
	
	/**是否锁定(0:否,1:是)*/
	public Integer getLocked() {
		return locked;
	}
	
	public void setLocked(Integer locked) {
		this.locked = locked;
	}
	
	/**上传人ID*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**上传人名称*/
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	/**扩展字段*/
	public String getExtField() {
		return extField;
	}
	
	public void setExtField(String extField) {
		this.extField = extField;
	}
	
	/**创建时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
