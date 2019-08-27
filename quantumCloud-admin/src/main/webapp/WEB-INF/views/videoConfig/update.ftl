<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="版块管理">
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/videoConfig/index.html">版块管理</a></li>
            <li class="active">增加</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form" >
                    <input type="hidden" id="catalog" name="catalog">
                    <input type="hidden" id="img" name="img" value="${(entity.img)!}"/>
                    <input type="hidden" id="lectureurl" name="lectureurl" value="${(entity.lectureurl)!}"/>
                    <input type="hidden" id="url" name="url">
                    <#--<input type="hidden" id="video_url" name="video_url" value="http://video.qpanda.cn:65520/">-->
                    <input type="hidden" id="vid" name="vid" value="${(entity.vid)!}">
                    <div class="box box-primary">
                        <div class="box-body">
                            <@main.warning/>
                            <div class="form-group">
                                <label for="title" class="col-md-3 control-label no-padding-right"> 视频名称 </label>
                                <div class="col-md-6">
                                    <input type="text" id="title" name="title" value="${(entity.title)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-title" ></font><span id="errormsg-title" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="brief" class="col-md-3 control-label no-padding-right"> 视频简介</label>
                                <div class="col-md-6">
                                    <textarea id="brief" name="brief" ref="brief" class="form-control">${(entity.brief)!}</textarea>
                                </div>
                                <div class="col-md-3"><font id="require-brief" ></font><span id="errormsg-brief" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="cataLog" class="col-md-3 control-label no-padding-right"> 视频时长 </label>
                                <div class="col-md-6">
                                    <input type="text" id="video_time" name="video_time" value="${(entity.video_time)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-video_time" ></font><span id="errormsg-video_time" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="free" class="col-md-3 control-label no-padding-right"> 所属板块 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="block" id="block" onchange="getCatalog()" disabled="true">
                                        <#if (blockList)?exists && ((blockList)?size != 0)>
                                            <#list blockList as block>
                                                <option value="${block.blockid}" data-value="${block.catalog}">${block.name}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-block"></font><span id="errormsg-block" class="error"></span></div>
                            </div>

                            <div class="form-group file">
                                <label for="pic" class="col-md-3 control-label no-padding-right"> 视频图片 </label>
                                <div class="col-md-6">
                                    <img style="max-width: 152px;" src="${entity.img}" alt="" onclick="$('#img').click()" id="pic">
                                    <input type="file" id="file" name="file" ref="file" onchange="uploadpic(this)" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
                            </div>

                            <div class="form-group file">
                                <label for="content" class="col-md-3 control-label no-padding-right"> 上传高清视频 </label>
                                <div class="col-md-6">
                                <#if (entity.url)??>
                                    <video width="320" height="240" controls="controls">
                                        <source src="${entity.videoUrl}360p/${entity.url}" type="video/mp4">
                                    </video>
                                </#if>
                                    <div id="thelist1" class="uploader-list"></div>
                                    <div id="picker1">选择文件</div>
                                    <div id="ctlBtn1" class="btn btn-default" data-value="1">开始上传</div>
                                    <div class="progress">
                                        <div id="progress1" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                                            <span class="sr-only">60% Complete</span>
                                        </div>
                                    </div>
                                    <#--<input type="file" id="video360pFile" name="video360pFile" ref="video360pFile" onchange="uploadVideo(this,'1')" class="form-control"/>-->
                                </div>
                                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
                            </div>

                            <div class="form-group file">
                                <label for="content" class="col-md-3 control-label no-padding-right"> 上传超清视频 </label>
                                <div class="col-md-6">
                                    <#if (entity.url)??>
                                        <video width="320" height="240" controls="controls">
                                            <source src="${entity.videoUrl}${entity.url}" type="video/mp4">
                                        </video>
                                    </#if>
                                    <!--用来存放文件信息-->
                                    <div id="thelist" class="uploader-list"></div>
                                    <div id="picker">选择文件</div>
                                    <div id="ctlBtn" class="btn btn-default" data-value="2">开始上传</div>
                                    <div class="progress">
                                        <div id="progress" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
                                            <span class="sr-only">60% Complete</span>
                                        </div>
                                    </div>
                                    <#--<input type="file" id="videoFile" name="videoFile" ref="videoFile" onchange="uploadVideo(this,'2')" class="form-control"/>-->
                                </div>
                                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
                            </div>

                            <div class="form-group file">
                                <label for="lectureUrl" class="col-md-3 control-label no-padding-right"> 上传讲义 </label>
                                <div class="col-md-6">
                                    <#if (entity.lectureurl)??>
                                        <a href="${base}${entity.lectureurl}">点击预览讲义</a>
                                    </#if>
                                    <input type="file" ref="lectureurlFile" name="lectureurlFile" id="lectureurlFile" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-lectureUrl" ></font><span id="errormsg-lectureUrl" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <label for="free" class="col-md-3 control-label no-padding-right"> 是否免费 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="free" id="free">
                                        <option value="0">是</option>
                                        <option value="1">否</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-free"></font><span id="errormsg-free" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="toplevel" class="col-md-3 control-label no-padding-right"> 是否置顶 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="toplevel" id="toplevel">
                                        <option value="0">否</option>
                                        <option value="1">是</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-toplevel"></font><span id="errormsg-toplevel" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="defaultUrl" class="col-md-3 control-label no-padding-right"> 是否选择默认路径 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="defaultUrl" id="defaultUrl" onchange="changeUrl()">
                                        <option value="1">是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-defaultUrl"></font><span id="errormsg-defaultUrl" class="error"></span></div>
                            </div>
                            <div class="form-group" hidden id="hideUrl">
                                <label for="video_url" class="col-md-3 control-label no-padding-right"> video_url </label>
                                <div class="col-md-6">
                                    <input type="text" id="video_url" name="video_url" value="${(entity.videoUrl)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-video_url" ></font><span id="errormsg-video_url" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-sm-5 col-xs-offset-3">
                                        <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                        <a class="btn btn-sm btn-primary" href="${base }/videoConfig/index.html">返回</a>
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
<script type="text/javascript" src="${base}/assets/views/VideoConfig/add.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/assets/webuploader-0.1.5/webuploader.css">

