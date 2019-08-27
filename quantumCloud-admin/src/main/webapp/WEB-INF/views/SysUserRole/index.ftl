<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户角色">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>用户角色管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SysUserRole/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
						<div class="col-md-offset-5 col-md-7">
							<button class="btn btn-xs btn-primary submitForm">查询</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-xs btn-primary clearForm">重置</button>
						</div> 
					</div>
				</div>
				<div class="box">	
					<div class="box-header with-border">
						<div class="btn-group">
							<@shiro.hasAnyRoles name="ADMIN,SysUserRole:save">
							<a class="btn btn-xs btn-primary" href="${base}/SysUserRole/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th>角色ID</th>
								  	<th>用户ID</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td title="${(entity.roleId)!}">${(entity.roleId)!}</td>
									<td title="${(entity.userId)!}">${(entity.userId)!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SysUserRole:detail">
								<a href="${base}/SysUserRole/detail.html?roleId=${(entity.roleId)!}&userId=${(entity.userId)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysUserRole:update">
								<a href="${base}/SysUserRole/edit.html?roleId=${(entity.roleId)!}&userId=${(entity.userId)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysUserRole:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SysUserRole/delete.json',{roleId:'${(entity.roleId)!}',userId:'${(entity.userId)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="1" class="error center">无记录</td></tr>
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
