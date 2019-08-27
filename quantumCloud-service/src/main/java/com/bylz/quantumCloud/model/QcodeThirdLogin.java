package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 第三方登录
 * @author houdongdong
 * @since  2018-02-26
 */
public class QcodeThirdLogin implements Serializable{
	private static final long serialVersionUID = 1L;
	
	public static final int APPTYPE_QQ = 1;
	public static final int APPTYPE_WE_CHAT = 2;
	public static final int APPTYPE_SINA = 3;
	
	/**id*/
	private Long id;
	
	/**会员id*/
	private Long userId;
	
	/**第三方登录类型(如1:qq、2:微信、3:微博)*/
	private Integer appType;
	
	/**第三方唯一id*/
	private String appId;
	
	/**access_token*/
	private String accessToken;
	
	/**第三方头像*/
	private String face;
	
	/**第三方的昵称*/
	private String nickname;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**会员id*/
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	/**第三方登录类型(如1:qq、2:微信、3:微博)*/
	public Integer getAppType() {
		return appType;
	}
	
	public void setAppType(Integer appType) {
		this.appType = appType;
	}
	
	/**第三方唯一id*/
	public String getAppId() {
		return appId;
	}
	
	public void setAppId(String appId) {
		this.appId = appId;
	}
	
	/**access_token*/
	public String getAccessToken() {
		return accessToken;
	}
	
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	
	/**第三方头像*/
	public String getFace() {
		return face;
	}
	
	public void setFace(String face) {
		this.face = face;
	}
	
	/**第三方的昵称*/
	public String getNickname() {
		return nickname;
	}
	
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
}
