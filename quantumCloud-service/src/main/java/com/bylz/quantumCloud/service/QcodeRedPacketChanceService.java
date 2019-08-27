package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.QcodeRedPacketChance;
import com.likegene.framework.core.BaseService;

/**
 * 红包概率区间表 Service
 * @author JT
 * @since  2018-01-29
 * 
 */
public interface QcodeRedPacketChanceService extends BaseService<QcodeRedPacketChance, Integer>{
	  String SELECTLIST_COUNT = "selectList_count";
	  String SELECT_AN_USABLE_QCODE_RED_PACKET_CHANCE ="selectAnUsableQcodeRedPacketChance";
	  String UPDATE_BY_CHANCENUM = "updateByChanceNum";
	
	/**检查概率区间数值 是否存在 ,并且可以使用*/
	public boolean checkChanceNumExistAndUsable(Integer chanceNum);
	/**检查概率区间数值 是否存在 ,并且可以使用，然后更新为不可用*/
	public boolean checkChanceNumAndUpdate(Integer chanceNum);
	/**恢复 红包概率区间表的数据可用*/
	public void recoveryQcodeRedPacketChanceTable();
	
	/**获取可用数据的数量*/
	public int usableQcodeRedPacketChanceAcount();
	/**获取一条有效的数据,并修改为不可用状态*/
	public  String getAUsableQcodeRedPacketChanceAndUpdate();
	
	public 	QcodeRedPacketChance getAUsableQcodeRedPacketChance();
//	public void insertRandom(int minValue, int maxValue, int count, double amount );
	
	/**
	 * 插入随机数据
	 * @param  minValue 概率区间数值 chanceNum 开始值
	 * @param count   每一个amount 插入多少个
	 * @param amount
	 * */
	public void insertRandom(int minValue,  int count, String amount );
}
