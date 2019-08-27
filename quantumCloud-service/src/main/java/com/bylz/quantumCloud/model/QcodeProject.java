package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 项目表
 * @author JT
 * @since  2017-07-28
 */
public class QcodeProject implements Serializable{
	private static final long serialVersionUID = 1L;
	
	//模拟类型 
	/**Monte-Carlo*/
	public static final Integer ANALOG_TYPE_MONTE = 0;
	/**概率方法*/
	public static final Integer ANALOG_TYPE_PROBABILITY = 1;

	 public static final int  isDel_NO  = 0;
	 public static final int  isDel_YES = 1;
	
	/**id*/
	private Long id;
	
	/**项目名称*/
	private String name;
	
	/**创建人id*/
	private Long userId;
	
	/**创建时间*/
	private Date createTime;
	
	/**量子比特数*/
	private Integer qubitNum;
	
	/**经典比特数*/
	private Integer classicalbitNum;

	/**重复试验次数*/
	private Integer repeat;
	
	/**图片*/
	private String pic;
	
	/**项目描述*/
	private String desc;
	
	/**任务类型id(1:模拟,2:芯片)*/
	private Integer taskTypeId;
	
	/**是否删除(0:否,1:是)*/
	private Integer isDel;
	
	/**英文名称*/
	private String nameEnglish;
	
	/**英文描述*/
	private String descEnglish;
	
	/**模拟类型（0：Monte-Carlo，1：概率方法）*/
	private Integer analogType;

	private  String semi;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**项目名称*/
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**创建人id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**创建时间*/
	public Date getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	/**量子比特数*/
	public Integer getQubitNum() {
		return qubitNum;
	}
	
	public void setQubitNum(Integer qubitNum) {
		this.qubitNum = qubitNum;
	}
	
	/**经典比特数*/
	public Integer getClassicalbitNum() {
		return classicalbitNum;
	}
	
	public void setClassicalbitNum(Integer classicalbitNum) {
		this.classicalbitNum = classicalbitNum;
	}

	/**重复试验次数*/
	public Integer getRepeat() {
		return repeat;
	}
	
	public void setRepeat(Integer repeat) {
		this.repeat = repeat;
	}
	
	/**图片*/
	public String getPic() {
		return pic;
	}
	
	public void setPic(String pic) {
		this.pic = pic;
	}
	
	/**项目描述*/
	public String getDesc() {
		return desc;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	/**任务类型id(1:模拟,2:芯片)*/
	public Integer getTaskTypeId() {
		return taskTypeId;
	}
	
	public void setTaskTypeId(Integer taskTypeId) {
		this.taskTypeId = taskTypeId;
	}
	
	/**是否删除(0:否,1:是)*/
	public Integer getIsDel() {
		return isDel;
	}
	
	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}

	/**英文名称*/
	public String getNameEnglish() {
		return nameEnglish;
	}

	public void setNameEnglish(String nameEnglish) {
		this.nameEnglish = nameEnglish;
	}

	/**英文描述*/
	public String getDescEnglish() {
		return descEnglish;
	}

	public void setDescEnglish(String descEnglish) {
		this.descEnglish = descEnglish;
	}

	/**模拟类型（0：Monte-Carlo，1：概率方法）*/
	public Integer getAnalogType() {
		return analogType;
	}

	public void setAnalogType(Integer analogType) {
		this.analogType = analogType;
	}

	public String getSemi() {
		return semi;
	}

	public void setSemi(String semi) {
		this.semi = semi;
	}
}
