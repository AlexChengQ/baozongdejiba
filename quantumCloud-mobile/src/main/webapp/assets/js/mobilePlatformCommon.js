/*
 * 文档说明：本文档用于存放量子云项目公共JavaScript
 * */

/**js判断文本中是否有emoji表情
	@param     {String} 要被检查的string
	@author  houdongdong 
***/
function isEmojiCharacter(  substring) {  
    for ( var i = 0; i < substring.length; i++) {  
        var hs = substring.charCodeAt(i);  
        if (0xd800 <= hs && hs <= 0xdbff) {  
            if (substring.length > 1) {  
                var ls = substring.charCodeAt(i + 1);  
                var uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;  
                if (0x1d000 <= uc && uc <= 0x1f77f) {  
                    return true;  
                }  
            }  
        } else if (substring.length > 1) {  
            var ls = substring.charCodeAt(i + 1);  
            if (ls == 0x20e3) {  
                return true;  
            }  
        } else {  
            if (0x2100 <= hs && hs <= 0x27ff) {  
                return true;  
            } else if (0x2B05 <= hs && hs <= 0x2b07) {  
                return true;  
            } else if (0x2934 <= hs && hs <= 0x2935) {  
                return true;  
            } else if (0x3297 <= hs && hs <= 0x3299) {  
                return true;  
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030  
                    || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b  
                    || hs == 0x2b50) {  
                return true;  
            }  
        }  
    }  
} 
/**
过滤emoji的JS代码
@param     {String} 要被过滤的string
@returns  过滤后的结果
@author  houdongdong 
**/	

function filteremoji(  org_val){
	var regStr = /[\uD83C|\uD83D|\uD83E][\uDC00-\uDFFF][\u200D|\uFE0F]|[\uD83C|\uD83D|\uD83E][\uDC00-\uDFFF]|[0-9|*|#]\uFE0F\u20E3|[0-9|#]\u20E3|[\u203C-\u3299]\uFE0F\u200D|[\u203C-\u3299]\uFE0F|[\u2122-\u2B55]|\u303D|[\A9|\AE]\u3030|\uA9|\uAE|\u3030/ig;
	if(regStr.test(org_val)){
	　return  org_val.replace(regStr,"");
	}
}

/**
过滤emoji的JS代码
@param     要被过滤的elementId
@returns  过滤后的结果
@author  houdongdong 
**/	
function filteremojiByElementId(  emoji_input_id){
    var emojireg = $("#"+emoji_input_id).val();
    return filteremoji(emojireg);
}


/**内容中表情验证 过滤输入域中的表情
 * @param     要被过滤的输入域elementId
 * @author  houdongdong 
 * **/
function filteEmoji(elementObj){
	var value = $(elementObj).val();
	if(isEmojiCharacter(value)){
		App.prompt('请不要输入表情，或其他不正确的字符');
		$(elementObj).val(filteremoji(value));
	}
}


/** 数字验证  只能输入数字和小数点后两个
 * 保留至小数点后两位
 * @param  elementObj 元素对象
 * @author houdongdong
 * */
function numberValidate(elementObj){
	var valueTemp = $(elementObj).val();
	
	///^(\-|\+?)\d*(\.?|(\.\d{1,2}))?$/  单个正负号，或者是以正负号开头（或不以正号开头）的数字（整数或有两位小数），或者是以正负号开头（或不以正号开头）的整数后加一个小数点
	//例如  +，-，11， +11，+11.，+11.1，+11.11 
	var reg =/^\d+(\.?|(\.\d{1,2}))?$/;
	if((valueTemp.length > 0) &&  !reg.test(valueTemp)){
		App.prompt("请填写正确的数字，请输入如:1.1或11.11格式的数字");
		var str = $(elementObj).val();
//		var reg = /^[-+]?\d+(\.?\d{1,2})?/g; //允许有正负号
		var reg = /^\d+(\.?\d{1,2})?/g;   //不允许有正负号
		var ret = reg.exec(str);   
		if(!ret){//未找到匹数内容
			$(elementObj).val("");
			return;
		}
		$(elementObj).val(ret[0]);   
	}
}

/***
 * 正整数验证
 * @param  elementObj 元素对象
 * @author houdongdong
 * ***/
function positiveIntegerValidate(elementObj){
	var valueTemp = $(elementObj).val();
	var reg =/^\d+$/;
	if((valueTemp <= 0) ||  !reg.test(valueTemp) ){
		App.prompt("请填写正整数的数字");
		var str = $(elementObj).val();
		var reg = /\d+/g;  
		var ret = reg.exec(str);   
		if(!ret){//未找到匹数内容
			$(elementObj).val("");
			return;
		}
		$(elementObj).val(ret[0]);   
	}
};


$(function(){
	$('.filteEmoji').on("input propertychange", function(){
		filteEmoji(this);
	});
})


