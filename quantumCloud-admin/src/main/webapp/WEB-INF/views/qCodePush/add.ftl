<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推送表">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/QcodePush/index.html">推送管理</a></li>
       <li class="active">增加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post" class="form-horizontal" role="form" >
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
		 <div class="form-group txt">
			<label for="content" class="col-md-3 control-label no-padding-right"> 内容 </label>
			<div class="col-md-6">
				    <textarea id="content" name="content" ref="content" class="form-control" onblur="valid(this)">${(entity.content)!}</textarea>
			</div>
			<div class="col-md-3"><font id="require-content" ></font><span id="errormsg-content" class="error"></span></div>
		 </div>
            <div class="form-group file">
                <label for="content" class="col-md-3 control-label no-padding-right"> 模板 </label>
                <div class="col-md-6">
                    <input type="file" id="file" name="file" ref="content" class="form-control" onchange="valid(this)"/>
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
		    var docObj = document.getElementById("file");
		    var file = docObj.files;
            var formData = new FormData();
            formData.append('multipartFiles', $('#file')[0].files[0]);
            formData.append('content',$("#content").val());
            formData.append('title',$("#title").val());
			if($("#myFormId").validateForm(saveQcodePushConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,
                    processData: false,
                    contentType: false,
			        url:'${base}/QcodePush/save.json',
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

	function valid(obj) {
	    if(obj.value) {
	        $('.txt').show();
	        $('.file').hide();
		}

		if(obj.files) {
	        $('.file').show();
			$('.txt').hide();
		}
	}
	</script>
</@main.footer>
