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
    <style>
        .Edu_box{
            background: #282828;
        }
    </style>
        <div class="modal-dialog" role="document" style="margin-top: 150px;">
            <div class="modal-content" style="box-shadow: 0 1px 4px rgb(217, 217, 217);-webkit-box-shadow: 0 1px 4px rgb(217, 217, 217);">
                <div class="modal-header">

                    <h4 class="modal-title" id="myModalLabel"><@spring.message code="modify_password" /></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputPassword3" class="col-sm-2 control-label"><@spring.message code="password" /></label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" id="password" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword8" class="col-sm-2 control-label"><@spring.message code="confirm_password" /></label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="<@spring.message code='placeholder_password_6' />" maxlength="50">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="save();"><@spring.message code="save" /></button>
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
var isEmail = "${isEmail!''}";

function save(){		
	var password = $("#password").val();
	var confirmPassword = $("#confirmPassword").val();
	
	var email = "${USER_INFO.email!}";
	var createTime = "";
	if(isEmail!=null && isEmail!=undefined && isEmail=="true"){
		email = "${emailStr!''}";
		createTime = "${createTimeStr!''}";
	}
	
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
	var param ={};
	param.confirmPassword = confirmPassword;
	param.password = password;
	param.email = email;
	param.createTime = createTime;
	param.isEmail = isEmail;

	//表单提交
	$.ajax({
		url:"${base}/Mine/modifySave.json",
		data:param,
        async:false,
		cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
		type:'post', 
		success:function(result){
			if(result.code == 401){
                window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
	            return false;
            }
			if(result.success){ 
				var n = noty({
			            text        : messages.pwd_update_success,
			            type        : 'success',
			            dismissQueue: true,
			            layout      : 'topCenter',
			            theme       : 'relax',
			            timeout		: 1500,
			            callback: {     // 设置回调函数
					        afterClose: function() { window.location.href = "${base}/logout.html";}
					    }
			        });			
			} else {
	  			errorMsg(result.message);
			}
		},
		error:function(){
		 	errorMsg(messages.option_fail);
		 	loading = false;
		}
	});   
}

function toModify(){
	window.location.href="${base}/Mine/modify.html";
}
</script>
</@main.footer>
 