/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Component;

import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.service.ExamQuestionSetService;
import com.likegene.framework.core.BaseServiceImpl;

import java.util.List;

/**
 * 申请Service实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
@Component
public class ExamQuestionSetServiceImpl extends BaseServiceImpl<ExamQuestionSet, Long> implements ExamQuestionSetService {

    public String getNamespace() {
        return ExamQuestionSet.class.getSimpleName();
    }

    /**
     * 获取试题表中最大questionId
     *
     * @param filter
     * @return
     */
    @Override
    public int getMaxQuestionId(QueryFilter filter) {
        filter.setStatementKey("getMaxQuestionId");
        return this.findOne(filter).getReturnObj();
    }

    @Override
    public void saveExam(ExamQuestionSet examQuestionSet) {
        QueryFilter filter = new QueryFilter(examQuestionSet);
        filter.setStatementKey("saveExam");
        this.save(filter);
    }

    @Override
    public List<BlockConfigVo> getBlock(QueryFilter filter) {
        filter.setStatementKey("getBlock");
        return this.findList(filter).getReturnObj();
    }

    @Override
    public List<VideoInfoVo> getVideoByBlock(QueryFilter filter) {
        filter.setStatementKey("getVideoByBlock");
        return this.findList(filter).getReturnObj();
    }
}
