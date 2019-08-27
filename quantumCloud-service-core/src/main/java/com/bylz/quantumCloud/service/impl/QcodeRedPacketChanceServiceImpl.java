package com.bylz.quantumCloud.service.impl;

import java.util.LinkedHashSet;
import java.util.Random;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.QcodeRedPacketChance;
import com.bylz.quantumCloud.service.QcodeRedPacketChanceService;

/**
 * 红包概率区间表 Service
 * @author JT
 * @since  2018-01-29
 * 
 */
@Component
public class QcodeRedPacketChanceServiceImpl extends BaseServiceImpl<QcodeRedPacketChance, Integer> implements QcodeRedPacketChanceService{

	public String getNamespace()
    {
        return QcodeRedPacketChance.class.getSimpleName();
    }

	@Override
	public boolean checkChanceNumExistAndUsable(Integer chanceNum) {
		
		int usableQcodeRedPacketChanceAcount = usableQcodeRedPacketChanceAcount();
		if(usableQcodeRedPacketChanceAcount <=0){//所有的数据都不可做对比
			recoveryQcodeRedPacketChanceTable();//恢复数据
			return true;
		}
		
		QueryFilter filter = new QueryFilter();
		filter.put("chanceNum", chanceNum);
		QcodeRedPacketChance qcodeRedPacketChance = this.findOne(filter).getReturnObj();
		if(qcodeRedPacketChance != null && qcodeRedPacketChance.getAvailable() == QcodeRedPacketChance.AVAILABLE_USABLE){
			return true;
		}
		return false;
	}

	@Override
	public void recoveryQcodeRedPacketChanceTable() {
		QueryFilter filter = new QueryFilter();
		filter.put("available", QcodeRedPacketChance.AVAILABLE_USABLE);
		this.update(filter);
	}

	@Override
	public int usableQcodeRedPacketChanceAcount() {
		QueryFilter filter = new QueryFilter();
		filter.put("available", QcodeRedPacketChance.AVAILABLE_USABLE);
		filter.setStatementKey(QcodeRedPacketChanceService.SELECTLIST_COUNT);
		return this.findOne(filter).getReturnObj();
	}

	@Override
	public boolean checkChanceNumAndUpdate(Integer chanceNum) {
		if(checkChanceNumExistAndUsable(chanceNum)){
			QueryFilter filter = new QueryFilter();
			filter.put("available", QcodeRedPacketChance.AVAILABLE_USELESS);
			filter.put("chanceNum", chanceNum);
			filter.setStatementKey(QcodeRedPacketChanceService.UPDATE_BY_CHANCENUM);
			this.update(filter);
			return true;
		}
		return false;
	}
	
	
//	public void insertRandom(int minValue, int maxValue, int count, double amount ) {  //插入随机数据
//		 
////		Set<Integer> set = new LinkedHashSet<>();//无顺序
//		Set<Integer> set = new TreeSet<>();//有序
//		while(set.size() < count){
//			int randomNumber = new Random().nextInt(maxValue) + minValue;  
//			if(!set.contains(randomNumber)){
//				set.add(randomNumber);
//				QcodeRedPacketChance qcodeRedPacketChance = new QcodeRedPacketChance();
//				qcodeRedPacketChance.setAmount(amount);
//				qcodeRedPacketChance.setChanceNum(randomNumber);
//				qcodeRedPacketChance.setAvailable(QcodeRedPacketChance.AVAILABLE_USABLE);
//				this.save(qcodeRedPacketChance);
//			}
//		}
//	}
	
	
	public void insertRandom(int minValue,  int count, String amount ) {  //插入随机数据
		Set<Integer> set = new LinkedHashSet<>();//无顺序
		while(set.size() < count){
			int randomNumber = new Random().nextInt(count) + minValue;  
			if(!set.contains(randomNumber)){
				set.add(randomNumber);
				QcodeRedPacketChance qcodeRedPacketChance = new QcodeRedPacketChance();
				qcodeRedPacketChance.setAmount(amount);
				qcodeRedPacketChance.setChanceNum(randomNumber);
				qcodeRedPacketChance.setAvailable(QcodeRedPacketChance.AVAILABLE_USABLE);
				this.save(qcodeRedPacketChance);
			}
		}
	}

	@Override
	public  String getAUsableQcodeRedPacketChanceAndUpdate() {
		synchronized (QcodeRedPacketChanceServiceImpl.class) { 
			QcodeRedPacketChance qcodeRedPacketChance = getAUsableQcodeRedPacketChance();
			QueryFilter filter = new QueryFilter() ;
			filter.put("available", QcodeRedPacketChance.AVAILABLE_USELESS);
			filter.put("id", qcodeRedPacketChance.getId());
			this.update(filter);
			return qcodeRedPacketChance.getAmount();
		}
	}
	
	public QcodeRedPacketChance getAUsableQcodeRedPacketChance() {
		synchronized (QcodeRedPacketChanceServiceImpl.class) {
			QueryFilter filter = new QueryFilter();
			filter.put("available", QcodeRedPacketChance.AVAILABLE_USABLE);
			filter.setStatementKey(QcodeRedPacketChanceService.SELECT_AN_USABLE_QCODE_RED_PACKET_CHANCE);
			QcodeRedPacketChance qcodeRedPacketChance = this.findOne(filter).getReturnObj();
			while (qcodeRedPacketChance == null) {// 没有可用的数据，恢复数据表的所有数据可用
				recoveryQcodeRedPacketChanceTable();
				int usableQcodeRedPacketChanceAcount = usableQcodeRedPacketChanceAcount();
				if (usableQcodeRedPacketChanceAcount >= 0) {// 恢复后，有可用数据
					qcodeRedPacketChance = this.findOne(filter).getReturnObj();
				} else {// 恢复后，还是没有可用数据
					logger.error("QcodeRedPacketChance表中无可用数据，请检查");
					return null;
				}
			}
			return qcodeRedPacketChance;
		}
	}
}
