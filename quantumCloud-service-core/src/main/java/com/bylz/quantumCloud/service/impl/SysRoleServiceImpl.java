package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysRoleService;
import com.bylz.quantumCloud.model.SysRole;

/**
 * 系统角色 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole, Long> implements SysRoleService{

	public String getNamespace()
    {
        return SysRole.class.getSimpleName();
    }
}
