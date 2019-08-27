<#-----author:wuhao------->
<#-----date:2018-01-09------->
<@main.header title="密码修改">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>密码修改</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post" class="form-horizontal" role="form" >
		 <#if entity?exists>
		 	<div class="box box-primary">
				<div class="box-body">
			<@main.warning/>
			<input type="hidden" name="id" value="${(entity.id)!}"/>
	             <div class="form-group">
	                 <label for="password" class="col-md-3 control-label no-padding-right"> 新密码 </label>
	                 <div class="col-md-6">
	                     <input type="password" id="password" name="password" value="" class="form-control col-xs-10 col-sm-5"/>
	                 </div>
	                 <div class="col-md-3"><font id="require-password"></font><span id="errormsg-password" class="error"></span></div>
	             </div>
	             <div class="form-group">
	                 <label for="confirmPassword" class="col-md-3 control-label no-padding-right"> 确认密码 </label>
	                 <div class="col-md-6">
	                     <input type="password" id="confirmPassword" name="confirmPassword" value="" class="form-control"/>
	                 </div>
	                 <div class="col-md-3"><font id="require-confirmPassword"></font><span id="errormsg-confirmPassword" class="error"></span></div>
	             </div>
			 
		 <#else>
			<div role="alert" class="alert alert-danger">
		      <strong>记录不存在</strong>
		    </div>
		</#if>
		<div class="form-group">
			    	<div class="form-group">
						<div class="col-sm-5 col-xs-offset-4">
							<button type="button" class="btn btn-sm btn-success btn-save">保存</button>
							<button type="button" class="btn btn-sm btn-success" onclick="javascript:history.back(-1);">取消</button>
						</div>
					</div>
			    </div>
			 </div>
		</div>
	 </form>
		</div>
	</div>
</section>
	
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/SysUser.js"></script>
<script type="text/javascript">
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveSysUserPwd);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveSysUserPwd)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysUser/changePwd.json',
			        data:$("#myFormId").serialize(),  
			        success:function(data){
			        	switch(data.code){
			        	case 401:
			        		var n = noty({
					            text        : data.message,
					            type        : 'error',
					            dismissQueue: true,
					            layout      : 'topCenter',
					            theme       : 'relax',
					            timeout		: 1500,
					            callback: {     // 设置回调函数
							        afterClose: function() {
							        	
							        }
							    }
					        });
		        			break;
		        		default:
			        		if (data.success){
				        		var n = noty({
						            text        : data.message,
						            type        : 'success',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1000,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	if (${USER_INFO.id} == ${(entity.id)!}) {
								        		window.location.href="${base}/index.html";
								        	} else {
								        		window.location.href="${base}/SysUser/index.html";
								        	}
								        	
								        }
								    }
						        });
				        	}else{
				        		var n = noty({
						            text        : data.message,
						            type        : 'error',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1500
						        });
				        	}
			        	}
			        },
			        error:function(data){
			        	alert('ajax错误');
			        }
			    });
			}
		});
	});
</script>
</@main.footer>

