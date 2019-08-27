package com.bylz.quantumCloud.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.SysConfigService;
import com.bylz.quantumCloud.utils.DateUtils;


/**
 * 任务更新定时器
 * @author JT
 */
public class QuartzUpdateTask{
	@Autowired
	private QcodeTaskService qcodeTaskService;	
	@Autowired
	private SysConfigService sysConfigService;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
    /**
     * 定时查询任务并更新
     * @2018-1-2上午11:46:25
     * @JT
     */
    public void updateTaskMethod() throws Exception { 
        QueryFilter filter = new QueryFilter();
        List<String> statusList = new ArrayList<String>();
        statusList.add(QcodeTask.STATUS_PROCESS);
        statusList.add(QcodeTask.STATUS_WAITING);
        filter.put("statusList", statusList);
        filter.setStatementKey("getRunningTask");
        List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
        for(int i=0;i<taskList.size();i++){
        	QcodeTask task = taskList.get(i);
        	filter.clear();
        	filter.put("id", task.getId());
        	//查询任务当前状态
        	task = qcodeTaskService.findOne(filter).getReturnObj();
        	if(task.getStatus().equals(QcodeTask.STATUS_WAITING)||task.getStatus().equals(QcodeTask.STATUS_PROCESS)){
            	HashMap paramAns = new HashMap();
            	paramAns.put("taskid", task.getTaskId());
				paramAns.put("typ", "qrytask");
            	String s2 = qcodeTaskService.queryTask(paramAns);
            	JSONObject json = JSONObject.parseObject(s2);
            	if(json.size()==0){
            		logger.debug("查询任务方法queryTask,http请求无返回",task.getTaskId());
            	}
            	//任务状态
            	String tasksta = (String) json.get("tasksta");
				task.setEndTime(new Date());
            	if(tasksta!=null&&!"".equals(tasksta)){
                	switch(tasksta){
                	case "1":
                	    //等待
                		task.setStatus(QcodeTask.STATUS_WAITING);
                	    break;
                	case "2":
                	    //处理中
                		task.setStatus(QcodeTask.STATUS_PROCESS);
                	    break;
                	case "3":
                		Object ans = json.get("taskrs");
                		if(ans!=null&&!("".equals(ans))){
                			//有结果且正确
                			task.setStatus(QcodeTask.STATUS_RESULT);
                			task.setAns(ans.toString());
                		}else{
                			//有结果为空，语法错误
                			task.setStatus(QcodeTask.STATUS_ERROR);
                		}
                	    break;  
                	default:
                	    break;
                	}
            	}

                Result result = qcodeTaskService.update(task);
                if (!result.isSuccess()) {
                	logger.debug("定时任务方法updateTaskMethod更新任务出错",task.getTaskId());
                }        		
        	}
 
        }

    }  
    
    /**
     * 超过10分钟的任务自动停止
     * @2018-1-2上午11:46:25
     * @JT
     */
    public void terminateTaskMethod(){ 
        QueryFilter filter = new QueryFilter();
        List<String> statusList = new ArrayList<String>();
        statusList.add(QcodeTask.STATUS_PROCESS);
        statusList.add(QcodeTask.STATUS_WAITING);
        filter.put("statusList", statusList);
        filter.setStatementKey("getRunningTask");
        List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
        
        //查询后台配置的定时时间
        filter = new QueryFilter();
        filter.put("keyname", SysConfig.TERMINATE_TASK_TRIGGER);
        filter.put("category", SysConfig.CATEGORY_CONFIG);
        SysConfig config = sysConfigService.findOne(filter).getReturnObj();
        int minutes = 5;
        if(config!=null && config.getVal()!=null && !"".equals(config.getVal())){
        	Pattern p = Pattern.compile("[0-9]+"); 
            Matcher m = p.matcher(config.getVal()); 
            if(m.matches()){
            	minutes = Integer.parseInt(config.getVal());
            }else{
            	minutes = 5;
            }
        }
        
        for(int i=0;i<taskList.size();i++){
        	QcodeTask task = taskList.get(i);
        	filter.clear();
        	filter.put("id", task.getId());
        	//查询任务当前状态
        	task = qcodeTaskService.findOne(filter).getReturnObj();
        	if(task.getStatus().equals(QcodeTask.STATUS_WAITING)||task.getStatus().equals(QcodeTask.STATUS_PROCESS)){
	        	if(DateUtils.addMiunte(task.getStartTime(), minutes).before(new Date())){
		        	task.setStatus(QcodeTask.STATUS_END);
		        	task.setEndTime(new Date());
		        	Result result = qcodeTaskService.update(task);
		    		if(!result.isSuccess()){
		    			logger.debug("终止任务方法terminateTaskMethod更新任务状态出错",task.getTaskId());
		    		} 
		    		//调用终止任务借口
					HashMap paramAns = new HashMap();
		        	paramAns.put("impTyp", "2");
		        	paramAns.put("taskTyp", task.getType());
		        	paramAns.put("typ", "updtask");
		        	paramAns.put("taskid", task.getId());        	
		        	//终止任务
		        	qcodeTaskService.terminateTask(paramAns);
	        	}
        	}
        }

    }
    
}
