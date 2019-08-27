package com.bylz.quantumCloud.education.controller;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.model.UserBonusVo;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.QueryFilter;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Timer;
import java.util.TimerTask;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/3/12
 */
@Controller
@RequestMapping("/InspectHeart")
public class InspectHeartbeatController {

    @Autowired
    private QcodeUserService qcodeUserService;

    @RequestMapping("/inspect.json")
    @ResponseBody
    public void getLastPostCheck() {
        Session session = AppContextHolder.getSession();
        Object attribute = session.getAttribute("lastPostTime");
        QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
        if(attribute != null) {
            long lastPostTime = (long)attribute;
            long currentTimeMillis = System.currentTimeMillis();
            long stdTime = (currentTimeMillis - lastPostTime)/(1000*60);
            if (3 <= stdTime) {
                QueryFilter filter = new QueryFilter();
                filter.put("userId",qcodeUser.getId());
                filter.put("logoutTime","1");
                filter.put("loginTime",session.getAttribute("userStdDate"));
                filter.setStatementKey("updUserLogoutTime");
                qcodeUserService.update(filter);
                AppContextHolder.getSession().removeAttribute("lastPostTime");
            }

        }

    }

}
