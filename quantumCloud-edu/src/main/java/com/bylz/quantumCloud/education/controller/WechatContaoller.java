package com.bylz.quantumCloud.education.controller;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.bylz.quantumCloud.education.util.HttpUtils;
import com.bylz.quantumCloud.education.util.wechat.JsAPI;
import com.bylz.quantumCloud.education.util.wechat.SignatureUtil;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.likegene.framework.util.SettingUtil;

@Controller
@RequestMapping("/Wechat")
public class WechatContaoller extends BaseController {
	
	
	
	/**
	 * 微信分享获取jsapi接口
	 * @author songhaozhang
	 * @since 2019.3.19
	 * @return jsapi类
	 **/
    @RequestMapping(value = "/ShareLearning.json")
    @ResponseBody
    public ResponseData test(ModelMap model, HttpServletRequest request) {
        ResponseData data=new ResponseData(true);    
    	String grantType = SettingUtil.getSetting("grantType", String.class);
    	String appId = "wx3f7f69bcfbe19950";
    	String secret = "9dc0f19e0c5dd7e5037252044769a7b9";
    	String access_token = WeChatUtils.getAccessTokenCheckCache(grantType, appId, secret); 
        //String access_token=WeChatUtils.getAccessTokenCheckCache();
        logger.info("access_token"+access_token);
        //使用access_token获取jsapi_ticket
        //请求地址https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi
		String authUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
		authUrl= authUrl.replace("ACCESS_TOKEN", access_token);
		String jsonString = HttpUtils.sendPost(authUrl,"");
		System.out.println("jsonString: " + jsonString);
		JsAPI jsapi = null;
		try {
			jsapi = (JsAPI) JSON.parseObject(jsonString, JsAPI.class);
		} catch (Exception e) {
		logger.error(e.getMessage());
		}
	    //签名
		//随机字符串，暂定10位随机字符串
        String noncestr=SignatureUtil.noncestrGenerate(10);
        jsapi.setNoncestr(noncestr);
        jsapi.setAppid(appId);
        //使用用户id查询用户学习信息，如果学习信息为空，返回学习天数为0天
        //model.put("noncestr", noncestr);
        //System.out.println("noncestr"+noncestr);
        data.setObj(jsapi);        
        
        //返回分享页
        return data;
    }
    
    
   
  
}
