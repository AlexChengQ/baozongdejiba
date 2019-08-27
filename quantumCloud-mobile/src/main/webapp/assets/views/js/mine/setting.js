$(function(){
	App.setTitle("设置");
	App.dragRefresh();
});

var param ={};
var uuid = App.get("iosuuid");//设备识别码
param.uuid = uuid;

function logOut(){
	//移动端退出
	App.callHostPlugin('logout');
}

$(function(){
  $('#changePwd').bind('click', function() {
    App.openNew({url:base+"/Mine/changePwd.html"});
  });
  $('#feedBack').bind('click', function() {
    App.openNew({url:base+"/Mine/feedBackAdd.html"});
  });
  $('#about').bind('click', function() {
    App.openNew({url:base+"/Mine/about.html"});
  });
})