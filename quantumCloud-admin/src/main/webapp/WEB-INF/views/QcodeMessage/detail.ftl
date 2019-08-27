<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="留言管理">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeMessage/index.html">留言管理</a></li>
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
				    <input type="text" name="userId" value="${(entity.name)!'游客'}"  class="form-control" disabled/>
		 		</div>
			 </div>	
			 
			 <div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 机构 </label>
				<div class="col-md-6">
				    <input type="text" name="userId" value="${(entity.orgName)!'游客'}"  class="form-control" disabled/>
		 		</div>
			 </div>
			 
			 <div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> Email </label>
				<div class="col-md-6">
				    <input type="text" name="userId" value="${(entity.email)!'游客'}"  class="form-control" disabled/>
		 		</div>
			 </div>		
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 主题 </label>
				<div class="col-md-6">
				    <input type="text" name="title" value="${(entity.title)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 内容 </label>
				<div class="col-md-6" style="height: 100px">
				    <textarea name="content" class="form-control" disabled style="height: 100px">${(entity.content)!}</textarea>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
				<div class="col-md-6">
				    <input name="createTime" type="text" value="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
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
					<a class="btn btn-sm btn-primary" href="${base }/QcodeMessage/index.html">返回</a>
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
