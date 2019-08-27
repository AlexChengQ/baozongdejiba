<#-----author:lvliang------->
<#-----date:2017-10-14------->
<@main.header title="导航管理">

</@main.header>
<@main.body>
<#escape x as x?html>
<section class="content">
    <ol class="breadcrumb">
       <li></li>
       <li>导航管理</li>
    </ol>
    <div class="row">
        <div class="col-md-12">
            <form method="post" id="searchForm" action="${base}/SysBanner/index.html" autocomplete="off">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="_roleName">菜单名称</label>
                                    <input type="text" id="bannerName" name="bannerName" value="${(RequestParameters.bannerName)!}" class="form-control "/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-offset-5 col-md-7">
                            <button class="btn btn-xs btn-primary submitForm">查询</button>&nbsp;&nbsp;&nbsp;<button class="btn btn-xs btn-primary clearForm">重置</button>
                        </div>
                    </div>
                </div>
                <div class="box">
                    <div class="box-header with-border">
                        <div class="btn-group">
                          <@shiro.hasAnyRoles name="ADMIN,SysBanner:save">
                              <a class="btn btn-sm btn-primary" href="${base}/SysBanner/add.html?bannerGrade=1&parentId=0">新增</a>
                          </@shiro.hasAnyRoles>
                        </div>
                    </div>
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-bordered table-hover dataList">
                            <thead>
                            <tr>
                                <th class="hide">id</th>
			                    <th style="widht:30%">导航名称</th>
			                    <th style="widht:30%">英文名称</th>
			                    <th style="widht:30%">链接地址</th>
			                    <th style="widht:10%">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                              <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                              	  <#list pager.entityList as banner>	
					                  <tr class="${banner.parentId!-1}">
					                  	<td class="pk hide" rid="${banner.id!-1}">${banner.id!-1}</td>
					                  	<td>
					                  		<a id="${banner.id!-1}" pid="${banner.parentId!-1}" style="font-size: 20px;font-weight: bold;" href="javascript:open('${banner.id!-1}',this);">+</a>&nbsp;${banner.bannerName!''}
					                  	</td>
				                  		<td>${banner.bannerNameEnglish!}</td>
				                  		<td>${banner.bannerUrl!}</td>
					                  	<td>
					                  		<@shiro.hasAnyRoles name="ADMIN,:SysBanner:save">
					                  			<a href="${base}/SysBanner/add.html?parentId=${banner.id!-1}&bannerGrade=${banner.bannerGrade+1}&bannerPath=${banner.bannerPath!''}">新增</a>
					                  		</@shiro.hasAnyRoles>
					                  		<@shiro.hasAnyRoles name="ADMIN,:SysBanner:update">
					                  			<a href="${base}/SysBanner/edit.html?id=${banner.id!-1}">编辑</a>
					                  		</@shiro.hasAnyRoles>
					                  		<@shiro.hasAnyRoles name="ADMIN,:SysBanner:delete">
					                  			<a href="javascript:void(0)" onclick="return del('${base}/SysBanner/delete.json',{id:'${(banner.id)!}'});">删除</a>
					                  		</@shiro.hasAnyRoles>
					                  		${map[banner.id]!}
					                  	</td>
					                  </tr>
					                  
					                  <#if map?? && map[banner.id?string]??>
					                  	 <#list map[banner.id?string] as ban>
						                  	 <tr class="${ban.parentId!-1}" style="display: none;">
							                  	<td class="pk hide" rid="${ban.id!-1}">${ban.id!-1}</td>
							                  	<td>
						                  			&nbsp;&nbsp;&nbsp;&nbsp;
							                  		${ban.bannerName!''}
							                  	</td>
							                  	<td>${ban.bannerNameEnglish!}</td>
						                  		<td>${ban.bannerUrl!}</td>
							                  	<td>
							                  		<@shiro.hasAnyRoles name="ADMIN,:SysBanner:update">
							                  			<a href="${base}/SysBanner/edit.html?id=${ban.id!-1}">编辑</a>
							                  		</@shiro.hasAnyRoles>
							                  		<@shiro.hasAnyRoles name="ADMIN,:SysBanner:delete">
					                  					<a href="javascript:void(0)" onclick="return del('${base}/SysBanner/delete.json',{id:'${(ban.id)!}'});">删除</a>
							                  		</@shiro.hasAnyRoles>
							                  	</td>
							                  </tr>
						                  </#list>
					                  </#if>
				                  </#list>
                              <#else>
                              <tr>
                                  <td colspan="5" class="error center">无记录</td>
                              </tr>
                              </#if>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer"><@main.pagination pager=pager/></div>
                </div>
            </form>
        </div>
    </div>
  </section>
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script>
	function checkThis(obj){
		$(obj).parent().parent().click();
	}
	function open(id,obj){
		if($("."+id).css('display') == 'none'){
			$("#"+id).html("-");
			$("."+id).show();
		}else{
			closeSub(id);
		}
	}
	
	function closeSub(id){
		$("#"+id).html("+");
		$("."+id).hide();
		$("a[pid="+id+"]").each(function(){
			var subId=$(this).attr("id");
			$("#"+subId).html("+");
			$("."+subId).hide();
			closeSub(subId);
		});
	}
	
	function deleteBanner(id){
		$.ajax({  
	        type:'post',  
	        traditional :true,  
	        url:'${base}/SysBanner/delete.json',  
	        data:{"id":id},  
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
						        	window.location.reload();
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
</script>
</@main.footer>
