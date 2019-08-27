package com.bylz.quantumCloud.service.impl;

import java.text.ParseException;

import com.likegene.framework.core.QueryFilter;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.CronTriggerBean;
import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.service.SysConfigService;

/**
 * 参数配置 Service
 * 
 * @author JT
 * @since 2017-07-20
 * 
 */
@Component
public class SysConfigServiceImpl extends BaseServiceImpl<SysConfig, Long>
		implements SysConfigService {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());

	public String getNamespace() {
		return SysConfig.class.getSimpleName();
	}

	// spring-service.xml 注入
	private Scheduler scheduler;

	@Override
	public void changeCronExpression(String triggerName,String minutes) throws Exception {
		try {
			logger.debug("SysConfigServiceImpl changeCronExpression 触发器名称:"+triggerName+",间隔时间:"+minutes);
			
			CronTriggerBean trigger = (CronTriggerBean) scheduler.getTrigger(triggerName, Scheduler.DEFAULT_GROUP);
			trigger.setCronExpression("0 */"+minutes+" * * * ?");
			scheduler.rescheduleJob(triggerName,Scheduler.DEFAULT_GROUP, trigger);
		} catch (SchedulerException e1) {
			logger.error("调度程序异常："+e1);
		} catch (ParseException e1) {
			e1.printStackTrace();
			logger.error("解析异常："+e1);
		}
	}

	@Override
	public void updateDownloadCount(QueryFilter filter) {
		filter.setStatementKey("updateDownloadCount");
		this.update(filter);
	}

	public Scheduler getScheduler() {
		return scheduler;
	}

	public void setScheduler(Scheduler scheduler) {
		this.scheduler = scheduler;
	}

}
