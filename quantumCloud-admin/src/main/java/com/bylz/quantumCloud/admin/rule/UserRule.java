package com.bylz.quantumCloud.admin.rule;

import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.formvalidator.BusinessLogicRule;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xielina on 2017/5/9 0009.
 */
@Component
public class UserRule extends BusinessLogicRule {
    @Autowired
    private SysUserService sysUserService;

    @Override
    public String getRuleName() {
        return "userRule";
    }

    @Override
    public Map<String, String> validate(Object config, Map<String, String> params) {
        Map<String, String> errorMap = new HashMap<String, String>();

        //检查用户名是否存在
        String username = params.get("username");
        String id = params.get("id");
        QueryFilter checkFilter = new QueryFilter();
        checkFilter.put("username", username);
        if(id!=null&&id.length()>0){    
            SysUser checkRole = sysUserService.findOne(checkFilter).getReturnObj();
            if (checkRole != null&&!(checkRole.getId().toString().equals(id))) {
                errorMap.put("username","登录名 已存在");
            }
        }else{
            SysUser checkRole = sysUserService.findOne(checkFilter).getReturnObj();
            if (checkRole != null) {
                errorMap.put("username","登录名 已存在");
            }
        }

        return errorMap;
    }
}
