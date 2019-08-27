<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${setting['app.name']}</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- icon -->
  <link rel="shortcut icon" href=" ${base}/assets/images/favicon.ico" />
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="${base}/assets/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${base}/assets/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="${base}/assets/ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${base}/assets/adminlte/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="${base}/assets/plugins/iCheck/square/blue.css">
  
  
  <link rel="stylesheet" href="${base}/assets/adminlte/css/button.css">
  
  
  <link rel="stylesheet" href="${base}/assets/adminlte/css/animation.css">
  
  <link rel="stylesheet" href="${base}/assets/css/main.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="${base}/assets/html5shiv-3.7.2.min.js"></script>
  <script src="${base}/assets/respond-1.4.2.min.js"></script>
  <![endif]-->
 <style>
        .button a{color:#fff; display: block;}
    </style>
</head>
<body style="background-image: url(${base}/assets/adminlte/img/lgbg.jpg);background-size:cover;">
<h3 class="form-signin-heading flip-top" style="text-align: center; padding-bottom: 20px; color:#fff;position: fixed;top:10px;width:100%;font-family: 微软雅黑">${setting['app.name']}</h3>
<div class="container" style="padding-top:80px;">

    <form class="form-signin login flip-top">
        <header class="panel-heading text-center"> <strong>用户登录</strong> </header>
        <div style="padding: 20px;">
        <div class="form-group">
            <label for="exampleInputEmail1">用户名</label>
            <input type="text" name="username" class="form-control" id="exampleInputEmail1" placeholder="Username">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">密码</label>
            <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
        </div>
        <div class="checkbox" style="padding: 10px 0;">
            <label>
                <input type="checkbox" value="remember-me" name="rememberMe"> 记住我
            </label>
               <span class="button button-primary button-pill button-small" type="submit" style="width:40%; height:38px;line-height:38px; font-size: 18px; float:right;">
            <a href="javascript:void(0)" class="btn-sm">登 录</a>
        </span>
        </div>

        </div>
    </form>

</div> <!-- /container -->


</div> <!-- /container -->

<!-- jQuery 2.2.0 -->
<script src="${base}/assets/plugins/jQuery/jQuery-2.2.0.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="${base}/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="${base}/assets/plugins/iCheck/icheck.min.js"></script>
  <script type="text/javascript" src="${base}/assets/js/noty/jquery.noty.packaged.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
  
  if(window.parent != window) {
			window.parent.location.href = "${base}/login";		
		}
		$(document).ready(function(){
			$(document).keyup(function(event){
				if(event.keyCode ==13){
			        login();
			 	}
			});
			$(".btn-sm").click(function(){
				login();
			});
		});
		
		
		function login(){
			var params = {};
				params['username'] = $("input[name=username]").val();
				params['password'] = $("input[name=password]").val();
				
				if ($('input[name=rememberMe]').is(':checked'))
					params['rememberMe'] = true;
				
				$.post('${base}/doLogin.json',params,function(data){
					if(data.success) {
						location.href="${rc.contextPath}/index.html";		
					} else {
						var n = noty({
				            text        : data.message,
				            type        : 'error',
				            dismissQueue: true,
				            layout      : 'topCenter',
				            theme       : 'relax',
				            timeout		: 2000
				        });
					}
				});
			
		}
</script>
</body>
</html>
