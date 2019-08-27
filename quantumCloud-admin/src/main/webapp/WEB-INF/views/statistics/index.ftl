<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="云平台管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>统计信息</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                    <div class="box">
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th>用户数</th>
                                    <th>任务数</th>
                                    <th>获取时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if ((statisticsCount)?exists)>
                                        <tr>
                                            <td title="${(statisticsCount.userCount)!}">${(statisticsCount.userCount)!}</td>
                                            <td title="${(statisticsCount.taskCount)!}">${(statisticsCount.taskCount)!}</td>
                                            <td title="${(statisticsCount.obtainDate?string('yyyy-MM-dd HH:mm:ss'))!}">${(statisticsCount.obtainDate?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td>
                                                <a href="${base}/statistics/statisticsCount.html">
                                                    刷新
                                                </a>
                                            </td>
                                        </tr>
                                    <#else>
                                    <tr>
                                        <td colspan="10" class="error center">无记录</td>
                                    </tr>
                                    </#if>
                                </tbody>
                            </table>
                        </div>
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
