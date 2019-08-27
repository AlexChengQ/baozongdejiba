<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="报名人员">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>报名人员</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/matchSignUp/index.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="userName">名称</label>
                                        <input type="text" id="userName" name="userName" value="${(RequestParameters
                                        .userName)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="tel">电话</label>
                                        <input type="text" id="tel" name="tel" value="${(RequestParameters
                                        .tel)!}" class="form-control"/>
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
                    <#--<div class="box-header with-border">-->
                    <#--<div class="btn-group">-->
                    <#--&lt;#&ndash;<a class="btn btn-xs btn-primary" onclick="return onAction({url:'${base}/SysRole/add.html',title:'新增',callback:refreshList})">新增</a>&ndash;&gt;-->
                    <#--<a class="btn btn-sm btn-primary" href="${base}/examConfig/add.html">新增</a>-->
                    <#--</div>-->
                    <#--</div>-->
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <th>名称</th>
                                    <th>电话</th>
                                    <th>年龄</th>
                                    <th>行业</th>
                                    <th>学历</th>
                                    <th>性别</th><#assign sexs={'0':'男','1':'女'}>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="questionid" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td title="${(entity.userName)!}">${(entity.userName)!}</td>
                                            <td title="${(entity.tel)!}">${(entity.tel)!}</td>
                                            <td title="${(entity.age)!}">${(entity.age)!}</td>
                                            <td title="${(entity.industry)!}">${(entity.industry)!}</td>
                                            <td title="${(entity.education)!}">${(entity.education)!}</td>
                                            <td title="${(sexs[''+entity.sex])!}">${(sexs[''+entity.sex])!}</td>
                                        </tr>
                                        </#list>
                                    <#else>
                                    <tr>
                                        <td colspan="10" class="error center">无记录</td>
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
