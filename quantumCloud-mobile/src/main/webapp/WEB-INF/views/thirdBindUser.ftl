<#-----author:JT------->
<#-----date:2018-01-16------->
<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div id="tab">
    <ul class="tab_menu">
        <li class="selected">注册</li>
        <li>绑定</li>
    </ul>
    <div class="tab_box">
        <div>
            <div class="weui-cells weui-cells_form" style="margin-top: 0;">
 				<input type="hidden" class="form-control" name="appId" id="appId"    value="${RequestParameters.appId!}" maxlength="32">
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">用户名</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input filteEmoji" type="email" id="email" name="email" placeholder="请输入Email地址">
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">姓名</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input filteEmoji" type="text" id="name" name="name"  value="${name!}" placeholder="请输入姓名(1-20位的中英文)" maxlength="20">
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">密码</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input filteEmoji" type="password" type="password" id="password" placeholder="至少六位" minlength="6">
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label filteEmoji">确认密码</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="password"  id="confirmPassword" 	name="confirmPassword" placeholder="至少六位" minlength="6">
                    </div>
                </div>
            </div>
            <div class="button" style="margin-top: 20px;text-align: center;">
                <a href="javascript:;" style="display: inline-block;width: 35%;float: none;" onclick="register()">注册</a>
            </div>

        </div>
        <div class="hide">
			<form  id="qcodeUserAccount">
            	<div class="weui-cells weui-cells_form" style="margin-top: 0;">
                	<div class="weui-cell">
                    	<div class="weui-cell__hd">
                        	<label class="weui-label ">邮箱</label>
                    	</div>
                    	<div class="weui-cell__bd">
                      		<input class="weui-input filteEmoji" type="email" name="email"  placeholder="请输入Email地址">
                    	</div>
                	</div>
                	<div class="weui-cell">
                    	<div class="weui-cell__hd">
                        	<label class="weui-label ">密码</label>
                    	</div>
                    	<div class="weui-cell__bd">
                        	<input class="weui-input filteEmoji" type="password"  name="password"  placeholder="至少六位" minlength="6">
                    	</div>
                	</div>
            	</div>
 			</form>
            <div class="button" style="margin-top: 20px;text-align: center;">
                <a href="javascript:;" style="display: inline-block;width: 35%;float: none;" onclick="bindExistAccount()">绑定该账号</a>
            </div>
        </div>
    </div>
</div>


</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>
    var $tab_li = $('#tab ul li');
    $tab_li.click(function(){
        $(this).addClass('selected').siblings().removeClass('selected');
        var index = $tab_li.index(this);
        $('div.tab_box > div').eq(index).show().siblings().hide();
    });


	App.setTitle("快捷登陆");
	function register() {
		re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
		if (!re.test($("#email").val())) {
			App.prompt(messages.enter_email_true);
			return false;
		}
		if ($("#name").val() == '') {
			App.prompt(messages.name_not_null);
			return false;
		}
		var password = $("#password").val();
		var confirmPassword = $("#confirmPassword").val();
		/**if ((!/^[A-Za-z0-9]{8,16}$/.test(password))||(!/^[A-Za-z0-9]{8,16}$/.test(confirmPassword))) { 
		 	App.prompt(messages.password_six_to_eight);
		    return false;  
		}*/
		if (password.length < 6) {
			App.prompt(messages.password_six);
			return false;
		}
		if (confirmPassword.length < 6) {
			App.prompt(messages.confirm_password_six);
			return false;
		}
		if (password != confirmPassword) {
			App.prompt(messages.password_not_same);
			return false;
		}
		
		var param = {};
		param.email = $("#email").val();
		param.name = $("#name").val();
		param.password = $.md5(password);
		param.appId = $("#appId").val();
		//表单提交
		$.ajax({
			url : "${base}/thirdRegisterSave.json",
			data : param,
			cache : false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
			type : 'post',
			success : function(result) {
				if (result.code == 401) {
					window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
					return false;
				}
				if (result.success) {
					App.openNew("${base}/QCode/index.html");
        	  		App.close();
				} else {
					App.prompt(result.message);
				}
			},
			error : function() {
				App.prompt(messages.register_fail);
				loading = false;
			}
		});
	}

	//绑定已有账户
	function bindExistAccount(){
        
    	var params = {};
		params.email = $("#qcodeUserAccount input[name='email']").val();
		params.password = $.md5($("#qcodeUserAccount input[name='password']").val());
		params.appId = $("#appId").val();
        params.appType = '${QcodeThirdLogin.APPTYPE_WE_CHAT}';     
           
        $.post('${base}/doLogin.json', params, function(data) {
         if (data.success) {
        	  App.setToken(data.obj);
        	  App.openNew("${base}/QCode/index.html");
        	  App.close();
          } else {
            App.prompt(data.message);
          }
        });
	}
</script>
</@main.footer>