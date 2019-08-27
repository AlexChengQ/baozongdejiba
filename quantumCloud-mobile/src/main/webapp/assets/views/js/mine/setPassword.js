$(function(){
	App.setTitle("修改密码");
    App.setTopMenu([{name:"保存",icon:base+"/assets/images/save.png",callback:"doSave()"}]);

});

//标识
var doUpdate = false;

//确认
function doSave(){
	if(doUpdate){
		return false;
	}
	
	if($("#oldPsd").val()==""){
		App.prompt("请输入旧密码");
		doUpdate = false;
		return false;
	}
	
	var reg = /^[0-9a-zA-Z_]{6,12}$/;
	
	if($("#password").val()==""){
		App.prompt("请输入新密码");
		doUpdate = false;
		return false;
	}else{
		if(!reg.test($("#password").val())){
			App.prompt("密码由6-12位数字或字母或下划线");
			doUpdate = false;
			return false;
		}
	}
	if($("#confirmPsd").val()==""){
		App.prompt("请输入确认密码");
		doUpdate = false;
		return false;
	}else{
		if(!reg.test($("#confirmPsd").val())){
			App.prompt("密码由6-12位数字或字母或下划线");
			doUpdate = false;
			return false;
		}
	}
	if($("#password").val()!=$("#confirmPsd").val()){
		App.prompt("二次密码输入不一致");
		doUpdate = false;
		return false;
	}
	
	doUpdate = true;
	var url = base+"/Mine/changePsd.json";//修改密码
    var params = {};
    //params['mobile'] = $("#mobile").val();
    params['oldPsd'] = $.md5($("#oldPsd").val());
    params['password'] = $.md5($("#password").val());
	$.post(url,params,function(response) {
		if ('401' == response.code) {
	        App.prompt("重新登录");
	        setTimeout(function () {
				window.location.href = response.message;
	        },1000);
		}
		if (response.success) {
			App.prompt("密码修改成功，请重新登录");
			//App.callHostPlugin('logout');//进入登陆页面
			App.close();
      	}else {
			App.prompt(response.message);
			doUpdate = false;
      	}
    });
}