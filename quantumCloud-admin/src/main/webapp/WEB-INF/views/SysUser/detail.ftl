<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户管理">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysUser/index.html">用户管理</a></li>
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
				    <input type="text" name="fullname" value="${(entity.fullname)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 登录名 </label>
				<div class="col-md-6">
				    <input type="text" name="username" value="${(entity.username)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 邮箱 </label>
				<div class="col-md-6">
				    <input type="text" name="email" value="${(entity.email)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<#assign statuss={'1':'启用','2':'禁用'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 状态 </label>
				<div class="col-md-6">
					<input type="text" name="status" value="${(statuss[''+entity.status])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	<#assign isSuperadmins={'0':'普通管理员','1':'超级管理员'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 类型 </label>
				<div class="col-md-6">
					<input type="text" name="isSuperadmin" value="${(isSuperadmins[''+entity.isSuperadmin])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 备注 </label>
				<div class="col-md-6">
				    <input type="text" name="remark" value="${(entity.remark)!}"  class="form-control" disabled />
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
					<a class="btn btn-sm btn-primary" href="${base }/SysUser/index.html">返回</a>
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
