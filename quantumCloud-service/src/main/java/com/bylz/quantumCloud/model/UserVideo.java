package com.bylz.quantumCloud.model;

import java.io.Serializable;

public class UserVideo implements Serializable{

	private String progress;
	private int vid;
	private Long userid;
	private String title;
	private String datetime;
	//增加分数标志，0未增加，1已增加
	private int addscore;
	private String img;
	
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public int getVid() {
		return vid;
	}
	public void setVid(int vid) {
		this.vid = vid;
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

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
}
