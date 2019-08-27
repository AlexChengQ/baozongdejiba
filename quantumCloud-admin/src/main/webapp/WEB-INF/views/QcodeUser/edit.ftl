<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户管理">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/SysLog/index.html">用户管理</a></li>
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
					<label for="email" class="col-md-3 control-label no-padding-right"> Email </label>
					<div class="col-md-6">
			    	<input type="text" id="email" name="email" value="${(entity.email)!}" class="form-control" disabled/>
			    </div>
			    <div class="col-md-3"><font id="require-email"></font><span id="errormsg-email" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="level" class="col-md-3 control-label no-padding-right"> 客户等级 </label>
					<div class="col-md-6">
			    	<select id="_level" name="level" val="${(entity.level)!}" class="form-control select2" style="width: 100%;">
                        <option value="1">一级用户</option>
                        <option value="2">二级用户</option>
                        <option value="3">三级用户</option>
                    </select>
			    </div>
			    <div class="col-md-3"><font id="require-level"></font><span id="errormsg-level" class="error"></span></div>
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
						<a class="btn btn-sm btn-primary" href="${base }/QcodeUser/index.html">返回</a>
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
<script charset="utf-8" src="${base}/assets/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/plugins/code/prettify.js"></script>	
<script type="text/javascript">
	jQuery(function($) {
		$(".select2").select2();
		$(".btn-update").click(function(){
			$.ajax({  
		        type:'post',  
		        traditional :true,  
		        url:'${base}/QcodeUser/update.json',  
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
							        	location.href = "${base}/QcodeUser/index.html";
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
		});
	});
</script>
</@main.footer>
