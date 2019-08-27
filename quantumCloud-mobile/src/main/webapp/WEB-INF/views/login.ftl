<#-----author:JT------->
<#-----date:2016-05-05------->
<@main.header title="登录">
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">用户名</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" type="email" name="email" placeholder="请输入Email地址" value="">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">密码</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" type="password" name="password" placeholder="请输入密码" value="">
        </div>
    </div>
</div>
<div class="button" style="margin-top: 20px;text-align: center;">
    <a href="${base}/register.html" style="display: inline-block;width: 35%;float: none;">注册</a>
    <a style="display: inline-block;width: 35%;float: none;" class="btn-sm">登录</a>
</div>
<div class="quick-login"  >
    <div class="weui-loadmore weui-loadmore_line">
        <span class="weui-loadmore__tips">快速登录</span>
    </div>
    <div class="q-login-list">
        <ul>
            <li>
                <i class="iconfont icon-weixin" onclick="App.auth({callBack:'weChatLogin',platform:'Wechat'});"></i>
            </li>
        </ul>
    </div>
</div>
</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>
//登陆
$(function() {
    App.setTitle("登陆");
    $(".btn-sm").click(function() {
        var params = {};
        params['email'] = $("input[name=email]").val();
        params['password'] = $.md5($("input[name=password]").val());;
        $.post('${base}/doLogin.json', params, function(data) {
          if (data.success) {
        	  App.setToken(data.obj);
        	  App.openNew("${base}/QCode/index.html");
        	  App.close();
        	  //window.location.href = "${base}/QCode/index.html";
          } else {
            App.prompt(data.message);
          }
        });
      });
      iosCheckWeChatIsInstalled();
});
    var a=$(window).height();
    $('.quick-login').css('padding-top',a - 300);
    $(window).resize(function(){
        $('.quick-login').css('padding-top',a - 300);
    });

function iosCheckWeChatIsInstalled(){ //ios检查微信是否已安装
	var isWXAppInstalled  = App.get('isWXAppInstalled');//isWXAppInstalled==1 即为安装 
	if(isWXAppInstalled !=undefined  && (!(isWXAppInstalled == 1))){ //未安装
		$('.quick-login').hide();
	}
}

function weChatLogin(data){
	data.appType = ${QcodeThirdLogin.APPTYPE_WE_CHAT};
	data.isThird = true;
	  $.post('${base}/doLogin.json', data, function(data) {
          if (data.success) {
        	  App.setToken(data.obj);
        	  App.openNew("${base}/QCode/index.html");
        	  App.close();
        	  //window.location.href = "${base}/QCode/index.html";
          } else {
          	if(data.code == 303){
          		var params = "?name="+data.obj.name+"&appId="+data.obj.appId; 
          		  App.openNew("${base}/thirdRegisterSave.html"+params);
          	}else{
	            App.prompt(data.message);
          	}
          }
      });
}
</script>
</@main.footer>
