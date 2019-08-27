<#global base=rc.contextPath/>
<#global validateJS="${rc.contextPath}${setting['validatejspath']!}"/>
<#global lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
<#macro header title="" charset="utf-8" lang="zh-CN">
<!DOCTYPE html>
<html>
<head>
    <title><@spring.message code="project_name" /></title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta name="renderer" content="webkit" />
    <meta name="keywords" content="本源量子,云平台,计算机,学习,量子力学,信息,科技,社区,全球,量子纠缠,薛定谔,量子通信,量子人工智能,机器学习,原理,比特,0和1,相干叠加,量子程序,量子计算应用,量子计算,霸权">
    <meta name="description" content=" 欢迎使用量子云平台，我们为您提供了详细的云平台教程，您也可以通过视频教程的学习来提高使用熟练程度。本源量子云平台将帮助你快速了解量子云计算平台以及量子算法 ">
<#--<meta name="viewport" content=" minimum-scale=1.0, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">-->
    <link rel="shortcut icon" href="${base}/assets/images/favicon.ico" />
    <link type="image/x-icon" href="${base}/assets/images/favicon.ico" rel="bookmark" />
    <link rel="stylesheet" href="${base}/assets/css/style.css">
    <link rel="stylesheet" href="${base}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${base}/assets/css/all.css?1.1">
    <script type="text/javascript" data-src="${base}/assets/js/bootstrap.min.js"></script>
    <script>var isIndex;</script>
    <#nested>
</head>
</#macro>
<#macro top4>
<!--top-->
<div class="top">
    <nav class="navbar navbar-default navbar-fixed-top" style=" height: 80px ;  background-color: #002b56; border:none;width: 100%;    color: #a0a9c5;left: auto;">
        <div class="logo">
        <span style="padding-top: 10px;">
             <img src="${base}/assets/images/benyuan.png" width="40" height="40" />
        </span>
            <span class="logo-text"><@spring.message code="project_name" /><span class="f12 " style="float:right;margin-left: 10px;">BETA</span></span>
        </div>
        <#if USER_INFO??>
            <div class="admin">

                <span class="mingzi r" style="margin-top:16px; margin-right:30px; text-align:right; cursor:pointer;">
            <p style="padding: 0;margin: 0;font-size: 12px;">
                <#if USER_INFO.level??>
				<#switch USER_INFO.level!1>
                    <#case 1>
                        <@spring.message code="lv1_user" />
                        <#break>
                    <#case 2>
                        <@spring.message code="lv2_user" />
                        <#break>
                    <#case 3>
                        <@spring.message code="lv3_user" />
                        <#break>
                    <#default>
                        <@spring.message code="lv1_user" />
                </#switch>
			</#if>
            </p>
                    <#if USER_INFO.name?? && USER_INFO.name?length gt 5>
                    ${USER_INFO.name?substring(0,5)}...
                    <#else>
                    ${USER_INFO.name!}
                    </#if>

                <div class="admin-none">
                    <div id="triangle-up"></div>
                    <span><a href="${base}/QCode/project.html"><@spring.message code="my_project" /></a> </span>
                    <span><a href="${base}/QCode/userInfo.html"><@spring.message code="user_info" /></a></span>
                    <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a></span>
                <#--<span><a href="###" onclick="toModify()"><@spring.message code="modify_password" /></a></span>
                <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a> </span>
                <span><a href="javascript:void(0);" onclick="createKey(0);">API KEY</a> </span>-->
                    <span><a href="${base}/logout.html"><@spring.message code="sign_out" /></a></span>
                </div>
            </div>
            </span>
        <#else>
            <div class="admin">

                <span class="r" style="padding-top:30px; padding-right: 16px;">
	            	<a class="sign-up"><@spring.message code="sign_up" /></a> | <a class="login-url"  onclick="viewLoginMin()"><@spring.message code="login" /></a>
	        </span>
            </div>
        </#if>
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar" style="margin-top: 25px">
                    <span class="sr-only"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>

                </button>
            </div>
            <div id="navbar" class="navbar-collapse collapse navbar-right " style="margin-top: 15px">
                <ul class="nav navbar-nav">
                    <!-- 中文 -->
                    <li><a href="http://www.qubitonline.cn"><@spring.message code="home_page" /></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="design" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="${base}/QCode/index.html"><@spring.message code="quantum_virtual_machine" /></a></li>
                            <li><a href="${base}/QCode/apply.html"><@spring.message code="64_quantum_virtual_machine" /></a></li>
                            <li><a href="${base}/QCode/semiQuantumComputer.html"><@spring.message code="semiconductor_quantum_computer" /></a></li>
                            <li><a href="${base}/QCode/superQuantumComputer.html"><@spring.message code="superconductor_quantum_computer" /></a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="science_and_tutorial" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="${base}/QCode/library.html"><@spring.message code="tutorial" /></a></li>
                            <li><a href="https://learn-quantum.com/tutorial/quantumApps.html?defaultIndex=1"><@spring.message code="application" /></a></li>
                            <li><a href="https://learn-quantum.com/tutorial/quantumLooking.html"><@spring.message code="future" /></a></li>
                            <li><a href="http://game.qubitonline.cn" target="_blank"><@spring.message code="mini_game" /></a></li>                          
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="qPanda" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="https://github.com/OriginQ/qurator-vscode" target="_blank"><@spring.message code="qRunes" /></a></li>
                            <li><a href="http://www.originqc.com.cn/QPanda/download.html"><@spring.message code="qPanda" /></a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="join_us" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="http://www.originqc.com.cn/website/companyProfile.html" target="_blank"><@spring.message code="about_us" /></a></li>
                            <li><a href="http://www.originqc.com.cn/website/socialRecruit.html" target="_blank"><@spring.message code="social_recruit" /></a></li>
                            <li><a href="${base}/QCode/community.html"><@spring.message code="contact_us" /></a></li>
                        </ul>
                    </li>


                    <li>
                        <#if lang?? && lang?string=="en_US">
                            <a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_chinese" /></a>
                        <#else>
                            <a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_english" /></a>
                        </#if>

                    </li>
                    <li>
                        <a href="http://download.qubitonline.cn/" ><@spring.message code="app_download" /></a>
                    </li>

                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
</div>
<!--top end-->
</#macro>

