/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.model.QcodeApply;
import com.bylz.quantumCloud.service.QcodeApplyService;

/**
 * 申请Service实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
@Component
public class QcodeApplyServiceImpl extends BaseServiceImpl<QcodeApply, Long> implements QcodeApplyService {

    public String getNamespace() {
        return QcodeApply.class.getSimpleName();
    }

}
