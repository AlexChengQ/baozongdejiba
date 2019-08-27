var token;
var gettoken;
function getToken(token) {
    gettoken = token;
    param.token=gettoken;
    var url="${base}/api/requestUserInfo.json";
    if(param.token==null||param.token=='undefined'||param.token==''||param.token=='null'){
	    url = "${base}/api/loginOut.json";
        $.post(url, function(response) {
        }).fail(function() { saveFlag = false;window.location.href = "${base}/api/program.html?projectId=257"});       
        window.location.href = "${base}/api/program.html?projectId=257";
	}else{
			url = "${base}/api/requestUserInfo.json";
			$.post(url, param, function(response) {
			if (response.code == "401") {
				url = "${base}/api/loginOut.json";
		        $.post(url, function(response) {
		        }).fail(function() { saveFlag = false;window.location.href = "${base}/api/program.html?projectId=257"});
	            login();
	            window.location.href = "${base}/api/program.html?projectId=257";
			}			
			if (response.success) {				
				if(forward!=""){
					window.location.href = forward;
				}else{
					window.location.href = "${base}/api/program.html";
				}				
			} else {
				//登录失败，跳转到登录界面
				window.location.href = "${base}/api/program.html?projectId=257";
			}
		}).fail(function() { saveFlag = false;alert("网络异常")});    
	}		    
    return token;
}
var	injectedObject = function () {
	var userAgentInfo = navigator.userAgent;

	return {
		skipWebviewFunction:function(url,title){
			window.webkit.messageHandlers.skipWebviewFunction.postMessage({
				"url":url ,"title" : title});
		},
		skipLoginFunction:function(){
			window.webkit.messageHandlers.skipLoginFunction.postMessage({});
        },
        startFunction:function(){
        	window.webkit.messageHandlers.startFunction.postMessage({}); 	
        },   
        activityFinshFunction:function(){
			window.webkit.messageHandlers.activityFinshFunction.postMessage({});
        }
     }
}();

