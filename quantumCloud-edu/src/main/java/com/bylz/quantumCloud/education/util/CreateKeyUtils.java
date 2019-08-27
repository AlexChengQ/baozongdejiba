package com.bylz.quantumCloud.education.util;

import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;

import java.util.UUID;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/29
 */
public class CreateKeyUtils {

    @Autowired
    private static QcodeUserService qcodeuserservice = (QcodeUserService) ContextLoader.getCurrentWebApplicationContext().getBean("qcodeUserService");

    public static ResponseData createKey(QcodeUser user) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        if (user != null) {
            String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
            user.setApiKey(apiKey);
            Result result = qcodeuserservice.update(user);
            if (result.isSuccess()) {
                data.setObj(apiKey);
            } else {
                data.setSuccess(false);
            }
        } else {
            data.setSuccess(false);
        }
        return data;
    }
}
