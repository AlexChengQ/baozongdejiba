package com.bylz.quantumCloud.mobile.service.tag;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.SysUserService;

import freemarker.template.SimpleHash;
import freemarker.template.TemplateModel;

/**
 * sys_user tag
 * @author            JT
 * @since             2017-06-15
 */
@Component
public class SysUserTag extends BaseTag{

    @Autowired
    private SysUserService sysUserService;
	
    @Override
    public void process(String method, Map params, String var, SimpleHash result,
            TemplateModel[] loopVars)
    {
        if("getUserNameInfoByUserId".equals(method)){
            result.put("mobile", getUserNameInfoByUserId(params));
        }else if("getEmployeeByUserId".equals(method)){
        	result.put("employee", getEmployeeByUserId(params));
        }
    }

    /**根据user_id获取用户联系方式（用户名称为手机号）*/
    private String getUserNameInfoByUserId(Map params){
        QueryFilter filter = new QueryFilter();
        filter.put("userId", params.get("user_id").toString());
        SysUser user=sysUserService.findOne(filter).getReturnObj();
        if(user==null || user.getUsername()==null || "".equals(user.getUsername())){
        	return null;
        }else{
        	return user.getUsername();
        }
    }
	

    /**根据user_id获取员工信息*/
    private Map<String,Object> getEmployeeByUserId(Map params){
        QueryFilter filter = new QueryFilter();
        filter.setStatementKey("selectEmployeeByUserId");
        filter.put("userId", params.get("user_id").toString());
        return sysUserService.findOne(filter).getReturnObj();
    }
    
}
