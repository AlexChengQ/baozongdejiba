<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="任务表">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeTask/index.html">任务表管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 项目版本id </label>
				<div class="col-md-6">
				    <input type="text" name="versionId" value="${(entity.versionId)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 任务编号 </label>
				<div class="col-md-6">
				    <input type="text" name="taskId" value="${(entity.taskId)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 经典寄存器名 </label>
				<div class="col-md-6">
				    <input type="text" name="classicRegisterName" value="${(entity.classicRegisterName)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 执行时间 </label>
				<div class="col-md-6">
				    <input name="startTime" type="text" value="${(entity.startTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 结束时间 </label>
				<div class="col-md-6">
				    <input name="endTime" type="text" value="${(entity.endTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 重复次数 </label>
				<div class="col-md-6">
				    <input type="text" name="repeat" value="${(entity.repeat)!}"  class="form-control" disabled/>
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 测量比特数组 </label>
				<div class="col-md-6">
				    <input type="text" name="meaarr" value="${(entity.meaarr)!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	<#assign statuss={'3':'完成','2':'处理中','1':'等待','5':'已终止','4':'语法错误'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 状态 </label>
				<div class="col-md-6">
					<input type="text" name="status" value="${(statuss[''+entity.status])!}"  class="form-control" disabled />
		 		</div>
			 </div>	
		 	
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 应答 </label>
				<div class="col-md-6">
				    <textarea name="ans" class="form-control" disabled>${(entity.ans)!}</textarea>
		 		</div>
			 </div>	
		 	<#assign isDels={'1':'是','0':'否'}>
		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否删除 </label>
				<div class="col-md-6">
					<input type="text" name="isDel" value="${(isDels[''+entity.isDel])!}"  class="form-control" disabled />
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
					<a class="btn btn-sm btn-primary" href="${base }/QcodeTask/index.html">返回</a>
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
