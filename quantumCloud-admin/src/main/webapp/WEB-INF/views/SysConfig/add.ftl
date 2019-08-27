<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="参数配置">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysConfig/index.html">参数配置管理</a></li>
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
			<label for="descn" class="col-md-3 control-label no-padding-right"> 描述 </label>
			<div class="col-md-6">
			    <input type="text" id="descn" name="descn" value="${(entity.descn)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-descn" ></font><span id="errormsg-descn" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="keyname" class="col-md-3 control-label no-padding-right"> 变量名 </label>
			<div class="col-md-6">
			    <input type="text" id="keyname" name="keyname" value="${(entity.keyname)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-keyname" ></font><span id="errormsg-keyname" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="val" class="col-md-3 control-label no-padding-right"> 变量值 </label>
			<div class="col-md-6">
				    <textarea id="val" name="val" ref="val" class="form-control">${(entity.val)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-val" ></font><span id="errormsg-val" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="category" class="col-md-3 control-label no-padding-right"> 分类 </label>
			<div class="col-md-6">
			    <input type="text" id="category" name="category" value="${(entity.category)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-category" ></font><span id="errormsg-category" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="categoryDesc" class="col-md-3 control-label no-padding-right"> 分类描述 </label>
			<div class="col-md-6">
			    <input type="text" id="categoryDesc" name="categoryDesc" value="${(entity.categoryDesc)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-categoryDesc" ></font><span id="errormsg-categoryDesc" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="orderNo" class="col-md-3 control-label no-padding-right"> 排序 </label>
			<div class="col-md-6">
		        <div class="input-group spinner"  data-trigger="spinner">
			          <input type="text" class="form-control text-center" id="orderNo" name="orderNo" value="1" data-step="1" data-min="1" data-max="2147483647">
				    <div class="input-group-btn-vertical">
				      <button class="btn btn-default" type="button" data-spin="up"><i class="fa fa-caret-up"></i></button>
				      <button class="btn btn-default" type="button" data-spin="down"><i class="fa fa-caret-down"></i></button>
				    </div>
				  </div>
			</div>
			<div class="col-md-3"><font id="require-orderNo" ></font><span id="errormsg-orderNo" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SysConfig/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/SysConfig.js"></script>
<script type="text/javascript">
		var valEditor;
		
	KindEditor.ready(function(K) {
		valEditor = K.create('textarea[name="val"]', {
			height : "600px",
			cssPath : '${base}/assets/kindeditor/plugins/code/prettify.css',
			uploadJson : '${base}/assets/kindeditor/jsp/upload_json.jsp',
			fileManagerJson : '${base}/assets/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : true,
			afterFocus : function() {
				$("#errormsg-val").remove();
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
		$("#myFormId").validate(saveSysConfigConfig);
		$(".btn-save").click(function(){
				valEditor.sync();
			if($("#myFormId").validateForm(saveSysConfigConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysConfig/save.json',  
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
								        	window.location.href="${base}/SysConfig/index.html";
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