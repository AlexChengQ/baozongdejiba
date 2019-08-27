package com.bylz.quantumCloud.model;

import java.io.Serializable;

public class UserExam implements Serializable{

	private int examid;
	private Long userid;
	private String status;
	private String datetime;
	public int getBlockid() {
		return blockid;
	}
	public void setBlockid(int blockid) {
		this.blockid = blockid;
	}
	private int blockid;
	public int getExamid() {
		return examid;
	}
	public void setExamid(int examid) {
		this.examid = examid;
	}
	public Long getUserid() {
		return userid;
	}
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	
	
}
