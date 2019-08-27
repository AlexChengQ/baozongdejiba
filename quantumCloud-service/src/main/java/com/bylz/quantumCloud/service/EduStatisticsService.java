package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.EduStatisticsVo;
import com.likegene.framework.core.BaseService;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/1
 */
public interface EduStatisticsService extends BaseService<EduStatisticsVo,Integer> {

    /**
     * 添加每天教育云数据统计
     */
    void addStatisticsTask();
}
