package com.bylz.quantumCloud.mobile.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.util.DigestUtils;

/**
 * 手机短信发送类
 *
 * @author wangquanyuan
 * @version 1.0
 * @since 2017-6-30
 */
public class SendSMSUtil {
    
	private static final String SMS_URL = "https://sms.189ek.com/yktsms/send";
	private static final String app_id = "7m2oQ521wD3hAVMUSTsnWL8IIw5eSsJc";
	private static final String app_key = "LsqtKr5IyTGoASqrxtjndlyJ86hx69QH";
	//private static final String app_key1 = "O1FqMA6Q0SEdnSDKkeWfVQ9IsRGolYo9";
	public static final String SMS_CONTENT = "【全球安】您的手机验证码是：{验证码}，该验证码{lostTime}分钟内有效。";
    public static final String SMS_CONTENT_ADD_FRIEND = "【全球安】APP提醒您：APP用户（{手机号}）希望添加您为好友，与您共享智能监控，马上去下载手机客户端吧！www.xjqqa.com";
    /**邀请店员的短信消息提醒*/
	public static String INVITEUSER_SMS = "【全球安】APP提醒您：APP用户(%s)邀请你加入%s，马上去下载手机客户端吧！www.xjqqa.com";
	public static boolean sendSMS(String content, String mobile) {
        boolean isSendSuccess = false;
        BufferedReader reader = null;
        StringBuffer sbf = new StringBuffer();
        String httpUrl;
		try {
			String sign = app_id+mobile+content+app_key;
			httpUrl = SMS_URL+"?appid="+app_id+"&mobile="+mobile+"&msg="+URLEncoder.encode(content, "UTF-8")+"&sign="+DigestUtils.md5DigestAsHex(sign.getBytes());
            URL url = new URL(httpUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.connect();
            InputStream is = connection.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sbf.append(strRead);
            }
            reader.close();
            String result = sbf.toString();
            //System.out.println("sms result:"+result);
            String[] resultArr = result.split(",");
            if (resultArr != null && "0".equals(resultArr[0])) {
                isSendSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSendSuccess;
    }
	
	public static void main(String[] args) {
        String content = SMS_CONTENT.replace("{验证码}", "123456").replace("{lostTime}", "2");
        System.out.println(content);

        boolean jsonResult = sendSMS(content, "15256582908");
        System.out.println(jsonResult);
    } 
	
}
