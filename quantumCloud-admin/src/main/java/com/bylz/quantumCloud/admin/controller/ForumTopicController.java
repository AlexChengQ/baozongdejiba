/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.RelationFileVo;
import com.likegene.framework.core.Pagination;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.model.ForumTopicVo;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.QueryFilter;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;

/**
 * 论坛主题Controller层
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月19日
 */
@Controller
@RequestMapping("/qcode/forumtopic")
public class ForumTopicController extends BaseController {

    public static final String FORUMTOPIC_COMMUNITY = "forumtopic/community";

    public static final String FORUMTOPIC_COMMUNITYDETAIL = "forumtopic/communityDetail";

    @Autowired
    public ForumTopicService forumTopicService;

    /**
     * 论坛主题页面
     */
    @RequestMapping(value = "/community.html")
    public String community(ModelMap model, HttpServletRequest request) {
        //获取当前登陆用户
        SysUser sysUser = AppContextHolder.getCurrentUser();
        if (sysUser != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.setStatementKey("selectAdminList");
            model.put("pager", forumTopicService.findPager(filter).getReturnObj());
        }
        return FORUMTOPIC_COMMUNITY;
    }

    /**
     * 获取论坛详情
     */
    @RequestMapping(value = "/forumtopicdetail.html")
    public String forumtopicdetail(ModelMap model, ForumTopicVo forumTopicParam) {
        //获取当前登陆用户
        SysUser sysUser = AppContextHolder.getCurrentUser();
        ForumTopicVo forumTopicVo;
        if (sysUser != null) {
            forumTopicVo = forumTopicService.forumTopicdetail(forumTopicParam);
        } else {
            forumTopicVo = new ForumTopicVo();
        }
        model.put("entity", forumTopicVo);
        return FORUMTOPIC_COMMUNITYDETAIL;
    }

    /**
     * 获取论坛回复详情集合
     */
    @RequestMapping(value = "/replyList.html")
    public String replyList(ModelMap model, HttpServletRequest request) {
        //获取当前登陆用户
        SysUser sysUser = AppContextHolder.getCurrentUser();
        if (sysUser != null) {
            QueryFilter filter = new QueryFilter(request);
            model.put("pager", forumTopicService.forumReplyList(filter));
            model.put("forumTopicId", filter.get("forumTopicId"));
        }


        return "forumtopic/replyList";
    }

    /**
     * 论坛主题审核
     */
    @RequestMapping(value = "/forumTopicAudit.json")
    @ResponseBody
    public ResponseData forumTopicAudit(ForumTopicVo forumTopicVo) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        if (sysUser != null) {
            //论坛主题审核
            forumTopicService.updTopicAudit(forumTopicVo);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }

    /**
     * 批量审核回复
     */
    @RequestMapping(value = "/replyAuditAll.json")
    @ResponseBody
    public ResponseData replyAuditAll(HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        if (sysUser != null) {
            QueryFilter filter = new QueryFilter(request);
            filter.put("replyIds", request.getParameter("ids").split(","));
            filter.setStatementKey("replyAuditAll");
            //批量审核回复
            forumTopicService.replyAuditAll(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }
        return ResponseData.FAILED_NO_DATA;
    }


    /**
     * 论坛主题批量审核
     */
    @RequestMapping(value = "/updTopicBatchAudit.json")
    @ResponseBody
    public ResponseData updTopicBatchAudit(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.put("ids", request.getParameter("ids").split(","));
            //批量审核主题
        try {
            forumTopicService.updTopicBatchAudit(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 批量删除回复
     */
    @RequestMapping(value = "/delBatchReply.json")
    @ResponseBody
    public ResponseData delBatchReply(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.put("replyIds", request.getParameter("ids").split(","));
        //批量审核回复
        try {
            forumTopicService.delBatchReply(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 批量删除论坛主题
     */
    @RequestMapping(value = "/delTopicBatchAudit.json")
    @ResponseBody
    public ResponseData delTopicBatchAudit(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.put("ids", request.getParameter("ids").split(","));
        //批量审核回复
        try {
            forumTopicService.delTopicBatchAudit(filter);
            return ResponseData.SUCCESS_NO_DATA;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            return ResponseData.FAILED_NO_DATA;
        }
    }

    /**
     * 查询反馈建议
     * @param model
     * @param request
     * @return
     */
    @RequestMapping(value = "/feedback.html")
    public String getFeedback(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",forumTopicService.getForumFeedBackList(filter));
        return "forumtopic/feedback";
    }

    /**
     * 反馈详情
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/feedbackDetail")
    public String getFeedbackDetails(Model model,String id) {
        QueryFilter filter = new QueryFilter();
        filter.put("id",id);
        model.addAttribute("feedbackDetail",forumTopicService.getFeedbackDetails(filter));
        return "forumtopic/feedbackDetail";
    }

    /**
     * 预览图片
     * @param response
     * @param fileID
     */
    @RequestMapping("/getFileById.json")
    public void getImage(HttpServletResponse response, String fileID) {
        QueryFilter filter = new QueryFilter();
        filter.put("id",fileID);
        try {
            RelationFileVo relationFileVo = forumTopicService.getFileById(filter);
            OutputStream os = response.getOutputStream();
            os.write(relationFileVo.getBt());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 查询所有版块
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/belonged.html")
    public String getAllBelonged(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",forumTopicService.getAllBelonged(filter));
        return "forumtopic/moderator";
    }

    @RequestMapping("/updateApproval.json")
    @ResponseBody
    public ResponseData updateApproval(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        try {
            forumTopicService.update(filter);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
        return ResponseData.SUCCESS_NO_DATA;
    }


    /**
     * 查询可能为版主的用户
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/getModerator.html")
    public String getModerator(Model model,HttpServletRequest request) {
        if(StringUtils.isBlank(request.getParameter("belonged"))) {
            return "{\"success\":fasle,\"message\":\"未获得具体版块\"}";
        }else {
            QueryFilter filter = new QueryFilter(request);
            model.addAttribute("belonged",request.getParameter("belonged"));
            model.addAttribute("pager",forumTopicService.getModerator(filter));
        }
        return "forumtopic/moderatorUser";
    }

    /**
     * 保存或修改版主
     * @param request
     * @return
     */
    @RequestMapping("/saveOrUpdateModerator.json")
    @ResponseBody
    public ResponseData setModerator(HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("ids", request.getParameter("ids").split(","));
        filter.put("userId",sysUser.getId());
        try {
            forumTopicService.setModerator(filter);
        }catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
            return ResponseData.FAILED_NO_DATA;
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 查看置顶
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/viewModerator.html")
    public String viewModerator(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("belonged",request.getParameter("belonged"));
        model.addAttribute("pager",forumTopicService.viewModerator(filter));
        return "forumtopic/viewModerator";
    }

    /**
     * 置顶
     * @param request
     * @return
     */
    @RequestMapping("/setTop.json")
    @ResponseBody
    public ResponseData setTop(HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        if(sysUser == null) {
            return new ResponseData(false,"没有权限！");
        }else {
            try {
                QueryFilter filter = new QueryFilter(request);
                filter.put("topLevel","1");
                forumTopicService.setTop(filter);
            }catch (Exception e) {
                e.printStackTrace();
                e.getMessage();
                return ResponseData.FAILED_NO_DATA;
            }
            return ResponseData.SUCCESS_NO_DATA;
        }
    }
}
