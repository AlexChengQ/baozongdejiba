package com.bylz.quantumCloud.education.util.bingemail;

import com.bylz.quantumCloud.education.util.StringHelperTools;
import com.bylz.quantumCloud.education.util.TemplateSendEmail;
import com.bylz.quantumCloud.education.util.sms.ExpiryMap;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;

import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/7/18
 */
public class BingEmailUtil {
    /**
     * 邮箱
     */
    private static final String EMAIL_NO = "EMAIL_VALID_NO";

    /**
     * 邮箱验证码
     */
    private static final String EMAIL_VALID_CODE = "EMAIL_VALID_CODE";

    /**
     * 邮箱 输入错误次数
     */
    private static final String EMAIL_ERROR_COUNT = "EMAIL_ERROR_COUNT";

    /**
     * 邮箱 验证码逾期时间
     */
    private static final String EMAIL_EXPIRE_TIME = "EMAIL_EXPIRE_TIME";


    /**
     * 邮箱 输入最大错误次数
     */
    private static final int EMAIL_MAX_ERROR_COUNT = 3;

    /**
     * 邮箱 有效时间（分钟）
     */
    private static final int EMAIL_VALID_TIME = 3;

    private static ExpiryMap<String,Object> expiryMap = ExpiryMap.getInstance();

    private static final Logger logger = LoggerFactory.getLogger(BingEmailUtil.class);


//    private static TemplateSendEmail templateSendEmail = (TemplateSendEmail) ContextLoader.getCurrentWebApplicationContext().getBean("templateSendEmail");

    public static boolean sendEmail(String email,TemplateSendEmail templateSendEmail) {
        String captcha = StringHelperTools.getNumberRandom(6);
        System.out.println(captcha);
        Map<String,Object> map = new HashMap<>();
        map.put("subject","邮箱验证码");
        map.put("content","您的绑定验证码为："+captcha+",有效时间为"+EMAIL_VALID_TIME+"分钟");

        Map<String,Object> map1 = new HashMap<>();
        map1.put(EMAIL_NO,email);
        map1.put(EMAIL_VALID_CODE,captcha);
        map1.put(EMAIL_ERROR_COUNT,0);
        map1.put(EMAIL_EXPIRE_TIME, DateUtils.addMinutes(new Date(), EMAIL_VALID_TIME));
        expiryMap.put(email,map1,EMAIL_VALID_TIME*60*1000);
        try {
//            TemplateSendEmail templateSendEmail = new TemplateSendEmail();
            templateSendEmail.sendValidaMail(map,email);
            return true;
        } catch (SendFailedException e) {
            System.out.println("------------无效邮箱--------------");
            e.printStackTrace();
            return false;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } catch (TemplateException e) {
            e.printStackTrace();
            return false;
        }

    }

    public static int validEmailCode(String inputEmail,String inputCode) {
        Map<String,Object> map = (Map<String, Object>) expiryMap.get(inputEmail);
        if(null == map) {
            return 3;
        }

        Integer errorCount = (Integer)map.get(EMAIL_ERROR_COUNT);
        // Session中验证码输入错误次数
//        Integer errorCount = (Integer) session.getAttribute(TEL_ERROR_COUNT);

        Date expireDate = (Date)map.get(EMAIL_EXPIRE_TIME);
//        Date expireDate = (Date) session.getAttribute(TEL_EXPIRE_TIME);
        // 空
        if (errorCount == null || expireDate == null) {
            return 1;
        }
        // 错误次数大于指定次数
        if (errorCount > EMAIL_MAX_ERROR_COUNT) {
            // 提示重新发送
            return 2;
        }

        // 现在时间大于逾期时间
        if (DateUtils.truncatedCompareTo(new Date(), expireDate, Calendar.MINUTE) > 0) {
            // 提示已经过期
            return 3;
        }

        String sessionEmail = (String)map.get(EMAIL_NO);
        // Session中手机号
//        String sessionMobile = (String) RedisUtil.getObject(TEL_NO,String.class);
//        String sessionMobile = (String) session.getAttribute(TEL_NO);

        String sessionCaptcha = (String)map.get(EMAIL_VALID_CODE);
        // Session中验证码
//        String sessionCaptcha = (String) RedisUtil.getObject(TEL_VALID_CODE,String.class);
//        String sessionCaptcha = (String) session.getAttribute(TEL_VALID_CODE);

        // Session中存在且不为空
        if (StringUtils.isNotEmpty(sessionEmail) && StringUtils.isNotEmpty(sessionCaptcha)
                && sessionEmail.equals(inputEmail)
                && sessionCaptcha.equals(inputCode)) {
            logger.debug("※※※※※※对 手机号：{}，手机验证码：{}，验证成功！", inputEmail, inputCode);
            return 0;
        }

        // 自增
        errorCount++;
        // 重置错误次数
        map.put(EMAIL_ERROR_COUNT,errorCount);
        expiryMap.put(inputEmail,map);
//        mapSerialize.setMap(map);
//        RedisUtil.setObject(inputMobile,mapSerialize);
//        session.setAttribute(TEL_ERROR_COUNT, errorCount);

        logger.debug("※※※※※※对 邮箱：{}，邮箱验证码：{}，验证失败，错误次数：{}！实际邮箱：{}，邮箱验证码：{}。", inputEmail,
                inputCode, errorCount, sessionEmail, sessionCaptcha);

        // 错误次数大于指定次数
        if (errorCount > EMAIL_MAX_ERROR_COUNT) {
            // 提示重新发送
            return 2;
        }

        return 1;
    }
}
