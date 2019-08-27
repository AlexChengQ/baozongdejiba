/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;
import com.bylz.quantumCloud.model.UserScoreDetail;
import com.bylz.quantumCloud.model.UserVideo;
import com.bylz.quantumCloud.service.UserScoreDetailService;
import com.likegene.framework.core.BaseServiceImpl;


/**
 * 申请Service实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
@Component
public class UserScoreDetailServiceImpl extends BaseServiceImpl<UserScoreDetail, Long> implements UserScoreDetailService {

    public String getNamespace() {
        return UserVideo.class.getSimpleName();
    }



}
