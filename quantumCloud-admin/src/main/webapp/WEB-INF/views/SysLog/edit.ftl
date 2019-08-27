<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="系统日志">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/SysLog/index.html">系统日志管理</a></li>
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
					<label for="operation" class="col-md-3 control-label no-padding-right"> 操作 </label>
					<div class="col-md-6">
			    <input type="text" id="operation" name="operation" value="${(entity.operation)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-operation"></font><span id="errormsg-operation" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="operContent" class="col-md-3 control-label no-padding-right"> 操作内容 </label>
					<div class="col-md-6">
				    <textarea id="operContent" name="operContent" ref="operContent" class="form-control">${(entity.operContent)!}</textarea>
			    </div>
			    <div class="col-md-3"><font id="require-operContent"></font><span id="errormsg-operContent" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="userId" class="col-md-3 control-label no-padding-right"> 操作人账号 </label>
					<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-userId"></font><span id="errormsg-userId" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="username" class="col-md-3 control-label no-padding-right"> 操作人 </label>
					<div class="col-md-6">
			    <input type="text" id="username" name="username" value="${(entity.username)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-username"></font><span id="errormsg-username" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="userAgent" class="col-md-3 control-label no-padding-right"> 客户端 </label>
					<div class="col-md-6">
			    <input type="text" id="userAgent" name="userAgent" value="${(entity.userAgent)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-userAgent"></font><span id="errormsg-userAgent" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="ip" class="col-md-3 control-label no-padding-right"> IP </label>
					<div class="col-md-6">
			    <input type="text" id="ip" name="ip" value="${(entity.ip)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-ip"></font><span id="errormsg-ip" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="operDate" class="col-md-3 control-label no-padding-right"> 操作日期 </label>
					<div class="col-md-6">
			    <div class="input-group date datetimepicker" data-date="${(entity.operDate?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="operDate" name="operDate" type="text" value="${(entity.operDate?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			    </div>
			    <div class="col-md-3"><font id="require-operDate"></font><span id="errormsg-operDate" class="error"></span></div>
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
						<a class="btn btn-sm btn-primary" href="${base }/SysLog/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/SysLog.js"></script>
<script type="text/javascript">
		var operContentEditor;
		
	KindEditor.ready(function(K) {
		operContentEditor = K.create('textarea[name="operContent"]', {
			height : "600px",
			cssPath : '${base}/assets/kindeditor/plugins/code/prettify.css',
			uploadJson : '${base}/assets/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '${base}/assets/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterFocus : function() {
				$("#errormsg-operContent").remove();
			},
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['myFormId'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['myFormId'].submit();
				});
			},
			extraFileUploadParams: {
		        user_id: '1',
		        password: 'f49a77ef44205b1ed45f29'
		    }
		});
		prettyPrint();
	});
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveSysLogConfig);
		$(".btn-update").click(function(){
			operContentEditor.sync();
			if($("#myFormId").validateForm(saveSysLogConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysLog/update.json',  
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
