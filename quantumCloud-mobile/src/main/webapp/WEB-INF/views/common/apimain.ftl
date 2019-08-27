<#global base="${basePath!}">
<#global validateJS="${basePath!}${setting['validatejspath']!}"/>
<#macro apiheader title="" charset="utf-8" lang="zh-CN">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes"/> <!-- 是否启用 WebApp 全屏模式 -->
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="format-detection" content="telephone=no">
    <!-- uc强制竖屏 -->
    <meta name="screen-orientation" content="portrait">
    <!-- QQ强制竖屏 -->
    <meta name="x5-orientation" content="portrait">
    <title>首页</title>
    <link rel="stylesheet" href="${base}/assets/fonts/iconfont.css">
    <link rel="stylesheet" href="${base}/assets/css/apiprogram.css">
    <link rel="stylesheet" href="${base}/assets/css/style.css">
    <link rel="stylesheet" href="${base}/assets/css/my.css">
    <link rel="stylesheet" href="${base}/assets/css/course.css">
    <link rel="stylesheet" href="${base}/assets/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="${base}/assets/codemirror/theme/monokai.css">
    <script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="${base}/assets/js/jquery.nicescroll.min.js"></script>
	<!--<script type="text/javascript" src="${base}/assets/js/fastclick.js"></script>-->
	<script type="text/javascript" src="${base}/assets/js/app.js"></script>
	<script type="text/javascript" src="${base}/assets/js/formValidator/apivalidateEngine.js"></script>
	<script type="text/javascript" src="${base}/assets/js/noty/jquery.noty.packaged.js"></script>
    <script src="${base}/assets/codemirror/lib/codemirror.js"></script>
    <script src="${base}/assets/codemirror/mode/javascript/javascript.js"></script>
    <script src="${base}/assets/codemirror/addon/selection/active-line.js"></script>
    <script src="${base}/assets/codemirror/addon/edit/matchbrackets.js"></script>
    <script src="${base}/assets/views/js/program/messages_zh_CN.js"></script>
    <script src="${base}/assets/js/echarts/echarts.js"></script>
	<script src="${base}/assets/js/echarts/macarons.js"></script>
	<script src="${base}/assets/js/mobilePlatformCommon.js"></script>
	<script>
    	var base = "${basePath!}";   	
    	var forward="${forward!}";
		var userAgentInfo = navigator.userAgent;
    	var isAndroid=userAgentInfo.indexOf("android") >=0||userAgentInfo.indexOf("Android") >=0;   	
    	var isIOS=userAgentInfo.indexOf("ios")>=0||userAgentInfo.indexOf("Mac OS")>=0||userAgentInfo.indexOf("iPhone")>=0||userAgentInfo.indexOf("iPod")>=0||userAgentInfo.indexOf("iPad")>=0;   	
    	function loadJS( url, callback ){
    	var script = document.createElement('script'),
        fn = callback || function(){};
    	script.type = 'text/javascript';
    	//IE
	    if(script.readyState){
	        script.onreadystatechange = function(){
	            if( script.readyState == 'loaded' || script.readyState == 'complete' ){
	                script.onreadystatechange = null;
	                fn();
	            }
	        };
	    }else{
	        //其他浏览器
	        script.onload = function(){
	            fn();
	        };
	    }
	    script.src = url;
	    document.getElementsByTagName('head')[0].appendChild(script);}
    	if(isIOS){
			loadJS('${base}/assets/js/appiosclient.js',function(){			
			    
			});    	
    	}  	
    	//检查是否登录
		
    	function checkappuserlogin(){
    		var param = {};var url = "${base}/api/requestUserInfo.json";
    		if(isAndroid){
    			param.token=window.injectedObject.startFunction();
    		}else if(isIOS){
	    		window.webkit.messageHandlers.startFunction.postMessage({});   			
    		}else{
    			param.token="37E00A1337DF456491E6A586CFDBCD08";
    		}
    		//IOS跳过判断
			if(isIOS){
				return;
			}
		    if(param.token==null||param.token=='undefined'||param.token==''||param.token=='null'){
	            url = "${base}/api/loginOut.json";
		        $.post(url, function(response) {
		        }).fail(function() { saveFlag = false;alert("token网络异常")});
                login();		    	
		    	window.location.href = "${base}/api/program.html?projectId=257";
		    	return;
			}

			url = "${base}/api/requestUserInfo.json";
    		$.post(url, param, function(response) {
            if (response.code == "401") {
	            url = "${base}/api/loginOut.json";
		        $.post(url, function(response) {
		        }).fail(function() { saveFlag = false;alert("网络异常")});
                login();                
                window.location.href = "${base}/api/program.html?projectId=257";
                return;
            }          
            if (response.success) {         
            	if(forward!=""){
            		window.location.href = forward;
            	}else{
            		return true;
            	}				
            } else {
            	//登录失败，跳转到登录界面
	            url = "${base}/api/loginOut.json";
		        $.post(url, function(response) {
		        }).fail(function() { saveFlag = false;alert("网络异常")});
                login();
                //加载默认设置
                window.location.href = "${base}/api/program.html?projectId=257";
                return;
            }
        }).fail(function() { saveFlag = false;App.alert("网络异常")});   
    	}
    	function login(){
    		if(isAndroid){
    			console.log("Android");
    			window.injectedObject.skipLoginFunction();
    			window.location.href = "${base}/api/program.html?projectId=257";
    		}else if(isIOS){
    			//window.injectedObject.skipLoginFunction();
    			window.location.href = "${base}/api/program.html?projectId=257";
    		}
    	}    	

    	
    	//IOS框架回调函数    	
		function setupWebViewJavascriptBridge(callback) {
		        if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
		        if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
		        window.WVJBCallbacks = [callback]; // 创建一个 WVJBCallbacks 全局属性数组，并将 callback 插入到数组中。
		        var WVJBIframe = document.createElement('iframe'); // 创建一个 iframe 元素
		        WVJBIframe.style.display = 'none'; // 不显示
		        WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__'; // 设置 iframe 的 src 属性
		        document.documentElement.appendChild(WVJBIframe); // 把 iframe 添加到当前文导航上。
		        setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
		    }
		    
		    // 这里主要是注册 OC 将要调用的 JS 方法。
		    setupWebViewJavascriptBridge(function(bridge){
		       
		    });    	
    	    	    	    	    	
    	//确认弹窗
    	function confirmcallback(message,truefun,param){
			var msg=confirm(message);
			if(msg==true){
				truefun(param);
				return true;
			}else{
				return false;
			}
		
		}
		function appLoadview(url){
			if(isAndroid){
				//关闭当前页面
				window.injectedObject.activityFinshFunction();
			}
			window.location.href = url;
			window.location.reload();
		}
		function appViewFinish(url){
			if(isAndroid){
				//关闭当前页面
				alert(url);
				window.injectedObject.activityFinshFunction(url);
			}
		}
  	</script>
</head>
</#macro>
 
<#macro apibody>
		<body>
		    <#nested>
		</body>
</#macro>

<#macro apifooter>
<script type="text/javascript">
//是否登录
function isLogin() {
  <#if !USER_INFO??>
  		//alert(messages.visitor_no_right);
  		window.injectedObject.skipLoginFunction();
  		<#--window.location.href="${base}/api/index.html"-->
  		return false;
  <#else>
  		return true;		
  </#if>
}

//判断是否是教程案例
function isCase(){
	var id = $("#projectId").val();
	if(id==257||id==258){
		alert(messages.tutorial_cannot_modified);
		return false;
	}else{
		return true;
	}
}

//判断是否是半导体量子芯片案例
function isSemi(){
	var id = $("#taskTypeId").val();
	if(id==3){
		alert(messages.tutorial_cannot_modified);
		return false;
	}else{
		return true;
	}
}

</script>
		<#nested>
	</html>
</#macro>
