<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="敏感词添加">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SensitiveConfig/index.html">敏感词管理</a></li>
       <li class="active">添加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post"  class="form-horizontal" role="form" >
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		 <div class="form-group">
			<label for="title" class="col-md-3 control-label no-padding-right"> 敏感词 </label>
			<div class="col-md-6">
			    <input type="text" id="sensitiveWord" name="sensitiveWord" value="${(entity.sensitiveWord)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-title" ></font><span id="errormsg-title" class="error"></span></div>
		 </div>	
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SensitiveConfig/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/saveSensitiveWord.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveSensitiveWord);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveSensitiveWord)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SensitiveConfig/addSensitiveWord.json',
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
							            window.location.href = '${base }/SensitiveConfig/index.html'
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
                                            window.location.href = '${base }/SensitiveConfig/index.html'
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
