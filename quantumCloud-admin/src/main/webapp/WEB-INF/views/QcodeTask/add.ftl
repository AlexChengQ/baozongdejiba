<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="任务表">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeTask/index.html">任务表管理</a></li>
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
			<label for="versionId" class="col-md-3 control-label no-padding-right"> 项目版本id </label>
			<div class="col-md-6">
			    <input type="text" id="versionId" name="versionId" value="${(entity.versionId)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-versionId" ></font><span id="errormsg-versionId" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="taskId" class="col-md-3 control-label no-padding-right"> 任务编号 </label>
			<div class="col-md-6">
			    <input type="text" id="taskId" name="taskId" value="${(entity.taskId)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-taskId" ></font><span id="errormsg-taskId" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="classicRegisterName" class="col-md-3 control-label no-padding-right"> 经典寄存器名 </label>
			<div class="col-md-6">
			    <input type="text" id="classicRegisterName" name="classicRegisterName" value="${(entity.classicRegisterName)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-classicRegisterName" ></font><span id="errormsg-classicRegisterName" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="startTime" class="col-md-3 control-label no-padding-right"> 执行时间 </label>
			<div class="col-md-6">
				<div class="input-group date datetimepicker" data-date="${(entity.startTime?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="startTime" name="startTime" type="text" value="${(entity.startTime?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			</div>
			<div class="col-md-3"><font id="require-startTime" ></font><span id="errormsg-startTime" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="endTime" class="col-md-3 control-label no-padding-right"> 结束时间 </label>
			<div class="col-md-6">
				<div class="input-group date datetimepicker" data-date="${(entity.endTime?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="endTime" name="endTime" type="text" value="${(entity.endTime?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			</div>
			<div class="col-md-3"><font id="require-endTime" ></font><span id="errormsg-endTime" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="repeat" class="col-md-3 control-label no-padding-right"> 重复次数 </label>
			<div class="col-md-6">
		        <div class="input-group spinner"  data-trigger="spinner">
			          <input type="text" class="form-control text-center" id="repeat" name="repeat" value="1" data-step="1" data-min="1" data-max="2147483647">
				    <div class="input-group-btn-vertical">
				      <button class="btn btn-default" type="button" data-spin="up"><i class="fa fa-caret-up"></i></button>
				      <button class="btn btn-default" type="button" data-spin="down"><i class="fa fa-caret-down"></i></button>
				    </div>
				  </div>
			</div>
			<div class="col-md-3"><font id="require-repeat" ></font><span id="errormsg-repeat" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="meaarr" class="col-md-3 control-label no-padding-right"> 测量比特数组 </label>
			<div class="col-md-6">
			    <input type="text" id="meaarr" name="meaarr" value="${(entity.meaarr)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-meaarr" ></font><span id="errormsg-meaarr" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="status" class="col-md-3 control-label no-padding-right"> 状态 </label>
			<div class="col-md-6">
					<select id="status" name="status" val="${(entity.status)!}" class="form-control select2">
						<option value="3">完成</option>
						<option value="2">处理中</option>
						<option value="1">等待</option>
						<option value="5">已终止</option>
						<option value="4">语法错误</option>
					</select>
			</div>
			<div class="col-md-3"><font id="require-status" ></font><span id="errormsg-status" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="ans" class="col-md-3 control-label no-padding-right"> 应答 </label>
			<div class="col-md-6">
				    <textarea id="ans" name="ans" ref="ans" class="form-control">${(entity.ans)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-ans" ></font><span id="errormsg-ans" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="isDel" class="col-md-3 control-label no-padding-right"> 是否删除 </label>
			<div class="col-md-6">
					<select id="isDel" name="isDel" val="${(entity.isDel)!}" class="form-control select2">
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
			</div>
			<div class="col-md-3"><font id="require-isDel" ></font><span id="errormsg-isDel" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/QcodeTask/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/QcodeTask.js"></script>
<script type="text/javascript">
		var ansEditor;
		
	KindEditor.ready(function(K) {
		ansEditor = K.create('textarea[name="ans"]', {
			height : "600px",
			cssPath : '${base}/assets/kindeditor/plugins/code/prettify.css',
			uploadJson : '${base}/assets/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '${base}/assets/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterFocus : function() {
				$("#errormsg-ans").remove();
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
			}
		});
		prettyPrint();
	});
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveQcodeTaskConfig);
		$(".btn-save").click(function(){
				ansEditor.sync();
			if($("#myFormId").validateForm(saveQcodeTaskConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/QcodeTask/save.json',  
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