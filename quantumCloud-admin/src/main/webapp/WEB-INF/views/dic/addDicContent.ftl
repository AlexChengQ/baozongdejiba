<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="字典管理">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />
</@main.header>
<@main.body>
<#escape x as x?html> 
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/Qcode/dic/dicIndex.html">字典内容管理</a></li>
       <li class="active">增加</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
		<form id="myFormId" method="post"  class="form-horizontal" role="form" >
		<div class="box box-primary">
		<div class="box-body">
		<@main.warning/>
		<input type="hidden" name="id" value="${(dic.id)!}"/>
		<input type="hidden" name="dicId" value="${(dicId)!}"/>
            <div class="form-group">
                <label for="descn" class="col-md-3 control-label no-padding-right"> 字典内容 </label>
                <div class="col-md-6">
                    <input type="text" id="dicContext" name="dicContext" value="${(dic.dicContext)!}" class="form-control"/>
                </div>
                <div class="col-md-3"><font id="require-descn" ></font><span id="errormsg-descn" class="error"></span></div>
            </div>
            <div class="form-group">
			<label for="descn" class="col-md-3 control-label no-padding-right"> 字典描述 </label>
			<div class="col-md-6">
			    <input type="text" id="dicDesc" name="dicDesc" value="${(dic.dicDesc)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-descn" ></font><span id="errormsg-descn" class="error"></span></div>
		 </div>	
		 <div class="form-group">
			<label for="keyname" class="col-md-3 control-label no-padding-right"> 字典值 </label>
			<div class="col-md-6">
			    <input type="text" id="dicFlag" name="dicFlag" value="${(dic.dicFlag)!}" class="form-control"/>
			</div>
			<div class="col-md-3"><font id="require-keyname" ></font><span id="errormsg-keyname" class="error"></span></div>
		 </div>
            <div class="form-group">
                <label for="isSuperadmin" class="col-md-3 control-label no-padding-right"> 是否有效 </label>
                <div class="col-md-6">
                    <select id="deflag" name="deflag" val="${(dic.deflag)!}" class="form-control select2">
                        <option value="1">有效</option>
                        <option value="0">无效</option>
                    </select>
                </div>
                <div class="col-md-3"><font id="require-isSuperadmin" ></font><span id="errormsg-isSuperadmin" class="error"></span></div>
            </div>

            <div class="form-group">
		    	<div class="form-group">
					<div class="col-sm-5 col-xs-offset-3">
						<button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
						<a class="btn btn-sm btn-primary" href="${base }/Qcode/dic/dicIndex.html">返回</a>
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
<script charset="utf-8" src="${base}/assets/kindeditor/kindeditor-all.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/lang/zh-CN.js"></script>
<script charset="utf-8" src="${base}/assets/kindeditor/plugins/code/prettify.js"></script>	
<script type="text/javascript" src="${validateJS}/dic.js"></script>
<script type="text/javascript">

	jQuery(function($) {
		$(".select2").select2();
		$("#myFormId").validate(saveDicConfig);
		$(".btn-save").click(function(){
			if($("#myFormId").validateForm(saveDicConfig)) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/Qcode/dic/saveDicContent.json',
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
						            timeout		: 1000,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	window.location.href="${base}/Qcode/dic/dicIndex.html";
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