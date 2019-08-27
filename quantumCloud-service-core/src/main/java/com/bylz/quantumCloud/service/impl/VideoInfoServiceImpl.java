package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.TutorialReviewVo;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.bylz.quantumCloud.service.TutorialReviewService;
import com.bylz.quantumCloud.service.VideoInfoService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/8
 */
@Service
public class VideoInfoServiceImpl extends BaseServiceImpl<VideoInfoVo, Long> implements VideoInfoService {

    @Override
    public String getNamespace() {
        return VideoInfoVo.class.getSimpleName();
    }

	@Override
	public VideoInfoVo addReadCount(long videoId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPagerNumById(QueryFilter filter) {
		// TODO Auto-generated method stub
		return 0;
	}

	/**
	 * 获取板块下最大vid
	 *
	 * @param filter
	 * @return
	 */
	@Override
	public int getMaxVid(QueryFilter filter) {
		filter.setStatementKey("getMaxVid");
		return this.findOne(filter).getReturnObj();
	}

	@Override
	public List<ExamQuestionSet> getExamByVideo(long vid) {
		QueryFilter filter = new QueryFilter();
		filter.put("vid",vid);
		filter.setStatementKey("getExamByVideo");
		return this.findList(filter).getReturnObj();
	}

	@Override
	public int getHaveVideo(String title) {
		QueryFilter filter = new QueryFilter();
		filter.put("title",title);
		filter.setStatementKey("getHaveVideo");
		return this.findOne(filter).getReturnObj();
	}


}
