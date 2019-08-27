<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="系统管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>App推送管理</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/appPush/index.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="dicName">标题</label>
                                        <input type="text" id="title" name="title" value="${(RequestParameters
                                        .title)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="desc">内容</label>
                                        <input type="text" id="content" name="content" value="${(RequestParameters.content)!}" class="form-control"/>
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
                        <div class="box-header with-border">
                            <div class="btn-group">
                                <#--<a class="btn btn-xs btn-primary" onclick="return onAction({url:'${base}/SysRole/add.html',title:'新增',callback:refreshList})">新增</a>-->
                                    <a class="btn btn-sm btn-primary" href="${base}/appPush/add.html">新增</a>
                            </div>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <#--<th style="text-align: center;" class="col-md-1"><input id="selectAll" name="checkboxs"-->
                                                                           <#--type="checkbox" onchange="selectAlls(this)"/>-->
                                    <#--</th>-->
                                    <th>推送标题</th>
                                    <th>推送内容</th>
                                    <th>创建时间</th>
                                    <th>是否已推送</th><#assign isPush={'0':'未推送','1':'已推送'}>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <#--<td style="text-align: center;"><input id="item_${entity.id}" name="checkbox" type="checkbox" value="${entity.id}"-->
                                                                                   <#--onclick="selectcheck(this)"-->
                                                                                   <#--onchange="selectcheck(this)"/></td>-->
                                            <td title="${(entity.title)!}">${(entity.title)!}</td>
                                            <td title="${(entity.content)!}">${(entity.content)!}</td>
                                            <td title="${(entity.addTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity
                                            .addTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td title="${(isPush[''+entity.isPush])!}">${(isPush[''+entity.isPush])!}</td>
                                            <td>
                                                <a href="${base}/appPush/update.html?id=${(entity
                                                .id)!}">
                                                    修改
                                                </a>
                                                <a href="javaScript:;" onclick="del('${entity.id}')">删除</a>
                                                <a href="javaScript:;" onclick="push('${entity.id}')">推送</a>
                                            </td>
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


    //删除
    function del(id) {
        Dialog.confirm({message: "确定删除吗？"}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: "${base}/appPush/delPush.json",
                    data: {
                        "id":id
                    },
                    dataType: 'json',
                    traditional: true,
                    success: function (data) {
                        switch (data.code) {
                            case 401:
                                var n = noty({
                                    text: data.message,
                                    type: 'error',
                                    dismissQueue: true,
                                    layout: 'topCenter',
                                    theme: 'relax',
                                    timeout: 1500,
                                    callback: {     // 设置回调函数
                                        afterClose: function () {

                                        }
                                    }
                                });
                                break;
                            default:
                                if (data.success) {
                                    var n = noty({
                                        text: data.message,
                                        type: 'success',
                                        dismissQueue: true,
                                        layout: 'topCenter',
                                        theme: 'relax',
                                        timeout: 1500,
                                        callback: {     // 设置回调函数
                                            afterClose: function () {
                                                $("#searchForm").submit();
                                            }
                                        }
                                    });
                                } else {
                                    var n = noty({
                                        text: data.message,
                                        type: 'error',
                                        dismissQueue: true,
                                        layout: 'topCenter',
                                        theme: 'relax',
                                        timeout: 1500
                                    });
                                }
                        }
                    },
                    error: function (data) {
                        alert('ajax错误');
                    }
                });
            }
        });
    }


    function push(id) {
        Dialog.confirm({message: "确定推送吗？"}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: "${base}/appPush/push.json",
                    data: {
                        "id":id
                    },
                    dataType: 'json',
                    traditional: true,
                    success: function (data) {
                        switch (data.code) {
                            case 401:
                                var n = noty({
                                    text: data.message,
                                    type: 'error',
                                    dismissQueue: true,
                                    layout: 'topCenter',
                                    theme: 'relax',
                                    timeout: 1500,
                                    callback: {     // 设置回调函数
                                        afterClose: function () {

                                        }
                                    }
                                });
                                break;
                            default:
                                if (data.success) {
                                    var n = noty({
                                        text: data.message,
                                        type: 'success',
                                        dismissQueue: true,
                                        layout: 'topCenter',
                                        theme: 'relax',
                                        timeout: 1500,
                                        callback: {     // 设置回调函数
                                            afterClose: function () {
                                                $("#searchForm").submit();
                                            }
                                        }
                                    });
                                } else {
                                    var n = noty({
                                        text: data.message,
                                        type: 'error',
                                        dismissQueue: true,
                                        layout: 'topCenter',
                                        theme: 'relax',
                                        timeout: 1500
                                    });
                                }
                        }
                    },
                    error: function (data) {
                        alert('ajax错误');
                    }
                });
            }
        });
    }
</script>
</@main.footer>
