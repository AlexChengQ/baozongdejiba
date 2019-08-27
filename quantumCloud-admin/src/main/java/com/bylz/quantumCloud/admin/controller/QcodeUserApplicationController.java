package com.bylz.quantumCloud.admin.controller;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.service.QcodeUserApplicationService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.QcodeUserApplication;
import com.bylz.quantumCloud.model.SysUser;
import com.likegene.framework.core.formvalidator.FormValidatorManager;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * qcode_user_application Controller
 * @author JT
 * @since  2017-12-28
 */
@Controller
@RequestMapping("/QcodeUserApplication")
public class QcodeUserApplicationController extends BaseController{
	
	@Autowired
	private QcodeUserApplicationService service;
	
	@Autowired
	private QcodeUserService qcodeUserService;
	

	@RequestMapping(value = "/index.html")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter(request);
        filter.put("order", "create_time DESC");
        model.put("pager", service.findPager(filter).getReturnObj());
		return "/QcodeUserApplication/index";
	}
	
	@RequestMapping(value = "/add.html")
	public String add(HttpServletRequest request, HttpServletResponse response) {
		return "/QcodeUserApplication/add";
	}
	
	@RequestMapping(value = "/save.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData save(ModelMap model, @ModelAttribute("entity") QcodeUserApplication entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
			Map<String,Object> errors = FormValidatorManager.validate("saveQcodeUserApplicationConfig", request);
	        if (errors.size() != 0)
	        {
	            return new ResponseData(false, errors.keySet().toString());
	        }
		    Result result = service.save(entity);
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
    	filter.setStatementKey(QcodeUserApplicationService.SELECT_DETAIL);
        filter.put("id", id);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        return "/QcodeUserApplication/detail";
    }

	@RequestMapping(value = "/edit.html")
    public String edit(Long id, HttpServletRequest request, HttpServletResponse response) {
    	QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        return "/QcodeUserApplication/edit";
    }
    
    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
	public ResponseData update(ModelMap model, @ModelAttribute("entity") QcodeUserApplication entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
//			Map<String,Object> errors = FormValidatorManager.validate("saveQcodeUserApplicationConfig", request);
//	        if (errors.size() != 0)
//	        {
//	            return new ResponseData(false, errors.keySet().toString());
//	        }
        	QueryFilter filter = new QueryFilter();
        	filter.put("id", entity.getId());
        	QcodeUserApplication qcodeUserApplication =  service.findOne(filter).getReturnObj();
        	if(!QcodeUserApplication.STATUS_WAITING.equals(qcodeUserApplication.getStatus())){ //已被审核
        		ResponseData responseData = new ResponseData(false, "已被审核，请检查；即将刷新内容。");
        		responseData.setCode(HttpStatus.CONFLICT.value());
        		return responseData;
        	}
        	SysUser sysUser = AppContextHolder.getCurrentUser();
        	entity.setAuditorId(sysUser.getId());
        	entity.setAuditTime(new Date());
		    Result result = service.update(entity);
		    if (!result.isSuccess() ) {
		    	return new ResponseData(false, result.getErrormsg());
		    }
		    if(entity.getStatus().equals( QcodeUserApplication.STATUS_AGREE )){//同意申请更改qcode-user等级
		    	QcodeUser qcodeUser = new QcodeUser();
		    	qcodeUser.setId(entity.getUserId());
		    	qcodeUser.setLevel(entity.getLevel());
		    	Result qcodeUserResult  =  qcodeUserService.update(qcodeUser);
		    	if (!qcodeUserResult.isSuccess() ) {
		    		return new ResponseData(false, qcodeUserResult.getErrormsg());
		    	}
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
	        	service.delete(id);
	      	}
      	}catch(Exception e){
            return new ResponseData(false, e.getMessage());
        }
      	
      	return ResponseData.SUCCESS_NO_DATA;
    }
}
