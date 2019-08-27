<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="虚拟机申请管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>虚拟机申请管理</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/qcodeApply/index.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="_name">账户名</label>
                                        <input type="text" id="userName" name="userName"
                                               value="${(RequestParameters.userName)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="_name">账户邮箱</label>
                                        <input type="text" id="useremail" name="userEmail"
                                               value="${(RequestParameters.userEmail)!}" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-offset-5 col-md-7">
                                <button class="btn btn-xs btn-primary submitForm">查询</button>&nbsp;&nbsp;&nbsp;<button
                                    class="btn btn-xs btn-primary clearForm">重置
                            </button>
                            </div>
                        </div>
                    </div>
                    <div class="box">
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <th class="hide">userId</th>
                                    <th>账户名</th>
                                    <th>账户邮箱</th>
                                    <th>姓名</th>
                                    <th>电话</th>
                                    <th>邮箱</th>
                                    <th>虚拟机</th>
                                    <th>目的</th>
                                    <th>申请时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td class="pk hide" id="userId" title="${(entity.userid)!}">${(entity
                                            .userid)!}</td>
                                            <td title="${(entity.userName)!}">${(entity.username)!}</td>
                                            <td title="${(entity.useremail)!}">${(entity.useremail)!}</td>
                                            <td title="${(entity.name)!}">${(entity.name)!}</td>
                                            <td title="${(entity.phone)!}">${(entity.phone)!}</td>
                                            <td title="${(entity.email)!}">${(entity.email)!}</td>
                                            <#if entity.vmtype == '1'>
                                                <td>56位</td>
                                            </#if>
                                            <#if entity.vmtype == '2'>
                                                <td>64位</td>
                                            </#if>
                                            <#if entity.vmtype == '3'>
                                                <td>42位</td>
                                            </#if>
                                            <td title="${(entity.purpose)!}">${(entity.purpose)!}</td>
                                            <td title="${(entity.applytime?string('yyyy-MM-dd HH:mm:ss'))!}">${
(entity.applytime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td>
                                                <#if entity.applystatus == '1'>
                                                    <a href="javascript:void(0)" onclick="return upd
                                                            ('${base}/qcodeApply/audit.json',{id:'${(entity.id)!}',
                                                            applyStatus:'2'});">审核通过</a>
                                                    <a href="javascript:void(0)"
                                                       onclick="return upd('${base}/qcodeApply/audit.json',{id:'${(entity.id)!}',
                                                               applyStatus:'3'});">审核不通过</a>
                                                </#if>
                                                <@shiro.hasAnyRoles name="ADMIN,qcodeApply:detail">
                                                    <a href="${base}/qcodeApply/applyRecord.html?userId=${(entity
                                                    .userid)
                                                    !}">申请记录</a>
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
    jQuery(function ($) {
        $(".select2").select2();
    })
</script>
</@main.footer>
