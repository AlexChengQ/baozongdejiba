package com.bylz.quantumCloud.education.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import com.bylz.quantumCloud.model.QcodePushVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.likegene.framework.util.SettingUtil;
import com.bylz.quantumCloud.model.QcodeApply;
import com.bylz.quantumCloud.model.QcodeUser;

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

    // 通过模板构造邮件内容，参数username将替换模板文件中的${username}标签。
    private String getMailText(QcodeUser qcodeUser) {
        String htmlText = "";
        try {
            // 通过指定模板名获取FreeMarker模板实例
            Template tpl = freemarkerConfiguration.getTemplate("registerUser.ftl");
            // FreeMarker通过Map传递动态数据
            Map<Object, Object> map = new HashMap<Object, Object>();
            String code = EncryptionUtil.authcode(qcodeUser.getEmail() + ":" + qcodeUser.getPwd(), "ENCODE", "", 0);
            map.put("url", SettingUtil.getSetting("project.server.url", null) + "Register/checkEmail.html?s=" + code);
            map.put("createTime", DateUtils.currentDatetime());
            // 解析模板并替换动态数据，最终username将替换模板文件中的${username}标签。
            htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return htmlText;
    }

    // 发送模板邮件
    public boolean sendTemplateMail(QcodeUser qcodeUser) throws MessagingException, UnsupportedEncodingException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo(qcodeUser.getEmail());
        helper.setSubject("激活你的帐号（来自：" + SettingUtil.getSetting("app.name", String.class) + "）");
        String htmlText = getMailText(qcodeUser);// 使用模板生成html邮件内容
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

    private String getMailText(String email) {
        String htmlText = "";
        try {
            String createTime = DateUtils.currentDatetime();
            // 通过指定模板名获取FreeMarker模板实例
            Template tpl = freemarkerConfiguration.getTemplate("forgetPwdr.ftl");
            // FreeMarker通过Map传递动态数据
            Map<Object, Object> map = new HashMap<Object, Object>();
            String code = DecodeUtil.encrypt(email + "," + createTime);
            map.put("url", SettingUtil.getSetting("project.server.url", null) + "Mine/modify.html?s=" + code);
            map.put("createTime", createTime);
            // 解析模板并替换动态数据，最终username将替换模板文件中的${username}标签。
            htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return htmlText;
    }


    // 发送模板邮件
    public boolean sendForgetMail(String email) throws MessagingException, UnsupportedEncodingException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo(email);
        helper.setSubject("密码找回（来自：" + SettingUtil.getSetting("app.name", String.class) + "）");
        String htmlText = getMailText(email);// 使用模板生成html邮件内容
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

    // 留言发送到邮箱
    public boolean sendTemplateMail(QcodeUser qcodeUser, String userMsg, String title)
            throws MessagingException, IOException, TemplateException {
        String name = "游客";
        String email = "游客";
        if (qcodeUser != null) {
            name = qcodeUser.getName();
            email = qcodeUser.getEmail();
        }
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo("service@qubitonline.cn");
        helper.setSubject("来自" + name + "的留言");
        // 通过指定模板名获取FreeMarker模板实例
        Template tpl = freemarkerConfiguration.getTemplate("userMsg.ftl");
        // FreeMarker通过Map传递动态数据
        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("userMsg", userMsg);
        map.put("email", email);
        map.put("title", title);
        map.put("receiveTime", DateUtils.currentDatetime());
        // 解析模板并替换动态数据。
        String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

    // 申请发送到邮箱
    public boolean sendApplyMail(QcodeApply qcodeApply) throws MessagingException, IOException, TemplateException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo(SettingUtil.getSetting("email_apply", String.class));
        helper.setSubject("来自" + qcodeApply.getName() + "量子虚拟机的申请");
        // 通过指定模板名获取FreeMarker模板实例
        Template tpl = freemarkerConfiguration.getTemplate("userApply.ftl");
        // FreeMarker通过Map传递动态数据
        Map<Object, Object> map = new HashMap<Object, Object>();
        map.put("qcodeApply", qcodeApply);
        // 解析模板并替换动态数据。
        String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

    // 回复申请邮件发送到邮箱
    public boolean rePlyApplyMail(QcodeApply qcodeApply) throws MessagingException, IOException, TemplateException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo(qcodeApply.getEmail());
        helper.setSubject("虚拟机申请回复（来自：" + SettingUtil.getSetting("app.name", String.class) + "）");
        // 通过指定模板名获取FreeMarker模板实例
        Template tpl = freemarkerConfiguration.getTemplate("rePlyApplyEmail.ftl");
        // FreeMarker通过Map传递动态数据
        Map<Object, Object> map = new HashMap<Object, Object>();
        String rePlyContent = "您已成功递交申请，在递交申请30天内我们会给您的邮箱发送一封确认信，请您耐心等待，如有需要可致信oqc@originqc.com.";
        map.put("rePlyContent", rePlyContent);
        // 解析模板并替换动态数据。
        String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

    // 回复申请邮件发送到邮箱>>>带附件的
    public boolean rePlyApplyMail2(QcodeApply qcodeApply, HttpServletRequest request)
            throws MessagingException, IOException, TemplateException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, 1, "utf8");// 由于是html邮件，不是mulitpart类型
        String encoding=null;
        if(helper.getEncoding() != null){
        	encoding=helper.getEncoding();
        }
        
        helper.setFrom("noreply@qubitonline.cn", SettingUtil.getSetting("app.name", String.class));
        helper.setTo(qcodeApply.getEmail());
        helper.setSubject("量子虚拟机付费服务申请回复（来自：" + SettingUtil.getSetting("app.name", String.class) + "）");

        // 通过指定模板名获取FreeMarker模板实例
        Template tpl = freemarkerConfiguration.getTemplate("rePlyApplyEmail.ftl");
        String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, null);
        helper.setText(htmlText, true);
        String path = request.getServletContext().getRealPath("/assets/fonts/Request.doc");
        helper.addAttachment(MimeUtility.encodeText("本源量子虚拟机付费体验申请表.doc", encoding, "B"), new FileDataSource(path));
        sender.send(msg);
        return true;
    }

    // 消息推送邮件
    public boolean sendPushMail(QcodePushVo qcodePushVo, String[] emails)
            throws MessagingException, IOException, TemplateException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn",SettingUtil.getSetting("app.name",String.class));
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


    // 消息推送邮件
    public boolean sendValidaMail(Map<String,Object> map, String emails)
            throws MessagingException, IOException, TemplateException {
        MimeMessage msg = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(msg, false, "utf8");// 由于是html邮件，不是mulitpart类型
        helper.setFrom("noreply@qubitonline.cn",SettingUtil.getSetting("app.name",String.class));
        helper.setTo(emails);
        helper.setSubject("邮箱验证码");
        // 通过指定模板名获取FreeMarker模板实例
        Template tpl = freemarkerConfiguration.getTemplate("validaEmail.ftl");
        // FreeMarker通过Map传递动态数据
        map.put("base",SettingUtil.getSetting("project.server.url",null));
        // 解析模板并替换动态数据。
        String htmlText = FreeMarkerTemplateUtils.processTemplateIntoString(tpl,map);
        helper.setText(htmlText, true);
        sender.send(msg);
        return true;
    }

}

















