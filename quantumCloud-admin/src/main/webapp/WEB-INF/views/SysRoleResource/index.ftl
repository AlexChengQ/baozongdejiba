<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="角色资源">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>角色资源管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SysRoleResource/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_roleId">角色ID</label> 
							<input type="text" id="_roleId" name="roleId" value="${(RequestParameters.roleId)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_resource">资源名</label> 
							<input type="text" id="_resource" name="resource" value="${(RequestParameters.resource)!}" class="form-control"/>
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
							<@shiro.hasAnyRoles name="ADMIN,SysRoleResource:save">
							<a class="btn btn-xs btn-primary" href="${base}/SysRoleResource/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th>角色ID</th>
								  	<th>资源名</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td title="${(entity.roleId)!}">${(entity.roleId)!}</td>
									<td title="${(entity.resource)!}">${(entity.resource)!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SysRoleResource:detail">
								<a href="${base}/SysRoleResource/detail.html?roleId=${(entity.roleId)!}&resource=${(entity.resource)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysRoleResource:update">
								<a href="${base}/SysRoleResource/edit.html?roleId=${(entity.roleId)!}&resource=${(entity.resource)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysRoleResource:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SysRoleResource/delete.json',{roleId:'${(entity.roleId)!}',resource:'${(entity.resource)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="3" class="error center">无记录</td></tr>
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
