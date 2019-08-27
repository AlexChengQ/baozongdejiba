/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.model.QcodePushVo;
import com.bylz.quantumCloud.service.QcodePushService;

/**
 * 批量推送消息实现类
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月03日
 */
@Component
public class QcodePushServiceImpl extends BaseServiceImpl<QcodePushVo, Long> implements QcodePushService{
    public String getNamespace()
    {
        return QcodePushVo.class.getSimpleName();
    }
}
