<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="用户申请管理">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeUserApplication/index.html">用户申请管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> Email </label>
				<div class="col-md-6">
				    <input type="text" name="email" value="${(entity.email)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<#assign levels={'3':'三级用户','2':'二级用户','1':'一级用户'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 用户等级 </label>
				<div class="col-md-6">
					<input type="text" name="level" value="${(levels[''+entity.level])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 具有基础 </label>
				<div class="col-md-6">
				    <textarea  name="base"  class="form-control" disabled >${(entity.base)!}</textarea>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 目标 </label>
				<div class="col-md-6">
				    <textarea name="target" class="form-control" disabled >${(entity.target)!}</textarea>
		 		</div>
			 </div>	
		 	
		 	<#assign statuss={'2':'未审核','1':'已通过','0':'已拒绝'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 申请状态 </label>
				<div class="col-md-6">
					<input type="text" name="status" value="${(statuss[''+entity.status])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
				<div class="col-md-6">
				    <input name="createTime" type="text" value="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
			<#if entity.status !=  QcodeUserApplication.STATUS_WAITING >
			<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 审核人 </label>
				<div class="col-md-6">
				    <input name="auditor" type="text" value="${(entity.auditor)!}"  class="form-control" disabled/>
		 		</div>
			 </div>
			 <#if entity.status ==  QcodeUserApplication.STATUS_REFUSE > 
			 <div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 拒绝理由 </label>
				<div class="col-md-6">
				    <textarea  class="form-control" disabled >${(entity.refuseReason)!}</textarea>
		 		</div>
			 </div>
			 </#if>
			 <div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 审核时间 </label>
				<div class="col-md-6">
				    <input name="auditTime" type="text" value="${(entity.auditTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
			 </#if>
		 <#else>
			<div role="alert" class="alert alert-danger ">
		      <strong>记录不存在</strong>
		    </div>
		</#if>
		<div class="form-group">
	    	<div class="form-group">
				<div class="col-md-5 col-md-offset-3">
					<#if entity.status ==  QcodeUserApplication.STATUS_WAITING >
					<a class="btn btn-sm btn-primary btn-Auditing" href="javaScript:void(0)" onclick = "Auditing(${(entity.id)!},${(entity.userId)!},${(entity.level)!},true)">同意</a>
					<a class="btn btn-sm btn-primary btn-lg btn-Auditing" href="javaScript:void(0)"  data-toggle="modal" data-target="#myModal" >拒绝</a>
					</#if>
					<a class="btn btn-sm btn-primary" href="${base }/QcodeUserApplication/index.html">返回</a>
				</div>
			</div>
	    </div>
		</div>
		</div>
			</form>
		</div>
	</div>
	
	<!-- 模态框（Modal）开始 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						拒绝理由
					</h4>
				</div>
				<div class="modal-body">
	                 <textarea class="form-control" id="refuseReason"  name="refuseReason" rows="3" maxlength="500" placeholder="请填写拒绝理由 1-500字"  style="resize:none;"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
					<button type="button" class="btn btn-primary" onclick = "Auditing(${(entity.id)!},${(entity.userId)!},${(entity.level)!},false)">
						确定
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框（Modal）结束 -->
</section>
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
	<script type="text/javascript">
		jQuery(function($) {
		})
		
		
		//Auditing审核	
		function Auditing(entityId,userId,level,isAgree){
			var params ={};
			params.id = entityId;
			if(isAgree){
				params.status = 1;
				params.userId = userId;
				params.level = level;
				
				Dialog.confirm({message: "确定要同意吗？"}).on(function(callback){
					if (callback)
					{
						auditRequest(params);
					}
				});
			}else{
				params.status = 0;
				params.refuseReason = $('#refuseReason').val();
				auditRequest(params);
			}
		}
		
		
		function auditRequest(params){
			$.ajax({
			        type : 'POST',
			        url : base+"/QcodeUserApplication/update.json",
			        data : params,  
			        dataType : 'json',
			        traditional:true,
			        success : function(result){
			        	switch(result.code){
			        	case 401:
			        		var n = noty({
					            text        : result.message,
					            type        : 'error',
					            dismissQueue: true,
					            layout      : 'topCenter',
					            theme       : 'relax',
					            timeout		: 1500
					        });
		        			break;
		        		default:
			        		if (result.success){
				        		var n = noty({
						            text        : result.message,
						            type        : 'success',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1000,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	window.location.href="${base}/QcodeUserApplication/index.html";
								        }
								    }
						        });
				        	}else{
				        		var n = noty({
						            text        : result.message,
						            type        : 'error',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1500,
					                callback: {     // 设置回调函数
								        afterClose: function() {
								        	if (result.code == 409 ){//已被审核
								        		 window.location.reload();
								        	}
								        }
								    }
						        });
				        	}
			        	}
			        },
			        cache:false,
			        error : function(){
			           top.Dialog.alert("审核失败!");
			        }
			    });
		}
	</script>
</@main.footer>
