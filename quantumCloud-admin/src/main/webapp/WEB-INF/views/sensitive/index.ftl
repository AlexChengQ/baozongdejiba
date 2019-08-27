<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="敏感词">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>敏感词管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SensitiveConfig/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="sensitiveWord">敏感词</label>
							<input type="text" id="sensitiveWord" name="sensitiveWord" value="${(RequestParameters.sensitiveWord)!}" class="form-control"/>
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
							<@shiro.hasAnyRoles name="ADMIN,SensitiveConfig:save">
							<a class="btn btn-xs btn-primary" href="${base}/SensitiveConfig/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>敏感词</th>
								  	<th>添加时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.sensitiveWord)!}">${(entity.sensitiveWord)!}</td>
                                	<td title="${(entity.addTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.addTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SensitiveConfig:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SensitiveConfig/deleteSensitiveWord.json',{id:'${(entity.id)!}'});">删除</a>
								<a href="${base}/SensitiveConfig/update.html?id=${entity.id}">修改</a>
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
