package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysRoleResourceService;
import com.bylz.quantumCloud.model.SysRoleResource;

/**
 * 角色资源 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysRoleResourceServiceImpl extends BaseServiceImpl<SysRoleResource, SysRoleResource> implements SysRoleResourceService{

	public String getNamespace()
    {
        return SysRoleResource.class.getSimpleName();
    }
}
