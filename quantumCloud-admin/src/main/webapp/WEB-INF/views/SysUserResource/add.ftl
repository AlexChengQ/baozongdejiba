<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户资源">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysUserResource/index.html">用户资源管理</a></li>
       <li class="active">增加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post"  class="form-horizontal" role="form" >
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		<input type="hidden" name="id" value="${(entity.id)!}"/>
		 <div class="form-group">
			<label for="userId" class="col-md-3 control-label no-padding-right"> 用户ID </label>
			<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-userId" ></font><span id="errormsg-userId" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="resource" class="col-md-3 control-label no-padding-right"> 资源名 </label>
			<div class="col-md-6">
			    <input type="text" id="resource" name="resource" value="${(entity.resource)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-resource" ></font><span id="errormsg-resource" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SysUserResource/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/SysUserResource.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveSysUserResourceConfig);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveSysUserResourceConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysUserResource/save.json',  
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
						            timeout		: 1500,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	
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