<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="任务管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>任务管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeTask/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
		 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">姓名</label> 
							<input type="text" id="username" name="username" value="${(RequestParameters.username)!}" class="form-control"/>
							</div>
						</div>
						<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">Email</label> 
							<input type="text" id="email" name="email" value="${(RequestParameters.email)!}" class="form-control"/>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">项目</label> 
							<input type="text" id="_name" name="name" value="${(RequestParameters.name)!}" class="form-control"/>
							</div>
						</div>
						<div class="col-md-3">
				 			<div class="form-group">
							<label for="_taskTypeId">任务类型</label> 
							<select id="_taskTypeId" name="taskTypeId" val="${(RequestParameters.taskTypeId)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="3">半导体量子芯片</option>
								<option value="2">超导量子芯片</option>
								<option value="1">量子仿真</option>
							</select>
							</div>
						</div>
			 		</div>
		 			<div class="row">
		 				<div class="col-md-3">
				 			<div class="form-group">
							<label for="_status">状态</label> 
							<select id="_status" name="status" val="${(RequestParameters.status)!}" class="form-control select2" style="width: 100%;">
								<option value="">全部</option>
								<option value="3">完成</option>
								<option value="2">处理中</option>
								<option value="1">等待</option>
								<option value="5">已终止</option>
								<option value="4">语法错误</option>
							</select>
							</div>
						</div>
		 				<div class="col-md-3">
				 			<div class="form-group">
							<label for="_startTime">执行时间</label> 
			                <input  type="hidden"  id="startTime_range_start" name="startTime_range_start" type="text" value="${(RequestParameters.startTime_range_start)!}" readonly>
			                <input  type="hidden"  id="startTime_range_end" name="startTime_range_end" type="text" value="${(RequestParameters.startTime_range_end)!}" readonly>
			                <div class="input-group date startTime-datetimepicker-day" data-date="${(RequestParameters.startTime)!}" data-date-format="yyyy-mm-dd ">
			                    <input class="form-control"  type="text" id="_startTime"  name="startTimeTemp"  value="${(RequestParameters.startTimeTemp)!}" readonly>
			                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
								<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
			                </div>
							</div>
						</div>
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_endTime">结束时间</label>
							<input  type="hidden"   id="endTime_range_start" name="endTime_range_start" type="text" value="${(RequestParameters.endTime_range_start)!}" readonly>
			                <input  type="hidden"   id="endTime_range_end" name="endTime_range_end" type="text" value="${(RequestParameters.endTime_range_end)!}" readonly> 
			                <div class="input-group date endTime-datetimepicker-day" data-date="${(RequestParameters.endTime)!}" data-date-format="yyyy-mm-dd">
			                    <input class="form-control" id="_endTime" name="endTimeTemp" type="text" value="${(RequestParameters.endTimeTemp)!}" readonly>
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
							<!--<@shiro.hasAnyRoles name="ADMIN,QcodeTask:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeTask/add.html">新增</a>
							</@shiro.hasAnyRoles>	-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>姓名</th>
								  	<th>Email</th>
								  	<th>项目</th>
								  	<th>类型</th><#assign taskTypeIds={'1':'量子仿真','2':'超导量子芯片','3':'半导体量子芯片'}>
								  	<th>状态</th><#assign statuss={'1':'等待','2':'处理中','3':'完成','4':'语法错误','5':'已终止'}>
								  	<th>执行时间</th>
								  	<th>结束时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.username)!}">${(entity.username)!}</td>
									<td title="${(entity.email)!}">${(entity.email)!}</td>
									<td title="${(entity.name)!}">${(entity.name)!}</td>
									<td title="${(taskTypeIds[''+entity.taskTypeId])!}">${(taskTypeIds[''+entity.taskTypeId])!}</td>
									<td title="${(statuss[''+entity.status])!}">${(statuss[''+entity.status])!}</td>
									<td title="${(entity.startTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.startTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
									<td title="${(entity.endTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.endTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeTask:update">
								<#if ((entity.status)?string ==  QcodeTask.STATUS_WAITING) || ((entity.status)?string ==  QcodeTask.STATUS_PROCESS)  >
									<a href="javascript:void(0)" onclick="return stopTask('${base}/QcodeTask/stopTask.json',{id:'${(entity.id)!}'});">终止</a>
								</#if>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeTask:detail">
								<a href="${base}/QcodeTask/detail.html?id=${(entity.id)!}">详细</a>
								</@shiro.hasAnyRoles>
						   <!-- <@shiro.hasAnyRoles name="ADMIN,QcodeTask:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/QcodeTask/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles> -->
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="11" class="error center">无记录</td></tr>
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
				
				startTime_datetimepicker_day_Initializer();
				$('.startTime-datetimepicker-day').datetimepicker({  //执行时间范围选择
		            format: 'yyyy-mm-dd',
		            weekStart: 1,
		           // autoclose: true,
		            startView: 2,
		            minView: 2,
		            forceParse: false,
		            language: 'zh-CN'
		        }).on('changeDate', function(ev){
		       	 	if(!ev.date ){ //ev.date为null 就是清空
		         		$('#startTime_range_start').val(null);
		         		$('#startTime_range_end').val(null);
		         		$('#_startTime').val(null);
		         		$(".startTime-datetimepicker-day").datetimepicker('setStartDate','xxxx-xx-xx');//让setStartDate失效从而恢复默认
		        		return false;
		      		 }
		        	var startTime_range_start =  $('#startTime_range_start').val();
		        	var startTime_range_end =  $('#startTime_range_end').val();
		        	var date = $('#_startTime').val().substring(0,10);//防止时间格式为yyyy-mm-dd - yyyy-mm-dd
		        	if(startTime_range_start =='' || (startTime_range_start !='' && startTime_range_end !='')){//开始时间为空，或者结束时间不为空 ，则选中时间作为开始时间
		        		$('#startTime_range_start').val(date);
		        		$('#startTime_range_end').val(''); 
		        		$('#_startTime').val(date+' - ');
		        		$(".startTime-datetimepicker-day").datetimepicker('hide');
		        		$(".startTime-datetimepicker-day").datetimepicker('setStartDate',date);
		        		$(".startTime-datetimepicker-day").datetimepicker('show');
		        	}else{//将选中时间作为结束时间
		        	 	$('#startTime_range_end').val(date); 
		        	 	$(".startTime-datetimepicker-day").datetimepicker('setStartDate','xx-xx-xxxx');//传入个错误的值，让setStartDate失效从而恢复默认
						$(".startTime-datetimepicker-day").datetimepicker('hide');
						$('#_startTime').val(startTime_range_start+' - '+date);
		        	}
		        }).on('show', function(ev){
		       			var startTime_range_start =  $('#startTime_range_start').val();
		        		var startTime_range_end =  $('#startTime_range_end').val();
		        		if(startTime_range_start !='' && startTime_range_end ==''){//开始时间不为空且结束时间为空 ，则选中时间作为结束时间
		        			$(".startTime-datetimepicker-day").datetimepicker('setStartDate',startTime_range_start);
		        		}else{
		        		}
		        		if(startTime_range_start != '' && startTime_range_end != ''){//防止初始化为1899年
		        			$('.startTime-datetimepicker-day').datetimepicker({
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
		        
		        
		        endTime_datetimepicker_day_Initializer();
		        
		        $('.endTime-datetimepicker-day').datetimepicker({ //结束时间范围选择
		            format: 'yyyy-mm-dd',
		            weekStart: 1,
		           // autoclose: true,
		            startView: 2,
		            minView: 2,
		            forceParse: false,
		            language: 'zh-CN'
		        }).on('changeDate', function(ev){
		       	 	if(!ev.date ){ //ev.date为null 就是清空
		         		$('#endTime_range_start').val(null);
		         		$('#endTime_range_end').val(null);
		         		$('#_endTime').val(null);
		         		$(".endTime-datetimepicker-day").datetimepicker('setStartDate','xxxx-xx-xx');//让setStartDate失效从而恢复默认
		        		return false;
		      		 }
		        	var endTime_range_start =  $('#endTime_range_start').val();
		        	var endTime_range_end =  $('#endTime_range_end').val();
		        	var date = $('#_endTime').val().substring(0,10);//防止时间格式为yyyy-mm-dd - yyyy-mm-dd
		        	if(endTime_range_start =='' || (endTime_range_start !='' && endTime_range_end !='')){//开始时间为空，或者结束时间不为空 ，则选中时间作为开始时间
		        		$('#endTime_range_start').val(date);
		        		$('#endTime_range_end').val(''); 
		        		$('#_endTime').val(date+' - ');
		        		$(".endTime-datetimepicker-day").datetimepicker('hide');
		        		$(".endTime-datetimepicker-day").datetimepicker('setStartDate',date);
		        		$(".endTime-datetimepicker-day").datetimepicker('show');
		        	}else{//将选中时间作为结束时间
		        	 	$('#endTime_range_end').val(date); 
		        	 	$(".endTime-datetimepicker-day").datetimepicker('setStartDate','xx-xx-xxxx');//传入个错误的值，让setStartDate失效从而恢复默认
						$(".endTime-datetimepicker-day").datetimepicker('hide');
						$('#_endTime').val(endTime_range_start+' - '+date);
		        	}
		        }).on('show', function(ev){
		       			var endTime_range_start =  $('#endTime_range_start').val();
		        		var endTime_range_end =  $('#endTime_range_end').val();
		        		if(endTime_range_start !='' && endTime_range_end ==''){//开始时间不为空且结束时间为空 ，则选中时间作为结束时间
		        			$(".endTime-datetimepicker-day").datetimepicker('setStartDate',endTime_range_start);
		        		}else{
		        		}
		        		if(endTime_range_start != '' && endTime_range_end != ''){//防止初始化为1899年
		        			$('.endTime-datetimepicker-day').datetimepicker({
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
			
			
			function startTime_datetimepicker_day_Initializer(){
				var startTime_range_start =  $('#startTime_range_start').val();
		        var startTime_range_end =  $('#startTime_range_end').val();
				if(startTime_range_start != '' && startTime_range_end != ''){ //防止初始化为1899年
		        		$('.startTime-datetimepicker-day').datetimepicker({
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
			
			function endTime_datetimepicker_day_Initializer(){
				var endTime_range_start =  $('#endTime_range_start').val();
		        var endTime_range_end =  $('#endTime_range_end').val();
				if(endTime_range_start != '' && endTime_range_end != ''){ //防止初始化为1899年
		        		$('.endTime-datetimepicker-day').datetimepicker({
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
			
			
		//终止	
		function stopTask(url,params,callbackFun){
			Dialog.confirm({message: "确定要终止吗？"}).on(function(callback){
			if (callback)
			{
				$.ajax({
			        type : 'POST',
			        url : url,
			        data : params,  
			        dataType : 'json',
			        traditional:true,
			        success : function(result){
			        	if (callbackFun != undefined)
		        		{
			        		callbackFun(result);
			        		return;
		        		}
			        	switch(result.code){
			        	case 401:
			        		var n = noty({
					            text        : result.message,
					            type        : 'error',
					            dismissQueue: true,
					            layout      : 'topCenter',
					            theme       : 'relax',
					            timeout		: 1500
					        });
		        			break;
		        		default:
			        		if (result.success){
				        		var n = noty({
						            text        : result.message,
						            type        : 'success',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1500,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	refreshList();
								        }
								    }
						        });
				        	}else{
				        		var n = noty({
						            text        : result.message,
						            type        : 'error',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1500
						        });
				        	}
			        	}
			        },
			        cache:false,
			        error : function(){
			           top.Dialog.alert("终止失败！");
			        }
			    });
			}
			});
		}
			
		</script>
</@main.footer>
