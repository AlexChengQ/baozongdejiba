package com.bylz.quantumCloud.education.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import freemarker.template.TemplateException;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.likegene.framework.core.QueryFilter;
import com.bylz.quantumCloud.education.util.DecodeUtil;
import com.bylz.quantumCloud.education.util.RegExpValidatorUtils;
import com.bylz.quantumCloud.education.util.TemplateSendEmail;
import com.bylz.quantumCloud.model.QcodeUser;
import com.bylz.quantumCloud.service.QcodeUserService;

@Controller
@RequestMapping(value = "/Mine")
public class MineController extends BaseController {
	
	@Autowired
	private QcodeUserService qcodeUserService;
	
    @Autowired
    private TemplateSendEmail templateEmail;  

	/**
	 * 修改密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/modify.html")
	public String modify(ModelMap model, HttpServletRequest request) {
		String encryptStr = request.getParameter("s");
		//判断是否从邮件过来
		if(encryptStr==null || "".equals(encryptStr)){
			model.put("isEmail", "false");
		}else{
			try{
				String str = DecodeUtil.decrypt(encryptStr);
				if(str!=null && !"".equals(str)){
					String[] strs = str.split(",");
					if(strs.length>=2){
						model.put("emailStr", strs[0]);
						model.put("createTimeStr", strs[1]);
						model.put("isEmail", "true");
					}else{
						model.put("isEmail", "false");
					}
				}else{
					model.put("isEmail", "false");
				}
			}catch(Exception e){
				model.put("isEmail", "false");
			}
		}
		
		return "modify";
	}

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
		try {
			// 数据获取
			String email = request.getParameter("email");
			String confirmPassword = request.getParameter("confirmPassword");
			String password = request.getParameter("password");
			String createTime = request.getParameter("createTime");
			String isEmail = request.getParameter("isEmail");//是否从邮件来
			
			if(email==null || "".equals(email)){
				return new ResponseData(false,getMessage("account_does_not_exist_"));
			}
			if(password==null || "".equals(password)){
				return new ResponseData(false,getMessage("enter_modify_password"));
			}else{
				if(!RegExpValidatorUtils.matchStr("[A-Za-z0-9]{6,16}",password)){
					return new ResponseData(false,getMessage("change_password_6_16_bits"));
				}
			}
			if(confirmPassword==null || "".equals(confirmPassword)){
				return new ResponseData(false,getMessage("enter_change_password"));
			}else{
				if(!RegExpValidatorUtils.matchStr("[A-Za-z0-9]{6,16}",confirmPassword)){
					return new ResponseData(false,getMessage("enter_password_6_16_bits"));
				}
			}
			if(!password.equals(confirmPassword)){
				return new ResponseData(false,getMessage("passwords_must_be_same"));
			}
			QueryFilter filter = new QueryFilter();
			filter.put("email", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
			if(qcodeUser==null){
				return new ResponseData(false,"当前用户："+email+"不存在");
			}else{
				if(isEmail!="" && "true".equals(isEmail) && createTime!=null && !"".equals(createTime)){
					//判断时长是否大于1小时
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date createDate = sdf.parse(createTime);
					Date currentDate = new Date();
					/*System.out.println("createDate:"+createDate);
					System.out.println("currentDate:"+currentDate);
					System.out.println("createDate.getTime():"+createDate.getTime());
					System.out.println("currentDate.getTime():"+currentDate.getTime());
					System.out.println("(currentDate.getTime() - createDate.getTime()):"+(currentDate.getTime() - createDate.getTime()));
					System.out.println("*****************************************************"+((currentDate.getTime() - createDate.getTime())/1000/60));*/
					if(((currentDate.getTime() - createDate.getTime())/1000/60)>60){//大于1小时 提示失效
						return new ResponseData(false,getMessage("current_link_is_invalid"));
					}else{
						qcodeUser.setPwd(new Md5Hash(password).toHex());
						qcodeUserService.update(qcodeUser);
					}
				}else{
					qcodeUser.setPwd(new Md5Hash(password).toHex());
					qcodeUserService.update(qcodeUser);
				}
				return ResponseData.SUCCESS_NO_DATA;
			}
		} catch (DuplicateKeyException e) {
			return ResponseData.FAILED_NO_DATA;
		}
	}
	
	
	/**
	 * 修改密码
	 * 
	 * @return
	 */
	@RequestMapping(value = "/forget.html")
	public String forget() {
		return "forget";
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
		try {
			// 数据获取
			String email = request.getParameter("email");
			if(email==null || "".equals(email)){
				return new ResponseData(false,getMessage("enter_email_at_registeration"));
			}
			
			QueryFilter filter = new QueryFilter();
			filter.put("email", email);
			QcodeUser qcodeUser = qcodeUserService.findOne(filter).getReturnObj();
			if(qcodeUser==null){//判断邮箱是否注册
				return new ResponseData(false,"注册邮箱："+email+"不存在");
			}else{
				//发送邮件
				templateEmail.sendForgetMail(email);
				return ResponseData.SUCCESS_NO_DATA;
			}
		} catch (DuplicateKeyException e) {
			return ResponseData.FAILED_NO_DATA;
		} catch (UnsupportedEncodingException e) {
				logger.error(getMessage("sender_mistake"));
				e.printStackTrace();
		}
		return ResponseData.SUCCESS_NO_DATA;
	}

}
