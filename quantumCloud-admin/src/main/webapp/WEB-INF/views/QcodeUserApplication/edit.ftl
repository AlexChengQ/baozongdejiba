<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="qcode_user_application">
		
</@main.header>
<@main.body>
<#escape x as x?html>  
	<section class="content">
	<ol class="breadcrumb">
			<li></li>
	       <li><a href="${base }/QcodeUserApplication/index.html">用户申请管理</a></li>
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
					<label for="name" class="col-md-3 control-label no-padding-right"> 姓名 </label>
					<div class="col-md-6">
			    <input type="text" id="name" name="name" value="${(entity.name)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-name"></font><span id="errormsg-name" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="email" class="col-md-3 control-label no-padding-right"> emil </label>
					<div class="col-md-6">
			    <input type="text" id="email" name="email" value="${(entity.email)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-email"></font><span id="errormsg-email" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="orgName" class="col-md-3 control-label no-padding-right"> 机构 </label>
					<div class="col-md-6">
			    <input type="text" id="orgName" name="orgName" value="${(entity.orgName)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-orgName"></font><span id="errormsg-orgName" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="level" class="col-md-3 control-label no-padding-right"> 用户等级 </label>
					<div class="col-md-6">
				<select id="level" name="level" val="${(entity.level)!}"  class="form-control select2">
					<option value="3">三级用户</option>
					<option value="2">二级用户</option>
					<option value="1">一级用户</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-level"></font><span id="errormsg-level" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="base" class="col-md-3 control-label no-padding-right"> 具有基础 </label>
					<div class="col-md-6">
			    <input type="text" id="base" name="base" value="${(entity.base)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-base"></font><span id="errormsg-base" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="target" class="col-md-3 control-label no-padding-right"> 目标 </label>
					<div class="col-md-6">
			    <input type="text" id="target" name="target" value="${(entity.target)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-target"></font><span id="errormsg-target" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="userId" class="col-md-3 control-label no-padding-right"> 申请人id </label>
					<div class="col-md-6">
			    <input type="text" id="userId" name="userId" value="${(entity.userId)!}" class="form-control"/>
			    </div>
			    <div class="col-md-3"><font id="require-userId"></font><span id="errormsg-userId" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="status" class="col-md-3 control-label no-padding-right"> 申请状态 </label>
					<div class="col-md-6">
				<select id="status" name="status" val="${(entity.status)!}"  class="form-control select2">
					<option value="2">未审核</option>
					<option value="1">已通过</option>
					<option value="0">已拒绝</option>
				</select>
			    </div>
			    <div class="col-md-3"><font id="require-status"></font><span id="errormsg-status" class="error"></span></div>
		    </div>
		    	<div class="form-group">
					<label for="createtime" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
					<div class="col-md-6">
			    <div class="input-group date datetimepicker" data-date="${(entity.createtime?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="createtime" name="createtime" type="text" value="${(entity.createtime?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			    </div>
			    <div class="col-md-3"><font id="require-createtime"></font><span id="errormsg-createtime" class="error"></span></div>
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
						<a class="btn btn-sm btn-primary" href="${base }/QcodeUserApplication/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/QcodeUserApplication.js"></script>
<script type="text/javascript">
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveQcodeUserApplicationConfig);
		$(".btn-update").click(function(){
			if($("#myFormId").validateForm(saveQcodeUserApplicationConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/QcodeUserApplication/update.json',  
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
