<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="留言表">
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/QcodeMessage/index.html">留言表管理</a></li>
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
					<label for="userId" class="col-md-3 control-label no-padding-right"> 创建人id </label>
					<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-userId"></font><span id="errormsg-userId" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="title" class="col-md-3 control-label no-padding-right"> 主题 </label>
					<div class="col-md-6">
			    <input type="text" id="title" name="title" value="${(entity.title)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-title"></font><span id="errormsg-title" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="content" class="col-md-3 control-label no-padding-right"> 内容 </label>
					<div class="col-md-6">
				    <textarea id="content" name="content" ref="content" class="form-control">${(entity.content)!}</textarea>
			    </div>
			    <div class="col-md-3"><font id="require-content"></font><span id="errormsg-content" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="createTime" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
					<div class="col-md-6">
			    <div class="input-group date datetimepicker" data-date="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="createTime" name="createTime" type="text" value="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			    </div>
			    <div class="col-md-3"><font id="require-createTime"></font><span id="errormsg-createTime" class="error"></span></div>
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
						<a class="btn btn-sm btn-primary" href="${base }/QcodeMessage/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/QcodeMessage.js"></script>
<script type="text/javascript">
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveQcodeMessageConfig);
		$(".btn-update").click(function(){
			if($("#myFormId").validateForm(saveQcodeMessageConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/QcodeMessage/update.json',  
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
