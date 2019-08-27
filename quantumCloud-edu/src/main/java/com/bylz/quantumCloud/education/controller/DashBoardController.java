package com.bylz.quantumCloud.education.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.likegene.framework.core.QueryFilter;

@Controller
@RequestMapping("/")
public class DashBoardController extends BaseController {

    /**
     * 用户信息查询
     * @author songhaozhang
     * @return 2017-7-20 JT
     */
    @RequestMapping(value = "/EDU/userinfo.html")
    public String userInfo(ModelMap model, HttpServletRequest request) {
        QcodeUser userInfo = AppContextHolder.getCurrentUser();
        String userid = request.getParameter("userid");
        
        QueryFilter filter = new QueryFilter();
        filter.put("id", userInfo.getId());
        
        
        //查询视频观看记录  
        model.put("userInfo", userInfo);
        //判断是否从邮件过来
        return "quantumCloud/userInfo";
    }

	
	
}