<#macro top5>
<!--top-->
<style>
    .login_bg{background: transparent!important;border-radius: 10px!important;box-shadow: none!important;}
    .layui-layer-setwin .layui-layer-close2{background: transparent;right: -19px!important;top: -11px!important;}
    .layui-layer-setwin .layui-layer-close2:before{content: '×';font-size: 18px;color: #333;}
    .content{padding-top: 66px!important;}
    .top{height: 66px;background: transparent;position: absolute;top:0;}
    .navbar{height: 66px ;<#--background: url(${base}/assets/images/jcTopBg.png) repeat-x;--> background: #262f40;border:none;width: 100%;    color: #fff;left: auto;background-color: #262f40;}
    .admin{height: 66px;color: #fff;background: transparent;}
    .logo{padding-top: 15px;}
    #navbar{float: none!important;margin: 0!important;}
    @media (min-width: 1100px){
        .navbar-nav > li > a {padding-top: 23px;padding-bottom: 23px;}
        .navbar-nav{float: none;}
        .min1180{cursor: pointer;float: right!important;background: transparent!important;}
        #userSo786{display: none!important;}
    }
    @media (max-width: 1100px){
        .navbar-nav > li:last-child{display: none;}
        #userSo786{display: block!important;}
        .navbar{position: fixed!important;}
    }
    .admin span a{color: #fff;text-align: center;}
    <#if lang?? && lang?string=="en_US">
        body{
            font-family: "Arial"!important;
        }
    <#else>
        body{
            font-family: "黑体"!important;
        }
    </#if>
</style>
<div class="top" style="">
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="logo">
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="293.286px" height="34.772px" viewBox="0 0 293.286 34.772" enable-background="new 0 0 293.286 34.772" xml:space="preserve">
                <g>
	<path fill="#FFFFFF" d="M17.859,1.756C9.44,1.613,2.504,8.333,2.367,16.765c-0.137,8.432,6.577,15.381,14.996,15.524   c1.792,0.029,3.516-0.254,5.123-0.795c-3.056-0.648-5.531-2.74-6.573-5.477c-4.283-0.863-7.51-4.655-7.51-9.205   c0-5.186,4.192-9.39,9.364-9.39c4.495,0,8.249,3.176,9.154,7.413c2.53,0.653,4.62,2.305,5.762,4.478   c0.1-0.664,0.161-1.342,0.172-2.032C32.992,8.85,26.279,1.899,17.859,1.756z"/>
	<path fill="#FFFFFF" d="M25.983,18.538c-2.041-0.708-4.287,0.497-5.017,2.689c-0.732,2.193,0.331,4.544,2.37,5.25   c2.04,0.709,4.286-0.495,5.017-2.687C29.083,21.598,28.022,19.246,25.983,18.538z"/>
	<path fill="#FFFFFF" d="M51.953,11.314h7.939V9.869h-8.496V6.354h-1.523v3.516h-8.496v1.445h7.881   c-1.836,3.392-4.606,6.608-8.311,9.648c0.352,0.3,0.781,0.69,1.289,1.172c3.431-3.073,5.977-6.263,7.637-9.57v7.734h-4.629v1.367   h4.629v4.004h1.523v-4.004h4.473v-1.367h-4.473v-7.734c1.875,3.796,4.388,6.907,7.539,9.336c0.547-0.573,0.99-1.028,1.328-1.367   C56.793,18.28,54.023,15.208,51.953,11.314z"/>
	<path fill="#FFFFFF" d="M63.232,17.174c-0.521,2.5-1.159,5.085-1.914,7.754l1.504,0.508c0.664-2.852,1.263-5.384,1.797-7.598   C64.163,17.694,63.701,17.474,63.232,17.174z"/>
	<path fill="#FFFFFF" d="M65.322,14.342c-1.276-1.016-2.422-1.888-3.438-2.617l-0.977,1.113c0.951,0.742,2.051,1.667,3.301,2.773   C64.495,15.312,64.866,14.889,65.322,14.342z"/>
	<path fill="#FFFFFF" d="M76.044,20.67c1.081,1.315,2.083,2.669,3.008,4.063l1.23-0.938c-0.885-1.237-1.92-2.546-3.105-3.926   L76.044,20.67z"/>
	<path fill="#FFFFFF" d="M66.767,14.693c0,4.505-0.898,7.761-2.695,9.766c0.443,0.403,0.82,0.808,1.133,1.211   c2.005-2.214,3.008-5.879,3.008-10.996V9.049h4.941c-0.267,0.801-0.541,1.569-0.82,2.305h-2.539v8.008h1.406v-0.508h2.363v4.453   c0,0.625-0.299,0.938-0.898,0.938c-0.482,0-1.048-0.026-1.699-0.078c0.117,0.508,0.208,0.957,0.273,1.348   c0.69,0.013,1.256,0.02,1.699,0.02c1.354,0,2.031-0.696,2.031-2.09v-4.59h2.52v0.508h1.406v-8.008H73.74   c0.377-0.755,0.746-1.523,1.104-2.305h5.479V7.721H66.767V14.693z M77.49,17.564h-6.289v-1.855h6.289V17.564z M77.49,12.643v1.816   h-6.289v-1.816H77.49z"/>
	<path fill="#FFFFFF" d="M70.966,19.967c-0.859,1.484-1.842,2.819-2.949,4.004l1.152,0.898c1.042-1.185,2.057-2.565,3.047-4.141   L70.966,19.967z"/>
	<path fill="#FFFFFF" d="M65.908,9.342c-1.094-0.989-2.155-1.868-3.184-2.637l-0.996,1.074c0.873,0.716,1.875,1.634,3.008,2.754   C65.062,10.182,65.452,9.784,65.908,9.342z"/>
	<path fill="#FFFFFF" d="M85.458,12.252h10.43v0.527h1.328V7.193H84.13v5.586h1.328V12.252z M85.458,8.209h10.43v1.035h-10.43V8.209   z M85.458,10.182h10.43v1.055h-10.43V10.182z"/>
	<path fill="#FFFFFF" d="M91.318,22.799h7.852v-1.016h-7.852V20.67h4.707v0.508h1.328v-5.996H83.974v5.996h1.328V20.67h4.648v1.113   h-7.832v1.016h7.832v1.113h-8.965v1.055h19.297v-1.055h-8.965V22.799z M91.318,16.197h4.707v1.25h-4.707V16.197z M91.318,18.385   h4.707v1.27h-4.707V18.385z M89.951,19.654h-4.648v-1.27h4.648V19.654z M89.951,17.447h-4.648v-1.25h4.648V17.447z"/>
	<rect x="81.142" y="13.189" fill="#FFFFFF" width="19.063" height="1.055"/>
	<path fill="#FFFFFF" d="M111.767,13.854l6.543-4.785V7.545h-15.234V9.01h12.637l-5.605,4.082v2.148h-9.082v1.465h9.082v5.742   c0,0.938-0.462,1.406-1.387,1.406c-1.055-0.013-2.058-0.078-3.008-0.195c0.104,0.664,0.183,1.257,0.234,1.777   c1.458,0.026,2.487,0.039,3.086,0.039c1.823,0,2.734-0.872,2.734-2.617v-6.152h8.555V15.24h-8.555V13.854z"/>
	<path fill="#FFFFFF" d="M126.025,9.967c-0.638-0.703-1.667-1.784-3.086-3.242l-1.191,1.035c1.12,1.159,2.09,2.278,2.91,3.359   L126.025,9.967z"/>
	<path fill="#FFFFFF" d="M125.283,22.564v-9.492h-4.336v1.406h2.773v7.734c0,0.794-0.228,1.387-0.684,1.777l0.938,1.328   c1.354-0.964,3.073-2.097,5.156-3.398c-0.052-0.456-0.098-1.022-0.137-1.699C127.653,21.093,126.416,21.874,125.283,22.564z"/>
	<polygon fill="#FFFFFF" points="134.56,6.471 132.88,6.471 132.88,13.189 127.197,13.189 127.197,14.596 132.88,14.596    132.88,25.611 134.56,25.611 134.56,14.596 140.283,14.596 140.283,13.189 134.56,13.189  "/>
	<path fill="#FFFFFF" d="M141.884,11.9c0.989-0.827,1.868-1.726,2.637-2.695h1.641l-0.703,0.508c0.481,0.521,0.964,1.081,1.445,1.68   h-3.242v8.789h1.367v-0.645h11.348v0.645h1.367v-8.789h-1.514l0.947-0.762c-0.469-0.488-0.983-0.964-1.543-1.426h4.453V8.072   h-6.191c0.313-0.547,0.618-1.126,0.918-1.738h-1.68c-0.716,1.55-1.628,2.903-2.734,4.063c0.456,0.313,0.853,0.618,1.191,0.918   c0.554-0.618,1.087-1.321,1.602-2.109h1.943l-0.674,0.508c0.605,0.547,1.155,1.106,1.65,1.68h-9.004l0.928-0.703   c-0.469-0.515-0.938-1.009-1.406-1.484h4.395V8.072h-5.684c0.371-0.56,0.71-1.14,1.016-1.738h-1.66   c-0.925,1.797-2.188,3.32-3.789,4.57C141.272,11.243,141.598,11.575,141.884,11.9z M156.376,18.443h-11.348v-1.309h11.348V18.443z    M156.376,16.119h-11.348v-1.309h11.348V16.119z M156.376,12.486v1.309h-11.348v-1.309H156.376z"/>
	<path fill="#FFFFFF" d="M155.693,19.928h-1.445v1.211h-6.396c0.046-0.384,0.068-0.794,0.068-1.23h-1.426   c0,0.449-0.026,0.859-0.078,1.23h-5.313v1.211h5.02c-0.481,1.081-1.804,1.804-3.965,2.168c0.325,0.456,0.612,0.886,0.859,1.289   c2.617-0.554,4.16-1.706,4.629-3.457h6.602v3.281h1.445V22.35h4.629v-1.211h-4.629V19.928z"/>
	<rect x="162.978" y="7.818" fill="#FFFFFF" width="15.449" height="1.445"/>
	<path fill="#FFFFFF" d="M161.162,15.26h7.041c-1.185,1.979-2.478,3.815-3.877,5.508c-0.521,0.625-1.172,1.126-1.953,1.504   l0.781,1.797c0.495-0.144,1.022-0.247,1.582-0.313c3.216-0.208,7.161-0.394,11.836-0.557c0.469,0.612,0.938,1.24,1.406,1.885   l1.465-1.094c-1.901-2.409-3.815-4.688-5.742-6.836l-1.289,0.859c1.042,1.23,2.08,2.507,3.115,3.828   c-2.402,0.098-5.823,0.202-10.264,0.313c1.419-1.687,3.105-3.984,5.059-6.895h9.941v-1.445h-19.102V15.26z"/>
	<path fill="#FFFFFF" d="M182.314,18.795c0,2.461-0.437,4.362-1.309,5.703c0.43,0.352,0.788,0.716,1.074,1.094   c1.12-1.575,1.66-3.86,1.621-6.855h2.734v4.492c0,0.534-0.267,0.801-0.801,0.801c-0.481,0-1.055-0.052-1.719-0.156   c0.104,0.534,0.183,0.996,0.234,1.387c0.573,0.039,1.191,0.059,1.855,0.059c1.211,0,1.816-0.651,1.816-1.953V7.525h-5.508V18.795z    M183.701,8.795h2.734v3.75h-2.734V8.795z M183.701,13.756h2.734v3.77h-2.734V13.756z"/>
	<path fill="#FFFFFF" d="M199.169,15.729v-1.152h-8.242V8.951h6.66c-0.026,0.403-0.059,0.774-0.098,1.113   c-0.091,1.106-0.696,1.641-1.816,1.602c-0.769-0.026-1.634-0.098-2.598-0.215c0.091,0.521,0.176,1.035,0.254,1.543   c1.146,0.039,1.985,0.065,2.52,0.078c1.953,0.039,2.981-0.95,3.086-2.969c0.039-0.612,0.091-1.445,0.156-2.5h-9.648v17.949h1.484   v-9.707h0.918c0.403,2.292,1.24,4.251,2.51,5.879c-0.944,0.925-2.067,1.719-3.369,2.383c0.286,0.43,0.554,0.859,0.801,1.289   c1.341-0.749,2.51-1.614,3.506-2.598c1.113,1.113,2.471,2.044,4.072,2.793c0.313-0.417,0.69-0.886,1.133-1.406   c-1.667-0.593-3.063-1.423-4.189-2.49C197.695,20.003,198.649,18.014,199.169,15.729z M193.183,15.846h4.443   c-0.449,1.829-1.211,3.425-2.285,4.785C194.306,19.315,193.586,17.721,193.183,15.846z"/>
	<path fill="#FFFFFF" d="M209.97,15.533h-1.582c-0.065,0.774-0.144,1.478-0.234,2.109h-5.684v1.387h5.41   c-0.69,2.461-2.903,4.297-6.641,5.508c0.339,0.442,0.657,0.879,0.957,1.309c4.16-1.413,6.585-3.685,7.275-6.816h6.514   c-0.052,1.106-0.137,2.148-0.254,3.125c-0.117,1.094-0.729,1.653-1.836,1.68c-0.977-0.013-2.214-0.085-3.711-0.215   c0.117,0.599,0.215,1.14,0.293,1.621c1.536,0.065,2.688,0.091,3.457,0.078c1.979-0.013,3.073-0.938,3.281-2.773   c0.117-0.938,0.241-2.571,0.371-4.902h-7.881C209.797,17.011,209.885,16.308,209.97,15.533z"/>
	<path fill="#FFFFFF" d="M217.685,9.537V8.229h-10.566c0.319-0.456,0.625-0.925,0.918-1.406l-1.465-0.625   c-1.159,2.239-2.937,4.31-5.332,6.211c0.325,0.286,0.684,0.638,1.074,1.055c1.224-1.022,2.341-2.132,3.35-3.33   c0.892,1.237,2.08,2.308,3.564,3.213c-2.402,0.918-5.234,1.628-8.496,2.129c0.313,0.508,0.579,0.964,0.801,1.367   c3.665-0.638,6.79-1.507,9.375-2.607c2.298,1.067,5.144,1.826,8.535,2.275c0.313-0.508,0.677-1.055,1.094-1.641   c-3.027-0.188-5.635-0.681-7.822-1.475C214.817,12.294,216.474,11.009,217.685,9.537z M206.875,9.518h8.721   c-1.237,1.191-2.796,2.227-4.678,3.105C209.27,11.81,207.922,10.774,206.875,9.518z"/>
	<path fill="#FFFFFF" d="M234.189,16.061c1.276-1.367,2.649-3.06,4.121-5.078l-1.465-0.938c-1.146,1.823-2.435,3.489-3.867,5   L234.189,16.061z"/>
	<polygon fill="#FFFFFF" points="231.455,8.834 239.306,8.834 239.306,7.33 222.041,7.33 222.041,8.834 229.814,8.834    229.814,16.998 221.162,16.998 221.162,18.502 229.814,18.502 229.814,25.689 231.455,25.689 231.455,18.502 240.166,18.502    240.166,16.998 231.455,16.998  "/>
	<path fill="#FFFFFF" d="M224.267,10.123l-1.23,0.859c1.406,1.784,2.61,3.489,3.613,5.117l1.387-1.035   C226.982,13.476,225.725,11.829,224.267,10.123z"/>
	<path fill="#FFFFFF" d="M243.662,25.592h1.602v-1.289h10.742v1.289h1.602v-8.867h-13.945V25.592z M245.263,18.17h10.742v4.727   h-10.742V18.17z"/>
	<path fill="#FFFFFF" d="M254.736,8.971l-1.133,0.977c0.918,0.918,1.823,1.862,2.715,2.832c-3.86,0.163-7.786,0.306-11.777,0.43   c2.122-1.784,4.16-3.821,6.113-6.113l-1.465-0.898c-1.849,2.383-3.887,4.485-6.113,6.309c-0.481,0.391-1.022,0.696-1.621,0.918   l0.645,1.68c0.664-0.156,1.354-0.261,2.07-0.313c3.086-0.176,7.552-0.388,13.398-0.635c0.534,0.593,1.062,1.194,1.582,1.807   l1.387-1.152C258.713,12.818,256.78,10.872,254.736,8.971z"/>
	<path fill="#FFFFFF" d="M270.507,10.445v-0.02c0.413-0.133,0.738-0.36,0.974-0.679c0.236-0.319,0.354-0.687,0.354-1.104   c0-0.524-0.198-0.945-0.596-1.262s-0.928-0.476-1.592-0.476h-2.222v7.563h2.28c0.729,0,1.327-0.201,1.794-0.603   c0.468-0.402,0.701-0.929,0.701-1.58c0-0.508-0.154-0.927-0.461-1.257C271.432,10.698,271.022,10.504,270.507,10.445z    M268.403,7.76h0.977c0.95,0,1.426,0.356,1.426,1.069c0,0.407-0.135,0.725-0.402,0.955c-0.27,0.229-0.64,0.344-1.111,0.344h-0.889   V7.76z M270.758,13.26c-0.277,0.236-0.673,0.354-1.184,0.354h-1.172v-2.637h1.011c1.175,0,1.763,0.433,1.763,1.299   C271.176,12.696,271.038,13.024,270.758,13.26z"/>
	<polygon fill="#FFFFFF" points="274.677,11.061 277.382,11.061 277.382,10.196 274.677,10.196 274.677,7.774 277.597,7.774    277.597,6.905 273.701,6.905 273.701,14.469 277.768,14.469 277.768,13.604 274.677,13.604  "/>
	<polygon fill="#FFFFFF" points="283.789,6.905 278.452,6.905 278.452,7.774 280.625,7.774 280.625,14.469 281.606,14.469    281.606,7.774 283.789,7.774  "/>
	<path fill="#FFFFFF" d="M287.202,6.905h-1.045l-2.881,7.563h1.079l0.728-2.07h3.149l0.771,2.07h1.079L287.202,6.905z    M285.39,11.544l1.133-3.145c0.046-0.124,0.086-0.299,0.122-0.527h0.024c0.042,0.25,0.081,0.426,0.117,0.527l1.143,3.145H285.39z"/>
</g>            </svg>
        </div>
        <#if USER_INFO??>
            <div class="admin" id="userSo786">
                <span class="mingzi r" style="margin-top:16px; margin-right:30px; text-align:right; cursor:pointer;">
            <p style="padding: 0;margin: 0;font-size: 12px;">
                <#if USER_INFO.level??>
				<#switch USER_INFO.level!1>
                    <#case 1>
                        <@spring.message code="lv1_user" />
                        <#break>
                    <#case 2>
                        <@spring.message code="lv2_user" />
                        <#break>
                    <#case 3>
                        <@spring.message code="lv3_user" />
                        <#break>
                    <#default>
                        <@spring.message code="lv1_user" />
                </#switch>
			</#if>
            </p>
                    <#if USER_INFO.name?? && USER_INFO.name?length gt 5>
                    ${USER_INFO.name?substring(0,5)}...
                    <#else>
                    ${USER_INFO.name!}
                    </#if>

                <div class="admin-none">
                    <div id="triangle-up"></div>
                    <span><a href="${base}/QCode/project.html"><@spring.message code="my_project" /></a> </span>
                    <span><a href="${base}/QCode/userInfo.html"><@spring.message code="user_info" /></a></span>
                    <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a></span>
                <#--<span><a href="###" onclick="toModify()"><@spring.message code="modify_password" /></a></span>
                <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a> </span>
                <span><a href="javascript:void(0);" onclick="createKey(0);">API KEY</a> </span>-->
                    <span><a href="${base}/logout.html"><@spring.message code="sign_out" /></a></span>
                </div>
            </div>
            </span>
        <#else>
            <div class="admin" id="userSo786" style="height: 66px">
                <span class="r" style="padding-top:23px; padding-right: 16px;">
	            	<a class="sign-up"><@spring.message code="sign_up" /></a> | <a class="login-url" onclick="viewLoginMin()"><@spring.message code="login" /></a>
                </span>
            </div>
        </#if>
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar" style="margin-top: 16px;margin-bottom: 14px">
                    <span class="sr-only"></span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button>
            </div>
            <div id="navbar" class="navbar-collapse collapse navbar-right " style="margin-top: 8px">
                <ul class="nav navbar-nav">
                    <!-- 中文 -->
                    <li><a href="http://www.qubitonline.cn"><@spring.message code="home_page" /></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="design" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="${base}/QCode/index.html"><@spring.message code="quantum_virtual_machine" /></a></li>
                            <li><a href="${base}/QCode/apply.html"><@spring.message code="64_quantum_virtual_machine" /></a></li>
                            <li><a href="${base}/QCode/semiQuantumComputer.html"><@spring.message code="semiconductor_quantum_computer" /></a></li>
                            <li><a href="${base}/QCode/superQuantumComputer.html"><@spring.message code="superconductor_quantum_computer" /></a></li>
                        </ul>
                    </li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="science_and_tutorial" /></a>
                        <ul class="dropdown-menu">

                            <li><a href="${base}/QCode/library.html"><@spring.message code="tutorial" /></a></li>
                            <li><a href="${base}/tutorial/quantumApps.html?defaultIndex=1"><@spring.message code="Application_field" /></a></li>
                            <li><a href="${base}/tutorial/quantumLooking.html"> <@spring.message code="Future_development" /></a></li>
                            <li><a href="http://game.qubitonline.cn" target="_blank"><@spring.message code="mini_game" /></a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="qPanda" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="https://github.com/OriginQ/qurator-vscode" target="_blank"><@spring.message code="qRunes" /></a></li>
                            <li><a href="http://originqc.com.cn/website/classIntroduction.html?bannerId=43"><@spring.message code="qPanda" /></a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="join_us" /></a>
                        <ul class="dropdown-menu">
                            <li><a href="http://www.originqc.com.cn/website/companyProfile.html" target="_blank"><@spring.message code="about_us" /></a></li>
                            <li><a href="http://www.originqc.com.cn/website/socialRecruit.html" target="_blank"><@spring.message code="social_recruit" /></a></li>
                            <li><a href="${base}/QCode/community.html"><@spring.message code="contact_us" /></a></li>
                        </ul>
                    </li>
                    <li><a href="${base}/qcode/forumtopic/index.html" target="_blank"><@spring.message code="forum" /></a></li>
                    <li class="min1180">
                        <#if lang?? && lang?string=="en_US">
                            <a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_chinese" /></a>
                        <#else>
                            <a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_english" /></a>
                        </#if>
                    </li>

                    <li class="min1180" >
                        <a href="http://download.qubitonline.cn/" ><@spring.message code="app_download" /></a>
                    </li>
                    <li class="min1180" >
                        <#if USER_INFO??>
                            <div class="admin">
                                <span class="mingzi r" style="margin-top:16px; margin-right:30px; text-align:right; cursor:pointer;">
                                    <p style="padding: 0;margin: 0;font-size: 12px;">
                <#if USER_INFO.level??>
				<#switch USER_INFO.level!1>
                    <#case 1>
                        <@spring.message code="lv1_user" />
                        <#break>
                    <#case 2>
                        <@spring.message code="lv2_user" />
                        <#break>
                    <#case 3>
                        <@spring.message code="lv3_user" />
                        <#break>
                    <#default>
                        <@spring.message code="lv1_user" />
                </#switch>
			</#if>
            </p>
                    <#if USER_INFO.name?? && USER_INFO.name?length gt 5>
                    ${USER_INFO.name?substring(0,5)}...
                    <#else>
                    ${USER_INFO.name!}
                    </#if>

                <div class="admin-none">
                    <div id="triangle-up"></div>
                    <span><a href="${base}/QCode/project.html"><@spring.message code="my_project" /></a> </span>
                    <span><a href="${base}/QCode/userInfo.html"><@spring.message code="user_info" /></a></span>
                    <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a></span>
                <#--<span><a href="###" onclick="toModify()"><@spring.message code="modify_password" /></a></span>
                <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a> </span>
                <span><a href="javascript:void(0);" onclick="createKey(0);">API KEY</a> </span>-->
                    <span><a href="${base}/logout.html"><@spring.message code="sign_out" /></a></span>
                </div></div></span>
                        <#else>
                            <div class="admin" style="height: 66px">

                <span class="r" style="padding-top:23px; padding-right: 16px;">
                     <#if lang?? && lang?string=="en_US">
                           <a class="sign-up" style="margin-right: 10px"><@spring.message code="sign_up" /></a>
                     <#else>
                            <a class="sign-up" style="margin-right: 30px"><@spring.message code="sign_up" /></a>
                     </#if>
                    <a class="login-url" onclick="viewLoginMin()"><@spring.message code="login" /></a>
                </span>
                            </div>
                        </#if>
                    </li>

                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
</div>
<!--top end-->
</#macro>
<#macro pagination pager>
    <#if (pager.totalRecords)?default(0) != 0>
    <div class="row">
        <input type="hidden" id="startId" name="start" value="${(RequestParameters.start?default(0))!}"/>
        <nav>
            <ul class="pagination navbar-toggle">
                <li>
                    <a><font color="red">${(pager.totalRecords)!}</font><@spring.message code="strip" /></a>
                </li>
                <li>
                    <a>${(pager.totalPages)!}<@spring.message code="page" /></a>
                </li>
                <li>
                    <a aria-label="Previous" href="javascript:void(0)" onclick="toPage(0);">
                        <span aria-hidden="true">«</span>
                    </a>
                </li>
                <#if pager.pageNum gt 2>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 2)*pager.pageSize!});">${(pager.pageNum - 2)!}</a></li>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
                <#elseif pager.pageNum gt 1>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
                </#if>
                <li class="active"><a><font color="white">${(pager.pageNum)!}</font></a></li>
                <#if (pager.totalPages - pager.pageNum) gt 1>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.nextPage)*pager.pageSize!});">${(pager.nextPage + 1)!}</a></li>
                <#elseif (pager.totalPages - pager.pageNum) gt 0>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
                </#if>
                <li>
                    <a aria-label="Next" href="javascript:void(0)" onclick="toPage(${(pager.totalPages-1)*pager.pageSize!});">
                        <span aria-hidden="true">»</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    </#if>
</#macro>
<#macro body>
<body>
    <#nested>
<div class="model-icon">本源量子</div>
<div class="first-bg" style="display:none;">
    <div class="first-del">
        <a href="###"><i class="iconfont icon-cha1"></i></a>
    </div>
    <div class="first-pic bounceIn animated">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <#--<img data-src="${base}/assets/images/a1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img data-src="${base}/assets/images/b1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img data-src="${base}/assets/images/c1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img data-src="${base}/assets/images/d1.png" />-->
                </div>
                <div class="swiper-slide">
                    <div class="ljty">
                        <a href="###"><@spring.message code="immediate_experience" /></a>
                    </div>
                    <img data-src="${base}/assets/images/e1.png" />
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
            <!-- Add Arrows -->
            <div class="swiper-button-next swiper-button-white"></div>
            <div class="swiper-button-prev swiper-button-white"></div>
        </div>
    </div>
</div>
<div id="BottomAppDown">
    <div id="ToApp">
        <img id="app_logoImg" class="app_logo rms_img" src="${base}/assets/images/bylz.png" data-bm="19" style="">
        <div id="app_title" class="app_title">
            <div id="ta_line1">下载本源量子云APP</br>获得更好的使用体验</div>
        <#--<div id="ta_line2" class="ta_supplement">请下载本源量子云APP</div>-->
        </div>
        <a id="app_download" class="app_link" mobile="iphone" _ctf="rdr_T" href="http://download.qubitonline.cn/" h="ID=SERP,5067.1" style="display: block;">
            <img data-src="${base}/assets/images/download_app.png" alt="">
        </a>
    <#--<div class="app_line"></div>-->
        <img id="ta_close" class="app_img" src="${base}/assets/images/taclose.png" data-bm="20">
    </div>
</div>
<script>
    var BottomAppDown=document.getElementById('BottomAppDown');
    function browserRedirect() {
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
        if (bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM) {
            //跳转移动端页面
            BottomAppDown.style.display="block"
        } else {
            BottomAppDown.style.display="none"
            //跳转pc端页面
        }
    }
    browserRedirect();
    // window.onresize=function () {browserRedirect();};
    var close_btn=document.getElementsByClassName("app_img")[0];
    close_btn.onclick=function () {BottomAppDown.style.display="none";}
    <#--function qubit(flag) {-->
        <#--<#if !USER_INFO??>-->
            <#--viewLoginMin();-->
            <#--return;-->
        <#--<#else>-->
            <#--if(flag == '1') {-->
                <#--window.location.href = "${base}/QCode/index.html";-->
            <#--}else {-->
                <#--window.location.href = "${base}/QCode/apply.html";-->
            <#--}-->

        <#--</#if>-->
    <#--}-->
</script>
</body>
</#macro>
<#macro footer>
<!-- Modal生成API KEY -->
<div class="modal fade" id="apiKeyModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display:none;">
    <div class="modal-dialog" role="document" style="width:500px;"><!--style="width:294px;" -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">API KEY</h4>
            </div>
            <div class="modal-body">
                <div class="contentt clear">
                    <div>
                        <input type="hidden" id="typeId" value="1">
                        <div class="zi">
                            <div class="zi-left" taskType="1" style="width:100%;">
                                <p id="apiKeyContent"></p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="createKey(1);"><@spring.message code="regenerate"/></button>
                            <button type="button" class="btn btn-primary" onclick="closeModel();"><@spring.message code="close"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer-container" style="height: 100px;display: none;background: #262f40;">
    <ul class="footer-box">
        <div class="footer" style="color: #fff;font-size: 12px;text-align: center;line-height: 100px;margin: 0">
            <#if lang?? && lang?string=="en_US">
            <span style="margin-right: 30px">Copyright©2017-2019 <a href="http://www.originqc.com.cn/" target="_blank" style="color: #fff;text-decoration: none"><@spring.message code='footer_company_name' /></a></span>
            <span style="margin-right: 30px"><@spring.message code='mobile' />: 0551-63836038</span>
            <span>Email : oqc@originqc.com</span>
            <#else>
                <span style="margin-right: 30px">Copyright©2017-2019 <a href="http://www.originqc.com.cn/" target="_blank" style="color: #fff;text-decoration: none"><@spring.message code='footer_company_name' /></a></span>
            <span style="margin-right: 30px"><@spring.message code='footer_company_code1' /></span>
            <span style="margin-right: 30px"><@spring.message code='footer_company_code2' /></span>
            <span style="margin-right: 30px"><@spring.message code='mobile' />: 0551-63836038</span>
            <span>Email : oqc@originqc.com</span>
            </#if>
        </div>
    </ul>
</div>
<script type="text/javascript" src="${base}/assets/js/messages_${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}.js"></script>
<script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
<script>
    var lan = '${lang}';
    var ctxPath = "${base}";
    var fromAdmin = undefined;
    var login = <#if USER_INFO??>true<#else>false</#if>;
    var _hmt = _hmt || [];

    var forward = "${forward!}";
    var registerUrl;
    var loginUrl;
    function addClass(elements, cName) {if (!hasClass(elements, cName)) {elements.className += " " + cName;}}
    function hasClass(elements, cName) {
        return !!elements.className.match(new RegExp("(\\s|^)" + cName + "(\\s|$)"));
    } // ( \\s|^ ) 判断前面是否有空格 （\\s | $ ）判断后面是否有空格 两个感叹号为转换为布尔值 以方便做判断}

    //用户下拉
    $('.admin').mouseenter(function () {
        $('.admin-none').css('display','block');
    }).mouseleave(function(e){
        $('.admin-none').css('display','none');
    });
    var flagM=1;

    //公共底部判断
    $(function () {setTimeout(function () {footerPosition();},1)});
    //社区使用
    function positionFooter() {
        // 获取页脚的高度
        footerHeight = $(".footer-container").height();
        // 获取页脚的高度
        ///scrollTop() 设置或获取位于对象最顶端和窗口中可见内容的最顶端之间的距离
        footerTop = ($(window).scrollTop()+$(window).height()-footerHeight)+"px";
        var height=$(document.body).height()+45;
        //如果页面内容高度小于屏幕高度，div#footer将绝对定位到屏幕底部，否则div#footer保留它的正常静态定位
        if(height > $(window).height())  {
            $(".footer-container").css({ position: "static",left:"0",width:"100%" }).stop().css({bottom:0});
        }else{
            $(".footer-container").css({ position: "fixed",left:"0",width:"100%" }).stop().css({bottom:0});
        }
    }
    var footercontainer = document.getElementsByClassName("footer-container")[0];
    function footerPosition(){
        var contentHeight = document.body.scrollHeight,//网页正文全文高度
                winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
        if(!(contentHeight > winHeight)){
            addClass(footercontainer,'fixed-bottom');
            footercontainer.style.display="block"
            positionFooter();
        } else {footercontainer.style.display="block";
            positionFooter();
        }
    }
    $(window).resize(function () {footerPosition();});

    $(function(){
        $(".navSwitch").hover(function () {$(".SwitchBtn").show()},function(){$(".SwitchBtn").hide()});
        var g=null;
        $(".UserSearchBtn").on("click",function () {clearTimeout(g);
//            $(this).css("min-width","46px");
            $(".Userinfo .InfoName").hide();
            $(this).find(".navSearch .navInput").css({"width":"158px","height":"40px","opacity":"1","margin-top":"25px"});
            $(this).find(".sea_input").css({"width":"116px"});
            $(this).find("a").hide();

        });
        $(".UserSearchBtn").on("mouseleave",function () {
            $(".Userinfo .InfoName").show();
            $this=$(this);
            $this.find(".navSearch .navInput").css({"width":"0","height":"0","opacity":"0","margin-top":"0"});
            $this.find(".sea_input").css({"width":"0"});
            $this.find("a").slideDown();
        })
    });
    function setCookie(name,value){
        var Days = 7; //有效期为7天
        //取出当前日期，加上7天，得出有效截止日期
        var exp = new Date();
        exp.setTime(exp.getTime()+7*24*60*60*1000);
        document.cookie=name +"="+escape(value) +";expries     ="+exp.toGMTString();
    }
    function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
</script>
<script type="text/javascript" src="${base}/assets/build/js/app.js?1.1"></script>
<link rel="stylesheet" class="cssLazy" href="">
<link rel="stylesheet" href="${base}/assets/js/layer-v3.1.1/layer/theme/default/layer.css">
<link rel="stylesheet" data-href="${base}/assets/plugins/select2/select2.css">
<style>circle{cursor:pointer;}  .focus{border:10px solid yellow;}</style>
<script>
    //弹出小框的登录
    function viewLoginMin(){
        layer.open({
            type : 2,
            title: false,
            closeBtn: 1, //不显示关闭按钮
//            title : "用户登录",
//            shadeClose : true,
            move : false,
            shade :0.1,
            area : [ '632px', '342px' ],
            shift : 2,
            skin:"login_bg",
            content : [ ctxPath+"/login.html", 'no' ]
        });
    }

    $(window).load(function() {
        $(".cssLazy").attr("href",'${base}/assets/fonts/iconfont.css?v1.0')
    });
    // 是否登录
    function isLogin() {
        <#if !USER_INFO??>
            errorMsg(messages.visitor_no_right);
            //window.location.href="${base}/login.html"
            return false;
        <#else>
            return true;
        </#if>
    }

    //切换语言
    function switchLanguage(){
        var url=window.location.href;
        var lan = '${lang}';
        if(lan=='en_US'){//中文
            if(url.indexOf("?lang=")>0 || url.indexOf("&lang=")>0){
                url = changeURLPar(url,'lang','zh_CN');
            }else{
                if(url.indexOf("?")>0){
                    url = url　+ "&lang=zh_CN";
                }else{
                    url = url　+ "?lang=zh_CN";
                }
            }
        }else{//英文
            if(url.indexOf("?lang=")>0 || url.indexOf("&lang=")>0){
                url = changeURLPar(url,'lang','en_US');
            }else{
                if(url.indexOf("?")>0){
                    url = url　+ "&lang=en_US";
                }else{
                    url = url　+ "?lang=en_US";
                }
            }
        }
        window.location.href=url;
    }
    //修改URL参数
    function changeURLPar(destiny, par, par_value){
        var pattern = par+'=([^&]*)';
        var replaceText = par+'='+par_value;
        if (destiny.match(pattern)){
            var tmp = '/\\'+par+'=[^&]*/';
            tmp = destiny.replace(eval(tmp), replaceText);
            return (tmp);
        }else{
            if (destiny.match('[\?]')){
                return destiny+'&'+ replaceText;
            }else{
                return destiny+'?'+replaceText;
            }
        }
        return destiny+'\n'+par+'\n'+par_value;
    }
</script>

    <#nested>
<script type="text/javascript" src="${base}/assets/js/layer-v3.1.1/layer/layer.js"></script>
</html>

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?f1954891ab72948425e7ca63a204c510";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    $("link[data-href]").each(function () {$(this).attr("href",$(this).attr("data-href"));});
    $("img[data-src]").each(function () {$(this).attr("src",$(this).attr("data-src"));});
    $("script[data-src]").each(function () {$(this).attr("src",$(this).attr("data-src"));});
</script>
</#macro>

<#macro footerJs>
<#--<script type="text/javascript" src="${base}/assets/js/bootstro.js"></script>-->
<#--<script type="text/javascript" src="${base}/assets/js/qiao.js"></script>-->
<script type="text/javascript" src="${base}/assets/plugins/select2/select2.js"></script>
<link rel="stylesheet" data-href="${base}/assets/js/popup/popup/style.css" />
<script type="text/javascript" data-src="${base}/assets/js/popup/drag.js"></script>
<script type="text/javascript" src="${base}/assets/js/dialog.js"></script>
<script>
    if(forward!=null&&forward!=''){
        registerUrl = ctxPath+"/Register/register.html?forward="+forward;
        loginUrl = ctxPath+"/login.html?forward="+forward;
    }else{
        registerUrl = ctxPath+"/Register/register.html";
        loginUrl = ctxPath+"/login.html";
    }


    $(".sign-up").attr("href",registerUrl);

    $(document).ready(function () {
        $('.showone').click(function () {
            $(".first").show();
            $(".second").hide();
            $(".there").hide();
        });
        $('.daima').click(function () {
            $(".case-bottom").getNiceScroll().resize();
        });
        //遮罩
        $('.moda').click(function () {
            $('.loading-bg').show();
            $('.loading').show();
            setTimeout("$('.loading').hide()",5000);
            setTimeout("$('.loading-bg').hide()",5000);
        });
        //指引
        $('.zhiyin').click(function () {
            $('.first-bg').hide();
            swiper.slideTo(0,10);
        });
        //幻灯片
        // var swiper = new Swiper('.swiper-container', {
        //     pagination: '.swiper-pagination',
        //     paginationClickable: '.swiper-pagination',
        //     nextButton: '.swiper-button-next',
        //     prevButton: '.swiper-button-prev',
        //     initialSlide: 0,
        //     spaceBetween: 30,
        //     observer:true,//修改swiper自己或子元素时，自动初始化swiper
        //     observeParents:true//修改swiper的父元素时，自动初始化swiper
        // });
        //点击关闭
        $('.first-del').click(function () {$('.first-bg').hide();});
        $('.ljty').click(function () {$('.first-bg').hide();});
        //加载幻灯片
        loadSlide();
    });

    function toModify(){window.location.href="${base}/Mine/modify.html";}

    //是否加载幻灯片
    function loadSlide(){
        <#if !USER_INFO??>
            var isRead = getCookie("isRead");
            if(isRead!='yes'||isRead==null){
                $('.first-bg').hide();
                setCookie("isRead","yes");
            }
        </#if>
    }

    //判断是否是教程案例
    function isCase(){
        var id = $("#projectId").val();
        if(id==257||id==258){
            errorMsg(messages.tutorial_cannot_modified);
            return false;
        }else{
            return true;
        }
    }

    //判断是否是半导体量子芯片案例
    function isSemi(){
        var id = $("#taskTypeId").val();
        if(id==3){
            errorMsg(messages.tutorial_cannot_modified);
            return false;
        }else{
            return true;
        }
    }


    //生成API KEY
    //isRepeat是否重新生成
    function createKey(isRepeat){
        var param ={};
        param.isRepeat = isRepeat;
        $.ajax({
            url:"${base}/QCode/createKey.json",
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            data:param,
            type:'post',
            success:function(result){
                if(result.code == 401){
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if(result.success){
                    $("#apiKeyContent").text(result.obj);
                    $('#apiKeyModel').modal('show');
                } else {
                    errorMsg(messages.option_fail);
                }
            },
            error:function(){
                errorMsg(messages.option_fail);
            }
        });
    }
    //关闭模态窗口
    function closeModel(){$('#apiKeyModel').modal('hide');}
    // var footerHeight = 0;
    // var footerTop = 0;
</script>
    <#nested>
</html>
</#macro>


<#macro forumTop>
<body onhashchange="getHash()" onload="initWebSocket('');">
    <#nested>
<#--顶部导航栏-->
<style>
    .footer-container{
        background: #000;
    }
    .login_bg{
        background: transparent!important;
        border-radius: 10px!important;
        box-shadow: none!important;
    }
    .layui-layer-setwin .layui-layer-close2{
        background: transparent;
        right: -19px!important;
        top: -11px!important;
    }
    .layui-layer-setwin .layui-layer-close2:before{
        content: '×';
        font-size: 18px;
        color: #333;
    }
</style>
<div class="navbarHeader">
    <div class="forContent">

        <div class="navLogo">
            <a href="${base}/qcode/forumtopic/index.html">
                <img src="${base}/assets/forImg/logo.png" alt="">
            </a>
        </div>
        <div class="SwitchBtnShowIndex">
            <a href="${base}/qcode/forumtopic/index.html">首页</a>
        </div>
        <div class="navSwitch" style="padding: 0 50px">
            <div class="SwitchBtnShow">
                <a href="javascript:void(0)">版块<i class="arrowJ">  &gt; </i></a>

            </div>
            <div class="Switchfix"></div>
            <div class="navSwiPost">
                <div class="SwitchBtn">
                    <#if blockList?? && (blockList)?size gt 0>
                        <#list blockList as blockList>
                            <a href="${base}/qcode/forumtopic/community.html?belonged=${blockList.id}">${blockList.blockName}</a>
                        </#list>
                    </#if>
                    <#--<a href="${base}/qcode/forumtopic/community.html?belonged=1">QPanda</a>-->
                    <#--<a href="${base}/qcode/forumtopic/community.html?belonged=2">量子算法</a>-->
                    <#--<a href="${base}/qcode/forumtopic/community.html?belonged=3">量子课程</a>-->
                </div>
            </div>
        </div>
        <div class="eduSwith"><a href="http://www.qubitonline.cn">量子云计算</a></div>
        <div class="eduSwith"><a href="https://learn-quantum.com/EDU/index.html">量子教育</a></div>
        <div class="navSearch" >
            <div class="navInput">
                <div class="sea_icon" id="globalSearch"><i></i></div>
                <div class="sea_input"><input type="text" placeholder="请输入搜索内容" id="searchContent"></div>
            </div>
        </div>
        <div class="navUser" style="float: right;">
            <#if (USER_INFO)??>
                <div class="Userinfo">
                    <div class="Usermessage"><a href="${base}/platform/forumuser/getForumInform.html"><img src="${base}/assets/forImg/news.png" alt="" id="notice"></a></div>
                    <div class="imgname">
                        <div class="InfoImg">
                            <a href="${base}/platform/forumuser/getForumUser.html">
                                <#if (USER_INFO.face)?exists>
                                    <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="">
                                <#else>
                                    <img src="${base}/assets/forImg/3.jpg" alt="">
                                </#if>
                        </div>
                        <div class="InfoName"><span><#if USER_INFO.name?? && USER_INFO.name?length gt 5>
                    ${USER_INFO.name?substring(0,5)}...
                    <#else>${USER_INFO.name!}</#if></span></a></div>
                        <div class="admin-list-box">
                            <ul>
                                <li>
                                    <a href="${base}/platform/forumuser/getForumUser.html#Article">
                                        <div class="admin-list-details">
                                            <i class="tz"></i><span>帖子</span><i class="sj"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="${base}/platform/forumuser/getForumUser.html#follow">
                                        <div class="admin-list-details">
                                            <i class="gz"></i>
                                            <span href="${base}/platform/forumuser/getForumUser.html#follow">关注 </span>
                                            <i class="sj"></i>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="${base}/platform/forumuser/getForumUser.html#Collection">
                                        <div class="admin-list-details">
                                            <i class="sc"></i>
                                            <span href="${base}/platform/forumuser/getForumUser.html#Collection">收藏 </span>
                                            <i class="sj"></i>
                                        </div>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="${base}/platform/forumuser/getForumUser.html#setting">
                                        <div class="admin-list-details UserSetting">
                                            <i class="sz"></i><span href="${base}/platform/forumuser/getForumUser.html#setting">设置</span><i class="sj"></i>
                                        </div>
                                    </a>

                                </li>
                            </ul>
                            <a href="${base}/logout.html?flag=forumLogout">
                                <div class="admin-list-details  UserSing" style="padding: 1px 20px;">
                                    <i class="tc"></i><span href="${base}/logout.html?flag=forumLogout">退出登录</span>
                                </div>
                            </a>
                        </div>

                    </div>
                </div>
            <#else>
                <a href="${base}/Register/register.html" class="UserSing">注册</a>
                <a href="javascript:;" onclick="viewLoginMin()" class="UserSing">登录</a>
            </#if>
        </div>
    </div>

</div>
<#--<div class="navbarHover"></div>-->

</body>
<script>
    var websocket;
    //初始话WebSocket
    function initWebSocket(toUserId) {
        if (window.WebSocket) {
            var ishttps = 'https:' == document.location.protocol ? true: false;
            if(ishttps){
                var wimadress = location.hostname + ":8887"
                websocket = new WebSocket(encodeURI('wss://'+wimadress));
            }else{
                var wimadress = location.hostname + ":8887"
                websocket = new WebSocket(encodeURI('ws://'+wimadress));
            }
            websocket.onopen = function() {
                //连接成功
                //main.ftl
                <#if USER_INFO??>
                    websocket.send(JSON.stringify({
                        message : {
                            userId : ${USER_INFO.id},
                            toUserId:toUserId
                        }
                    }));
                </#if>
            }
            websocket.onerror = function() {
                //连接失败
            }
            websocket.onclose = function() {
                //连接断开
            }
            //消息接收
            websocket.onmessage = function(msg) {
                // debugger;
                //主页面
                if(msg.data != "0") {
                    $("#notice").before('<i id="messageNum">'+msg.data+'</i>');
                }else {
                    $("#messageNum").remove();
                }
            }
        }
    }
</script>
</#macro>

<#macro forumTopLevel>
<body onhashchange="getHash()" onload="initWebSocket('');">
    <#nested>
<#--顶部导航栏-->
<style>
    .footer-container{background: #000;}
    .login_bg{background: transparent!important;border-radius: 10px!important;box-shadow: none!important;}
    .layui-layer-setwin .layui-layer-close2{background: transparent;right: -19px!important;top: -11px!important;}
    .layui-layer-setwin .layui-layer-close2:before{content: '×';font-size: 18px;color: #333;}
</style>
<div class="navbarHeader">
        <div class="forContent">

            <div class="navLogo">
                <a href="${base}/qcode/forumtopic/community.html">
                    <img src="${base}/assets/forImg/logo.png" alt="">
                </a>
            </div>
            <div class="SwitchBtnShowIndex">
                <a href="${base}/qcode/forumtopic/index.html">首页</a>
            </div>
            <div class="navSwitch" style="padding: 0 50px">
                <div class="SwitchBtnShow">
                    <a href="javascript:void(0)">版块<i class="arrowJ">  &gt; </i></a>

                </div>
            <div class="Switchfix"></div>
                <div class="navSwiPost">
                    <div class="SwitchBtn">
                        <#if blockList?? && (blockList)?size gt 0>
                            <#list blockList as blockList>
                                <a href="${base}/qcode/forumtopic/community.html?belonged=${blockList.id}">${blockList.blockName}</a>
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="eduSwith"><a href="http://www.qubitonline.cn">量子云计算</a></div>
            <div class="eduSwith"><a href="https://learn-quantum.com/EDU/index.html">量子教育</a></div>
            <div class="navSearch" >
                <div class="navInput">
                    <div class="sea_icon" id="globalSearch"><i></i></div>
                    <div class="sea_input"><input type="text" placeholder="请输入搜索内容" id="searchContent"></div>
                </div>
            </div>
            <div class="navUser" style="float: right;">
                <#if (USER_INFO)??>
                    <div class="Userinfo">
                        <div class="Usermessage"><a href="${base}/platform/forumuser/getForumInform.html"><img src="${base}/assets/forImg/news.png" alt="" id="notice"></a></div>
                        <div class="imgname">
                            <div class="InfoImg">
                                <a href="${base}/platform/forumuser/getForumUser.html">
                                    <#if (USER_INFO.face)?exists>
                                        <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="">
                                    <#else>
                                        <img src="${base}/assets/forImg/3.jpg" alt="">
                                    </#if>
                            </div>
                            <div class="InfoName"><span><#if USER_INFO.name?? && USER_INFO.name?length gt 5>
                    ${USER_INFO.name?substring(0,5)}...
                    <#else>${USER_INFO.name!}</#if></span></a></div>
                            <div class="admin-list-box">
                                <ul>
                                    <li>
                                        <a href="${base}/platform/forumuser/getForumUser.html#Article">
                                            <div class="admin-list-details">
                                                <i class="tz"></i><span href="${base}/platform/forumuser/getForumUser.html#Article">帖子</span><i class="sj"></i>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${base}/platform/forumuser/getForumUser.html#follow">
                                            <div class="admin-list-details">
                                                <i class="gz"></i>
                                                <span href="${base}/platform/forumuser/getForumUser.html#follow">关注 </span>
                                                <i class="sj"></i>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${base}/platform/forumuser/getForumUser.html#Collection">
                                            <div class="admin-list-details">
                                                <i class="sc"></i>
                                                <span href="${base}/platform/forumuser/getForumUser.html#Collection">收藏 </span>
                                                <i class="sj"></i>
                                            </div>
                                        </a>
                                    </li>
                                    <li >
                                        <a href="${base}/platform/forumuser/getForumUser.html#setting">
                                            <div class="admin-list-details UserSetting">
                                                <i class="sz"></i><span href="${base}/platform/forumuser/getForumUser.html#setting">设置</span><i class="sj"></i>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                                <a href="${base}/logout.html?flag=forumLogout">
                                    <div class="admin-list-details  UserSing" style="padding: 1px 20px;">
                                        <i class="tc"></i><span href="${base}/logout.html?flag=forumLogout">退出登录</span>
                                    </div>
                                </a>
                            </div>

                        </div>
                    </div>

                <#else>
                    <a href="${base}/Register/register.html" class="UserSing">注册</a>
                    <a href="javascript:;" onclick="viewLoginMin()" class="UserSing">登录</a>
                </#if>
            </div>
        </div>

    </div>

    <script>
    var websocket;
    //初始话WebSocket
    function initWebSocket(toUserId) {
        if (window.WebSocket) {
	        var ishttps = 'https:' == document.location.protocol ? true: false;	
			if(ishttps){
				var wimadress = location.hostname + "/websocket"
				websocket = new WebSocket(encodeURI('wss://'+wimadress));
			}else{		
				var wimadress = location.hostname + ":8887"
				websocket = new WebSocket(encodeURI('ws://'+wimadress));
			}
            websocket.onopen = function() {
                //连接成功
                //main.ftl
                <#if USER_INFO??>
                    websocket.send(JSON.stringify({
                        message : {
                            userId : ${USER_INFO.id},
                            toUserId:toUserId
                        }
                    }));
                </#if>
            }
            websocket.onerror = function() {
                //连接失败
            }
            websocket.onclose = function() {
                //连接断开
            }
            //消息接收
            websocket.onmessage = function(msg) {
                $("#messageNum").remove();
                if(msg.data != "0") {
                    $("#notice").before('<i id="messageNum">'+msg.data+'</i>');
                }else {
                    $("#messageNum").remove();
                }
            }
        }
    }
</script>
</body>
</#macro>
