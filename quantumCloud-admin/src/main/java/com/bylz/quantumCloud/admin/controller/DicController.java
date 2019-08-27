package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.core.AppContextHolder;
import com.bylz.quantumCloud.model.SysUser;
import com.bylz.quantumCloud.service.DicService;
import com.likegene.framework.core.QueryFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:字典controller
 * @since 2018/8/6
 */
@Controller
@RequestMapping("/Qcode/dic")
public class DicController extends BaseController {

    @Autowired
    private DicService dicService;

    @RequestMapping("/dicIndex.html")
    public String getDicList(Model model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",dicService.getDicListByPage(filter));
        return "/dic/dicList";
    }

    /**
     * 新增或修改页面
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/addDicIndex.html")
    public String addDicIndex(Model model,HttpServletRequest request) {
        String id = request.getParameter("id");
        QueryFilter filter = new QueryFilter(request);
        if(StringUtils.isNotBlank(id)) {
            model.addAttribute("dic",dicService.getDicById(filter));
        }
        return "/dic/add";
    }

    /**
     * 添加或修改字典
     * @param request
     * @return
     */
    @RequestMapping("/saveDic.json")
    @ResponseBody
    public ResponseData saveDic(HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId",sysUser.getId());
        try {
            if(StringUtils.isBlank(request.getParameter("id"))) {
                dicService.saveDic(filter);
            }else {
                dicService.updDic(filter);
            }
        }catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
            return new ResponseData(false,"添加失败");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 根据字典Id查询字典内容
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/getDicContentById.html")
    public String getDicContentById(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("dicId",request.getParameter("dicId"));
        model.addAttribute("pager",dicService.getDicContentById(filter));
        return "/dic/dicContentList";
    }

    /**
     * 添加或修改字典内容页面
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/saveContent.html")
    public String saveContent(Model model,HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("dicId",request.getParameter("dicId"));
        if(StringUtils.isNotBlank(request.getParameter("id"))) {
            model.addAttribute("dicContent",dicService.getDicContent(filter));
        }
        return "/dic/addDicContent";
    }

    /**
     * 添加或修改字典内容
     * @param request
     * @return
     */
    @RequestMapping("/saveDicContent.json")
    @ResponseBody
    public ResponseData saveDicContent(HttpServletRequest request) {
        SysUser sysUser = AppContextHolder.getCurrentUser();
        QueryFilter filter = new QueryFilter(request);
        filter.put("userId",sysUser.getId());
        try {
            if(StringUtils.isBlank(request.getParameter("id"))) {
                //新增
                dicService.saveDicContent(filter);
            }else {
                dicService.updDicContent(filter);
            }
        }catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
            return new ResponseData(false,"添加字典内容失败");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 删除字典内容
     * @param request
     * @return
     */
    @RequestMapping("/delDicContent.json")
    @ResponseBody
    public ResponseData delDicContent(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        try {
            dicService.delDicContent(filter);
        }catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
            return new ResponseData(false,"删除字典内容失败");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }

    /**
     * 删除字典
     * @param request
     * @return
     */
    @RequestMapping("/delDic.json")
    @ResponseBody
    public ResponseData delDic(HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        try {
            dicService.delDic(filter);
        }catch (Exception e) {
            e.printStackTrace();
            e.getMessage();
            return new ResponseData(false,"删除字典失败");
        }
        return ResponseData.SUCCESS_NO_DATA;
    }
}
