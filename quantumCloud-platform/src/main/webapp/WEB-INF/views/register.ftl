<@main.header title="首页">
<#escape x as x?html> 
  <style>
    body{ text-align:center} 
    .divcss{margin:0 auto;width:300px;height:100px} 
 </style> 
 </#escape> 
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
<!--box-->
        <div class="modal-dialog" role="document" style="margin-top: 150px;">
            <div class="modal-content" style="box-shadow: 0 1px 4px rgb(217, 217, 217);-webkit-box-shadow: 0 1px 4px rgb(217, 217, 217);">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel"><@spring.message code="sign_up" /></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail2" class="col-sm-3 control-label"><@spring.message code="user_login_name" /></label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" name="email" id="email" placeholder="<@spring.message code='placeholder_email' />" maxlength="32">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-3 control-label"><@spring.message code="password" /></label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" name="password" id="password" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword8" class="col-sm-3 control-label"><@spring.message code="confirm_password" /></label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword1" class="col-sm-3 control-label"><@spring.message code="verification_code" /></label>
                            <div class="col-sm-6">
								<input type="text" id="captcha" name="captcha" class="form-control"  placeholder="<@spring.message code='placeholder_captcha' />" maxlength="10" />
                            </div>
                            <div class="col-sm-3" style="float:left;">
					        	<img id="captchaImage" style="cursor:pointer;" src="${base}/assets/register_vcode_image.jsp"/>                                 
                            </div>
                        </div>   
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="register();" style="float: left;margin-left: 148px;width: 100px;text-align: center;"><@spring.message code="sign_up" /></button>
					<div style="text-align: right;line-height: 34px;">
						<@spring.message code="Alreadyac" /><a href="#"  onclick="login();" style="color: #337ab7;font-weight: 600"><@spring.message code="to_login" /></a>
					</div>

                </div>
            </div>
        </div>

<!--box end-->
</div>
</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script type='text/javascript' src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>
<script>
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
	param.name = $("#name").val();
	param.orgName = $("#orgName").val();
	param.password = $.md5(password);
	param.code = code;
	//表单提交
	$.ajax({
		url:"${base}/Register/registerSave.json",
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
			            text        : messages.register_success_login,
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
	<#if !USER_INFO??>
	    viewLoginMin();
	    return;
	</#if>
	var forward = "${forward!}";
	if(forward!=null&&forward!=''){
		window.location.href = "${base}/login.html?forward="+forward;
	  }else{
		window.location.href = "${base}/login.html";
	  }
	
}
</script>
</@main.footer>
 