/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.model.QcodeApply;
import com.bylz.quantumCloud.service.QcodeApplyService;

/**
 * 虚拟机申请Controller
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年04月13日
 */
@Controller
@RequestMapping("/qcodeApply")
public class QcodeApplyController extends BaseController {

    public static final String SELECT_APPLY_RECORD_LIST = "selectApplyRecordList";

    /**
     * 虚拟机申请Service
     */
    @Autowired
    private QcodeApplyService qcodeApplyService;

    /**
     * 虚拟机申请展示页面
     */
    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey(QcodeApplyService.SELECT_INDEX_LIST);
        filter.put("order", "qa.`apply_time` DESC");
        model.put("pager", qcodeApplyService.findPager(filter).getReturnObj());
        return "/qCodeApply/index";
    }

    /**
     * 虚拟机申请审核
     */
    @RequestMapping(value = "/audit.json")
    @ResponseBody
    public ResponseData audit(QcodeApply qcodeApply) {

        try {
            if (qcodeApply.getId() != null && qcodeApply.getApplyStatus() != null) {
                //更改用户为老用户状态
                qcodeApplyService.update(qcodeApply);
            }
        } catch (Exception e) {
            return new ResponseData(false, e.getMessage());
        }

        return ResponseData.SUCCESS_NO_DATA;
    }
    /**
     * 虚拟机申请记录
     */
    @RequestMapping(value = "/applyRecord.html")
    public String applyRecord(ModelMap model,QcodeApply qcodeApply) {
        QueryFilter filter = new QueryFilter();
        filter.put("userId",qcodeApply.getUserId());
        filter.setStatementKey(QcodeApplyService. SELECT_APPLY_RECORD_LIST);
        model.put("list", qcodeApplyService.findList(filter).getReturnObj());
        return "/qCodeApply/applyRecord";
    }
}
