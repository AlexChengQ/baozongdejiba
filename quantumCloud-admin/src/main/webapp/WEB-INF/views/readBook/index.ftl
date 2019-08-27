<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="云平台管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>推荐阅读</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/readBook/index.html" autocomplete="off">
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
                                    <a class="btn btn-sm btn-primary" href="${base}/readBook/add.html">新增</a>
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
                                    <th>标题</th>
                                    <th>内容</th>
                                    <th>作者</th>
                                    <th>翻译作者</th>
                                    <th>首页图片</th>
                                    <th>出版商</th>
                                    <th>论文提交时间</th>
                                    <th>最初宣布时间</th>
                                    <th>论文地址</th>
                                    <th>类型</th><#assign types={'0':'文章','1':'论文'}>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td title="${(entity.title)!}">${(entity.title)!}</td>
                                            <td title="${(entity.context)!}">${(entity.context)!}</td>
                                            <td title="${(entity.author)!}">${(entity.author)!}</td>
                                            <td title="${(entity.translator)!}">${(entity.translator)!}</td>
                                            <td title="${(entity.image)!}"><img src="${setting['files.contextpath']}${(entity.image)!}" style="width:40px;height:40px;"></td>
                                            <td title="${(entity.publisher)!}">${(entity.publisher)!}</td>
                                            <td title="${(entity.submitted)!}">${(entity.submitted)!}</td>
                                            <td title="${(entity.joriginallyannounced)!}">${(entity.joriginallyannounced)!}</td>
                                            <td title="${(entity.site)!}">${(entity.site)!}</td>
                                            <td title="${(types[''+entity.type])!}">${(types[''+entity.type])!}</td>
                                            <td>
                                                <a href="${base}/readBook/detail.html?id=${(entity
                                                .id)!}">
                                                    详情
                                                </a>
                                                <a href="javaScript:;" onclick="delDic('${entity.id}')">删除</a>
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


    //删除字典
    function delDic(id) {
        Dialog.confirm({message: "确定删除吗？"}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: "${base}/readBook/delReadBook.json",
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
