<#-----author:JT------->
<#-----date:2017-10-26------->
<@main.header title="招聘表">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeRecruit/index.html">招聘表管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 岗位名称 </label>
				<div class="col-md-6">
				    <input type="text" name="positionname" value="${(entity.positionname)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 岗位名称英文标题 </label>
				<div class="col-md-6">
				    <input type="text" name="positionnameEnglish" value="${(entity.positionnameEnglish)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 提示 </label>
				<div class="col-md-6">
				    <input type="text" name="remark" value="${(entity.remark)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文提示 </label>
				<div class="col-md-6">
				    <input type="text" name="remarkEnglish" value="${(entity.remarkEnglish)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	<#assign category={'1':'校园招聘','0':'社会招聘'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否展示 </label>
				<div class="col-md-6">
					<input type="text" name="category" value="${(category[''+entity.category])!}"  class="form-control" disabled />
		 		</div>
			 </div>			 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 工作地点 </label>
				<div class="col-md-6">
				    <input type="text" name="workingPlace" value="${(entity.workingPlace)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文工作地点 </label>
				<div class="col-md-6">
				    <input type="text" name="workingPlaceEnglish" value="${(entity.workingPlaceEnglish)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 招聘人数 </label>
				<div class="col-md-6">
				    <input type="text" name="num" value="${(entity.num)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 工作内容 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.jobDescription)!}</#noescape>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文工作内容 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.jobDescriptionEnglish)!}</#noescape>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 专业及要求 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.jobRequirements)!}</#noescape>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文专业及要求 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.jobRequirementsEnglish)!}</#noescape>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 基本要求 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.baseRequirements)!}</#noescape>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文基本要求 </label>
				<div class="col-md-6">
				    <#noescape>${(entity.baseRequirementsEnglish)!}</#noescape>
		 		</div>
			 </div>	
		 	<#assign isShows={'1':'展示','0':'不展示'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否展示 </label>
				<div class="col-md-6">
					<input type="text" name="isShow" value="${(isShows[''+entity.isShow])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 发布时间 </label>
				<div class="col-md-6">
				    <input name="publishTime" type="text" value="${(entity.publishTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
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
					<a class="btn btn-sm btn-primary" href="${base }/QcodeRecruit/index.html">返回</a>
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
