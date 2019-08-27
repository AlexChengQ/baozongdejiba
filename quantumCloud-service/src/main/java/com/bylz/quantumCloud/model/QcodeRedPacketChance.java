package com.bylz.quantumCloud.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 红包概率区间表
 * @author JT
 * @since  2018-01-29
 */
public class QcodeRedPacketChance implements Serializable{
	private static final long serialVersionUID = 1L;
	/**不可用*/
	public static final  Integer AVAILABLE_USELESS = 0;
	/**可用*/
	public static final  Integer AVAILABLE_USABLE = 1;
	
	/**id*/
	private Integer id;
	
	/**加密后的数值*/
	private String amount;
	
	/**概率区间数值*/
	private Integer chanceNum;
	
	/**可获得的(0:不可用,1:可用)*/
	private Integer available;
	
	/**id*/
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	/**数值*/
	public String getAmount() {
		return amount;
	}
	
	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	/**概率区间数值*/
	public Integer getChanceNum() {
		return chanceNum;
	}
	
	public void setChanceNum(Integer chanceNum) {
		this.chanceNum = chanceNum;
	}
	
	/**可获得的(0:不可用,1:可用)*/
	public Integer getAvailable() {
		return available;
	}
	
	public void setAvailable(Integer available) {
		this.available = available;
	}
	
}
