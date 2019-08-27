package com.bylz.quantumCloud.education.util.wechat;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

import javax.net.ssl.SSLContext;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.UriComponentsBuilder;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.likegene.framework.core.SpringBeanUtil;
import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.model.QcodeWeChatEventRequest;
import com.bylz.quantumCloud.model.SysConfig;
import com.bylz.quantumCloud.education.util.DateUtils;
import com.bylz.quantumCloud.education.util.HttpUtils;
import com.bylz.quantumCloud.service.QcodeWeChatEventRequestService;
import com.bylz.quantumCloud.service.SysConfigService;

public class WeChatUtils {
	private static final Logger logger = LoggerFactory.getLogger(WeChatUtils.class);
	private static QcodeWeChatEventRequestService  qcodeWeChatEventRequestService = SpringBeanUtil.getBean("qcodeWeChatEventRequestService");
	private static SysConfigService  sysConfigService = SpringBeanUtil.getBean("sysConfigService");
	//获取accessToken的间隔时间   单位：分钟，不可大于120
	private static int accessTokenRefreshTime =  SettingUtil.getSetting("accessTokenRefreshTime", Integer.class);
	
	private  SendRedPack  sendRedPack;
	
	/**
	 * 初始化的时候把一些配置加载进来，获取配置文件的数据。
	 * 注意：如果是批量发送红包，mch_billno（商户订单号）一定不能够重复，否则就会报“更换了openid，但商户单号未更新”
	 * */
	public WeChatUtils(){
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String str = sdf.format(date);
        
        sendRedPack = new SendRedPack();
        sendRedPack.setNonce_str(UUID.randomUUID().toString().replace("-", ""));
        sendRedPack.setMch_id(SettingUtil.getSetting("mch_id", String.class));
        sendRedPack.setMch_billno(new StringBuffer(SettingUtil.getSetting("mch_id", String.class)).append(str).append(new Random().nextInt(10)).toString());
        sendRedPack.setWxappid(SettingUtil.getSetting("wxappid", String.class));
        sendRedPack.setSend_name(SettingUtil.getSetting("send_name", String.class));
        sendRedPack.setTotal_num(SettingUtil.getSetting("total_num", Integer.class));
        sendRedPack.setWishing(SettingUtil.getSetting("wishing", String.class));
        sendRedPack.setAct_name(SettingUtil.getSetting("act_name", String.class));
        sendRedPack.setRemark(SettingUtil.getSetting("remark", String.class));
        sendRedPack.setClient_ip(SettingUtil.getSetting("client_ip", String.class));
    }
	
	/**
     * 发送普通现金红包，不使用场景     
     * @param re_openid 接受红包的用户 ,用户在wxappid下的openid
     * @param total_amount 付款金额，单位分
     * @return Map<String, String>  
     * @throws
     */
    public  Map<String, String> sendRedPack(String re_openid, int total_amount) throws Exception{
        sendRedPack.setRe_openid(re_openid);
        sendRedPack.setTotal_amount(total_amount);
        String sign = createSendRedPackOrderSign(sendRedPack);
        sendRedPack.setSign(sign);
        
        XMLUtil xmlUtil= new XMLUtil();
        xmlUtil.xstream().alias("xml", sendRedPack.getClass());
        String xml = xmlUtil.xstream().toXML(sendRedPack);
        String response = ssl(SettingUtil.getSetting("SENDEEDPACKURL", String.class), xml);
        Map<String, String> map = xmlUtil.parseXml(response);
        return map;
    }
    
    
    /**
     * 发送现金红包，使用场景     
     * @param re_openid 接受红包的用户 ,用户在wxappid下的openid
     * @param total_amount 付款金额，单位分
     * @return Map<String, String>  
     * @throws
     */
    public  Map<String, String> sendRedPack(String re_openid, int total_amount ,String scene_id) throws Exception{
        sendRedPack.setRe_openid(re_openid);
        sendRedPack.setTotal_amount(total_amount);
        sendRedPack.setScene_id(scene_id);        
        String sign = createSendRedPackOrderSign(sendRedPack);
        sendRedPack.setSign(sign);
        XMLUtil xmlUtil= new XMLUtil();
        xmlUtil.xstream().alias("xml", sendRedPack.getClass());
        String xml = xmlUtil.xstream().toXML(sendRedPack);
        String response = ssl(SettingUtil.getSetting("SENDEEDPACKURL", String.class), xml);
        Map<String, String> map = xmlUtil.parseXml(response);
        return map;
    }
    
