<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>用户管理</li>
    </ol>
    <div class="row">
        <div class="col-md-12">
            <form method="post" id="searchForm" action="${base}/SysUser/index.html" autocomplete="off">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="_username">用户名</label>
                                    <input type="text" id="_username" name="username" value="${(RequestParameters.username)!}" class="form-control"/>
								</div>
							</div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="isSuperadmin">类型</label>
                                    <select id="isSuperadmin" name="isSuperadmin" val="${(RequestParameters.isSuperadmin)!}" class="form-control select2" style="width: 100%;">
                                        <option value="">-</option>
                                        <option value="0">普通管理员</option>
                                        <option value="1">超级管理员</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="status">状态</label>
                                    <select id="status" name="status" val="${(RequestParameters.status)!}" class="form-control select2" style="width: 100%;">
                                        <option value="">-</option>
                                        <option value="1">启用</option>
                                        <option value="2">禁用</option>
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
							<@shiro.hasAnyRoles name="ADMIN,SysUser:save">
                                <a class="btn btn-sm btn-primary" href="${base}/SysUser/add.html">新增</a>
							</@shiro.hasAnyRoles>
						</div>
                    </div>
                    <div class="box-body">
                        <table id="example2"  class="table table-bordered table-hover dataList">
                            <thead>
                            <tr>
                                <th class="hide">id</th>
							<#--<th>编号</th>-->
                                <th>用户名</th>
                                <th>姓名</th>
                                <th>角色</th>
                                <th>类型</th><#assign isSuperadmins={'0':'普通管理员','1':'超级管理员'}>
                                <th>状态</th><#assign statuss={'1':'启用','2':'禁用'}>
                                <th>备注</th>
                                <th width="200px">操作</th>
                            </tr>
                            </thead>
                            <tbody>
								<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
									<#list pager.entityList as entity>
                                    <tr>
                                        <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<#--<td title="${(entity_index+1)!}">${(entity_index+1)!}</td>-->
                                        <td title="${(entity.username)!}">${(entity.username)!}</td>
                                        <td title="${(entity.fullname)!}">${(entity.fullname)!}</td>
                                        <td title="${(entity.roleName)!}">${(entity.roleName)!}</td>
                                        <td title="${(isSuperadmins[''+entity.isSuperadmin])!}">${(isSuperadmins[''+entity.isSuperadmin])!}</td>
                                        <td title="${(statuss[''+entity.status])!}">${(statuss[''+entity.status])!}</td>
                                        <td title="${(entity.remark)!}">${(entity.remark)!}</td>
                                        <td>
                                        <#if (entity.isSuperadmin)?? && (entity.isSuperadmin!=0)>
											<@shiro.hasAnyRoles name="ADMIN,SysUser:detail">
                                                <a href="${base}/SysUser/detail.html?id=${(entity.id)!}">查看</a>
											</@shiro.hasAnyRoles>
                                        <#else>
                                            <@shiro.hasAnyRoles name="ADMIN,SysUser:detail">
                                                <a href="${base}/SysUser/detail.html?id=${(entity.id)!}">查看</a>
                                            </@shiro.hasAnyRoles>
											<@shiro.hasAnyRoles name="ADMIN,SysUser:update">
                                                <a href="${base}/SysUser/edit.html?id=${(entity.id)!}">编辑</a>
											</@shiro.hasAnyRoles>
											<@shiro.hasAnyRoles name="ADMIN,SysUser:delete">
                                                <a href="javascript:void(0)" onclick="return del('${base}/SysUser/delete.json',{id:'${(entity.id)!}'});">删除</a>
											</@shiro.hasAnyRoles>
											<@shiro.hasAnyRoles name="ADMIN,SysUser:authorization">
                                                <a href="${base}/SysUser/authorization.html?id=${(entity.id)!}">授权</a>
											</@shiro.hasAnyRoles>
											<@shiro.hasAnyRoles name="ADMIN,SysUser:reset">
                                                <a href="${base}/SysUser/changePwd.html?id=${(entity.id)!}">重置密码</a>
											</@shiro.hasAnyRoles>
                                        </#if>
                                        </td>
                                    </tr>
									</#list>
								<#else>
                                <tr><td colspan="9" class="error center">无记录</td></tr>
								</#if>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
						<@main.pagination pager=pager/>
                    </div>
				</div>
			</form>
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
