<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推送管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>推送管理</li>
    </ol>

	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodePush/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">推送人</label>
							<input type="text" id="userName" name="userName" value="${(RequestParameters.userName)!}"
								   class="form-control"/>
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
							<@shiro.hasAnyRoles name="ADMIN,QcodePush:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodePush/add.html">新增</a>
							</@shiro.hasAnyRoles>
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>推送人</th>
								  	<th>主题</th>
								  	<th style="width: 540px">内容</th>
								  	<th>创建时间</th>
									<th>发送成功条数</th>
                                    <th>发送失败条数</th>
                                    <th>总发件数</th>
									<th>无效邮箱列表</th>
									<th>有效邮箱发送失败列表</th>
									<th>发送状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.username)!}">${(entity.username)!}</td>
									<td title="${(entity.title)!}">${(entity.title)!}</td>
									<td title="${(entity.content)!}">${(entity.content)!}</td>
									<td title="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                	<td id="successCount_${(entity.id)!}" data-value="${(entity.id)!}">${mailStatus['${entity.id}']['successCount']}</td>
                                	<td id="failedCount_${(entity.id)!}" data-value="${(entity.id)!}">${mailStatus['${entity.id}']['failedCount']}</td>
                                	<td id="allCount_${(entity.id)!}" data-value="${(entity.id)!}">${mailStatus['${entity.id}']['allCount']}</td>
									<td id="invalid_${(entity.id)!}" data-value="${(entity.id)!}"><a href="${base}/QcodePush/getFailedMail.html?id=${(entity.id)!}&flag=1">点击查看</a></td>
									<td id="validUnsent_${(entity.id)!}" data-value="${(entity.id)!}"><a href="${base}/QcodePush/getFailedMail.html?id=${(entity.id)!}&flag=2">点击查看</a></td>
    								<td id="status_${(entity.id)!}" data-value="${(entity.id)!}">${mailStatus['${entity.id}']['status']}</td>

								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodePush:detail">
                                <a href="${base}/QcodePush/edit.html?id=${(entity.id)!}">编辑</a>
								<a href="${base}/QcodePush/preview.html?id=${(entity.id)!}">预览</a>
								<a href="${base}/QcodePush/detail.html?id=${(entity.id)!}">去发送</a>
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
            var t1
			$(function() {
			    <#if mailStatus??>
                    t1 = setInterval(function(){queryMailStatus()},5000);
				</#if>

			})


			function queryMailStatus() {
			    $.get(ctx + "QcodePush/queryStatus.json",function (data) {
					if(data) {
						$.each($('td[id^="successCount"]'),function(i,v) {
						    var m = $(v).attr("data-value");
						    var map = data[m];
						    if(map) {
                                $("#successCount_"+m).text(map.successCount);
                                $("#failedCount_"+m).text(map.failedCount);
                                $("#allCount_"+m).text(map.allCount);
                                if("running" == map.status) {

                                }else {
                                    clearInterval(t1);
                                }

                                $("#status_"+m).text(map.status);
							}

						})
					}
                })
			}
		</script>

</@main.footer>
