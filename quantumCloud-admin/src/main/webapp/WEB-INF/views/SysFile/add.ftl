<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="文件">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysFile/index.html">文件管理</a></li>
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
			<label for="fileName" class="col-md-3 control-label no-padding-right"> 文件名 </label>
			<div class="col-md-6">
			    <input type="text" id="fileName" name="fileName" value="${(entity.fileName)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-fileName" ></font><span id="errormsg-fileName" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="descn" class="col-md-3 control-label no-padding-right"> 描述 </label>
			<div class="col-md-6">
			    <input type="text" id="descn" name="descn" value="${(entity.descn)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-descn" ></font><span id="errormsg-descn" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="path" class="col-md-3 control-label no-padding-right"> 文件路径 </label>
			<div class="col-md-6">
			    <input type="text" id="path" name="path" value="${(entity.path)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-path" ></font><span id="errormsg-path" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="type" class="col-md-3 control-label no-padding-right"> 文件类型 </label>
			<div class="col-md-6">
			    <input type="text" id="type" name="type" value="${(entity.type)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-type" ></font><span id="errormsg-type" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="extension" class="col-md-3 control-label no-padding-right"> 扩展名 </label>
			<div class="col-md-6">
			    <input type="text" id="extension" name="extension" value="${(entity.extension)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-extension" ></font><span id="errormsg-extension" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="size" class="col-md-3 control-label no-padding-right"> 文件大小 </label>
			<div class="col-md-6">
			    <input type="text" id="size" name="size" value="${(entity.size)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-size" ></font><span id="errormsg-size" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="refId" class="col-md-3 control-label no-padding-right"> 对象主键 </label>
			<div class="col-md-6">
			    <input type="text" id="refId" name="refId" value="${(entity.refId)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-refId" ></font><span id="errormsg-refId" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="refObj" class="col-md-3 control-label no-padding-right"> 引用对象 </label>
			<div class="col-md-6">
			    <input type="text" id="refObj" name="refObj" value="${(entity.refObj)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-refObj" ></font><span id="errormsg-refObj" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="locked" class="col-md-3 control-label no-padding-right"> 是否锁定 </label>
			<div class="col-md-6">
					<select id="locked" name="locked" val="${(entity.locked)!}" class="form-control select2">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
			</div>
			<div class="col-md-3"><font id="require-locked" ></font><span id="errormsg-locked" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="userId" class="col-md-3 control-label no-padding-right"> 上传人ID </label>
			<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-userId" ></font><span id="errormsg-userId" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="username" class="col-md-3 control-label no-padding-right"> 上传人名称 </label>
			<div class="col-md-6">
			    <input type="text" id="username" name="username" value="${(entity.username)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-username" ></font><span id="errormsg-username" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="extField" class="col-md-3 control-label no-padding-right"> 扩展字段 </label>
			<div class="col-md-6">
			    <input type="text" id="extField" name="extField" value="${(entity.extField)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-extField" ></font><span id="errormsg-extField" class="error"></span></div>
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
			<div class="col-md-3"><font id="require-createTime" ></font><span id="errormsg-createTime" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SysFile/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/SysFile.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveSysFileConfig);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveSysFileConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysFile/save.json',  
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