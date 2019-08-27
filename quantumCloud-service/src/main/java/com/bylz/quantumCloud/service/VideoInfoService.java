package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;

import java.util.List;

/**
 * @author songhaozhang
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
public interface VideoInfoService extends BaseService<VideoInfoVo, Long> {


    /**
     * 添加观看次数
     */
    VideoInfoVo addReadCount(long videoId);



    /**
     * 根据视频Id，回复id查询当前回复所在页码
     */
    int getPagerNumById(QueryFilter filter);

    /**
     * 获取板块下最大vid
     * @param filter
     * @return
     */
    int getMaxVid(QueryFilter filter);

    List<ExamQuestionSet> getExamByVideo(long vid);

    int getHaveVideo(String title);
}
