package com.bylz.quantumCloud.education.controller;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;


/**
 * QCode Controller
 *
 */
@Controller
@RequestMapping("/")
public class MobileController extends BaseController {

    @Autowired
    private QcodeUserService qcodeuserservice;
    @Autowired
    private SysConfigService sysConfigService;
    @Autowired
    private EduStatisticsService eduStatisticsService;


    /**
     * 首页(手机)
     */
    @RequestMapping(value = "m/index.html")
    public String mIndex() {
        return "eduMobile/index";
    }

    /**
     * 推荐阅读(手机)
     */
    @RequestMapping(value = "m/mReading.html")
    public String mReading() {
        return "eduMobile/mReading";
    }
    /**
     * 编程大赛(手机)
     */
    @RequestMapping(value = "m/signUp.html")
    public String mSignUp() {
        return "eduMobile/signUp";
    }

    /**
     * 编程大赛报名(手机)
     */
    @RequestMapping(value = "m/appCompetition.html")
    public String mCompetition() {
        return "eduMobile/appCompetition";
    }

    /**
     * 个人中心(手机)
     */
    @RequestMapping(value = "m/personal.html")
    public String mPersonal() {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(null==qcodeUser) {
            return "eduMobile/login";
        }
        return "eduMobile/personal";
    }

    /**
     * 学习页面获取(手机)
     */
    @RequestMapping(value = "m/quantumLearning.html")
    public String mLearning() {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(null==qcodeUser) {
            return "eduMobile/login";
        }
        return "eduMobile/quantumLearning";
    }

    /**
     * 个人中心页面获取(手机)
     */
    @RequestMapping(value = "m/dashboard.html")
    public String mdashboard() {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(null==qcodeUser) {
            return "eduMobile/login";
        }
        return "eduMobile/dashboard";
    }

    /**
     * 视频页面获取(手机)
     */
    @RequestMapping(value = "m/mVideo.html")
    public String mVideo() {
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(null==qcodeUser) {
            return "eduMobile/login";
        }
        return "eduMobile/quantumVideo";
    }


    /**
     * 登录页面获取(手机)
     */
    @RequestMapping(value = "m/login.html")
    public String mLogin(ModelMap model, HttpServletRequest request) {
        String forward = request.getParameter("forward");
        if (forward != null && !"".equals(forward)) {
            model.put("forward", forward);
        }
        return "eduMobile/login";
    }


    /**
     * 忘记页面获取(手机)
     */
    @RequestMapping(value = "m/forget.html")
    public String mForget() {
        return "eduMobile/forget";
    }




    /**
     * 注册页面获取(手机)
     */
    @RequestMapping(value = "m/register.html")
    public String mRegister(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
        String forward = request.getParameter("forward");
        if(forward!=null&&!"".equals(forward)){
            model.put("forward", forward);
        }
        return "eduMobile/register";
    }


    /**
     * app外部链接地址
     * @param model
     * @param request
     * @param response
     * @return
     * @since  2019-07-26
     * @author songhaozhang
     */
    @RequestMapping(value = "eduMobile/appdownload.html")
    public String mappdownload(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("keyname","Android");
        filter.setStart(0);
        filter.setLimit(1);
        filter.put("order","val DESC");
        SysConfig sysConfig = sysConfigService.findOne(filter).getReturnObj();

        String versionAndUrl = sysConfig.getVal();
        String updUrl = versionAndUrl.substring(versionAndUrl.indexOf("|")+1);
        model.put("updUrl",updUrl);
        return "eduMobile/appDownload";
    }


    /**
     * app二维码扫描地址
     * @param model
     * @param request
     * @param response
     * @return
     * @since  2019-07-26
     * @author songhaozhang
     */
    @RequestMapping(value = "eduMobile/appDownload.html")
    public String mappDownload(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("keyname","Android");
        filter.setStart(0);
        filter.setLimit(1);
        filter.put("order","val DESC");
        SysConfig sysConfig = sysConfigService.findOne(filter).getReturnObj();

        String versionAndUrl = sysConfig.getVal();
        String updUrl = versionAndUrl.substring(versionAndUrl.indexOf("|")+1);
        model.put("updUrl",updUrl);
        return "eduMobile/appDownload";
    }

    @RequestMapping(value = "EDU/appdownload.html")
    public String mappEDUdownload(ModelMap model,HttpServletRequest request,HttpServletResponse response) {
        QueryFilter filter = new QueryFilter();
        filter.put("keyname","Android");
        filter.setStart(0);
        filter.setLimit(1);
        filter.put("order","val DESC");
        SysConfig sysConfig = sysConfigService.findOne(filter).getReturnObj();

        String versionAndUrl = sysConfig.getVal();
        String updUrl = versionAndUrl.substring(versionAndUrl.indexOf("|")+1);
        model.put("updUrl",updUrl);
        return "tutorial/appdownload";
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
     * 创建API KEY
     *
     * @since 2018-1-9
     */
    @RequestMapping(value = "MobileQcode/createKey.json")
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
                Result result = qcodeuserservice.update(user);
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


    @RequestMapping("/statisticsDownload.json")
    @ResponseBody
    public void statisticsDownload(String version) {
        QueryFilter filter = new QueryFilter();
        filter.put("keyName",version);
        try {
            sysConfigService.updateDownloadCount(filter);
            EduStatisticsVo eduStatisticsVo = eduStatisticsService.findOne(new QueryFilter()).getReturnObj();
            if(eduStatisticsVo != null) {
                eduStatisticsVo.setAppDownLoadCount(eduStatisticsVo.getAppDownLoadCount()+1);
                eduStatisticsService.update(eduStatisticsVo);
            }else {
                filter.clear();
                filter.put("appDownLoadCount",1);
                filter.setStatementKey("addEduStatistics1");
                eduStatisticsService.save(filter);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

}
