<#global base=rc.contextPath/>
<#global validateJS="${rc.contextPath}${setting['validatejspath']!}"/>
<#macro header title="" charset="utf-8" lang="zh-CN">
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${title!} ${setting['app.name']}</title>
  <!-- Tell the browser to be responsive to screen width -->
  <script>
	var formValidatorServletPath = "${base}";
	var ctx = "${base}/";
	var base = "${base}";
</script>
<link rel="shortcut icon" href=" ${base}/assets/images/favicon.ico" />
<link type="image/x-icon" href="${base}/assets/images/favicon.ico" rel="bookmark" />
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="${base}/assets/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${base}/assets/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="${base}/assets/ionicons/css/ionicons.min.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="${base}/assets/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${base}/assets/adminlte/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="${base}/assets/adminlte/css/skins/_all-skins.min.css">

<!--引入弹窗组件start-->
<link rel="stylesheet" href="${base}/assets/js/popup/popup/style.css" />
<link rel="stylesheet" href="${base}/assets/plugins/spinner/bootstrap-spinner.css" />

<link href="${base}/assets/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>

<link rel="stylesheet" href="${base}/assets/plugins/select2/select2.min.css">

<link rel="stylesheet" href="${base}/assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="${base}/assets/plugins/uploadify/uploadify.css"/>
<link rel="stylesheet" href="${base}/assets/bootstrap-fileinput/css/fileinput.min.css">

<link rel="stylesheet" href="${base}/assets/jcrop/css/jquery.Jcrop.css">
<link rel="stylesheet" href="${base}/assets/jcrop/css/jquery.Jcrop.min.css">
<link rel="stylesheet" href="${base}/assets/plugins/layer-v3.1.1/layer/theme/default/layer.css">
<style>
html{
    background-color: #ecf0f5;
}
.modal-content {
    background-clip: padding-box;
    background-color: #fff;
    border: 1px solid rgba(0, 0, 0, 0.2);
    border-radius: 6px;
    box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
    outline: 0 none;
    position: relative;
}

.sidebar-menu .treeview-menu{
	display:block;
}
.treeview-menu li.active{
    background: #B6E7FA none repeat scroll 0 0;
    border-right:solid 2px #387790;
    color: #fff;
}
.treeview-menu li a.nofocus{
background:none;
border-right:none;
cursor: default;
}
</style>

<#nested>

</head>
 </#macro>
<#macro body>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <header class="main-header">

    <!-- Logo -->
    <a href="${base}/index.html" class="logo">
      
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini">WL</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">${setting['app.name']}</span>
    </a>

    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="${base}/index.html" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="${base}/SysUser/changePwd.html?id=${USER_INFO.id}">
              <i aria-hidden="true" class="fa fa-user"></i>
              <span class="hidden-xs"><@shiro.principal/></span>
            </a>
          </li>
          <li>
            <a href="#" id="sign-out">
              <i class="fa fa-sign-out" aria-hidden="true"></i>
              <span class="hidden-xs">退出</span>
            </a>
          </li>
        </ul>
      </div>

    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <#assign requestUri=rc.requestUri?substring(rc.contextPath?length)/>
      <#list FunctionList as f>
      	<#if requestUri?matches(f.url)>
      		<#if f.navigate>
		  		<#assign parent = f/>
      		<#else>
	  			<#assign parent = FunctionMap[""+f.parentId]!/>
	  		</#if>
		</#if>
      </#list>
      <ul class="sidebar-menu">
      
      	<#list FunctionChildMap["0"] as f1>
		<@shiro.hasAnyRoles name="${f1.rolenames}">
		<li class="<#if parent?if_exists == f1>active</#if> treeview">
			<a href="${base}${f1.url!}">
				<i class="fa ${f1.icon!}"></i>
				<span> ${f1.name}</span>
				<#if FunctionChildNavigateMap[""+f1.id]?size != 0>
				<i class="fa pull-right"></i>
				</#if>
			</a>
			<#if FunctionChildNavigateMap[""+f1.id]?size != 0>
			<ul class="treeview-menu">
			<#list FunctionChildMap[""+f1.id] as f2>
				<@shiro.hasAnyRoles name="${f2.rolenames}">
				<#if f2.navigate>
				<li <#if  parent?if_exists == f2>class="active"</#if>>
					<a href="${base}${f2.url!}" <#if FunctionChildMap[""+f2.id]?size != 0>class="nofocus"</#if>>
						<i class="fa ${f2.icon!}"></i>
						${f2.name}
						<#if FunctionChildNavigateMap[""+f2.id]?size != 0>
						<i class="fa pull-right"></i>
						</#if>
					</a>
					<#if FunctionChildNavigateMap[""+f2.id]?size != 0>
					<ul class="treeview-menu">
					<#list FunctionChildMap[""+f2.id] as f3>
						<@shiro.hasAnyRoles name="${f3.rolenames}">
						<#if f3.navigate>
							 <li <#if  parent?if_exists == f3>class="active"</#if>><a href="${base}${f3.url!}"><i class="fa ${f3.icon!}"></i> ${f3.name}</a></li>
						</#if>
						</@shiro.hasAnyRoles>
					</#list>
					</ul>
					</#if>
				</li>
				</#if>
				</@shiro.hasAnyRoles>
			</#list>
			</ul>
			</#if>
		</li>
		</@shiro.hasAnyRoles>
		</#list>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
  <div class="page-content">
    <#nested>
  </div>
    	<div class="modal fade" id="myModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel"></h4>
		            </div>
		            <div class="modal-body">
		            </div>
		            <div class="modal-footer">
	                    &nbsp;
	                </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
  </div>
  
