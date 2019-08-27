<@main.header title="首页">
<#escape x as x?html> 
 </#escape> 
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content" style="height: 80px;">
    <!--top-->
<@main.top5>
    <#escape x as x?html>
    </#escape>
</@main.top5>
    <style>
        .Edu_box{
            background: #282828;
        }
    </style>
    <div class="container m-t-40 container-border">
        <div class="row" style="padding: 20px 15px 40px 15px;">
            <!-- registerBox-->
            <div class="col-md-6 left-box" style="position: relative;">
                <h3 class="notice-title"><@spring.message code="improve_new_account_information" /></h3>
                <div class="notice-content">
                    <p class="m-b-0"><b><@spring.message code="prompt" />：</b><@spring.message code="build_quantum_account_prompt" /></p>
                </div>
                <form role="form">
                    <input type="hidden" class="form-control" name="appId"   id="appId1"  value="${appId!}" maxlength="32">
                    <div class="form-group">
                        <label for="E-mail"><@spring.message code="user_login_name" /></label>
                        <input type="text" class="form-control" name="email" id="email" placeholder="<@spring.message code='placeholder_email' />" maxlength="32">
                    </div>
                    <div class="form-group">
                        <label for="name"><@spring.message code="name" /></label>
                        <input type="text" class="form-control" name="nickname" id="nickname" value="${nickname!}" placeholder="<@spring.message code='application_placeholder_name' />"maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="password"><@spring.message code="password" /></label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                    </div>
                    <div class="form-group">
                        <label for="confirm-password"><@spring.message code="confirm_password" /></label>
                        <input type="password" class="form-control"  name="confirmPassword" id="confirmPassword" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                    </div>
                    <div class="form-group text-right">
                        <button type="button" class="btn btn-primary btn-sm" onclick="register();"><@spring.message code="sign_up" /></button>
                    </div>
                </form>
                <b class="OR">OR</b>
            </div>
            <!--registerBox end-->
            <!-- loginBox-->
            <div class="col-md-6 right-box">
                <h3 class="notice-title"><@spring.message code="improve_existing_account_information" /></h3>
                <div class="notice-content">
                    <p class="m-b-0"><b><@spring.message code="prompt" />：</b><@spring.message code="bind_quantum_account_prompt" /></p>
                </div>
                <form role="form" id="qcodeUserAccount">
                    <input type="hidden" class="form-control" name="appId"   id="appId2"  value="${appId!}" maxlength="32">
                    <div class="form-group">
                        <label for="Email"><@spring.message code="user_login_name" /></label>
                        <input type="text" class="form-control" name="email" placeholder="<@spring.message code='placeholder_email' />">
                    </div>
                    <div class="form-group">
                        <label for="my-password"><@spring.message code="password" /></label>
                        <input type="password" class="form-control" name="password" placeholder="<@spring.message code='placeholder_password' />">
                    </div>
                    <div class="form-group text-right">
                        <button type="button" class="btn btn-primary btn-sm  btn-login"><@spring.message code='bind_quantum_account' /></button>
                    </div>
                </form>
            </div>
            <!--loginBox end-->
        </div>
    </div>
</div>

</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>

<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>

 function clickButton(obj){
        var obj = $(obj);
        obj.attr("disabled","disabled");
        var time = 60;
        var set=setInterval(function(){
            obj.val(--time+"(s)");
        }, 1000);

        setTimeout(function(){
            obj.attr("disabled",false).val("重新获取验证码");
            clearInterval(set);
        }, 60000);
    }


function register(){		
	re = /^(\w-*\.*)+@(\w-?)+(\.\w+)+$/;
	if(!re.test($("#email").val())){
		errorMsg(messages.enter_email_true);
        return false;  
	}
	var password = $("#password").val();
	var confirmPassword = $("#confirmPassword").val();
	/**if ((!/^[A-Za-z0-9]{8,16}$/.test(password))||(!/^[A-Za-z0-9]{8,16}$/.test(confirmPassword))) { 
	 	errorMsg(messages.password_six_to_eight);
        return false;  
    }*/	
    if (password.length<6){
    	errorMsg(messages.password_six);
        return false; 
    }
    if (confirmPassword.length<6){
    	errorMsg(messages.confirm_password_six);
        return false; 
    }    
	if(password!=confirmPassword){
		errorMsg(messages.password_not_same);
		return false;
	}
	var code = $("#captcha").val();	
	if(code==''){
		errorMsg(messages.volidate_code_not_null);
		return false;
	}	
	
	var param ={};
	param.email = $("#email").val();
	param.password = $.md5(password);
	param.nickname = $("#nickname").val();
	param.appId = $("#appId1").val();
	param.code = code;
	//表单提交
	$.ajax({
		url:"${base}/Register/thirdRegisterSave.json",
		data:param,
		cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
		type:'post', 
		success:function(result){
			if(result.code == 401){
                window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
	            return false;
            }
			if(result.success){ 
					var n = noty({
			            text        : messages.init_waiting,
			            type        : 'success',
			            dismissQueue: true,
			            layout      : 'topCenter',
			            theme       : 'relax',
			            timeout		: 1500,
			            callback: {     // 设置回调函数
					        afterClose: function() { 
						            if(forward!=null&&forward!=''){
						          	  location.href = forward;
						            }else{
						          	  location.href = "${base}/index.html";
						            }
					            }
					    }
			        });			
			} else {
	  			errorMsg(result.message);
			}
		},
		error:function(){		
		 	errorMsg(messages.register_fail);
		 	loading = false;
		}
	});   
}

// 更换验证码
$('#captchaImage').click(function(){
     $('#captchaImage').attr("src", "${base}/assets/register_vcode_image.jsp?timestamp=" + (new Date()).valueOf());
}); 

//跳转登陆页面
function login(){

	var forward = "${forward!}";
	if(forward!=null&&forward!=''){
		window.location.href = "${base}/login.html?forward="+forward;
	  }else{
		window.location.href = "${base}/login.html";
	  }
	
}


//以下内容为已有量子用户的相关操作
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
		params.email = $("#qcodeUserAccount input[name='email']").val();
		params.password = $.md5($("#qcodeUserAccount input[name='password']").val());
		params.appId = $("#appId2").val();
        params.appType = '${QcodeThirdLogin.APPTYPE_WE_CHAT}';    

        $.post('${base}/doLogin.json', params,
        function(data) {
            if (data.success) {
                if (forward != null && forward != '') {
                    location.href = forward;
                } else {
                    location.href = "${base}/index.html";
                }

            } else {
                errorMsg(data.message);
            }
        });
    });

    $(".weChat-login").click(function() {
        location.href = "${weChatLogin!}"
    });

});
</script>
</@main.footer>
