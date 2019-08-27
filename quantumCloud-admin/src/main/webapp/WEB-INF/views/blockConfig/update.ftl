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
            <li class="active">修改</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form" >
                    <input type="hidden" id="blockId" name="blockId" value="${(entity.blockId)!}">
                    <div class="box box-primary">
                        <div class="box-body">
                            <@main.warning/>
                            <div class="form-group">
                                <label for="name" class="col-md-3 control-label no-padding-right"> 名称 </label>
                                <div class="col-md-6">
                                    <input type="text" id="name" name="name" value="${(entity.name)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-name" ></font><span id="errormsg-name" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="brief" class="col-md-3 control-label no-padding-right"> 简介</label>
                                <div class="col-md-6">
                                    <textarea id="brief" name="brief" ref="brief" class="form-control">${(entity.brief)!}</textarea>
                                </div>
                                <div class="col-md-3"><font id="require-brief" ></font><span id="errormsg-brief" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="cataLog" class="col-md-3 control-label no-padding-right"> 目录 </label>
                                <div class="col-md-6">
                                    <input type="text" id="cataLog" name="cataLog" value="${(entity.cataLog)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-cataLog" ></font><span id="errormsg-cataLog" class="error"></span></div>
                            </div>
                            <div class="form-group file">
                                <label for="img" class="col-md-3 control-label no-padding-right"> 版块图片 </label>
                                <div class="col-md-6">
                                    <img style="max-width: 152px;" src="${entity.img}" alt="" onclick="$('#img').click()" id="pic">
                                    <input type="file" id="img" name="img" ref="img" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-img" ></font><span id="errormsg-img" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="type" class="col-md-3 control-label no-padding-right"> 是否使用外部链接 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="type" id="type" onchange="inputUrl(this)">
                                        <option value="0">否</option>
                                        <option value="1">是</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-type"></font><span id="errormsg-type" class="error"></span></div>
                            </div>
                            <div class="form-group" hidden>
                                <label for="url" class="col-md-3 control-label no-padding-right"> url </label>
                                <div class="col-md-6">
                                    <input type="text" id="url" name="url" value="${(entity.url)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-title" ></font><span id="errormsg-title" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-sm-5 col-xs-offset-3">
                                        <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                        <a class="btn btn-sm btn-primary" href="${base }/blockConfig/index.html">返回</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
    </section>
    </#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script charset="utf-8" src="${base}/assets/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/plugins/code/prettify.js"></script>
<script type="text/javascript" src="${base}/assets/views/BlockConfig/add.js"></script>
<script type="text/javascript" src="${validateJS}/blockConfig.js"></script>
<script type="text/javascript">

    jQuery(function($) {
        $(".select2").select2();
        $("#myFormId").validate(saveBlockConfig);
        $(".btn-save").click(function(){
            var img = $('#img')[0].files[0];
            if(img) {
                updloadImg();
            }
            if($("#myFormId").validateForm(saveBlockConfig)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/blockConfig/updBlock.json',
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
                                            window.location.href = '${base }/blockConfig/index.html'
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
                                                window.location.href = '${base }/blockConfig/index.html'
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


    function uploadpic(obj) {
        var docObj = document.getElementById("file");
        var imgObjPreview = document.getElementById("pic");
        if(docObj.files[0].size > 5242880) {
            alert("图片大小超出5兆");
            return;
        }

        var AllImgExt=".jpg|.jpeg|.gif|.bmp|.png|";
        var extName = docObj.files[0].name.substring(docObj.files[0].name.lastIndexOf(".")).toLowerCase();

        if(AllImgExt.indexOf(extName+"|")==-1)
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(ErrMsg);
            return false;
        }

        if (docObj.files && docObj.files[0]) {
            //火狐下，直接设img属性
            //imgObjPreview.src = docObj.files[0].getAsDataURL();
            //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
            imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
        } else {
            //IE下，使用滤镜
            docObj.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag");
            //必须设置初始大小
            localImagId.style.width = "250px";
            localImagId.style.height = "200px";
            //图片异常的捕捉，防止用户修改后缀来伪造图片
            try {
                localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters
                        .item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
            } catch (e) {
                alert("您上传的图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }

        return true;


    }

    function updloadImg() {
        var formData = new FormData();
        formData.append('multipartFile', $('#file')[0].files[0]?$('#file')[0].files[0]:"");
        $.ajax({
            url:"${base}/blockConfig/uploadImg.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            async:false,
            processData: false,
            contentType: false,
            success:function(data) {
                var path = data.obj;
                $("#img").val(path);
            },
        })
    }

    function inputUrl(obj) {
        if(obj.value == 1) {
            $("#isHide").show();
        }else {
            $("#isHide").hide();
        }
    }

</script>
</@main.footer>
