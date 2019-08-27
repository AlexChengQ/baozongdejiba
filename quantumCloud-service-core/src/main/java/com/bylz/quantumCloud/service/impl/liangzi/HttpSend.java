package com.bylz.quantumCloud.service.impl.liangzi;

import java.io.InputStream;
import java.util.Map;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.protocol.Protocol;
import org.apache.commons.httpclient.protocol.ProtocolSocketFactory;
import org.apache.commons.io.IOUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

public class HttpSend {

    private static String host = CONST.HOST;
        

    public static JSONObject HttpSendMethod(Map<String, String> paramsMap) {

        // 返回json
        JSONObject jsonObj = doPost(host, paramsMap);
        System.out.println("=============================");
        System.out.println("返回结果：" + jsonObj.toJSONString());
        return jsonObj;

    }

    public static JSONObject doPost(String url, Map<String, String> map) {
        ProtocolSocketFactory fcty = new MySecureProtocolSocketFactory();
        Protocol.registerProtocol("https", new Protocol("https", fcty, 8080));
        String json = JSON.toJSONString(map);
        HttpClient client = new HttpClient();
/*        client.getParams().setContentCharset("UTF-8");
        client.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
        client.getParams().setParameter(HttpConnectionParams.CONNECTION_TIMEOUT,5000);
        client.getParams().setParameter(HttpMethodParams.SO_TIMEOUT,5000);*/
        PostMethod method = new PostMethod(url);
        method.addRequestHeader("Content-Type", "application/json; charset=UTF-8");
        System.out.println(url);
        String result = "";
        JSONObject jsonObject = new JSONObject();
        try {
            RequestEntity se = new StringRequestEntity(json, "application/json", "UTF-8");
    		method.setRequestEntity(se);
            client.executeMethod(method);
            InputStream inputStream = method.getResponseBodyAsStream();
            result = IOUtils.toString(inputStream, "UTF-8");
            try{
            	jsonObject = JSONObject.parseObject(result);
            }catch(JSONException je){
            	System.err.println("com.bylz.quantumCloud.service.impl.liangzi.HttpSend JSON类型转换错误");
            	jsonObject = new JSONObject();
/*            	jsonObject.put("code", 0);
            	jsonObject.put("success", "false");
            	jsonObject.put("message", result);
            	jsonObject.put("execptionTrace", je.getMessage());*/
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            method.releaseConnection();
        }
        return jsonObject;
    }


    public static String getHost() {
        return host;
    }

    public static void setHost(String host) {
        HttpSend.host = host;
    }

}
