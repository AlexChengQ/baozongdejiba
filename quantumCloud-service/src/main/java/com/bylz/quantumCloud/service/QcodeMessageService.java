package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.QcodeMessage;
import com.likegene.framework.core.BaseService;

/**
 * 留言表 Service
 * @author liuxiantao
 * @since  2017-12-26
 * 
 */
public interface QcodeMessageService extends BaseService<QcodeMessage, Long>{
	String  SELECT_INDEX_LIST = "selectIndexList";
}
