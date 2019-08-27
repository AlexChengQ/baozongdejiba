package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 参数配置
 * @author liuxiantao
 * @since  2017-07-20
 */
public class SysConfig implements Serializable{
	private static final long serialVersionUID = 1L;
	
	/**
	 * 定时器参数
	 */
	public static final String CATEGORY_CONFIG = "quartzConfig";
	/**
	 * 终止任务
	 */
	public static final String TERMINATE_TASK_TRIGGER = "terminateTaskTrigger";
	
	/**
	 * 微信公众号 access_token
	 */
	public static final String WECHATACCESSTOKEN = "weChatAccessToken";
	
	/**
	 * 微信红包金额(单位：元)与概率设置
	 */
	public static final String REDPACKETCHANCECONFIG = "redPacketChanceConfig";
	
	/**id*/
	private Long id;
	
	/**描述*/
	private String descn;
	
	/**变量名*/
	private String keyname;
	
	/**变量值*/
	private String val;
	
	/**分类*/
	private String category;
	
	/**分类描述*/
	private String categoryDesc;
	
	/**排序*/
	private Integer orderNo;
	
	/**id*/
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	/**描述*/
	public String getDescn() {
		return descn;
	}
	
	public void setDescn(String descn) {
		this.descn = descn;
	}
	
	/**变量名*/
	public String getKeyname() {
		return keyname;
	}
	
	public void setKeyname(String keyname) {
		this.keyname = keyname;
	}
	
	/**变量值*/
	public String getVal() {
		return val;
	}
	
	public void setVal(String val) {
		this.val = val;
	}
	
	/**分类*/
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	/**分类描述*/
	public String getCategoryDesc() {
		return categoryDesc;
	}
	
	public void setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
	}
	
	/**排序*/
	public Integer getOrderNo() {
		return orderNo;
	}
	
	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
}
