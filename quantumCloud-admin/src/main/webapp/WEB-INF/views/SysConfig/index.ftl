<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="参数配置">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>参数配置管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SysConfig/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_keyname">变量名</label> 
							<input type="text" id="_keyname" name="keyname" value="${(RequestParameters.keyname)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_val">变量值</label> 
							<input type="text" id="_val" name="val" value="${(RequestParameters.val)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_category">分类</label> 
							<input type="text" id="_category" name="category" value="${(RequestParameters.category)!}" class="form-control"/>
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
							<@shiro.hasAnyRoles name="ADMIN,SysConfig:save">
							<a class="btn btn-xs btn-primary" href="${base}/SysConfig/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>描述</th>
								  	<th>变量名</th>
								  	<th>变量值</th>
								  	<th>分类</th>
								  	<th>分类描述</th>
								  	<th>排序</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.descn)!}">${(entity.descn)!}</td>
									<td title="${(entity.keyname)!}">${(entity.keyname)!}</td>
									<td title="${(entity.val)!}">${(entity.val)!}</td>
									<td title="${(entity.category)!}">${(entity.category)!}</td>
									<td title="${(entity.categoryDesc)!}">${(entity.categoryDesc)!}</td>
									<td title="${(entity.orderNo)!}">${(entity.orderNo)!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SysConfig:detail">
								<a href="${base}/SysConfig/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysConfig:update">
								<a href="${base}/SysConfig/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysConfig:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SysConfig/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="7" class="error center">无记录</td></tr>
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