<!--引入JS-->
<script type="text/javascript" src="${base}/assets/webuploader-0.1.5/webuploader.js"></script>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/videoConfig.js"></script>
<script type="text/javascript">

    var uploader = WebUploader.create({

        // swf文件路径
        swf:  '${base}/assets/webuploader-0.1.5/Uploader.swf',

        // 文件接收服务端。
        server: '${base}/videoConfig/uploadVideo.json',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker',

        fileNumLimit: 1,
        chunked:true,
        chunkSize:100*1024*1024,
        threads:3,//上传并发数。允许同时最大上传进程数。
        //不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false
    });
    $upload = $("#ctlBtn"),

    $upload.on('click', function() {
        var obj = new Object();
        obj.videoType = $upload.attr("data-value");
        obj.vid = $("#vid").val();
        obj.guid = Math.random();
        uploader.options.formData = obj;
        $(".btn-save").attr("disabled",true);
        uploader.upload();

    });
    uploader.on( 'beforeFileQueued', function( file ) {
        uploader.reset();
    })

    // 当有文件被添加进队列的时候
    uploader.on( 'fileQueued', function( file ) {
        $("#thelist").empty();
        //判断文件格式是否正确
        var type = file.ext;
        if(type!="mp4"){
            uploader.removeFile(file);//删除
            layer.msg("文件格式不正确");
            return;
        }

        getVideoTime(file);

        $("#thelist").append( '<div id="' + file.id + '" class="item">' +
                '<h4 class="info">' + file.name + '</h4>' +
                '<p class="state">等待上传...</p>' +
                '</div>' );
    });

    var uploadTime = null;

    uploader.on('uploadSuccess', function(file) {
        $('#' + file.id).find('p.state').text('已上传');
        var guid = uploader.options.formData.guid;
        var chunks = Math.ceil(file.size/(100*1024*1024));
        $.post("${base}/videoConfig/uploadSuccess.json", { "guid": guid,chunks:chunks,fileName:file.name,catalog: $("#block").find("option:selected").attr("data-value"),videoType:$upload.attr("data-value"),vid:$("#vid").val()},
                function(data){
                    var path = data.obj;
                    if($upload.attr("data-value") == "1") {
                        firstpload = path;
                    }else {
                        sencondUpload = path;
                    }

                    lastType = $upload.attr("data-value");
                    lastPath = path;

                    $("#url").val(path);

                    uploadTime=setInterval(function () {
                        checkVideoHasUpload($("#vid").val())
                    },5000)
                });
    });


    uploader.on('uploadProgress', function(file,percentage) {
        $("#progress").css("width",parseInt(percentage*100)+"%");
    });

    // 所有文件上传成功后调用
    uploader.on('uploadFinished', function () {
        //清空队列
        uploader.reset();
    });


    var uploader1 = WebUploader.create({

        // swf文件路径
        swf:  '${base}/assets/webuploader-0.1.5/Uploader.swf',

        // 文件接收服务端。
        server: '${base}/videoConfig/uploadVideo.json',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker1',

        fileNumLimit: 1,
        chunked:true,
        chunkSize:100*1024*1024,
        threads:3,//上传并发数。允许同时最大上传进程数。
        //不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false
    });
    $upload1 = $("#ctlBtn1"),

    $upload1.on('click', function() {
        var obj = new Object();
        obj.videoType = $upload1.attr("data-value");
        obj.catalog = $("#catalog").val();
        obj.vid = $("#vid").val();
        obj.guid = Math.random();
        uploader1.options.formData = obj;
        $(".btn-save").attr("disabled",true);
        uploader1.upload();

    });

    uploader1.on( 'beforeFileQueued', function( file ) {
        uploader1.reset();
    })

    // 当有文件被添加进队列的时候
    uploader1.on( 'fileQueued', function( file ) {
        $("#thelist1").empty();

        //判断文件格式是否正确
        var type = file.ext;
        if(type!="mp4"){
            uploader1.removeFile(file);//删除
            layer.msg("文件格式不正确");
            return;
        }

        getVideoTime(file);

        $("#thelist1").append( '<div id="' + file.id + '" class="item">' +
                '<h4 class="info">' + file.name + '</h4>' +
                '<p class="state">等待上传...</p>' +
                '</div>' );
    });


    uploader1.on('uploadSuccess', function(file) {
        $('#' + file.id).find('p.state').text('已上传');
        var guid = uploader1.options.formData.guid;
        var chunks = Math.ceil(file.size/(100*1024*1024));
        $.post("${base}/videoConfig/uploadSuccess.json", { "guid": guid,chunks:chunks,fileName:file.name,catalog:$("#block").find("option:selected").attr("data-value"),videoType:$upload1.attr("data-value"),vid:$("#vid").val()},
                function(data){
                    var path = data.obj;
                    if($upload1.attr("data-value") == "1") {
                        firstpload = path;
                    }else {
                        sencondUpload = path;
                    }

                    lastType = $upload1.attr("data-value");
                    lastPath = path;

                    $("#url").val(path);

                    uploadTime=setInterval(function () {
                        checkVideoHasUpload($("#vid").val())
                    },5000)


                });
    });


    uploader1.on('uploadProgress', function(file,percentage) {
        $("#progress1").css("width",parseInt(percentage*100)+"%");
    });

    // 所有文件上传成功后调用
    uploader1.on('uploadFinished', function () {
        //清空队列
        uploader1.reset();
    });


    function getVideoTime(obj) {
        //获取视频时长
        var url = URL.createObjectURL(obj.source.source);
        //经测试，发现audio也可获取视频的时长
        var audioElement = new Audio(url);

        var duration;
        audioElement.addEventListener("loadedmetadata", function (_event) {
            duration = audioElement.duration;
            var h = 0;
            var m = 0;
            var s = 0;
            h = Math.floor(duration/3600);
            m = Math.floor((duration - 3600*h)/60);
            s = Math.floor(duration - 3600*h - 60*m);
            if(h >0 && h < 10) {
                h = "0" + h;
            }else if(h == 0) {
                h = "00";
            }

            if(m > 0 && m <10) {
                m = "0" + m;
            }else if(m == 0) {
                m = "00";
            }

            if(s > 0 && s <10) {
                s = "0" + s;
            }else if(s == 0) {
                s = "00";
            }


            $("#video_time").val(h + ":" + m + ":" + s);

        });
    }


    var firstpload;
    var sencondUpload;
    var lastPath;
    var lastType;
    jQuery(function($) {
        $(".select2").select2();
        $("#block").val(${entity.block})
        $("#myFormId").validate(saveVideoConfig);
        $(".btn-save").click(function(){
            var img = $('#file')[0].files[0];
            var lectureurl = $('#lectureurlFile')[0].files[0];
            if(img || lectureurl) {
                updloadImg();
            }

            var flag = true;

            if(firstpload != sencondUpload) {
                var flag = changeVide();
            }



            if($("#myFormId").validateForm(saveVideoConfig)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/videoConfig/updVideo.json',
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
                                            window.location.href = '${base }/videoConfig/index.html'
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
                                                window.location.href = '${base }/videoConfig/index.html'
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


    function uploadVideo(obj,type) {
        $("#catalog").val( $("#block").find("option:selected").attr("data-value"));
        var docObj = "";
        if(document.getElementById("videoFile").files[0] != null) {
             docObj = document.getElementById("videoFile");
        }else {
            docObj = document.getElementById("video360pFile");
        }


        var AllImgExt=".avi|.mp4|.wmv|.3gp|";
        var extName = docObj.files[0].name.substring(docObj.files[0].name.lastIndexOf(".")).toLowerCase();

        if(AllImgExt.indexOf(extName+"|")==-1)
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(ErrMsg);
            obj.value = null;
            return false;
        }

        if(/.*[\u4e00-\u9fa5]+.*$/.test(docObj.files[0].name))
        {
            alert("不能含有汉字！");
            obj.value = null;
            return false;
        }

        updloadSaveVideo(type)
    }

    function updloadSaveVideo(type) {
        var formData = new FormData();
        if(type == "1") {
            formData.append('360pFile', $('#video360pFile')[0].files[0]?$('#video360pFile')[0].files[0]:"");
        }else {
            formData.append('File', $('#videoFile')[0].files[0]?$('#videoFile')[0].files[0]:"");
        }

        formData.append("type",type);

        formData.append("vid",$("#vid").val());

        formData.append("catalog",$("#catalog").val());
        $.ajax({
            url:"${base}/videoConfig/uploadVideo.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            async:false,
            processData: false,
            contentType: false,
            success:function(data) {
                var path = data.obj;
                if(type == "1") {
                    firstpload = path;
                }else {
                    sencondUpload = path;
                }

                lastType = type;
                lastPath = path;

                $("#url").val(path);
            },
        })
    }


    function getCatalog() {
        $("#catalog").val( $("#block").find("option:selected").attr("data-value"));
    }

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
            obj.value = null;
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
        formData.append('imgFile', $('#file')[0].files[0]?$('#file')[0].files[0]:"");
        formData.append('lectureurlFile', $('#lectureurlFile')[0].files[0]?$('#lectureurlFile')[0].files[0]:"");
        $.ajax({
            url:"${base}/videoConfig/uploadImg.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            async:false,
            processData: false,
            contentType: false,
            success:function(data) {
                var img = data.obj.img;
                var lectureurl = data.obj.lectureurl;
                $("#img").val(img);
                $("#lectureurl").val(lectureurl);
            },
        })
    }

    function changeUrl() {
        if($("#defaultUrl").val() == 1) {
            $("#hideUrl").hide();
        }else {
            $("#hideUrl").show();
        }
    }


    function changeVide() {
        $.ajaxSettings.async = false;
        var flag = false;
        $.post("${base}/videoConfig/changeVideo.json",
                {
                    "vid":$("#vid").val(),
                    "catalog":$("#block").find("option:selected").attr("data-value"),
                    "lastType":lastType,
                    "lastPath":lastPath},
                function(result) {
                    flag = result;
                    return flag;
                })
        $.ajaxSettings.async = true;
    }


    function checkVideoHasUpload(vid) {
        $.post("${base}/videoConfig/checkVideoHasComplete.json",{"vid":vid},function (result) {
            if(result) {
                var data = result.obj;
                if(data == 1) {
                    layer.msg("文件上传至服务器成功");
                    $(".btn-save").attr("disabled",false);
                    clearInterval(uploadTime);
                }
            }
        })
    }
</script>
</@main.footer>
