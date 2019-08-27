<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="系统管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>字典管理</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/Qcode/dic/dicIndex.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="dicName">字典值</label>
                                        <input type="text" id="dicName" name="dicName" value="${(RequestParameters
                                        .dicName)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="desc">字典描述</label>
                                        <input type="text" id="dicDesc" name="dicDesc" value="${(RequestParameters.dicDesc)!}" class="form-control"/>
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
                                    <a class="btn btn-sm btn-primary" href="${base}/Qcode/dic/addDicIndex.html">新增</a>
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
                                    <th>字典描述</th>
                                    <th>字典值</th>
                                    <th>创建时间</th>
                                    <th>创建人</th>
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
                                            <td title="${(entity.dicdesc)!}">${(entity.dicdesc)!}</td>
                                            <td title="${(entity.dicname)!}">${(entity.dicname)!}</td>
                                            <td title="${(entity.addtime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity
                                            .addtime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td title="${(entity.username)!}">${(entity.username)!}</td>
                                            <td>
                                                <a href="${base}/Qcode/dic/getDicContentById.html?dicId=${(entity
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

    //全选
    function selectAlls(obj) {
        $(obj).closest('tr').toggleClass('active');
        if ($(obj).val() == "on") {

            $('tr').addClass('active')
            $(obj).closest('tr').removeClass('active');
            $("input[type='checkbox']").prop("checked", true);//全选
            $(obj).val("off");
        } else {

            $('tr').removeClass('active')
            $("input[type='checkbox']").removeAttr("checked");//取消全选
            $(obj).val("on");
        }
    }

    //单选
    function selectcheck(obj) {
        if ($(obj).is(":checked")) {
            $(obj).closest('tr').addClass('active');
            $("#selectAll").prop("checked", true);
            $("#selectAll").val("off");
            $("input[id^='item_']").each(function (index, item) {
                var c = $(item).is(":checked");
                if (!c) {
                    $("#selectAll").removeAttr("checked");
                    $("#selectAll").val("on");
                    return;
                }
            });
        } else {
            $(obj).closest('tr').removeClass('active');
            $(obj).removeAttr("checked");
            $("#selectAll").removeAttr("checked");
            $("#selectAll").val("on");
        }
    }

    <#--批量审核删除-->

    function replyAuditAll(flag) {
        var ids = new Array();
        var parm = {};
        var url = null;
        var text = null;
        var message = null;
        //判断是否选中
        $("input[name='checkbox']:checked").each(function () {
            ids.push($(this).val());
        });

        if(flag == '1') {//审核
            text = "请选择要审核的数据";
            message = "确定要审核吗？";
            url = "${base}/qcode/forumtopic/updTopicBatchAudit.json";
        }else {//删除
            text = "请选择要删除的数据";
            message = "确定要删除吗？";
            url = "${base}/qcode/forumtopic/delTopicBatchAudit.json";
        }

        if (ids.length == 0) {
            var n = noty({
                text: text,
                type: 'error',
                dismissQueue: true,
                layout: 'topCenter',
                theme: 'relax',
                timeout: 1500
            });
            return false;
        }

        Dialog.confirm({message: message}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: url,
                    data: {
                        "ids":ids.join(",")
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


    //删除字典
    function delDic(id) {
        Dialog.confirm({message: "确定删除吗？"}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: "${base}/Qcode/dic/delDic.json",
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
