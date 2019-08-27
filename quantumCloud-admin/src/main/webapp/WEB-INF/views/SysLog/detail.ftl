<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="系统日志">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysLog/index.html">系统日志管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 操作 </label>
				<div class="col-md-6">
				    <input type="text" name="operation" value="${(entity.operation)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 操作内容 </label>
				<div class="col-md-6" style="height: 100px">
				    <textarea name="operContent" class="form-control" disabled style="height: 100px">${(entity.operContent)!}</textarea>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 操作人账号 </label>
				<div class="col-md-6">
				    <input type="text" name="userId" value="${(entity.userId)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 操作人 </label>
				<div class="col-md-6">
				    <input type="text" name="username" value="${(entity.username)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 客户端 </label>
				<div class="col-md-6">
				    <input type="text" name="userAgent" value="${(entity.userAgent)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> IP </label>
				<div class="col-md-6">
				    <input type="text" name="ip" value="${(entity.ip)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 操作日期 </label>
				<div class="col-md-6">
				    <input name="operDate" type="text" value="${(entity.operDate?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
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
	<script type="text/javascript">
		jQuery(function($) {
		})
	</script>
</@main.footer>
