package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.StatisticsCountVo;
import com.bylz.quantumCloud.service.StatisticsCountService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/2/26
 */
public class StatisticsCountServiceImpl extends BaseServiceImpl<StatisticsCountVo, Integer> implements StatisticsCountService {
    @Override
    public StatisticsCountVo getSataisticsCount(QueryFilter filter) {
        filter.setStatementKey("statisticsCount");
        return this.findOne(filter).getReturnObj();
    }

    @Override
    public String getNamespace() {
        return StatisticsCountVo.class.getSimpleName();
    }
}
