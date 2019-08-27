package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysUserRoleService;
import com.bylz.quantumCloud.model.SysUserRole;

/**
 * 用户角色 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysUserRoleServiceImpl extends BaseServiceImpl<SysUserRole, SysUserRole> implements SysUserRoleService{

	public String getNamespace()
    {
        return SysUserRole.class.getSimpleName();
    }
}
