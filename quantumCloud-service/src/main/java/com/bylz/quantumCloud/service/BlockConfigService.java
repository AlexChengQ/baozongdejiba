package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.likegene.framework.core.BaseService;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/6
 */
public interface BlockConfigService extends BaseService<BlockConfigVo,Long> {

    List<VideoInfoVo> getVideoList(long block);

    List<ExamQuestionSet> getExamList(long block);

    int getHaveBlockName(String blockName);
}
