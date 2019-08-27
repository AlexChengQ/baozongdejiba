package com.bylz.quantumCloud.model;

import java.io.Serializable;

public class UserBadge implements Serializable{
	private int badge_id;
	private int userid;
	
	public int getBadge_id() {
		return badge_id;
	}
	public void setBadge_id(int badge_id) {
		this.badge_id = badge_id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}	
}
