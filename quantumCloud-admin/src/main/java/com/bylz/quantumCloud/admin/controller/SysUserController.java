package com.bylz.quantumCloud.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.model.SysUserRole;
import com.bylz.quantumCloud.service.SysRoleService;
import com.bylz.quantumCloud.service.SysUserRoleService;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.likegene.framework.core.formvalidator.FormValidatorManager;
import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.SysUserService;

/**
 * 平台管理员 Controller
 * @author lxt
 * @since  2017-04-06
 */
@Controller
@RequestMapping("/SysUser")
public class SysUserController extends BaseController{
	/**
	 * 默认平台账号密码
	 */
	private static final String DEFAULT_PASSWORD=SettingUtil.getSetting("default.password", null).toString();
	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private SysRoleService sysRoleService;

	@Autowired
	private SysUserRoleService sysUserRoleService;

	@RequestMapping(value = "/index.html")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter(request);
		filter.setStatementKey("selectListWithRole");
		filter.put("order"," id desc ");
		//filter.put("isSuperadmin", 0);
        model.put("pager", sysUserService.findPager(filter).getReturnObj());
		return "/SysUser/index";
	}
	
	@RequestMapping(value = "/add.html")
	public String add(HttpServletRequest request, HttpServletResponse response) {
		return "/SysUser/add";
	}
	
	@RequestMapping(value = "/save.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData save(ModelMap model, @ModelAttribute("entity") SysUser entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
			Map<String,Object> errors = FormValidatorManager.validate("saveSysUserConfig", request);
	        if (errors.size() != 0)
	        {
	            return new ResponseData(false, errors.keySet().toString());
	        }
	        // 用户密码MD5加密
	     	entity.setPassword(new Md5Hash(DEFAULT_PASSWORD).toHex());
		    Result result = sysUserService.save(entity);
		    if (!result.isSuccess()) {
		    	return new ResponseData(false, result.getErrormsg());
	        }
	    }catch(DuplicateKeyException e){
	        	Result result = new Result();
	            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")){
	                result.addErrormsg("id  重复");
	            }
	            return new ResponseData(false, result.getErrormsg());
        } catch(Exception e)
        {
            return new ResponseData(false, e.getMessage());
        }
        return ResponseData.SUCCESS_NO_DATA;
	} 
	
	@RequestMapping(value = "/detail.html")
    public String detail(Long id, HttpServletRequest request, HttpServletResponse response) {
    	QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", sysUserService.findOne(filter).getReturnObj());
        return "/SysUser/detail";
    }

	@RequestMapping(value = "/edit.html")
    public String edit(Long id, HttpServletRequest request, HttpServletResponse response) {
    	QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", sysUserService.findOne(filter).getReturnObj());
        return "/SysUser/edit";
    }
    
    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
	public ResponseData update(ModelMap model, @ModelAttribute("entity") SysUser entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
			Map<String,Object> errors = FormValidatorManager.validate("saveSysUserConfig", request);
	        if (errors.size() != 0)
	        {
	            return new ResponseData(false, errors.keySet().toString());
	        }
		    Result result = sysUserService.update(entity);
		    if (!result.isSuccess()) {
		    	return new ResponseData(false, result.getErrormsg());
	        }
        }catch(DuplicateKeyException e){
        	Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")){
                result.addErrormsg("id  重复");
            }
            return new ResponseData(false, result.getErrormsg());
        } catch(Exception e)
        {
            return new ResponseData(false, e.getMessage());
        }
	    return ResponseData.SUCCESS_NO_DATA;
	}
	
	@RequestMapping(value="/delete.json")
	@ResponseBody
    public ResponseData delete(Long id, HttpServletRequest request, HttpServletResponse response)
    {
    	try{
	    	if (id != null)
	      	{
	    		sysUserService.delete(id);
	      	}
      	}catch(Exception e){
            return new ResponseData(false, e.getMessage());
        }
      	
      	return ResponseData.SUCCESS_NO_DATA;
    }
	
	/** 重置密码*/
	@RequestMapping(value="/reset.json")
	@ResponseBody
    public ResponseData reset(Long[] ids, HttpServletRequest request, HttpServletResponse response){
		try{
			for (Long id : ids){
				SysUser entity = new SysUser();
				entity.setId(id);
				entity.setPassword(new Md5Hash(DEFAULT_PASSWORD).toHex());
				sysUserService.update(entity);
	      	}
	  		return ResponseData.SUCCESS_NO_DATA;
		}catch(Exception e){
			e.printStackTrace();
			return ResponseData.FAILED_NO_DATA;
		}
    }

	/**用户授权操作页面*/
	@RequestMapping(value = "/authorization.html")
	public String authorization(Long id, HttpServletRequest request, HttpServletResponse response) {
		QueryFilter filter = new QueryFilter();
		filter.put("id", id);
		request.setAttribute("entity", sysUserService.findOne(filter).getReturnObj());

		//获取部门列表
		QueryFilter roleFilter = new QueryFilter();
		roleFilter.put("enabled", 1);//选取有效角色
		request.setAttribute("roleList", sysRoleService.findList(roleFilter).getReturnObj());

		return "/SysUser/authorization";
	}

	/**授权操作*/
	@RequestMapping(value="/authorization.json")
	@ResponseBody
	public ResponseData authorization(ModelMap model, @ModelAttribute("entity") SysUser entity,Long roleId, HttpServletRequest request, HttpServletResponse response){
		try {
			if(entity==null || entity.getId()==null){
				return new ResponseData(false, "授权失败");
			}else if(roleId==null || "".equals(roleId)){
				return new ResponseData(false, "请选择用户角色");
			}else{
				//判断该用户是否已分配角色 若分配 则修改
				QueryFilter checkFilter = new QueryFilter();
				checkFilter.put("userId", entity.getId().toString());
				SysUserRole checkUserRole=sysUserRoleService.findOne(checkFilter).getReturnObj();
				Result result=null;
				if(checkUserRole!=null){
					checkUserRole.setRoleId(roleId);
					result=sysUserRoleService.update(checkUserRole);
				}else{
					checkUserRole=new SysUserRole();
					checkUserRole.setRoleId(roleId);
					checkUserRole.setUserId(entity.getId());
					result=sysUserRoleService.save(checkUserRole);
				}
				if (!result.isSuccess()) {
					model.putAll(result);
					return new ResponseData(false, result);
				}
			}
		} catch (Exception e) {
			return new ResponseData(false, "授权失败");
		}
		return ResponseData.SUCCESS_NO_DATA;
	}
	
	/**
	 * 
	 * 修改密码
	 *
	 * @param request
	 * @param response
	 * @return
	 * @author wuhao
	 * @since 2018-1-8
	 */
	@RequestMapping(value = "/changePwd.html")
    public String changePwd(HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter(request);
        SysUser user = sysUserService.findOne(filter).getReturnObj();
        request.setAttribute("entity", user);
        return "/SysUser/change_pwd";
    }
	/**
	 * 
	 * 修改密码接口
	 *
	 * @param model
	 * @param entity
	 * @param request
	 * @param response
	 * @return
	 * @author wuhao
	 * @since 2018-1-8
	 */
	@RequestMapping(value = "/changePwd.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData changePwd(ModelMap model, @ModelAttribute("entity") SysUser entity , HttpServletRequest request, HttpServletResponse response) {
        try{
            Map<String,Object> errors = FormValidatorManager.validate("saveSysUserPwd", request);
            if (errors.size() != 0){
                return new ResponseData(false, errors.keySet().toString());
            }
            entity.setPassword(new Md5Hash(entity.getPassword()).toHex());
            Result result = sysUserService.update(entity);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
        }catch(DuplicateKeyException e){
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")){
                result.addErrormsg("id  重复");
            }
            return new ResponseData(false, result.getErrormsg());
        } catch(Exception e){
            return new ResponseData(false, e.getMessage());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }
}
