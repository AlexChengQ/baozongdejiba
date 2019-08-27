package com.bylz.quantumCloud.admin.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.bylz.quantumCloud.service.SysUserRoleService;
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
import com.bylz.quantumCloud.model.SysRole;
import com.bylz.quantumCloud.model.SysRoleResource;
import com.bylz.quantumCloud.service.SysRoleResourceService;
import com.bylz.quantumCloud.service.SysRoleService;

/**
 * 系统角色 Controller
 * @author lxt
 * @since  2017-04-06
 */
@Controller
@RequestMapping("/SysRole")
public class SysRoleController extends BaseController{

    @Autowired
    private SysRoleService service;
    
    @Autowired
    private SysRoleResourceService resourceService;

    @Autowired
    private SysRoleService sysRoleService;

    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter(request);
        filter.put("order"," role_id desc ");
        model.put("pager", service.findPager(filter).getReturnObj());
        return "/SysRole/index";
    }

    @RequestMapping(value = "/add.html")
    public String add(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        model.put("roleLists", service.findList(new QueryFilter()).getReturnObj());
        return "/SysRole/add";
    }

    @RequestMapping(value = "/save.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData save(ModelMap model, @ModelAttribute("entity") SysRole entity, HttpServletRequest request,
            HttpServletResponse response) {
        Map<String, Object> errors = FormValidatorManager.validate("saveSysRoleConfig", request);
        if (errors.size() != 0) {
            return new ResponseData(false, errors);
        }
        try {
            if (entity != null) {
                entity.setEnabled(1);// '是否生效(0:无效,1:有效)'
                entity.setParentId(0L);
            } else {
                errors.put("操作失败", "error");
                return new ResponseData(false, errors);
            }

            String resources = request.getParameter("resources");
            if (resources == null || "".equals(resources)) {
                errors.put("请选择角色资源", "resources");
                return new ResponseData(false, errors);
            }

            Result result = service.save(entity);
            if (result.isSuccess()) {// 角色添加成功，处理资源信息
                String[] resourcesStr = resources.split(",");
                SysRole sysRole = result.getReturnObj();
                for (String str : resourcesStr) {
                    SysRoleResource roleResource = new SysRoleResource();
                    roleResource.setRoleId(sysRole.getRoleId());
                    if (str.equals("0")) {
                        str = ":sys:index";
                    }
                    roleResource.setResource(str);
                    resourceService.save(roleResource);
                }
            } else {
                errors.put("操作失败", "error");
                return new ResponseData(false, errors);
            }
        } catch (DuplicateKeyException e) {
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
                errors.put("id  重复", "id");
            }else if (e.getRootCause().getMessage().toUpperCase().contains("ROLENAME")) {
                errors.put("角色名称  重复", "rolename");
            }else{
                errors.put("操作失败", "error");
            }
            return new ResponseData(false, errors);
        } catch (Exception e) {
            errors.put("操作失败", "error");
            return new ResponseData(false, errors);
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    @RequestMapping(value = "/detail.html")
    public String detail(@ModelAttribute("roleId")Long roleId, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("roleId", roleId);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        //根据roleId获取角色资源信息
        List<SysRoleResource> list = resourceService.findList(filter).getReturnObj();
        String resourceStrs="";
        for (SysRoleResource sysRoleResource : list) {
            if (sysRoleResource != null && sysRoleResource.getResource() != null) {
                if (resourceStrs == null || "".equals(resourceStrs)) {
                    if (sysRoleResource.getResource().equals(":sys:index")) {
                        resourceStrs = "0";
                    } else {
                        resourceStrs = sysRoleResource.getResource();
                    }
                } else {
                    if (sysRoleResource.getResource().equals(":sys:index")) {
                        resourceStrs = resourceStrs + ",0";
                    } else {
                        resourceStrs = resourceStrs + "," + sysRoleResource.getResource();
                    }
                }
            }
        }
        request.setAttribute("resourceStrs", resourceStrs);
        return "/SysRole/detail";
    }

    @RequestMapping(value = "/edit.html")
    public String edit(@ModelAttribute("roleId")Long roleId, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("roleId", roleId);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        // 根据roleId获取角色资源信息
        List<SysRoleResource> list = resourceService.findList(filter).getReturnObj();
        String resourceStrs = "";
        for (SysRoleResource sysRoleResource : list) {
            if (sysRoleResource != null && sysRoleResource.getResource() != null) {
                if (resourceStrs == null || "".equals(resourceStrs)) {
                    if (sysRoleResource.getResource().equals(":sys:index")) {
                        resourceStrs = "0";
                    } else {
                        resourceStrs = sysRoleResource.getResource();
                    }
                } else {
                    if (sysRoleResource.getResource().equals(":sys:index")) {
                        resourceStrs = resourceStrs + ",0";
                    } else {
                        resourceStrs = resourceStrs + "," + sysRoleResource.getResource();
                    }
                }
            }
        }
        request.setAttribute("resourceStrs", resourceStrs);
        return "/SysRole/edit";
    }

    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData update(ModelMap model, @ModelAttribute("entity") SysRole entity, HttpServletRequest request,
            HttpServletResponse response) {
        Map<String, Object> errors = FormValidatorManager.validate("saveSysRoleConfig", request);
        if (errors.size() != 0)
            return new ResponseData(false, errors);
        try {
            // 检查角色资源信息
            String resources = request.getParameter("resources");
            if (resources == null || "".equals(resources)) {
                errors.put("请选择角色资源", "resources");
                return new ResponseData(false, errors);
            }

            Result result = service.update(entity);

            if (result.isSuccess()) {// 角色添加成功，处理资源信息
                // 删除原有角色信息
                QueryFilter deleteFilter = new QueryFilter();
                deleteFilter.put("roleId", entity.getRoleId());
                Result delResult = resourceService.delete(deleteFilter);

                if (delResult.isSuccess()) {
                    // 重新添加角色资源信息
                    String[] resourcesStr = resources.split(",");
                    for (String str : resourcesStr) {
                        SysRoleResource roleResource = new SysRoleResource();
                        roleResource.setRoleId(entity.getRoleId());
                        if (str.equals("0")) {
                            str = ":sys:index";
                        }
                        roleResource.setResource(str);
                        resourceService.save(roleResource);
                    }
                } else {
                    errors.put("操作失败  ", "error");
                    return new ResponseData(false, errors);
                }
            } else {
                errors.put("操作失败  ", "error");
                return new ResponseData(false, errors);
            }
        } catch (DuplicateKeyException e) {
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
                errors.put("id  重复", "id");
            }
            if (e.getRootCause().getMessage().toUpperCase().contains("ROLENAME")) {
                errors.put("角色名称  重复", "id");
            }
            return new ResponseData(false, errors);
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    @RequestMapping(value = "/delete.json")
    @ResponseBody
    public ResponseData delete(@ModelAttribute("roleId")Long roleId, HttpServletRequest request, HttpServletResponse response) {
        try {
            if (roleId != null) {
                service.delete(roleId);
            }
        } catch (Exception e) {
            return new ResponseData(false, e.getMessage());
        }

        return ResponseData.SUCCESS_NO_DATA;
    }

    @RequestMapping(value="/relRole.json")
    @ResponseBody
    public ResponseData relRole(Long id, HttpServletRequest request, HttpServletResponse response){
        QueryFilter filter = new QueryFilter();
        filter.put("parentId", id);
        List<SysRole> list = sysRoleService.findList(filter).getReturnObj();
        if(list == null || list.size() <= 0){
            return new ResponseData(false);
        }else{
            return new ResponseData(true, JSON.toJSONString(list,true));
        }
    }
}
