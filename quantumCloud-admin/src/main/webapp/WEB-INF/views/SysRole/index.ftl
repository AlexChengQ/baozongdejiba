<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="系统角色">
</@main.header>
<@main.body>
<#escape x as x?html>
  <section class="content">
    <ol class="breadcrumb">
      <li></li>
      <li>系统角色管理</li>
    </ol>
    <div class="row">
        <div class="col-md-12">
            <form method="post" id="searchForm" action="${base}/SysRole/index.html" autocomplete="off">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="_roleName">角色名称</label>
                                    <input type="text" id="_roleName" name="roleName" value="${(RequestParameters.roleName)!}" class="form-control "/>
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
                          <@shiro.hasAnyRoles name="ADMIN,SysRole:save">
                          <#--<a class="btn btn-xs btn-primary" onclick="return onAction({url:'${base}/SysRole/add.html',title:'新增',callback:refreshList})">新增</a>-->
                              <a class="btn btn-sm btn-primary" href="${base}/SysRole/add.html">新增</a>
                          </@shiro.hasAnyRoles>
                        </div>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-bordered table-hover dataList">
                            <thead>
                            <tr>
                                <th class="hide">role_id</th>
                                <th>角色名称</th>
                                <th>描述</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                              <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                <#list pager.entityList as entity>
                                <tr>
                                    <td class="pk hide" id="roleId" title="${(entity.roleId)!}">${(entity.roleId)!}</td>
                                    <td title="${(entity.roleName)!}">${(entity.roleName)!}</td>
                                    <td title="${(entity.descn)!}">${(entity.descn)!}</td>
                                    <td>
                                      <@shiro.hasAnyRoles name="ADMIN,SysRole:detail">
                                      <#--<a onclick="return onAction({url:'${base}/SysRole/detail.html?roleId=${(entity.roleId)!}',title:'编辑'});">查看</a>-->
                                          <a href="${base}/SysRole/detail.html?roleId=${(entity.roleId)!}">查看</a>
                                      </@shiro.hasAnyRoles>
                                      <@shiro.hasAnyRoles name="ADMIN,SysRole:update">
                                      <#--<a onclick="return onAction({url:'${base}/SysRole/edit.html?roleId=${(entity.roleId)!}',title:'编辑',callback:refreshList});">编辑</a>-->
                                          <a href="${base}/SysRole/edit.html?roleId=${(entity.roleId)!}">编辑</a>
                                      </@shiro.hasAnyRoles>
                                      <@shiro.hasAnyRoles name="ADMIN,SysRole:delete">
                                          <a href="javascript:void(0)" onclick="return del('${base}/SysRole/delete.json',{roleId:'${(entity.roleId)!}'});">删除</a>
                                      </@shiro.hasAnyRoles>
                                    </td>
                                </tr>
                                </#list>
                              <#else>
                              <tr>
                                  <td colspan="5" class="error center">无记录</td>
                              </tr>
                              </#if>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer"><@main.pagination pager=pager/></div>
                </div>
            </form>
        </div>
    </div>
  </section>
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script>
  jQuery(function($) {
    $(".select2").select2();
  })
</script>
</@main.footer>