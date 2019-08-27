<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="项目表">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeProject/index.html">项目表管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 项目名称 </label>
				<div class="col-md-6">
				    <input type="text" name="name" value="${(entity.name)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建人id </label>
				<div class="col-md-6">
				    <input type="text" name="userId" value="${(entity.userId)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
				<div class="col-md-6">
				    <input name="createTime" type="text" value="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 量子比特数 </label>
				<div class="col-md-6">
				    <input type="text" name="qubitNum" value="${(entity.qubitNum)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 经典比特数 </label>
				<div class="col-md-6">
				    <input type="text" name="classicalbitNum" value="${(entity.classicalbitNum)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 重复次数 </label>
				<div class="col-md-6">
				    <input type="text" name="repeat" value="${(entity.repeat)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 图片 </label>
				<div class="col-md-6">
				    <input type="text" name="pic" value="${(entity.pic)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 项目描述 </label>
				<div class="col-md-6">
				    <textarea name="desc" class="form-control" disabled>${(entity.desc)!}</textarea>
		 		</div>
			 </div>	
		 	<#assign taskTypeIds={'3':'半导体量子芯片','2':'超导量子芯片','1':'量子仿真'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 任务类型id </label>
				<div class="col-md-6">
					<input type="text" name="taskTypeId" value="${(taskTypeIds[''+entity.taskTypeId])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	<#assign isDels={'1':'是','0':'否'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否删除 </label>
				<div class="col-md-6">
					<input type="text" name="isDel" value="${(isDels[''+entity.isDel])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文名称 </label>
				<div class="col-md-6">
				    <textarea name="nameEnglish" class="form-control" disabled>${(entity.nameEnglish)!}</textarea>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 英文描述 </label>
				<div class="col-md-6">
				    <textarea name="descEnglish" class="form-control" disabled>${(entity.descEnglish)!}</textarea>
		 		</div>
			 </div>	
		 	<#assign analogTypes={'1':'概率方法','0':'Monte-Carlo'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 模拟类型 </label>
				<div class="col-md-6">
					<input type="text" name="analogType" value="${(analogTypes[''+entity.analogType])!}"  class="form-control" disabled />
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
					<a class="btn btn-sm btn-primary" href="${base }/QcodeProject/index.html">返回</a>
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
