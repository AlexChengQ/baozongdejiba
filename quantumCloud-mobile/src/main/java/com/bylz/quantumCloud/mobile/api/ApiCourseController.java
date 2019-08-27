package com.bylz.quantumCloud.mobile.api;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.mobile.controller.BaseController;
import com.bylz.quantumCloud.mobile.controller.ResponseData;
import com.bylz.quantumCloud.mobile.core.AppContextHolder;
import com.bylz.quantumCloud.mobile.util.DateUtils.DateStyle;
import com.bylz.quantumCloud.mobile.util.GetParmFromRequestUtils;
import com.bylz.quantumCloud.mobile.util.GetUserIdByApikey;
import com.bylz.quantumCloud.mobile.util.SvgUtil;
import com.bylz.quantumCloud.model.QcodeProject;
import com.bylz.quantumCloud.model.QcodeProjectVersion;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.service.QcodeProjectVersionService;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

import net.coobird.thumbnailator.Thumbnails;





/**
 * 教程 Controller
 * @author JT
 * @since  2017-01-15
 */
@Controller
@RequestMapping("/api")
public class ApiCourseController extends BaseController{
	@Autowired
	private QcodeProjectService qcodeProjectService;
	@Autowired
	private QcodeProjectVersionService qcodeProjectVersionService;
	@Autowired
	private QcodeTaskService qcodeTaskService;
	
    @Autowired
    private QcodeUserService qcodeUserService;
    @RequestMapping(value = "/program.html")
    public String program(ModelMap model, HttpServletRequest request) {
        String projectId = request.getParameter("projectId");
        String versionId = request.getParameter("versionId");
    	if(projectId!=null||versionId!=null) {
    		QueryFilter filter = new QueryFilter();
            filter.put("id", projectId);
            filter.put("isDel", 0);
            filter.put("order", "create_time desc");
            QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            filter = new QueryFilter();
            filter.put("projectId", projectId);
            filter.put("id", versionId);
            filter.put("isDel", 0);
            filter.put("order", "create_time desc");
            QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
            model.put("qcodeProject", qcodeProject);
            model.put("projectVersion", version);
    	}else {
            getProjectInfo(model,request);
    	}
        return "api/program";
    }




