<#-----author:JT------->
<#-----date:2018-01-16------->
<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="weui-cells weui-cells_form">
	<form class="form-horizontal">
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">用户登陆名</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input filteEmoji" type="email" id="email" name="email"
					placeholder="请输入Email地址">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">密码</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input filteEmoji" type="password" id="password"
					name="password" placeholder="至少六位" minlength="6">
			</div>
		</div>
		<div class="weui-cell">
			<div class="weui-cell__hd">
				<label class="weui-label">确认密码</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input filteEmoji" type="password" id="confirmPassword"
					name="confirmPassword" placeholder="至少六位" minlength="6">
			</div>
		</div>
		<div class="weui-cell weui-cell_vcode">
			<div class="weui-cell__hd">
				<label class="weui-label">验证码</label>
			</div>
			<div class="weui-cell__bd">
				<input class="weui-input filteEmoji" type="text" id="captcha" name="captcha"
					placeholder="请输入验证码">
			</div>
			<div class="weui-cell__ft">
				<img class="weui-vcode-img" id="captchaImage"
					style="cursor: pointer;"
					src="${base}/assets/register_vcode_image.jsp">
			</div>
		</div>
	</form>
</div>
<div class="button" style="margin-top: 20px; text-align: center;">
	<a href="javascript:;" onclick="register();"
		style="display: inline-block; width: 35%; float: none;">注册</a>
	<a href="${base}/login.html" onclick="login();"
		style="display: inline-block; width: 35%; float: none;">登录</a>
</div>
</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>


	

	//注册
	$(function() {
		App.setTitle("注册");
		App.dragRefresh();
	});

	function register() {
		re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
		if (!re.test($("#email").val())) {
			App.prompt(messages.enter_email_true);
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
		var code = $("#captcha").val();
		if (code == '') {
			App.prompt(messages.volidate_code_not_null);
			return false;
		}
		var param = {};
		param.email = $("#email").val();
		param.password = $.md5(password);
		param.code = code;

		//表单提交
		$.ajax({
			url : "${base}/registerSave.json",
			data : param,
			cache : false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
			type : 'post',
			success : function(result) {
				if (result.code == 401) {
					window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
					return false;
				}
				if (result.success) {
					App.prompt(messages.register_success_login);
					window.location.href = "${base}/login.html";
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

	// 更换验证码
	$('#captchaImage').click(
			function() {
				$('#captchaImage').attr(
						"src",
						"${base}/assets/register_vcode_image.jsp?timestamp="
								+ (new Date()).valueOf());
			});

	//跳转登陆页面
	function login() {
		window.location.href = "${base}/login.html";
	}
	
</script>
</@main.footer>