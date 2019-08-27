<#-----author:JT------->
<#-----date:2017-12-28------->
<@main.header title="论坛管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li>版主管理</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/qcode/forumtopic/belonged.html" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="belonged">版块</label>
                                        <select id="blockName" name="blockName" val="${(RequestParameters
                                        .blockName)!}" class="form-control select2" style="width: 100%;">
                                            <option value="">全部</option>
                                            <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                                <#list pager.entityList as entity>
                                                    <option value="${entity.blockname}">${entity.blockname}</option>
                                                </#list>
                                            </#if>

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
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <th>版块名称</th>
                                    <th>创建时间</th>
                                    <th>是否开启审核</th><#assign isApproval={'1':'开启','0':'未开启'}>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td title="${(entity.blockname)!}">${(entity.blockname)!}</td>
                                            <td title="${(entity.createtime)!}">${(entity.createtime)!}</td>
                                            <td title="${entity.isapproval}">${(isApproval[''+entity.isapproval])!}</td>
                                            <td>
                                                <a data-toggle="modal" data-target="#myModal" onclick="checkUser('${entity.id}')">
                                                    设置版主
                                                </a>
                                                <a href="${base}/qcode/forumtopic/viewModerator.html?belonged=${entity.id}">
                                                    查看版主
                                                </a>
                                                <#if entity.isapproval == "0">
                                                <a href="javascript:void(0)" onclick="updStatus('${entity.id}',1)">
                                                        开启
                                                </a>
                                                <#else >
                                                    <a href="javascript:void(0)" onclick="updStatus('${entity.id}',0)">
                                                        关闭
                                                    </a>
                                                </#if>
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
                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                            <div class="modal-dialog" style="width:80%;top:10%">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            选择用户
                                        </h4>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        <button type="button" class="btn btn-primary">
                                            保存
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
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

    function updStatus(id,status) {
        $.ajax({
            type:'post',
            traditional :true,
            url:'${base}/qcode/forumtopic/updateApproval.json',
            data:{
                id:id,
                isApproval:status
            },
            success:function(data){
                switch(data.code){
                    case 401:
                        var n = noty({
                            text        : data.message,
                            type        : 'error',
                            dismissQueue: true,
                            layout      : 'topCenter',
                            theme       : 'relax',
                            timeout		: 1500,
                            callback: {     // 设置回调函数
                                afterClose: function() {
                                    window.location.href = '${base }/qcode/forumtopic/belonged.html'
                                }
                            }
                        });
                        break;
                    default:
                        if (data.success){
                            var n = noty({
                                text        : data.message,
                                type        : 'success',
                                dismissQueue: true,
                                layout      : 'topCenter',
                                theme       : 'relax',
                                timeout		: 1500,
                                callback: {     // 设置回调函数
                                    afterClose: function() {
                                        window.location.href = '${base }/qcode/forumtopic/belonged.html'
                                    }
                                }
                            });
                        }else{
                            var n = noty({
                                text        : data.message,
                                type        : 'error',
                                dismissQueue: true,
                                layout      : 'topCenter',
                                theme       : 'relax',
                                timeout		: 1500
                            });
                        }
                }
            },
            error:function(data){
                alert('ajax错误');
            }
        });
    }


    function checkUser(flag) {
        $.ajax({
            url:"${base }/qcode/forumtopic/getModerator.html",
            data:{
                belonged:flag,
                start:$("#startId").val(),
                email:$("#_email").val()

            },
            dataType:'html',
            type:'post',
            success:function(data) {
                if(data.success != false) {
                    $(".modal-content").empty();
                    $(".modal-content").html(data);
                }
            }
        })
    }
</script>
</@main.footer>
