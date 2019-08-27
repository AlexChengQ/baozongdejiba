<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="项目管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>项目管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeProject/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
		 				<div class="col-md-3">
				 			<div class="form-group">
							<label for="_name">创建人</label> 
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
							<label for="_taskTypeId">类型</label> 
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
							<label for="_createTime">创建时间</label> 
							<input  type="hidden"  id="createTime_range_start" name="createTime_range_start" type="text" value="${(RequestParameters.createTime_range_start)!}" readonly="true">
			                <input  type="hidden"  id="createTime_range_end" name="createTime_range_end" type="text" value="${(RequestParameters.createTime_range_end)!}" readonly="true">
			                <div class="input-group date createTime-datetimepicker-day" data-date="${.now}" data-date-format="yyyy-mm-dd" value="${.now}">
			                    <input class="form-control" id="_createTime" name="createTimeTemp" type="text" value="${(RequestParameters.createTimeTemp)!}"  readonly>
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
							<!--<@shiro.hasAnyRoles name="ADMIN,QcodeProject:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeProject/add.html">新增</a>
							</@shiro.hasAnyRoles>	-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>创建人</th>
								  	<th>Email</th>
								  	<th>项目名称</th>
								  	<th>版本数</th>
								  	<th>创建时间</th>
								  	<th>类型</th><#assign taskTypeIds={'3':'半导体量子芯片','2':'超导量子芯片','1':'量子仿真'}>
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
									<td title="${(entity.versionNum)!}">${(entity.versionNum)!}</td>
									<td title="${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
									<td title="${(taskTypeIds[''+entity.taskTypeId])!}">${(taskTypeIds[''+entity.taskTypeId])!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeProject:detail">
								<a href="${base}/QcodeProject/detail.html?id=${(entity.id)!}">详细</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeProject:update">
								<!-- <a href="${base}/QcodeProject/edit.html?id=${(entity.id)!}">编辑</a> -->
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeProject:delete">
								<!-- <a href="javascript:void(0)" onclick="return del('${base}/QcodeProject/delete.json',{id:'${(entity.id)!}'});">删除</a> -->
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="14" class="error center">无记录</td></tr>
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
				
				$('.createTime-datetimepicker-day').datetimepicker({
		            format: 'yyyy-mm-dd',
		            weekStart: 1,
		            //autoclose: true,
		            startView: 2,
		            minView: 2,
		            forceParse: false,
		            language: 'zh-CN'
		        }).on('changeDate', function(ev){
		        	if(!ev.date ){ //ev.date为null 就是清空
		         		$('#createTime_range_start').val(null);
		         		$('#createTime_range_end').val(null);
		         		$('#_createTime').val(null);
		         		$(".createTime-datetimepicker-day").datetimepicker('setStartDate','yyyy-mm-dd');//让setStartDate失效从而恢复默认
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
		        	 	$(".createTime-datetimepicker-day").datetimepicker('setStartDate','yyyy-mm-dd');//让setStartDate失效从而恢复默认
						$(".createTime-datetimepicker-day").datetimepicker('hide');
						$('#_createTime').val(createTime_range_start+' - '+date);
		        	}
		        }).on('show', function(ev){
		       			var createTime_range_start = $('#createTime_range_start').val();
		       			var createTime_range_end = $('#createTime_range_end').val();
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
				var createTime_range_start = $('#createTime_range_start').val();
		       	var createTime_range_end = $('#createTime_range_end').val();
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
		</script>
</@main.footer>
