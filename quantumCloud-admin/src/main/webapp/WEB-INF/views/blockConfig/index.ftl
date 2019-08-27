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
                <form method="post" id="searchForm" action="${base}/blockConfig/index.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="dicName">名称</label>
                                        <input type="text" id="title" name="title" value="${(RequestParameters
                                        .name)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="desc">所属分类</label>
                                        <input type="text" id="content" name="content" value="${(RequestParameters.cataLog)!}" class="form-control"/>
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
                                    <a class="btn btn-sm btn-primary" href="${base}/blockConfig/add.html">新增</a>
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
                                    <th>版块名称</th>
                                    <th>版块简介</th>
                                    <th>所属分类</th>
                                    <th>版块图片</th>
                                    <th>展示方式</th>
                                    <th>url</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="blockId" title="${(entity.blockId)!}">${(entity.blockId)!}</td>
                                            <#--<td style="text-align: center;"><input id="item_${entity.id}" name="checkbox" type="checkbox" value="${entity.id}"-->
                                                                                   <#--onclick="selectcheck(this)"-->
                                                                                   <#--onchange="selectcheck(this)"/></td>-->
                                            <td title="${(entity.name)!}">${(entity.name)!}</td>
                                            <td title="${(entity.brief)!}">${(entity.brief)!}</td>
                                            <td title="${(entity.cataLog)!}">${(entity.cataLog)!}</td>
                                            <td title="${(entity.img)!}">${(entity.img)!}</td>
                                            <td title="${(entity.type)!}">${(entity.type)!}</td>
                                            <td title="${(entity.url)!}">${(entity.url)!}</td>
                                            <td>
                                                <a href="${base}/blockConfig/update.html?blockId=${(entity
                                                .blockId)!}">
                                                    修改
                                                </a>
                                                <a href="javascript:void(0)" onclick="delBlock('${(entity.blockId)!}','${(entity.cataLog)!}')">
                                                    删除
                                                </a>
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

    function delBlock(block,cataLog) {
        Dialog.confirm({message: "确认删除吗？"}).on(function (callback) {
            if (callback) {
                var flag = getVideo(block);
                if(!flag) {
                    var n = noty({
                        text: "此版块下有视频，无法删除！",
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

                    return;
                }

                flag = getExam(block);
                if(!flag) {
                    var n = noty({
                        text: "此版块下有题目，无法删除！",
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

                    return;
                }

                $.ajax({
                    type: 'post',
                    url: "${base}/blockConfig/delBlock.json",
                    data: {
                        "block":block,
                        "cataLog":cataLog
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

    function getVideo(block) {
        var flag = true
        $.ajaxSettings.async = false;
        $.post("${base}/blockConfig/getVideo.json",{"block":block},function(result) {
            if(result.length > 0) {
                flag = false;
            }else {
                flag = true;
            }
        })
        $.ajaxSettings.async = true;
        return flag;
    }

    function getExam(block) {
        var flag = true
        $.ajaxSettings.async = false;
        $.post("${base}/blockConfig/getExam.json",{"block":block},function(result) {
            if(result.length > 0) {
                flag = false;
            }else {
                flag = true;
            }
        })
        $.ajaxSettings.async = true;
        return flag;
    }
</script>
</@main.footer>
