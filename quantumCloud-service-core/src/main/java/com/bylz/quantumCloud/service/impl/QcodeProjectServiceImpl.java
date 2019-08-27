package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.model.QcodeProject;

/**
 * 项目表 Service
 * @author liuxiantao
 * @since  2017-07-22
 * 
 */
@Component
public class QcodeProjectServiceImpl extends BaseServiceImpl<QcodeProject, Long> implements QcodeProjectService{

	public String getNamespace()
    {
        return QcodeProject.class.getSimpleName();
    }
}
