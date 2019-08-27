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
                    <h4 class="modal-title" id="myModalLabel" onclick="toForget();"><@spring.message code="forgot_password" /></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail2" class="col-sm-2 control-label"><@spring.message code="register_email" /></label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" name="email" id="email" placeholder="<@spring.message code='placeholder_email' />" maxlength="32">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="save();"><@spring.message code="send_volidate_message" /></button>
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
function save(){		
	re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
	if(!re.test($("#email").val())){
		errorMsg(messages.enter_email_true);
        return false;  
	}	
	
	var param ={};
	param.email = $("#email").val();

	//表单提交
	$.ajax({
		url:"${base}/Mine/sendCheckEmail.json",
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
			            text        : messages.send_message_login_mail,
			            type        : 'success',
			            dismissQueue: true,
			            layout      : 'topCenter',
			            theme       : 'relax',
			            timeout		: 3000,
			            callback: {     // 设置回调函数
					        afterClose: function() { window.location.href = "${base}/index.html";}
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

</script>
</@main.footer>
 