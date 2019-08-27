/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service;

import com.likegene.framework.core.BaseService;
import com.bylz.quantumCloud.model.QcodeApply;

/**
 * 用户申请Service
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
public interface QcodeApplyService extends BaseService<QcodeApply, Long> {
    String  SELECT_INDEX_LIST = "selectIndexList";
    String  SELECT_APPLY_RECORD_LIST = "selectApplyRecordList";

}
