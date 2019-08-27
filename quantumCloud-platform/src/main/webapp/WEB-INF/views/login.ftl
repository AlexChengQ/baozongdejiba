<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header title="登录">
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="content" style="min-height: 600px">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>

<!--top end-->
<!--box-->
<div style="margin: 0 auto; width:600px; padding-top:120px;">
	<#if msg??>
	<#if msg.type?? && msg.type=='success'>
		<div class="alert alert-success" role="alert">${msg.msg!''}</div>
	</#if>
	<#if msg.type?? && msg.type=='error'>
		<div class="alert alert-danger" role="alert">${msg.msg!''}</div>
	</#if>
	<#if msg.type?? && msg.type=='info'>
		<div class="alert alert-info" role="alert">${msg.msg!''}</div>
	</#if>
    </#if>
</div>

    <style type="text/css">
        .login_main {
            margin-top: 0px;

        }
        .layui-layer-title {
            height: 40px;
            font-size: 16px;
        }
        .LoginContent{
            margin: 0 auto;
            width: 632px;
            height: 342px;
            position: relative;
            background: url(${base}/assets/images/Loginbg.png)  ;

            /*background: #000;*/


            /*position: relative;*/
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        body{
            margin: 0;
            padding: 0;
        }
        .LoginConLeft{
            width: 245px;
            margin-right: 72px;
            text-align: center;
            float: left;
            height: 100%;
            padding-top: 46px;
        }
        .com_name{
            margin-top: 22px;
            font-size: 22px;
            color: #fff;
            line-height: 26px;
            margin-bottom: 75px;
        }
        .go_home_login{

            font-size: 12px;
            color: #ccc;
            line-height: 12px;
            text-decoration: underline;
        }
        .go_home_login:hover{
            color: #fff;
        }
        .LoginConRight{
            width: 244px;
            padding-top: 46px;
            float: left;
        }
        .LoginLabel{
            height: 31px;
            padding-left: 30px;
            line-height: 30px;
            border-bottom: 1px solid #666;
            background: url(${base}/assets/images/usernameImg.png) left center no-repeat;
        }
        .LoginLabel input{
            border: none;
            line-height: 28px;
            outline: none;font-size: 14px;
            width: 100%;
            color: #666;

        }
        .LoginLabel input:focus{
            outline: none;
            border: none;
            box-shadow: none;
        }
        input:-webkit-autofill, textarea:-webkit-autofill, select:-webkit-autofill{
            -webkit-box-shadow: 0 0 0px 1000px white inset;
            -webkit-text-fill-color: #333;
        }
        .LoginLabel.mar28{
            margin-bottom: 28px;

        }
        .LoginLabel.bg{
            background-image: url(${base}/assets/images/passwordImg.png);
        }
        .LoginRdBox{
            font-size: 12px;
            line-height: 12px;
            margin-top: 14px;
            height: 38px;
        }
        .LoginRdLeft{
            float: left;
            color: #666;
            cursor: pointer;
        }
        .LoginRdLeft i{
            float: left;
            width: 8px;
            height: 8px;
            margin-top: 2px;
            margin-right: 5px;
            border: 1px solid #666;
        }
        .LoginRdLeft i.active{
            background: #666;
        }
        .LoginRdRight{
            float: right;

        }
        .LoginRdRight a{
            text-decoration: none;
            color: #178cec;
        }
        .to_login{
            width: 100%;
            height: 47px;

        }
        .to_login a{
            width: 100%;
            height: 100%;
            background: url(${base}/assets/images/enterBtn.png) no-repeat;
            display: block;
            text-align: center;
            line-height: 47px;
            color: #fff;
        }
        .to_wechat{
            width: 100%;
            margin: 20px 0;
            text-align: center;
        }
        .to_wechat i{
            float: left;
            width: 100%;
            height: 1px;
            margin-top: 18px;
            background: #e6e6e6;
        }
        .to_wechat img{
            margin-top: -18px;
        }
        .to_regiter{
            text-align: center;
            font-size: 12px;
        }
        .to_regiter span{
            color: #666;
        }
        .to_regiter a{
            text-decoration: none;
            color: #178cec;
        }


        input.active::-webkit-input-placeholder{
            color:#c23131;
        }
        input.active::-moz-placeholder{   /* Mozilla Firefox 19+ */
            color:#c23131;
        }
        input.active:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
            color:#c23131;
        }
        input.active:-ms-input-placeholder{  /* Internet Explorer 10-11 */
            color:#c23131;
        }
        .ajaxError{
            font-size: 12px;
            margin-top: 8px;
            clear: both;
            display: none;
            color: #c23131;
            text-align: center;
            float: left;
            width: 100%;

        }
        .LoginContent .close{
            position: absolute;
            right: 13px;
            top: 7px;
            text-decoration: none;
            font-size: 18px;
            color: #333;
            display: none;
        }
        .admin{
            display: none!important;
        }
        #userSo786{
            display: none!important;
        }
    </style>
    <div class="LoginContent">
        <div class="LoginConLeft">
            <img src="${base}/assets/images/logomin.png" alt="">
            <div class="com_name">
                本源量子</br>
                云平台
            </div>
            <a class="go_home_login" href="javascript:" onclick="window.parent.location='${base}/QCode/index.html'">返回首页</a>
        </div>
        <div class="LoginConRight">
            <div class="LoginLabel mar28">
                <input type="email" class="form-controlM" name="email" placeholder="<@spring.message code='placeholder_email' />">
            </div>
            <div class="LoginLabel bg">
                <input type="password" class="form-controlM" name="password" placeholder="<@spring.message code='placeholder_password' />">
            </div>
            <div class="LoginRdBox">

                <div class="LoginRdLeft">
                    <div class="checkboxBtn">
                        <i></i>
                        记住密码
                    </div>
                </div>
                <div class="LoginRdRight"><a href="javascript:" onclick="toForget()">忘记密码？</a> </div>

                <div class="ajaxError">账号信息不正确</div>
            </div>
            <div class="to_login">
                <a href="javascript:" onclick="submitLogin()"></a>
            </div>
            <div class="to_wechat">
                <i></i>
                <a href="javascript:"><img src="${base}/assets/images/wchatImg.png" alt=""></a>
            </div>
            <div class="to_regiter">
                <span>还没有账号？ </span><a class="btn-sign-up" href="javascript:">立即注册</a>
            </div>
        </div>
    </div>

        <div class="modal-dialog" role="document" style="margin-top: 40px;display: none">
            <div class="modal-content" style="box-shadow: 0 1px 4px rgb(217, 217, 217);-webkit-box-shadow: 0 1px 4px rgb(217, 217, 217);">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel"><spring:message code="login" /></h4>
                    <p>${msg!''}</p>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-3 control-label"><@spring.message code="user_login_name" /></label>
                            <div class="col-sm-9">
                                <#--<input type="email" class="form-control" name="email" placeholder="<@spring.message code='placeholder_email' />">-->
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-3 control-label"><@spring.message code="password" /></label>
                            <div class="col-sm-9">
                                <#--<input type="password" class="form-control" name="password" placeholder="<@spring.message code='placeholder_password' />">-->
                            </div>
                        </div>
                        <div style="width: 100%;height: 25px;line-height: 25px;">
							<span style="float: right;cursor: pointer;" onclick="toForget();"><@spring.message code="forgot_password" /></span>
						</div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-sm btn-login" style="float: left;margin-left: 148px;width: 100px;text-align: center;"><@spring.message code="login" /></button>
                    <#--<button type="button" class="btn btn-primary btn-sm btn-sign-up"><@spring.message code="sign_up" /></button>-->
                    <div style="text-align: right;line-height: 34px;">
                        <@spring.message code="NowRe" /><a href="#" class="btn-sign-up" style="color: #337ab7;font-weight: 600"><@spring.message code="to_register" /></a>
                    </div>
                    <!-- <button type="button" class="btn btn-primary btn-sm weChat-login">微信登录</button> -->
                </div>
            </div>
        </div>

