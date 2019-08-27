package com.bylz.quantumCloud.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.QcodeRedPacket;
import com.bylz.quantumCloud.service.QcodeRedPacketService;

/**
 * 红包表 Service
 * @author JT
 * @since  2018-01-29
 * 
 */
@Component
public class QcodeRedPacketServiceImpl extends BaseServiceImpl<QcodeRedPacket, Long> implements QcodeRedPacketService{

	public String getNamespace()
    {
        return QcodeRedPacket.class.getSimpleName();
    }
	
	   /**是否已经发送过红包 ,加了类锁同步 */
    public Map<String, Object> hadSendRedPacket(String openId , long userId){
		Map<String, Object> resultMap = new HashMap<>();
    	boolean status = false;
    	String reason = null ;
    	QueryFilter filter = new QueryFilter();
    	filter.put("userId", userId);
    	filter.put("status", QcodeRedPacket.STATUS_SUCCESS);
    	QcodeRedPacket qcodeRedPacket = this.findOne(filter).getReturnObj();
    	if(qcodeRedPacket != null){
    		status = true ;
			reason = "很抱歉，该量子云用户已领取红包";
    	}
    	
    	if(!status){//如果查userId 的结果是未领取，则查询微信openId是否领过
    		filter.clear();
    		filter.put("openId", openId);
    		filter.put("status", QcodeRedPacket.STATUS_SUCCESS);
    		qcodeRedPacket = this.findOne(filter).getReturnObj();
    		if(qcodeRedPacket != null){
        		status = true ;
    			reason = "很抱歉，该微信用户已领取红包";
        	}
    	}
    	resultMap.put("status", status);
    	resultMap.put("reason", reason);
		return resultMap;
    }
}
