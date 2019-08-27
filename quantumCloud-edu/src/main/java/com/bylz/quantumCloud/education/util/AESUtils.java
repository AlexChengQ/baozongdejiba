package com.bylz.quantumCloud.education.util;


import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * AES加密
 * @author houdongdong
 * 1018/02/02
 * **/
public class AESUtils {
	
	private static  Logger logger = LoggerFactory.getLogger(AESUtils.class);
	private static 	Cipher cipher = null;
	private static Key key  = null;
	static {
		
	        
		try {
			
	        KeyGenerator _generator = KeyGenerator.getInstance( "AES" );  
	        SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );  
	        secureRandom.setSeed("seedseedseed".getBytes());  
	        _generator.init(128,secureRandom);  
	        key = _generator.generateKey();  
	        //Key转换
			cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
		} catch (NoSuchAlgorithmException e) {
			logger.error("AES  获取Cipher实例失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			logger.error("AES  获取Cipher实例失败请检查:"+e.getMessage());
			e.printStackTrace();
		}
	}
	
    /**
     *  AES加密
     * @param encodeObject 待加密对象
     * @return 加密后的结果
     * */
	public static String jdkAESEncode(String encodeObject){
		String encodeResultString = null;
		try {
            //加密
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] encodeResult = cipher.doFinal(encodeObject.getBytes());
            encodeResultString = Hex.encodeHexString(encodeResult) ;
//            System.out.println("AESencode : " + encodeResultString );
		} catch (InvalidKeyException e) {
			logger.error("AES加密失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			logger.error("AES加密失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (BadPaddingException e) {
			logger.error("AES加密失败请检查:"+e.getMessage());
			e.printStackTrace();
		}
		return 	encodeResultString;
	}
	
//	@Test
//	public void test(){
//		String jdkAESEncode = jdkAESEncode("0.33");
//		String jdkAESDecode = jdkAESDecode(jdkAESEncode);
//		System.out.println(jdkAESEncode +"-----"+jdkAESDecode);
//	}
	
	 /**
     *  AES解密
     * @param encodeObject 待解密对象
     * @return 解密后的结果
     * */
	public static String jdkAESDecode(String decodeObject){
		String decodeResultString = null;
		try {
			//解密
			cipher.init(Cipher.DECRYPT_MODE, key);
		    byte[] decodeResult = cipher.doFinal(Hex.decodeHex(decodeObject.toCharArray()));
		    decodeResultString =  new String (decodeResult);
		} catch (InvalidKeyException e) {
			logger.error("AES解密失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			logger.error("AES解密失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (BadPaddingException e) {
			logger.error("AES解密失败请检查:"+e.getMessage());
			e.printStackTrace();
		} catch (DecoderException e) {
			logger.error("AES解密失败请检查:"+e.getMessage());
			e.printStackTrace();
		}
		return 	decodeResultString;
	}
	
	
//    bcAES demo
//    public static void bcAES (){
//        try {
//            
//            //使用BouncyCastle 的DES加密
//            Security.addProvider(new BouncyCastleProvider());
//            
//            //生成Key
//            KeyGenerator keyGenerator = KeyGenerator.getInstance("AES","BC");
//            keyGenerator.getProvider();
//            keyGenerator.init(128);  
//            SecretKey secretKey = keyGenerator.generateKey();
//            byte[] keyBytes = secretKey.getEncoded();
//            
//            //Key转换
//            Key key = new SecretKeySpec(keyBytes, "AES");
//            
//            //加密
//            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
//            cipher.init(Cipher.ENCRYPT_MODE, key);
//            byte[] encodeResult = cipher.doFinal(AESUtils.src.getBytes());
////            System.out.println("AESencode : " + Hex.toHexString(encodeResult) );
//            System.out.println("AESencode : " + encodeResult );
////            System.out.println("AESencode : " + Hex.encode(encodeResult) );
//            
//            //解密
//            cipher.init(Cipher.DECRYPT_MODE, key);
//            byte[] decodeResult = cipher.doFinal(encodeResult);
//            System.out.println("AESdecode : " + new String (decodeResult));
//            
//            
//        
//        
//        } catch (NoSuchAlgorithmException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        } catch (NoSuchPaddingException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        } catch (InvalidKeyException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        } catch (IllegalBlockSizeException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        } catch (BadPaddingException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        } catch (NoSuchProviderException e) {
//            // TODO 自动生成的 catch 块
//            e.printStackTrace();
//        }
//    
//    }
    


}
