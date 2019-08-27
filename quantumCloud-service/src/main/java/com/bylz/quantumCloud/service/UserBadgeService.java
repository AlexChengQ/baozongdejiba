package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.UserBadge;
import com.likegene.framework.core.BaseService;
import com.likegene.framework.core.Result;

/**
 * 平台管理员 Service
 * 
 */
public interface UserBadgeService extends BaseService<UserBadge, Long>{

	Result save(UserBadge userBadge);
}
