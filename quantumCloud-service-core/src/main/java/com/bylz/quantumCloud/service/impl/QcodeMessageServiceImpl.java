package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.QcodeMessageService;
import com.bylz.quantumCloud.model.QcodeMessage;

/**
 * 留言表 Service
 * @author liuxiantao
 * @since  2017-12-26
 * 
 */
@Component
public class QcodeMessageServiceImpl extends BaseServiceImpl<QcodeMessage, Long> implements QcodeMessageService{

	public String getNamespace()
    {
        return QcodeMessage.class.getSimpleName();
    }
}
