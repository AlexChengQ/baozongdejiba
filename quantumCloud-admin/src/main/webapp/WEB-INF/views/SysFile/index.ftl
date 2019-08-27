<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="文件">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>文件管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/SysFile/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_fileName">文件名</label> 
							<input type="text" id="_fileName" name="fileName" value="${(RequestParameters.fileName)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_type">文件类型</label> 
							<input type="text" id="_type" name="type" value="${(RequestParameters.type)!}" class="form-control"/>
							</div>
						</div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_extension">扩展名</label>
                                <input type="text" id="_extension" name="extension" value="${(RequestParameters.extension)!}" class="form-control"/>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_locked">是否锁定</label>
                                <select id="_locked" name="locked" val="${(RequestParameters.locked)!}" class="form-control select2" style="width: 100%;">
                                    <option value="">-</option>
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </div>
                        </div>
			 		</div>
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_createTime">创建时间</label> 
			                <div class="input-group date datetimepicker" data-date="${(RequestParameters.createTime)!}" data-date-format="yyyy-mm-dd hh:ii:ss">
			                    <input class="form-control" id="createTime" name="createTime" type="text" value="${(RequestParameters.createTime)!}" readonly>
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
							<@shiro.hasAnyRoles name="ADMIN,SysFile:save">
							<a class="btn btn-xs btn-primary" href="${base}/SysFile/add.html">新增</a>
							</@shiro.hasAnyRoles>	
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>文件名</th>
								  	<th>描述</th>
								  	<th>文件路径</th>
								  	<th>文件类型</th>
								  	<th>扩展名</th>
								  	<th>文件大小</th>
								  	<th>对象主键</th>
								  	<th>引用对象</th>
								  	<th>是否锁定</th><#assign lockeds={'0':'否','1':'是'}>
								  	<th>上传人ID</th>
								  	<th>上传人名称</th>
								  	<th>扩展字段</th>
								  	<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.fileName)!}">${(entity.fileName)!}</td>
									<td title="${(entity.descn)!}">${(entity.descn)!}</td>
									<td title="${(entity.path)!}">${(entity.path)!}</td>
									<td title="${(entity.type)!}">${(entity.type)!}</td>
									<td title="${(entity.extension)!}">${(entity.extension)!}</td>
									<td title="${(entity.size)!}">${(entity.size)!}</td>
									<td title="${(entity.refId)!}">${(entity.refId)!}</td>
									<td title="${(entity.refObj)!}">${(entity.refObj)!}</td>
									<td title="${(lockeds[''+entity.locked])!}">${(lockeds[''+entity.locked])!}</td>
									<td title="${(entity.userId)!}">${(entity.userId)!}</td>
									<td title="${(entity.username)!}">${(entity.username)!}</td>
									<td title="${(entity.extField)!}">${(entity.extField)!}</td>
									<td title="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,SysFile:detail">
								<a href="${base}/SysFile/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysFile:update">
								<a href="${base}/SysFile/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,SysFile:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/SysFile/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="14" class="error center">无记录</td></tr>
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
