/*
 * @(#) SmsValidatorHelper.java 2015年10月20日
 *
 * Copyright (c) 2015, SIMPO Technology. All Rights Reserved. SIMPO Technology. CONFIDENTIAL
 */
package com.bylz.quantumCloud.education.util.sms;

import com.bylz.quantumCloud.education.core.AppContextHolder;
import com.bylz.quantumCloud.education.util.StringHelperTools;
import com.bylz.quantumCloud.education.util.redis.MapSerialize;
import com.bylz.quantumCloud.education.util.redis.RedisUtil;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import com.likegene.framework.util.SettingUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.shiro.session.Session;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;


/*
 * 手机短信验证码 验证 帮助类
 * 
 * @author ZHang.WenBin
 * 
 * @version 1.0
 * 
 * @since 2016年01月26日
 */

public class SmsValidatorHelper {

    /**
     * 手机号
     */
    private static final String TEL_NO = "TEL_VALID_NO";

    /**
     * 手机短信验证码
     */
    private static final String TEL_VALID_CODE = "TEL_VALID_CODE";

    /**
     * 手机号 输入错误次数
     */
    private static final String TEL_ERROR_COUNT = "TEL_ERROR_COUNT";

    /**
     * 手机号 验证码逾期时间
     */
    private static final String TEL_EXPIRE_TIME = "TEL_EXPIRE_TIME";

    /**
     * 获取验证码值
     */
    private static final String SMS_VALIDATE_VALUE = "尊敬的用户：您此次手机验证码为${code}。如非本人操作请忽略。";

    /**
     * 手机号 输入最大错误次数
     */
    private static final int TEL_MAX_ERROR_COUNT = 3;

    /**
     * 手机号 有效时间（分钟）
     */
    private static final int TEL_VALID_TIME = 3;

    private static int appId = SettingUtil.getSetting("SMS_APPID",Integer.class);

    private static String appKey = SettingUtil.getSetting("SMS_APPKEY",String.class);

    private static final Logger logger = LoggerFactory.getLogger(SmsValidatorHelper.class);

    private static ExpiryMap<String,Object> expiryMap = ExpiryMap.getInstance();

    /**
     * 给指定号码发送验证码，并保存到Session
     *
     * @param mobile 手机号码
     * @param captchaLen 验证码长度
     * @return 发送结果：true，发送成功；false：发送失败
     */
    public static boolean sendMobileCaptcha(String mobile, int captchaLen) {
//        Session session = AppContextHolder.getSession();
        // 生成验证码
        String captcha = StringHelperTools.getNumberRandom(captchaLen);

        System.out.println(captcha);
        SmsSingleSender smsSingleSender = new SmsSingleSender(appId,appKey);
        System.out.println("--------------------------------------------------------");
        String[] params = {captcha,String.valueOf(TEL_VALID_TIME)};

        String sign = "本源量子";

        SmsSingleSenderResult smsSingleSenderResult = null;
        try {
            System.out.println("开始发短信了啊");
            // 发送验证码
            smsSingleSenderResult = smsSingleSender.sendWithParam("86",mobile,363816,(String[])params,sign,"","");
            System.out.println("短信发完了啊");

        } catch (HTTPException e) {
            // HTTP响应码错误
            e.printStackTrace();
        } catch (JSONException e) {
            // json解析错误
            e.printStackTrace();
        } catch (IOException e) {
            // 网络IO错误
            e.printStackTrace();
        }
        // 发送成功
        if (smsSingleSenderResult.result == 0) {
            logger.debug("※※※※※※手机号：{}，申请的手机验证码为：{}", mobile, captcha);

            Map<String,Object> map = new HashMap<>();
            map.put(TEL_NO,mobile);
            map.put(TEL_VALID_CODE,captcha);
            map.put(TEL_ERROR_COUNT,0);
            map.put(TEL_EXPIRE_TIME,DateUtils.addMinutes(new Date(), TEL_VALID_TIME));
            expiryMap.put(mobile,map,TEL_VALID_TIME*60*1000);
//            MapSerialize mapSerialize = new MapSerialize();
//            mapSerialize.setMap(map);
//            RedisUtil.setObject(mobile,mapSerialize,TEL_VALID_TIME*60*1000);
            // 保存手机号码和验证码到Session
//            session.setAttribute(TEL_NO, mobile);
            // 保存手机号码和验证码到Session
//            session.setAttribute(TEL_VALID_CODE, captcha);
            // 重置错误次数
//            session.setAttribute(TEL_ERROR_COUNT, 0);
            // 逾期时间
//            session.setAttribute(TEL_EXPIRE_TIME, DateUtils.addMinutes(new Date(), TEL_VALID_TIME));
            return true;
        } else { // 发送失败
            logger.debug("※※※※※※手机号：{}，申请的手机验证码：{}，发送失败！错误代码为：{}。", mobile, captcha, smsSingleSenderResult.result);
            expiryMap.remove(mobile);
            // 移除手机号码
//            RedisUtil.deleteObject(mobile);
//            session.removeAttribute(TEL_NO);
            // 移除验证码
//            session.removeAttribute(TEL_VALID_CODE);
            // 移除错误次数
//            session.removeAttribute(TEL_ERROR_COUNT);
            // 移除逾期时间
//            session.removeAttribute(TEL_EXPIRE_TIME);
            return false;
        }
    }

