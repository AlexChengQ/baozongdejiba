package com.bylz.quantumCloud.service;
import com.bylz.quantumCloud.model.UserScoreDetail;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Result;

/**
 * 平台管理员 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
public interface UserScoreDetailService extends BaseService<UserScoreDetail, Long>{

	Result save(UserScoreDetail userscoredetail);


}
