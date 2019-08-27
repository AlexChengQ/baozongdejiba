<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="留言管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>留言管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeMessage/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">姓名</label> 
							<input type="text" id="name" name="name" value="${(RequestParameters.name)!}" class="form-control"/>
							</div>
						</div>
						<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">Email</label> 
							<input type="text" id="email" name="email" value="${(RequestParameters.email)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_title">机构</label> 
							<input type="text" id="orgName" name="orgName" value="${(RequestParameters.orgName)!}" class="form-control"/>
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
							<!--<@shiro.hasAnyRoles name="ADMIN,QcodeMessage:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeMessage/add.html">新增</a>
							</@shiro.hasAnyRoles>-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>姓名</th>
								  	<th>Email</th>
                                    <th>机构</th>
								  	<th>主题</th>
								  	<th>内容</th>
								  	<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.name)!}">${(entity.name)!'游客'}</td>
									<td title="${(entity.email)!}">${(entity.email)!'游客'}</td>
                                    <td title="${(entity.orgName)!}">${(entity.orgName)!'游客'}</td>
									<td title="${(entity.title)!}">${(entity.title)!}</td>
									<td title="${(entity.content)!}">${(entity.content)!}</td>
									<td title="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeMessage:detail">
								<a href="${base}/QcodeMessage/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeMessage:update">
								<!-- <a href="${base}/QcodeMessage/edit.html?id=${(entity.id)!}">编辑</a>-->
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeMessage:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/QcodeMessage/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="5" class="error center">无记录</td></tr>
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
