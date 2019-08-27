package com.bylz.quantumCloud.education.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

import com.alibaba.fastjson.JSONObject;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.model.QcodeRedPacket;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.wechat.MathRandom;
import com.bylz.quantumCloud.education.util.wechat.SendRedPack;
import com.bylz.quantumCloud.education.util.wechat.WeChatEvent;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.bylz.quantumCloud.education.util.wechat.XMLUtil;
import com.bylz.quantumCloud.service.QcodeRedPacketService;
import com.bylz.quantumCloud.service.QcodeUserService;

@Controller
@RequestMapping("/api")
public class WeChatController extends BaseController {
	@Autowired
	private QcodeRedPacketService qcodeRedPacketService;
	@Autowired
	private QcodeUserService qcodeUserService;
  
   /**
     * 生成红包概率随机数据
     * 
     * **/
    @RequestMapping("/createRandom.json")
    @ResponseBody
    public String createRandom(ModelMap model){
    	MathRandom.insertRandom();
    	return "生成红包概率随机数据结束，请查看数据库";
    }
    
    /**
     * 生成二维码
     * @return 二维码的链接
     * **/
    @RequestMapping("/QRCode")
    @ResponseBody
    public String getQRCode(){
    	QcodeUser qcodeUser = AppContextHolder.getCurrentUser();
    	return  SettingUtil.getSetting("showqrcode", String.class)+ WeChatUtils.getQRCodeTicket(qcodeUser.getId());
    }
    
