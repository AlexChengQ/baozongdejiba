package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.QcodeRedPacket;

import java.util.Map;

import com.likegene.framework.core.BaseService;

/**
 * 红包表 Service
 * @author JT
 * @since  2018-01-29
 * 
 */
public interface QcodeRedPacketService extends BaseService<QcodeRedPacket, Long>{
	/**
	 * 是否已发送过红包
	 * @param openId 微信openId
	 * @param userId 用户Id
	 * @return Map 中 status 标识是否已经发送过，reason 标识不可发送的原因
	 * */
	 public  Map<String, Object>  hadSendRedPacket(String openId , long userId);
}
