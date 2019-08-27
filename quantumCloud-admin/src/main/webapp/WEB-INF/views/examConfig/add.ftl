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
            <input type="hidden" id="video_url" name="video_url" value="http://video.qpanda.cn:65520/">
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
                    <select class="form-control" name="block" id="block" onchange="getCatalog()">
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
                    <img style="max-width: 152px;" src="${base}/assets/forImg/Upload.png" alt="" onclick="$('#img').click()" id="pic">
                    <input type="file" id="file" name="file" ref="file" onchange="uploadpic(this)" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
            </div>

            <div class="form-group file">
                <label for="content" class="col-md-3 control-label no-padding-right"> 上传高清视频 </label>
                <div class="col-md-6">
                    <input type="file" id="video360pFile" name="video360pFile" ref="video360pFile" onchange="uploadVideo(this)" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
            </div>

            <div class="form-group file">
                <label for="content" class="col-md-3 control-label no-padding-right"> 上传超清视频 </label>
                <div class="col-md-6">
                    <input type="file" id="videoFile" name="videoFile" ref="videoFile" onchange="uploadVideo(this)" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
            </div>

            <div class="form-group file">
                <label for="lectureUrl" class="col-md-3 control-label no-padding-right"> 上传讲义 </label>
                <div class="col-md-6">
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
                    <input type="text" id="video_url" name="video_url" value="${(entity.video_url)!}" class="form-control"/>
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
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/videoConfig.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveVideoConfig);
		$(".btn-save").click(function(){
            updloadSaveVideo();
            updloadImg();
			if($("#myFormId").validateForm(saveVideoConfig)) {
				$.ajax({  
			        type:'post',
                    traditional :true,
                    url:'${base}/videoConfig/save.json',
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


    function uploadVideo(obj) {
        $("#catalog").val( $("#block").find("option:selected").attr("data-value"));
        var docObj = document.getElementById("videoFile");

        var AllImgExt=".avi|.mp4|.wmv|.3gp|";
        var extName = docObj.files[0].name.substring(docObj.files[0].name.lastIndexOf(".")).toLowerCase();

        if(AllImgExt.indexOf(extName+"|")==-1)
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(ErrMsg);
            return false;
        }

    }

    function updloadSaveVideo() {
        var formData = new FormData();
        formData.append('360pFile', $('#video360pFile')[0].files[0]?$('#video360pFile')[0].files[0]:"");
        formData.append('File', $('#videoFile')[0].files[0]?$('#videoFile')[0].files[0]:"");
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
                var path = "${base}/"+data.obj;
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
	</script>
</@main.footer>
