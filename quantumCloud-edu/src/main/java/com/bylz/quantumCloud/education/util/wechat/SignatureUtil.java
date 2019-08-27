package com.bylz.quantumCloud.education.util.wechat;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Random;

import com.likegene.framework.util.SettingUtil;

/**
 * 验证Signature工具类
 * @author houdongdong
 *
 */
public class SignatureUtil {

    // 与接口配置信息中的Token要一致  
    private static String token = SettingUtil.getSetting("token", String.class);  

    /** 
     * 验证签名 
     *  
     * @param signature 
     * @param timestamp 
     * @param nonce 
     * @return 
     */  
    public static boolean checkSignature(String signature, String timestamp, String nonce) { 
        boolean isEqual=false;
        String[] arr = new String[] { token, timestamp, nonce };  
        // 将token、timestamp、nonce三个参数进行字典序排序  
        Arrays.sort(arr);  

        //三个参数组合成一个字符串
        StringBuilder content = new StringBuilder();  
        for (int i = 0; i < arr.length; i++) {  
            content.append(arr[i]);  
        }  

        String tmpStr = null;  
        //进行SHA1加密，返回16进制字符串
        tmpStr=encryptSHA1(content.toString());

        // 将sha1加密后的字符串可与signature对比，标识该请求来源于微信
        if(tmpStr!=null&&tmpStr.equals(signature)){
            isEqual=true;
        }else{
            isEqual=false;
        }
        content = null;  

        return isEqual;  
    }  
    /**
     * SHA1加密
     * 
     * @param data
     * @return
     */
    public static String encryptSHA1(String data){
        String str=null;
        try {
            // 获得SHA1摘要算法的 MessageDigest 对象
            MessageDigest md=MessageDigest.getInstance("SHA-1");
            // 使用指定的字节更新摘要
            md.update(data.getBytes());
            //获得密文
            byte[] bytes=md.digest();
            //字节数组转化为16进制字符串
            str=bytesToHexString(bytes);

        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return str;
    }
    /**
     * 字节数组转化为16进制字符串
     * @param bytes
     * @return
     */
    public static String bytesToHexString(byte[] bytes){
        StringBuffer sb=new StringBuffer();
        if(bytes==null||bytes.length<=0){
            return null;
        }
        for(int i=0;i<bytes.length;i++){
            int temp=bytes[i]&0xFF;//与运算，将byte转化为整型
            String hex=Integer.toHexString(temp);//int型转化为16进制字符串
            if(hex.length()<2){
                sb.append(0);
            }
            sb.append(hex);
        }
        return sb.toString();
    }  
    
    
    
    
    
    public static String noncestrGenerate(int length){
        Random random=new Random();
        StringBuffer sb=new StringBuffer();
        //循环length次
        for(int i=0; i<length; i++){
          //产生0-2个随机数，既与a-z，A-Z，0-9三种可能
          int number=random.nextInt(3);
          long result=0;
          switch(number){
          //如果number产生的是数字0；
          case 0:
            //产生A-Z的ASCII码
            result=Math.round(Math.random()*25+65);
            //将ASCII码转换成字符
            sb.append(String.valueOf((char)result));
            break;
            case 1:
              //产生a-z的ASCII码
            result=Math.round(Math.random()*25+97);
              sb.append(String.valueOf((char)result));
            break;
            case 2:
              //产生0-9的数字
                       sb.append(String.valueOf
                              (new Random().nextInt(10)));
            break; 
          }
        }
    	
    	
    	
    	

    	return sb.toString();
    }
    
    
    
    

}
