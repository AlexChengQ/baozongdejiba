<#-----author:JT------->
<#-----date:2017-10-26------->
<@main.header title="招聘表">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>招聘表管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeRecruit/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_positionname">岗位名称</label> 
							<input type="text" id="_positionname" name="positionname" value="${(RequestParameters.positionname)!}" class="form-control"/>
							</div>
						</div>
						<div class="col-md-3">
				 			<div class="form-group">
							<label for="_workingPlace">工作地点</label> 
							<input type="text" id="_workingPlace" name="workingPlace" value="${(RequestParameters.workingPlace)!}" class="form-control"/>
							</div>
						</div>	
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_department">所属部门</label> 
							<input type="text" id="_department" name="department" value="${(RequestParameters.department)!}" class="form-control"/>
							</div>
						</div>
			 		</div>
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_category">招聘类别</label> 
							<select id="_category" name="category" val="${(RequestParameters.category)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="0">社会招聘</option>
								<option value="1">校园招聘</option>
							</select>
							</div>
						</div>								 			
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_isShow">是否展示</label> 
							<select id="_isShow" name="isShow" val="${(RequestParameters.isShow)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="1">展示</option>
								<option value="0">不展示</option>
							</select>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_publishTime">发布时间</label> 
			                <div class="input-group date datetimepicker-withOut-day" data-date="${(RequestParameters.publishTime)!}" data-date-format="yyyy-mm-dd hh:ii:ss">
			                    <input class="form-control" id="publishTime" name="publishTime" type="text" value="${(RequestParameters.publishTime)!}" readonly>
			                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
			                </div>
							</div>
						</div>
				 		</div>
						<div class="col-md-offset-5 col-md-7">
							<button class="btn btn-xs btn-primary submitForm">查询</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-xs btn-primary clearForm">重置</button>
						</div> 
					</div>
				</div>
				<div class="box">	
					<div class="box-header with-border">
						<div class="btn-group">
							<@shiro.hasAnyRoles name="ADMIN,QcodeRecruit:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeRecruit/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">ID</th>
								  	<th>岗位名称</th>
								  	<th>提示</th>
								  	<th>招聘类别</th><#assign category={'0':'社会招聘','1':'校园招聘'}>
								  	<th>所属部门</th>
								  	<th>工作地点</th>
								  	<th>是否展示</th><#assign isShows={'1':'展示','0':'不展示'}>
								  	<th>发布时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.positionname)!}">${(entity.positionname)!}</td>
									<td title="${(entity.remark)!}">${(entity.remark)!}</td>
									<td title="${(category[''+entity.category])!}">${(category[''+entity.category])!}</td>
									<td title="${(entity.department)!}">${(entity.department)!}</td>
									<td title="${(entity.workingPlace)!}">${(entity.workingPlace)!}</td>
									<td title="${(isShows[''+entity.isShow])!}">${(isShows[''+entity.isShow])!}</td>
									<td title="${(entity.publishTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.publishTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeRecruit:detail">
								<a href="${base}/QcodeRecruit/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeRecruit:update">
								<a href="${base}/QcodeRecruit/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeRecruit:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/QcodeRecruit/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="19" class="error center">无记录</td></tr>
						 	</#if>
						 	</tbody>
						</table>
					</div>
					<div class="panel-footer">
						<@main.pagination pager=pager/>
					</div>
					</form>
			</div>
	</div>
</div>
</section>
	
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
		<script type="text/javascript">
			jQuery(function($) {
				$(".select2").select2();
				$('.datetimepicker-withOut-day').datetimepicker({
                    format: 'yyyy-mm-dd',
                    weekStart: 1,
                    autoclose: true,
                    startView: 2,
                    minView: 2,
                    forceParse: false,
                    language: 'zh-CN'
                });				
			})
		</script>
</@main.footer>
