package com.bylz.quantumCloud.model;

import java.io.Serializable;

public class UserScoreDetail implements Serializable{

	private int minusscore;
	private Long id;
	private Long userid;
	private String title;
	private String datetime;
	//增加分数标志，0未增加，1已增加
	private int addscore;
	public int getMinusscore() {
		return minusscore;
	}
	public void setMinusscore(int minusscore) {
		this.minusscore = minusscore;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getUserid() {
		return userid;
	}
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}
	public int getAddscore() {
		return addscore;
	}
	public void setAddscore(int addscore) {
		this.addscore = addscore;
	}
	

	
	
	
}
