package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.model.StatisticsCountVo;
import com.bylz.quantumCloud.service.StatisticsCountService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:统计用户数、任务数
 * @since 2019/2/26
 */

@RequestMapping("/statistics")
@Controller
public class StatisticsCountController {

    @Autowired
    private StatisticsCountService statisticsCountService;


    @RequestMapping("/statisticsCount.html")
    public String getCount(Model model) {
        StatisticsCountVo statisticsCountVo = statisticsCountService.getSataisticsCount(new QueryFilter());
        Date date = new Date();
        statisticsCountVo.setObtainDate(date);
        model.addAttribute("statisticsCount",statisticsCountVo);
        return "statistics/index";
    }
}
