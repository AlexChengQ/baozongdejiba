package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.VideoDetailVo;
import com.bylz.quantumCloud.service.VideoDetailService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/8
 */
@Service
public class VideoDetailServiceImpl extends BaseServiceImpl<VideoDetailVo,Integer> implements VideoDetailService{
    @Override
    public String getNamespace() {
        return VideoDetailVo.class.getSimpleName();
    }

    @Override
    public VideoDetailVo getVideoTotal(QueryFilter filter) {
        filter.setStatementKey("getVideoTotal");
        return this.findOne(filter).getReturnObj();
    }

    @Override
    public List<Map> getVideoSingle(QueryFilter filter) {
        filter.setStatementKey("getVideoSingle");
        return this.findList(filter).getReturnObj();
    }

    @Override
    public Pagination getListVideo(QueryFilter filter) {
        filter.setStatementKey("getListVideo");
        return this.findPager(filter).getReturnObj();
    }

    @Override
    public List<Map> videoList(QueryFilter filter) {
        filter.setStatementKey("getListVideo");
        return this.findList(filter).getReturnObj();
    }
}
