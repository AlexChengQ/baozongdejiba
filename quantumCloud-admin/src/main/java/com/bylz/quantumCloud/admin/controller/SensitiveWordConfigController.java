package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.model.SensitiveWordVo;
import com.bylz.quantumCloud.service.SensitiveWordService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/7
 */
@Controller
@RequestMapping("/SensitiveConfig")
public class SensitiveWordConfigController {

    @Autowired
    private SensitiveWordService sensitiveWordService;

    /**
     * 敏感词列表
     * @param modelMap
     * @return
     */
    @RequestMapping("/index.html")
    public String sensitiveIndex(ModelMap modelMap, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        modelMap.put("pager",sensitiveWordService.findPager(filter).getReturnObj());
        return "/sensitive/index";
    }

    @RequestMapping("/add.html")
    public String add() {
        return "/sensitive/add";
    }

    @RequestMapping("/addSensitiveWord.json")
    @ResponseBody
    public ResponseData addSensitiveWord(SensitiveWordVo sensitiveWordVo) {
        try {
            sensitiveWordService.save(sensitiveWordVo);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }

        return ResponseData.SUCCESS_NO_DATA;
    }


    @RequestMapping("/update.html")
    public String updateWord(HttpServletRequest request) {
        long id = Long.parseLong(request.getParameter("id"));
        QueryFilter filter = new QueryFilter();
        filter.put("id",id);
        request.setAttribute("entity",sensitiveWordService.findOne(filter).getReturnObj());
        return "/sensitive/edit";
    }

    @RequestMapping("/updateSensitiveWord.json")
    @ResponseBody
    public ResponseData updateSensitiveWord(SensitiveWordVo sensitiveWordVo) {
        try {
            sensitiveWordService.update(sensitiveWordVo);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    @RequestMapping("/deleteSensitiveWord.json")
    @ResponseBody
    public ResponseData deleteSensitiveWord(long id) {
        try {
            sensitiveWordService.delete(id);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseData.FAILED_NO_DATA;
        }

        return ResponseData.SUCCESS_NO_DATA;
    }
}