    /**
     * 微信认证
     * */
    @RequestMapping(value="/weChatEvent" ,method=RequestMethod.GET)
    @ResponseBody
    public String weChatEvent(HttpServletRequest request ){
    	Map<String, Object> paramsMap;
		try {
			paramsMap = XMLUtil.getParams(request);
			/*验证消息的确来自微信服务器 开始*/
			if(HttpMethod.GET.toString().equals(request.getMethod())){
				Object echostr = paramsMap.get("echostr");
				if( WeChatUtils.checkSignature(paramsMap) && echostr != null){
					return (String) echostr;
				}	
			}
			/* 验证消息的确来自微信服务器  结束*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
    }
    
    
    /**
     * 微信事件的处理
     * */
    @RequestMapping(value="/weChatEvent" ,method=RequestMethod.POST)
    @ResponseBody
    public String weChatEvent(HttpServletRequest request,HttpServletResponse response ,UriComponentsBuilder uribuilder){
    	
    	String reason= null;
		try {
			Map<Object, Object>  paramsMap = XMLUtil.parseXml(request);
			String toUserName = (String) paramsMap.get("ToUserName");
	    	String fromUserName = (String) paramsMap.get("FromUserName");
	    	Object CreateTime = paramsMap.get("CreateTime");
//	    	Date createTime = new Date((Integer.valueOf((String) CreateTime)));
	    	if( WeChatUtils.isWeChatEventRepeat(fromUserName,(String)CreateTime)){
	    		//微信重复请求的处理
	    		return "";//返回空串微信服务器不会对此作任何处理，并且不会发起重试。
	    	}
	    	String msgType = (String) paramsMap.get("MsgType");
	    	String event = (String) paramsMap.get("Event");
	    	String eventKey = (String) paramsMap.get("EventKey");
	    	String ticket = (String) paramsMap.get("Ticket");
	    	switch (msgType) {
			case WeChatEvent.MSGTYPE_EVENT://事件推送
				{
					switch (event) {
					case WeChatEvent.EVENT_SUBSCRIBE: //扫描带参数二维码事件 ，用户未关注时，进行关注后的事件推送
						{
							WeChatUtils.customerSendImgMessag(fromUserName,uribuilder );//发送订阅号提示
							String qcodeUserIdBinaryString = eventKey.replace("qrscene_", "");
							Long qcodeUserId = Long.valueOf(qcodeUserIdBinaryString,2); 
							Map<String, Object> sendRedPackAndRecordResultMap = sendRedPackAndRecord(fromUserName,qcodeUserId);//发送现金红包
//							reason = getRedPackFailReason(sendRedPackAndRecordResultMap);
						}
						break;
					case WeChatEvent.EVENT_SCAN: //扫描带参数二维码事件，用户已关注时的事件推送 
						{
							String qcodeUserIdBinaryString = eventKey.replace("qrscene_", "");
							Long qcodeUserId = Long.valueOf(qcodeUserIdBinaryString,2);
							Map<String, Object> sendRedPackAndRecordResultMap = sendRedPackAndRecord(fromUserName,qcodeUserId);
//							reason = getRedPackFailReason(sendRedPackAndRecordResultMap);
						}
					break;

					default:
						break;
					}
					
				}
				break;

			default:
				break;
			}
	    	
		} catch (Exception e) {
			e.printStackTrace();
		}
//		logger.info("微信事件处理结束"+reason);
		return "";//返回空串微信服务器不会对此作任何处理。
    }
    
    
    
    /**
	 * 是否能够发送红包并记录
	 * @param openId 微信openId
	 * @param userId 用户Id
	 * @return Map 中 isSuccess 标识是否发送成功，reason 标识发送结果或 不可发送的原因
	 * */
    private 	Map<String, Object>  sendRedPackAndRecord( String openId ,long userId){
    	Map<String, Object> sendRedPackAndRecordResultMap = new HashMap<>();
    	boolean isSuccess = false ;
    	String reason = null ; 
    	synchronized (WeChatController.class) {
    		Map<String, Object> hadSendRedPacketMap = qcodeRedPacketService.hadSendRedPacket(openId, userId);
        	if(!((boolean)hadSendRedPacketMap.get("status"))){//没有发过红包
        		QueryFilter filter = new QueryFilter();
        		filter.put("id", userId);
        		filter.put("deleted", QcodeUser.DELETED_NO);
        		filter.put("isDisable", QcodeUser.IS_DISABLE_NO);
        		QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
        		if(qcodeUser != null){//未删除，未被禁用的账号可领取红包
        			//开始发红包
        			int moneny = WeChatUtils.getRedPackTotalAmount();
        			WeChatUtils weChatUtils = new WeChatUtils();
        			Map<String, String> sendRedPackResultMap = null;
        			try {
        				sendRedPackResultMap = weChatUtils.sendRedPack(openId,moneny,SendRedPack.SCENE_ID_PRODUCT_4);
        				boolean communicationReturnCode = "SUCCESS".equals(sendRedPackResultMap.get("return_code"));//通信结果标识
        				boolean tradeResultCode = "SUCCESS".equals(sendRedPackResultMap.get("result_code"));//交易结果标识
        				String returnMsg = sendRedPackResultMap.get("return_msg");
        				QcodeRedPacket qcodeRedPacket = new QcodeRedPacket();
        				qcodeRedPacket.setOpenId(openId);
        				qcodeRedPacket.setUserId(userId);
        				qcodeRedPacket.setUserName(qcodeUser.getName());
        				qcodeRedPacket.setUserMail(qcodeUser.getEmail());
        				JSONObject WeChatUserInfoJson = WeChatUtils.getWeChatUserInfo(openId);
        				String nickname = WeChatUserInfoJson.getString("nickname");
        				qcodeRedPacket.setWechatName(nickname);
        				if(communicationReturnCode){//通信成功
        					if(tradeResultCode){//交易成功
        						qcodeRedPacket.setStatus(QcodeRedPacket.STATUS_SUCCESS);
        					}else{
        						logger.error("红包发送失败，请尽快检查："+returnMsg);
        						qcodeRedPacket.setStatus(QcodeRedPacket.STATUS_FAIL);
        					}
        				}else{
        					logger.error("红包发送失败，请尽快检查："+returnMsg);
        					qcodeRedPacket.setStatus(QcodeRedPacket.STATUS_FAIL);
        				}
        				qcodeRedPacket.setReason(returnMsg);
        				qcodeRedPacket.setMoneny(((double)moneny)/100);
        				qcodeRedPacket.setCreateTime(new Date());
        				Result result =  qcodeRedPacketService.save(qcodeRedPacket);
        			    if (!result.isSuccess()) {
        			    	logger.error("红包发送记录保存失败，请尽快检查");
        			    	//记录保存失败的处理
        		        }
        				isSuccess = communicationReturnCode ;
        				reason = returnMsg;
        			} catch (Exception e) {
        				e.printStackTrace();
        			}
        		}else{
        			isSuccess = false ;
        			reason = new StringBuffer().append(" 该量子云用户(id为").append(userId).append(")被删除或被禁用，请检查").toString();
        			logger.info(reason);
        		}
    		}else{//已经发过红包
    			isSuccess = false ;
    			reason = (String) hadSendRedPacketMap.get("reason");
    		}
        	sendRedPackAndRecordResultMap.put("isSuccess", isSuccess);
        	sendRedPackAndRecordResultMap.put("reason", reason);
		}
		return sendRedPackAndRecordResultMap;
    }
     
    /*
     * 获取发送红包失败的信息
     * 发送成功返回 null
     * 发送失败或不可发送 ，返回原因
     * */
    private String getRedPackFailReason(Map<String, Object> sendRedPackAndRecordResultMap){
    	String reason = null;
    	boolean	isSuccess =	(boolean)sendRedPackAndRecordResultMap.get("isSuccess");
		if(!isSuccess){
			reason = (String) sendRedPackAndRecordResultMap.get("reason");
//			System.out.println("红包发送失败的原因： "+reason);
		}
		return reason;
    } 
}
