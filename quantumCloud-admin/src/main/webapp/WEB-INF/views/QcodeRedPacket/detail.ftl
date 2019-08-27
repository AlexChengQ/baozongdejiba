<#-----author:JT------->
<#-----date:2018-01-29------->
<@main.header title="红包管理">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeRedPacket/index.html">红包管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 姓名 </label>
				<div class="col-md-6">
				    <input type="text" name="openId" value="${(entity.userName)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> Email </label>
				<div class="col-md-6">
				    <input type="text" name="userMail" value="${(entity.userMail)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 微信名称 </label>
				<div class="col-md-6">
				    <input type="text" name="wechatName" value="${(entity.wechatName)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 发放时间 </label>
				<div class="col-md-6">
				    <input name="createTime" type="text" value="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 金额 </label>
				<div class="col-md-6">
				    <input type="text" name="moneny" value="${(entity.moneny)?string('#.##')}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	<#assign statuss={'1':'成功','0':'失败'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 状态 </label>
				<div class="col-md-6">
					<input type="text" name="status" value="${(statuss[''+entity.status])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 结果信息 </label>
				<div class="col-md-6">
				    <input type="text" name="reason" value="${(entity.reason)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 <#else>
			<div role="alert" class="alert alert-danger ">
		      <strong>记录不存在</strong>
		    </div>
		</#if>
		<div class="form-group">
	    	<div class="form-group">
				<div class="col-md-5 col-md-offset-3">
					<a class="btn btn-sm btn-primary" href="${base }/QcodeRedPacket/index.html">返回</a>
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
	<script type="text/javascript">
		jQuery(function($) {
		})
	</script>
</@main.footer>
