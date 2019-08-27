package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.bylz.quantumCloud.service.BlockConfigService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/6
 */
public class BlockConfigServiceImpl extends BaseServiceImpl<BlockConfigVo,Long> implements BlockConfigService {

    @Override
    public String getNamespace() {
        return BlockConfigVo.class.getSimpleName();
    }

    @Override
    public List<VideoInfoVo> getVideoList(long block) {
        QueryFilter filter = new QueryFilter();
        filter.put("block",block);
        filter.setStatementKey("getVideoList");
        return this.findList(filter).getReturnObj();
    }

    @Override
    public List<ExamQuestionSet> getExamList(long block) {
        QueryFilter filter = new QueryFilter();
        filter.put("block",block);
        filter.setStatementKey("getExamList");
        return this.findList(filter).getReturnObj();
    }

    @Override
    public int getHaveBlockName(String blockName) {
        QueryFilter filter = new QueryFilter();
        filter.put("blockName",blockName);
        filter.setStatementKey("getHaveBlockName");
        return this.findOne(filter).getReturnObj();
    }
}
