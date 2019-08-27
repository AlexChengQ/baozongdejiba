<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="帖子举报管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>帖子举报管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/qcodereport/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_type">类别</label>
                                <select id="_type" name="type" val="${(RequestParameters.type)!}"
										class="form-control select2" style="width: 100%;">
                                    <option value="">全部</option>
                                    <option value="01">帖子</option>
                                    <option value="02">评论</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_reportType">举报类型</label>
                                <select id="_reportType" name="reportType" val="${(RequestParameters.reportType)!}" class="form-control select2" style="width: 100%;">
                                    <option value="">全部</option>
                                    <option value="1">违规内容</option>
                                    <option value="2">涉嫌广告</option>
                                    <option value="3">文不对题</option>
                                    <option value="4">抄袭内容</option>
                                    <option value="5">其他理由</option>
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
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>类别</th>
								  	<th>举报类型</th>
								  	<th>举报人</th>
								  	<th>帖子标题</th>
								  	<th>评论内容</th>
								  	<th>举报内容</th>
								  	<th>时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.typename)!}">${(entity.typename)!}</td>
									<td title="${(entity.reporttypename)!}">${(entity.reporttypename)!}</td>
									<td title="${(entity.reportusername)!}">${(entity.reportusername)!}</td>
									<td title="${(entity.topictitle)!}">${(entity.topictitle)!}</td>
									<td title="${(entity.replycontent)!}">${(entity.replycontent)!}</td>
									<td title="${(entity.reportcontent)!}">${(entity.reportcontent)!}</td>
									<td title="${(entity.addtime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity
									.addtime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,qcodereport:detail">
								<a href="${base}/qcodereport/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<#--<@shiro.hasAnyRoles name="ADMIN,qcodereport:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/qcodereport/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>-->
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
