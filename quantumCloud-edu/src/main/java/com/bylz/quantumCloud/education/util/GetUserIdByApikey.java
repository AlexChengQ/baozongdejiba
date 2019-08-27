package com.bylz.quantumCloud.education.util;

import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.QueryFilter;
import org.springframework.web.context.ContextLoader;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/5/15
 */
public class GetUserIdByApikey {

    private static QcodeUserService qcodeUserService = (QcodeUserService) ContextLoader.getCurrentWebApplicationContext().getBean("qcodeUserService");

    public static QcodeUser getUserId(String token) {
        QueryFilter filter = new QueryFilter();
        filter.put("apiKey",token);
        QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
        return qcodeUser;
    }
}
