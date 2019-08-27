package com.bylz.quantumCloud.platform.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.model.QcodeApply;
import com.bylz.quantumCloud.model.QcodeMessage;
import com.bylz.quantumCloud.model.QcodeProject;
import com.bylz.quantumCloud.model.QcodeProjectVersion;
import com.bylz.quantumCloud.model.QcodeTask;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.QcodeUserApplication;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.platform.core.AppContextHolder;
import com.bylz.quantumCloud.platform.util.DateUtils;
import com.bylz.quantumCloud.platform.util.DateUtils.DateStyle;
import com.bylz.quantumCloud.platform.util.DecodeUtil;
import com.bylz.quantumCloud.platform.util.SvgUtil;
import com.bylz.quantumCloud.platform.util.TemplateSendEmail;
import com.bylz.quantumCloud.service.QcodeApplyService;
import com.bylz.quantumCloud.service.QcodeMessageService;
import com.bylz.quantumCloud.service.QcodeProjectService;
import com.bylz.quantumCloud.service.QcodeProjectVersionService;
import com.bylz.quantumCloud.service.QcodeTaskService;
import com.bylz.quantumCloud.service.QcodeUserApplicationService;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.bylz.quantumCloud.service.SysConfigService;
import com.bylz.quantumCloud.service.SysUserService;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;

import freemarker.template.TemplateException;
import net.coobird.thumbnailator.Thumbnails;


/**
 * QCode Controller
 *
 * @author JiangTao
 * @since 2017-05-31
 */
@Controller
@RequestMapping("/")
public class QcodeController extends BaseController {

    public static final String FROM_ADMIN = "fromAdmin";

    public static final String PROJECT_ID = "projectId";

    public static final String VERSION_ID = "versionId";

    public static final String USER_ID = "userId";

    public static final String IS_DEL = "isDel";

    public static final String SELECT_LIST_COUNT = "selectList_count";

    public static final String YYYY_M_MDD = "yyyyMMdd";

    public static final String H_HMMSS = "HHmmss";

    public static final String QEMULATOR = "_QEmulator";

    public static final String ORDER = "order";

    public static final String CREATE_TIME_DESC = "create_time desc";

    public static final String QCODE_PROJECT = "qcodeProject";

    public static final String QCODE_PROJECT_LIST = "qcodeProjectList";

    public static final String VERSION = "version";

    public static final String START_TIME_DESC = "start_time desc";

    public static final String TASK_LIST = "taskList";

    public static final String VERSION_MAP_LIST = "versionMapList";

    public static final String PROJECT_VERSION = "projectVersion";

    public static final String CURRENT_VERSION = "currentVersion";

    public static final String USER_NOT_LOGGED_IN = "user_not_logged_in";

    public static final String PRIMARY = "PRIMARY";

    public static final String REPEAT = "repeat";

    public static final String TASK_DOES_NOT_EXIST = "task_does_not_exist";

    public static final String NUMBER_HAS_REACHED = "number_has_reached";

    public static final String MEAARR = "meaarr";

    public static final String MIN_QUBIT_NUM = "minQubitNum";

    public static final String TASK_TYP = "taskTyp";

    public static final String TASK_TYPE = "TaskType";

    public static final String QPROG = "qprog";

    public static final String QPROG_QRUNES2 = "QProg";

    public static final String MIDPR = "midpr";

    public static final String SMAPR = "smapr";

    public static final String REALCHIP_BUSY = "realchip_is_busy";
    
    public static final String SERVER_IS_BUSY = "server_is_busy";

    public static final String SUBMIT_TASK_HTTP_NULL = "请求任务方法submitTask,http请求无返回";

    public static final String TASKID = "taskid";

    public static final String TASKSTA = "tasksta";

    public static final String TASKRS = "taskrs";

    public static final String TASK_ID = "taskId";

    public static final String IMP_TYP = "impTyp";

    public static final String VERSION_DOES_NOT_EXIST = "version_does_not_exist";

    public static final String TOKEN = "token";

    public static final String COMMON_INVALID_PAGE = "common/invalidPage";

    public static final String LACK_OF_NECESSARY_PARAMETERS = "lack_of_necessary_parameters";

    public static final String KEY_IS_NOT_NULL = "key_is_not_null";

    public static final String API_KEY = "apiKey";

    public static final String KEY_DOES_NOT_EXIST = "key_does_not_exist";

    public static final String SUCCESS = "success";

    public static final String MESSAGE = "message";

    public static final String PROGRAM_EXCEPTION = "program_exception";

    @Autowired
    private QcodeProjectService qcodeProjectService;

    @Autowired
    private QcodeProjectVersionService qcodeProjectVersionService;

    @Autowired
    private QcodeTaskService qcodeTaskService;

    @Autowired
    private TemplateSendEmail templateEmail;

    @Autowired
    private SysConfigService sysConfigService;

    @Autowired
    private QcodeMessageService qcodeMessageService;

    @Autowired
    private QcodeUserApplicationService qcodeUserApplicationService;

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private QcodeUserService qcodeUserService;

    /**
     * 用户申请Service
     */
    @Autowired
    private QcodeApplyService qcodeApplyService;


    /**
     * 首页
     *
     * @return 2017-7-20 JT
     */
    @RequestMapping(value = "/")
    public String homePage() {

        return "redirect:/QCode/index.html";
    }

