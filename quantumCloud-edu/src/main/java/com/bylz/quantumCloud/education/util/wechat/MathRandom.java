package com.bylz.quantumCloud.education.util.wechat;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.SpringBeanUtil;
import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.model.QcodeMethRandomEntity;
import com.bylz.quantumCloud.model.QcodeRedPacketChance;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.education.util.AESUtils;
import com.bylz.quantumCloud.service.QcodeRedPacketChanceService;
import com.bylz.quantumCloud.service.SysConfigService;

/**  
 * JAVA 返回随机数，并根据概率、比率  
 * @author houdongdong
 *  
 */    
public class MathRandom    
{    
	
	 private static QcodeRedPacketChanceService  qcodeRedPacketChanceService = SpringBeanUtil.getBean("qcodeRedPacketChanceService");
	 private static SysConfigService  sysConfigService = SpringBeanUtil.getBean("sysConfigService");;
	/**最小位数【生成多少条随机数】, 例如 0.0001 (万分之一，即为10000)*/
	 private static final int MIN_PERCENTILES = SettingUtil.getSetting("min_percentiles", Integer.class);
	
	/**指定的数据中，随机选中一个*/
	 public static Double percentageRandom(Map<String, Integer> keyChanceMap){
		 if(keyChanceMap == null || keyChanceMap.size() == 0)  
             return null;  
          
		Integer sum = 0;  
        for (Integer value : keyChanceMap.values()) {  
             sum += value;  
        }  
        
	   	 // 从1开始  
	     Integer randomNumber = new Random().nextInt(sum) + 1;  
         while(!isAvailable(randomNumber)){
        	 randomNumber = new Random().nextInt(sum) + 1;  
         }
         /*获取 随机数对应的金额 */
         QueryFilter filter = new  QueryFilter();
         filter.put("chanceNum", randomNumber);
         QcodeRedPacketChance   qcodeRedPacketChance = qcodeRedPacketChanceService.findOne(filter).getReturnObj();
         if(qcodeRedPacketChance != null){
        	 return  Double.valueOf(AESUtils.jdkAESDecode(qcodeRedPacketChance.getAmount()));
         }
        return null;  
	 }
	 
	 /**从数据表取出一个随机数使用*/
	 public static Double percentageRandom(){
		return  Double.valueOf(AESUtils.jdkAESDecode(qcodeRedPacketChanceService.getAUsableQcodeRedPacketChanceAndUpdate())); 
	 }
	 
	
	 /**检查随机数值是否可用*/
	private synchronized static boolean isAvailable(Integer randomNumber){
		return	qcodeRedPacketChanceService.checkChanceNumAndUpdate(randomNumber);
	}
	
	
	public static void  insertRandom(){ //插入随机数据
		 List<QcodeMethRandomEntity> QcodeMethRandomEntityList = new LinkedList<QcodeMethRandomEntity>();
		 Map<String, Integer> keyChanceMap = new HashMap<String,Integer>();
		{
			/*获取红包金额概率配置 开始*/
			QueryFilter filter = new QueryFilter();
			filter.put("category", SysConfig.REDPACKETCHANCECONFIG);
			filter.setStatementKey(SysConfigService.SELECT_CONFIG_KEYNAME_CATEGROY);
			List<SysConfig> sysConfigList = sysConfigService.findList(filter).getReturnObj();
			for (SysConfig sysConfig : sysConfigList) {
				QcodeMethRandomEntityList.add(new QcodeMethRandomEntity(Double.valueOf(sysConfig.getKeyname()),Double.valueOf(sysConfig.getVal())));
			}
			/*获取红包金额概率配置 开始*/
			for (QcodeMethRandomEntity qcodeMethRandomEntity : QcodeMethRandomEntityList) {
				
				Double chanceTemp = qcodeMethRandomEntity.getChance()*MIN_PERCENTILES;
				String ChanceString = chanceTemp.toString();
				String chanceTempSubstring = ChanceString.substring(0, ChanceString.indexOf("."));
				keyChanceMap.put(qcodeMethRandomEntity.getAmount().toString(),Integer.valueOf(chanceTempSubstring));
			}
		}
		int minValue = 1 ;
		int count = 0;
		qcodeRedPacketChanceService.delete(new QueryFilter());//清空表中数据
		for (QcodeMethRandomEntity qcodeMethRandomEntity : QcodeMethRandomEntityList) {
			count = (int) (qcodeMethRandomEntity.getChance()*MIN_PERCENTILES);
			qcodeRedPacketChanceService.insertRandom(minValue, count, AESUtils.jdkAESEncode(qcodeMethRandomEntity.getAmount().toString()) );
			minValue +=  (qcodeMethRandomEntity.getChance()*MIN_PERCENTILES);
		}
	}
	
}
