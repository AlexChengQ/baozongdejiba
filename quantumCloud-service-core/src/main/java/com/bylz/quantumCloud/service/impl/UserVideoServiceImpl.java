/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.bylz.quantumCloud.model.UserExam;
import com.bylz.quantumCloud.model.UserVideo;
import com.bylz.quantumCloud.service.QcodeThirdLoginService;
import com.bylz.quantumCloud.service.UserVideoService;
import com.likegene.framework.core.BaseServiceImpl;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

/**
 * 申请Service实现类
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年03月30日
 */
@Component
public class UserVideoServiceImpl extends BaseServiceImpl<UserVideo, Long> implements UserVideoService {

    public String getNamespace() {
        return UserVideo.class.getSimpleName();
    }




}
