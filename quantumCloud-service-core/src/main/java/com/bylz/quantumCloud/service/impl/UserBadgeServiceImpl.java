/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.bylz.quantumCloud.model.UserBadge;
import com.bylz.quantumCloud.model.UserVideo;
import com.bylz.quantumCloud.service.UserBadgeService;
import com.likegene.framework.core.BaseServiceImpl;

/**
 * 申请Service实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
@Component
public class UserBadgeServiceImpl extends BaseServiceImpl<UserBadge, Long> implements UserBadgeService {

    public String getNamespace() {
        return UserBadge.class.getSimpleName();
    }

}
