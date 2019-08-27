package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.QcodeProjectVersionService;
import com.bylz.quantumCloud.model.QcodeProjectVersion;

/**
 * 项目版本表 Service
 * @author JT
 * @since  2017-07-25
 * 
 */
@Component
public class QcodeProjectVersionServiceImpl extends BaseServiceImpl<QcodeProjectVersion, Long> implements QcodeProjectVersionService{

	public String getNamespace()
    {
        return QcodeProjectVersion.class.getSimpleName();
    }
}
