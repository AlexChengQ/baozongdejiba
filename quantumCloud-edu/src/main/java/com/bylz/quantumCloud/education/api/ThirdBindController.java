package com.bylz.quantumCloud.education.api;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.*;
import com.bylz.quantumCloud.education.util.bingemail.BingEmailUtil;
import com.bylz.quantumCloud.education.util.sms.SmsValidatorHelper;
import com.bylz.quantumCloud.education.util.wechat.OAuthInfo;
import com.bylz.quantumCloud.education.util.wechat.WeChatUtils;
import com.bylz.quantumCloud.education.util.wechat.WechatUserInfoBean;
import com.bylz.quantumCloud.model.*;
import com.bylz.quantumCloud.service.*;
import com.likegene.framework.core.QueryFilter;
import com.likegene.framework.core.Result;
import com.likegene.framework.util.SettingUtil;

import freemarker.template.TemplateException;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.servlet.http.HttpServletRequest;

import java.io.*;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * QCode Controller
 *
 */
@Controller
@RequestMapping("/api/ThirdBind")
public class ThirdBindController extends BaseController {


    @Autowired
    private QcodeUserService qcodeUserService;

	@Autowired
	private QcodeThirdLoginService qcodeThirdLoginService;

	@Autowired
	private SysConfigService sysConfigService;
	@Autowired
	private QcodeProjectService qcodeProjectService;
	@Autowired
	private QcodeProjectVersionService qcodeProjectVersionService;

	@Autowired
	private TemplateSendEmail templateSendEmail;



	/**
	 * app第三方登录
	 * 获取微信个人信息
	 */
	@RequestMapping("/loginByThird.json")
	@ResponseBody
	public ResponseData loginByThird(HttpServletRequest request) {
		// 微信接口自带 2 个参数
		ResponseData data = new ResponseData(true);
		data.setObj("");
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			String appType = map.get("appType") == null ? null : map.get("appType").toString();

			if(appType == null || "".equals(appType)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			String appId = "";
			String face = "";
			String nickName = "";
			if("1".equals(appType)) {
				appId = map.get("openid") == null ? null : map.get("openid").toString();
				face = map.get("iconurl") == null ? null : map.get("iconurl").toString();
				nickName = map.get("name") == null ? null : map.get("name").toString();
			}else if("2".equals(appType)) {
				appId = map.get("appId") == null ? null : map.get("appId").toString();
				face = map.get("face") == null ? null : map.get("face").toString();
				nickName = map.get("nickname") == null ? null : map.get("nickname").toString();
			}else if("3".equals(appType)) {
				appId = map.get("id") == null ? null : map.get("id").toString();
				face = map.get("profileImageUrl") == null ? null : map.get("profileImageUrl").toString();
				nickName = map.get("screenName") == null ? null : map.get("screenName").toString();
			}



			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}

			if (face == null || "".equals(face)) {
				data.setSuccess(false);
				data.setMessage("face_is_not_null");
				return data;
			}
			if (nickName == null || "".equals(nickName)) {
				data.setSuccess(false);
				data.setMessage("nickname_is_not_null");
				return data;
			}


			//微信第三方用户信息
			QcodeThirdLogin qcodeThirdLogin = new QcodeThirdLogin();
			qcodeThirdLogin.setFace(face);
			qcodeThirdLogin.setNickname(nickName);
			qcodeThirdLogin.setAppId(appId);
			// 微信第三方登录检查
			QcodeUser qcodeUser = thirdLoginCheck1(qcodeThirdLogin);


			if (qcodeUser == null) {
				logger.info("尚未绑定账号.....");
				data.setSuccess(false);
				data.setMessage("need_bind_platform");
				if("1".equals(appType)) {
					data.setCode(206);
				}else if("2".equals(appType)) {
					data.setCode(207);
				}else if("3".equals(appType)) {
					data.setCode(208);
				}

				return data;//账号信息绑定
			} else { //模拟登录
				boolean bindWeiBo = bingingThird(qcodeUser.getId(),"3");
				boolean bindQQ = bingingThird(qcodeUser.getId(),"1");
				boolean bindWeixin = bingingThird(qcodeUser.getId(),"2");
				qcodeUser.setBindingPhone(false);
				qcodeUser.setBindingQQ(bindQQ);
				qcodeUser.setBindingWeiXin(bindWeixin);
				qcodeUser.setBindingWeiBo(bindWeiBo);
				data.setSuccess(true);
				data.setObj(qcodeUser);
				return data;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			data.setSuccess(false);
			data.setObj(e);
			return data;
		}
	}



	private boolean bingingThird(Long userId,String appType) {
		QueryFilter filter = new QueryFilter();
		filter.put("userId",userId);
		filter.put("appType",appType);
		filter.setStatementKey("selectList_count");
		int count = qcodeThirdLoginService.findOne(filter).getReturnObj();
		if(count > 0) {
			return true;
		}else {
			return false;
		}
	}




