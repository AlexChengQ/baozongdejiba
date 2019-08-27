package com.bylz.quantumCloud.service.impl;

import org.springframework.stereotype.Component;

import com.likegene.framework.core.BaseServiceImpl;
import com.bylz.quantumCloud.service.SysUserService;
import com.bylz.quantumCloud.model.SysUser;

/**
 * 平台管理员 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
@Component
public class SysUserServiceImpl extends BaseServiceImpl<SysUser, Long> implements SysUserService{

	public String getNamespace()
    {
        return SysUser.class.getSimpleName();
    }
}