<div sytle="display:none;">
	<form id="postForm" action="" method="post">
	</form>
</div>
  <!-- /.content-wrapper -->
<#--
  <footer class="main-footer">
    <strong>${setting["app.copyright"]!}</strong>
  </footer>
  -->
</div>
<!-- ./wrapper -->

</#macro>
<#macro footer>
</body>
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="${base}/assets/js/html5shiv-3.7.2.min.js"></script>
  <script src="${base}/assets/js/respond-1.4.2.min.js"></script>
  <![endif]-->
  <!-- jQuery 2.2.0 -->
<script src="${base}/assets/plugins/jQuery/jQuery-2.2.0.min.js"></script>
  <script src="${base}/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="${base}/assets/adminlte/js/app.js"></script>
<script type="text/javascript" src="${base}/assets/js/popup/drag.js"></script>
<script type="text/javascript" src="${base}/assets/js/popup/dialog.js"></script>
<script type="text/javascript" src="${base}/assets/js/noty/jquery.noty.packaged.js"></script>
<script src="${base}/assets/js/bootstrap-popover.js"></script>
<script src="${base}/assets/js/bootstrap-tooltip.js"></script>
<script src="${base}/assets/js/app.js"></script>
<script src="${base}/assets/js/dialog.js"></script>
<script src="${base}/assets/js/formValidator/validateEngine.js"></script>
<script src="${base}/assets/plugins/spinner/jquery.spinner.js"></script>
<script src="${base}/assets/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
<script src="${base}/assets/plugins/bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/assets/plugins/select2/select2.js"></script>
<script src="${base}/assets/plugins/select2/i18n/zh-CN.js"></script>
<script src="${base}/assets/plugins/uploadify/jquery.uploadify.min.js"></script>
<#-- bootstrap fileinput -->
<script src="${base}/assets/bootstrap-fileinput/js/fileinput.min.js"></script>
<script src="${base}/assets/bootstrap-fileinput/js/locales/zh.js"></script>

<script src="${base}/assets/jcrop/js/jquery.color.js"></script>
<script src="${base}/assets/jcrop/js/jquery.Jcrop.js"></script>
<script src="${base}/assets/jcrop/js/jquery.Jcrop.min.js"></script>
<script src="${base}/assets/plugins/layer-v3.1.1/layer/layer.js"></script>
<script>
$(document).ready(function(){
	$("#sign-out").click(function(){
	     Dialog.confirm({message: "确认退出系统吗？" }).on(function (e) {
	       if (!e) {
	         return;
	       }
	       location.href='${base}/logout.html';
	     });
	});
	$(".datetimepicker").datetimepicker({language:  'zh-CN'});
	
});
</script>
<#nested>
</html>
</#macro>

<#macro pagination pager>
<#if (pager.totalRecords)?default(0) != 0>
<div class="row">
	<input type="hidden" id="startId" name="start" value="${(RequestParameters.start?default(0))!}"/>	
	<nav>
      <ul class="pagination navbar-toggle">
        <li>
        	<a><font color="red">${(pager.totalRecords)!}</font>条</a>
        </li>
        <li>
        	<a>${(pager.totalPages)!}页</a>
        </li>
        <li>
          <a aria-label="Previous" href="javascript:void(0)" onclick="toPage(0);">
            <span aria-hidden="true">«</span>
          </a>
        </li>
        <#if pager.pageNum gt 2>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 2)*pager.pageSize!});">${(pager.pageNum - 2)!}</a></li>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
        <#elseif pager.pageNum gt 1>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
        </#if>
        <li class="active"><a><font color="white">${(pager.pageNum)!}</font></a></li>
        <#if (pager.totalPages - pager.pageNum) gt 1>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.nextPage)*pager.pageSize!});">${(pager.nextPage + 1)!}</a></li>
        <#elseif (pager.totalPages - pager.pageNum) gt 0>
        <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
        </#if>
        <li>
          <a aria-label="Next" href="javascript:void(0)" onclick="toPage(${(pager.totalPages-1)*pager.pageSize!});">
            <span aria-hidden="true">»</span>
          </a>
        </li>
      </ul>
    </nav>
	</div>
</#if>
</#macro>

<#macro params uri>
	<#list RequestParameters?if_exists?keys as key>
	<#if RequestParameters[key]?has_content>
	<input type="hidden" name="${uri+key!}" value="${RequestParameters[key]!}"/>
	</#if>
	</#list>
</#macro>

<#macro warning>
	<#if errorMsgs?exists && errorMsgs?has_content>
		<div class="errorblock">
		<#if errorMsgs?is_string>
			${errorMsgs}<br/>
		<#else>
		<#list errorMsgs as msg>
			${msg}<br/>
		</#list>
		</#if>
		</div>
	</#if>
</#macro>
