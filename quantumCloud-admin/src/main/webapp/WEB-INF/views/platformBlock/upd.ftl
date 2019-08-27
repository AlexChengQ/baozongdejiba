<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推荐阅读">
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/platformBlock/index.html">论坛版块管理</a></li>
            <li class="active">修改</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form" >
                    <input type="hidden" id="face" name="face">
                    <div class="box box-primary">
                        <div class="box-body">
                            <@main.warning/>
                            <input type="hidden" name="id" value="${(entity.id)!}"/>
                            <div class="form-group">
                                <label for="blockName" class="col-md-3 control-label no-padding-right"> 版块名称 </label>
                                <div class="col-md-6">
                                    <input type="text" id="blockName" name="blockName" value="${(entity.blockName)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-blockName" ></font><span id="errormsg-blockName" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="blockDesc" class="col-md-3 control-label no-padding-right"> 版块描述</label>
                                <div class="col-md-6">
                                    <textarea id="blockDesc" name="blockDesc" ref="blockDesc" class="form-control">${(entity.blockDesc)!}</textarea>
                                </div>
                                <div class="col-md-3"><font id="require-blockDesc" ></font><span id="errormsg-blockDesc" class="error"></span></div>
                            </div>
                            <div class="form-group file">
                                <label for="image" class="col-md-3 control-label no-padding-right"> 首页图标 </label>
                                <div class="col-md-6">
                                    <img style="max-width: 152px;" src="${setting['files.contextpath']}${(entity.face)}" alt="" onclick="$('#img').click()" id="prevImg">
                                    <input type="file" id="pic" name="pic" ref="pic" onchange="uploadpic(this)" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-image" ></font><span id="errormsg-image" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-sm-5 col-xs-offset-3">
                                        <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                        <a class="btn btn-sm btn-primary" href="${base }/platformBlock/index.html">返回</a>
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
<script charset="utf-8" src="${base}/assets/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/plugins/code/prettify.js"></script>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/PlatformBlock.js"></script>
<script type="text/javascript">

    jQuery(function($) {
        $(".select2").select2();
        $("#myFormId").validate(savePlatformBlock);
        $(".btn-save").click(function(){
            updloadImg();
            if($("#myFormId").validateForm(savePlatformBlock)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/platformBlock/updData.json',
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
                                            window.location.href = '${base }/platformBlock/index.html'
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
                                                window.location.href = '${base }/platformBlock/index.html'
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
        var docObj = document.getElementById("pic");
        var imgObjPreview = document.getElementById("prevImg");
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
        formData.append('image', $('#pic')[0].files[0]?$('#pic')[0].files[0]:"");
        $.ajax({
            url:"${base}/platformBlock/uploadImg.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            async:false,
            processData: false,
            contentType: false,
            success:function(data) {
                var img = data.obj;
                $("#face").val(img);
            },
        })
    }



</script>
</@main.footer>
