package com.bylz.quantumCloud.mobile.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.vdurmont.emoji.EmojiParser;

public class EmojiUtil {
	/***
	 * 验证内容是否含有emoji表情
		@Parameters 待检查的字符串
		@return 验证结果，false 不含有emoji表情，true 即有emoji表情 
		@author JT
	**/
	public static boolean isEmojiCharacter(String stringValue){
		 String unicode = EmojiParser.parseToHtmlHexadecimal(stringValue);    
	     Pattern pattern = Pattern.compile("[`~@#$%^&*()+=|{}\\[\\]<>/~@#￥%……&*（）——+|{}【】]");
		 Matcher matcher = pattern.matcher(unicode);
         if(matcher.find()){//转译后存在特殊字符 表示含有表情
        	return true;
         }
		return false;
	}
}
