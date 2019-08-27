package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 任务表
 * @author JT
 * @since  2017-07-27
 */
public class QcodeTask implements Serializable{
	private static final long serialVersionUID = 1L;
	
	
	/**等待*/
	public static final String STATUS_WAITING = "1";
	/**处理中*/
	public static final String STATUS_PROCESS = "2";
	/**有结果且正确*/
	public static final String STATUS_RESULT = "3";
	/**语法错误*/
	public static final String STATUS_ERROR = "4";
	/**终止*/
	public static final String STATUS_END = "5";
	
	public static final int  ISDEL_NO  = 0 ;
	public static final int  ISDEL_YES = 1 ;
	
	/**id*/
	private Long id;
	
	/**项目版本id*/
	private Long versionId;
	
	/**任务编号*/
	private String taskId;
	
	/**经典寄存器名*/
	private String classicRegisterName;
	
	/**执行时间*/
	private Date startTime;
	
	/**结束时间*/
	private Date endTime;
	
	/**重复次数*/
	private Integer repeat;
	
	/**测量比特数组*/
	private String meaarr;

	/**任务类型*/
	private String type;
	
	/**状态（1：等待，2：处理中，3：有结果，4：语法错误，5：终止）*/
	private String status;
	
	/**应答*/
	private String ans;
	
	/**是否删除(0:否,1:是)*/
	private Integer isDel;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**项目版本id*/
	public Long getVersionId() {
		return versionId;
	}
	
	public void setVersionId(Long versionId) {
		this.versionId = versionId;
	}
	
	/**任务编号*/
	public String getTaskId() {
		return taskId;
	}
	
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	/**经典寄存器名*/
	public String getClassicRegisterName() {
		return classicRegisterName;
	}
	
	public void setClassicRegisterName(String classicRegisterName) {
		this.classicRegisterName = classicRegisterName;
	}
	
	/**执行时间*/
	public Date getStartTime() {
		return startTime;
	}
	
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	
	/**结束时间*/
	public Date getEndTime() {
		return endTime;
	}
	
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	/**重复次数*/
	public Integer getRepeat() {
		return repeat;
	}
	
	public void setRepeat(Integer repeat) {
		this.repeat = repeat;
	}
	
	/**测量比特数组*/
	public String getMeaarr() {
		return meaarr;
	}
	
	public void setMeaarr(String meaarr) {
		this.meaarr = meaarr;
	}

	/**进度*/
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**应答*/
	public String getAns() {
		return ans;
	}
	
	public void setAns(String ans) {
		this.ans = ans;
	}
	
	/**是否删除(0:否,1:是)*/
	public Integer getIsDel() {
		return isDel;
	}
	
	public void setIsDel(Integer isDel) {
		this.isDel = isDel;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}
	
}