    /**
     * 生成签名
     * */
    private String createSendRedPackOrderSign(SendRedPack redPack){
    	//重点：以下非空参数值的参数按照参数名ASCII码从小到大排序（字典序）
        StringBuffer sign = new StringBuffer();
       if(redPack.getAct_name() != null) 
    	   sign.append("act_name=").append(redPack.getAct_name());
       if(redPack.getClient_ip() != null) 
        sign.append("&client_ip=").append(redPack.getClient_ip());
       if(redPack.getMch_billno() != null) 
    	   sign.append("&mch_billno=").append(redPack.getMch_billno());
       if(redPack.getMch_id() != null) 
    	   sign.append("&mch_id=").append(redPack.getMch_id());
       if(redPack.getNonce_str() != null) 
    	   sign.append("&nonce_str=").append(redPack.getNonce_str());
       if(redPack.getRe_openid() != null) 
    	   sign.append("&re_openid=").append(redPack.getRe_openid());
       if(redPack.getRemark() != null) 
    	   sign.append("&remark=").append(redPack.getRemark());
       if(redPack.getScene_id() != null) 
    	   sign.append("&scene_id=").append(redPack.getScene_id());
       if(redPack.getSend_name() != null) 
    	   sign.append("&send_name=").append(redPack.getSend_name());
       if(redPack.getTotal_amount() >= 0) 
    	   sign.append("&total_amount=").append(redPack.getTotal_amount());
       if(redPack.getTotal_num() >= 0) 
    	   sign.append("&total_num=").append(redPack.getTotal_num());
       if(redPack.getWishing() != null) 
    	   sign.append("&wishing=").append(redPack.getWishing());
       if(redPack.getWxappid() != null) 
    	   sign.append("&wxappid=").append(redPack.getWxappid());
       String  key = SettingUtil.getSetting("key", String.class);
       if(key != null) 
    	   sign.append("&key=").append(key);
        return DigestUtils.md5Hex(sign.toString()).toUpperCase();
    }
    
    /**
     * 发送请求
     * */
    private String ssl(String url,String data){
        StringBuffer message = new StringBuffer();
        try {
            String mchId = SettingUtil.getSetting("mch_id", String.class) ;
            KeyStore keyStore  = KeyStore.getInstance("PKCS12");
            String certFilePath = SettingUtil.getSetting("certFilePath", String.class) ;//账户安全证书的位置
            FileInputStream instream = new FileInputStream(new File(certFilePath));
            keyStore.load(instream, mchId.toCharArray());
            SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, mchId.toCharArray()).build();
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null, SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
            CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
            HttpPost httpost = new HttpPost(url);
            httpost.addHeader("Connection", "keep-alive");
            httpost.addHeader("Accept", "*/*");
            httpost.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            httpost.addHeader("Host", "api.mch.weixin.qq.com");
            httpost.addHeader("X-Requested-With", "XMLHttpRequest");
            httpost.addHeader("Cache-Control", "max-age=0");
            httpost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
            httpost.setEntity(new StringEntity(data, "UTF-8"));
//            System.out.println("executing request" + httpost.getRequestLine());
            CloseableHttpResponse response = httpclient.execute(httpost);
            try {
                HttpEntity entity = response.getEntity();
//                System.out.println(response.getStatusLine());
                if (entity != null) {
//                    System.out.println("Response content length: " + entity.getContentLength());
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                    String text;
                    while ((text = bufferedReader.readLine()) != null) {
                        message.append(text);
                    }
                }
                EntityUtils.consume(entity);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                response.close();
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } 
//        System.out.println("微信红包结果："+message.toString());
        return message.toString();
    }
    
