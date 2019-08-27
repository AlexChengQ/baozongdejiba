<@apimain.apiheader title="编程">
<#escape x as x?html>
 </#escape> 
</@apimain.apiheader>
<@apimain.apifooter>
	<script>
		var userAgentInfo = navigator.userAgent;
	    var isAndroid=userAgentInfo.indexOf("android") >=0||userAgentInfo.indexOf("Android") >=0;   	
    	var isIOS=userAgentInfo.indexOf("ios")>=0||userAgentInfo.indexOf("Mac OS")>=0||userAgentInfo.indexOf("iPhone")>=0||userAgentInfo.indexOf("iPod")>=0||userAgentInfo.indexOf("iPad")>=0; 
		var param = {};
		var url = "${base}/api/requestUserInfo.json";
		var token;
		var gettoken;
		function getToken(token) {
		    gettoken = token;
		    param.token=gettoken;
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
	    if(isAndroid){
			param.token=window.injectedObject.startFunction();
		}else if(isIOS){
			//IOS在getToken中获取权限
			window.webkit.messageHandlers.startFunction.postMessage({});
		}else{
			param.token="";
		}
		
		if(!isIOS){
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
		}


  	</script>
</@apimain.apifooter>