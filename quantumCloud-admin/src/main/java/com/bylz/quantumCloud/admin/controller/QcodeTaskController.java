package com.bylz.quantumCloud.admin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.admin.util.DecodeUtil;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.SysUser;
import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.formvalidator.FormValidatorManager;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 任务表 Controller
 * @author JT
 * @since  2017-12-26
 */
@Controller
@RequestMapping("/QcodeTask")
public class QcodeTaskController extends BaseController{

	private static final String ADMIN_PASSWORD_CRYPT_KEY = "QCODE_WEB";
	
	@Autowired
	private QcodeTaskService service;

	@RequestMapping(value = "/index.html")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		SysUser sysUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey(QcodeTaskService.SELECT_INDEX_LIST);
        filter.put("order", "QT.start_time DESC");
        model.put("pager", service.findPager(filter).getReturnObj());
        
        StringBuilder sb = new StringBuilder(sysUser.getUsername()).append(",").append(sysUser.getPassword());
        String token = DecodeUtil.encrypt(sb.toString(), ADMIN_PASSWORD_CRYPT_KEY);
        model.put("token", token);
        
		return "/QcodeTask/index";
	}
	
	@RequestMapping(value = "/add.html")
	public String add(HttpServletRequest request, HttpServletResponse response) {
		return "/QcodeTask/add";
	}
	
	@RequestMapping(value = "/save.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData save(ModelMap model, @ModelAttribute("entity") QcodeTask entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
			Map<String,Object> errors = FormValidatorManager.validate("saveQcodeTaskConfig", request);
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
        filter.put("id", id);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        return "/QcodeTask/detail";
    }

	@RequestMapping(value = "/edit.html")
    public String edit(Long id, HttpServletRequest request, HttpServletResponse response) {
    	QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        return "/QcodeTask/edit";
    }
    
    @RequestMapping(value = "/update.json", method = RequestMethod.POST)
    @ResponseBody
	public ResponseData update(ModelMap model, @ModelAttribute("entity") QcodeTask entity, 
						HttpServletRequest request, HttpServletResponse response) {
        try{
			Map<String,Object> errors = FormValidatorManager.validate("saveQcodeTaskConfig", request);
	        if (errors.size() != 0)
	        {
	            return new ResponseData(false, errors.keySet().toString());
	        }
		    Result result = service.update(entity);
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
	        	service.delete(id);
	      	}
      	}catch(Exception e){
            return new ResponseData(false, e.getMessage());
        }
      	
      	return ResponseData.SUCCESS_NO_DATA;
    }
	
	
	@RequestMapping(value="/stopTask.json")
	@ResponseBody
    public ResponseData stopTask(Long id, HttpServletRequest request, HttpServletResponse response)
    {
    	try{
	    	if (id != null)
	      	{
	    		QueryFilter filter = new QueryFilter();
	            filter.put("id", id);
	            QcodeTask qcodeTask= service.findOne(filter).getReturnObj();
	            if(qcodeTask==null){
	            	return new ResponseData(false, "任务不存在");
	            }
	            if(qcodeTask.getStatus().equals(QcodeTask.STATUS_WAITING)||qcodeTask.getStatus().equals(QcodeTask.STATUS_PROCESS)){
	            	//调用终止任务借口
					HashMap paramAns = new HashMap();
		        	paramAns.put("impTyp", "2");
		        	paramAns.put("taskTyp", "");
		        	paramAns.put("typ", "updtask");
		        	paramAns.put("taskid", qcodeTask.getTaskId());        	
		        	
		        	service.terminateTask(paramAns);
		        	qcodeTask.setStatus(QcodeTask.STATUS_END);
		        	qcodeTask.setEndTime(new Date());
		        	Result result = service.update(qcodeTask);
		    		if(!result.isSuccess()){
		    			return new ResponseData(false,result.getErrormsg());
		    		}	            	
	            }else{
	            	return new ResponseData(false, "当前任务状态不可终止任务，请刷新页面");
	            }
	      	}
      	}catch(Exception e){
            return new ResponseData(false, e.getMessage());
        }
      	
      	return ResponseData.SUCCESS_NO_DATA;
    }
}
