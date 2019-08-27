package com.bylz.quantumCloud.admin.controller;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.PushPayload;
import com.bylz.quantumCloud.admin.util.JPushUtils;
import com.bylz.quantumCloud.model.AppPush;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.service.AppPushServie;
import com.bylz.quantumCloud.service.SysConfigService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/4
 */
@Controller
@RequestMapping("/appPush")
public class AppPushController extends BaseController {

    @Autowired
    private AppPushServie appPushServie;

    @Autowired
    private SysConfigService sysConfigService;

    @RequestMapping("/index.html")
    public String getIndex(Model model, HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        Pagination pagination = appPushServie.findPager(filter).getReturnObj();
        model.addAttribute("pager",pagination);
        return "/appPush/index";
    }

    @RequestMapping("/add.html")
    public String addAppPush() {
        return "/appPush/add";
    }

    @RequestMapping("/update.html")
    public String updateAppPush(Model model,HttpServletRequest request) {
        QueryFilter filter = new QueryFilter(request);
        AppPush appPush = appPushServie.findOne(filter).getReturnObj();
        model.addAttribute("entity",appPush);
        return "/appPush/update";
    }

    @RequestMapping("/save.json")
    @ResponseBody
    public ResponseData saveAppPush(AppPush appPush) {
        ResponseData data = new ResponseData(true);

        try {
            appPushServie.save(appPush);
            data.setMessage("保存成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("保存失败");
            return data;
        }

        return data;
    }

    @RequestMapping("/updAppPush.json")
    @ResponseBody
    public ResponseData updAppPush(AppPush appPush) {
        ResponseData data = new ResponseData(true);

        try {
            appPushServie.update(appPush);
            data.setMessage("修改成功");
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage("保存失败");
            return data;
        }

        return data;
    }


    @RequestMapping("/delPush.json")
    @ResponseBody
    public ResponseData delPush(long id) {
        ResponseData data = new ResponseData(true);
        try {
            appPushServie.delete(id);
            data.setMessage("删除成功");
            return data;
        }catch (Exception e) {
            data.setSuccess(false);
            data.setMessage(e.getMessage());
            return data;
        }
    }


    @RequestMapping("/push.json")
    @ResponseBody
    public ResponseData push(Long id) {
        QueryFilter filter = new QueryFilter();
        PushPayload payload = null;
        filter.put("id",id);
        AppPush appPush = appPushServie.findOne(filter).getReturnObj();
        Map<String,String> map = new HashMap<>();
        payload = JPushUtils.buildPushObject_android_and_ios(appPush.getTitle(),appPush.getContent(),map);
        try {
            PushResult result = JPushUtils.jPushClient.sendPush(payload);
            System.out.println("Got result - " + result);
            filter.put("isPush","1");
            int r = appPushServie.update(filter).getReturnObj();
            if(r > 0) {
                return ResponseData.SUCCESS_NO_DATA;
            }else {
                return ResponseData.FAILED_NO_DATA;
            }


        } catch (APIConnectionException e) {
            // Connection error, should retry later
            System.out.print("Connection error, should retry later "+e);

        } catch (APIRequestException e) {
            // Should review the error, and fix the request
            System.out.println("根据返回的错误信息核查请求是否正确"+e);
            System.out.println("HTTP 状态信息码: " + e.getStatus());
            System.out.println("JPush返回的错误码: " + e.getErrorCode());
            System.out.println("JPush返回的错误信息: " + e.getErrorMessage());
        }

        return ResponseData.FAILED_NO_DATA;
    }

    @RequestMapping("/appDownCount.html")
    public String getAppDownCount(Model model) {
        QueryFilter filter = new QueryFilter();
        filter.put("keyname","andriodDown");
        model.addAttribute("pager",sysConfigService.findPager(filter).getReturnObj());
        return "appPush/downCount";
    }
}
