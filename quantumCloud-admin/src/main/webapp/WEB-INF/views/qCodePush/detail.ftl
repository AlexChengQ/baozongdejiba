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
            <li><a href="${base }/QcodeMessage/index.html">推送管理</a></li>
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
                                        主题 </label>
                                    <div class="col-md-6">
                                        <input type="text" name="title" value="${(entity.title)!}" class="form-control"
                                               disabled/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right">
                                        内容 </label>
                                    <div class="col-md-6">
                                        <textarea name="content" class="form-control"
                                                  disabled>${(entity.content)!}</textarea>
                                    </div>
                                </div>

                            <#--<div class="form-group">
                               <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
                               <div class="col-md-6">
                                   <input name="createTime" type="text" value="${(entity.createTime)!}"  class="form-control" disabled/>
                                </div>
                            </div>-->
                                <div class="form-group isShow">
                                    <label for="isShow" class="col-md-3 control-label no-padding-right">
                                        是否发送给所有人</label>
                                    <div class="col-md-6">
                                        <select id="isShow" name="isShow" value="" class="form-control select2"
                                                onchange="isShows()">
                                            <option value="1">否</option>
                                            <option value="0">是</option>
                                        </select>
                                    </div>

                                </div>
                                <div class="form-group email">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right">
                                        自定义邮箱</label>
                                    <div class="col-md-6">
                                        <input type="text" name="email" value="" class="form-control"
                                               placeholder="多个邮箱以英文逗号分隔"/>
                                    </div>
                                    <div class="col-md-3"><font id="require-email"></font><span id="errormsg-email"
                                                                                                class="error"></span>
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
                                        <a class="btn btn-sm btn-primary" href="javascript:;" onclick="toSend()">发送</a>
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

    $(function() {
        var content = "${entity.content}";
        var charAt = content.indexOf(".")+1;
        var data = {};
        if(content.substring(charAt,content.length) == "html") {
            $('.email').hide();
            $('.isShow').hide();
        }
    })

    function isShows() {
        var isShow = $('#isShow').val();
        if (isShow == 0) {
            $('.email').hide()
        } else {
            $('.email').show()
        }

    }


    function toSend() {
        var id = $('input[name="id"]').val();
        var email = $('input[name="email"]').val();
        var isShow = $('#isShow').val();
        var url = "";
        var content = "${entity.content}";
        var charAt = content.indexOf(".")+1;
        var data = {};
        if(content.substring(charAt,content.length) == "html") {
            url = "QcodePush/sendHtmlMail.json";
            data = {"title":"${entity.title}","content":content,"id":id};
            isShow = 0;
        }else {
            url = "QcodePush/sendPushMail.json";
            data = {"id":id,"email":email,"isShow":isShow};
            isShow = 1;
        }


        if(isShow == 1 && !email){
            var n = noty({
                text: '请输入邮箱',
                type: 'error',
                dismissQueue: true,
                layout: 'topCenter',
                theme: 'relax',
                timeout: 1500
            });
            return false;
        }
            Dialog.confirm({message: "确定要发送吗？"}).on(function (callback) {
                if (callback) {
                    $.post(ctx + url,
                       data
                    , function (data) {
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
                                        window.location.href = '${base }/QcodePush/index.html'
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
                    })
                }
            })

        <#--window.location.href = '${base }/QcodePush/index.html?id='+$("#id").val();-->
    }
</script>
</@main.footer>
