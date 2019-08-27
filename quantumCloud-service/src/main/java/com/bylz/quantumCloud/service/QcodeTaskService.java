package com.bylz.quantumCloud.service;

import java.util.HashMap;

import com.bylz.quantumCloud.model.QcodeTask;
import com.likegene.framework.core.BaseService;

/**
 * 任务表 Service
 * @author JT
 * @since  2017-07-22
 * 
 */
public interface QcodeTaskService extends BaseService<QcodeTask, Long>{
	
	String SELECT_INDEX_LIST = "selectIndexList";

	public String submitTask(HashMap<String, String> paramMap);
	
	public String queryTask(HashMap<String, String> paramMap);

	public String terminateTask(HashMap<String, String> paramMap);
	
	public String test(String url,HashMap<String, String> paramMap);

	public String submitTaskNew(HashMap<String, String> paramMap);

	public String queryTaskNew(HashMap<String, String> paramMap);
}
