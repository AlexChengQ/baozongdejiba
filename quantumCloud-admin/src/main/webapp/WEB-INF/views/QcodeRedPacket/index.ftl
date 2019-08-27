<#-----author:JT------->
<#-----date:2018-01-29------->
<@main.header title="红包管理">

</@main.header>
<@main.body>
<#escape x as x?html>
<input type="hidden" id="monenyOrder"  value="${monenyOrder!''}">
<input type="hidden" id="createTimeOrder"  value="${createTimeOrder!''}">
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>红包管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeRedPacket/index.html" autocomplete="off">
			<input type="hidden" id="orderField" name="orderField" value="">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_userName">姓名</label> 
							<input type="text" id="_userName" name="userName" value="${(RequestParameters.userName)!}" class="form-control"/>
							</div>
						</div>		
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_userName">Email</label> 
							<input type="text" id="_userMail" name="userMail" value="${(RequestParameters.userMail)!}" class="form-control"/>
							</div>
						</div>						 			
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_wechatName">微信名称</label> 
							<input type="text" id="_wechatName" name="wechatName" value="${(RequestParameters.wechatName)!}" class="form-control"/>
							</div>
						</div>
			 		</div>
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_status">状态</label> 
							<select id="_status" name="status" val="${(RequestParameters.status)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="1">成功</option>
								<option value="0">失败</option>
							</select>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_moneny">金额</label> 
							<input type="text" id="_moneny" name="moneny" value="${(RequestParameters.moneny)!}" class="form-control"/>
							</div>
						</div>
		 				<div class="col-md-3">
				 			<div class="form-group">
							<label for="_createTime">发放时间</label> 
			                <input  type="hidden"  id="createTime_range_start" name="createTime_range_start" type="text" value="${(RequestParameters.createTime_range_start)!}" readonly>
			                <input  type="hidden"  id="createTime_range_end" name="createTime_range_end" type="text" value="${(RequestParameters.createTime_range_end)!}" readonly>
			                <div class="input-group date createTime-datetimepicker-day" data-date="${(RequestParameters.createTime)!}" data-date-format="yyyy-mm-dd ">
			                    <input class="form-control"  type="text" id="_createTime"  name="createTimeTemp"  value="${(RequestParameters.createTimeTemp)!}" readonly>
			                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
			                </div>
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
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>姓名</th>
								  	<th>Email</th>
								  	<th>微信名称</th>
								  	<th>发放时间<span style="margin-left:20px;cursor: pointer;" onclick="orderByCreateTime();"><img src="${base}/assets/images/jiantou.png"/></span></th>
								  	<th>金额<span style="margin-left:20px;cursor: pointer;" onclick="orderByMoneny();"><img src="${base}/assets/images/jiantou.png"/></span></th>
								  	<th>状态</th><#assign statuss={'1':'成功','0':'失败'}>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.userName)!}">${(entity.userName)!}</td>
									<td title="${(entity.userMail)!}">${(entity.userMail)!}</td>
									<td title="${(entity.wechatName)!}">${(entity.wechatName)!}</td>
									<td title="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
									<td title="${(entity.moneny)?string('#.##')}">${(entity.moneny)?string('#.##')}</td>
									<td title="${(statuss[''+entity.status])!}">${(statuss[''+entity.status])!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeRedPacket:detail">
								<a href="${base}/QcodeRedPacket/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="9" class="error center">无记录</td></tr>
						 	</#if>
						 	</tbody>
						</table>
					</div>
					<div class="panel-footer">
						<@main.pagination pager=pager/>
					</div>
					</form>
			</div>
	</div>
</div>
</section>
	
</#escape>
</@main.body>
<@main.footer>
<#--javascript include here-->
<script type="text/javascript">
jQuery(function($) {
	$(".select2").select2();
	createTime_datetimepicker_day_Initializer();
	$('.createTime-datetimepicker-day').datetimepicker({  //执行时间范围选择
        format: 'yyyy-mm-dd',
        weekStart: 1,
       // autoclose: true,
        startView: 2,
        minView: 2,
        forceParse: false,
        language: 'zh-CN'
    }).on('changeDate', function(ev){
   	 	if(!ev.date ){ //ev.date为null 就是清空
     		$('#createTime_range_start').val(null);
     		$('#createTime_range_end').val(null);
     		$('#_createTime').val(null);
     		$(".createTime-datetimepicker-day").datetimepicker('setStartDate','xxxx-xx-xx');//让setStartDate失效从而恢复默认
    		return false;
  		 }
    	var createTime_range_start =  $('#createTime_range_start').val();
    	var createTime_range_end =  $('#createTime_range_end').val();
    	var date = $('#_createTime').val().substring(0,10);//防止时间格式为yyyy-mm-dd - yyyy-mm-dd
    	if(createTime_range_start =='' || (createTime_range_start !='' && createTime_range_end !='')){//开始时间为空，或者结束时间不为空 ，则选中时间作为开始时间
    		$('#createTime_range_start').val(date);
    		$('#createTime_range_end').val(''); 
    		$('#_createTime').val(date+' - ');
    		$(".createTime-datetimepicker-day").datetimepicker('hide');
    		$(".createTime-datetimepicker-day").datetimepicker('setStartDate',date);
    		$(".createTime-datetimepicker-day").datetimepicker('show');
    	}else{//将选中时间作为结束时间
    	 	$('#createTime_range_end').val(date); 
    	 	$(".createTime-datetimepicker-day").datetimepicker('setStartDate','xx-xx-xxxx');//传入个错误的值，让setStartDate失效从而恢复默认
			$(".createTime-datetimepicker-day").datetimepicker('hide');
			$('#_createTime').val(createTime_range_start+' - '+date);
    	}
    }).on('show', function(ev){
   			var createTime_range_start =  $('#createTime_range_start').val();
    		var createTime_range_end =  $('#createTime_range_end').val();
    		if(createTime_range_start !='' && createTime_range_end ==''){//开始时间不为空且结束时间为空 ，则选中时间作为结束时间
    			$(".createTime-datetimepicker-day").datetimepicker('setStartDate',createTime_range_start);
    		}else{
    		}
    		if(createTime_range_start != '' && createTime_range_end != ''){//防止初始化为1899年
    			$('.createTime-datetimepicker-day').datetimepicker({
		            format: 'yyyy-mm-dd',
		            weekStart: 1,
		            //autoclose: true,
		            startView: 2,
		            minView: 2,
		            forceParse: false,
		            language: 'zh-CN'
		        });
    		}
    });	
	
})

function createTime_datetimepicker_day_Initializer(){
	var createTime_range_start =  $('#createTime_range_start').val();
       var createTime_range_end =  $('#createTime_range_end').val();
	if(createTime_range_start != '' && createTime_range_end != ''){ //防止初始化为1899年
       		$('.createTime-datetimepicker-day').datetimepicker({
	            format: 'yyyy-mm-dd - yyyy-mm-dd',
	            weekStart: 1,
	            //autoclose: true,
	            startView: 2,
	            minView: 2,
	            forceParse: false,
	            language: 'zh-CN'
	        })
       }
}
			
function orderByMoneny(){
	var orderByMoneny = $("#monenyOrder").val();
	if(orderByMoneny=='desc'){
		$("#orderField").val("monenyAsc");
	}else if(orderByMoneny=='asc'){
		$("#orderField").val("monenyDesc");
	}else{
		$("#orderField").val("monenyDesc");
	}
	$("#startId").val(0);
	$("#limitId").val($("#pageSizeId").val());
	$("#searchForm").submit();
	return false;
}

function orderByCreateTime(){
	var orderByCreateTime = $("#createTimeOrder").val();
	if(orderByCreateTime=='desc'){
		$("#orderField").val("createTimeAsc");
	}else if(orderByCreateTime=='asc'){
		$("#orderField").val("createTimeDesc");
	}else{
		$("#orderField").val("createTimeDesc");
	}
	$("#startId").val(0);
	$("#limitId").val($("#pageSizeId").val());
	$("#searchForm").submit();
	return false;
}	
</script>
</@main.footer>
