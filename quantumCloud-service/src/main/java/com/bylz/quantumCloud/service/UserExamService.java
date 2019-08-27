package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.UserExam;
import com.bylz.quantumCloud.model.UserVideo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

/**
 * 平台管理员 Service
 * 
 */
public interface UserExamService extends BaseService<UserExam, Long>{

	Result save(UserExam userexam);
}
