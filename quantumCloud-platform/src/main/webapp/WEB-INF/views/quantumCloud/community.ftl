<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content" style="min-height:500px; min-width:1336px;">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
    <div class="pic">
        <img src="${base}/assets/images/pic_5.jpg" width="100%" />
    </div>
    <div class="company-title m-b-30">
    	<h2 style="color:#333"><@spring.message code="contact_us" /></h2>
	</div>

    <div class="map">
        <div class="map-left">
            <div id="map" style="height:200px;background:#f5f5f5"></div>
            <div class="container-fluid bottom" style="padding-top: 50px;">
                <div class="row">
                    <div class="col-md-9">
                        <p><@spring.message code="mobile" />：0551-63836038</p>
                        <p><@spring.message code="url" />：http://www.originqc.com.cn</p>
                        <p><@spring.message code="email" />：oqc@originqc.com</p>
                        <p><@spring.message code="address" />：合肥市高新区创新大道2800号创新产业园二期E2楼六层  </p>
                    </div>
                    <div class="col-md-3 ewm">
                        <img src="${base}/assets/images/ewmm.jpg" width="158" height="158" />&nbsp;&nbsp;
                    </div>
                </div>

            </div>
        </div>
        <div class="map-right">
            <div class="msg">
                <form>
                    <h3 style="text-align: center;padding-bottom: 20px;"><@spring.message code="leave_message" /></h3>
                    <div class="form-group">
                        <label for="exampleInputEmail1"><@spring.message code="title" /></label>
                        <input type="text" class="form-control" id="title" placeholder="<@spring.message code='placeholder_title' />" maxlength="20">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1"><@spring.message code="content" /></label>
                        <textarea id="userMsg" class="form-control" rows="3" placeholder="<@spring.message code='placeholder_userMsg' />" maxlength="500" style="resize:none;"></textarea>
                    </div>                    
                    <div class="form-group">
                        <label for="exampleInputPassword1"><@spring.message code="verification_code" /></label></br>
                        <input type="text" id="captcha" name="captcha" class="form-control"  placeholder="<@spring.message code='placeholder_captcha' />" maxlength="10" style="width:70%;display:inline;">
							              <img id="captchaImage" src="${base}/assets/vcode_image.jsp"/>
                    </div>
                    <div style="text-align: center">
                        <button type="button" class="btn btn-primary" onclick="subimitUserMsg();"><@spring.message code="submit" /></button>
                    </div>
                </form>
            </div>
        </div>
    </div>      

<!--box end-->
</div>
</#escape>
</@main.body>
<@main.footer>
<script>
var ak = 'Y5brUY2qCrIjpehmh0CEQ4THLsiyY1Ti';
var map;
var point;
//百度地图API功能
function loadJScript() {
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "https://api.map.baidu.com/api?v=2.0&ak=" + ak + "&callback=init";
  document.body.appendChild(script);
}
function init() {
    var lng = "117.144132";
    var lat = "31.841868";
    map = new BMap.Map("map");                    // 创建Map实例
  point = new BMap.Point(lng,lat);              // 创建点坐标
  map.centerAndZoom(point,16);                  // 初始化地图,设置中心
  map.addControl(new BMap.NavigationControl()); //增加平移缩放控件 
  //map.enableScrollWheelZoom();                  //启用滚轮放大缩小
  
  var marker = new BMap.Marker(point);          // 创建标注
  map.addOverlay(marker);                       // 将标注添加到地图中
  //var label = new BMap.Label("公司地址",{offset:new BMap.Size(20,-10)});
  //marker.setLabel(label);
}
//异步加载地图
window.onload = loadJScript;

$(document).ready(function() {
    t = $('.fixed').offset().top;
    $(window).scroll(function(){
        s = $(document).scrollTop();
        if(s > t - 10){
            $('.fixed').css('position','fixed');
            $('.fixed').css('left','14px');
            $('.news-content').css('margin-left','16%');
            if(s){
                $('.fixed').css('top','px');
            }
        }else{
            $('.fixed').css('position','');
            $('.news-content').css('margin-left','');

        }
    })
});

function subimitUserMsg(){
	var title = $("#title").val();
	var userMsg = $("#userMsg").val();
	var code = $("#captcha").val();	
	if(title==''){
		errorMsg(messages.title_not_null);
		return false;
	}
	if(userMsg==''){
		errorMsg(messages.community_not_null);
		return false;
	}
	if(code==''){
		errorMsg(messages.volidate_code_not_null);
		return false;
	}	
	var param ={};
	param.userMsg = userMsg;
	param.title = title;
	param.code = code;
	//表单提交
	$.ajax({
		url:"${base}/QCode/userMsg.json",
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
		            text        : messages.community_is_submit,
		            type        : 'success',
		            dismissQueue: true,
		            layout      : 'topCenter',
		            theme       : 'relax',
		            timeout		: 1500,
		            callback: {     // 设置回调函数
				        afterClose: function() { window.location.reload(true);}
				    }
		        });
			}else{
	  			errorMsg(result.message);
			}
		},
		error:function(){		
		 	errorMsg(messages.server_is_busy);
		}
	}); 		
	
}   


// 更换验证码
$('#captchaImage').click(function(){
     $('#captchaImage').attr("src", "${base}/assets/vcode_image.jsp?timestamp=" + (new Date()).valueOf());
}); 
</script>
</@main.footer>