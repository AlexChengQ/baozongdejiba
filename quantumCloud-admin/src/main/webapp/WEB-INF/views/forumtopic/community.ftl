<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="论坛管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>论坛管理</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/qcode/forumtopic/community.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="userName">用户名</label>
                                        <input type="text" id="userName" name="userName" value="${(RequestParameters
                                        .userName)!}" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="title">主题</label>
                                        <input type="text" id="title" name="title" value="${(RequestParameters.title)!}"
                                               class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="applyStatus">审核状态</label>
                                        <select id="applyStatus" name="applyStatus" val="${(RequestParameters
                                        .applyStatus)!}" class="form-control select2" style="width: 100%;">
                                            <option value="">全部</option>
                                            <option value="0">未审核</option>
                                            <option value="1">已审核</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="noApplyCount">是否有需要审核的评论</label>
                                        <select id="noApplyCount" name="noApplyCount" val="${(RequestParameters
                                        .noApplyCount)!}" class="form-control select2" style="width: 100%;">
                                            <option value="">全部</option>
                                            <option value="0">没有</option>
                                            <option value="1">有</option>
                                        </select>
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
                                <a class="btn btn-sm btn-primary" href="javascript:;" onclick="replyAuditAll('2')" style="border-radius: 5px;margin-right: 5px">批量删除</a>
                                <a class="btn btn-sm btn-primary" href="javascript:;" onclick="replyAuditAll('1')" style="border-radius: 5px;margin-right: 5px">批量审核</a>
                            </div><div class="btn-group">

                        </div>
                        </div>
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <th style="text-align: center;" class="col-md-1"><input id="selectAll" name="checkboxs"
                                                                           type="checkbox" onchange="selectAlls(this)"/>
                                    </th>
                                    <th>用户名</th>
                                    <th>主题</th>
                                    <th>发帖时间</th>
                                    <th>审核状态</th><#assign applyStatuss={'1':'已审核','0':'未审核'}>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td style="text-align: center;"><input id="item_${entity.id}" name="checkbox" type="checkbox" value="${entity.id}"
                                                                                   onclick="selectcheck(this)"
                                                                                   onchange="selectcheck(this)"/></td>
                                            <td title="${(entity.username)!}">${(entity.username)!}</td>
                                            <td title="${(entity.title)!}">${(entity.title)!}</td>
                                            <td title="${(entity.addtime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity
                                            .addtime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td >${(applyStatuss[''+entity.applystatus])!}</td>
                                            <td>
                                                <a href="${base}/qcode/forumtopic/forumtopicdetail.html?id=${(entity
                                                .id)!}">
                                                    详情
                                                </a>
                                            <#if entity.noapplycount !=  0 >
                                                <a href="${base}/qcode/forumtopic/replyList.html?forumTopicId=${(entity.id)!}">
                                                    回复列表
                                                </a>
                                            </#if>
                                                <a href="javaScript:;" onclick="setTop('${entity.id}')">置顶</a>
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

    function setTop(forumTopicId) {
        Dialog.confirm({message: "确定置顶吗？"}).on(function (callback) {
            if (callback) {
                $.ajax({
                    type: 'post',
                    url: "${base}/qcode/forumtopic/setTop.json",
                    data: {
                        "forumTopicId":forumTopicId
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
