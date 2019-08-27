<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推送管理">
<#--javascript include here-->
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/appPush/index.html">推送管理</a></li>
            <li class="active">查看</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form">
                    <div class="box box-primary">
                        <div class="box-body">
                            <#if entity?exists>
                                <input type="hidden" id="id" name="id" value="${(entity.id)!}"/>
                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right">
                                        标题 </label>
                                    <div class="col-md-6">
                                        <input type="text" name="title" id="title" value="${(entity.title)!}" class="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right">
                                        内容 </label>
                                    <div class="col-md-6">
                                        <textarea name="content" id="content" class="form-control">${(entity.content)!}</textarea>
                                    </div>
                                </div>

                            <#else>
                                <div role="alert" class="alert alert-danger ">
                                    <strong>记录不存在</strong>
                                </div>
                            </#if>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-md-5 col-md-offset-3">
                                        <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                        <a class="btn btn-sm btn-primary" href="${base }/appPush/index.html">返回</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
    </#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/appPush.js"></script>
<script type="text/javascript">

    jQuery(function($) {
        $(".select2").select2();
        $("#myFormId").validate(saveAppPushConfig);
        $(".btn-save").click(function(){
            var formData = new FormData();
            formData.append('content',$("#content").val());
            formData.append('title',$("#title").val());
            if($("#myFormId").validateForm(saveAppPushConfig)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    processData: false,
                    contentType: false,
                    url:'${base}/appPush/updAppPush.json',
                    data:formData,
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
                                            window.location.href = '${base }/appPush/index.html'
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
                                                window.location.href = '${base }/appPush/index.html'
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
        });
    });



</script>
</@main.footer>
