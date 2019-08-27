<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="导航">
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/SysBanner/index.html">导航管理</a></li>
       <li class="active">增加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post"  class="form-horizontal" role="form" >
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		<input type="hidden" name="id" value="${(entity.id)!}"/>
		<input type="hidden" name="bannerGrade" value="${RequestParameters.bannerGrade!1}"/>
		<input type="hidden" name="parentId" value="${RequestParameters.parentId!0}"/>
		<input type="hidden" name="bannerPath" value="${RequestParameters.bannerPath!''}"/>
		 <div class="form-group">
			<label for="bannerName" class="col-md-3 control-label no-padding-right"> 主菜单名称 </label>
			<div class="col-md-6">
			    <input type="text" id="bannerName" name="bannerName" value="${(entity.bannerName)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-bannerName" ></font><span id="errormsg-bannerName" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="bannerNameEnglish" class="col-md-3 control-label no-padding-right"> 主菜单英文名称 </label>
			<div class="col-md-6">
			    <input type="text" id="bannerNameEnglish" name="bannerNameEnglish" value="${(entity.bannerNameEnglish)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-bannerNameEnglish" ></font><span id="errormsg-bannerNameEnglish" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="bannerUrl" class="col-md-3 control-label no-padding-right"> 链接地址 </label>
			<div class="col-md-6">
			    <input type="text" id="bannerUrl" name="bannerUrl" value="${(entity.bannerUrl)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-bannerUrl" ></font><span id="errormsg-bannerUrl" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="bannerIndex" class="col-md-3 control-label no-padding-right"> 排序 </label>
			<div class="col-md-6">
		        <div class="input-group spinner"  data-trigger="spinner">
			        <input type="text" class="form-control text-center" id="bannerIndex" name="bannerIndex" value="1" data-step="1" data-min="1" data-max="2147483647">
				    <div class="input-group-btn-vertical">
				      <button class="btn btn-default" type="button" data-spin="up"><i class="fa fa-caret-up"></i></button>
				      <button class="btn btn-default" type="button" data-spin="down"><i class="fa fa-caret-down"></i></button>
				    </div>
				  </div>
			</div>
			<div class="col-md-3"><font id="require-bannerIndex" ></font><span id="errormsg-bannerIndex" class="error"></span></div>
		 </div>
		 <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/SysBanner/index.html">返回</a>
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
<script type="text/javascript" src="${validateJS}/SysBanner.js"></script>
<script type="text/javascript">
		
	jQuery(function($) {
		$("#myFormId").validate(saveSysBannerConfig);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveSysBannerConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/SysBanner/save.json',  
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
								        	window.location.href="${base}/SysBanner/index.html";
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