    /**
     * 验证手机验证码是否正确
     *
     * @param inputMobile 输入的手机号
     * @param inputCaptcha 输入的验证码
     * @return 验证结果编码：0，正确；1，错误，2，错误次数过多，需要提示用户重新发送；3，验证码已过期
     */
    public static int validateMobileCaptcha(String inputMobile, String inputCaptcha) {
        System.out.println("---------------------------开始获取map中元素--------------------------------");
        Map<String,Object> map = (Map<String, Object>) expiryMap.get(inputMobile);
        System.out.println("---------------------------获取完毕--------------------------------");
        if(null == map) {
            return 3;
        }
//        MapSerialize mapSerialize = RedisUtil.getObject(inputMobile,MapSerialize.class);
//        Map<String,Object> map = mapSerialize.getMap();
        Integer errorCount = (Integer)map.get(TEL_ERROR_COUNT);
        // Session中验证码输入错误次数
//        Integer errorCount = (Integer) session.getAttribute(TEL_ERROR_COUNT);

        Date expireDate = (Date)map.get(TEL_EXPIRE_TIME);
//        Date expireDate = (Date) session.getAttribute(TEL_EXPIRE_TIME);
        // 空
        if (errorCount == null || expireDate == null) {
            return 1;
        }
        // 错误次数大于指定次数
        if (errorCount > TEL_MAX_ERROR_COUNT) {
            // 提示重新发送
            return 2;
        }

        // 现在时间大于逾期时间
        if (DateUtils.truncatedCompareTo(new Date(), expireDate, Calendar.MINUTE) > 0) {
            // 提示已经过期
            return 3;
        }

        String sessionMobile = (String)map.get(TEL_NO);
        // Session中手机号
//        String sessionMobile = (String) RedisUtil.getObject(TEL_NO,String.class);
//        String sessionMobile = (String) session.getAttribute(TEL_NO);

        String sessionCaptcha = (String)map.get(TEL_VALID_CODE);
        // Session中验证码
//        String sessionCaptcha = (String) RedisUtil.getObject(TEL_VALID_CODE,String.class);
//        String sessionCaptcha = (String) session.getAttribute(TEL_VALID_CODE);

        // Session中存在且不为空
        if (StringUtils.isNotEmpty(sessionMobile) && StringUtils.isNotEmpty(sessionCaptcha)
                && sessionMobile.equals(inputMobile)
                && sessionCaptcha.equals(inputCaptcha)) {
            logger.debug("※※※※※※对 手机号：{}，手机验证码：{}，验证成功！", inputMobile, inputCaptcha);
            return 0;
        }

        // 自增
        errorCount++;
        // 重置错误次数
        map.put(TEL_ERROR_COUNT,errorCount);
        expiryMap.put(inputMobile,map);
//        mapSerialize.setMap(map);
//        RedisUtil.setObject(inputMobile,mapSerialize);
//        session.setAttribute(TEL_ERROR_COUNT, errorCount);

        logger.debug("※※※※※※对 手机号：{}，手机验证码：{}，验证失败，错误次数：{}！实际手机号：{}，手机验证码：{}。", inputMobile,
                inputCaptcha, errorCount, sessionMobile, sessionCaptcha);

        // 错误次数大于指定次数
        if (errorCount > TEL_MAX_ERROR_COUNT) {
            // 提示重新发送
            return 2;
        }

        return 1;
    }





}
