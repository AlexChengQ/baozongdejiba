package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.StatisticsCountVo;
import com.likegene.framework.core.QueryFilter;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/2/26
 */
public interface StatisticsCountService {

    StatisticsCountVo getSataisticsCount(QueryFilter filter);
}
