package com.bylz.quantumCloud.service;

import com.bylz.quantumCloud.model.SysRole;
import com.likegene.framework.core.BaseService;

/**
 * 系统角色 Service
 * @author liuxiantao
 * @since  2017-07-20
 * 
 */
public interface SysRoleService extends BaseService<SysRole, Long>{
	String SELECT_BY_ROLENAME = "selectByRoleName";
}
