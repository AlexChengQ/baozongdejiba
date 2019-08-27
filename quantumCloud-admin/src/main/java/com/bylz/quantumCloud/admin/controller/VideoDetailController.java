package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.admin.util.DateUtils;
import com.bylz.quantumCloud.admin.util.ExportExcelUtil;
import com.bylz.quantumCloud.service.VideoDetailService;
import com.likegene.framework.core.Pagination;
import com.likegene.framework.core.QueryFilter;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/8
 */
@RequestMapping("/videoDetail")
@Controller
public class VideoDetailController {

    @Autowired
    private VideoDetailService videoDetailService;

    @RequestMapping("/index.html")
    public String getIndex(Model model) {
        model.addAttribute("videoDetail",videoDetailService.getVideoTotal(new QueryFilter()));
        return "/videoDetail/details";
    }

    @RequestMapping("/getVideoSingle.json")
    @ResponseBody
    public ResponseData getVideoSingle(HttpServletRequest request) {
        ResponseData data= new ResponseData(true);
        QueryFilter filter= new QueryFilter(request);
        List<Map> dataList = videoDetailService.getVideoSingle(filter);
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        List<String> dateList = DateUtils.getAllDate(startDate,endDate);
        int[] frequencyDataNum = new int[dateList.size()];
        int[] peopleDataNum = new int[dateList.size()];
        int count = 0;
        for(String date : dateList) {
            boolean flag = false;
            for(Map map : dataList) {
                String time = map.get("triggerday").toString();
                if(date.equals(time)) {
                    flag = true;
                    frequencyDataNum[count] = Integer.parseInt(map.get("frequency").toString());
                    peopleDataNum[count] = Integer.parseInt(map.get("peoplenum").toString());
                    break;
                }
            }
            if(!flag) {
                frequencyDataNum[count] = 0;
                peopleDataNum[count] = 0;
            }

            count++;
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("dateList",dateList);
        map.put("frequencyData",frequencyDataNum);
        map.put("peopleData",peopleDataNum);
        data.setObj(map);
        return data;
    }

    @RequestMapping("/getListVide.html")
    public String getListVideo(HttpServletRequest request,Model model) {
        QueryFilter filter = new QueryFilter(request);
        Pagination pagination = videoDetailService.getListVideo(filter);
        model.addAttribute("pager",pagination);
        return "/videoDetail/index";
    }


    @RequestMapping("/exportData.json")
    @ResponseBody
    public void exportData(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        ResponseData data = new ResponseData(true);
        QueryFilter filter = new QueryFilter(request);
        List list = videoDetailService.videoList(filter);
        Map<String,Object> headMap = new LinkedHashMap<>();
        headMap.put("title","视频名称");
        headMap.put("videourl","视频链接");
        headMap.put("addTime","上传时间");
        headMap.put("free","是否免费");
        headMap.put("playcount","播放次数");
        headMap.put("sharecount","分享次数");
        headMap.put("replycount","评论次数");
        XSSFWorkbook wb = ExportExcelUtil.export(headMap,list,"YYYY-MM-DD");
//        if (wb == null) {
//            data.setSuccess(false);
//        }
        String fileName = "视频详细信息";
        OutputStream out = response.getOutputStream();
        response.reset();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition","attachment;filename=" + new String(fileName.getBytes("gbk"), "ISO-8859-1") + ".xlsx");

        wb.write(out);
        out.close();

    }

}
