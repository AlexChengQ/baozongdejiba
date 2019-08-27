<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="项目表">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/QcodeProject/index.html">项目表管理</a></li>
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
					<label for="name" class="col-md-3 control-label no-padding-right"> 项目名称 </label>
					<div class="col-md-6">
			    <input type="text" id="name" name="name" value="${(entity.name)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-name"></font><span id="errormsg-name" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="userId" class="col-md-3 control-label no-padding-right"> 创建人id </label>
					<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-userId"></font><span id="errormsg-userId" class="error"></span></div>
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
		    	<div class="form-group">
					<label for="qubitNum" class="col-md-3 control-label no-padding-right"> 量子比特数 </label>
					<div class="col-md-6">
						        <div class="input-group spinner"  data-trigger="spinner">
			          <input type="text" class="form-control text-center" id="qubitNum" name="qubitNum" value="1" data-step="1" data-min="1" data-max="2147483647">
				    <div class="input-group-btn-vertical">
				      <button class="btn btn-default" type="button" data-spin="up"><i class="fa fa-caret-up"></i></button>
				      <button class="btn btn-default" type="button" data-spin="down"><i class="fa fa-caret-down"></i></button>
				    </div>
				  </div>
			    </div>
			    <div class="col-md-3"><font id="require-qubitNum"></font><span id="errormsg-qubitNum" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="classicalbitNum" class="col-md-3 control-label no-padding-right"> 经典比特数 </label>
					<div class="col-md-6">
						        <div class="input-group spinner"  data-trigger="spinner">
			          <input type="text" class="form-control text-center" id="classicalbitNum" name="classicalbitNum" value="1" data-step="1" data-min="1" data-max="2147483647">
				    <div class="input-group-btn-vertical">
				      <button class="btn btn-default" type="button" data-spin="up"><i class="fa fa-caret-up"></i></button>
				      <button class="btn btn-default" type="button" data-spin="down"><i class="fa fa-caret-down"></i></button>
				    </div>
				  </div>
			    </div>
			    <div class="col-md-3"><font id="require-classicalbitNum"></font><span id="errormsg-classicalbitNum" class="error"></span></div>
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
			    <div class="col-md-3"><font id="require-repeat"></font><span id="errormsg-repeat" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="pic" class="col-md-3 control-label no-padding-right"> 图片 </label>
					<div class="col-md-6">
			    <input type="text" id="pic" name="pic" value="${(entity.pic)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-pic"></font><span id="errormsg-pic" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="desc" class="col-md-3 control-label no-padding-right"> 项目描述 </label>
					<div class="col-md-6">
				    <textarea id="desc" name="desc" ref="desc" class="form-control">${(entity.desc)!}</textarea>
			    </div>
			    <div class="col-md-3"><font id="require-desc"></font><span id="errormsg-desc" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="taskTypeId" class="col-md-3 control-label no-padding-right"> 任务类型id </label>
					<div class="col-md-6">
				<select id="taskTypeId" name="taskTypeId" val="${(entity.taskTypeId)!}"  class="form-control select2">
					<option value="3">半导体量子芯片</option>
					<option value="2">超导量子芯片</option>
					<option value="1">量子仿真</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-taskTypeId"></font><span id="errormsg-taskTypeId" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="isDel" class="col-md-3 control-label no-padding-right"> 是否删除 </label>
					<div class="col-md-6">
				<select id="isDel" name="isDel" val="${(entity.isDel)!}"  class="form-control select2">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-isDel"></font><span id="errormsg-isDel" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="nameEnglish" class="col-md-3 control-label no-padding-right"> 英文名称 </label>
					<div class="col-md-6">
				    <textarea id="nameEnglish" name="nameEnglish" ref="nameEnglish" class="form-control">${(entity.nameEnglish)!}</textarea>
			    </div>
			    <div class="col-md-3"><font id="require-nameEnglish"></font><span id="errormsg-nameEnglish" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="descEnglish" class="col-md-3 control-label no-padding-right"> 英文描述 </label>
					<div class="col-md-6">
				    <textarea id="descEnglish" name="descEnglish" ref="descEnglish" class="form-control">${(entity.descEnglish)!}</textarea>
			    </div>
			    <div class="col-md-3"><font id="require-descEnglish"></font><span id="errormsg-descEnglish" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="analogType" class="col-md-3 control-label no-padding-right"> 模拟类型 </label>
					<div class="col-md-6">
				<select id="analogType" name="analogType" val="${(entity.analogType)!}"  class="form-control select2">
					<option value="1">概率方法</option>
					<option value="0">Monte-Carlo</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-analogType"></font><span id="errormsg-analogType" class="error"></span></div>
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
						<a class="btn btn-sm btn-primary" href="${base }/QcodeProject/index.html">返回</a>
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
		var descEditor;
		
	KindEditor.ready(function(K) {
		descEditor = K.create('textarea[name="desc"]', {
			height : "600px",
			cssPath : '${base}/assets/kindeditor/plugins/code/prettify.css',
			uploadJson : '${base}/assets/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '${base}/assets/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterFocus : function() {
				$("#errormsg-desc").remove();
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
		$("#myFormId").validate(saveQcodeProjectConfig);
		$(".btn-update").click(function(){
			descEditor.sync();
			if($("#myFormId").validateForm(saveQcodeProjectConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/QcodeProject/update.json',  
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
