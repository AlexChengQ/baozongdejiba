<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="文件">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysFile/index.html">文件管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 文件名 </label>
				<div class="col-md-6">
				    <input type="text" name="fileName" value="${(entity.fileName)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 描述 </label>
				<div class="col-md-6">
				    <input type="text" name="descn" value="${(entity.descn)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 文件路径 </label>
				<div class="col-md-6">
				    <input type="text" name="path" value="${(entity.path)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 文件类型 </label>
				<div class="col-md-6">
				    <input type="text" name="type" value="${(entity.type)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 扩展名 </label>
				<div class="col-md-6">
				    <input type="text" name="extension" value="${(entity.extension)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 文件大小 </label>
				<div class="col-md-6">
				    <input type="text" name="size" value="${(entity.size)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 对象主键 </label>
				<div class="col-md-6">
				    <input type="text" name="refId" value="${(entity.refId)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 引用对象 </label>
				<div class="col-md-6">
				    <input type="text" name="refObj" value="${(entity.refObj)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	<#assign lockeds={'0':'否','1':'是'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否锁定 </label>
				<div class="col-md-6">
					<input type="text" name="locked" value="${(lockeds[''+entity.locked])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 上传人ID </label>
				<div class="col-md-6">
				    <input type="text" name="userId" value="${(entity.userId)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 上传人名称 </label>
				<div class="col-md-6">
				    <input type="text" name="username" value="${(entity.username)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 扩展字段 </label>
				<div class="col-md-6">
				    <input type="text" name="extField" value="${(entity.extField)!}"  class="form-control" disabled />
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
	<script type="text/javascript">
		jQuery(function($) {
		})
	</script>
</@main.footer>
