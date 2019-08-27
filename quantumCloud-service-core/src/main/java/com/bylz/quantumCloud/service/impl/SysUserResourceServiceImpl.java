package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysUserResourceService;
import com.bylz.quantumCloud.model.SysUserResource;

/**
 * 用户资源 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysUserResourceServiceImpl extends BaseServiceImpl<SysUserResource, Long> implements SysUserResourceService{

	public String getNamespace()
    {
        return SysUserResource.class.getSimpleName();
    }
}
