package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.SysConfig;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;

/**
 * 参数配置 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
public interface SysConfigService extends BaseService<SysConfig, Long>{
	
	/**
	 * 根据关键字及分类查询参数
	 */
	String SELECT_CONFIG_KEYNAME_CATEGROY = "selectConfigByKeyNameAndCategroy";
	String UPDATE_BY_KEYNAME_AND_CATEGROY = "updateByKeyNameAndCategroy";
	
	/**
	 * 修改定时器执行时间
	 * 
	 * @param triggerName 触发器名称
	 * @param minutes 执行时间 每多少分钟执行一次
	 * 
	 * @throws Exception
	 * 
	 * @author lvliang
	 * @since 2018-1-3
	 */
	void changeCronExpression(String triggerName,String minutes) throws Exception ;

	void updateDownloadCount(QueryFilter filter);
}
