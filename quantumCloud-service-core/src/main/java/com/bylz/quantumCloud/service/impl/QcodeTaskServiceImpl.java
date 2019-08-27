package com.bylz.quantumCloud.service.impl;

import java.util.HashMap;
import org.springframework.stereotype.Component;
import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.impl.liangzi.HttpSendSetParam;
import com.bylz.quantumCloud.model.QcodeTask;

/**
 * 任务表 Service
 * @author JT
 * @since  2017-07-22
 * 
 */
@Component
public class QcodeTaskServiceImpl extends BaseServiceImpl<QcodeTask, Long> implements QcodeTaskService{

	public String getNamespace()
    {
        return QcodeTask.class.getSimpleName();
    }
	/**
	 * 提交task并获取taskId
	 * @param paramMap
	 * @return
	 * @2017-7-26上午8:55:39
	 * @JT
	 */
	@Override
	public String submitTask(HashMap<String, String> paramMap) {
		return  HttpSendSetParam.sent(paramMap).toString();
	}

	/**
	 * 提交task并获取taskId
	 * @param paramMap
	 * @return
	 * @2017-7-26上午8:55:39
	 * @JT
	 */
	@Override
	public String submitTaskNew(HashMap<String, String> paramMap) {
		return  HttpSendSetParam.sentNew(paramMap).toString();
	}

	/**
	 * 通过taskId查询task状态
	 * @param paramMap
	 * @return
	 * @2017-7-26上午8:55:39
	 * @JT
	 */
	@Override
	public String queryTask(HashMap<String, String> paramMap) {
		return  HttpSendSetParam.sent(paramMap).toString();
	}

    /**
     * 通过taskId查询task状态
     * @param paramMap
     * @return
     * @2017-7-26上午8:55:39
     * @JT
     */
    @Override
    public String queryTaskNew(HashMap<String, String> paramMap) {
        return  HttpSendSetParam.sentNew(paramMap).toString();
    }


    /**
	 * 通过taskId来终止task
	 * @param paramMap
	 * @return
	 * @2017-7-26上午8:55:39
	 * @JT
	 */
	@Override
	public String terminateTask(HashMap<String, String> paramMap) {
		return  HttpSendSetParam.sent(paramMap).toString();
	}		
	
	
	public String test(String url,HashMap<String, String> paramMap){
		return  HttpSendSetParam.doPost(url,paramMap).toString();
	}
}
