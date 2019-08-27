package com.bylz.quantumCloud.admin.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.admin.util.BaiduTJUtil;
import com.bylz.quantumCloud.admin.util.DateUtils;
import com.bylz.quantumCloud.admin.util.ExportExcelUtil;
import com.bylz.quantumCloud.model.EduStatisticsVo;
import com.bylz.quantumCloud.service.EduStatisticsService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/1
 */
@Controller
@RequestMapping("/EduStatics")
public class EduStatisticsController extends BaseController {

    @Autowired
    private EduStatisticsService eduStatisticsService;

    /**
     * 百度统计详情页
     * @return
     */
    @RequestMapping("/details.html")
    public String details(HttpServletRequest request, ModelMap model) {
        model.addAttribute("type",request.getParameter("type"));
        return "/eduStatistics/details";
    }

    /*l*
     * 根据站点 ID 获取站点报告数据
     *
     * 文档地址：http://tongji.baidu.com/open/api/more?p=tongjiapi_getData.tpl
     */
    @RequestMapping("/trend.json")
    public @ResponseBody
    JSONObject trend(HttpServletRequest request) {
        String siteId = request.getParameter("siteId");//站点ID
        String method = request.getParameter("method");//要查询的报告 method名称
        String startDate = request.getParameter("startDate");//开始时间
        String endDate = request.getParameter("endDate");//结束时间
        String metrics = request.getParameter("metrics");//自定义指标选择，多个指标用逗号分隔
        int start_index = Integer.parseInt(request.getParameter("start_index") == null?"0":request.getParameter("start_index"));
        int max_results = Integer.parseInt(request.getParameter("max_results"));
        String gran = request.getParameter("gran");//	时间粒度(只支持有该参数的报告): day/hour/week/month
        JSONObject result = BaiduTJUtil.getData(siteId, method, startDate, endDate, metrics, gran,start_index,max_results);
        String type = request.getParameter("type") == null?null:request.getParameter("type").toString();
        JSONObject result1 = result.getJSONObject("body");
        JSONArray result2 = result1.getJSONArray("data");
        JSONObject result3 = result2.getJSONObject(0);
        JSONObject result4 = result3.getJSONObject("result");
        JSONArray result5 = result4.getJSONArray("items");
        JSONArray result6 = result5.getJSONArray(0);
        JSONArray result8 = result5.getJSONArray(1);
        int pagerSum = DateUtils.getAllDate(startDate,endDate).size();
        List<ArrayList> listList = JSONObject.parseArray(result8.toJSONString(),ArrayList.class);
        List<ArrayList> arrayDate = JSONObject.parseArray(result6.toJSONString(),ArrayList.class);
        List<String> dateList = new ArrayList<>();
        for(ArrayList arrayList : arrayDate) {
            dateList.add(((String)arrayList.get(0)).replaceAll("/",""));
        }
        QueryFilter filter= new QueryFilter(request);
        if(max_results != 0) {
            filter.put("start_index",start_index);
            filter.put("max_results",max_results);
            int surplus = pagerSum % max_results;
            if(surplus == 0) {
                pagerSum = pagerSum/max_results;
            }else {
                pagerSum = pagerSum/max_results + 1;
            }
        }else {
            pagerSum = 1;
        }
        filter.setStatementKey("getStatistics");
        Pagination pagination = eduStatisticsService.findPager(filter).getReturnObj();
        List<EduStatisticsVo> eduStatisticsVoList = pagination.getEntityList();
        List<EduStatisticsVo> list = new LinkedList<>();
        int count = 0;
        for(String date : dateList) {
            boolean flag = false;
            for(EduStatisticsVo eduStatisticsVo : eduStatisticsVoList) {
                String eduStatisticsDate = eduStatisticsVo.getAddTime();
                if(date.equals(eduStatisticsDate)) {
                    flag = true;
                    eduStatisticsVo.setCustomerCount((Integer) listList.get(count).get(0));
                    if("1".equals(type)) {
                        eduStatisticsVo.setStatisticsCount((Integer) listList.get(count).get(0));
                    }
                    list.add(eduStatisticsVo);
                    break;
                }
            }

            if(!flag) {
                EduStatisticsVo eduStatisticsVo = new EduStatisticsVo();
                eduStatisticsVo.setAddTime(date);
                eduStatisticsVo.setCustomerCount((Integer) listList.get(count).get(0));
                if("1".equals(type)) {
                    eduStatisticsVo.setStatisticsCount((Integer) listList.get(count).get(0));
                }
                list.add(eduStatisticsVo);
            }

            count ++;
        }


        result.put("pagerSum",pagerSum);
        result.put("dateList",dateList);
        result.put("eduStatisticsVoList",list);

        return result;
    }