	/**
	 * 第三方用户登录，页面注册保存
	 *
	 * @param request
	 * @return
	 * @throws MessagingException
	 *  2018/3/2 houdongdong
	 */
	@RequestMapping(value = "/thirdRegisterSave1.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData thirdRegisterSave1(HttpServletRequest request){
		ResponseData data = new ResponseData(true);
		data.setObj("");
		// 数据获取
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}
			String email =map.get("email") == null ? null : map.get("email").toString();
			String password = map.get("password") == null ? null : map.get("password").toString();
			String token = map.get("token") ==  null ? null : map.get("token").toString();
			String appType = map.get("appType") ==  null ? null : map.get("appType").toString();
			if(appType == null || "".equals(appType)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			if (token == null || "".equals(token)) {
				data.setSuccess(false);
				data.setMessage("key_is_not_null");
				return data;
			}

			if (email == null || "".equals(email)) {
				data.setSuccess(false);
				data.setMessage("email_is_not_null");
				return data;
			}
			if (password == null || "".equals(password)) {
				data.setSuccess(false);
				data.setMessage("password_is_not_null");
				return data;
			}

			String name = "";
			String appId = "";
			String face = "";

			if("1".equals(appType)) {
				name = map.get("name") == null ? null : map.get("name").toString();
				appId = map.get("openid") ==  null ? null : map.get("openid").toString();
				face = map.get("iconurl") == null ? null : map.get("iconurl").toString();
			}else if("2".equals(appType)) {
				name = map.get("nickname") == null ? null : map.get("nickname").toString();
				appId = map.get("appId") == null ? null : map.get("appId").toString();
				face = map.get("face") == null ? null : map.get("face").toString();
			}else if("3".equals(appType)) {
				name = map.get("screenName") == null ? null : map.get("screenName").toString();
				appId = map.get("id") == null ? null : map.get("id").toString();
				face = map.get("profileImageUrl") == null ? null : map.get("profileImageUrl").toString();
			}


			Result result = new Result();

			QcodeUser qcodeUser = GetUserIdByApikey.getUserId(token);

			QueryFilter filter = new QueryFilter();
			if("4".equals(appType)) {
				filter.put("email",email);
				boolean flag = qcodeThirdLoginService.hasBindThird(filter);
				if(flag) {
					data.setSuccess(false);
					data.setMessage("此邮箱已绑定过，请绑定其他邮箱");
					return data;
				}
				qcodeUser.setEmail(email);
				qcodeUser.setPwd(password);
				qcodeUserService.update(qcodeUser);
				data.setMessage("绑定成功");
				data.setObj(qcodeUser);
				return data;
			}

			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}


			filter.put("appId",appId);
			filter.put("appType",appType);
			QcodeThirdLogin qcodeThirdLoginc = qcodeThirdLoginService.findOne(filter).getReturnObj();

			if(qcodeThirdLoginc != null && qcodeThirdLoginc.getUserId() != null) {
				data.setSuccess(false);
				data.setCode(209);
				data.setMessage("can not repeat bind");
				return data;
			}

