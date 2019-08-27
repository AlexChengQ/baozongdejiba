package com.bylz.quantumCloud.education.util.qq;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.util.HttpUtils;
import com.likegene.framework.util.SettingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/6/28
 */
public class QQUtils {

    private static final Logger logger = LoggerFactory.getLogger(QQUtils.class);


    public static String getCode() {
        String qqUrl = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=QQ_client_id&redirect_uri=QQ_redirect_uri&scope=LOGIN";
        qqUrl= qqUrl.replace("QQ_client_id", SettingUtil.getSetting("QQ_client_id", String.class));
        try {
            qqUrl = qqUrl.replace("QQ_redirect_uri",
                    URLEncoder.encode(SettingUtil.getSetting("QQ_redirect_uri", String.class), "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage());
        }

        return qqUrl;
    }


    public static String getAccessByCode(String code) {
        String url = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=QQ_client_id" +
                "&client_secret=QQ_client_SERCRET&code=CODE&redirect_uri=QQ_redirect_uri";
        url= url.replace("QQ_client_id", SettingUtil.getSetting("QQ_client_id", String.class));
        url= url.replace("QQ_client_SERCRET", SettingUtil.getSetting("QQ_client_SERCRET", String.class));
        url= url.replace("CODE", code);
        try {
            url = url.replace("QQ_redirect_uri",
                    URLEncoder.encode(SettingUtil.getSetting("QQ_redirect_uri", String.class), "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            logger.error(e.getMessage());
        }

        System.out.println(url);
        String result = "";
        try {
            result = HttpUtils.sendGet(url);
        }catch (Exception e) {
            e.printStackTrace();
        }

        String tokens[] = result.split("&");
        String access_token = tokens[0];
        return access_token;
    }


    public static String getOpenId(String access_token) {
        String openUrl = "https://graph.qq.com/oauth2.0/me?"+access_token;
        String result = "";
        try {
            result = HttpUtils.sendGet(openUrl);
        }catch (Exception e) {
            e.printStackTrace();
        }
        JSONObject jsonObject = JSON.parseObject(result.substring(10, result.length() - 3));
        String openId = jsonObject.getString("openid");
        return openId;
    }

    public static QQUser getQQUserInfo(String appId,String accessToken,String openId) {
        String userInfoUrl = "https://graph.qq.com/user/get_user_info?"+accessToken+"&oauth_consumer_key="+appId+"&openid="+openId;
        String jsonString = "";
        try {
            jsonString = HttpUtils.sendGet(userInfoUrl);
        }catch (Exception e) {
            e.printStackTrace();
        }

        QQUser qqUser = JSON.parseObject(jsonString,QQUser.class);
        qqUser.setOpenId(openId);
        return qqUser;
    }
}
