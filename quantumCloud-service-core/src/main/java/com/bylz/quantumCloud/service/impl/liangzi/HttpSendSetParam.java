package com.bylz.quantumCloud.service.impl.liangzi;

import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.likegene.framework.util.SettingUtil;

public class HttpSendSetParam extends HttpSend {
    public static Object sent(HashMap<String, String> paramMap) {
        HttpSend.setHost(SettingUtil.getSetting("ip", String.class));
        return HttpSendMethod(paramMap);
    }

    public static Object sentNew(HashMap<String, String> paramMap) {
        HttpSend.setHost(SettingUtil.getSetting("qrunes2Ip", String.class));
        return HttpSendMethod(paramMap);
    }
}
