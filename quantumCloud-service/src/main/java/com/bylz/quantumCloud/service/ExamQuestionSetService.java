package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.BlockConfigVo;
import com.bylz.quantumCloud.model.ExamQuestionSet;
import com.bylz.quantumCloud.model.VideoInfoVo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

import java.util.List;

/**
 * 平台管理员 Service
 * 
 */
public interface ExamQuestionSetService extends BaseService<ExamQuestionSet, Long>{

	Result save(ExamQuestionSet examQuestionSet);

	/**
	 * 获取试题表中最大questionId
	 * @param filter
	 * @return
	 */
	int getMaxQuestionId(QueryFilter filter);


	void saveExam(ExamQuestionSet examQuestionSet);

	List<BlockConfigVo> getBlock(QueryFilter filter);

	List<VideoInfoVo> getVideoByBlock(QueryFilter filter);

}
