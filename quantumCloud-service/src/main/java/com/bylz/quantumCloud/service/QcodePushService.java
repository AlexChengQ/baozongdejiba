/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service;

import com.likegene.framework.core.BaseService;
import com.bylz.quantumCloud.model.QcodePushVo;

/**
 * 批量推送消息Service
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月03日
 */
public interface QcodePushService extends BaseService<QcodePushVo, Long> {
    String  SELECT_INDEX_LIST = "selectIndexList";
}
