package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.EduStatisticsVo;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/1
 */
@Service
public class EduStatisticsServiceImpl extends BaseServiceImpl<EduStatisticsVo,Integer> implements EduStatisticsService {

    @Override
    public String getNamespace() {
        return EduStatisticsVo.class.getSimpleName();
    }

    /**
     * 添加每天教育云数据统计
     */
    @Override
    public void addStatisticsTask() {
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("addEduStatistics");
        this.save(filter);
    }
}
