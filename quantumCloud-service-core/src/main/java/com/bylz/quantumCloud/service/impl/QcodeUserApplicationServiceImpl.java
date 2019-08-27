package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.model.QcodeUserApplication;
import com.bylz.quantumCloud.service.QcodeUserApplicationService;

/**
 * qcode_user_application Service
 * @author JT
 * @since  2017-12-28
 * 
 */
@Component
public class QcodeUserApplicationServiceImpl extends BaseServiceImpl<QcodeUserApplication, Long> implements QcodeUserApplicationService{

	public String getNamespace()
    {
        return QcodeUserApplication.class.getSimpleName();
    }
}
