package com.bylz.quantumCloud.education.controller;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.QueryFilter;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;

import java.util.TimerTask;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/8/12
 */
@Component
public class UserStatusTask extends TimerTask {

    @Autowired
    private QcodeUserService qcodeUserService;

//    public void queryAbnormalLogout() {
//
//    }

    /**
     * The action to be performed by this timer task.
     */
    @Override
    public void run() {
        Session session = AppContextHolder.getSession();
        if(session != null) {
            Object attribute = AppContextHolder.getSession().getAttribute("lastPostTime");
            QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
            if(attribute != null) {
                long lastPostTime = (long)attribute;
                long invalidTimer = (long)AppContextHolder.getSession().getAttribute("invalidTimer");
                long currentTimeMillis = System.currentTimeMillis();
                long stdTime = (currentTimeMillis - lastPostTime)/(1000*60);
                if (invalidTimer <= stdTime) {
                    QueryFilter filter = new QueryFilter();
                    filter.put("id",qcodeUser.getId());
                    filter.put("logoutTime","1");
                    filter.put("loginTime",session.getAttribute("userStdDate"));
                    filter.setStatementKey("updUserLogoutTime");
                    qcodeUserService.update(filter);
                    AppContextHolder.getSession().removeAttribute("lastPostTime");
                    AppContextHolder.getSession().removeAttribute("invalidTimer");
                }
            }
        }
    }
}
