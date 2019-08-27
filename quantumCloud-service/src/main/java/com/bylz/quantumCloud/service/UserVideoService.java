package com.bylz.quantumCloud.service;
import com.bylz.quantumCloud.model.UserVideo;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Result;

/**
 * 平台管理员 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
public interface UserVideoService extends BaseService<UserVideo, Long>{

	Result save(UserVideo userVideo);


}
