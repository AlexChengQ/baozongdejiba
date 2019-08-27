package com.bylz.quantumCloud.education.util;

import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.*;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.audience.AudienceTarget;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosAlert;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;

import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

/**
 * @author Xubenjun
 * @version 1.0
 * @Description:
 * @since 2019/4/20
 */
public class JPushUtils {
    private static String masterSecret = "21e644664ed9ca8027648eee";
    private static String appKey = "589fbfec26c4154f75b56f70";

    public static JPushClient jPushClient = new JPushClient(masterSecret,appKey,null, ClientConfig.getInstance());

    /**
     * 构建推送对象：对所有平台，所有设备，内容为 alert的通知
     * @param alter
     * @return
     */
    public static PushPayload buildPushObject_all_all_alert(String alter) {
        return PushPayload.alertAll(alter);
    }
    /**
     * 所有平台，推送目标是别名为 "alias"，通知内容为 alert
     * @param alias
     * @param alert
     * @return
     */
    public static PushPayload buildPushObject_all_alias_alert(String alias,Object alert) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.all())
                .setAudience(Audience.alias(alias))
                .setNotification(Notification.alert(alert))
                .build();
    }
    /**
     * 构建推送对象：平台是 Android，目标是 tag的设备，通知内容是alert，并且标题为title。
     * @param tag
     * @param alert
     * @param title
     * @param extras
     * @return
     */
    public static PushPayload buildPushObject_android_tag_alertWithTitle(String tag,String alert,String title,Map<String, String> extras) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.tag(tag))
                .setNotification(Notification.android(alert, title, extras))
                .build();
    }
    /**
     * 构建推送对象：平台是 iOS，推送目标是 tags(可以是一个设备也可以是多个设备)，推送内容同时包括通知与消息 - 通知信息是alert，消息内容是 msgContent，角标数字为badge(应用程序左上角或者右上角的数字)，通知声音为sound，并且附加字段 from = "JPush"。
     * 通知是 APNs 推送通道的，消息是 JPush 应用内消息通道的。
     * APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
     * @param alert
     * @param msgContent
     * @param badge
     * @param sound
     * @param tags
     * @return
     */
    public static PushPayload buildPushObject_ios_tagAnd_alertWithExtrasAndMessage(Object alert,String msgContent,int badge,String sound,String...tags) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.ios())
                .setAudience(Audience.tag_and(tags))
                .setNotification(Notification.newBuilder()
                        .addPlatformNotification(IosNotification.newBuilder()
                                .setAlert(alert)
                                .setBadge(badge)
                                .setSound(sound)
                                .addExtra("from", "JPush")
                                .build())
                        .build())
                .setMessage(Message.content(msgContent))
                .setOptions(Options.newBuilder()
                        .setApnsProduction(true)
                        .build())
                .build();
    }
    /**
     * 构建推送对象：平台是 Andorid 与 iOS，推送的设备有（推送目标为tags和推送目标别名为aliases），推送内容是 - 内容为 msg_content的消息，并且附加字段 from = JPush。
     * @param msg_content
     * @param tags
     * @param aliases
     * @return
     */
    public static PushPayload buildPushObject_ios_audienceMore_messageWithExtras(String msg_content,String[] tags,String[] aliases) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
                .setAudience(Audience.newBuilder()
                        .addAudienceTarget(AudienceTarget.tag(tags))
                        .addAudienceTarget(AudienceTarget.alias(aliases))
                        .build())
                .setMessage(Message.newBuilder()
                        .setMsgContent(msg_content)
                        .addExtra("from", "JPush")
                        .build())
                .build();
    }
    /**
     * 构建推送对象：推送内容包含SMS信息
     * @param title
     * @param sendSMSContent
     * @param delayTime
     * @param aliases
     */
    public static void testSendWithSMS(String title,String sendSMSContent,int delayTime,String... aliases) {
        JPushClient jpushClient = new JPushClient(masterSecret, appKey);
        try {
            SMS sms = SMS.content(sendSMSContent, delayTime);
            PushResult result = jpushClient.sendAndroidMessageWithAlias(title, sendSMSContent, sms, aliases);
            System.out.println("Got result - " + result);
        } catch (APIConnectionException e) {
            System.out.println("Connection error. Should retry later. "+e);
        } catch (APIRequestException e) {
            System.out.println("Error response from JPush server. Should review and fix it. "+e);
            System.out.println("HTTP Status: " + e.getStatus());
            System.out.println("Error Code: " + e.getErrorCode());
            System.out.println("Error Message: " + e.getErrorMessage());
        }
    }

    public static PushPayload buildPushObject_android_and_ios(LinkedList<String> list,String title,String content,Map<String,String> extras) {
        IosAlert alert = IosAlert.newBuilder().setTitleAndBody(title,null,content).build();
        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
                .setAudience(Audience.registrationId(list))
                .setNotification(Notification.newBuilder()
                        .setAlert(content)
                        .addPlatformNotification(AndroidNotification.newBuilder()
                                .setTitle(title)
                                .addExtras(extras).build())
                        .addPlatformNotification(IosNotification.newBuilder()
                                .incrBadge(1)
                                .setAlert(alert)
                                .addExtras(extras).build())
                        .build())
                .build();
    }


    public static PushPayload buildPushObject_android_cid(String alert) {
        Collection<String> list =new LinkedList<String>();
        list.add("171976fa8af4bd9d339");
        list.add("140fe1da9ee887f0d33");
//        list.add("1507bfd3f79555957de");
//        list.add("1507bfd3f79556957de");
//        list.add("1507ffd3f79545957de");
//        list.add("1507ffd3f79457957de");
//        list.add("1507ffd3f79456757de");


        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
//                .setAudience(Audience.registrationId("171976fa8af4bd9d339"))
                .setAudience(Audience.registrationId(list))
                .setNotification(Notification.alert(alert))
                .build();
    }

    public static void main(String[] args) {
        JPushClient jpushClient = new JPushClient(masterSecret,appKey, null, ClientConfig.getInstance());
        Map map = new HashMap();
        map.put("id","1");
        map.put("tt","2");
        map.put("dd","3");
        LinkedList<String> linkedList = new LinkedList<>();
        linkedList.add("141fe1da9ed5e738865");
        linkedList.add("140fe1da9ee887f0d33");
        PushPayload payload = buildPushObject_android_and_ios(linkedList,"title","sdfgdfg ，满满的正能量",map);
        //PushPayload payload=PhicommPush.buildPushObject_android_tag_alertWithTitle("tag1", "123", "123", null);

        try {
            PushResult result = jpushClient.sendPush(payload);
            System.out.println("Got result - " + result);

        } catch (APIConnectionException e) {
            // Connection error, should retry later
            System.out.print("Connection error, should retry later "+e);

        } catch (APIRequestException e) {
            // Should review the error, and fix the request
            System.out.println("根据返回的错误信息核查请求是否正确"+e);
            System.out.println("HTTP 状态信息码: " + e.getStatus());
            System.out.println("JPush返回的错误码: " + e.getErrorCode());
            System.out.println("JPush返回的错误信息: " + e.getErrorMessage());
        }
    }

}
