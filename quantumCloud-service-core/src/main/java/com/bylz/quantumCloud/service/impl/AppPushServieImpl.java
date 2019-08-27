package com.bylz.quantumCloud.service.impl;

import com.bylz.quantumCloud.model.AppPush;
import com.bylz.quantumCloud.service.AppPushServie;
import com.likegene.framework.core.BaseServiceImpl;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/4
 */
public class AppPushServieImpl extends BaseServiceImpl<AppPush,Long> implements AppPushServie {
    @Override
    public String getNamespace() {
        return AppPush.class.getSimpleName();
    }
}
