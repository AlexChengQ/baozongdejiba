package com.bylz.quantumCloud.admin.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.bylz.quantumCloud.model.QcodeUser;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.bylz.quantumCloud.model.QcodePushVo;
import com.likegene.framework.util.SettingUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Service("templateSendEmail")
public class TemplateSendEmail {
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static JavaMailSender sender = null;
	private static Configuration freemarkerConfiguration = null;

	@SuppressWarnings("static-access")
	public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) {
		this.freemarkerConfiguration = freemarkerConfiguration;
	}
	@SuppressWarnings("static-access")
	public void setSender(JavaMailSender sender) {
		this.sender = sender;
	}

	// 消息推送邮件
	public boolean sendPushMail(QcodePushVo qcodePushVo,InternetAddress[] emails)
			throws MessagingException, IOException, TemplateException {
		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
		helper.setFrom(SettingUtil.getSetting("mail.username",String.class),SettingUtil.getSetting("app.name",String.class));
		helper.setTo(emails);
		helper.setSubject(qcodePushVo.getTitle());
		// 通过指定模板名获取FreeMarker模板实例
		Template tpl = freemarkerConfiguration.getTemplate("pushEmail.ftl");
		// FreeMarker通过Map传递动态数据
		Map<Object,Object> map = new HashMap<Object,Object>();
		map.put("qcodePushVo",qcodePushVo);
		map.put("base",SettingUtil.getSetting("project.server.url",null));
		// 解析模板并替换动态数据。
		String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl,map);
		helper.setText(htmlText, true);
		sender.send(msg);
		return true;
	}


	// 单发发送模板邮件
	public Map sendSingleTemplateMail1Newsletter(QcodeUser qcodeUser, String fileName, String subjectName,Map<String,Object> mapStatus) throws IOException, TemplateException {
		MimeMessage msg = sender.createMimeMessage();
		List<QcodeUser> invalidList = new ArrayList<QcodeUser>();
		List<QcodeUser> validUnsentList = new ArrayList<QcodeUser>();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
			helper.setFrom(SettingUtil.getSetting("mail.username",String.class), SettingUtil.getSetting("app.name",String.class));
			helper.setTo(qcodeUser.getEmail());
			InputStreamReader fileReader = new InputStreamReader(getClass().getResourceAsStream("/templates/"+fileName),"UTF-8");
			BufferedReader reader = new BufferedReader(fileReader);
			String htmlTxt = "";
			String line;
			while ((line = reader.readLine()) != null) {
				htmlTxt += line;
			}
			helper.setSubject(subjectName);
			helper.setText("你好"+qcodeUser.getName()+htmlTxt, true);
			sender.send(msg);
			List<QcodeUser> list = (List<QcodeUser>) mapStatus.get("validUnsent");
			list.remove(qcodeUser);
			mapStatus.put("validUnsent",list);
		}catch (MailSendException e) {
			e.printStackTrace();
			logger.error("sendHtmlMail fail.", e);
			QcodeUser user = new QcodeUser();
			String invalid = getInvalidAddresses(e,"1").length == 0?null:getInvalidAddresses(e,"1")[0];//无效地址
			String validUnsent = getInvalidAddresses(e,"2").length == 0?null:getInvalidAddresses(e,"2")[0];//有效地址发送失败
			if(StringUtils.isBlank(invalid) && StringUtils.isBlank(validUnsent)) {
				logger.error("邮箱出问题了啊，换邮箱吧",e);
				mapStatus.put("error","1");
				return mapStatus;
			}
			user.setName(qcodeUser.getName());
			if(StringUtils.isNotBlank(invalid)) {
				user.setEmail(invalid);
				invalidList = (List<QcodeUser>) mapStatus.get("invalid");
				invalidList.add(user);
				mapStatus.put("invalid",invalidList);
			}

			if(StringUtils.isNotBlank(validUnsent)) {
				user.setEmail(validUnsent);
				validUnsentList = (List<QcodeUser>) mapStatus.get("validUnsent");
				validUnsentList.add(user);
				mapStatus.put("validUnsent",validUnsentList);
			}

			int failedCount = (int)mapStatus.get("failedCount");
			mapStatus.put("failedCount",failedCount+1);
			return mapStatus;
		}catch (MessagingException e) {
			e.printStackTrace();
			return mapStatus;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("sendHtmlMail fail.", e);
			QcodeUser user = new QcodeUser();
			String invalid = getInvalidAddresses(e,"1") == null?null:getInvalidAddresses(e,"1")[0];//无效地址
			String validUnsent = getInvalidAddresses(e,"2") == null?null:getInvalidAddresses(e,"2")[0];//有效地址发送失败
			if(StringUtils.isBlank(invalid) && StringUtils.isBlank(validUnsent)) {
				logger.error("邮箱出问题了啊，换邮箱吧",e);
				mapStatus.put("error","1");
				return mapStatus;
			}
			user.setName(qcodeUser.getName());
			if(StringUtils.isNotBlank(invalid)) {
				user.setEmail(invalid);
				invalidList = (List<QcodeUser>) mapStatus.get("invalid");
				invalidList.add(user);
				mapStatus.put("invalid",invalidList);
			}

			if(StringUtils.isNotBlank(validUnsent)) {
				user.setEmail(validUnsent);
				validUnsentList = (List<QcodeUser>) mapStatus.get("validUnsent");
				validUnsentList.add(user);
				mapStatus.put("validUnsent",validUnsentList);
			}

			int failedCount = (int)mapStatus.get("failedCount");
			mapStatus.put("failedCount",failedCount+1);
			return mapStatus;
		}
		int successCount = (int)mapStatus.get("successCount");
		mapStatus.put("successCount",successCount+1);
		return mapStatus;
	}


	/**
	 * 从异常获取无效地址
	 * @param e
	 * @return
	 */
	private static String[] getInvalidAddresses(Throwable e,String flag) {
		if (e == null) {
			return null;
		}
		if (e instanceof MailSendException) {
			System.out.println("e instanceof SendFailedException");
			Exception[] exceptions = ((MailSendException) e).getMessageExceptions();
			for (Exception exception : exceptions) {
				if (exception instanceof SendFailedException) {
					if("1".equals(flag)) {
						return getStringAddress(((SendFailedException) exception).getInvalidAddresses());
					}else {
						return getStringAddress(((SendFailedException) exception).getValidUnsentAddresses());
					}

				}
			}
		}
		if (e instanceof SendFailedException) {
			return getStringAddress(((SendFailedException) e).getInvalidAddresses());
		}
		return null;
	}

	/**
	 * 将Address[]转成String[]
	 * @param address
	 * @return
	 */
	private static String[] getStringAddress(Address[] address) {
		List<String> invalid = new ArrayList<>();
		for (Address a : address) {
			String aa = ((InternetAddress) a).getAddress();
			if (!StringUtils.isEmpty(aa)) {
				invalid.add(aa);
			}
		}
		String[] emails = (String[]) invalid.toArray(new String[invalid.size()]);
		return emails;
	}


	/**
	 * 过滤数组source，规则为数组元素包含了数组filter中的元素则去除
	 *
	 * @param source
	 * @param filter
	 * @return
	 */
	private static String[] filterByArray(String[] source, String[] filter) {
		List<String> result = new ArrayList<>();
		for (String s : source) {
			boolean contains = false;
			for (String f : filter) {
				if (s.contains(f)) {
					contains = true;
					break;
				}
			}
			if (!contains) {
				result.add(s);
			}
		}

		String[] emails = (String[]) result.toArray(new String[result.size()]);

		return emails;
	}
}
