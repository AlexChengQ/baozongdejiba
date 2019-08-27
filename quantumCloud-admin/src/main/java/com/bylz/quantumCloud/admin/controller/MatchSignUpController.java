package com.bylz.quantumCloud.admin.controller;

import com.bylz.quantumCloud.service.MatchSignUpService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/25
 */
@RequestMapping("/matchSignUp")
@Controller
public class MatchSignUpController extends BaseController {

    @Autowired
    private MatchSignUpService matchSignUpService;

    @RequestMapping("/index.html")
    public String getMatchSignUpDetail(HttpServletRequest request, Model model) {
        QueryFilter filter = new QueryFilter(request);
        model.addAttribute("pager",matchSignUpService.findPager(filter).getReturnObj());
        return "matchSignUp/index";
    }

}