			if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
				//验证密码时候一致，一致默认绑定原有账号，不一致提示账号已经注册
				if(password.equals(qcodeUser.getPwd())) {
					if(qcodeThirdLoginc != null && null == qcodeThirdLoginc.getUserId()) {
						qcodeThirdLoginService.updateUserIdByAppId(appId,qcodeUser.getId());
						data.setObj(GetUserIdByApikey.getUserId(token));
						return data;
					}
					//绑定账号
					//创建一条第三方信息
					QcodeThirdLogin qcodeThirdLogin = new QcodeThirdLogin();
					qcodeThirdLogin.setAppId(appId);
					qcodeThirdLogin.setFace(face);
					qcodeThirdLogin.setNickname(name);
					qcodeThirdLogin.setUserId(qcodeUser.getId());
					qcodeThirdLogin.setAppType(Integer.parseInt(appType));
					Result r = qcodeThirdLoginService.save(qcodeThirdLogin);
					if(r.isSuccess()) {
						data.setObj(qcodeUser);
						data.setSuccess(true);
						return data;
					}else {
						data.setMessage("UPDATE_USERINFO_FAILED");
						data.setSuccess(false);
						return data;
					}
				}
				return new ResponseData(false, getMessage("mailbox_has_been_registered"));
			}else {
				if (name == null || "".equals(name)) {
					data.setSuccess(false);
					data.setMessage("nickname_is_not_null");
					return data;
				}
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setEmail(email);
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setToken(apiKey);
				qcodeUserAdd.setPwd(password);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				// 不进行邮箱验证 初始化demo项目和默认项目
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}

				QueryFilter emailFilter1 = new QueryFilter();
				emailFilter1.put("userName", email);
				qcodeUserAdd = qcodeUserService.findOne(emailFilter1).getReturnObj();
				if(!qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUserAdd.getId())) {
					data.setMessage("UPDATE_USERINFO_FAILED");
					data.setSuccess(false);
					return data;
				}
				data.setObj(qcodeUserAdd);
				data.setSuccess(true);
				return data;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			data.setObj(e);
			data.setSuccess(false);
			return data;
		}
	}




    /**
     * 获取http请求参数
     *
     * @since 2018-1-9
     */
    private Map getParams(HttpServletRequest request) throws Exception {
        Enumeration<String> parameterNames = request.getParameterNames();
        Map map = null;
        if (parameterNames.hasMoreElements()) {//Content-Type:application/x-www-form-urlencoded
            map = new HashMap<String, Object>();
            while (parameterNames.hasMoreElements()) {
                String parameterName = (String) parameterNames.nextElement();
                map.put(parameterName, request.getParameter(parameterName));
            }
            return map;
        }

        StringBuilder sb = new StringBuilder();// 非Content-Type:application/x-www-form-urlencoded的处理
        InputStream is = getRequest().getInputStream();
        BufferedInputStream bis = new BufferedInputStream(is);
        byte[] buffer = new byte[1024];
        int read = 0;
        while ((read = bis.read(buffer)) != -1) {
            sb.append(new String(buffer, 0, read, "UTF-8"));
        }

        if (sb != null && !"".equals(sb + "")) {
            try {
                map = JSONObject.parseObject(sb.toString(), Map.class);
            } catch (com.alibaba.fastjson.JSONException e) { //在异常中对taskTyp=xxx&qprog=xxxx&typ=xxx&repeat=xxx&token=xxxx这种数据的处理
                String sbStr = URLDecoder.decode(sb.toString());
                StringBuffer sbStringBuffer = new StringBuffer();
                sbStringBuffer.append("{\"")
                        .append(sbStr.toString().trim().replaceAll("&", "\",\"").replaceAll("=", "\":\""))
                        .append("\"}");
                map = JSONObject.parseObject(sbStringBuffer.toString(), Map.class);
            }
        }
        return map;
    }


    /**
     * 微信用户信息获取
     */
    @RequestMapping("/requestWeChatInfo.json")
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
    public ResponseData requestWeChatInfo(HttpServletRequest request) {
        // 微信接口自带 2 个参数
        ResponseData data = new ResponseData(true);
        data.setObj("");
        
        //获取参数
        Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
	        if (map == null) {
	            data.setSuccess(false);
	            data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
	            return data;
	        }        
			String code =map.get("code") == null ? null : map.get("code").toString();
			String state = map.get("state") == null ? null : map.get("state").toString();			
	        if (code == null || "".equals(code)) {
	            data.setSuccess(false);
	            data.setMessage("code_is_not_null");
	            return data;
	        }
	        if (state == null || "".equals(state)) {
	            data.setSuccess(false);
	            data.setMessage("state_is_not_null");
	            return data;
	        }
	        logger.info("code = " + code + ", state = " + state);
	        if (code != null && !"".equals(code)) {
	            // 授权成功, 微信获取用户openID
	            OAuthInfo authInfo = getAccess_token(code);
	            String access_token = authInfo.getAccess_token();

	            if (access_token == null) {
	                // Code 使用过 异常
	                logger.info("Code 使用过 异常.....");
	                data.setSuccess(false);
	                data.setMessage("Code 使用 异常.....");
	                data.setObj(getAccess_token(code));
	                return data;
	            }
	            //微信第三方用户信息
	            WechatUserInfoBean weChatUserInfo = WeChatUtils.getWeChatUserInfo(access_token, authInfo.getOpenid());
	            data.setSuccess(true);
	            data.setObj(weChatUserInfo);
	            // 登录成功
	            return data;
	        }
	        // 未授权	        
	        data.setSuccess(true);
	        data.setMessage("未授权"+WeChatUtils.getStartURLToGetCode());
	        return data;  
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
            data.setSuccess(false);
            data.setObj(e);
            return data;
		}
    }
    
    public OAuthInfo getAccess_token(String code){
        
	      String authUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code ";
	      authUrl= authUrl.replace("APPID",  SettingUtil.getSetting("MobileAppID", String.class));
	      authUrl = authUrl.replace("SECRET", SettingUtil.getSetting("MobileAppSecret", String.class));
	      authUrl = authUrl.replace("CODE", code);
	      String jsonString = HttpUtils.sendPost(authUrl,"");
	      System.out.println("Mobile_jsonString: " + jsonString);
	      OAuthInfo auth = null;
	      try {
	       auth = (OAuthInfo) JSON.parseObject(jsonString, OAuthInfo.class);
	      } catch (Exception e) {
	    	  logger.error(e.getMessage());
	      }
	      return auth;
    }




	public QcodeUser thirdLoginCheck1(QcodeThirdLogin qcodeThirdLogin) {
		QueryFilter filter = new QueryFilter();
		filter.put("appId", qcodeThirdLogin.getAppId());
		filter.put("appType", qcodeThirdLogin.getAppType());
		QcodeThirdLogin thirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();

		QcodeUser qcodeUser = null;
		if (thirdLogin == null) {//第一次登录
			return null;
		} else {//之前登录过
			//没有绑定用户
			if (null == thirdLogin.getUserId()) {
				return null;
			}
			//已绑定用户
			else {
				filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
				qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
				qcodeUser.setToken(qcodeUser.getApiKey());
			}

			//更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
			//没有绑定用户 第三方 微信头像，名称改变
			if (null == qcodeThirdLogin.getUserId() || (!qcodeThirdLogin.getFace()
					.equals(qcodeThirdLogin.getFace())) || (!qcodeThirdLogin.getNickname()
					.equals(qcodeThirdLogin.getNickname()))) {
				thirdLogin.setFace(qcodeThirdLogin.getFace());
				thirdLogin.setNickname(qcodeThirdLogin.getNickname());
				thirdLogin.setUserId(qcodeUser.getId());
				qcodeThirdLoginService.update(thirdLogin);
			}
		}
		return qcodeUser;

	}







	@RequestMapping("/loginByPhone.json")
	@ResponseBody
	public ResponseData registerSaveByPhone(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		try {
			// 数据获取
			String phone = request.getParameter("phoneNumber");
			String name = createRandomQcodeUserName();
			String phoneCode = request.getParameter("phonecode");

			// 校验短信验证码
			if (StringHelperTools.isEmpty(phoneCode)) {
				data.setCode(10003);// 请输入短信验证码
				data.setMessage("请输入短信验证码");
				data.setSuccess(false);
				return data;
			}

			int num = SmsValidatorHelper.validateMobileCaptcha(phone, phoneCode);

			//验证码错误
			if (num == 1) {
				data.setCode(10004);
				data.setMessage("短信验证码不正确");
				data.setSuccess(false);
				return data;
			}

			// 验证码输入次数过多,请重新发送
			if (num == 2) {
				data.setCode(10005);
				data.setMessage("短信验证码输入次数过多");
				data.setSuccess(false);
				return data;
			}

			// 短信验证码已过期
			if (num == 3) {
				data.setCode(10006);
				data.setMessage("短信验证码已过期");
				data.setSuccess(false);
				return data;
			}

			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("tel",phone);
			QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
					.getReturnObj();
			if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
				data.setObj(qcodeUser);
				return data;

			}else {
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setTel(phone);
				qcodeUserAdd.setEmail("");
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				qcodeUserAdd = result.getReturnObj();
				// 不进行邮箱验证 初始化demo项目和默认项目
				initProject(qcodeUserAdd.getId());
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}

				data.setObj(qcodeUserAdd);
				return data;
			}
		} catch (DuplicateKeyException e) {
			Result result = new Result();
			if (e.getRootCause().getMessage().toUpperCase().contains("PRIMARY")) {
				result.addErrormsg(getMessage("id_repeat"));
			}
			return new ResponseData(false, result);
		} /*catch (UnsupportedEncodingException e) {
			logger.error(getMessage("sender_mistake"));
			e.printStackTrace();
		}*/

	}


	@RequestMapping("/bindPhone.json")
	@ResponseBody
	public ResponseData bindPhone(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		data.setObj("");
		// 数据获取
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			String phone = map.get("phone") == null?null:map.get("phone").toString();
			String code = map.get("code") == null?null:map.get("code").toString();
			String phoneCode = map.get("phoneCode") == null?null:map.get("phoneCode").toString();
			String appType = map.get("appType") == null?null:map.get("appType").toString();
			// 发送短信验证码
			if(StringUtils.isBlank(phone)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			if(StringUtils.isBlank(code)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			if(StringUtils.isBlank(phoneCode)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}



			int num = SmsValidatorHelper.validateMobileCaptcha(phone, phoneCode);

			//验证码错误
			if (num == 1) {
				data.setCode(10004);
				data.setMessage("短信验证码不正确");
				data.setSuccess(false);
				return data;
			}

			// 验证码输入次数过多,请重新发送
			if (num == 2) {
				data.setCode(10005);
				data.setMessage("短信验证码输入次数过多");
				data.setSuccess(false);
				return data;
			}

			// 短信验证码已过期
			if (num == 3) {
				data.setCode(10006);
				data.setMessage("短信验证码已过期");
				data.setSuccess(false);
				return data;
			}

			String name = "";
			String appId = "";
			String face = "";
			String email = "";

			if("1".equals(appType)) {
				name = map.get("name") == null ? null : map.get("name").toString();
				appId = map.get("openid") ==  null ? null : map.get("openid").toString();
				face = map.get("iconurl") == null ? null : map.get("iconurl").toString();
			}else if("2".equals(appType)) {
				name = map.get("nickname") == null ? null : map.get("nickname").toString();
				appId = map.get("appId") == null ? null : map.get("appId").toString();
				face = map.get("face") == null ? null : map.get("face").toString();
			}else if("3".equals(appType)) {
				name = map.get("screenName") == null ? null : map.get("screenName").toString();
				appId = map.get("id") == null ? null : map.get("id").toString();
				face = map.get("profileImageUrl") == null ? null : map.get("profileImageUrl").toString();
			}else if("4".equals(appType)) {
				email = map.get("email") == null ? null : map.get("email").toString();
			}

			QueryFilter filter = new QueryFilter();
			filter.put("tel",phone);
			QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();

			QcodeThirdLogin qcodeThirdLogin = new QcodeThirdLogin();

			Result result;

			if(user == null) {
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setTel(phone);
				if(StringUtils.isNotBlank(email)) {
					qcodeUserAdd.setEmail(email);
				}else {
					qcodeUserAdd.setEmail("");
				}

				qcodeUserAdd.setName(name);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setFace(face);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				qcodeUserAdd = result.getReturnObj();
				// 不进行邮箱验证 初始化demo项目和默认项目
				initProject(qcodeUserAdd.getId());
				user = qcodeUserAdd;
			}

			qcodeThirdLogin.setUserId(user.getId());
			qcodeThirdLogin.setAppId(appId);
			qcodeThirdLogin.setFace(face);
			qcodeThirdLogin.setNickname(name);

			qcodeThirdLogin.setAppType(Integer.parseInt(appType));
			Result r = qcodeThirdLoginService.save(qcodeThirdLogin);
			if(r.isSuccess()) {
				boolean bindWeiBo = bingingThird(user.getId(),"3");
				boolean bindQQ = bingingThird(user.getId(),"1");
				boolean bindWeixin = bingingThird(user.getId(),"2");
				user.setBindingPhone(false);
				user.setBindingQQ(bindQQ);
				user.setBindingWeiXin(bindWeixin);
				user.setBindingWeiBo(bindWeiBo);
				user.setToken(user.getApiKey());
				data.setObj(user);
				data.setSuccess(true);
				return data;
			}else {
				data.setMessage("UPDATE_USERINFO_FAILED");
				data.setSuccess(false);
				return data;
			}

		}catch (Exception e) {
			e.printStackTrace();
			data.setSuccess(false);
			data.setMessage("program error");
			return data;
		}

	}


	/**
	 * 生成随机用户名称
	 * */
	private String createRandomQcodeUserName(){
		Random random = new Random();
		String randomNum = new StringBuffer().append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).append(random.nextInt(10)).toString();
		return new StringBuffer("U").append(randomNum).toString();
	}



	/**
	 * 激活成功创建项目
	 *
	 * @param id
	 * @2017-8-2下午1:55:07
	 * @JT
	 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void initProject(Long id) {

		Date now1 = new Date(System.currentTimeMillis() - 1000);
		Date now2 = new Date(System.currentTimeMillis());
		Date now3 = new Date(System.currentTimeMillis() + 1000);
		// 获取初始化数据
		QueryFilter filter = new QueryFilter();
		filter.put("keyname", "demo1");
		SysConfig sysConfig1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "demo2");
		SysConfig sysConfig2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "code1");
		SysConfig code1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "code2");
		SysConfig code2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_name_1");
		SysConfig demoName1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_name_2");
		SysConfig demoName2 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_desc_1");
		SysConfig demoDesc1 = sysConfigService.findOne(filter).getReturnObj();
		filter.put("keyname", "qcodeproject_desc_2");
		SysConfig demoDesc2 = sysConfigService.findOne(filter).getReturnObj();

		// 初始化demo1项目并创建第一个版本
		QcodeProject qcodeProjectDemo1 = new QcodeProject();
		qcodeProjectDemo1.setRepeat(100);
		qcodeProjectDemo1.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo1.setQubitNum(2);
		qcodeProjectDemo1.setClassicalbitNum(2);
		qcodeProjectDemo1.setCreateTime(now1);
		qcodeProjectDemo1.setName(getMessage("demonstration_of_two_qubit_dj_algorithm"));
		qcodeProjectDemo1.setTaskTypeId(1);
		qcodeProjectDemo1.setUserId(id);
		qcodeProjectDemo1.setNameEnglish(demoName1.getVal());
		qcodeProjectDemo1.setDescEnglish(demoDesc1.getVal());
		qcodeProjectDemo1
				.setDesc(getMessage("qcode_demo1_desc"));
		qcodeProjectDemo1.setIsDel(0);
		qcodeProjectDemo1.setPic("uploadFile/demo2.jpg");
		Result r1 = qcodeProjectService.save(qcodeProjectDemo1);
		if (!r1.isSuccess()) {
			logger.info("初始化demo项目出错：" + r1.getErrormsg());
		}
		qcodeProjectDemo1 = r1.getReturnObj();
		QcodeProjectVersion versionDemo1 = new QcodeProjectVersion();
		versionDemo1.setCode(code1.getVal());
		versionDemo1.setCreateTime(now1);
		versionDemo1.setIsDel(0);
		versionDemo1.setName("V1");
		versionDemo1.setPic("uploadFile/demo2.jpg");
		versionDemo1.setProjectId(qcodeProjectDemo1.getId());
		versionDemo1.setSvgXml(sysConfig1.getVal());
		Result r2 = qcodeProjectVersionService.save(versionDemo1);
		if (!r2.isSuccess()) {
			logger.info("初始化demo项目版本出错：" + r2.getErrormsg());
		}

		// 初始化demo2项目并创建第一个版本
		QcodeProject qcodeProjectDemo2 = new QcodeProject();
		qcodeProjectDemo2.setRepeat(100);
		qcodeProjectDemo2.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDemo2.setQubitNum(3);
		qcodeProjectDemo2.setClassicalbitNum(3);
		qcodeProjectDemo2.setCreateTime(now2);
		qcodeProjectDemo2.setName(getMessage("the_3_qubit_grover_search_algorithm"));
		qcodeProjectDemo2.setTaskTypeId(1);
		qcodeProjectDemo2.setUserId(id);
		qcodeProjectDemo2.setNameEnglish(demoName2.getVal());
		qcodeProjectDemo2.setDescEnglish(demoDesc2.getVal());
		qcodeProjectDemo2
				.setDesc(getMessage("qcode_demo2_desc"));
		qcodeProjectDemo2.setIsDel(0);
		qcodeProjectDemo2.setPic("uploadFile/demo1.jpg");
		Result r3 = qcodeProjectService.save(qcodeProjectDemo2);
		if (!r3.isSuccess()) {
			logger.info("初始化demo2项目出错：" + r3.getErrormsg());
		}
		qcodeProjectDemo2 = r3.getReturnObj();
		QcodeProjectVersion versionDemo2 = new QcodeProjectVersion();
		versionDemo2.setCode(code2.getVal());
		versionDemo2.setCreateTime(now2);
		versionDemo2.setIsDel(0);
		versionDemo2.setName("V1");
		versionDemo2.setPic("uploadFile/demo1.jpg");
		versionDemo2.setProjectId(qcodeProjectDemo2.getId());
		versionDemo2.setSvgXml(sysConfig2.getVal());
		Result r4 = qcodeProjectVersionService.save(versionDemo2);
		if (!r4.isSuccess()) {
			logger.info("初始化demo2项目版本出错：" + r4.getErrormsg());
		}

		// 初始化默认工作项目
		QcodeProject qcodeProjectDefault = new QcodeProject();
		qcodeProjectDefault.setRepeat(100);
		qcodeProjectDefault.setAnalogType(QcodeProject.ANALOG_TYPE_PROBABILITY);
		qcodeProjectDefault.setQubitNum(6);
		qcodeProjectDefault.setClassicalbitNum(6);
		qcodeProjectDefault.setCreateTime(now3);
		SimpleDateFormat d1 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat d2 = new SimpleDateFormat("HHmmss");
		String name = d1.format(now3) + "_" + d2.format(now3) + "_QEmulator";
		qcodeProjectDefault.setName(name);
		qcodeProjectDefault.setTaskTypeId(1);
		qcodeProjectDefault.setUserId(id);
		qcodeProjectDefault.setIsDel(0);
		Result r5 = qcodeProjectService.save(qcodeProjectDefault);
		if (!r5.isSuccess()) {
			logger.info("初始化默认工作项目出错：" + r5.getErrormsg());
		}
	}


	/**
	 * 发送短信验证码
	 *
	 * @author liq
	 * @since 2016年3月4日
	 */
	@RequestMapping("/sendPhoneMsg.json")
	@ResponseBody
	public ResponseData sendPhoneMsg(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			String phone = map.get("phone") == null?null:map.get("phone").toString();
			String code = map.get("code") == null?null:map.get("code").toString();
			String appType = map.get("appType") == null?null:map.get("appType").toString();

			// 发送短信验证码
			if(StringUtils.isBlank(phone)) {
				data.setSuccess(false);
				data.setMessage("phone can not null");
				return data;
			}

			if(StringUtils.isBlank(code)) {
				data.setSuccess(false);
				data.setMessage("code can not null");
				return data;
			}

			if(StringUtils.isNotBlank(appType)) {
				QueryFilter filter = new QueryFilter();
				filter.put("tel",phone);
				QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();
				if(user != null) {
//					filter.put("userId",user.getId());
//					QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();
//					if(qcodeThirdLogin != null) {
//						data.setSuccess(false);
//						data.setMessage("此号码已绑定，请换一个试试");
//						return data;
//					}
					data.setMessage("此号码已绑定，请换一个试试");
					data.setSuccess(false);
					data.setObj(user.getApiKey());

					return data;
				}
			}

			if (SmsValidatorHelper.sendMobileCaptcha(phone, 6)) {
				data.setCode(10000);
				data.setMessage("短信验证码发送成功！有效时间为20分钟！验证码：" );
			} else {
				data.setCode(10002);
				data.setMessage("短信发送失败");
				data.setSuccess(false);
			}
			return data;

		}catch (Exception e) {
			e.printStackTrace();
			data.setSuccess(false);
			data.setMessage("program error");
			return data;
		}

	}





	@RequestMapping("/bindStepOut.json")
	@ResponseBody
	public ResponseData bindStepOut(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		data.setObj("");
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}


			String appType = map.get("appType") == null ? null : map.get("appType").toString();

			if(appType == null || "".equals(appType)) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			String appId = "";
			String face = "";
			String nickName = "";
			if("1".equals(appType)) {
				appId = map.get("openid") == null ? null : map.get("openid").toString();
				face = map.get("iconurl") == null ? null : map.get("iconurl").toString();
				nickName = map.get("name") == null ? null : map.get("name").toString();
			}else if("2".equals(appType)) {
				appId = map.get("appId") == null ? null : map.get("appId").toString();
				face = map.get("face") == null ? null : map.get("face").toString();
				nickName = map.get("nickname") == null ? null : map.get("nickname").toString();
			}else if("3".equals(appType)) {
				appId = map.get("id") == null ? null : map.get("id").toString();
				face = map.get("profileImageUrl") == null ? null : map.get("profileImageUrl").toString();
				nickName = map.get("screenName") == null ? null : map.get("screenName").toString();
			}



			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}

			if (face == null || "".equals(face)) {
				data.setSuccess(false);
				data.setMessage("face_is_not_null");
				return data;
			}
			if (nickName == null || "".equals(nickName)) {
				data.setSuccess(false);
				data.setMessage("nickname_is_not_null");
				return data;
			}

			//创建用户信息
			String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
			QcodeUser qcodeUserAdd = new QcodeUser();
			qcodeUserAdd.setName(nickName);
			qcodeUserAdd.setEmail("");
			qcodeUserAdd.setRegisterTime(new Date());
			qcodeUserAdd.setDeleted(0);
			qcodeUserAdd.setIsDisable(0);
			qcodeUserAdd.setApiKey(apiKey);
			qcodeUserAdd.setFace(face);
			qcodeUserAdd.setToken(apiKey);
			qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
			Result result = qcodeUserService.save(qcodeUserAdd);
			qcodeUserAdd = result.getReturnObj();
			// 不进行邮箱验证 初始化demo项目和默认项目
			initProject(qcodeUserAdd.getId());

			//创建第三方登录信息
			QcodeThirdLogin qcodeThirdLogin = new QcodeThirdLogin();
			qcodeThirdLogin.setAppId(appId);
			qcodeThirdLogin.setFace(face);
			qcodeThirdLogin.setNickname(nickName);
			qcodeThirdLogin.setUserId(qcodeUserAdd.getId());
			qcodeThirdLogin.setAppType(Integer.parseInt(appType));
			Result r = qcodeThirdLoginService.save(qcodeThirdLogin);
			if(r.isSuccess()) {
				data.setObj(qcodeUserAdd);
				data.setSuccess(true);
				return data;
			}

			data.setSuccess(false);
			data.setMessage("login failed");
			return data;
		}catch (Exception e) {
			data.setSuccess(false);
			data.setMessage("program failed");
			e.printStackTrace();
			return data;
		}

	}


	/**
	 * app第三方登录
	 * 获取微信个人信息
	 */
	@RequestMapping("/loginByWeiXin.json")
	@ResponseBody
	public ResponseData loginByWeiXin(HttpServletRequest request) {
		// 微信接口自带 2 个参数
		ResponseData data = new ResponseData(true);
		data.setObj("");
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}


			String appId = map.get("appId") == null ? null : map.get("appId").toString();
			String appType = map.get("appType") == null ? null : map.get("appType").toString();

			String face = map.get("face") == null ? null : map.get("face").toString();
			String nickname = map.get("nickname") == null ? null : map.get("nickname").toString();

			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}
			if (appType == null || "".equals(appType)) {
				data.setSuccess(false);
				data.setMessage("appType_is_not_null");
				return data;
			}
			if (face == null || "".equals(face)) {
				data.setSuccess(false);
				data.setMessage("face_is_not_null");
				return data;
			}
			if (nickname == null || "".equals(nickname)) {
				data.setSuccess(false);
				data.setMessage("nickname_is_not_null");
				return data;
			}

			if(!appType.equals("2")) {
				data.setSuccess(false);
				data.setMessage("appType_is_not_right");
				return data;
			}

			//微信第三方用户信息
			WechatUserInfoBean weChatUserInfo =new WechatUserInfoBean();
			weChatUserInfo.setNickname(nickname);
			weChatUserInfo.setUnionid(appId);
			weChatUserInfo.setHeadimgurl(face);

			// 微信第三方登录检查
			QcodeUser qcodeUser = thirdLoginCheck(weChatUserInfo);

			if (qcodeUser == null) {
				logger.info("尚未绑定账号.....");
				data.setSuccess(false);
				data.setMessage("need_bind_platform");
				data.setCode(207);
				return data;//账号信息绑定
				//				return "redirect:" + WeChatUtils.getStartURLToGetCode();//继续扫描二维码
			} else { //模拟登录
				data.setSuccess(true);
				data.setObj(qcodeUser);
				return data;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			data.setSuccess(false);
			data.setObj(e);
			return data;
		}




	}
	/**
	 * 第三方用户登录，页面注册保存
	 *
	 * @param request
	 * @return
	 * @throws MessagingException
	 *  2018/3/2 houdongdong
	 */
	@RequestMapping(value = "/thirdRegisterSave.json", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED)
	public ResponseData thirdRegisterSave(HttpServletRequest request){
		ResponseData data = new ResponseData(true);
		data.setObj("");
		// 数据获取
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}
			String email =map.get("email") == null ? null : map.get("email").toString();
			String password = map.get("password") == null ? null : map.get("password").toString();
			String name = map.get("nickname") == null ? null : map.get("nickname").toString();
			String appId = map.get("appId") == null ? null : map.get("appId").toString();

			if (email == null || "".equals(email)) {
				data.setSuccess(false);
				data.setMessage("email_is_not_null");
				return data;
			}
			if (password == null || "".equals(password)) {
				data.setSuccess(false);
				data.setMessage("password_is_not_null");
				return data;
			}
			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}

			Result result = new Result();

			QueryFilter emailFilter = new QueryFilter();
			emailFilter.put("userName", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(emailFilter)
					.getReturnObj();
			if (qcodeUser != null && qcodeUser.getIsDisable() == 0) {
				//验证密码时候一致，一致默认绑定原有账号，不一致提示账号已经注册
				if(password.equals(qcodeUser.getPwd())) {
					//绑定账号
					if(!qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUser.getId())) {
						data.setMessage("UPDATE_USERINFO_FAILED");
						data.setSuccess(false);
						return data;
					}else {
						data.setObj(qcodeUser);
						data.setSuccess(true);
						return data;
					}
				}
				return new ResponseData(false, getMessage("mailbox_has_been_registered"));
			}else {
				if (name == null || "".equals(name)) {
					data.setSuccess(false);
					data.setMessage("nickname_is_not_null");
					return data;
				}
				String apiKey = UUID.randomUUID().toString().replace("-", "").toUpperCase();
				QcodeUser qcodeUserAdd = new QcodeUser();
				qcodeUserAdd.setEmail(email);
				qcodeUserAdd.setName(name);
				qcodeUserAdd.setApiKey(apiKey);
				qcodeUserAdd.setToken(apiKey);
				qcodeUserAdd.setPwd(password);
				qcodeUserAdd.setRegisterTime(new Date());
				qcodeUserAdd.setDeleted(0);
				qcodeUserAdd.setIsDisable(0);
				qcodeUserAdd.setLevel(QcodeUser.QCODEUSER_LEVEL_2);
				result = qcodeUserService.save(qcodeUserAdd);
				// 不进行邮箱验证 初始化demo项目和默认项目
				if (!result.isSuccess()) {
					return new ResponseData(false, result.getErrormsg());
				}

				QueryFilter emailFilter1 = new QueryFilter();
				emailFilter1.put("userName", email);
				qcodeUserAdd = qcodeUserService.findOne(emailFilter1).getReturnObj();
				if(!qcodeThirdLoginService.updateUserIdByAppId(appId, qcodeUserAdd.getId())) {
					data.setMessage("UPDATE_USERINFO_FAILED");
					data.setSuccess(false);
					return data;
				}
				data.setObj(qcodeUserAdd);
				data.setSuccess(true);
				return data;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			data.setObj(e);
			data.setSuccess(false);
			return data;
		}
	}



	@Transactional(propagation = Propagation.REQUIRED)
	public QcodeUser thirdLoginCheck(WechatUserInfoBean weChatUserInfo) {
		String appId = weChatUserInfo.getUnionid();
		// 数据库中查询微信号是否绑定平台账号
		QueryFilter filter = new QueryFilter();
		filter.put("appId", appId);
		filter.put("appType", QcodeThirdLogin.APPTYPE_WE_CHAT);
		QcodeThirdLogin qcodeThirdLogin = qcodeThirdLoginService.findOne(filter).getReturnObj();

		QcodeUser qcodeUser = null;
		if (qcodeThirdLogin == null) {//第一次登录
			//创建一条第三方信息
			qcodeThirdLogin = new QcodeThirdLogin();
			qcodeThirdLogin.setAppId(appId);
			qcodeThirdLogin.setFace(weChatUserInfo.getHeadimgurl());
			qcodeThirdLogin.setNickname(weChatUserInfo.getNickname());
			qcodeThirdLogin.setAppType(QcodeThirdLogin.APPTYPE_WE_CHAT);
			qcodeThirdLoginService.save(qcodeThirdLogin);
			return null;
		} else {//之前登录过
			//没有绑定用户
			if (null == qcodeThirdLogin.getUserId()) {
				return null;
			}
			//已绑定用户
			else {
				filter.setStatementKey(QcodeThirdLoginService.SELECT_BY_APPID);
				qcodeUser = qcodeThirdLoginService.findOne(filter).getReturnObj();
			}

			//更新qcodeThirdLogin内容，因为微信的个人信息可能被修改
			//没有绑定用户 第三方 微信头像，名称改变
			if (null == qcodeThirdLogin.getUserId() || (!weChatUserInfo.getHeadimgurl()
					.equals(qcodeThirdLogin.getFace())) || (!weChatUserInfo.getNickname()
					.equals(qcodeThirdLogin.getNickname()))) {
				qcodeThirdLogin.setFace(weChatUserInfo.getHeadimgurl());
				qcodeThirdLogin.setNickname(weChatUserInfo.getNickname());
				qcodeThirdLogin.setUserId(qcodeUser.getId());
				qcodeThirdLoginService.update(qcodeThirdLogin);
			}
		}
		return qcodeUser;

	}


	@RequestMapping("/sendEmail.json")
	@ResponseBody
	public ResponseData sendEmail(HttpServletRequest request) {
		ResponseData data = new ResponseData(true);
		data.setObj("");
		// 数据获取
		Map map;
		try {
			map = GetParmFromRequestUtils.getParams(request);
			if (map == null) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			if(null == map.get("email")) {
				data.setSuccess(false);
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				return data;
			}

			if(null == map.get("pwd")) {
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				data.setSuccess(false);
				return data;
			}

			String appType = map.get("appType") == null?null:map.get("appType").toString();

			QueryFilter filter = new QueryFilter(request);
			if("4".equals(appType)) {
				filter.remove("pwd");
				filter.remove("token");
			}
			QcodeUser user = qcodeUserService.findOne(filter).getReturnObj();

			if(user == null && !"4".equals(appType)) {
			    data.setSuccess(false);
			    data.setMessage("该用户未注册，请先注册");
			    data.setCode(10001);
			    return data;
            }else if(user != null && "4".equals(appType) ) {
				data.setMessage("该邮箱已注册，请换一个邮箱");
				data.setSuccess(false);
				data.setCode(10002);
				return data;
			}

            boolean flag = BingEmailUtil.sendEmail(map.get("email").toString(),templateSendEmail);

			if(flag) {
				if(user != null) {
					data.setObj(user.getApiKey());
				}

			    data.setMessage("邮件发送成功");
			    return data;
            }else {
			    data.setSuccess(false);
			    data.setMessage("发送失败");
			    return data;
            }

		}catch (Exception e) {
			e.printStackTrace();
			data.setSuccess(false);
			data.setMessage("program error");
			return data;
		}
	}


	@RequestMapping("/bindEmail.json")
    @ResponseBody
    public ResponseData bindEmail(HttpServletRequest request) {
        ResponseData data = new ResponseData(true);
        data.setObj("");
        // 数据获取
        Map map;
        try {
            map = GetParmFromRequestUtils.getParams(request);
            if (map == null) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            String appType = map.get("appType") ==  null ? null : map.get("appType").toString();

            if (null == map.get("email") || "".equals(map.get("email"))) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }

            if (null == map.get("pwd") || "".equals(map.get("pwd"))) {
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                data.setSuccess(false);
                return data;
            }

            if(null == map.get("emailCode") || "".equals(map.get("emailCode"))) {
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                data.setSuccess(false);
                return data;
            }

            if(null == map.get("token") || "".equals(map.get("token"))) {
				data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
				data.setSuccess(false);
				return data;
			}

            if(appType == null || "".equals(appType)) {
                data.setSuccess(false);
                data.setMessage(getMessage("LACK_OF_NECESSARY_PARAMETERS"));
                return data;
            }



            int num = BingEmailUtil.validEmailCode(map.get("email").toString(),map.get("emailCode").toString());

            //验证码错误
            if (num == 1) {
                data.setCode(10004);
                data.setMessage("验证码不正确");
                data.setSuccess(false);
                return data;
            }

            // 验证码输入次数过多,请重新发送
            if (num == 2) {
                data.setCode(10005);
                data.setMessage("验证码输入次数过多");
                data.setSuccess(false);
                return data;
            }

            // 短信验证码已过期
            if (num == 3) {
                data.setCode(10006);
                data.setMessage("验证码已过期");
                data.setSuccess(false);
                return data;
            }




            String name = "";
            String appId = "";
            String face = "";

            if("1".equals(appType)) {
                name = map.get("name") == null ? null : map.get("name").toString();
                appId = map.get("openid") ==  null ? null : map.get("openid").toString();
                face = map.get("iconurl") == null ? null : map.get("iconurl").toString();
            }else if("2".equals(appType)) {
                name = map.get("nickname") == null ? null : map.get("nickname").toString();
                appId = map.get("appId") == null ? null : map.get("appId").toString();
                face = map.get("face") == null ? null : map.get("face").toString();
            }else if("3".equals(appType)) {
                name = map.get("screenName") == null ? null : map.get("screenName").toString();
                appId = map.get("id") == null ? null : map.get("id").toString();
                face = map.get("profileImageUrl") == null ? null : map.get("profileImageUrl").toString();
            }


			QcodeUser user = GetUserIdByApikey.getUserId(map.get("token").toString());

			QueryFilter filter = new QueryFilter();
			if("4".equals(appType)) {
				filter.put("email",map.get("email").toString());
				boolean flag = qcodeThirdLoginService.hasBindThird(filter);
				if(flag) {
					data.setSuccess(false);
					data.setMessage("此邮箱已绑定过，请绑定其他邮箱");
					return data;
				}
				user.setEmail(map.get("email").toString());
				user.setPwd(map.get("pwd").toString());
				qcodeUserService.update(user);
				data.setMessage("绑定成功");
				data.setObj(user);
				return data;
			}

			if (appId == null || "".equals(appId)) {
				data.setSuccess(false);
				data.setMessage("appId_is_not_null");
				return data;
			}

            QcodeThirdLogin qcodeThirdLogin = new QcodeThirdLogin();
            qcodeThirdLogin.setAppId(appId);
            qcodeThirdLogin.setFace(face);
            qcodeThirdLogin.setNickname(name);
            qcodeThirdLogin.setUserId(user.getId());
            qcodeThirdLogin.setAppType(Integer.parseInt(appType));
            Result r = qcodeThirdLoginService.save(qcodeThirdLogin);
            if(r.isSuccess()) {
				boolean bindWeiBo = bingingThird(user.getId(),"3");
				boolean bindQQ = bingingThird(user.getId(),"1");
				boolean bindWeixin = bingingThird(user.getId(),"2");
				user.setBindingPhone(false);
				user.setBindingQQ(bindQQ);
				user.setBindingWeiXin(bindWeixin);
				user.setBindingWeiBo(bindWeiBo);
				user.setToken(user.getApiKey());
                data.setObj(user);
                data.setSuccess(true);
                return data;
            }else {
                data.setMessage("UPDATE_USERINFO_FAILED");
                data.setSuccess(false);
                return data;
            }

        }catch (Exception e) {
            e.printStackTrace();
            data.setSuccess(false);
            data.setMessage("program error");
            return data;
        }

    }


}
