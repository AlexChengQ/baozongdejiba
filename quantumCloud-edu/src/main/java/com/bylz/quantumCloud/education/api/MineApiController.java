package com.bylz.quantumCloud.education.api;


import com.bylz.quantumCloud.education.controller.BaseController;
import com.bylz.quantumCloud.education.controller.ResponseData;
import com.bylz.quantumCloud.education.util.DecodeUtil;
import com.bylz.quantumCloud.education.util.RegExpValidatorUtils;
import com.bylz.quantumCloud.education.util.TemplateSendEmail;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;
import com.likegene.framework.core.QueryFilter;
import freemarker.template.TemplateException;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping(value = "/api/Mine")
public class MineApiController extends BaseController {
	
	@Autowired
	private QcodeUserService qcodeUserService;
	
    @Autowired
    private TemplateSendEmail templateEmail;  


	/**
	 * 修改密码
	 * 
	 * @param model
	 * @param request
	 * @author lvliang
	 * @since 2017-07-30
	 * @return
	 * @throws MessagingException
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/modifySave.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData registerSave(ModelMap model, HttpServletRequest request)
			throws MessagingException, ParseException {
		ResponseData data = new ResponseData(true);
		data.setObj("");
		try {
			// 数据获取
			String email = request.getParameter("email");
			String confirmPassword = request.getParameter("confirmPassword");
			String password = request.getParameter("password");
			String createTime = request.getParameter("createTime");
			String isEmail = request.getParameter("isEmail");//是否从邮件来
			
			if(email==null || "".equals(email)){
				data.setSuccess(false);
				data.setMessage(getMessage("account_does_not_exist_"));
				return data;
			}
			if(password==null || "".equals(password)){
				data.setSuccess(false);
				data.setMessage(getMessage("enter_modify_password"));
				return data;
			}else{
				if(!RegExpValidatorUtils.matchStr("[A-Za-z0-9]{6,16}",password)){
					data.setSuccess(false);
					data.setMessage(getMessage("change_password_6_16_bits"));
					return data;
				}
			}
			if(confirmPassword==null || "".equals(confirmPassword)){
				data.setSuccess(false);
				data.setMessage(getMessage("enter_change_password"));
				return data;
			}else{
				if(!RegExpValidatorUtils.matchStr("[A-Za-z0-9]{6,16}",confirmPassword)){
					data.setSuccess(false);
					data.setMessage(getMessage("enter_password_6_16_bits"));
					return data;
				}
			}
			if(!password.equals(confirmPassword)){
				data.setSuccess(false);
				data.setMessage(getMessage("passwords_must_be_same"));
				return data;
			}
			QueryFilter filter = new QueryFilter();
			filter.put("email", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
			if(qcodeUser==null){
				data.setSuccess(false);
				data.setMessage("当前用户："+email+"不存在");
				return data;
			}else{
				if(isEmail!="" && "true".equals(isEmail) && createTime!=null && !"".equals(createTime)){
					//判断时长是否大于1小时
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date createDate = sdf.parse(createTime);
					Date currentDate = new Date();
					if(((currentDate.getTime() - createDate.getTime())/1000/60)>60){//大于1小时 提示失效
						data.setSuccess(false);
						data.setMessage(getMessage("current_link_is_invalid"));
						return data;
					}else{
						qcodeUser.setPwd(new Md5Hash(password).toHex());
						qcodeUserService.update(qcodeUser);
					}
				}else{
					qcodeUser.setPwd(new Md5Hash(password).toHex());
					qcodeUserService.update(qcodeUser);
				}
				return data;
			}
		} catch (DuplicateKeyException e) {
			data.setSuccess(false);
			return data;
		}
	}
	

	/**
	 * 发送验证邮件
	 * 
	 * @param model
	 * @param request
	 * @author lvliang
	 * @since 2017-08-02
	 * @return
	 * @throws MessagingException
	 */
	@RequestMapping(value = "/sendCheckEmail.json", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData sendCheckEmail(ModelMap model, HttpServletRequest request)
			throws MessagingException {
		ResponseData data = new ResponseData(true);
		data.setObj("");
		try {
			// 数据获取
			String email = request.getParameter("email");
			if(email==null || "".equals(email)){
				data.setSuccess(false);
				data.setMessage(getMessage("enter_email_at_registeration"));
				return data;
			}
			
			QueryFilter filter = new QueryFilter();
			filter.put("email", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
			if(qcodeUser==null){//判断邮箱是否注册
				data.setSuccess(false);
				data.setMessage("注册邮箱："+email+"不存在");
				return data;
			}else{
				//发送邮件
				templateEmail.sendForgetMail(email);
				return data;
			}
		} catch (DuplicateKeyException e) {
			e.printStackTrace();
			data.setSuccess(false);
			return data;
		} catch (UnsupportedEncodingException e) {
			logger.error(getMessage("sender_mistake"));
			e.printStackTrace();
			data.setSuccess(false);
			return data;
		}
	}


}