    public static String getAccessTokenCheckCache(){
    	
    	String grantType = SettingUtil.getSetting("grantType", String.class);
    	String appId = SettingUtil.getSetting("appId", String.class);
    	String secret = SettingUtil.getSetting("secret", String.class);
    	String access_token = WeChatUtils.getAccessTokenCheckCache(grantType, appId, secret); 
    	return access_token;
    }
    
    
    /**
     * 获取access_token 检查是否过期
     * @param grantType 获取access_token填写client_credential
     * @param  APPID 第三方用户唯一凭证
     * @param  secret 第三方用户唯一凭证密钥，即appsecret
     * */
    public synchronized static String getAccessTokenCheckCache(String grantType,String appId,String secret){
    	String accessToken = null;
    	String accessTokenResult = null ;
    	String keyName = new StringBuffer().append(grantType).append(appId).append(secret).toString();
    	
    	QueryFilter filter = new QueryFilter();
    	filter.put("keyName", keyName);
    	filter.put("category",SysConfig.WECHATACCESSTOKEN);
    	SysConfig sysConfig = sysConfigService.findOne(filter).getReturnObj();
    	if(sysConfig != null){//数据库已经存入
    		String accessTokenAndCreatTime = sysConfig.getVal();
    		String createTimeString = accessTokenAndCreatTime.substring(accessTokenAndCreatTime.indexOf("|")+1, accessTokenAndCreatTime.length());
    		Date createTime = null;
			try {
				createTime = new SimpleDateFormat("EEE MMM dd HH:mm:ss Z yyyy", Locale.UK).parse(createTimeString);
				long betweenMinutes = DateUtils.getBetweenSeconds(createTime,new Date())/60; //两个时间间隔分钟
	      	    if( betweenMinutes <= accessTokenRefreshTime){  //时间间隔未到指定时间，可以不重新获取
	      	    	accessTokenResult = accessTokenAndCreatTime.substring(0, accessTokenAndCreatTime.indexOf("|"));
					System.out.println("-------------------------------------------"+accessTokenResult+"-----------------------------------------------");
	      	    }else{//超过时间间隔，重新获取并更新
		      	  	accessTokenResult = getAccessToken(grantType,appId,secret);
					System.out.println("-------------------------------------------"+accessTokenResult+"-----------------------------------------------");
					String value = new StringBuffer().append(accessTokenResult).append("|").append(new Date().toString()).toString();
					filter = new QueryFilter();
					filter.put("keyname", keyName);
					filter.put("category", SysConfig.WECHATACCESSTOKEN);
					filter.put("val", value);
					filter.setStatementKey(SysConfigService.UPDATE_BY_KEYNAME_AND_CATEGROY);
					sysConfigService.update(filter);
	      	    }
			} catch (ParseException e) {//时间格式转换失败的处理
				accessTokenResult = getAccessTokenResultAndSave(grantType,appId,secret);
			}
    	}else{//数据库中没有，获取并存于数据库
    		accessTokenResult = getAccessTokenResultAndSave(grantType,appId,secret);
    	}
    	
    	JSONObject access_token_result_json = JSONObject.parseObject(accessTokenResult);
    	accessToken = (String) access_token_result_json.get("access_token");
		System.out.println("-------------------------------------------"+accessToken+"-----------------------------------------------");
		return accessToken;
    }
    /**
     * 获取access_token 
     * 并存入  格式为：  access_token|createTime
     * @return accessTokenResult
     * */
    private static String getAccessTokenResultAndSave( final String grantType,final String appId,final String secret){
    	final String keyName = new StringBuffer().append(grantType).append(appId).append(secret).toString();
    	String accessTokenResult = getAccessToken(grantType,appId,secret);
    	String value = new StringBuffer().append(accessTokenResult).append("|").append(new Date().toString()).toString();
    	SysConfig sysConfig = new SysConfig();
    	sysConfig.setKeyname(keyName);
    	sysConfig.setVal(value);
    	sysConfig.setCategory(SysConfig.WECHATACCESSTOKEN);
    	sysConfig.setOrderNo(1);
    	sysConfig.setCategoryDesc("微信公众号AccessToken");
    	sysConfig.setDescn("微信公众号AccessToken ;格式为： access_token|createTime");
    	Result sysConfigResult = sysConfigService.save(sysConfig);
    	if (!sysConfigResult.isSuccess()) { 
    		logger.error("存入微信公众号AccessToken，失败："+sysConfigResult.getErrormsg());
        }else{
//        	Timer timer = new Timer(false);
//        	timer.schedule(new TimerTask() {
//				
//				@Override
//				public void run() {
//					//定时更新AccessToken
//					String accessTokenResult = getAccessToken(grantType,appId,secret);
//			    	String value = new StringBuffer().append(accessTokenResult).append("|").append(new Date().toString()).toString();
//					QueryFilter filter = new QueryFilter();
//					filter.put("keyname", keyName);
//					filter.put("category", SysConfig.WECHATACCESSTOKEN);
//					filter.put("val", value);
//					filter.setStatementKey(SysConfigService.UPDATE_BY_KEYNAME_AND_CATEGROY);
//					sysConfigService.update(filter);
//					logger.info("定时更新微信公众号AccessToken已完成");
//				}
//			},accessTokenRefreshTime*60*1000,accessTokenRefreshTime*60*1000);
        }
    	 return accessTokenResult;
    }
    
