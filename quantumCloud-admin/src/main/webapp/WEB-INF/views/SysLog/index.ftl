<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="系统日志">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>系统日志管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SysLog/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_operation">操作</label> 
							<input type="text" id="_operation" name="operation" value="${(RequestParameters.operation)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_operContent">操作内容</label> 
							<input type="text" id="_operContent" name="operContent" value="${(RequestParameters.operContent)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_username">操作人</label> 
							<input type="text" id="_username" name="username" value="${(RequestParameters.username)!}" class="form-control"/>
							</div>
						</div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_operDate">操作日期</label>
                                <div class="input-group date datetimepicker" data-date="${(RequestParameters.operDate)!}" data-date-format="yyyy-mm-dd hh:ii:ss">
                                    <input class="form-control" id="operDate" name="operDate" type="text" value="${(RequestParameters.operDate)!}" readonly>
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
							<#--<@shiro.hasAnyRoles name="ADMIN,SysLog:save">
							<a class="btn btn-xs btn-primary" href="${base}/SysLog/add.html">新增</a>
							</@shiro.hasAnyRoles>	-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>操作</th>
								  	<th>操作内容</th>
								  	<th>操作人账号</th>
								  	<th>操作人</th>
								  	<th>客户端</th>
								  	<th>IP</th>
								  	<th>操作日期</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.operation)!}">${(entity.operation)!}</td>
									<td title="${(entity.operContent)!}">${(entity.operContent)!}</td>
									<td title="${(entity.userId)!}">${(entity.userId)!}</td>
									<td title="${(entity.username)!}">${(entity.username)!}</td>
									<td title="${(entity.userAgent)!}">${(entity.userAgent)!}</td>
									<td title="${(entity.ip)!}">${(entity.ip)!}</td>
									<td title="${(entity.operDate?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.operDate?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SysLog:detail">
								<a href="${base}/SysLog/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<#--<@shiro.hasAnyRoles name="ADMIN,SysLog:update">
								<a href="${base}/SysLog/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysLog:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SysLog/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>-->
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="8" class="error center">无记录</td></tr>
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
