<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="平台管理员">
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/SysUser/index.html">用户管理</a></li>
	       <li class="active">编辑</li>
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
					<label for="fullname" class="col-md-3 control-label no-padding-right"> 姓名 </label>
					<div class="col-md-6">
			    <input type="text" id="fullname" name="fullname" value="${(entity.fullname)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-fullname"></font><span id="errormsg-fullname" class="error"></span></div>
		    </div>
		    <div class="form-group">
					<label for="username" class="col-md-3 control-label no-padding-right"> 登录名 </label>
					<div class="col-md-6">
			    <input type="text" id="username" name="username" value="${(entity.username)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-username"></font><span id="errormsg-username" class="error"></span></div>
		    </div>
		    <div class="form-group">
					<label for="email" class="col-md-3 control-label no-padding-right"> 邮箱 </label>
					<div class="col-md-6">
			    <input type="text" id="email" name="email" value="${(entity.email)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-email"></font><span id="errormsg-email" class="error"></span></div>
		    </div>
		    <div class="form-group">
					<label for="status" class="col-md-3 control-label no-padding-right"> 状态 </label>
					<div class="col-md-6">
				<select id="status" name="status" val="${(entity.status)!}"  class="form-control select2">
					<option value="1">启用</option>
					<option value="2">禁用</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-status"></font><span id="errormsg-status" class="error"></span></div>
		    </div>
		    <div class="form-group">
					<label for="isSuperadmin" class="col-md-3 control-label no-padding-right"> 类型 </label>
					<div class="col-md-6">
				<select id="isSuperadmin" name="isSuperadmin" val="${(entity.isSuperadmin)!}"  class="form-control select2">
					<option value="0">普通管理员</option>
					<option value="1">超级管理员</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-isSuperadmin"></font><span id="errormsg-isSuperadmin" class="error"></span></div>
		    </div>
		    <div class="form-group">
					<label for="remark" class="col-md-3 control-label no-padding-right"> 备注 </label>
					<div class="col-md-6">
			    <input type="text" id="remark" name="remark" value="${(entity.remark)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-remark"></font><span id="errormsg-remark" class="error"></span></div>
		    </div>
		 
	 <#else>
		<div role="alert" class="alert alert-danger ">
	      <strong>记录不存在</strong>
	    </div>
	</#if>
	<div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-update">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SysUser/index.html">返回</a>
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
		$("#myFormId").validate(saveSysUserConfig);
		$(".btn-update").click(function(){
			if($("#myFormId").validateForm(saveSysUserConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysUser/update.json',  
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
								        	window.location.href = "${base }/SysUser/index.html";
								        }
								    }
						        });				        						       		
				        	}else{
				        		for(var msg in data.message){
					        		var n = noty({
							            text        : msg,
							            type        : 'error',
							            dismissQueue: true,
							            layout      : 'topCenter',
							            theme       : 'relax',
							            timeout		: 1500
							        });
					        	}
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
