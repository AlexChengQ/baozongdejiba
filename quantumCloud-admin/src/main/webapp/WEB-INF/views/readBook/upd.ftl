<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推荐阅读">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/readBook/index.html">推荐阅读</a></li>
       <li class="active">修改</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post" class="form-horizontal" role="form" >
            <input type="hidden" id="image" name="image">
            <input type="hidden" id="id" name="id" value="${(entity.id)!}">
            <input type="hidden" id="oldFace" name="oldFace" value="${(entity.image)!}">
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		 <div class="form-group">
			<label for="title" class="col-md-3 control-label no-padding-right"> 标题 </label>
			<div class="col-md-6">
			    <input type="text" id="title" name="title" value="${(entity.title)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-title" ></font><span id="errormsg-title" class="error"></span></div>
		 </div>
         <div class="form-group">
             <label for="version" class="col-md-3 control-label no-padding-right"> 版本 </label>
             <div class="col-md-6">
                 <input type="text" id="version" name="version" value="${(entity.version)!}" class="form-control"/>
             </div>
             <div class="col-md-3"><font id="require-version" ></font><span id="errormsg-version" class="error"></span></div>
         </div>
         <div class="form-group">
			 <label for="context" class="col-md-3 control-label no-padding-right"> 内容</label>
			 <div class="col-md-6">
				 <textarea id="context" name="context" ref="context" class="form-control">${(entity.context)!}</textarea>
			 </div>
			 <div class="col-md-3"><font id="require-context" ></font><span id="errormsg-context" class="error"></span></div>
		 </div>
            <div class="form-group">
                <label for="author" class="col-md-3 control-label no-padding-right"> 作者 </label>
                <div class="col-md-6">
                    <input type="text" id="author" name="author" value="${(entity.author)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-author" ></font><span id="errormsg-author" class="error"></span></div>
            </div>
            <div class="form-group">
                <label for="translator" class="col-md-3 control-label no-padding-right"> 翻译作者 </label>
                <div class="col-md-6">
                    <input type="text" id="translator" name="translator" value="${(entity.translator)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-author" ></font><span id="errormsg-author" class="error"></span></div>
            </div>
            <div class="form-group file">
                <label for="image" class="col-md-3 control-label no-padding-right"> 首页图标 </label>
                <div class="col-md-6">
                    <img style="max-width: 152px;" src="${setting['files.contextpath']}${(entity.image)!}" alt="" onclick="$('#img').click()" id="prevImg">
                    <input type="file" id="pic" name="pic" ref="pic" onchange="uploadpic(this)" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-image" ></font><span id="errormsg-image" class="error"></span></div>
            </div>

            <div class="form-group">
                <label for="publisher" class="col-md-3 control-label no-padding-right"> 出版商 </label>
                <div class="col-md-6">
                    <input type="text" id="publisher" name="publisher" value="${(entity.publisher)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-publisher" ></font><span id="errormsg-publisher" class="error"></span></div>
            </div>

            <div class="form-group">
                <label for="submitted" class="col-md-3 control-label no-padding-right"> 论文提交时间 </label>
                <div class="col-md-6">
                    <input type="text" id="submitted" name="submitted" value="${(entity.submitted)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-submitted" ></font><span id="errormsg-submitted" class="error"></span></div>
            </div>

            <div class="form-group">
                <label for="joriginallyannounced" class="col-md-3 control-label no-padding-right"> 最初宣布时间 </label>
                <div class="col-md-6">
                    <input type="text" id="joriginallyannounced" name="joriginallyannounced" value="${(entity.joriginallyannounced)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-joriginallyannounced" ></font><span id="errormsg-joriginallyannounced" class="error"></span></div>
            </div>

            <div class="form-group" hidden id="lunwen">
                <label for="site" class="col-md-3 control-label no-padding-right"> 论文地址 </label>
                <div class="col-md-6">
                    <input type="text" id="site" name="site" value="${(entity.site)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-site" ></font><span id="errormsg-site" class="error"></span></div>
            </div>

            <div class="form-group">
                <label for="type" class="col-md-3 control-label no-padding-right"> 选择类型 </label>
                <div class="col-md-6">
                    <select class="form-control" name="type" id="type" onchange="changeUrl()">
                        <option value="0">文章</option>
                        <option value="1">论文</option>
                    </select>
                </div>
                <div class="col-md-3"><font id="require-type"></font><span id="errormsg-type" class="error"></span></div>
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
<script type="text/javascript" src="${base}/assets/views/ReadBook/add.js"></script>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/ReadBook.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveReadBook);
		$(".btn-save").click(function(){
            updloadImg();
			if($("#myFormId").validateForm(saveReadBook)) {
				$.ajax({  
			        type:'post',
                    traditional :true,
                    url:'${base}/readBook/updData.json',
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
							            window.location.href = '${base }/readBook/index.html'
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
                                            window.location.href = '${base }/readBook/index.html'
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
            url:"${base}/readBook/uploadImg.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            async:false,
            processData: false,
            contentType: false,
            success:function(data) {
                var img = data.obj;
                $("#image").val(img);
            },
        })
    }

    function changeUrl() {
        if($("#type").val() == 1) {
            $("#lunwen").show();
        }else {
            $("#lunwen").hide();
        }
    }


	</script>
</@main.footer>
