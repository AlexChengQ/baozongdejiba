package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysLogService;
import com.bylz.quantumCloud.model.SysLog;

/**
 * 系统日志 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysLogServiceImpl extends BaseServiceImpl<SysLog, Long> implements SysLogService{

	public String getNamespace()
    {
        return SysLog.class.getSimpleName();
    }
}