    /**
     * @param model
     * @param request
     * @return index
     * @since  2019-07-19
     * @author songhaozhang
     */
    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
    	getProjectInfo(model,request);
        return "api/index";
    }
    
    /**
     * @param model
     * @param request
     * @return setting页面
     * @since  2019-07-19
     * @author songhaozhang
     */
    @RequestMapping(value = "/setting.html")
    public String setting(ModelMap model, HttpServletRequest request) {
		String projectId = request.getParameter("projectId");
		//获取当前登陆用户
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	if(qcodeUser==null) {
    		String path = request.getContextPath();
    		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    		System.out.println("basepath:"+basePath);
    		model.put("forward",basePath+"api/setting.html" );
    		return "api/index";
    	}
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
        return "api/setting";
    }  
    /**
     * 编辑器主页保存新版本
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "requestUserInfo.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData requestUserInfo(HttpServletRequest request) {
        //获取当前登陆用户
        ResponseData data = new ResponseData(true);
        data.setObj("");
        Map map=null;
		try {
			map = map = GetParmFromRequestUtils.getParams(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (map == null) {
            data.setSuccess(false);
            data.setMessage("LACK_OF_NECESSARY_PARAMETERS");
            return data;
        }

        String token = map.get("token") == null ? null : (String)map.get("token");
        QcodeUser userInfor = GetUserIdByApikey.getUserId(token);


        if (userInfor == null) {
            data.setSuccess(false);
            data.setMessage("key_does_not_exist");
            return data;
        }
        
        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, userInfor);
    	
        return login(userInfor,request);
        //return data;
    }
    
    
    /**
     * 退出清除缓存接口
     * @param request
     * @param response
     * @param session
     * @return
     * @since  2019-07-20
     * @author songhaozhang
     */
    @RequestMapping(value = "/loginOut.json")
    @ResponseBody
    public ResponseData loginOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	logger.debug("===============loginOut=============");
    	SecurityUtils.getSubject().getSession().removeAttribute(AppContextHolder.USER_INFO);
    	 SecurityUtils.getSubject().logout();
    	 logger.debug("===============loginOut success=============");
    	return new ResponseData(true,"退出成功");
    }
    /**
     * shiro 登录操作
     * 
     * 调用前请做member是否为null操作
     * 该私有方法没有验证，避免重复。
     * 如果调用前未做验证，有可能throw nullpointerexception
     * 
     * @param member
     * @return
     */
    private ResponseData login(QcodeUser qcodeUser,HttpServletRequest request) {
		
    	HttpServletRequest httpRequest = (HttpServletRequest)request;
    	
    	Subject subject = SecurityUtils.getSubject();
    	if (subject != null)
    	{
    	    subject.logout();
    	}
    	
    	//String tokenStr = qcodeUser.getEmail()+"-"+UUID.randomUUID().toString().substring(12);
        //httpRequest.setAttribute("sid", tokenStr);       
        //System.out.println(tokenStr.length());
        
        //更新登录用户TOKEN字段
        //qcodeUser.setToken(tokenStr);
        
        //qcodeUserService.update(qcodeUser);
        
        // 密码修改成功自动登录，session中存放用户信息。登录跳转在android、ios端处理
        UsernamePasswordToken token = new UsernamePasswordToken(qcodeUser.getEmail(), qcodeUser.getPwd());
        SecurityUtils.getSubject().login(token);

        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.USER_INFO, qcodeUser);
        SecurityUtils.getSubject().getSession().setAttribute(AppContextHolder.TOKEN_STR, qcodeUser.getToken());
        ResponseData data = new ResponseData(true);
        
        data.setObj(qcodeUser.getToken());
        
        	//查询用户运行中任务当前状态并同步
      		  QueryFilter filter = new QueryFilter();
              filter.put("status", 0);
              filter.put("userId", qcodeUser.getId());
              filter.setStatementKey("getRunningTask");
              List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
              for(int i=0;i<taskList.size();i++){
              	QcodeTask task = taskList.get(i);
              	HashMap paramAns = new HashMap();
              	paramAns.put("task_id", task.getTaskId());
              	
              	String s2 = qcodeTaskService.queryTask(paramAns);
              	JSONObject json = JSONObject.parseObject(s2);
              	if(json.size()==0){
              		logger.debug("登陆时同步task请求接口失败，http返回空",task.getTaskId());
              	}
              	//任务id
              	String task_id = (String) json.get("taskid");
              	//任务状态
              	String tasksta = (String) json.get("tasksta");
              	switch(tasksta){
              	case "1":
              	    //等待
              		task.setStatus(QcodeTask.STATUS_WAITING);
              	    break;
              	case "2":
              	    //处理中
              		task.setStatus(QcodeTask.STATUS_PROCESS);
              	    break;
              	case "3":
              		JSONObject ans = (JSONObject) json.get("taskrs");
              		if(ans!=null&&!("".equals(ans))){
              			//有结果且正确
              			task.setStatus(QcodeTask.STATUS_RESULT);
              			task.setAns(ans.toString());
              		}else{
              			//有结果为空，语法错误
              			task.setStatus(QcodeTask.STATUS_ERROR);
              		}
              		
              	    break;  
              	default:
              	    break;
              	}
                  Result result = qcodeTaskService.save(task);
                  if (!result.isSuccess()) {
                  	logger.debug("登陆时同步task，更新task出错",task.getTaskId());
                  } 
              }
        return data;

    }
    
    
    
    
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
            return new ResponseData(false, "user_not_logged_in");
        }
        if (projectId == null) {
            return new ResponseData(false, "id_is_empty");
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
            return new ResponseData(false, "project_does_not_exist");
        }
        long vId = 0l;
        //保存的图片相对路径
        String pic = svg2Png(svgXml);
        if (StringUtils.isEmpty(versionId)) {
            Result result = createProjectVersion(code, svgXml, pic, "V1", projectId);
            if (!result.isSuccess()) {
                return new ResponseData(false,"server_is_busy");
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
                    return new ResponseData(false, "server_is_busy");
                }
                qcodeProjectVersion = result.getReturnObj();
            }
            vId = qcodeProjectVersion.getId();
        }
        
        qcodeProject.setPic(pic);
        Result result = qcodeProjectService.update(qcodeProject);
        if (!result.isSuccess()) {
            return new ResponseData(false, "server_is_busy");
        }
        ResponseData data = new ResponseData(true, "successful_operation");
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
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	if(qcodeUser==null) {
    		String path = request.getContextPath();
    		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    		System.out.println("basepath:"+basePath);
    		model.put("forward",basePath+"api/revisionsDetail.html" );
    		return "api/index";
    	}
		model.put("pager", revisionsDetailListPager(request));
		return "/api/revisionsDetail";
	}
    
	private Pagination revisionsDetailListPager(HttpServletRequest request){
		QueryFilter filter = new QueryFilter(request);
		filter.put("isDel", QcodeTask.ISDEL_NO);
		filter.put("order", "start_time DESC");
		return qcodeTaskService.findPager(filter).getReturnObj();
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
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	if(qcodeUser==null) {
    		String path = request.getContextPath();
    		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    		System.out.println("basepath:"+basePath);
    		model.put("forward",basePath+"api/add.html" );
    		return "api/index";
    	}
		return "/api/add";
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
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	if(qcodeUser==null) {
    		String path = request.getContextPath();
    		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    		System.out.println("basepath:"+basePath);
    		model.put("forward",basePath+"api/revisions.html" );
    		return "api/index";
    	}
		model.put("pager", qcodeProjectVersionListPager(request,qcodeUser));
		return "/api/revisions";
	}
	
	private Pagination qcodeProjectVersionListPager( HttpServletRequest request, QcodeUser qcodeUser){
		QueryFilter filter = new QueryFilter(request);
		filter.put("isDel", QcodeProjectVersion.ISDEL_NO);
		filter.put("order", "qcode_project_version.create_time DESC");
		filter.put("userid", qcodeUser.getId());
		filter.setStatementKey("selectversionbyid");
		return qcodeProjectVersionService.findPager(filter).getReturnObj();
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

    
}
