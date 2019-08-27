package com.bylz.quantumCloud.mobile.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.mobile.util.DateUtils.DateStyle;
import com.bylz.quantumCloud.mobile.util.SvgUtil;
import com.bylz.quantumCloud.model.QcodeProject;
import com.bylz.quantumCloud.model.QcodeProjectVersion;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.service.QcodeProjectVersionService;
import com.bylz.quantumCloud.service.QcodeTaskService;

import net.coobird.thumbnailator.Thumbnails;

/**
 * 编程 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/QCode")
public class ProgramController extends BaseController{
	
	@Autowired
	private QcodeProjectService qcodeProjectService;
	@Autowired
	private QcodeProjectVersionService qcodeProjectVersionService;
	@Autowired
	private QcodeTaskService qcodeTaskService;
	
	private static final String  user_not_logged_in = "用户未登录";
		
	/**
	 * 设置页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/setting.html")
	public String setting(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String projectId = request.getParameter("projectId");
		//获取当前登陆用户
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	QueryFilter filter = new QueryFilter();
    	//存在项目id时查询项目相关信息并返回
    	if(!(projectId==null)){
    		//查询项目
    		filter.put("id", projectId);
    		//判断是否案例教程
        	if(projectId.equals("257")||projectId.equals("258")){
        		filter.put("userId", 0);
        	}else{
        		filter.put("userId", qcodeUser.getId());
        	}
        	filter.put("isDel", QcodeProject.isDel_NO);
        	QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
        	model.put("qcodeProject", qcodeProject);
    	}
    	return "/program/setting";
	}
	
    /**
     * 编辑项目
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/updateProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData updateProject(QcodeProject qcodeProject) {
        	
        	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        	if(qcodeUser==null){
        		return new ResponseData(false,user_not_logged_in);
        	}
        	ResponseData data = new ResponseData(true);

            QueryFilter filter = new QueryFilter();
            filter.put("id", qcodeProject.getId());
            filter.put("userId", qcodeUser.getId());
            filter.put("idDel", QcodeProject.isDel_NO);
            QcodeProject qcodeProjectById = qcodeProjectService.findOne(filter).getReturnObj();
            if(qcodeProjectById==null){
            	return new ResponseData(false,"项目不存在");
            }
            
            Result result = qcodeProjectService.update(qcodeProject);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
            data.setObj(result.getReturnObj());
            
            return data; 
    }  
	
	/**
	 * 新增项目页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/add.html")
	public String add(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/program/add";
	}
	
	  /**
     * 新增项目
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/saveProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData saveProject(QcodeProject qcodeProject, HttpServletRequest request, HttpServletResponse response) {
        try {
        	
        	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        	ResponseData data = new ResponseData(true);
            //判断用户等级及量子比特数
        	if(qcodeProject.getQubitNum() > 20 ){
        		if(qcodeUser.getLevel().intValue() == QcodeUser.QCODEUSER_LEVEL_1){
        			return new ResponseData(false,"您为一级用户，无权操作20位以上的量子比特");
        		}else{
        			if(qcodeProject.getAnalogType().intValue() == QcodeProject.ANALOG_TYPE_MONTE){
        				return new ResponseData(false,"Monte-Carlo方法只能操作20位及以下的量子比特");
        			}else {
        				if(qcodeProject.getAnalogType().intValue() > 32){
        					return new ResponseData(false,"概率方法只能操作32位及以下的量子比特");
        				}
        			}
        		}
        	}
        	
        	QueryFilter filter = new QueryFilter();
        	filter.put("name", qcodeProject.getName());
            filter.put("userId", qcodeUser.getId());
            filter.put("isDel", 0);
            QcodeProject qcodeProjectByName = qcodeProjectService.findOne(filter).getReturnObj();
            if(qcodeProjectByName!=null){
            	return new ResponseData(false,"项目名称重复");
            }
            
            qcodeProject.setRepeat(100);
            qcodeProject.setUserId(qcodeUser.getId());
            qcodeProject.setIsDel(QcodeProject.isDel_NO);;
            qcodeProject.setCreateTime(new Date());
            
            Result result = qcodeProjectService.save(qcodeProject);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
            
            qcodeProject = result.getReturnObj();
            QcodeProjectVersion versionDefault = new QcodeProjectVersion(); 
        	versionDefault.setCode("");
        	versionDefault.setPic("");
        	versionDefault.setSvgXml("");
			versionDefault.setCreateTime(new Date());
			versionDefault.setIsDel(QcodeProjectVersion.ISDEL_NO);
			versionDefault.setName("V1");
			versionDefault.setProjectId(qcodeProject.getId());
			Result qcodeProjectVersionResult = qcodeProjectVersionService.save(versionDefault);
			if(!qcodeProjectVersionResult.isSuccess()){
				return new ResponseData(false, qcodeProjectVersionResult.getErrormsg());
			}
            data.setObj(qcodeProjectVersionResult.getReturnObj());
            return data; 
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
                result.addErrormsg("ID 重复");
            }
            return new ResponseData(false, result);
        }
    }
    
    
	/**
	 * 编程详情页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/programBrief.html")
	public String programBrief(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/program/programBrief";
	}
	
	
	/**
	 * 历史版本页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/revisions.html")
	public String revisions(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("pager", qcodeProjectVersionListPager(request));
		return "/program/revisions";
	}
	
	@RequestMapping(value = "/revisions.json")
	@ResponseBody
	public ResponseData revisionsJson(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		ResponseData data  = new ResponseData(true);
		data.setObj(qcodeProjectVersionListPager(request));
		return data;
	}
	
	private Pagination qcodeProjectVersionListPager( HttpServletRequest request ){
		QueryFilter filter = new QueryFilter(request);
		filter.put("isDel", QcodeProjectVersion.ISDEL_NO);
		filter.put("order", "create_time DESC");
		return	 qcodeProjectVersionService.findPager(filter).getReturnObj();
	}
	
    /**
     * 获取版本
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/getVersion.json")
    @ResponseBody
    public ResponseData getVersion( HttpServletRequest request, HttpServletResponse response) {
			//获取当前登陆用户
			QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
			if(qcodeUser==null){ return new ResponseData(false,user_not_logged_in);}
            QueryFilter filter = new QueryFilter(request);          
            QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
            if(qcodeProjectVersion==null){
                return new ResponseData(false,"版本不存在");
            }
            
            ResponseData responseData = new ResponseData(true);
            responseData.setObj(qcodeProjectVersion);
            
            return responseData;
    }
	
	 /**
     * 删除版本
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/delVersion.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData delVersion( HttpServletRequest request, HttpServletResponse response) {
			//获取当前登陆用户
			QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
			if(qcodeUser==null){ return new ResponseData(false,user_not_logged_in);}
			QueryFilter filter = new QueryFilter(request);
			QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
			if(qcodeProjectVersion==null){
				return new ResponseData(false,"版本不存在");
			}
			//删除项目最后一个版本是删除项目
			filter = new QueryFilter();
			filter.put("projectId", qcodeProjectVersion.getProjectId());
			filter.put("isDel", 0);
			List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
			if(versionList.size() == 1){
				filter = new QueryFilter();
				filter.put("id", qcodeProjectVersion.getProjectId());
				QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
				qcodeProject.setIsDel(QcodeProject.isDel_YES);
				Result re = qcodeProjectService.update(qcodeProject);
	    		if(!re.isSuccess()){
	    			return new ResponseData(false,re.getErrormsg());
	    		}
			}
			
			filter = new QueryFilter();
			filter.setStatementKey("updateByVersionId");
			filter.put("isDel", QcodeProjectVersion.ISDEL_YES);
			filter.put("versionId", qcodeProjectVersion.getId());
			Result result1 = qcodeTaskService.update(filter);
    		if(!result1.isSuccess()){
    			return new ResponseData(false,result1.getErrormsg());
    		}
    		qcodeProjectVersion.setIsDel(1);
    		Result result2 =  qcodeProjectVersionService.update(qcodeProjectVersion);
    		if(!result2.isSuccess()){
    			return new ResponseData(false,result2.getErrormsg());
    		}
    		
			return ResponseData.SUCCESS_NO_DATA;
    } 
	
	/**
	 * 版本详情页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/revisionsDetail.html")
	public String revisionsDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("pager", revisionsDetailListPager(request));
		return "/program/revisionsDetail";
	}
	
	@RequestMapping(value = "/revisionsDetail.json")
	@ResponseBody
	public ResponseData revisionsDetail( HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		data.setObj(revisionsDetailListPager(request));
		return data;
	}
	
	private Pagination revisionsDetailListPager(HttpServletRequest request){
		QueryFilter filter = new QueryFilter(request);
		filter.put("isDel", QcodeTask.ISDEL_NO);
		filter.put("order", "start_time DESC");
		return qcodeTaskService.findPager(filter).getReturnObj();
	}
	
	   /**
     * 删除任务
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/delTask.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData delTask( HttpServletRequest request, HttpServletResponse response) {
    		//获取当前登陆用户
    		QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    		if(qcodeUser==null){ return new ResponseData(false,"user_not_logged_in");}
    		QueryFilter filter = new QueryFilter(request);   		
    		QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
			if(qcodeTask==null){
				return new ResponseData(false,"任务不存在");
			}  
			qcodeTask.setIsDel(QcodeTask.ISDEL_YES);
    		Result result = qcodeTaskService.update(qcodeTask);
    		if(!result.isSuccess()){
    			return new ResponseData(false,result.getErrormsg());
    		}
    		return ResponseData.SUCCESS_NO_DATA;
    }  
    
    /**
     * 终止任务
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @author Hou Dongdong
     */
    @RequestMapping(value = "/terminateTask.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData terminateTask( HttpServletRequest request, HttpServletResponse response) {
    		//获取当前登陆用户
    		QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    		if(qcodeUser==null){ return new ResponseData(false,"user_not_logged_in");}
    		QueryFilter filter = new QueryFilter(request);   		
    		QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
			if(qcodeTask==null){
				return new ResponseData(false,"任务不存在");
			}  
			//调用终止任务借口
			HashMap paramAns = new HashMap();
        	paramAns.put("impTyp", "2");
        	paramAns.put("taskTyp", qcodeTask.getType());
        	paramAns.put("typ", "updtask");
        	paramAns.put("taskid", qcodeTask.getTaskId());        	
        	//中断任务操作
        	qcodeTaskService.terminateTask(paramAns);
        	qcodeTask.setStatus(QcodeTask.STATUS_END);	
        	qcodeTask.setEndTime(new Date());
    		Result result = qcodeTaskService.update(qcodeTask);
    		if(!result.isSuccess()){
    			return new ResponseData(false,result.getErrormsg());
    		}
    		return ResponseData.SUCCESS_NO_DATA;
    } 
    
	
	/**
	 * 我的页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-15下午1:41:58
	 * @author Hou Dongdong
	 */
	@RequestMapping(value = "/mine.html")
	public String mine(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/program/mine";
	}
	
    /**
     * 默认编程页面获取
     * @param model
     * @param request
     * @return
     * @2017-7-25下午8:38:26
     * @JT
     */
    @RequestMapping(value = "/program.html")
    public String program(ModelMap model, HttpServletRequest request) {
        getProjectInfo(model,request);
        return "program/program";
    }
    
    /**
     * 新编程页面获取
     * @param model
     * @param request
     * @return
     * @2017-7-25下午8:38:26
     * @JT
     */
    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
        getProjectInfo(model,request);
        return "program/index";
    }

    /**
     * 获取项目信息
     * @param model
     * @param request
     * @2018-1-29下午2:17:11
     * @JT
     */
    private void getProjectInfo(ModelMap model, HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        String projectId = request.getParameter("projectId");
        String versionId = request.getParameter("versionId");
        //查询登陆用户项目
        if (qcodeUser != null) {
            //没有项目时自动创建一个新项目
            filter.put("isDel", 0);
            filter.put("userId", qcodeUser.getId());
            filter.setStatementKey("selectList_count");
            Integer count = qcodeProjectService.findOne(filter).getReturnObj();
            if (count == 0) {
                Result result = createProject(qcodeUser.getId(), "");
                QcodeProject project = result.getReturnObj();
                result = createProjectVersion("", "", "", "V1", project.getId());
                model.put("qcodeProject", project);
                model.put("projectVersion", result.getReturnObj());
                return;
            }
            if (StringUtils.isNotEmpty(versionId)) {
                filter = new QueryFilter();
                filter.put("id", versionId);
                QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
                QcodeProject qcodeProject;
                if (version == null || version.getProjectId() == null) {
                    filter = new QueryFilter();
                    filter.put("userId", qcodeUser.getId());
                    filter.put("isDel", 0);
                    filter.put("order", "create_time desc");
                    qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                    filter = new QueryFilter();
                    filter.put("projectId", qcodeProject.getId());
                    filter.put("isDel", 0);
                    filter.put("order", "create_time desc");
                    version = qcodeProjectVersionService.findOne(filter).getReturnObj();
                } else {
                    filter = new QueryFilter();
                    filter.put("userId", qcodeUser.getId());
                    filter.put("id", version.getProjectId());
                    filter.put("isDel", 0);
                    qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                    if (qcodeProject == null) {
                        filter.put("id", null);
                        qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                        filter = new QueryFilter();
                        filter.put("projectId", qcodeProject.getId());
                        filter.put("isDel", 0);
                        filter.put("order", "create_time desc");
                        version = qcodeProjectVersionService.findOne(filter).getReturnObj();
                    }
                }
                model.put("qcodeProject", qcodeProject);
                model.put("projectVersion", version);
                return;
            }
            //存在项目id时查询项目相关信息并返回
            filter = new QueryFilter();
            if (StringUtils.isNotEmpty(projectId)) {
                filter.put("id", projectId);
            }
            filter.put("isDel", 0);
            filter.put("userId", qcodeUser.getId());
            filter.put("order", "create_time desc");
            QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            if (qcodeProject == null) {
                filter.put("id", null);
                qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            }
            model.put("qcodeProject", qcodeProject);
            filter = new QueryFilter();
            filter.put("projectId", qcodeProject.getId());
            filter.put("isDel", 0);
            filter.put("order", "create_time desc");
            QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
            model.put("projectVersion", version);

        } else {
            //游客模式展示两个默认算法项目
            if (StringUtils.isNotEmpty(projectId)) {
                //查询项目
                filter.put("id", projectId);
                filter.put("userId", 0);
                filter.put("isDel", 0);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                if (qcodeProject == null) {
                    filter = new QueryFilter();
                    filter.put("id", projectId);
                    filter.put("isDel", 0);
                    filter.put("userId", 0);
                    qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                }
                filter = new QueryFilter();
                filter.put("projectId", qcodeProject.getId());
                filter.put("isDel", 0);
                filter.put("order", "create_time desc");
                QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
                model.put("qcodeProject", qcodeProject);
                model.put("projectVersion", version);
            } else {
                filter = new QueryFilter();
                filter.put("isDel", 0);
                filter.put("userId", 0);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                filter = new QueryFilter();
                filter.put("projectId", qcodeProject.getId());
                filter.put("isDel", 0);
                filter.put("order", "create_time desc");
                QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
                model.put("qcodeProject", qcodeProject);
                model.put("projectVersion", version);
            }
        }
    }

	/**
	 * 问题页面获取
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @2018-1-26下午1:41:58
	 * @author JT
	 */
	@RequestMapping(value = "/question.html")
	public String question(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "/common/commingsoon";
	}
	
    /**
     * 运行任务
     * @param request
     * @return
     */
    @RequestMapping(value = "running.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData running(String projectId, String versionId, HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        ResponseData data = new ResponseData(true);
        if (qcodeUser == null) {
            //游客模式直接获取数据
            QueryFilter filter = new QueryFilter();
            filter.put("versionId", versionId);
            QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
            data.setObj(qcodeTask);
            return data;
        } else {
            //教程直接获取数据
            if (projectId.equals("257") || projectId.equals("258")) {
                //游客模式直接获取数据
                QueryFilter filter = new QueryFilter();
                filter.put("versionId", versionId);
                QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
                data.setObj(qcodeTask);
                return data;
            }
            //单个用户运行中任务上限为3个
            QueryFilter filterTask = new QueryFilter();
            filterTask.put("userId", qcodeUser.getId());
            filterTask.put("isDel", 0);
            List<String> statusList = new ArrayList<String>();
            statusList.add(QcodeTask.STATUS_PROCESS);
            statusList.add(QcodeTask.STATUS_WAITING);
            filterTask.put("statusList", statusList);
            filterTask.setStatementKey("getRunningTask_count");
            Integer count = qcodeTaskService.findOne(filterTask).getReturnObj();
            if (count > 2) {
                return new ResponseData(false, getMessage("number_has_reached"));
            }

            String code = request.getParameter("code");
            String meaarr = request.getParameter("meaarr");
            if (StringUtils.isEmpty(code)) {
                return new ResponseData(false, getMessage("code_error"));
            }

            String svgXml = request.getParameter("svgXml");
            
            //保存的图片相对路径
            String pic = svg2Png(svgXml);
            
            QueryFilter filter = new QueryFilter();
            if (StringUtils.isEmpty(projectId)) {

                Result result = createProject(qcodeUser.getId(), pic);
                if (!result.isSuccess()) {
                    return new ResponseData(false, getMessage("server_is_busy"));
                }
                QcodeProject project = result.getReturnObj();
                
                result = createProjectVersion(code, svgXml, pic, "V1", project.getId());

                if (!result.isSuccess()) {
                    return new ResponseData(false, getMessage("server_is_busy"));
                }
                QcodeProjectVersion version = result.getReturnObj();
                
                //创建任务并运行
                JSONObject json = submitTask(project, code, meaarr);
                
                if (!toBoolean(json.get("success"))) {
                    return new ResponseData(false, json.get("message"));
                }

                //任务id
                String taskId = (String) json.get("taskid");
                //任务状态
                String tasksta = (String) json.get("tasksta");
                
                String taskrs = (String) json.get("taskrs");
                
                String taskTyp = (String) json.get("taskTyp");
                
                result = createQcodeTask(taskId, tasksta, taskrs, project.getQubitNum(), taskTyp, meaarr,
                        project.getRepeat(), version.getId());
                
                if (!result.isSuccess()) {
                    return new ResponseData(false, getMessage("server_is_busy"));
                }
                
                QcodeTask task = result.getReturnObj();
                data.setObj(task);
                return data;
            } else {
                filter = new QueryFilter();
                filter.put("id", projectId);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                //无版本时直接创建第一个版本>创建运行任务
                if (StringUtils.isEmpty(versionId)) {
                    Result result = createProjectVersion(code, svgXml, pic, "V1", qcodeProject.getId());
                    if (!result.isSuccess()) {
                        return new ResponseData(false, getMessage("server_is_busy"));
                    }
                    qcodeProject.setPic(pic);
                    qcodeProjectService.update(qcodeProject);
                    
                    QcodeProjectVersion qcodeProjectVersion = result.getReturnObj();
                    //创建任务并运行
                    JSONObject json = submitTask(qcodeProject, code, meaarr);
                    if (!toBoolean(json.get("success"))) {
                        return new ResponseData(false, json.get("message"));
                    }

                    //任务id
                    String taskId = (String) json.get("taskid");
                    //任务状态
                    String tasksta = (String) json.get("tasksta");
                    
                    String taskrs = (String) json.get("taskrs");
                    
                    String taskTyp = (String) json.get("taskTyp");
                    
                    result = createQcodeTask(taskId, tasksta, taskrs, qcodeProject.getQubitNum(), taskTyp, meaarr,
                            qcodeProject.getRepeat(), qcodeProjectVersion.getId());
                    
                    if (!result.isSuccess()) {
                        return new ResponseData(false, getMessage("server_is_busy"));
                    } 
                    
                    QcodeTask task = result.getReturnObj();
                    data.setObj(task);
                    
                    return data;
                } else {
                    filter.put("id", versionId);
                    QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
                    //选中项目时判断code是否变化，若变化创建新版本并创建运行任务，若无变化直接创建运行任务
                    if (code.equals(qcodeProjectVersion.getCode())) {
                        filter = new QueryFilter();
                        filter.put("id", projectId);
                        QcodeProject project = qcodeProjectService.findOne(filter).getReturnObj();
                        //创建任务并运行
                        JSONObject json = submitTask(project, code, meaarr);
                        if (!toBoolean(json.get("success"))) {
                            return new ResponseData(false, json.get("message"));
                        }
                        //任务id
                        String taskId = (String) json.get("taskid");
                        //任务状态
                        String tasksta = (String) json.get("tasksta");
                        
                        String taskrs = (String) json.get("taskrs");
                        
                        String taskTyp = (String) json.get("taskTyp");
                        Result result = createQcodeTask(taskId, tasksta, taskrs, project.getQubitNum(), taskTyp, meaarr, project.getRepeat(), qcodeProjectVersion.getId());
                        if (!result.isSuccess()) {
                            return new ResponseData(false, getMessage("server_is_busy"));
                        } 
                        data.setObj(result.getReturnObj());
                        return data;
                    } else {
                        Long vId = qcodeProjectVersion.getId();
                        if (StringUtils.isEmpty(qcodeProjectVersion.getCode())) {
                            qcodeProjectVersion.setCode(code);
                            qcodeProjectVersion.setPic(pic);
                            qcodeProjectVersion.setSvgXml(svgXml);
                            Result result = qcodeProjectVersionService.update(qcodeProjectVersion);
                            if (!result.isSuccess()) {
                                return new ResponseData(false, getMessage("server_is_busy"));
                            }
                        } else {
                            filter = new QueryFilter();
                            filter.put("projectId", projectId);
                            filter.setStatementKey(QcodeProjectVersionService.SELECTLIST_COUNT);
                            Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
                            String name = "V" + (versionCount + 1);
                            //创建新版本
                            Result taskNewRe = createProjectVersion(code, svgXml, pic, name, qcodeProject.getId());
                            
                            if (!taskNewRe.isSuccess()) {
                                return new ResponseData(false, getMessage("server_is_busy"));
                            }  
                            QcodeProjectVersion versionNew = taskNewRe.getReturnObj();
                            vId = versionNew.getId();
                        }
                        qcodeProject.setPic(pic);
                        qcodeProjectService.update(qcodeProject);

                        //创建任务并运行
                        JSONObject json = submitTask(qcodeProject, code, meaarr);
                        if (!toBoolean(json.get("success"))) {
                            return new ResponseData(false, json.get("message"));
                        }
                        //任务id
                        String taskId = (String) json.get("taskid");
                        //任务状态
                        String tasksta = (String) json.get("tasksta");
                        
                        String taskrs = (String) json.get("taskrs");
                        
                        String taskTyp = (String) json.get("taskTyp");
                        Result result = createQcodeTask(taskId, tasksta, taskrs, qcodeProject.getQubitNum(), taskTyp,
                                meaarr, qcodeProject.getRepeat(), vId);
                        if (!result.isSuccess()) {
                            return new ResponseData(false, getMessage("server_is_busy"));
                        }
                        data.setObj(result.getReturnObj());
                        return data;
                    }
                }
            }
        }
    }
    /**
     * 获取任务状态
     */
    @RequestMapping(value = "getTaskRate.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData getTaskRate(String taskId) {
        //获取当前登陆用户
        ResponseData data = new ResponseData(true);
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        
        if (qcodeUser == null) {
            //游客模式直接获取数据
            QueryFilter filter = new QueryFilter();
            filter.put("taskId", taskId);
            QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
            data.setObj(qcodeTask);
            return data;
        } else {
            //获取当前任务
            QueryFilter filter = new QueryFilter();
            filter.put("taskId", taskId);
            QcodeTask qcodeTaskByTaskId = qcodeTaskService.findOne(filter).getReturnObj();
            if (qcodeTaskByTaskId != null) {
                //只查询等待和处理中的任务
                if (qcodeTaskByTaskId.getStatus().equals(QcodeTask.STATUS_WAITING)
                        || qcodeTaskByTaskId.getStatus().equals(QcodeTask.STATUS_PROCESS)) {
                    HashMap<String, String> paramAns = new HashMap<String, String>();
                    
                    paramAns.put("taskTyp", qcodeTaskByTaskId.getType());
                    paramAns.put("impTyp", "1");
                    paramAns.put("typ", "qrytask");
                    paramAns.put("taskid", taskId);
                    
                    String s2 = qcodeTaskService.queryTask(paramAns);
                    JSONObject json = JSONObject.parseObject(s2);
                    if (json.size() == 0) {
                        logger.debug("查询任务方法queryTask,http请求无返回", taskId);
                        return new ResponseData(false, getMessage("server_is_busy"));
                    }
                    //任务id
                    //String task_id = (String) json.get("taskid");
                    //任务状态
                    String tasksta = (String) json.get("tasksta");
                    switch (tasksta) {
                    case "1":
                        //等待
                        qcodeTaskByTaskId.setStatus(QcodeTask.STATUS_WAITING);
                        break;
                    case "2":
                        //处理中
                        qcodeTaskByTaskId.setStatus(QcodeTask.STATUS_PROCESS);
                        break;
                    case "3":
                        String ans = (String) json.get("taskrs");
                        qcodeTaskByTaskId.setEndTime(new Date());
                        if (!StringUtils.isEmpty(ans)) {
                            //有结果且正确
                            qcodeTaskByTaskId.setStatus(QcodeTask.STATUS_RESULT);
                            qcodeTaskByTaskId.setAns(ans);
                        } else {
                            //有结果为空，语法错误
                            qcodeTaskByTaskId.setStatus(QcodeTask.STATUS_ERROR);
                        }
                        
                        break;
                    default:
                        break;
                    }
                    Result result = qcodeTaskService.update(qcodeTaskByTaskId);
                    if (!result.isSuccess()) {
                        return new ResponseData(false, getMessage("server_is_busy"));
                    }
                }
            
                data.setObj(qcodeTaskByTaskId);
                return data;
            }
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 编辑器主页保存新版本
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "save.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData save(Long projectId, HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage("user_not_logged_in"));
        }
        if (projectId == null) {
            return new ResponseData(false, getMessage("id_is_empty"));
        }
        QueryFilter filter = new QueryFilter();
        String versionId = request.getParameter("versionId");
        String code = request.getParameter("code");

        String svgXml = request.getParameter("svgXml");

        //查询项目
        filter.put("id", projectId);
        filter.put("userId", qcodeUser.getId());
        filter.put("isDel", 0);
        QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
        
        if (qcodeProject == null) {
            return new ResponseData(false, getMessage("project_does_not_exist"));
        }
        long vId = 0l;
        //保存的图片相对路径
        String pic = svg2Png(svgXml);
        if (StringUtils.isEmpty(versionId)) {
            Result result = createProjectVersion(code, svgXml, pic, "V1", projectId);
            if (!result.isSuccess()) {
                return new ResponseData(false, getMessage("server_is_busy"));
            }
            QcodeProjectVersion version = result.getReturnObj();
            vId = version.getId();
        } else {
            //查询版本
            filter = new QueryFilter();
            filter.put("id", versionId);
            filter.put("isDel", 0);
            QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
            if (code.equals(qcodeProjectVersion.getCode())) {
                return new ResponseData(false, getMessage("code_is_not_modified"));
            } else if (StringUtils.isEmpty(qcodeProjectVersion.getCode())) {
                qcodeProjectVersion.setCode(code);
                qcodeProjectVersion.setPic(pic);
                qcodeProjectVersion.setSvgXml(svgXml);
                qcodeProjectVersionService.update(qcodeProjectVersion);
            } else {
                filter = new QueryFilter();
                filter.put("projectId", projectId);
                filter.setStatementKey("selectList_count");
                Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
                String name = "V" + (versionCount + 1);
                Result result = createProjectVersion(code, svgXml, pic, name, projectId);
                if (!result.isSuccess()) {
                    return new ResponseData(false, getMessage("server_is_busy"));
                }
                qcodeProjectVersion = result.getReturnObj();
            }
            vId = qcodeProjectVersion.getId();
        }
        
        qcodeProject.setPic(pic);
        Result result = qcodeProjectService.update(qcodeProject);
        if (!result.isSuccess()) {
            return new ResponseData(false, getMessage("server_is_busy"));
        }
        ResponseData data = new ResponseData(true, getMessage("successful_operation"));
        data.setObj(vId);
        return data;
    }
    
    private Result createProject(long userId, String pic) {
        DateTime dateTime = new DateTime();
        QcodeProject qcodeProject  = new QcodeProject();
        qcodeProject.setQubitNum(6);
        qcodeProject.setClassicalbitNum(6);
        qcodeProject.setRepeat(100);
        qcodeProject.setCreateTime(dateTime.toDate());
        String name = dateTime.toString("yyyyMMdd_HHmmss") + "_QEmulator";
        qcodeProject.setName(name);
        qcodeProject.setTaskTypeId(2);
        qcodeProject.setUserId(userId);
        qcodeProject.setIsDel(0);
        qcodeProject.setPic(pic);
        qcodeProject.setAnalogType(QcodeProject.ANALOG_TYPE_MONTE);
        return qcodeProjectService.save(qcodeProject);
    }

    private Result createProjectVersion(String code, String svgXml, String pic, String name, long projectId) {
        QcodeProjectVersion version = new QcodeProjectVersion();
        version.setCode(code);
        version.setSvgXml(svgXml);
        version.setCreateTime(new Date());
        version.setIsDel(0);
        version.setName(name);
        version.setProjectId(projectId);
        version.setPic(pic);
        return qcodeProjectVersionService.save(version);
    }

    /**
     * 
     * @param taskId
     * @param tasksta
     * @param taskrs
     * @param qubitNum
     * @param taskTyp
     * @param meaarr
     * @param repeat
     * @param vId
     * @return
     */
    private Result createQcodeTask(String taskId, String tasksta, String taskrs, int qubitNum, String taskTyp,
            String meaarr, int repeat, long vId) {
        QcodeTask qcodeTask = new QcodeTask();
        switch (tasksta) {
        case "1":
            //等待
            qcodeTask.setStatus(QcodeTask.STATUS_WAITING);
            break;
        case "2":
            //处理中
            qcodeTask.setStatus(QcodeTask.STATUS_PROCESS);
            break;
        case "3":
            qcodeTask.setEndTime(new Date());
            if (!StringUtils.isEmpty(taskrs)) {
                //有结果且正确
                qcodeTask.setStatus(QcodeTask.STATUS_RESULT);
                qcodeTask.setAns(taskrs);
             } else {
                //有结果为空，语法错误
                qcodeTask.setStatus(QcodeTask.STATUS_ERROR);
            }
            
            break;
        default:
            break;
        }
        if (qubitNum > 20) {
            qcodeTask.setMeaarr(meaarr);
        } else {
            qcodeTask.setRepeat(repeat);
        } 
        qcodeTask.setType(taskTyp);
        qcodeTask.setVersionId(vId);
        qcodeTask.setTaskId(taskId);
        qcodeTask.setStartTime(new Date());
        qcodeTask.setClassicRegisterName("c");
        qcodeTask.setIsDel(QcodeTask.ISDEL_NO);
        return qcodeTaskService.save(qcodeTask);
    }

    private JSONObject submitTask(QcodeProject project, String code, String meaarr) {
        JSONObject json = new JSONObject();
        HashMap<String, String> paramTask = new HashMap<String, String> ();
        QueryFilter qf = new QueryFilter();
        qf.put("userId", project.getUserId());
        qf.put("isDel", 0);
        List<String> statusList = new ArrayList<String>();
        statusList.add(QcodeTask.STATUS_PROCESS);
        statusList.add(QcodeTask.STATUS_WAITING);
        qf.put("statusList", statusList);
        qf.setStatementKey("getRunningTask_count");

        //当前系统支持三种类型的任务（模拟Monte_carlo方法对应任务类型为2，1-20位模拟概率方法对应任务类型3，21-30位模拟概率方法对应任务类型4）
        if (project.getQubitNum() > 20) {
            qf.put("minQubitNum", 20);
            Integer count = qcodeTaskService.findOne(qf).getReturnObj();
            if (count > 0) {
                json.put("success", false);
                json.put("message", getMessage("number_has_reached"));
                return json;
            }
            paramTask.put("taskTyp", "4");
            paramTask.put("qprog", code);
            paramTask.put("meaarr", meaarr);
            paramTask.put("qbit", project.getQubitNum().toString());
            paramTask.put("typ", "midpr");
        } else {
            if (project.getAnalogType() == 0) {
                paramTask.put("taskTyp", "2");
                paramTask.put("qprog", code);
                paramTask.put("repeat", project.getRepeat().toString());
                paramTask.put("typ", "mcpr");
            } else if (project.getAnalogType() == 1) {
                paramTask.put("taskTyp", "3");
                paramTask.put("qprog", code);
                paramTask.put("meaarr", meaarr);
                paramTask.put("typ", "smapr");
            } else {
                json.put("success", false);
                json.put("message", getMessage("server_is_busy"));
                return json;
            }
        }
        System.out.println(paramTask);
        //提交任务，获取返回的task_id
        String str = qcodeTaskService.submitTask(paramTask);
        json = JSONObject.parseObject(str);
        if (json.size() == 0) {
            logger.debug("请求任务方法submitTask,http请求无返回",paramTask);
            json.put("success", false);
            json.put("message", getMessage("server_is_busy"));
            return json;
        } else {
            if (json.get("success") == null) {
                json.put("success", true);
            }
        }
        json.put("taskTyp", paramTask.get("taskTyp"));
        System.out.println(json.toString());
        return json;
    }
    
    private boolean toBoolean(Object b) {
        if (b instanceof String) {
            return Boolean.valueOf((String)b);
        } else if (b instanceof Boolean) {
            return (boolean) b;
        }
        return false;
    }
    
    private String svg2Png(String svgXml) {
        DateTime date = new DateTime();
        
        String pic = "uploadFile/" + date.toString(DateStyle.YYYY_MM_DD.getValue());
        
        File file = new File(AppContextHolder.getFileSavePath() + pic);
        if (!file.exists() || !file.isDirectory()) {
            file.mkdirs();
        }
        pic += "/" + date.toString(DateStyle.YYYYMMDDHHMMSSSSS.getValue()) + ".png";
        
        try {
            SvgUtil.convertSVGString2Png(svgXml.replaceAll("fill=\"black\"", "fill=\"none\""), new File(AppContextHolder.getFileSavePath() + pic));
        } catch (IOException e) {
            logger.error("SvgUtil.convertSVGString2Png error");
            logger.error(e.getMessage());
            e.printStackTrace();
            return "";
        }

        //指定坐标  
        try {
            String thumbnail = AppContextHolder.getFileSavePath() + pic;
            Thumbnails.of(thumbnail).sourceRegion(10, 0, 576, 360).size(192, 120).keepAspectRatio(false).toFile(thumbnail);
        } catch (IOException e) {
            logger.error("Thumbnails error");
            logger.error(e.getMessage());
            e.printStackTrace();
            return "";
        }
        return pic;
    }

}
