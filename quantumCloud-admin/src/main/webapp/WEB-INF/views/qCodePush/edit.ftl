<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="留言表">
		
</@main.header>
<@main.body>
<#escape x as x?html>
<section class="content">
    <ol class="breadcrumb">
        <li></li>
        <li><a href="${base }/QcodePush/index.html">推送管理</a></li>
        <li class="active">编辑</li>
    </ol>
    <div class="row">
        <div class="col-md-12">
            <form id="myFormId" method="post"  class="form-horizontal" role="form" >
                <div class="box box-primary">
                    <div class="box-body">
						<@main.warning/>
                        <input type="hidden" name="id" value="${(entity.id)!}"/>
                        <input type="hidden" name="userId" value="${(entity.userId)!}"/>
                        <div class="form-group">
                            <label for="title" class="col-md-3 control-label no-padding-right"> 主题 </label>
                            <div class="col-md-6">
                                <input type="text" id="title" name="title" value="${(entity.title)!}" class="form-control"/>
                            </div>
                            <div class="col-md-3"><font id="require-title" ></font><span id="errormsg-title" class="error"></span></div>
                        </div>
                        <div class="form-group">
                            <label for="content" class="col-md-3 control-label no-padding-right"> 内容 </label>
                            <div class="col-md-6">
                                <textarea id="content" name="content" ref="content" class="form-control">${(entity.content)!}</textarea>
                            </div>
                            <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <div class="col-sm-5 col-xs-offset-3">
                                    <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                    <a class="btn btn-sm btn-primary" href="${base }/QcodePush/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/QcodePush.js"></script>
<script type="text/javascript">

    jQuery(function($) {
        $(".select2").select2();
        $("#myFormId").validate(saveQcodePushConfig);
        $(".btn-save").click(function(){
            if($("#myFormId").validateForm(saveQcodePushConfig)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/QcodePush/update.json',
                    data:$("#myFormId").serialize(),
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
                                            window.location.href = '${base }/QcodePush/index.html'
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
                                                window.location.href = '${base }/QcodePush/index.html'
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
