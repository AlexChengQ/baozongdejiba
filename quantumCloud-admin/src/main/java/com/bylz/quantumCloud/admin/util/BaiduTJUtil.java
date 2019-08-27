/*
 * Copyright (c) 2018, Technology. All Rights Reserved. Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.admin.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.util.SettingUtil;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

/**
 * 百度统计utils
 *
 * @author Gao.Ning
 * @version 1.0
 * @since 2018年08月17日
 */
public class BaiduTJUtil {

    private static final JSONObject HEADER = new JSONObject();

    private static final String API_SITE;// 获取站点ID，获取当前用户下的站点和子目录列表以及对应参数信息，不包括权限站点和汇总网站。

    private static final String API_DATA;// 根据站点ID获取站点报告数据。

    private static final String API_URL;// 接口URL相同部分

    public static final String PASSWORD = "password";

    public static final String USERNAME = "username";

    public static final String TOKEN = "token";

    static {
        HEADER.put(USERNAME, SettingUtil.getSetting("baidutj.name", null));
        HEADER.put(PASSWORD, SettingUtil.getSetting("baidutj.password", null));
        HEADER.put(TOKEN, SettingUtil.getSetting("baidutj.token", null));
        HEADER.put("account_type", "1");
        API_SITE = "getSiteList";
        API_DATA = "getData";
        API_URL = "https://api.baidu.com/json/tongji/v1/ReportService/";
    }

    /**
     * 根据URL发送请求
     */
    private static String sendRequest(String url, String content) {
        System.out.println("sendRequest start");
        URLConnection conn = null;
        try {
            conn = new URL(url).openConnection();
            StringBuffer sb = null;
            if (conn != null) {
                System.out.println("connnect succeed");
                conn.setUseCaches(false);
                conn.setDoInput(true);
                conn.setDoOutput(true);
                conn.setRequestProperty("Content-Length", "" + content.length());
                conn.setRequestProperty("Cache-Control", "no-cache");
                conn.setRequestProperty("Content-Type", "application/json");
                DataOutputStream stream = new DataOutputStream(conn.getOutputStream());
                stream.write(content.getBytes("UTF-8"));
                stream.close();
                BufferedReader br = null;
                try {
                    br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                sb = new StringBuffer();
                String str = br.readLine();
                while (str != null) {
                    sb.append(str);
                    str = br.readLine();
                }
                br.close();
            }
            System.out.println("sendRequest end");
            return sb.toString();
        } catch (Exception e1) {
            e1.printStackTrace();
        }
        return "";
    }

    /**
     * 获取用户的站点列表
     * 文档地址：//http://tongji.baidu.com/open/api/more?p=tongjiapi_getSiteList.tpl
     */
    public static JSONObject getSite() {
        System.out.println("getSite start");

        JSONObject body = new JSONObject();
        body.put("method", API_SITE);// 接口方法名称

        JSONObject content = new JSONObject();
        content.put("header", HEADER);
        content.put("body", body);

        String result = sendRequest(API_URL + API_SITE, content.toJSONString());
        System.out.println("return data:" + JSON.parseObject(result));

        System.out.println("getSite end");
        return JSON.parseObject(result);
    }

    /**
     * 根据站点 ID 获取站点报告数据
     *
     * @param siteId 站点ID
     * @param method 要查询的报告 method名称
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param metrics 指标
     * @param gran 时间粒度
     * 文档地址：http://tongji.baidu.com/open/api/more?p=tongjiapi_getData.tpl
     */
    public static JSONObject getData(String siteId, String method, String startDate, String endDate, String metrics,
                                     String gran,int start_index,int max_results) {
        System.out.println("getData start");
        JSONObject body = new JSONObject();
        body.put("site_id", siteId);//站点id
        body.put("method", method);//通常对应要查询的报告
        body.put("start_date", startDate);//查询起始时间,例：20160501
        body.put("end_date", endDate);//查询结束时间,例：20160531
        //body.put("start_date2", "");//对比查询起始时间
        //body.put("end_date2", "");//对比查询结束时间
        body.put("metrics", metrics);//自定义指标选择，多个指标用逗号分隔
        body.put("gran", gran);//时间粒度(只支持有该参数的报告): day/hour/week/month
        // body.put("order", "1");//指标排序，示例：visitor_count,desc
         body.put("start_index", start_index);//获取数据偏移，用于分页；默认是0
        body.put("max_results", max_results);//单次获取数据条数，用于分页；默认是20; 0表示获取所有数据

        JSONObject content = new JSONObject();
        content.put("header", HEADER);
        content.put("body", body);

        String result = sendRequest(API_URL + API_DATA, content.toJSONString());

        System.out.println("return data:" + JSON.parseObject(result));
        System.out.println("getData end");
        return JSON.parseObject(result);
    }

    public static void main(String[] args) {
        //获取站点
        //BaiduTJUtil.getSite();//originqc.com.cn->12223696,qubitonline.cn->12238346,intro.qubitonline.cn->12238355

        //获取数据
//        JSONObject object = BaiduTJUtil.getData("12223696", "homepage/getSitesInfoList", "20180820", "20180820",
//                "pv_count,visitor_count,ip_count,bounce_ratio,avg_visit_time", "day");

    }

}