<!--box end-->
</div>

<div class="quick-login" style="display:none;">
    <div class="weui-loadmore weui-loadmore_line">
        <span class="weui-loadmore__tips">快速登录</span>
    </div>
    <div class="q-login-list">
        <ul>
            <li>
                <a href="javascript:void(0)" class="weChat-login">
                <i class="iconfont icon-weixin"></i>
                </a>
            </li>
        </ul>
    </div>
</div>

</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>
    $(document).keydown(function(event) {
        if (event.keyCode == 13) {
            $(".btn-login").click();
        }
    });


    if(getCookie("isCookies")==1){
        $(".LoginRdLeft").find("i").addClass("active");
        $("input[name='email']").val(getCookie("getUsername"));
        $("input[name='password']").val(getCookie("getPassword"))
    }else {
        $("input[name='email']").val('');
        $("input[name='password']").val('')
    }

    <#--if (window.parent != window) {-->
    <#--console.log(window.parent);-->
    <#--window.parent.location.href = "${base}/login";-->
    <#--}-->

    $(".LoginRdLeft").on("click",function () {
        $(this).find("i").toggleClass("active")
    });


    $(document).ready(function() {
        var forward = "${forward!}";
        $(".btn-sign-up").click(function() {

            if(forward!=null&&forward!=''){
                parent.location.href = "${base}/Register/register.html?forward="+forward;
            }else{
                parent.location.href = "${base}/Register/register.html";
            }

        });

        $(".to_wechat").click(function() {
            parent.location.href = "${weChatLogin!}"
        });

    });


    //设置cookie
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    }
    //获取cookie
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i=0; i<ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1);
            if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
        }
        return "";
    }
    //清除cookie
    function clearCookie(name) {
        setCookie(name, "", -1);
    }
    //添加抖动
    jQuery.fn.shake = function (intShakes /*Amount of shakes*/, intDistance /*Shake distance*/, intDuration /*Time duration*/) {
        this.each(function () {
            var jqNode = $(this);
            jqNode.css({ position: 'relative' });
            for (var x = 1; x <= intShakes; x++) {
                jqNode.animate({ left: (intDistance * -1) }, (((intDuration / intShakes) / 4)))
                        .animate({ left: intDistance }, ((intDuration / intShakes) / 2))
                        .animate({ left: 0 }, (((intDuration / intShakes) / 4)));
            }
        });
        return this;
    };
    //忘记密码
    function toForget(){
        window.parent.location.href="${base}/Mine/forget.html";
    }


    //    完成登录

    function submitLogin() {
        var forward = "${forward!}";
        var params = {};
        params['email'] = $("input[name=email]").val();
        params['password'] = $.md5($("input[name=password]").val());

        if(params['email']==''||params['email']==null){
            $("input[name=email]").attr('placeholder','请输入邮箱地址');
            $("input[name=email]").addClass("active");
            return false;
        }else {
            $("input[name=email]").removeClass("active");
        }

        if($("input[name=password]").val()==''||$("input[name=password]").val()==null){
            $("input[name=password]").attr('placeholder','请输入密码');
            $("input[name=password]").addClass("active");
            return false;
        }else {
            $("input[name=password]").removeClass("active");
        }
        $.post('${base}/doLogin.json', params, function(data) {
            if (data.success) {
                $(".ajaxError").hide();
                if($(".LoginRdLeft").find("i").hasClass("active")){
                    setCookie("isCookies",1);
                    setCookie("getUsername", $("input[name='email']").val());
                    setCookie("getPassword", $("input[name='password']").val());
                }else{
                    setCookie("isCookies",'0');
                    setCookie("getUsername", '');
                    setCookie("getPassword", '')
                }
                if(forward!=null&&forward!=''){
                    window.parent.location.href = forward;
                }else{
                    parent.location.reload();
                }

            } else {
                $(".ajaxError").show();
                $(".LoginContent").shake(2, 10, 400);
//                errorMsg(data.message);
            }
        });
    }
</script>
<script>
//    $(".footer-container").css("position","static")

  $(document).keydown(function(event) {
    if (event.keyCode == 13) {
      $(".btn-login").click();
    }
  });

  if (window.parent != window) {
    window.parent.location.href = "${base}/login";
  }
  $(document).ready(function() {

	var forward = "${forward!}";
	
    $(".btn-login").click(function() {
      var params = {};
      params['email'] = $("input[name=email]").val();
  	  params['password'] = $.md5($("input[name=password]").val());;
      $.post('${base}/doLogin.json', params, function(data) {
        if (data.success) {
          if(forward!=null&&forward!=''){
        	  location.href = forward;
          }else{
        	  location.href = "${base}/index.html";
          }
          
        } else {
          errorMsg(data.message);
        }
      });
    });
    
    $(".btn-sign-up").click(function() {

            if(forward!=null&&forward!=''){
          	    location.href = "${base}/Register/register.html?forward="+forward;
            }else{
            	location.href = "${base}/Register/register.html";
            }

      });
      
     $(".weChat-login").click(function() {
          	    location.href = "${weChatLogin!}"
      });
      
  });
  
  //忘记密码
  function toForget(){
  	window.location.href="${base}/Mine/forget.html";
  }
</script>
</@main.footer>
