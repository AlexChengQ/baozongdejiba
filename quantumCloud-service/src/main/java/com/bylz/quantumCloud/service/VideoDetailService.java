package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.VideoDetailVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;

import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/8
 */
public interface VideoDetailService extends BaseService<VideoDetailVo,Integer> {

    VideoDetailVo getVideoTotal(QueryFilter filter);

    List<Map> getVideoSingle(QueryFilter filter);

    Pagination getListVideo(QueryFilter filter);

    List<Map> videoList(QueryFilter filter);
}
