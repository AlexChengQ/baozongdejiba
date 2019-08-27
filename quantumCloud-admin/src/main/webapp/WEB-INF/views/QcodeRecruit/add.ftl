<#-----author:JT------->
<#-----date:2017-10-15------->
<@main.header title="招聘表">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodeRecruit/index.html">招聘表管理</a></li>
       <li class="active">增加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post"  class="form-horizontal" role="form" >
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		<input type="hidden" name="id" value="${(entity.id)!}"/>
		 <div class="form-group">
			<label for="positionname" class="col-md-3 control-label no-padding-right"> 岗位名称 </label>
			<div class="col-md-6">
			    <input type="text" id="positionname" name="positionname" value="${(entity.positionname)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-positionname" ></font><span id="errormsg-positionname" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="positionnameEnglish" class="col-md-3 control-label no-padding-right"> 岗位名称(英文) </label>
			<div class="col-md-6">
			    <input type="text" id="positionnameEnglish" name="positionnameEnglish" value="${(entity.positionnameEnglish)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-positionnameEnglish" ></font><span id="errormsg-positionnameEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="remark" class="col-md-3 control-label no-padding-right"> 提示 </label>
			<div class="col-md-6">
			    <input type="text" id="remark" name="remark" value="${(entity.remark)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-remark" ></font><span id="errormsg-remark" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="remarkEnglish" class="col-md-3 control-label no-padding-right"> 提示(英文) </label>
			<div class="col-md-6">
			    <input type="text" id="remarkEnglish" name="remarkEnglish" value="${(entity.remarkEnglish)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-remarkEnglish" ></font><span id="errormsg-remarkEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="category" class="col-md-3 control-label no-padding-right"> 招聘类别 </label>
			<div class="col-md-6">
					<select id="category" name="category" val="${(entity.category)!}" class="form-control select2">
						<option value="0">社会招聘</option>
						<option value="1">校园招聘</option>
					</select>
			</div>
			<div class="col-md-3"><font id="require-category" ></font><span id="errormsg-category" class="error"></span></div>
		 </div>			 		 
		 <div class="form-group">
			<label for="department" class="col-md-3 control-label no-padding-right"> 所属部门 </label>
			<div class="col-md-6">
			    <input type="text" id="department" name="department" value="${(entity.department)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-department" ></font><span id="errormsg-department" class="error"></span></div>
		 </div>			 		 
		 <div class="form-group">
			<label for="departmentEnglish" class="col-md-3 control-label no-padding-right"> 所属部门(英文) </label>
			<div class="col-md-6">
			    <input type="text" id="departmentEnglish" name="departmentEnglish" value="${(entity.departmentEnglish)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-departmentEnglish" ></font><span id="errormsg-departmentEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="workingPlace" class="col-md-3 control-label no-padding-right"> 工作地点 </label>
			<div class="col-md-6">
			    <input type="text" id="workingPlace" name="workingPlace" value="${(entity.workingPlace)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-workingPlace" ></font><span id="errormsg-workingPlace" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="workingPlaceEnglish" class="col-md-3 control-label no-padding-right"> 工作地点(英文) </label>
			<div class="col-md-6">
			    <input type="text" id="workingPlaceEnglish" name="workingPlaceEnglish" value="${(entity.workingPlaceEnglish)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-workingPlaceEnglish" ></font><span id="errormsg-workingPlaceEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="num" class="col-md-3 control-label no-padding-right"> 招聘人数 </label>
			<div class="col-md-6">
			    <input type="text" id="num" name="num" value="${(entity.num)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-num" ></font><span id="errormsg-num" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="jobDescription" class="col-md-3 control-label no-padding-right"> 工作内容 </label>
			<div class="col-md-6">
				    <textarea id="jobDescription" name="jobDescription" ref="jobDescription" class="form-control">${(entity.jobDescription)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-jobDescription" ></font><span id="errormsg-jobDescription" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="jobDescriptionEnglish" class="col-md-3 control-label no-padding-right"> 工作内容(英文) </label>
			<div class="col-md-6">
				    <textarea id="jobDescriptionEnglish" name="jobDescriptionEnglish" ref="jobDescriptionEnglish" class="form-control">${(entity.jobDescriptionEnglish)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-jobDescriptionEnglish" ></font><span id="errormsg-jobDescriptionEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="jobRequirements" class="col-md-3 control-label no-padding-right"> 专业及要求 </label>
			<div class="col-md-6">
				    <textarea id="jobRequirements" name="jobRequirements" ref="jobRequirements" class="form-control">${(entity.jobRequirements)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-jobRequirements" ></font><span id="errormsg-jobRequirements" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="jobRequirementsEnglish" class="col-md-3 control-label no-padding-right"> 专业及要求(英文) </label>
			<div class="col-md-6">
				    <textarea id="jobRequirementsEnglish" name="jobRequirementsEnglish" ref="jobRequirementsEnglish" class="form-control">${(entity.jobRequirementsEnglish)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-jobRequirementsEnglish" ></font><span id="errormsg-jobRequirementsEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="baseRequirements" class="col-md-3 control-label no-padding-right"> 基本要求 </label>
			<div class="col-md-6">
				    <textarea id="baseRequirements" name="baseRequirements" ref="baseRequirements" class="form-control">${(entity.baseRequirements)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-baseRequirements" ></font><span id="errormsg-baseRequirements" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="baseRequirementsEnglish" class="col-md-3 control-label no-padding-right"> 基本要求(英文) </label>
			<div class="col-md-6">
				    <textarea id="baseRequirementsEnglish" name="baseRequirementsEnglish" ref="baseRequirementsEnglish" class="form-control">${(entity.baseRequirementsEnglish)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-baseRequirementsEnglish" ></font><span id="errormsg-baseRequirementsEnglish" class="error"></span></div>
		 </div>			 		 		 	
		 <div class="form-group">
			<label for="isShow" class="col-md-3 control-label no-padding-right"> 是否展示 </label>
			<div class="col-md-6">
					<select id="isShow" name="isShow" val="${(entity.isShow)!}" class="form-control select2">
						<option value="0">不展示</option>
						<option value="1">展示</option>
					</select>
			</div>
			<div class="col-md-3"><font id="require-isShow" ></font><span id="errormsg-isShow" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="publishTime" class="col-md-3 control-label no-padding-right"> 发布时间 </label>
			<div class="col-md-6">
				<div class="input-group date datetimepicker-day" data-date="${(entity.publishTime?string('yyyy-MM-dd HH:mm:ss'))!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                    <input class="form-control" id="publishTime" name="publishTime" type="text" value="${(entity.publishTime?string('yyyy-MM-dd HH:mm:ss'))!}" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
			</div>
			<div class="col-md-3"><font id="require-publishTime" ></font><span id="errormsg-publishTime" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
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
<script charset="utf-8" src="${base}/assets/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/plugins/code/prettify.js"></script>	
<script type="text/javascript" src="${validateJS}/QcodeRecruit.js"></script>
<script type="text/javascript" src="${base}/assets/view/QcodeRecruit/add.js"></script>	
</@main.footer>