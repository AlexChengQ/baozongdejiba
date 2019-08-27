<#global base="${basePath!}">
<#global validateJS="${basePath!}${setting['validatejspath']!}"/>
<#macro header title="" charset="utf-8" lang="zh-CN">
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
    <link rel="stylesheet" href="${base}/assets/css/program.css">
    <link rel="stylesheet" href="${base}/assets/css/style.css">
    <link rel="stylesheet" href="${base}/assets/css/my.css">
    <link rel="stylesheet" href="${base}/assets/css/course.css">
    <link rel="stylesheet" href="${base}/assets/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="${base}/assets/codemirror/theme/monokai.css">
    <script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="${base}/assets/js/jquery.nicescroll.min.js"></script>
	<!--<script type="text/javascript" src="${base}/assets/js/fastclick.js"></script>-->
	<script type="text/javascript" src="${base}/assets/js/app.js"></script>
	<script type="text/javascript" src="${base}/assets/js/appclient.js"></script>
	<script type="text/javascript" src="${base}/assets/js/formValidator/validateEngine.js"></script>
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
  	</script>
</head>
</#macro>
 
<#macro body>
		<body>
		    <#nested>
		</body>
</#macro>

<#macro footer>
<script type="text/javascript">
//是否登录
function isLogin() {
  <#if !USER_INFO??>
  		App.prompt(messages.visitor_no_right);
  		//window.location.href="${base}/login.html"
  		return false;
  <#else>
  		return true;		
  </#if>
}

//判断是否是教程案例
function isCase(){
	var id = $("#projectId").val();
	if(id==257||id==258){
		App.prompt(messages.tutorial_cannot_modified);
		return false;
	}else{
		return true;
	}
}

//判断是否是半导体量子芯片案例
function isSemi(){
	var id = $("#taskTypeId").val();
	if(id==3){
		App.prompt(messages.tutorial_cannot_modified);
		return false;
	}else{
		return true;
	}
}

</script>
		<#nested>
	</html>
</#macro>
