package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 项目版本表
 * @author JT
 * @since  2017-07-28
 */
public class QcodeProjectVersion implements Serializable{
	private static final long serialVersionUID = 1L;

	public static final int  ISDEL_NO  = 0 ;
	public static final int  ISDEL_YES = 1 ;
	
	/**版本id*/
	private Long id;
	
	/**版本名称*/
	private String name;
	
	/**项目id*/
	private Long projectId;
	
	/**创建时间*/
	private Date createTime;
	
	/**量子比特数*/
	private String code;
	
	/**svg_xml内容*/
	private String svgXml;
	
	/**图片路径*/
	private String pic;
	
	/**是否删除(0:否,1:是)*/
	private Integer isDel;
	
	/**版本id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**版本名称*/
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**项目id*/
	public Long getProjectId() {
		return projectId;
	}
	
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}
	
	/**创建时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	/**量子比特数*/
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	/**svg_xml内容*/
	public String getSvgXml() {
		return svgXml;
	}
	
	public void setSvgXml(String svgXml) {
		this.svgXml = svgXml;
	}
	
	/**图片路径*/
	public String getPic() {
		return pic;
	}
	
	public void setPic(String pic) {
		this.pic = pic;
	}
	
	/**是否删除(0:否,1:是)*/
	public Integer getIsDel() {
		return isDel;
	}
	
	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}
	
}
