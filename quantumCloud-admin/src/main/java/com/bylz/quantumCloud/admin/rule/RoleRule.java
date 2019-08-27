package com.bylz.quantumCloud.admin.rule;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bylz.quantumCloud.model.SysRole;
import com.bylz.quantumCloud.service.SysRoleService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.formvalidator.BusinessLogicRule;

/**
 * Description of the class
 *
 * @author            liuxiantao
 * @version           1.0
 * @since             2017-5-9
 */
@Component
public class RoleRule extends BusinessLogicRule
{
    @Autowired
    private SysRoleService sysRoleService;
    @Override
    public String getRuleName()
    {
        return "roleRule";
    }

    @Override
    public Map<String,String> validate(Object config, Map<String, String> params)
    {
        Map<String, String> errorMap = new HashMap<String, String>();
        
        // 检查角色名称是否存在
        String roleName = params.get("roleName");
        if (Strings.isEmpty(roleName)) {
            errorMap.put("roleName","角色名称 不能为空");
            return errorMap;
        }
        String roleId = params.get("roleId");
        QueryFilter checkFilter = new QueryFilter(SysRoleService.SELECT_BY_ROLENAME);
        checkFilter.put("roleName", roleName);
        if(roleId!=null&&roleId.length()>0){
            checkFilter.put("roleId",roleId);
        }
        SysRole checkRole = sysRoleService.findOne(checkFilter).getReturnObj();
        if (checkRole != null) {
            errorMap.put("roleName","角色名称 已存在");
        }
        return errorMap;
    }

}

