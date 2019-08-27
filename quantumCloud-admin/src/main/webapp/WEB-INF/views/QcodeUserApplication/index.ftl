<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="用户申请管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>用户申请管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeUserApplication/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_email">Email</label> 
							<input type="text" id="_email" name="email" value="${(RequestParameters.email)!}" class="form-control"/>
							</div>
						</div>
						<div class="col-md-3">
				 			<div class="form-group">
							<label for="_status">申请状态</label> 
							<select id="_status" name="status" val="${(RequestParameters.status)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="2">未审核</option>
								<option value="1">已通过</option>
								<option value="0">已拒绝</option>
							</select>
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
							<!--<@shiro.hasAnyRoles name="ADMIN,QcodeUserApplication:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeUserApplication/add.html">新增</a>
							</@shiro.hasAnyRoles>-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>Emil</th>
								  	<th>用户等级</th><#assign levels={'3':'三级用户','2':'二级用户','1':'一级用户'}>
								  	<th>申请状态</th><#assign statuss={'2':'未审核','1':'已通过','0':'已拒绝'}>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.email)!}">${(entity.email)!}</td>
									<td title="${(levels[''+entity.level])!}">${(levels[''+entity.level])!}</td>
									<td title="${(statuss[''+entity.status])!}">${(statuss[''+entity.status])!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeUserApplication:detail">								
								<a href="${base}/QcodeUserApplication/detail.html?id=${(entity.id)!}">
								<#if (entity.status) == 2>  审核		
								<#else> 查看
								</#if>
								</a>
								</@shiro.hasAnyRoles>
								<!--<@shiro.hasAnyRoles name="ADMIN,QcodeUserApplication:update">
								<a href="${base}/QcodeUserApplication/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeUserApplication:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/QcodeUserApplication/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>-->
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="10" class="error center">无记录</td></tr>
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
			})
		</script>
</@main.footer>
