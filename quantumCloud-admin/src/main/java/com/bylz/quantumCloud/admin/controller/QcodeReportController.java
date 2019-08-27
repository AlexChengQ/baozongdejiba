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

import com.bylz.quantumCloud.service.ForumTopicService;
import com.likegene.framework.core.QueryFilter;

/**
 * 举报Controller
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年07月10日
 */
@Controller
@RequestMapping("/qcodereport")
public class QcodeReportController extends BaseController {
    @Autowired
    public ForumTopicService service;
    @RequestMapping(value = "/index.html")
    public String index(ModelMap model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("getReportPage");
        model.put("pager", service.findPager(filter).getReturnObj());
        return "/qcodereport/index";
    }


    @RequestMapping(value = "/detail.html")
    public String detail(Long id, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter();
        filter.put("id", id);
        filter.setStatementKey("getReportPage");
        request.setAttribute("entity", service.findOne(filter).getReturnObj());
        return "/qcodereport/detail";
    }


    @RequestMapping(value = "/delete.json")
    @ResponseBody
    public ResponseData delete(Long id) {
        try {
            if (id != null) {
                service.delete(id);
            }
        } catch (Exception e) {
            return new ResponseData(false, e.getMessage());
        }

        return ResponseData.SUCCESS_NO_DATA;
    }

}