    /**
     * 获取access_token
     * @param grantType 获取access_token填写client_credential
     * @param  appId 第三方用户唯一凭证
     * @param  secret 第三方用户唯一凭证密钥，即appsecret
     * */
    public static String getAccessToken(String grantType,String appId,String secret){
    	String url = SettingUtil.getSetting("getAccessTokenUrl", String.class);
    	Map<String, String> params  = new HashMap<String, String>();
    	params.put("grant_type", grantType);
    	params.put("appid", appId);
    	params.put("secret", secret);
    	String response = null;;
		try {
			response = HttpUtils.sendGet(url, params);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return response;
    }
    
    
    /**
     *  生成临时ticket
     *  @param accessToken access_token是公众号的全局唯一接口调用凭据，公众号调用各接口时都需使用access_token
     *  @param sceneId 场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
     *  @param account 该二维码有效时间，以秒为单位。 最大不超过2592000（即30天），此字段如果不填，则默认有效期为30秒。
     * */
    public static String getTemporaryQRCodeTicket(String accessToken, String sceneId ,Long account){
    	String url = SettingUtil.getSetting("getQRCodeTicketUrl", String.class)+accessToken;
    	String jsonStr = "{\"expire_seconds\": "+account+", \"action_name\": \"QR_SCENE\", \"action_info\":{\"scene\": {\"scene_id\":"+sceneId+"}}}";
//    	Object parse = JSON.parse(jsonStr);
    	String response = HttpUtils.sendPost(url,jsonStr);
    	return response;
    }
    
    
    /**
     *  生成永久二维码ticket
     *  @param accessToken access_token是公众号的全局唯一接口调用凭据，公众号调用各接口时都需使用access_token
     *  @param sceneId 场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
     *  @param account 该二维码有效时间，以秒为单位。 最大不超过2592000（即30天），此字段如果不填，则默认有效期为30秒。
     * */
    public static String getForeverQRCodeTicket(String accessToken, String sceneId ){
    	String url = SettingUtil.getSetting("getQRCodeTicketUrl", String.class)+accessToken;
    	String jsonStr = "{\"action_name\":\"QR_LIMIT_SCENE\",\"action_info\":{\"scene\":{\"scene_id\":"+sceneId+"}}}";
    	String response = HttpUtils.sendPost(url,jsonStr);
    	return response;
    }
    
    /**获取微信公众号带参二维码
     * @param sceneId 场景值ID，临时二维码时为32位非0整型，永久二维码时最大值为100000（目前参数只支持1--100000）
     * */
    public static String getQRCodeTicket( long sceneId ){
    	String sceneIdString = Long.toBinaryString(sceneId);
    	String ticket = null;
    	String access_token  = WeChatUtils.getAccessTokenCheckCache(); 
     	if(access_token != null){
     		// 获取ticket 开始
     		String qrCodeTicketResult = null;
     		long expire_seconds = SettingUtil.getSetting("expire_seconds", Long.class);
     		if( expire_seconds != 0){
     			qrCodeTicketResult = WeChatUtils.getTemporaryQRCodeTicket(access_token, sceneIdString,expire_seconds);//临时二维码
     		}else{
     			qrCodeTicketResult = WeChatUtils.getForeverQRCodeTicket(access_token, sceneIdString);//永久二维码
     		}
        	JSONObject qrCodeResultJson = JSONObject.parseObject(qrCodeTicketResult);
        	ticket = (String) qrCodeResultJson.get("ticket");
     	}else{
     		logger.error("获取微信 access_token 失败 请检查 ，错误信息如下：");
     	}
     	return ticket;
    }
    /***
     * 开发者通过检验signature对请求进行校验
     */
    public static boolean checkSignature(Map<String, Object> paramsMap,String signature){
			String timestamp = (String) paramsMap.get("timestamp");
			String nonce = (String) paramsMap.get("nonce");
			return	SignatureUtil.checkSignature(signature,timestamp,nonce);
    }
    
    /***
     * 开发者通过检验signature对请求进行校验
     */
    public static boolean checkSignature(Map<String, Object> paramsMap){
    	try{
    		String timestamp =  (String) paramsMap.get("timestamp");
    		String nonce =  (String) paramsMap.get("nonce");
    		String signature =  (String) paramsMap.get("signature");
        	return	SignatureUtil.checkSignature(signature,timestamp,nonce);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return	false;
    }
    
//    public static boolean isWeChatEventRepeat(String fromUserName,Date createTime){
//    	boolean isRepeat = false ;
//    	String cacheKey = fromUserName+createTime;
//    	if(RedisTemplateUtil.exists(cacheKey)){//缓存中存有  正式上线时释放被注释的代码
//    		isRepeat = true ;
//    	}else{
////    		RedisTemplateUtil.set(cacheKey, cacheKey);	//跟随缓存服务器的一个运行时间
//    		RedisTemplateUtil.set(cacheKey, cacheKey,15L);//缓存30秒	
//    	}
//    	return isRepeat ;
//    }
    
    
    public static boolean isWeChatEventRepeat(String fromUserName,String createTime){
    	synchronized (WeChatUtils.class) {
//    		logger.debug("检查重复请求*****"+fromUserName+createTime+"*******");
    		QueryFilter filter = new QueryFilter();
        	filter.put("uniqueIdentification", fromUserName+createTime);
        	QcodeWeChatEventRequest qcodeWeChatEventRequest = qcodeWeChatEventRequestService.findOne(filter).getReturnObj();
        	if(qcodeWeChatEventRequest != null){
        		return true;
        	}else{
        		qcodeWeChatEventRequestService.save(filter);
        		destroyWeChatEventRepeatFlag(fromUserName,createTime,15000);
        	}
        	return false;
		}
    }
    /**
     * 删除微信事件重复请求的标识
     * @param fromUserName
     * @param createTime
     * @param delay 经过delay(ms)后开始进行调度，仅仅调度一次。
     * */
    public static void destroyWeChatEventRepeatFlag(final String fromUserName,final String createTime,long delay){
    	Timer timer = new Timer();
    	timer.schedule(new TimerTask() {
    	        public void run() {
    	        	logger.debug("定时器清除微信事件请求表中unique_identification="+fromUserName+createTime+"数据工作开始************");
    	        	QueryFilter filter = new QueryFilter();
    	        	filter.put("uniqueIdentification", fromUserName+createTime);
    	        	qcodeWeChatEventRequestService.delete(filter);
    	        	logger.debug("定时器清除微信事件请求表中unique_identification="+fromUserName+createTime+"数据工作结束************");
    	        }
    	} , delay);
    	
    }
    
    public static  int getRedPackTotalAmount(){
    	Double percentageRandom = MathRandom.percentageRandom();
    	if(percentageRandom != null){
    		percentageRandom = percentageRandom *100; //因为在微信接口中金额以 分 为单位，这里将  元 转换为 分
    		String percentageRandomString = percentageRandom.toString();
    		return Integer.valueOf(percentageRandomString.substring(0, percentageRandomString.indexOf(".")));
    	}
    	return 0;  
    }
    
    /**获取微信用户信息
     * @param openId
     * @return {@link JSONObject}  这方法将请求返回的tagid_list（用户被打上的标签ID列表）的内容转换过程中丢失
     * */
    public static JSONObject getWeChatUserInfo(String openId){
    	JSONObject jsonResult = null;
    	String weChatUserInfoUrl = SettingUtil.getSetting("weChatUserInfoUrl", String.class);
    	Map<String, String > paramsMap = new HashMap<>();
    	paramsMap.put("access_token", getAccessTokenCheckCache());
    	paramsMap.put("lang", "zh_CN");
       	paramsMap.put("openid", openId);
       	try {
			String resultJsonStr = HttpUtils.sendGet(weChatUserInfoUrl, paramsMap);
			jsonResult = JSONObject.parseObject(resultJsonStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return jsonResult;
    }
    
    /***
     * 客服接口-发消息
     * 关注订阅号提示
     * */
    
    public static void customerSendImgMessag( String openId,UriComponentsBuilder uribuilder){
    	
    	String url = SettingUtil.getSetting("customUrl", String.class)+""+getAccessTokenCheckCache();
    	Map<String,Object> paramsMap = new HashMap<>();
    	paramsMap.put("touser", openId);
    	paramsMap.put("msgtype", "news");
    	List<Map<String, Object>> articles = new LinkedList<>();
    	Map<String , Object> article = new HashMap<>();
    	article.put("title", SettingUtil.getSetting("title", String.class));
    	article.put("description", SettingUtil.getSetting("description", String.class));
    	
    	URI hostUrl = uribuilder.build().toUri();
    	String customToUrl = SettingUtil.getSetting("customToUrl", String.class);
    	customToUrl = hostUrl.toString()+customToUrl;
    	String picLocation = SettingUtil.getSetting("picLocation", String.class);
    	String picUrl = hostUrl.toString()+picLocation;
    	
    	article.put("url", customToUrl);
//    	article.put("url", "http://127.0.0.1:4630/assets/images/originDYH.jpg");
//    	article.put("picurl", picUrl);
//    	article.put("picurl", "http://192.168.1.104:4630"+SettingUtil.getSetting("picLocation", String.class));
    	articles.add(article);
    	Map<String , Object> news = new HashMap<>();
    	news.put("articles", articles);
    	paramsMap.put("news", news);
    	
    	Object json = JSONObject.toJSON(paramsMap);
//    	System.out.println(json.toString());
    	String response = HttpUtils.sendPost(url,json.toString());
//    	System.out.println(response.toString());
    }
    
    
    /**
     * 微信登录
     * 第一步：用户同意授权，获取code(引导关注者打开如下页面：)
     * 获取 code、state
     * @throws UnsupportedEncodingException 
     */
     public static String getStartURLToGetCode()  {
	    String takenUrl = "https://open.weixin.qq.com/connect/qrconnect?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";
	    takenUrl= takenUrl.replace("APPID", SettingUtil.getSetting("AppID", String.class));
		try {
			takenUrl = takenUrl.replace("REDIRECT_URI",
					URLEncoder.encode(SettingUtil.getSetting("Redirect_URI", String.class), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			logger.error(e.getMessage());
		}
	     
	     //FIXME ： snsapi_login
	     takenUrl= takenUrl.replace("SCOPE", "snsapi_login");
	     System.out.println(takenUrl);
	     return takenUrl;
     }
     
     
     /**
      * 微信登录
      * 获取access_token、openid
      * 第二步：通过code获取access_token
      * @param code url = "https://api.weixin.qq.com/sns/oauth2/access_token
      *   ?appid=APPID
      *   &secret=SECRET
      *   &code=CODE
      *   &grant_type=authorization_code"
      * */
      public static OAuthInfo getAccess_token(String code){
      
	      String authUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code ";
	      authUrl= authUrl.replace("APPID",  SettingUtil.getSetting("AppID", String.class));
	      authUrl = authUrl.replace("SECRET", SettingUtil.getSetting("AppSecret", String.class));
	      authUrl = authUrl.replace("CODE", code);
	      String jsonString = HttpUtils.sendPost(authUrl,"");
	      System.out.println("jsonString: " + jsonString);
	      OAuthInfo auth = null;
	      try {
	       auth = (OAuthInfo) JSON.parseObject(jsonString, OAuthInfo.class);
	      } catch (Exception e) {
	    	logger.error(e.getMessage());
	      }
	      return auth;
      }
      
      /**
       * 微信登录
       * 获取用户基本信息
       * 第三步：通过access_token ，openId获取userInfo
       * @param code url = "https://api.weixin.qq.com/sns/userinfo
       * 	?access_token=ACCESS_TOKEN&openid=OPENID
       * */
	  public static WechatUserInfoBean getWeChatUserInfo(String accessToken ,String openId){
       
 	      String userInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
 	      userInfoUrl= userInfoUrl.replace("ACCESS_TOKEN",  accessToken);
 	      userInfoUrl= userInfoUrl.replace("OPENID",  openId);
 	      
 	      String jsonString;	
 	      WechatUserInfoBean  wechatUserInfo = null;
			try {
				jsonString = HttpUtils.sendGet(userInfoUrl,new HashMap<String, String>());
				System.out.println("jsonString: " + jsonString);
				wechatUserInfo = (WechatUserInfoBean) JSON.parseObject(jsonString, WechatUserInfoBean.class);
			} catch (Exception e) {
				logger.error(e.getMessage());
			}
			
 	      return wechatUserInfo;
       }
}