    @RequestMapping("/exportData.json")
    @ResponseBody
    public void exportData(HttpServletRequest request,HttpServletResponse response) throws IOException {
        QueryFilter filter = new QueryFilter(request);
        filter.setStatementKey("getStatistics");
        String siteId = request.getParameter("siteId");//站点ID
        String method = request.getParameter("method");//要查询的报告 method名称
        String startDate = request.getParameter("startDate");//开始时间
        String endDate = request.getParameter("endDate");//结束时间
        String metrics = request.getParameter("metrics");//自定义指标选择，多个指标用逗号分隔
        int start_index = Integer.parseInt(request.getParameter("start_index") == null?"0":request.getParameter("start_index"));
        int max_results = Integer.parseInt(request.getParameter("max_results"));
        String gran = request.getParameter("gran");//	时间粒度(只支持有该参数的报告): day/hour/week/month
        JSONObject result = BaiduTJUtil.getData(siteId, method, startDate, endDate, metrics, gran,start_index,max_results);
        String type = request.getParameter("type") == null?null:request.getParameter("type").toString();
        JSONObject result1 = result.getJSONObject("body");
        JSONArray result2 = result1.getJSONArray("data");
        JSONObject result3 = result2.getJSONObject(0);
        JSONObject result4 = result3.getJSONObject("result");
        JSONArray result5 = result4.getJSONArray("items");
        JSONArray result8 = result5.getJSONArray(1);
        List<ArrayList> listList = JSONObject.parseArray(result8.toJSONString(),ArrayList.class);
        List<String> datelist = DateUtils.getAllDate(startDate,endDate);
        if(max_results != 0) {
            filter.put("start_index",start_index);
            filter.put("max_results",max_results);
        }
        filter.setStatementKey("getStatistics");
        Pagination pagination = eduStatisticsService.findPager(filter).getReturnObj();
        List<EduStatisticsVo> eduStatisticsVoList = pagination.getEntityList();
        List<EduStatisticsVo> list = new LinkedList<>();
        int count = 0;
        for(String date : datelist) {
            boolean flag = false;
            for(EduStatisticsVo eduStatisticsVo : eduStatisticsVoList) {
                String eduStatisticsDate = eduStatisticsVo.getAddTime();
                if(date.equals(eduStatisticsDate)) {
                    flag = true;
                    eduStatisticsVo.setCustomerCount((Integer) listList.get(count).get(0));
                    if("1".equals(type)) {
                        eduStatisticsVo.setStatisticsCount((Integer) listList.get(count).get(0));
                    }
                    list.add(eduStatisticsVo);
                    break;
                }
            }

            if(!flag) {
                EduStatisticsVo eduStatisticsVo = new EduStatisticsVo();
                eduStatisticsVo.setAddTime(date);
                eduStatisticsVo.setCustomerCount((Integer) listList.get(count).get(0));
                if("1".equals(type)) {
                    eduStatisticsVo.setStatisticsCount((Integer) listList.get(count).get(0));
                }
                list.add(eduStatisticsVo);
            }

            count ++;
        }

        Map<String,Object> headMap = new LinkedHashMap<>();
        headMap.put("addTime","时间");
        headMap.put("customerCount","访客数");
        headMap.put("registCount","用户注册数");
        headMap.put("viewVideoCount","视频观看数");
        headMap.put("publishForumCount","帖子发布数");
        headMap.put("signInCount","签到数");
        headMap.put("appDownLoadCount","APP下载数");
        XSSFWorkbook wb = ExportExcelUtil.export(headMap,list,"YYYY-MM-DD");
        String fileName = "数据概览信息";
        OutputStream out = response.getOutputStream();
        response.reset();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition","attachment;filename=" + new String(fileName.getBytes("gbk"), "ISO-8859-1") + ".xlsx");

        wb.write(out);
        out.close();

        response.setContentType("application/vnd.ms-excel");
    }


}