    /**
     * 编辑器主页获取
     */
    @RequestMapping(value = "QCode/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
        QcodeProject qcodeProjectFalg =
                (QcodeProject) SecurityUtils.getSubject().getSession().getAttribute(QCODE_PROJECT);
        QcodeProjectVersion versionVo=(QcodeProjectVersion)SecurityUtils.getSubject().getSession().getAttribute("versionVo");

        String projectId = request.getParameter(PROJECT_ID);
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();

        //清空session
        if (projectId != null){
            qcodeProjectFalg = null;
            SecurityUtils.getSubject().getSession().setAttribute(QCODE_PROJECT,null);
        }

        //判断是否为老用户(0、否，1、是)  从数据库中查取isOldUser
        String isOldUser = null;
        if (null != qcodeUser) {
            QueryFilter nameFilter = new QueryFilter();
            nameFilter.put("userName", qcodeUser.getEmail());
            QcodeUser qcodeUserNew = qcodeUserService.findOne(nameFilter).getReturnObj();
            isOldUser = qcodeUserNew.getIsOldUser();
        }

        if (null != isOldUser) {
            model.put("isOldUser", isOldUser);
        } else {
            model.put("isOldUser", '2'); //游客模式
        }

        String fromAdmin = request.getParameter(FROM_ADMIN) == null ? "0" :
                request.getParameter(FROM_ADMIN);//是否从后台管理平台跳转而来 0：否，1：是
        if (qcodeUser != null && qcodeUser.getEmail() != null && "admin".toUpperCase()
                .equals(qcodeUser.getEmail().toUpperCase())) {
            fromAdmin = "1";
        }
        model.put(FROM_ADMIN, fromAdmin);

        if (qcodeProjectFalg != null) {
            if (qcodeUser !=null){
                saveProject(qcodeUser);
                return "redirect:/QCode/index.html";
            }else {
                model.put(QCODE_PROJECT, qcodeProjectFalg);
                return "quantumCloud/index";
            }
        }

        //查询登陆用户项目
        if (qcodeUser != null) {
            QueryFilter filter = new QueryFilter();
            String versionId = request.getParameter(VERSION_ID);
            //存在项目id时查询项目相关信息并返回
            if (!(projectId == null || "".equals(projectId))) {
                //查询项目
                filter.put("id", projectId);
                //判断是否案例教程
                if (projectId.equals("257") || projectId.equals("258")) {
                    filter.put(USER_ID, 0);
                } else {
                    filter.put(USER_ID, qcodeUser.getId());
                }
                if ("1".equals(fromAdmin)) {
                    filter.remove(USER_ID);
                }
                filter.put(IS_DEL, 0);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                if (qcodeProject == null) {
                    filter = new QueryFilter();
                    filter.put(IS_DEL, 0);
                    filter.put(USER_ID, qcodeUser.getId());
                    filter.setStatementKey(SELECT_LIST_COUNT);
                    Integer count = qcodeProjectService.findOne(filter).getReturnObj();
                    //没有项目时自动创建一个新项目
                    if (count == 0) {
                        Date now = new Date();
                        QcodeProject qcodeProjectNew = new QcodeProject();
                        qcodeProjectNew.setQubitNum(6);
                        qcodeProjectNew.setClassicalbitNum(6);
                        qcodeProjectNew.setCreateTime(now);
                        SimpleDateFormat d1 = new SimpleDateFormat(YYYY_M_MDD);
                        SimpleDateFormat d2 = new SimpleDateFormat(H_HMMSS);
                        String name = d1.format(now) + "_" + d2.format(now) + QEMULATOR;
                        qcodeProjectNew.setName(name);
                        qcodeProjectNew.setTaskTypeId(2);
                        qcodeProjectNew.setUserId(qcodeUser.getId());
                        qcodeProjectNew.setIsDel(0);
                        Result r1 = qcodeProjectService.save(qcodeProjectNew);
                        qcodeProjectNew = r1.getReturnObj();
                        QueryFilter filterList = new QueryFilter();
                        filterList.put(USER_ID, qcodeUser.getId());
                        filterList.put(IS_DEL, 0);
                        filterList.put(ORDER, CREATE_TIME_DESC);
                        List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                        model.put(QCODE_PROJECT, qcodeProjectNew);
                        model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                    } else {
                        QueryFilter filterList = new QueryFilter();
                        filterList.put(USER_ID, qcodeUser.getId());
                        filterList.put(IS_DEL, 0);
                        filterList.put(ORDER, CREATE_TIME_DESC);
                        List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                        filter = new QueryFilter();
                        filter.put(PROJECT_ID, qcodeProjectList.get(0).getId());
                        filter.put(IS_DEL, 0);
                        filter.put(ORDER, CREATE_TIME_DESC);
                        List<QcodeProjectVersion> versionList =
                                qcodeProjectVersionService.findList(filter).getReturnObj();
                        if (versionList.size() > 0) {
                            versionList.get(0).setSvgXml(
                                    versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                            List<Map> versionMapList = new ArrayList<Map>();
                            //查询项目�?��版本及task
                            for (int i = 0; i < versionList.size(); i++) {
                                //查询当前版本的所有task
                                QcodeProjectVersion version = versionList.get(i);
                                Map map = new HashMap();
                                map.put(VERSION, version);
                                filter = new QueryFilter();
                                filter.put(VERSION_ID, version.getId());
                                filter.put(IS_DEL, 0);
                                filter.put(ORDER, START_TIME_DESC);
                                List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                                map.put(TASK_LIST, taskList);
                                versionMapList.add(map);
                            }
                            model.put(VERSION_MAP_LIST, versionMapList);
                        }
                        if (versionId != null) {
                            filter = new QueryFilter();
                            filter.put("id", versionId);
                            filter.put(IS_DEL, 0);
                            //当前版本
                            QcodeProjectVersion qcodeProjectVersion =
                                    qcodeProjectVersionService.findOne(filter).getReturnObj();
                            if (qcodeProjectVersion == null) {
                                model.put(PROJECT_VERSION, versionList.get(0));
                            } else {
                                model.put(PROJECT_VERSION, qcodeProjectVersion);
                            }
                        } else {
                            if (versionList.size() > 0) {
                                model.put(PROJECT_VERSION, versionList.get(0));
                            }
                        }
                        model.put(QCODE_PROJECT, qcodeProjectList.get(0));
                        model.put(QCODE_PROJECT_LIST, qcodeProjectList);

                    }
                } else {
                    //查询项目最新版本及task
                    filter = new QueryFilter();
                    filter.put(PROJECT_ID, projectId);
                    filter.put(IS_DEL, 0);
                    filter.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                    if (versionList.size() > 0) {
                        versionList.get(0).setSvgXml(
                                versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                        List<Map> versionMapList = new ArrayList<Map>();
                        model.put(PROJECT_VERSION, versionList.get(0));
                        for (int i = 0; i < versionList.size(); i++) {
                            //查询当前版本的所有task
                            QcodeProjectVersion version = versionList.get(i);
                            Map map = new HashMap();
                            map.put(VERSION, version);
                            filter = new QueryFilter();
                            filter.put(VERSION_ID, version.getId());
                            filter.put(IS_DEL, 0);
                            filter.put(ORDER, START_TIME_DESC);
                            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                            map.put(TASK_LIST, taskList);
                            versionMapList.add(map);
                        }
                        model.put(VERSION_MAP_LIST, versionMapList);

                        if (versionId != null) {
                            filter = new QueryFilter();
                            filter.put("id", versionId);
                            filter.put(IS_DEL, 0);
                            //当前版本
                            QcodeProjectVersion qcodeProjectVersion =
                                    qcodeProjectVersionService.findOne(filter).getReturnObj();
                            if (qcodeProjectVersion == null) {
                                model.put(PROJECT_VERSION, versionList.get(0));
                            } else {
                                model.put(PROJECT_VERSION, qcodeProjectVersion);
                            }
                        } else {
                            model.put(PROJECT_VERSION, versionList.get(0));
                        }
                    }

                    model.put(QCODE_PROJECT, qcodeProject);
                    QueryFilter filterList = new QueryFilter();
                    filterList.put(USER_ID, qcodeUser.getId());
                    filterList.put(IS_DEL, 0);
                    filterList.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                    model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                }
            } else {
                filter = new QueryFilter();
                filter.put(IS_DEL, 0);
                filter.put(USER_ID, qcodeUser.getId());
                filter.setStatementKey(SELECT_LIST_COUNT);
                Integer count = qcodeProjectService.findOne(filter).getReturnObj();
                //没有项目时自动创建一个新项目
                if (count == 0) {
                    Date now = new Date();
                    QcodeProject qcodeProjectNew = new QcodeProject();
                    qcodeProjectNew.setQubitNum(6);
                    qcodeProjectNew.setClassicalbitNum(6);
                    qcodeProjectNew.setCreateTime(now);
                    SimpleDateFormat d1 = new SimpleDateFormat(YYYY_M_MDD);
                    SimpleDateFormat d2 = new SimpleDateFormat(H_HMMSS);
                    String name = d1.format(now) + "_" + d2.format(now) + QEMULATOR;
                    qcodeProjectNew.setName(name);
                    qcodeProjectNew.setTaskTypeId(1);
                    qcodeProjectNew.setUserId(qcodeUser.getId());
                    qcodeProjectNew.setIsDel(0);
                    qcodeProjectNew.setAnalogType(0);
                    Result r1 = qcodeProjectService.save(qcodeProjectNew);
                    qcodeProjectNew = r1.getReturnObj();
                    QueryFilter filterList = new QueryFilter();
                    filterList.put(USER_ID, qcodeUser.getId());
                    filterList.put(IS_DEL, 0);
                    filterList.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                    model.put(QCODE_PROJECT, qcodeProjectNew);
                    model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                } else {

                    QueryFilter filterList = new QueryFilter();
                    filterList.put(USER_ID, qcodeUser.getId());
                    filterList.put(IS_DEL, 0);
                    filterList.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                    if(versionVo != null && qcodeUser !=null){
                        saveVersion(qcodeProjectList.get(0).getId().toString(),versionVo.getSvgXml(),versionVo.getCode());
                        return "redirect:/QCode/index.html";
                    }
                    filter = new QueryFilter();
                    filter.put(PROJECT_ID, qcodeProjectList.get(0).getId());
                    filter.put(IS_DEL, 0);
                    filter.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                    if (versionList.size() > 0) {
                        versionList.get(0).setSvgXml(
                                versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                        List<Map> versionMapList = new ArrayList<Map>();
                        //查询项目最新版本及task
                        for (int i = 0; i < versionList.size(); i++) {
                            //查询当前版本的所有task
                            QcodeProjectVersion version = versionList.get(i);
                            Map map = new HashMap();
                            map.put(VERSION, version);
                            filter = new QueryFilter();
                            filter.put(VERSION_ID, version.getId());
                            filter.put(IS_DEL, 0);
                            filter.put(ORDER, START_TIME_DESC);
                            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                            map.put(TASK_LIST, taskList);
                            versionMapList.add(map);
                        }
                        model.put(VERSION_MAP_LIST, versionMapList);
                        if (versionId != null) {
                            filter = new QueryFilter();
                            filter.put("id", versionId);
                            filter.put(IS_DEL, 0);
                            //当前版本
                            QcodeProjectVersion qcodeProjectVersion =
                                    qcodeProjectVersionService.findOne(filter).getReturnObj();
                            if (qcodeProjectVersion == null) {
                                model.put(PROJECT_VERSION, versionList.get(0));
                            } else {
                                model.put(PROJECT_VERSION, qcodeProjectVersion);
                            }
                        } else {
                            model.put(PROJECT_VERSION, versionList.get(0));
                        }
                    }
                    model.put(QCODE_PROJECT, qcodeProjectList.get(0));
                    model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                }
            }
        } else {
            //游客模式展示两个默认算法项目
            QueryFilter filter = new QueryFilter();
            //存在项目id时查询项目相关信息并返回
            if (!(projectId == null || "".equals(projectId))) {
                //查询项目
                filter.put("id", projectId);
                filter.put(USER_ID, 0);
                filter.put(IS_DEL, 0);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                if (qcodeProject == null) {
                    QueryFilter filterList = new QueryFilter();
                    filterList.put(USER_ID, 0);
                    filterList.put(IS_DEL, 0);
                    filterList.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                    filter = new QueryFilter();
                    filter.put(PROJECT_ID, qcodeProjectList.get(0).getId());
                    filter.put(IS_DEL, 0);
                    filter.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                    if (versionList.size() > 0) {
                        versionList.get(0).setSvgXml(
                                versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                        model.put(CURRENT_VERSION, versionList.get(0));
                        List<Map> versionMapList = new ArrayList<Map>();
                        model.put(PROJECT_VERSION, versionList.get(0));
                        //查询项目�?��版本及task
                        for (int i = 0; i < versionList.size(); i++) {
                            //查询当前版本的所有task
                            QcodeProjectVersion version = versionList.get(i);
                            Map map = new HashMap();
                            map.put(VERSION, version);
                            filter = new QueryFilter();
                            filter.put(VERSION_ID, version.getId());
                            filter.put(IS_DEL, 0);
                            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                            map.put(TASK_LIST, taskList);
                            versionMapList.add(map);
                        }
                        model.put(VERSION_MAP_LIST, versionMapList);
                    }
                    model.put(QCODE_PROJECT, qcodeProjectList.get(0));
                    model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                } else {
                    //查询项目最新版本及task
                    filter = new QueryFilter();
                    filter.put(PROJECT_ID, projectId);
                    filter.put(IS_DEL, 0);
                    filter.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                    if (versionList.size() > 0) {
                        versionList.get(0).setSvgXml(
                                versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                        model.put(CURRENT_VERSION, versionList.get(0));
                        List<Map> versionMapList = new ArrayList<Map>();
                        model.put(PROJECT_VERSION, versionList.get(0));
                        for (int i = 0; i < versionList.size(); i++) {
                            //查询当前版本的所有task
                            QcodeProjectVersion version = versionList.get(i);
                            Map map = new HashMap();
                            map.put(VERSION, version);
                            filter = new QueryFilter();
                            filter.put(VERSION_ID, version.getId());
                            filter.put(IS_DEL, 0);
                            List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                            map.put(TASK_LIST, taskList);
                            versionMapList.add(map);
                        }
                        model.put(VERSION_MAP_LIST, versionMapList);
                    }

                    model.put(QCODE_PROJECT, qcodeProject);
                    QueryFilter filterList = new QueryFilter();
                    filterList.put(USER_ID, 0);
                    filterList.put(IS_DEL, 0);
                    filterList.put(ORDER, CREATE_TIME_DESC);
                    List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();
                    model.put(QCODE_PROJECT_LIST, qcodeProjectList);
                }
            } else {
                QueryFilter filterList = new QueryFilter();
                filterList.put(USER_ID, 0);
                filterList.put(IS_DEL, 0);
                filterList.put(ORDER, CREATE_TIME_DESC);
                List<QcodeProject> qcodeProjectList = qcodeProjectService.findList(filterList).getReturnObj();

                filter = new QueryFilter();
                filter.put(PROJECT_ID, qcodeProjectList.get(0).getId());
                filter.put(IS_DEL, 0);
                filter.put(ORDER, CREATE_TIME_DESC);
                List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                if (versionList.size() > 0) {
                    versionList.get(0)
                            .setSvgXml(versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                    model.put(CURRENT_VERSION, versionList.get(0));
                    List<Map> versionMapList = new ArrayList<Map>();
                    model.put(PROJECT_VERSION, versionList.get(0));
                    //查询项目最新版本及task
                    for (int i = 0; i < versionList.size(); i++) {
                        //查询当前版本的所有task
                        QcodeProjectVersion version = versionList.get(i);
                        Map map = new HashMap();
                        map.put(VERSION, version);
                        filter = new QueryFilter();
                        filter.put(VERSION_ID, version.getId());
                        filter.put(IS_DEL, 0);
                        List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                        map.put(TASK_LIST, taskList);
                        versionMapList.add(map);
                    }
                    model.put(VERSION_MAP_LIST, versionMapList);
                }

                model.put(QCODE_PROJECT, qcodeProjectList.get(0));
                model.put(QCODE_PROJECT_LIST, qcodeProjectList);
            }
        }
        return "quantumCloud/index";
    }

    /**
     * 查询项目任务状态
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("QCode/getTaskStatus.html")
    public String getTaskStatus(Model model, HttpServletRequest request) {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return "";
        }
        String projectId = request.getParameter(PROJECT_ID);
        if (StringUtils.isBlank(projectId)) {
            return "";
        }
        //查询项目最新版本及task
        QueryFilter filter = new QueryFilter();
        filter.put(PROJECT_ID, projectId);
        filter.put(IS_DEL, 0);
        filter.put(ORDER, CREATE_TIME_DESC);
        List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
        if (versionList.size() > 0) {
            versionList.get(0).setSvgXml(
                    versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
            List<Map> versionMapList = new ArrayList<Map>();
            model.addAttribute(PROJECT_VERSION, versionList.get(0));
            for (int i = 0; i < versionList.size(); i++) {
                //查询当前版本的所有task
                QcodeProjectVersion version = versionList.get(i);
                Map map = new HashMap();
                map.put(VERSION, version);
                filter = new QueryFilter();
                filter.put(VERSION_ID, version.getId());
                filter.put(IS_DEL, 0);
                filter.put(ORDER, START_TIME_DESC);
                List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                map.put(TASK_LIST, taskList);
                versionMapList.add(map);
            }
            model.addAttribute(VERSION_MAP_LIST, versionMapList);
        }
        return "quantumCloud/taskStatus";
    }


    private void saveProject(QcodeUser qcodeUser){
        QueryFilter filter = new QueryFilter();

        QcodeProject qcodeProject =
                (QcodeProject) SecurityUtils.getSubject().getSession().getAttribute(QCODE_PROJECT);
        filter.put("name", qcodeProject.getName());
        filter.put(USER_ID, qcodeUser.getId());
        filter.put(IS_DEL, 0);
        qcodeProject.setName(qcodeProject.getName());
        qcodeProject.setDesc(qcodeProject.getDesc());
        qcodeProject.setRepeat(100);
        qcodeProject.setClassicalbitNum(qcodeProject.getClassicalbitNum());
        qcodeProject.setCreateTime(new Date());
        //半导体量子
        if (qcodeProject.getTaskTypeId() != null && qcodeProject.getTaskTypeId().equals("3")) {
            qcodeProject.setQubitNum(2);
            qcodeProject.setPic("uploadFile/semi" + qcodeProject.getSemi() + ".png");
        } else {
            qcodeProject.setQubitNum(qcodeProject.getQubitNum());
        }
        qcodeProject.setTaskTypeId(qcodeProject.getTaskTypeId());
        qcodeProject.setUserId(qcodeUser.getId());
        qcodeProject.setIsDel(0);
        qcodeProject.setAnalogType(qcodeProject.getAnalogType() == null ? 0 : qcodeProject.getAnalogType());

        qcodeProjectService.save(qcodeProject);
        SecurityUtils.getSubject().getSession().setAttribute(QCODE_PROJECT, null);
    }

    private  void saveVersion(String projectId,String svgXml,String code){
        QueryFilter filter = new QueryFilter();
        filter.put("id", projectId);
        QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
        //无版本时直接创建第一个版本>创建运行任务
        String pic = "uploadFile/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD);

        File file = new File(AppContextHolder.getFileSavePath() + pic);
        if (!file.exists() || !file.isDirectory()) {
            // 如果文件夹不存在则创建
            file.mkdirs();
        }
        pic += "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYYMMDDHHMMSSSSS) + ".png";

        try {
            SvgUtil.convertSVGString2Png(svgXml.replaceAll("fill=\"black\"", "fill=\"none\""),
                    new File(AppContextHolder.getFileSavePath() + pic));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //指定坐标
        try {
            String thumbnail = AppContextHolder.getFileSavePath() + pic;
            Thumbnails.of(thumbnail).sourceRegion(50, 0, 576, 360).size(192, 120).keepAspectRatio(false)
                    .toFile(thumbnail);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //创建第一个版本
        QcodeProjectVersion qcodeProjectVersion = new QcodeProjectVersion();
        qcodeProjectVersion.setCode(code);
        qcodeProjectVersion.setSvgXml(svgXml);
        qcodeProjectVersion.setCreateTime(new Date());
        qcodeProjectVersion.setName("V1");
        qcodeProjectVersion.setProjectId(qcodeProject.getId());
        qcodeProjectVersion.setPic(pic);
        qcodeProjectVersion.setIsDel(0);
        Result r2 = qcodeProjectVersionService.save(qcodeProjectVersion);
        qcodeProject.setPic(pic);
        qcodeProjectService.update(qcodeProject);
        SecurityUtils.getSubject().getSession().setAttribute("versionVo",null);

    }
    /**
     * 保存新版本到session
     */
    @RequestMapping(value = "QCode/visitorRunning.json")
    @ResponseBody
    public ResponseData visitorRunning(HttpServletRequest request) {
        String code = request.getParameter("code");
        String svgXml = request.getParameter("svgXml");
        //String meaarr = request.getParameter("meaarr");
        QcodeProjectVersion versionVo = new QcodeProjectVersion();
        versionVo.setCode(code);
        versionVo.setSvgXml(svgXml);
        SecurityUtils.getSubject().getSession().setAttribute("versionVo", versionVo);
        ResponseData data = new ResponseData(true);
        return data;
    }

    /**
     * 获取用户所有项目
     */
    @RequestMapping(value = "QCode/project.html")
    public String project(ModelMap model, HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();

        if (qcodeUser != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put(USER_ID, qcodeUser.getId());
            filter.put(IS_DEL, 0);
            filter.setLimit(8);
            filter.put(ORDER, CREATE_TIME_DESC);
            model.put("pager", qcodeProjectService.findPager(filter).getReturnObj());
        }

        return "quantumCloud/project";
    }

    /**
     * 教程页面获取
     */
    @RequestMapping(value = "QCode/library.html")
    public String library() {
        return "quantumCloud/library";
    }
    /**
     * 视频页面页面获取
     */
    @RequestMapping(value = "QCode/videoLibrary.html")
    public String videoLibrary() {
        return "quantumCloud/videoLibrary";
    }
    /**
     * 教程新版页面获取
     */
    @RequestMapping(value = "QCode/libraries.html")
    public String libraries() {
        return "quantumCloud/libraries";
    }

    /**
     * 教程量子算法二级界面
     */
    @RequestMapping(value = "QCode/LibAlgorithm.html")
    public String LibAlgorithm() {
        return "quantumCloud/LibAlgorithm";
    }

    /**
     * 社区页面获取
     */
    @RequestMapping(value = "QCode/community.html")
    public String community() {
        return "quantumCloud/community";
    }


    /**
     * 编辑器主页保存新版本
     */
    @RequestMapping(value = "QCode/save.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData save(HttpServletRequest request) {
        //获取当前登陆用户

        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter();
        String projectId = request.getParameter(PROJECT_ID);
        String versionId = request.getParameter(VERSION_ID);
        String code = request.getParameter("code");
        //code = (code.replace("\r", "")).replace("\n", "#")+"#";
        //code = (code.replace("\r", "")).replace("\n", "");
        String svgXml = request.getParameter("svgXml");
        if ((projectId == null || "".equals(projectId))) {
            return new ResponseData(false, getMessage("id_is_empty"));
        }
        String pic = "uploadFile/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD);

        File file = new File(AppContextHolder.getFileSavePath() + pic);
        if (!file.exists() || !file.isDirectory()) {
            // 如果文件夹不存在则创建
            file.mkdirs();
        }
        pic += "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYYMMDDHHMMSSSSS) + ".png";

        try {
            SvgUtil.convertSVGString2Png(svgXml.replaceAll("fill=\"black\"", "fill=\"none\""),
                    new File(AppContextHolder.getFileSavePath() + pic));
        } catch (IOException e) {
            e.printStackTrace();
        }

        //指定坐标
        try {
            String thumbnail = AppContextHolder.getFileSavePath() + pic;
            Thumbnails.of(thumbnail).sourceRegion(50, 0, 576, 360).size(192, 120).keepAspectRatio(false)
                    .toFile(thumbnail);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //查询项目
        filter.put("id", projectId);
        filter.put(USER_ID, qcodeUser.getId());
        filter.put(IS_DEL, 0);
        QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();

        if (qcodeProject == null) {
            return new ResponseData(false, getMessage("project_does_not_exist"));
        }
        if (!(versionId == null || "".equals(versionId))) {
            //查询版本
            filter = new QueryFilter();
            filter.put("id", versionId);
            filter.put(IS_DEL, 0);
            QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
            if (code.equals(qcodeProjectVersion.getCode())) {
                return new ResponseData(false, getMessage("code_is_not_modified"));
            } else if (qcodeProjectVersion.getCode() == null || "".equals(qcodeProjectVersion.getCode())) {
                qcodeProjectVersion.setCode(code);
                qcodeProjectVersion.setPic(pic);
                qcodeProjectVersion.setSvgXml(svgXml);
                Result result = qcodeProjectVersionService.update(qcodeProjectVersion);
                if (!result.isSuccess()) {
                    return new ResponseData(false, result.getErrormsg());
                }
                qcodeProject.setPic(pic);
                qcodeProjectService.update(qcodeProject);
            } else {
                filter = new QueryFilter();
                filter.put(PROJECT_ID, projectId);
                filter.setStatementKey(SELECT_LIST_COUNT);
                Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
                String name = "V" + (versionCount + 1);
                //创建新版本
                QcodeProjectVersion versionNew = new QcodeProjectVersion();
                versionNew.setCode(code);
                versionNew.setCreateTime(new Date());
                versionNew.setName(name);
                versionNew.setProjectId(qcodeProject.getId());
                versionNew.setPic(pic);
                versionNew.setIsDel(0);
                versionNew.setSvgXml(svgXml);
                Result result = qcodeProjectVersionService.save(versionNew);
                if (!result.isSuccess()) {
                    return new ResponseData(false, result.getErrormsg());
                }

                qcodeProject.setPic(pic);
                Result re = qcodeProjectService.update(qcodeProject);

                if (!re.isSuccess()) {
                    return new ResponseData(false, re.getErrormsg());
                }

            }
        } else {
            filter = new QueryFilter();
            filter.put(PROJECT_ID, projectId);
            filter.setStatementKey(SELECT_LIST_COUNT);
            Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
            String name = "V" + (versionCount + 1);
            //创建新版本
            QcodeProjectVersion versionNew = new QcodeProjectVersion();
            versionNew.setCode(code);
            versionNew.setCreateTime(new Date());
            versionNew.setName(name);
            versionNew.setProjectId(qcodeProject.getId());
            versionNew.setPic(pic);
            versionNew.setIsDel(0);
            versionNew.setSvgXml(svgXml);
            Result result = qcodeProjectVersionService.save(versionNew);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }

            qcodeProject.setPic(pic);
            Result re = qcodeProjectService.update(qcodeProject);

            if (!re.isSuccess()) {
                return new ResponseData(false, re.getErrormsg());
            }
        }

        return ResponseData.SUCCESS_NO_DATA;

    }

    /**
     * 新增项目版本
     */
    @RequestMapping(value = "QCode/saveProjectVersion.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData saveProjectVersion(HttpServletRequest request) {
        try {

            QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
            if (qcodeUser == null) {
                return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
            }
            ResponseData data = new ResponseData(true);
            //项目id
            String projectId = request.getParameter(PROJECT_ID);
            //code
            String code = request.getParameter("code");
            //code = (code.replace("\r", "")).replace("\n", "#")+"#";
            //code = (code.replace("\r", "")).replace("\n", "");
            QueryFilter filter = new QueryFilter();
            filter.put(PROJECT_ID, projectId);
            filter.setStatementKey(QcodeProjectVersionService.SELECTLIST_COUNT);
            Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
            String name = "V" + (versionCount + 1);
            QcodeProjectVersion qcodeProjectVersion = new QcodeProjectVersion();
            qcodeProjectVersion.setCode(code);
            qcodeProjectVersion.setCreateTime(new Date());
            qcodeProjectVersion.setName(name);
            qcodeProjectVersion.setPic("");
            qcodeProjectVersion.setProjectId(Long.parseLong(projectId));

            Result result = qcodeProjectVersionService.save(qcodeProjectVersion);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
            data.setObj(result.getReturnObj());
            return data;
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains(PRIMARY)) {
                result.addErrormsg(getMessage("id_repeat"));
            }
            return new ResponseData(false, result);
        }
    }

    /**
     * 新增项目
     */
    @RequestMapping(value = "QCode/saveProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData saveProject(HttpServletRequest request) {
        try {

            QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
            if (qcodeUser == null) {
                return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
            }
            QueryFilter filter = new QueryFilter();

            ResponseData data = new ResponseData(true);
            //任务类型
            String taskTypeId = request.getParameter("taskTypeId");
            //项目名称
            String name = request.getParameter("name");
            //项目描述
            String desc = request.getParameter("desc");
            //量子比特数
            String qubitNum =
                    (String) (("".equals(request.getParameter("qubitNum"))) ? '6' : request.getParameter("qubitNum"));
            //经典寄存器数
            String classicalbitNum = (String) (("".equals(request.getParameter("classicalbitNum"))) ? '6' :
                    request.getParameter("classicalbitNum"));
            //教程号
            String semi = request.getParameter("semi");
            //模拟类型
            String analogType = request.getParameter("analogType");

            //判断用户等级及量子比特数
            if (qcodeUser.getLevel().intValue() == QcodeUser.QCODEUSER_LEVEL_1) {//一级用户
                //判断量子比特数是否在20位以内
                if (Integer.parseInt(qubitNum) > 20) {
                    return new ResponseData(false, getMessage("first_level_user_prompt"));
                }
            } else if (qcodeUser.getLevel().intValue() == QcodeUser.QCODEUSER_LEVEL_2) {//二级用户
                //判断量子比特数是否在32位以内
                if (Integer.parseInt(qubitNum) > 32) {
                    return new ResponseData(false, getMessage("two_level_user_prompt"));
                }
            } else if (qcodeUser.getLevel().intValue() == QcodeUser.QCODEUSER_LEVEL_3) {//三级用户
                //判断量子比特数是否在42位以内
                //return new ResponseData(false,"您为三级用户，无权操作30位以上量子比特");
            }

            filter.put("name", name);
            filter.put(USER_ID, qcodeUser.getId());
            filter.put(IS_DEL, 0);
            QcodeProject qcodeProjectByName = qcodeProjectService.findOne(filter).getReturnObj();
            if (qcodeProjectByName != null) {
                return new ResponseData(false, getMessage("duplicate_project_name"));
            }
            QcodeProject qcodeProject = new QcodeProject();
            qcodeProject.setName(name);
            qcodeProject.setDesc(desc);
            qcodeProject.setRepeat(100);
            qcodeProject.setClassicalbitNum(Integer.parseInt(classicalbitNum));
            qcodeProject.setCreateTime(new Date());
            //半导体量子
            if (taskTypeId != null && taskTypeId.equals("3")) {
                qcodeProject.setQubitNum(2);
                qcodeProject.setPic("uploadFile/semi" + semi + ".png");
            } else {
                qcodeProject.setQubitNum(Integer.parseInt(qubitNum));
            }
            qcodeProject.setTaskTypeId(Integer.parseInt(taskTypeId));
            qcodeProject.setUserId(qcodeUser.getId());
            qcodeProject.setIsDel(0);
            qcodeProject.setAnalogType(analogType == null ? 0 : Integer.parseInt(analogType));

            Result result = qcodeProjectService.save(qcodeProject);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
            qcodeProject = result.getReturnObj();
            //QcodeProjectVersion versionDefault = new QcodeProjectVersion();
            //半导体量子只能新建教程
            if (taskTypeId != null && taskTypeId.equals("3")) {
                //获取初始化数据
                filter = new QueryFilter();
                filter.put("keyname", "semi" + semi);
                SysConfig sysConfigCode = sysConfigService.findOne(filter).getReturnObj();
                filter.put("keyname", "semiSvg" + semi);
                SysConfig sysConfigSvg = sysConfigService.findOne(filter).getReturnObj();
                //versionDefault.setCode(sysConfigCode.getVal());
                //versionDefault.setPic("uploadFile/semi" + semi + ".png");
                //versionDefault.setSvgXml(sysConfigSvg.getVal());
                //} else {
                //versionDefault.setCode("");
                //versionDefault.setPic("");
                //versionDefault.setSvgXml("");
            }
            //versionDefault.setCreateTime(new Date());
            //versionDefault.setIsDel(0);
            //versionDefault.setName("V1");
            //versionDefault.setProjectId(qcodeProject.getId());
            //Result r = qcodeProjectVersionService.save(versionDefault);
            //if (!r.isSuccess()) {
            //    return new ResponseData(false, r.getErrormsg());
            //}
            data.setObj(result.getReturnObj());
            return data;
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains(PRIMARY)) {
                result.addErrormsg(getMessage("id_repeat"));
            }
            return new ResponseData(false, result);
        }
    }

    /**
     * 游客新增项目保存在Session
     */
    @RequestMapping(value = "QCode/visitorSaveProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData visitorSaveProject(HttpServletRequest request) {
        try {

            ResponseData data = new ResponseData(true);
            //任务类型
            String taskTypeId = request.getParameter("taskTypeId");
            //项目名称
            String name = request.getParameter("name");
            //项目描述
            String desc = request.getParameter("desc");
            //量子比特数
            String qubitNum =
                    (String) (("".equals(request.getParameter("qubitNum"))) ? '6' : request.getParameter("qubitNum"));
            //经典寄存器数
            String classicalbitNum = (String) (("".equals(request.getParameter("classicalbitNum"))) ? '6' :
                    request.getParameter("classicalbitNum"));
            //教程号
            String semi = request.getParameter("semi");
            //模拟类型
            String analogType = request.getParameter("analogType");

            //判断用户等级及量子比特数
            if (Integer.parseInt(qubitNum) > 6) {
                return new ResponseData(false, getMessage("无权操作6位以上的量子比特"));
            }

            QcodeProject qcodeProject = new QcodeProject();
            qcodeProject.setName(name);
            qcodeProject.setDesc(desc);
            qcodeProject.setRepeat(100);
            qcodeProject.setClassicalbitNum(Integer.parseInt(classicalbitNum));
            qcodeProject.setCreateTime(new Date());
            //半导体量子
            if (taskTypeId != null && taskTypeId.equals("3")) {
                qcodeProject.setQubitNum(2);
                qcodeProject.setPic("uploadFile/semi" + semi + ".png");
            } else {
                qcodeProject.setQubitNum(Integer.parseInt(qubitNum));
            }
            qcodeProject.setTaskTypeId(Integer.parseInt(taskTypeId));
            qcodeProject.setIsDel(0);
            qcodeProject.setAnalogType(analogType == null ? 0 : Integer.parseInt(analogType));
            SecurityUtils.getSubject().getSession().setAttribute(QCODE_PROJECT, qcodeProject);
            return data;
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains(PRIMARY)) {
                result.addErrormsg(getMessage("id_repeat"));
            }
            return new ResponseData(false, result);
        }
    }

    /**
     * 编辑项目
     */
    @RequestMapping(value = "QCode/updateProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData updateProject(HttpServletRequest request) {

        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        ResponseData data = new ResponseData(true);
        //项目id
        String projectId = request.getParameter(PROJECT_ID);
        //项目描述
        String desc = request.getParameter("desc");
        //重复次数
        String repeat = request.getParameter(REPEAT);

        QueryFilter filter = new QueryFilter();
        filter.put("id", projectId);
        filter.put(USER_ID, qcodeUser.getId());
        filter.put("idDel", 0);
        QcodeProject qcodeProjectById = qcodeProjectService.findOne(filter).getReturnObj();
        if (qcodeProjectById == null) {
            return new ResponseData(false, getMessage("project_does_not_exist"));
        }
        qcodeProjectById.setDesc(desc);
        if (repeat != null) {
            qcodeProjectById.setRepeat(Integer.parseInt(repeat));
        }

        Result result = qcodeProjectService.update(qcodeProjectById);
        if (!result.isSuccess()) {
            return new ResponseData(false, result.getErrormsg());
        }
        data.setObj(result.getReturnObj());

        return data;
    }


    /**
     * 获取task
     */
    @RequestMapping(value = "QCode/getTaskData.json")
    @ResponseBody
    public ResponseData getTaskData(HttpServletRequest request) {

        ResponseData data = new ResponseData(true);
        QueryFilter filter = new QueryFilter(request);
        QcodeTask qcodeTaskById = qcodeTaskService.findOne(filter).getReturnObj();
        if (qcodeTaskById == null) {
            return new ResponseData(false, getMessage(TASK_DOES_NOT_EXIST));
        }
        data.setObj(qcodeTaskById);
        return data;
    }

    /**
     * 运行任务
     */
    @RequestMapping(value = "QCode/running.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData running(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        ResponseData data = new ResponseData(true);
        if (qcodeUser == null) {
            //游客模式直接获取数据
            String versionId = request.getParameter(VERSION_ID);
            QueryFilter filter = new QueryFilter();
            filter.put(VERSION_ID, versionId);
            QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
            data.setObj(qcodeTask);
            return data;
        } else {
            String projectId = request.getParameter(PROJECT_ID);
            String versionId = request.getParameter(VERSION_ID);
            //教程直接获取数据
            if (projectId.equals("257") || projectId.equals("258")) {
                //游客模式直接获取数据
                QueryFilter filter = new QueryFilter();
                filter.put(VERSION_ID, versionId);
                QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
                data.setObj(qcodeTask);
                return data;
            }
            //单个用户运行中任务上限为3个
            QueryFilter filterTask = new QueryFilter();
            filterTask.put(USER_ID, qcodeUser.getId());
            filterTask.put(IS_DEL, 0);
            List<String> statusList = new ArrayList<String>();
            statusList.add(QcodeTask.STATUS_PROCESS);
            statusList.add(QcodeTask.STATUS_WAITING);
            filterTask.put("statusList", statusList);
            filterTask.setStatementKey("getRunningTask_count");
            Integer count = qcodeTaskService.findOne(filterTask).getReturnObj();
            if (count > 2) {
                return new ResponseData(false, getMessage(NUMBER_HAS_REACHED));
            }

            String code = request.getParameter("code");
            String code2 = request.getParameter("code2");
            String meaarr = request.getParameter(MEAARR);
            if ("".equals(code) || code == null) {
                return new ResponseData(false, getMessage("code_error"));
            }
            //code = (code.replace("\r", "")).replace("\n", "#")+"#";
            //code = (code.replace("\r", "")).replace("\n", "");
            String svgXml = request.getParameter("svgXml");

            String pic = "uploadFile/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYY_MM_DD);

            File file = new File(AppContextHolder.getFileSavePath() + pic);
            if (!file.exists() || !file.isDirectory()) {
                // 如果文件夹不存在则创建
                file.mkdirs();
            }
            pic += "/" + DateUtils.formatDatetime(new Date(), DateStyle.YYYYMMDDHHMMSSSSS) + ".png";

            try {
                SvgUtil.convertSVGString2Png(svgXml.replaceAll("fill=\"black\"", "fill=\"none\""),
                        new File(AppContextHolder.getFileSavePath() + pic));
            } catch (IOException e) {
                e.printStackTrace();
            }

            //指定坐标
            try {
                String thumbnail = AppContextHolder.getFileSavePath() + pic;
                Thumbnails.of(thumbnail).sourceRegion(50, 0, 576, 360).size(192, 120).keepAspectRatio(false)
                        .toFile(thumbnail);
            } catch (IOException e) {
                e.printStackTrace();
            }


            QueryFilter filter;
            if (projectId == null || "".equals(projectId)) {
                Date now = new Date();
                //未选中项目时创建新项目>创建第一个版本>创建运行任务
                //创建项目
                QcodeProject qcodeProject = new QcodeProject();
                qcodeProject.setQubitNum(6);
                qcodeProject.setClassicalbitNum(6);
                qcodeProject.setRepeat(100);
                qcodeProject.setCreateTime(now);
                SimpleDateFormat d1 = new SimpleDateFormat(YYYY_M_MDD);
                SimpleDateFormat d2 = new SimpleDateFormat(H_HMMSS);
                String name = d1.format(now) + "_" + d2.format(now) + QEMULATOR;
                qcodeProject.setName(name);
                qcodeProject.setTaskTypeId(2);
                qcodeProject.setUserId(qcodeUser.getId());
                qcodeProject.setIsDel(0);
                qcodeProject.setPic(pic);
                Result r1 = qcodeProjectService.save(qcodeProject);
                if (!r1.isSuccess()) {
                    return new ResponseData(false, r1.getErrormsg());
                }
                qcodeProject = r1.getReturnObj();
                //创建第一个版本
                QcodeProjectVersion qcodeProjectVersion = new QcodeProjectVersion();
                qcodeProjectVersion.setCode(code);
                qcodeProjectVersion.setSvgXml(svgXml);
                qcodeProjectVersion.setCreateTime(now);
                qcodeProjectVersion.setIsDel(0);
                qcodeProjectVersion.setName("V1");
                qcodeProjectVersion.setProjectId(qcodeProject.getId());
                qcodeProjectVersion.setPic(pic);
                Result r2 = qcodeProjectVersionService.save(qcodeProjectVersion);
                if (!r2.isSuccess()) {
                    return new ResponseData(false, r2.getErrormsg());
                }
                qcodeProjectVersion = r2.getReturnObj();
                //创建任务并运行
                HashMap paramTask = new HashMap();

                //当前系统支持三种类型的任务（模拟Monte_carlo方法对应任务类型为2，1-20位模拟概率方法对应任务类型3，21-30位模拟概率方法对应任务类型4）
                if (qcodeProject.getQubitNum() > 20) {
                    //单个用户运行中的21-32位的任务最多为一个
                    filterTask.put(MIN_QUBIT_NUM, 20);
                    Integer count1 = qcodeTaskService.findOne(filterTask).getReturnObj();
                    if (count1 > 0) {
                        return new ResponseData(false, getMessage(NUMBER_HAS_REACHED));
                    }
                    paramTask.put(TASK_TYP, "4");
                    paramTask.put(QPROG, code);
                    paramTask.put(MEAARR, meaarr);
                    paramTask.put("qbit", qcodeProject.getQubitNum().toString());
                    paramTask.put("typ", MIDPR);
                } else {
                    if (qcodeProject.getAnalogType() == 0) {
                        paramTask.put(TASK_TYP, "2");
                        paramTask.put(QPROG, code);
                        paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
                        paramTask.put("typ", "mcpr");
                    } else if (qcodeProject.getAnalogType() == 1) {
                        paramTask.put(TASK_TYP, "3");
                        paramTask.put(QPROG, code);
                        paramTask.put(MEAARR, meaarr);
                        paramTask.put("typ", SMAPR);
                    }else if (qcodeProject.getAnalogType() == 2) {
                    	return new ResponseData(false, getMessage(REALCHIP_BUSY));
//                        paramTask.put(TASK_TYP, "6");
//                        paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
//                        paramTask.put(QPROG, code2);
//                        paramTask.put("typ", "realchip");
                    } else {
                        return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                    }
                }

                //提交任务，获取返回的task_id
                String s1 = qcodeTaskService.submitTask(paramTask);
                JSONObject json = JSONObject.parseObject(s1);
                if (json.size() == 0) {
                    logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                    return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                }
                //任务id
                String taskId = (String) json.get(TASKID);
                //任务状态
                String tasksta = (String) json.get(TASKSTA);
                //创建任务并存运行
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
                        String ans = (String) json.get(TASKRS);
                        qcodeTask.setEndTime(new Date());
                        if (ans != null && !("".equals(ans))) {
                            //有结果且正确
                            qcodeTask.setStatus(QcodeTask.STATUS_RESULT);
                            qcodeTask.setAns(ans);
                        } else {
                            //有结果为空，语法错误
                            qcodeTask.setStatus(QcodeTask.STATUS_ERROR);
                        }

                        break;
                    default:
                        break;
                }
                if (qcodeProject.getQubitNum() > 20) {
                    qcodeTask.setMeaarr(meaarr);
                } else {
                    qcodeTask.setRepeat(qcodeProject.getRepeat());
                }
                qcodeTask.setType((String) paramTask.get(TASK_TYP));
                qcodeTask.setVersionId(qcodeProjectVersion.getId());
                qcodeTask.setTaskId(taskId);
                qcodeTask.setStartTime(new Date());
                qcodeTask.setClassicRegisterName("c");
                qcodeTask.setIsDel(0);
                Result result = qcodeTaskService.save(qcodeTask);
                if (!result.isSuccess()) {
                    return new ResponseData(false, result.getErrormsg());
                }
                data.setObj(qcodeTask);
                return data;
            } else {
                filter = new QueryFilter();
                filter.put("id", projectId);
                QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
                //无版本时直接创建第一个版本>创建运行任务
                if (versionId == null || "".equals(versionId)) {
                    //创建第一个版本
                    QcodeProjectVersion qcodeProjectVersion = new QcodeProjectVersion();
                    qcodeProjectVersion.setCode(code);
                    qcodeProjectVersion.setSvgXml(svgXml);
                    qcodeProjectVersion.setCreateTime(new Date());
                    qcodeProjectVersion.setName("V1");
                    qcodeProjectVersion.setProjectId(qcodeProject.getId());
                    qcodeProjectVersion.setPic(pic);
                    qcodeProjectVersion.setIsDel(0);
                    Result r2 = qcodeProjectVersionService.save(qcodeProjectVersion);
                    if (!r2.isSuccess()) {
                        return new ResponseData(false, r2.getErrormsg());
                    }
                    qcodeProject.setPic(pic);
                    qcodeProjectService.update(qcodeProject);

                    qcodeProjectVersion = r2.getReturnObj();
                    //创建任务并运行
                    HashMap paramTask = new HashMap();

                    //当前系统支持三种类型的任务（模拟Monte_carlo方法对应任务类型为2，1-20位模拟概率方法对应任务类型3，21-30位模拟概率方法对应任务类型4）
                    if (qcodeProject.getQubitNum() > 20) {
                        //单个用户运行中的21-32位的任务最多为一个
                        filterTask.put(MIN_QUBIT_NUM, 20);
                        Integer count1 = qcodeTaskService.findOne(filterTask).getReturnObj();
                        if (count1 > 0) {
                            return new ResponseData(false, getMessage(NUMBER_HAS_REACHED));
                        }
                        paramTask.put(TASK_TYP, "4");
                        paramTask.put(QPROG, code);
                        paramTask.put(MEAARR, meaarr);
                        paramTask.put("qbit", qcodeProject.getQubitNum().toString());
                        paramTask.put("typ", MIDPR);
                    } else {
                        if (qcodeProject.getAnalogType() == 0) {
                            paramTask.put(TASK_TYP, "2");
                            paramTask.put(QPROG, code);
                            paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
                            paramTask.put("typ", "mcpr");
                        } else if (qcodeProject.getAnalogType() == 1) {
                            paramTask.put(TASK_TYP, "3");
                            paramTask.put(QPROG, code);
                            paramTask.put(MEAARR, meaarr);
                            paramTask.put("typ", SMAPR);
                        } else if (qcodeProject.getAnalogType() == 2) {
                        	return new ResponseData(false, getMessage(REALCHIP_BUSY));
//                            paramTask.put(TASK_TYP, "6");
//                            paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
//                            paramTask.put(QPROG, code2);
//                            paramTask.put("typ", "realchip");
                        } else {
                            return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                        }
                    }

                    //提交任务，获取返回的task_id
                    String s1 = qcodeTaskService.submitTask(paramTask);
                    JSONObject json = JSONObject.parseObject(s1);
                    if (json.size() == 0) {
                        logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                        return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                    }
                    //任务id
                    String taskId = (String) json.get(TASKID);
                    //任务状态
                    String tasksta = (String) json.get(TASKSTA);
                    //创建任务并存运行
                    QcodeTask qcodeTask = new QcodeTask();
                    if (qcodeProject.getQubitNum() > 20) {
                        qcodeTask.setMeaarr(meaarr);
                    } else {
                        qcodeTask.setRepeat(qcodeProject.getRepeat());
                    }
                    qcodeTask.setType((String) paramTask.get(TASK_TYP));
                    qcodeTask.setVersionId(qcodeProjectVersion.getId());
                    qcodeTask.setTaskId(taskId);
                    qcodeTask.setStartTime(new Date());
                    qcodeTask.setClassicRegisterName("c");
                    qcodeTask.setIsDel(0);
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
                            String ans = (String) json.get(TASKRS);
                            qcodeTask.setEndTime(new Date());
                            if (ans != null && !("".equals(ans))) {
                                //有结果且正确
                                qcodeTask.setStatus(QcodeTask.STATUS_RESULT);
                                qcodeTask.setAns(ans);
                            } else {
                                //有结果为空，语法错误
                                qcodeTask.setStatus(QcodeTask.STATUS_ERROR);
                            }

                            break;
                        default:
                            break;
                    }

                    Result result = qcodeTaskService.save(qcodeTask);
                    if (!result.isSuccess()) {
                        return new ResponseData(false, result.getErrormsg());
                    }
                    data.setObj(qcodeTask);
                    return data;
                } else {
                    filter.put("id", versionId);
                    QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
                    //选中项目时判断code是否变化，若变化创建新版本并创建运行任务，若无变化直接创建运行任务
                    if (code.equals(qcodeProjectVersion.getCode())) {
                        HashMap paramTask = new HashMap();

                        //当前系统支持三种类型的任务（模拟Monte_carlo方法对应任务类型为2，1-20位模拟概率方法对应任务类型3，21-30位模拟概率方法对应任务类型4）
                        if (qcodeProject.getQubitNum() > 20) {
                            //单个用户运行中的21-32位的任务最多为一个
                            filterTask.put(MIN_QUBIT_NUM, 20);
                            Integer count1 = qcodeTaskService.findOne(filterTask).getReturnObj();
                            if (count1 > 0) {
                                return new ResponseData(false, getMessage(NUMBER_HAS_REACHED));
                            }
                            paramTask.put(TASK_TYP, "4");
                            paramTask.put(QPROG, code);
                            paramTask.put(MEAARR, meaarr);
                            paramTask.put("qbit", qcodeProject.getQubitNum().toString());
                            paramTask.put("typ", MIDPR);
                        } else {
                            if (qcodeProject.getAnalogType() == 0) {
                                paramTask.put(TASK_TYP, "2");
                                paramTask.put(QPROG, code);
                                paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
                                paramTask.put("typ", "mcpr");
                            } else if (qcodeProject.getAnalogType() == 1) {
                                paramTask.put(TASK_TYP, "3");
                                paramTask.put(QPROG, code);
                                paramTask.put(MEAARR, meaarr);
                                paramTask.put("typ", SMAPR);
                            } else if (qcodeProject.getAnalogType() == 2) {
                            	return new ResponseData(false, getMessage(REALCHIP_BUSY));
//                                paramTask.put(TASK_TYP, "6");
//                                paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
//                                paramTask.put(QPROG, code2);
//                                paramTask.put("typ", "realchip");
                            } else {
                                return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                            }
                        }

                        //提交任务，获取返回的task_id
                        String s1 = qcodeTaskService.submitTask(paramTask);
                        JSONObject json = JSONObject.parseObject(s1);
                        if (json.size() == 0) {
                            logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                            return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                        }
                        //任务id
                        String taskId = (String) json.get(TASKID);
                        //任务状态
                        String tasksta = (String) json.get(TASKSTA);
                        //创建任务并存运行
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
                                String ans = (String) json.get(TASKRS);
                                qcodeTask.setEndTime(new Date());
                                if (ans != null && !("".equals(ans))) {
                                    //有结果且正确
                                    qcodeTask.setStatus(QcodeTask.STATUS_RESULT);
                                    qcodeTask.setAns(ans);
                                } else {
                                    //有结果为空，语法错误
                                    qcodeTask.setStatus(QcodeTask.STATUS_ERROR);
                                }

                                break;
                            default:
                                break;
                        }
                        if (qcodeProject.getQubitNum() > 20) {
                            qcodeTask.setMeaarr(meaarr);
                        } else {
                            qcodeTask.setRepeat(qcodeProject.getRepeat());
                        }
                        qcodeTask.setType((String) paramTask.get(TASK_TYP));
                        qcodeTask.setVersionId(qcodeProjectVersion.getId());
                        qcodeTask.setTaskId(taskId);
                        qcodeTask.setStartTime(new Date());
                        qcodeTask.setClassicRegisterName("c");
                        qcodeTask.setIsDel(0);

                        Result result = qcodeTaskService.save(qcodeTask);
                        if (!result.isSuccess()) {
                            return new ResponseData(false, result.getErrormsg());
                        }
                        data.setObj(qcodeTask);
                        return data;
                    } else {
                        Long vId = qcodeProjectVersion.getId();
                        if (qcodeProjectVersion.getCode() == null || "".equals(qcodeProjectVersion.getCode())) {
                            qcodeProjectVersion.setCode(code);
                            qcodeProjectVersion.setPic(pic);
                            qcodeProjectVersion.setSvgXml(svgXml);
                            Result result = qcodeProjectVersionService.update(qcodeProjectVersion);
                            if (!result.isSuccess()) {
                                return new ResponseData(false, result.getErrormsg());
                            }
                        } else {
                            filter = new QueryFilter();
                            filter.put(PROJECT_ID, projectId);
                            filter.setStatementKey(QcodeProjectVersionService.SELECTLIST_COUNT);
                            Integer versionCount = qcodeProjectVersionService.findOne(filter).getReturnObj();
                            String name = "V" + (versionCount + 1);
                            //创建新版本
                            QcodeProjectVersion versionNew = new QcodeProjectVersion();
                            versionNew.setCode(code);
                            versionNew.setSvgXml(svgXml);
                            versionNew.setCreateTime(new Date());
                            versionNew.setName(name);
                            versionNew.setProjectId(qcodeProject.getId());
                            versionNew.setPic(pic);
                            versionNew.setIsDel(0);
                            Result taskNewRe = qcodeProjectVersionService.save(versionNew);
                            if (!taskNewRe.isSuccess()) {
                                return new ResponseData(false, taskNewRe.getErrormsg());
                            }
                            versionNew = taskNewRe.getReturnObj();
                            vId = versionNew.getId();
                        }
                        qcodeProject.setPic(pic);
                        qcodeProjectService.update(qcodeProject);

                        HashMap paramTask = new HashMap();

                        //当前系统支持三种类型的任务（模拟Monte_carlo方法对应任务类型为2，1-20位模拟概率方法对应任务类型3，21-30位模拟概率方法对应任务类型4）
                        if (qcodeProject.getQubitNum() > 20) {
                            //单个用户运行中的21-32位的任务最多为一个
                            filterTask.put(MIN_QUBIT_NUM, 20);
                            Integer count1 = qcodeTaskService.findOne(filterTask).getReturnObj();
                            if (count1 > 0) {
                                return new ResponseData(false, getMessage(NUMBER_HAS_REACHED));
                            }
                            paramTask.put(TASK_TYP, "4");
                            paramTask.put(QPROG, code);
                            paramTask.put(MEAARR, meaarr);
                            paramTask.put("qbit", qcodeProject.getQubitNum().toString());
                            paramTask.put("typ", MIDPR);
                        } else {
                            if (qcodeProject.getAnalogType() == 0) {
                                paramTask.put(TASK_TYP, "2");
                                paramTask.put(QPROG, code);
                                paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
                                paramTask.put("typ", "mcpr");
                            } else if (qcodeProject.getAnalogType() == 1) {
                                paramTask.put(TASK_TYP, "3");
                                paramTask.put(QPROG, code);
                                paramTask.put(MEAARR, meaarr);
                                paramTask.put("typ", SMAPR);
                            } else if (qcodeProject.getAnalogType() == 2) {
                            	return new ResponseData(false, getMessage(REALCHIP_BUSY));
//                                paramTask.put(TASK_TYP, "6");
//                                paramTask.put(REPEAT, qcodeProject.getRepeat().toString());
//                                paramTask.put(QPROG, code2);
//                                paramTask.put("typ", "realchip");
                            } else {
                                return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                            }
                        }

                        //提交任务，获取返回的task_id
                        String s1 = qcodeTaskService.submitTask(paramTask);
                        JSONObject json = JSONObject.parseObject(s1);
                        if (json.size() == 0) {
                            logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                            return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                        }
                        //任务id
                        String taskId = (String) json.get(TASKID);
                        //任务状态
                        String tasksta = (String) json.get(TASKSTA);
                        //创建任务并存运行
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
                                String ans = (String) json.get(TASKRS);
                                qcodeTask.setEndTime(new Date());
                                if (ans != null && !("".equals(ans))) {
                                    //有结果且正确
                                    qcodeTask.setStatus(QcodeTask.STATUS_RESULT);
                                    qcodeTask.setAns(ans);
                                } else {
                                    //有结果为空，语法错误
                                    qcodeTask.setStatus(QcodeTask.STATUS_ERROR);
                                }

                                break;
                            default:
                                break;
                        }
                        if (qcodeProject.getQubitNum() > 20) {
                            qcodeTask.setMeaarr(meaarr);
                        } else {
                            qcodeTask.setRepeat(qcodeProject.getRepeat());
                        }
                        qcodeTask.setType((String) paramTask.get(TASK_TYP));
                        qcodeTask.setVersionId(vId);
                        qcodeTask.setTaskId(taskId);
                        qcodeTask.setStartTime(new Date());
                        qcodeTask.setClassicRegisterName("c");
                        qcodeTask.setIsDel(0);
                        Result result = qcodeTaskService.save(qcodeTask);
                        if (!result.isSuccess()) {
                            return new ResponseData(false, result.getErrormsg());
                        }
                        data.setObj(qcodeTask);
                        return data;
                    }
                }
            }
        }

    }

    /**
     * 获取任务状态
     */
    @RequestMapping(value = "QCode/getTaskRate.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData getTaskRate(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        ResponseData data = new ResponseData(true);
        if (qcodeUser == null) {
            //游客模式直接获取数据
            String taskId = request.getParameter(TASK_ID);
            QueryFilter filter = new QueryFilter();
            filter.put("id", taskId);
            QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
            data.setObj(qcodeTask);
            return data;
        } else {
            //获取当前任务
            String taskId = request.getParameter(TASK_ID);
            QueryFilter filter = new QueryFilter();
            filter.put(TASK_ID, taskId);
            QcodeTask qcodeTaskByTaskId = qcodeTaskService.findOne(filter).getReturnObj();
            //只查询等待和处理中的任务
            if (qcodeTaskByTaskId.getStatus().equals(QcodeTask.STATUS_WAITING) || qcodeTaskByTaskId.getStatus()
                    .equals(QcodeTask.STATUS_PROCESS)) {
                HashMap paramAns = new HashMap();

                paramAns.put(TASK_TYP, qcodeTaskByTaskId.getType());
                paramAns.put(IMP_TYP, "1");
                paramAns.put("typ", "qrytask");
                paramAns.put(TASKID, taskId);

                String s2 = qcodeTaskService.queryTask(paramAns);
                JSONObject json = JSONObject.parseObject(s2);
                if (json.size() == 0) {
                    logger.debug("查询任务方法queryTask,http请求无返回", taskId);
                    return new ResponseData(false, getMessage(SERVER_IS_BUSY));
                }
                //任务状态
                String tasksta = (String) json.get(TASKSTA);
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
                        String ans = (String) json.get(TASKRS);
                        qcodeTaskByTaskId.setEndTime(new Date());
                        if (ans != null && !("".equals(ans))) {
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
                    return new ResponseData(false, result.getErrormsg());
                }
            }

            data.setObj(qcodeTaskByTaskId);
            return data;
        }
    }


    /**
     * 获取版本
     */
    @RequestMapping(value = "QCode/getVersion.json")
    @ResponseBody
    public ResponseData getVersion(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter(request);
        QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
        if (qcodeProjectVersion == null) {
            return new ResponseData(false, getMessage(VERSION_DOES_NOT_EXIST));
        }

        ResponseData responseData = new ResponseData(true);
        responseData.setObj(qcodeProjectVersion);

        return responseData;
    }


    /**
     * 删除版本
     */
    @RequestMapping(value = "QCode/delVersion.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData delVersion(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter(request);
        QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
        if (qcodeProjectVersion == null) {
            return new ResponseData(false, getMessage(VERSION_DOES_NOT_EXIST));
        }
        //删除项目最后一个版本是删除项目
        filter = new QueryFilter();
        filter.put(PROJECT_ID, qcodeProjectVersion.getProjectId());
        filter.put(IS_DEL, 0);
        List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
        if (versionList.size() == 1) {
            filter = new QueryFilter();
            filter.put("id", qcodeProjectVersion.getProjectId());
            QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            qcodeProject.setIsDel(1);
            Result re = qcodeProjectService.update(qcodeProject);
            if (!re.isSuccess()) {
                return new ResponseData(false, re.getErrormsg());
            }
        }

        filter = new QueryFilter();
        filter.put(IS_DEL, 1);
        filter.put(PROJECT_ID, qcodeProjectVersion.getId());
        Result result1 = qcodeTaskService.update(filter);
        if (!result1.isSuccess()) {
            return new ResponseData(false, result1.getErrormsg());
        }
        qcodeProjectVersion.setIsDel(1);
        Result result2 = qcodeProjectVersionService.update(qcodeProjectVersion);
        if (!result2.isSuccess()) {
            return new ResponseData(false, result2.getErrormsg());
        }

        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 删除任务
     */
    @RequestMapping(value = "QCode/delTask.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData delTask(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter(request);
        QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
        if (qcodeTask == null) {
            return new ResponseData(false, getMessage(TASK_DOES_NOT_EXIST));
        }
        qcodeTask.setIsDel(1);
        Result result = qcodeTaskService.update(qcodeTask);
        if (!result.isSuccess()) {
            return new ResponseData(false, result.getErrormsg());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 终止任务
     */
    @RequestMapping(value = "QCode/terminateTask.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData terminateTask(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter(request);
        QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
        if (qcodeTask == null) {
            return new ResponseData(false, getMessage(TASK_DOES_NOT_EXIST));
        }
        //调用终止任务借口
        HashMap paramAns = new HashMap();
        paramAns.put(IMP_TYP, "2");
        paramAns.put(TASK_TYP, qcodeTask.getType());
        paramAns.put("typ", "updtask");
        paramAns.put(TASKID, qcodeTask.getTaskId());
        //中断任务操作
        qcodeTaskService.terminateTask(paramAns);
        qcodeTask.setStatus(QcodeTask.STATUS_END);
        qcodeTask.setEndTime(new Date());
        Result result = qcodeTaskService.update(qcodeTask);
        if (!result.isSuccess()) {
            return new ResponseData(false, result.getErrormsg());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 删除项目
     */
    @RequestMapping(value = "QCode/delProject.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData delProject(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if (qcodeUser == null) {
            return new ResponseData(false, getMessage(USER_NOT_LOGGED_IN));
        }
        QueryFilter filter = new QueryFilter(request);
        QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
        if (qcodeProject == null) {
            return new ResponseData(false, getMessage(TASK_DOES_NOT_EXIST));
        }
        qcodeProject.setIsDel(1);
        Result result = qcodeProjectService.update(qcodeProject);
        if (!result.isSuccess()) {
            return new ResponseData(false, result.getErrormsg());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 用户留言功能
     */
    @RequestMapping(value = "QCode/userMsg.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData userMsg(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        String randomString = (String) request.getSession().getAttribute("validateCode");
        String code = request.getParameter("code");
        if (!randomString.toLowerCase().equals(code.toLowerCase())) {
            return new ResponseData(false, getMessage("check_verification_code"));
        }
        String userMsg = request.getParameter("userMsg");
        String title = request.getParameter("title");

        QcodeMessage qcodeMessage = new QcodeMessage();
        if (qcodeUser != null) { //登陆用户留言
            qcodeMessage.setUserId(qcodeUser.getId());
        }
        qcodeMessage.setTitle(title);
        qcodeMessage.setContent(userMsg);
        qcodeMessage.setCreateTime(new Date());
        try {
            qcodeMessageService.save(qcodeMessage);//留言存到数据库
            templateEmail.sendTemplateMail(qcodeUser, userMsg, title);
        } catch (MessagingException | IOException | TemplateException e) {
            logger.error(getMessage("user_message_failed"));
            e.printStackTrace();
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 欢迎来到量子的世界页面获取
     */
    @RequestMapping(value = "QCode/brief/welcome.html")
    public String welcome() {
        return "quantumCloud/welcome";
    }

    /**
     * 量子世界页面获取
     */
    @RequestMapping(value = "QCode/brief/world.html")
    public String world() {
        return "quantumCloud/world";
    }

    /**
     * 量子力学页面获取
     */
    @RequestMapping(value = "QCode/brief/mechanics.html")
    public String mechanics() {
        return "quantumCloud/mechanics";
    }

    /**
     * 量子计算原理页面获取
     */
    @RequestMapping(value = "QCode/brief/theory.html")
    public String theory() {
        return "quantumCloud/theory";
    }

    /**
     * 量子算法页面获取
     */
    @RequestMapping(value = "QCode/brief/algorithm.html")
    public String algorithm() {
        return "quantumCloud/algorithm";
    }

    /**
     * 问题页面获取
     */
    @RequestMapping(value = "QCode/question.html")
    public String question() {
        return "quantumCloud/question";
    }

    /**
     * 用户申请页面获取
     */
    @RequestMapping(value = "QCode/userApplication.html")
    public String userApplication() {
        return "quantumCloud/userApplication";
    }

    /**
     * 用户信息页面
     */
    @RequestMapping(value = "QCode/userInfo.html")
    public String userInfo(ModelMap model, HttpServletRequest request) {
        String encryptStr = request.getParameter("s");
        QcodeUser userInfo = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter();
        filter.put("id", userInfo.getId());
        userInfo = qcodeUserService.findOne(filter).getReturnObj();
        model.put("userInfo", userInfo);
        //判断是否从邮件过来
        if (encryptStr == null || "".equals(encryptStr)) {
            model.put("isEmail", "false");
        } else {
            try {
                String str = DecodeUtil.decrypt(encryptStr);
                if (str != null && !"".equals(str)) {
                    String[] strs = str.split(",");
                    if (strs.length >= 2) {
                        model.put("emailStr", strs[0]);
                        model.put("createTimeStr", strs[1]);
                        model.put("isEmail", "true");
                    } else {
                        model.put("isEmail", "false");
                    }
                } else {
                    model.put("isEmail", "false");
                }
            } catch (Exception e) {
                model.put("isEmail", "false");
            }
        }
        return "quantumCloud/userInfo";
    }

    /**
     * 修改用户信息
     */
    @RequestMapping(value = "QCode/updUserInfo.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData updUserInfo(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser userInfo = AppContextHolder.getCurrentUser();
        if (userInfo != null) {
            QcodeUser qcodeUser = new QcodeUser();
            qcodeUser.setId(userInfo.getId());
            qcodeUser.setName(request.getParameter("name"));
            qcodeUser.setOrgName(request.getParameter("orgName"));
            qcodeUserService.update(qcodeUser);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }

    /**
     * 保存用户申请
     */
    @RequestMapping(value = "QCode/userApplicationSave.json", method = RequestMethod.POST)
    @ResponseBody
    public ResponseData saveUserApplication(@ModelAttribute("entity") QcodeUserApplication entity) {
        try {
            //获取当前登陆用户
            QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
            entity.setStatus(QcodeUserApplication.STATUS_WAITING);
            entity.setCreateTime(new Date());
            entity.setUserId(qcodeUser != null ? qcodeUser.getId() : null);
            Result result = qcodeUserApplicationService.save(entity);
            if (!result.isSuccess()) {
                return new ResponseData(false, result.getErrormsg());
            }
        } catch (DuplicateKeyException e) {
            Result result = new Result();
            if (e.getRootCause().getMessage().toUpperCase().contains(PRIMARY)) {
                result.addErrormsg("id  重复");
            }
            return new ResponseData(false, result.getErrormsg());
        } catch (Exception e) {
            return new ResponseData(false, e.getMessage());
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 项目详情页面
     */
    @RequestMapping(value = "QCode/projectShow.html")
    public String projectShow(ModelMap model, HttpServletRequest request) {

        String tokenStr = request.getParameter(TOKEN);
        if (tokenStr == null || "".equals(tokenStr)) {
            return COMMON_INVALID_PAGE;
        }

        String[] usernamepassword = DecodeUtil.decrypt(tokenStr).split(",");
        if (usernamepassword.length != 2) {
            return COMMON_INVALID_PAGE;
        }

        String username = usernamepassword[0];
        String password = usernamepassword[1];

        //根据登录名查询用户
        QueryFilter filter = new QueryFilter();
        filter.put("username", username);
        filter.put("status", 1);
        SysUser sysUser = sysUserService.findOne(filter).getReturnObj();

        if (sysUser == null || !StringUtils.equals(password, sysUser.getPassword())) {
            return COMMON_INVALID_PAGE;
        }

        filter.clear();
        String projectId = request.getParameter(PROJECT_ID);
        //存在项目id时查询项目相关信息并返回
        if (!(projectId == null || "".equals(projectId))) {
            //查询项目
            filter.put("id", projectId);
            QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            if (qcodeProject != null) {
                //查询项目最新版本及task
                filter = new QueryFilter();
                filter.put(PROJECT_ID, projectId);
                filter.put(ORDER, CREATE_TIME_DESC);
                List<QcodeProjectVersion> versionList = qcodeProjectVersionService.findList(filter).getReturnObj();
                if (versionList.size() > 0) {
                    versionList.get(0)
                            .setSvgXml(versionList.get(0).getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
                    model.put(CURRENT_VERSION, versionList.get(0));
                    List<Map> versionMapList = new ArrayList<Map>();
                    model.put(PROJECT_VERSION, versionList.get(0));
                    for (int i = 0; i < versionList.size(); i++) {
                        //查询当前版本的所有task
                        QcodeProjectVersion version = versionList.get(i);
                        Map map = new HashMap();
                        map.put(VERSION, version);
                        filter = new QueryFilter();
                        filter.put(VERSION_ID, version.getId());
                        filter.put(IS_DEL, 0);
                        List<QcodeTask> taskList = qcodeTaskService.findList(filter).getReturnObj();
                        map.put(TASK_LIST, taskList);
                        versionMapList.add(map);
                    }
                    model.put(VERSION_MAP_LIST, versionMapList);
                }

                model.put(QCODE_PROJECT, qcodeProject);
            }
        }
        model.put(FROM_ADMIN, 1);

        return "quantumCloud/projectShow";
    }

    /**
     * 任务详情页面
     */
    @RequestMapping(value = "QCode/taskShow.html")
    public String taskShow(ModelMap model, HttpServletRequest request) {

        String tokenStr = request.getParameter(TOKEN);
        if (tokenStr == null || "".equals(tokenStr)) {
            return COMMON_INVALID_PAGE;
        }

        String[] usernamepassword = DecodeUtil.decrypt(tokenStr).split(",");
        if (usernamepassword.length != 2) {
            return COMMON_INVALID_PAGE;
        }

        String username = usernamepassword[0];
        String password = usernamepassword[1];

        //根据登录名查询用户
        QueryFilter filter = new QueryFilter();
        filter.put("username", username);
        filter.put("status", 1);
        SysUser sysUser = sysUserService.findOne(filter).getReturnObj();

        if (sysUser == null || !StringUtils.equals(password, sysUser.getPassword())) {
            return COMMON_INVALID_PAGE;
        }

        filter.clear();
        String taskId = request.getParameter(TASK_ID);
        //存在项目id时查询项目相关信息并返回
        if (!(taskId == null || "".equals(taskId))) {
            //查询任务
            filter.put("id", taskId);
            QcodeTask qcodeTask = qcodeTaskService.findOne(filter).getReturnObj();
            filter.clear();
            filter.put("id", qcodeTask.getVersionId());
            //查询任务对应版本
            QcodeProjectVersion version = qcodeProjectVersionService.findOne(filter).getReturnObj();
            version.setSvgXml(version.getSvgXml().replaceAll("ns.:", "").replaceAll("NS.:", ""));
            //查询任务对应项目
            filter.clear();
            filter.put("id", version.getProjectId());
            QcodeProject qcodeProject = qcodeProjectService.findOne(filter).getReturnObj();
            model.put("task", qcodeTask);
            model.put(PROJECT_VERSION, version);
            model.put(QCODE_PROJECT, qcodeProject);
        }
        model.put(FROM_ADMIN, 1);
        return "quantumCloud/taskShow";
    }

    /**
     * 项目详情获取版本
     */
    @RequestMapping(value = "QCode/showVersion.json")
    @ResponseBody
    public ResponseData showVersion(HttpServletRequest request, HttpServletResponse response) {
        QueryFilter filter = new QueryFilter(request);
        QcodeProjectVersion qcodeProjectVersion = qcodeProjectVersionService.findOne(filter).getReturnObj();
        if (qcodeProjectVersion == null) {
            return new ResponseData(false, getMessage(VERSION_DOES_NOT_EXIST));
        }

        ResponseData responseData = new ResponseData(true);
        responseData.setObj(qcodeProjectVersion);

        return responseData;
    }


    /**
     * 创建API KEY
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "QCode/createKey.json")
    @ResponseBody
    public ResponseData createKey(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        QcodeUser user = AppContextHolder.getCurrentUser();
        String isRepeat = request.getParameter("isRepeat");//是否重新生成 ：0：否、1：是
        if (user != null) {
            if (user.getApiKey() != null && !"".equals(user.getApiKey()) && !"1".equals(isRepeat)) {
                data.setObj(user.getApiKey());
            } else {
                String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
                user.setApiKey(apiKey);
                Result result = qcodeUserService.update(user);
                if (result.isSuccess()) {
                    data.setObj(apiKey);
                } else {
                    data.setSuccess(false);
                }
            }
        } else {
            data.setSuccess(false);
        }
        return data;
    }



    /**------------------------------以下为提供外部接口：下发任务，查询任务，终止任务----------------------------------*/
    /**
     * 下发任务
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "api/QCode/submitTask.json")
    @ResponseBody
    public ResponseData submitTask(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //获取用户token
            String token = map.get(TOKEN) == null ? null : map.get(TOKEN).toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage(getMessage(KEY_IS_NOT_NULL));
                return data;
            }

            //根据API KEY验证用户是否存在
            QueryFilter filter = new QueryFilter();
            filter.put(API_KEY, token);
            QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
            if (user == null || user.getApiKey() == null || "".equals(user.getApiKey())) {
                    data.setSuccess(false);
                data.setMessage(getMessage(KEY_DOES_NOT_EXIST));
                return data;
            }

            //获取任务类型
            String taskTyp = map.get(TASK_TYP) == null ? null : map.get(TASK_TYP).toString();
            if (taskTyp == null || "".equals(taskTyp)) {
                data.setSuccess(false);
                data.setMessage(getMessage("lack_of_task_type"));
                return data;
            }

            HashMap paramTask = new HashMap();
            //根据不同任务类型 处理不同参数
            if ("4".equals(taskTyp)) {
                if ((map.get(QPROG) == null) || "".equals(map.get(QPROG)) || map.get(MEAARR) == null || ""
                        .equals(map.get(MEAARR)) || map.get("qbit") == null || "".equals(map.get("qbit"))) {
                    data.setSuccess(false);
                    data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                    return data;
                }
                //判断用户等级是否可以执行当前任务
                Integer qbit = Integer.parseInt(map.get("qbit").toString());
                if (qbit.intValue() > 20 && user.getLevel().intValue() < QcodeUser.QCODEUSER_LEVEL_2) {
                    data.setSuccess(false);
                    data.setMessage(getMessage("unauthorized_to_operate"));
                    return data;
                }

                //设置参数
                paramTask.put(TASK_TYP, "4");
                paramTask.put(QPROG, map.get(QPROG));
                paramTask.put(MEAARR, map.get(MEAARR));
                paramTask.put("qbit", qbit);
                paramTask.put("typ", MIDPR);
            } else if ("2".equals(taskTyp)) {
                if (map.get(QPROG) == null || "".equals(map.get(QPROG)) || map.get(REPEAT) == null || ""
                        .equals(map.get(REPEAT))) {
                    data.setSuccess(false);
                    data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                    return data;
                }
                //设置参数
                paramTask.put(TASK_TYP, "2");
                paramTask.put(QPROG, map.get(QPROG));
                paramTask.put(REPEAT, map.get(REPEAT));
                paramTask.put("typ", "mcpr");
            } else if ("3".equals(taskTyp)) {
                if ((map.get(QPROG) == null || "".equals(map.get(QPROG))) || (map.get(MEAARR) == null || ""
                        .equals(map.get(MEAARR)))) {
                    data.setSuccess(false);
                    data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                    return data;
                }
                //设置参数
                paramTask.put(TASK_TYP, "3");
                paramTask.put(QPROG, map.get(QPROG));
                paramTask.put(MEAARR, map.get(MEAARR));
                paramTask.put("typ", SMAPR);
            }
            //运行任务
            String s1 = qcodeTaskService.submitTask(paramTask);
            JSONObject json = JSONObject.parseObject(s1);
            if (json.size() == 0) {
                logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                return new ResponseData(false, getMessage(SERVER_IS_BUSY));
            } else if (json.get(SUCCESS) != null && (!Boolean
                    .valueOf((String) json.get(SUCCESS)))) { //查询任务方法terminateTaskApi返回结果为失败
                return new ResponseData(false, json.get(MESSAGE));
            }
            data.setSuccess(true);
            data.setObj(json);
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/submitTask.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage(PROGRAM_EXCEPTION));
            return data;
        }
    }


    /**
     * 查询任务
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "api/QCode/queryTask.json")
    @ResponseBody
    public ResponseData queryTask(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //获取用户token
            String token = map.get(TOKEN) == null ? null : map.get(TOKEN).toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage(getMessage(KEY_IS_NOT_NULL));
                return data;
            }

            //根据API KEY验证用户是否存在
            QueryFilter filter = new QueryFilter();
            filter.put(API_KEY, token);
            QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
            if (user == null || user.getApiKey() == null || "".equals(user.getApiKey())) {
                data.setSuccess(false);
                data.setMessage(getMessage(KEY_DOES_NOT_EXIST));
                return data;
            }

            //获取任务类型
            String taskTyp = map.get(TASK_TYP) == null ? null : map.get(TASK_TYP).toString();
            String taskId = map.get(TASKID) == null ? null : map.get(TASKID).toString();
            if (taskTyp == null || "".equals(taskTyp) || taskId == null || "".equals(taskId)) {
                data.setSuccess(false);
                data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //运行任务
            HashMap paramAns = new HashMap();
            paramAns.put(TASK_TYP, taskTyp);
            paramAns.put(IMP_TYP, "1");
            paramAns.put("typ", "qrytask");
            paramAns.put(TASKID, taskId);

            String s1 = qcodeTaskService.queryTask(paramAns);
            JSONObject json = JSONObject.parseObject(s1);
            if (json.size() == 0) {
                logger.debug("查询任务方法queryTask,http请求无返回", taskId);
                return new ResponseData(false, getMessage(SERVER_IS_BUSY));
            } else if (json.get(SUCCESS) != null && (!Boolean
                    .valueOf((String) json.get(SUCCESS)))) { //查询任务方法queryTask返回结果为失败
                return new ResponseData(false, json.get(MESSAGE));
            }
            data.setSuccess(true);
            data.setObj(json);
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/queryTask.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage(PROGRAM_EXCEPTION));
            return data;
        }
    }


    /**
     * 终止任务
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "api/QCode/terminateTask.json")
    @ResponseBody
    public ResponseData terminateTaskApi(HttpServletRequest request, HttpServletResponse response) {
        ResponseData data = new ResponseData(true);
        try {
            response.setHeader("Access-Control-Allow-Origin", "*");
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //获取用户token
            String token = map.get(TOKEN) == null ? null : map.get(TOKEN).toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage(getMessage(KEY_IS_NOT_NULL));
                return data;
            }

            //根据API KEY验证用户是否存在
            QueryFilter filter = new QueryFilter();
            filter.put(API_KEY, token);
            QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
            if (user == null || user.getApiKey() == null || "".equals(user.getApiKey())) {
                data.setSuccess(false);
                data.setMessage(getMessage(KEY_DOES_NOT_EXIST));
                return data;
            }

            //获取任务类型
            String taskTyp = map.get(TASK_TYP) == null ? null : map.get(TASK_TYP).toString();
            String taskId = map.get(TASKID) == null ? null : map.get(TASKID).toString();
            if (taskTyp == null || "".equals(taskTyp) || taskId == null || "".equals(taskId)) {
                data.setSuccess(false);
                data.setMessage(getMessage(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //运行任务
            HashMap paramAns = new HashMap();
            paramAns.put(TASK_TYP, taskTyp);
            paramAns.put(IMP_TYP, "2");
            paramAns.put("typ", "updtask");
            paramAns.put(TASKID, taskId);

            String s1 = qcodeTaskService.terminateTask(paramAns);
            JSONObject json = JSONObject.parseObject(s1);
            if (json.size() == 0) {
                logger.debug("查询任务方法terminateTaskApi,http请求无返回", taskId);
                return new ResponseData(false, getMessage(SERVER_IS_BUSY));
            } else if (json.get(SUCCESS) != null && (!Boolean
                    .valueOf((String) json.get(SUCCESS)))) { //查询任务方法terminateTaskApi返回结果为失败
                return new ResponseData(false, json.get(MESSAGE));
            }
            data.setSuccess(true);
            data.setObj(json);
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/terminateTaskApi.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessage(PROGRAM_EXCEPTION));
            return data;
        }
    }


    /**
     * 获取http请求参数
     *
     * @since 2018-1-9
     */
    private Map getParams(HttpServletRequest request) throws Exception {
        Enumeration<String> parameterNames = request.getParameterNames();
        Map map = null;
        if (parameterNames.hasMoreElements()) {//Content-Type:application/x-www-form-urlencoded
            map = new HashMap<String, Object>();
            while (parameterNames.hasMoreElements()) {
                String parameterName = (String) parameterNames.nextElement();
                map.put(parameterName, request.getParameter(parameterName));
            }
            return map;
        }

        StringBuilder sb = new StringBuilder();// 非Content-Type:application/x-www-form-urlencoded的处理
        InputStream is = getRequest().getInputStream();
        BufferedInputStream bis = new BufferedInputStream(is);
        byte[] buffer = new byte[1024];
        int read = 0;
        while ((read = bis.read(buffer)) != -1) {
            sb.append(new String(buffer, 0, read, "UTF-8"));
        }

        if (sb != null && !"".equals(sb + "")) {
            try {
                map = JSONObject.parseObject(sb.toString(), Map.class);
            } catch (com.alibaba.fastjson.JSONException e) { //在异常中对taskTyp=xxx&qprog=xxxx&typ=xxx&repeat=xxx&token=xxxx这种数据的处理
                String sbStr = URLDecoder.decode(sb.toString());
                StringBuffer sbStringBuffer = new StringBuffer();
                sbStringBuffer.append("{\"")
                        .append(sbStr.toString().trim().replaceAll("&", "\",\"").replaceAll("=", "\":\""))
                        .append("\"}");
                map = JSONObject.parseObject(sbStringBuffer.toString(), Map.class);
            }
        }
        return map;
    }


    /**
     * 接口测试
     * @param request
     * @param response
     * @return
     * @2017-7-22下午2:56:13
     * @JT
     */
       /* @RequestMapping(value = "QCode/test.json")
        @ResponseBody
        public ResponseData test( HttpServletRequest request, HttpServletResponse response) {
        		ResponseData data = new ResponseData(true);
        		*//*HashMap paramMap = new HashMap();
                  HashMap param = new HashMap();
              	paramMap.put("user_id",105);
              	paramMap.put("user_type_id",2);
              	paramMap.put("task_type_id",1);
            	paramMap.put("repeat",6);
            	paramMap.put("code","Version 0.1\nQInit 2: '10'\nCReg c[1]\n// This is a Demonstration of Two Qubit D-J Algorithm\nH 0\nH 1\nCNOT 0,1\nH 0\nMeasure 0,c[0]\n");
            	param.put("task_id", 106);
            	String s1 = qcodeTaskService.submitTask(paramMap);
            	String s2 = qcodeTaskService.queryTask(param);
            	data.setObj(s2);*//*

    			HashMap paramAns = new HashMap();
        		paramAns.put("taskTyp","4"); //2.4	21-30 位模拟概率方法
        		paramAns.put("qprog","QINIT16 CREG10 NOT0 H15 H14 H10 CR15,9,64 CR14,9,32 MEASURE15,$9");
        		paramAns.put("meaarr","{1,14}");
        		paramAns.put("qbit",30);
        		paramAns.put("typ","midpr");
        		paramAns.put("token","8B73D83CD59C4A58AAE95FA1EF87006C");
        		String r1 = qcodeTaskService.test("http://192.168.1.104:4630/api/QCode/submitTask.json", paramAns);
        		System.err.println("r1:"+r1);

        		paramAns = new HashMap();
        		paramAns.put("taskTyp","2");//2.2	模拟Monte-Carlo方法。
        		paramAns.put("qprog","QINIT16 CREG10 NOT0 H15 H14 H10 CR15,9,64 CR14,9,32 MEASURE15,$9");
        		paramAns.put("repeat","3");
        		paramAns.put("typ","mcpr");
        		paramAns.put("token","8B73D83CD59C4A58AAE95FA1EF87006C");
        		String rs1 = qcodeTaskService.test("http://192.168.1.104:4630/api/QCode/submitTask.json", paramAns);
        		System.err.println("rs1:"+rs1);

        		paramAns = new HashMap();
        		paramAns.put("taskTyp","3");//2.3	1-20 位模拟概率方法。
        		paramAns.put("qprog","QINIT16 CREG10 NOT0 H15 H14 H10 CR15,9,64 CR14,9,32 MEASURE15,$9");
        		paramAns.put("meaarr","{1,10}");
        		paramAns.put("typ","smapr");
        		paramAns.put("token","8B73D83CD59C4A58AAE95FA1EF87006C");
        		String rs2 = qcodeTaskService.test("http://192.168.1.104:4630/api/QCode/submitTask.json", paramAns);
        		System.err.println("rs2:"+rs2);

        		paramAns = new HashMap();
            	paramAns.put("taskTyp", 2);//4.1	任务查询接口
            	paramAns.put("impTyp", "1");
            	paramAns.put("typ", "qrytask");
            	paramAns.put("taskid", "1801091403335819");
        		paramAns.put("token","8B73D83CD59C4A58AAE95FA1EF87006C");
        		String r2 = qcodeTaskService.test("http://192.168.1.104:4630/api/QCode/queryTask.json", paramAns);
        		System.err.println("r2:"+r2);

        		paramAns = new HashMap();//4.2	任务中断接口
        		paramAns.put("taskTyp", "2");
            	paramAns.put("impTyp", "2");
            	paramAns.put("typ", "updtask");
            	paramAns.put("taskid", "1801111341233553");
        		paramAns.put("token","8B73D83CD59C4A58AAE95FA1EF87006C");
        		String r3 = qcodeTaskService.test("http://192.168.1.104:4630/api/QCode/terminateTask.json", paramAns);
        		System.err.println("r3:"+r3);
            	return data;
        }*/

    /**
     * 半导体计算机页面获取
     */
    @RequestMapping(value = "QCode/semiQuantumComputer.html")
    public String semiQuantumComputer() {
        return "quantumCloud/semiQuantumComputer";
    }

    /**
     * 超导计算机页面获取
     */
    @RequestMapping(value = "QCode/superQuantumComputer.html")
    public String superQuantumComputer() {
        return "quantumCloud/superQuantumComputer";
    }

    /**
     * 敬请期待页面获取
     */
    @RequestMapping(value = "QCode/commingSoon.html")
    public String commingSoon() {
        return "quantumCloud/commingSoon";
    }

    /**
     * 虚拟机申请页面
     */
    @RequestMapping(value = "QCode/apply.html")
    public String apply(ModelMap model) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(qcodeUser != null) {
            QueryFilter filter = new QueryFilter();
            filter.put(USER_ID, qcodeUser.getId());
            filter.put("applyStatus", "1");
            QcodeApply qcodeApply = qcodeApplyService.findOne(filter).getReturnObj();//申请存到数据库
            if (null == qcodeApply) {
                model.put("isApply", "0");
            } else {
                model.put("isApply", "1");
            }
            return "quantumCloud/apply";
        }else {
            return "quantumCloud/apply";
        }
    }


    /**
     * 用户申请虚拟机功能
     */
    @RequestMapping(value = "QCode/userApply.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData userApply(HttpServletRequest request) {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        String randomString = (String) request.getSession().getAttribute("validateCode");
        String code = request.getParameter("code");
        if (!randomString.toLowerCase().equals(code.toLowerCase())) {
            return new ResponseData(false, getMessage("check_verification_code"));
        }
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String vmType = request.getParameter("vmType");
        String purpose = request.getParameter("purpose");
        String applyStatus = "1";

        QcodeApply qcodeApply = new QcodeApply();
        if (qcodeUser != null) { //登陆用户申请
            qcodeApply.setUserId(qcodeUser.getId());
            qcodeApply.setUserName(qcodeUser.getName());
            qcodeApply.setUserEmail(qcodeUser.getEmail());
        }
        qcodeApply.setName(name);
        qcodeApply.setPhone(phone);
        qcodeApply.setEmail(email);
        qcodeApply.setVmType(vmType);
        qcodeApply.setPurpose(purpose);
        qcodeApply.setApplyStatus(applyStatus);
        try {
            //申请存到数据库
            qcodeApplyService.save(qcodeApply);
            //申请邮件
            templateEmail.sendApplyMail(qcodeApply);
            //回复邮件
            templateEmail.rePlyApplyMail2(qcodeApply, request);
        } catch (Exception e) {
            logger.error(getMessage("user_message_failed"));
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 获取新老用户
     */
    @RequestMapping(value = "QCode/getUserStatus.json")
    @ResponseBody
    public ResponseData getUserStatus() {
        //获取当前登陆用户
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        //判断是否为老用户(0、否，1、是)  从数据库中查取isOldUser
        String isOldUser = null;
        if (null != qcodeUser) {
            QueryFilter nameFilter = new QueryFilter();
            nameFilter.put("userName", qcodeUser.getEmail());
            QcodeUser qcodeUserNew = qcodeUserService.findOne(nameFilter).getReturnObj();
            isOldUser = qcodeUserNew.getIsOldUser();

        } else {
            isOldUser = "2";
        }
        return new ResponseData(true, isOldUser);//游客
    }

    /**
     * 更改用户为老用户
     */
    @RequestMapping(value = "QCode/updUser.json")
    @ResponseBody
    @Transactional(propagation = Propagation.REQUIRED)
    public ResponseData updUser() {
        //获取当前登陆用户
        QcodeUser userInfor = AppContextHolder.getCurrentUser();
        QcodeUser qcodeUser = new QcodeUser();
        qcodeUser.setId(userInfor.getId());
        qcodeUser.setIsOldUser("1");//1代表老用户
        //更改用户为老用户状态
        qcodeUserService.update(qcodeUser);
        return ResponseData.SUCCESS_NO_DATA;
    }

    public static void main(String[] args) {
        String str = "{\"index\": 0,\"gateNum\": 7,\"gate\": [{\"type\": \"X1\",\"qBit1\": 0,\"position\":\"0,0\"},"
                + "{\"type\": \"Y1\",\"qBit1\": 1,\"position\":\"1,0\"},{\"type\": \"iSWAP\",\"qBit1\": 0,\"qBit2\": 1,\"position\":\"0,2\"},"
                + "{\"type\": \"X2\",\"qBit1\": 0,\"position\":\"0,3\"},{\"type\": \"Y2\",\"qBit1\": 1,\"position\":\"1,2\"},"
                + "{\"type\": \"X3\",\"qBit1\": 0,\"qBit2\": 1,\"position\":\"0,5\"},{\"type\": \"Y3\",\"qBit1\": 0,\"qBit2\": 1,\"position\":\"0,6\"}]}";
        JSONObject jsonObject = JSONObject.parseObject(str);
        jsonObject.put("error", "错误信息");
        System.out.println(jsonObject);
    }



    /**
     * 下发任务
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "api/QCode/QRunes2/submitTask.json")
    @ResponseBody
    public ResponseData submitTask1(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //获取用户token
            String token = map.get(TOKEN) == null ? null : map.get(TOKEN).toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(KEY_IS_NOT_NULL));
                return data;
            }

            //根据API KEY验证用户是否存在
            QueryFilter filter = new QueryFilter();
            filter.put(API_KEY, token);
            QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
            if (user == null || user.getApiKey() == null || "".equals(user.getApiKey())) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(KEY_DOES_NOT_EXIST));
                return data;
            }

            //获取任务类型
            String taskType = map.get(TASK_TYPE) == null ? null : map.get(TASK_TYPE).toString();
            if (taskType == null || "".equals(taskType)) {
                data.setSuccess(false);
                data.setMessage(getMessageUs("lack_of_task_type"));
                return data;
            }

            HashMap paramTask = new HashMap();
                //设置参数
//            paramTask.put(TASK_TYPE, map.get(taskType)); 感觉这一句是错的
            paramTask.put(TASK_TYPE, taskType);
            paramTask.put(QPROG_QRUNES2, map.get(QPROG_QRUNES2));
            paramTask.put("RepeatNum", map.get("RepeatNum") == null?"":map.get("RepeatNum").toString());
            paramTask.put("typ", map.get("typ").toString());
            paramTask.put("TaskState",map.get("TaskState"));
            paramTask.put("BackendType",map.get("BackendType").toString());
            paramTask.put("Qubits",map.get("Qubits") == null?"":map.get("Qubits").toString());
            paramTask.put("taskResult",map.get("TaskResult"));
            paramTask.put("errorMsg",map.get("ErrorMsg"));
            //运行任务
            String s1 = qcodeTaskService.submitTaskNew(paramTask);
            JSONObject json = JSONObject.parseObject(s1);
            if (json.size() == 0) {
                logger.debug(SUBMIT_TASK_HTTP_NULL, paramTask);
                return new ResponseData(false, getMessageUs(SERVER_IS_BUSY));
            } else if (json.get(SUCCESS) != null && (!Boolean
                    .valueOf((String) json.get(SUCCESS)))) { //查询任务方法terminateTaskApi返回结果为失败
                return new ResponseData(false, json.get(MESSAGE));
            }
            data.setSuccess(true);
            data.setObj(json);
            return data;
        } catch (Exception e) {
            logger.error("api/QCode/QRunes2/submitTask.json  data unnormal" + e);
            data.setSuccess(false);
            data.setMessage(getMessageUs(PROGRAM_EXCEPTION));
            return data;
        }
    }


    /**
     * 查询任务
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "api/QCode/QRunes2/queryTask.json")
    @ResponseBody
    public ResponseData queryTaskNew(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        try {
            Map map = getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //获取用户token
            String token = map.get(TOKEN) == null ? null : map.get(TOKEN).toString();
            if (token == null || "".equals(token)) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(KEY_IS_NOT_NULL));
                return data;
            }

            //根据API KEY验证用户是否存在
            QueryFilter filter = new QueryFilter();
            filter.put(API_KEY, token);
            QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
            if (user == null || user.getApiKey() == null || "".equals(user.getApiKey())) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(KEY_DOES_NOT_EXIST));
                return data;
            }

            //获取任务类型
            String taskTyp = map.get(TASK_TYPE) == null ? null : map.get(TASK_TYPE).toString();
            String taskId = map.get(TASKID) == null ? null : map.get(TASKID).toString();
            if (taskTyp == null || "".equals(taskTyp) || taskId == null || "".equals(taskId)) {
                data.setSuccess(false);
                data.setMessage(getMessageUs(LACK_OF_NECESSARY_PARAMETERS));
                return data;
            }

            //运行任务
            HashMap paramAns = new HashMap();
            paramAns.put(TASK_TYPE, taskTyp);
            paramAns.put(IMP_TYP, "1");
            paramAns.put("typ", "qrytask");
            paramAns.put(TASKID, taskId);

            String s1 = qcodeTaskService.queryTaskNew(paramAns);
            JSONObject json = JSONObject.parseObject(s1);
            if (json.size() == 0) {
                logger.debug("查询任务方法queryTask,http请求无返回", taskId);
                return new ResponseData(false, getMessageUs(SERVER_IS_BUSY));
            } else if (json.get(SUCCESS) != null && (!Boolean
                    .valueOf((String) json.get(SUCCESS)))) { //查询任务方法queryTask返回结果为失败
                return new ResponseData(false, json.get(MESSAGE));
            }
            data.setSuccess(true);
            data.setObj(json);
            return data;
        } catch (Exception e) {
            logger.error("接口（api/QCode/QRunes2/queryTask.json）数据异常:" + e);
            data.setSuccess(false);
            data.setMessage(getMessageUs(PROGRAM_EXCEPTION));
            return data;
        }
    }
}
