<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>用户管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodeUser/index.html" autocomplete="off">
				<div class="box box-primary">
	            <div class="box-body">
		 			<div class="row">
			 			<div class="col-md-3">
				 			<div class="form-group">
							<label for="_operContent">Email</label> 
							<input type="text" id="_email" name="email" value="${(RequestParameters.email)!}" class="form-control"/>
							</div>
						</div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="_operDate">注册日期</label>
                                <input  type="hidden"  id="registerTime_range_start" name="registerTime_range_start" type="text" value="${(RequestParameters.registerTime_range_start)!}" readonly>
                                <input  type="hidden"  id="registerTime_range_end" name="registerTime_range_end" type="text" value="${(RequestParameters.registerTime_range_end)!}" readonly>
                                <div class="input-group date registerTime-datetimepicker-day" data-date="${(RequestParameters.registerTime)!}" data-date-format="yyyy-mm-dd ">
                                    <input class="form-control"  type="text" id="_registerTime"  name="registerTimeTemp"  value="${(RequestParameters.registerTimeTemp)!}" readonly>
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
							<#--<@shiro.hasAnyRoles name="ADMIN,QcodeUser:save">
							<a class="btn btn-xs btn-primary" href="${base}/QcodeUser/add.html">新增</a>
							</@shiro.hasAnyRoles>	-->
						</div>
		            </div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
								  	<th class="hide">id</th>
								  	<th>用户名</th>
								  	<th>Email</th>
								  	<th>用户等级</th><#assign levels={'3':'三级用户','2':'二级用户','1':'一级用户'}>
                                    <th>机构</th>
								  	<th>注册时间</th>
									<th>总学习时间</th>
									<th>今日学习时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
							<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
							<#list pager.entityList as entity>
							<tr>
									<td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
									<td title="${(entity.name)!}">${(entity.name)!}</td>
									<td title="${(entity.email)!}">${(entity.email)!}</td>
                                	<td title="${(levels[''+entity.level])!}">${(levels[''+entity.level])!}</td>
                                    <td title="${(entity.orgName)!}">${(entity.orgName)!}</td>
									<td title="${(entity.registerTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.registerTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                	<td title="${(entity.allStdTime)!}">${(entity.allStdTime)!}</td>
                                	<td title="${(entity.todayStdTime)!}">${(entity.todayStdTime)!}</td>
								<td>
								<@shiro.hasAnyRoles name="ADMIN,QcodeUser:detail">
								<a href="${base}/QcodeUser/detail.html?id=${(entity.id)!}">查看</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeUser:update">
								<a href="${base}/QcodeUser/edit.html?id=${(entity.id)!}">编辑</a>
								</@shiro.hasAnyRoles>
								<@shiro.hasAnyRoles name="ADMIN,QcodeUser:delete">
								<a href="javascript:void(0)" onclick="return del('${base}/QcodeUser/delete.json',{id:'${(entity.id)!}'});">删除</a>
								</@shiro.hasAnyRoles>
								</td>
							</tr>
						 	</#list>
						 	<#else>
						 		<tr><td colspan="8" class="error center">无记录</td></tr>
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

			registerTime_datetimepicker_day_Initializer();
			$('.registerTime-datetimepicker-day').datetimepicker({  //执行时间范围选择
				format: 'yyyy-mm-dd',
				weekStart: 1,
				// autoclose: true,
				startView: 2,
				minView: 2,
				forceParse: false,
				language: 'zh-CN'
			}).on('changeDate', function(ev){
				if(!ev.date ){ //ev.date为null 就是清空
					$('#registerTime_range_start').val(null);
					$('#registerTime_range_end').val(null);
					$('#_registerTime').val(null);
					$(".registerTime-datetimepicker-day").datetimepicker('setStartDate','xxxx-xx-xx');//让setStartDate失效从而恢复默认
					return false;
				}
				var registerTime_range_start =  $('#registerTime_range_start').val();
				var registerTime_range_end =  $('#registerTime_range_end').val();
				var date = $('#_registerTime').val().substring(0,10);//防止时间格式为yyyy-mm-dd - yyyy-mm-dd
				if(registerTime_range_start =='' || (registerTime_range_start !='' && registerTime_range_end !='')){//开始时间为空，或者结束时间不为空 ，则选中时间作为开始时间
					$('#registerTime_range_start').val(date);
					$('#registerTime_range_end').val('');
					$('#_registerTime').val(date+' - ');
					$(".registerTime-datetimepicker-day").datetimepicker('hide');
					$(".registerTime-datetimepicker-day").datetimepicker('setStartDate',date);
					$(".registerTime-datetimepicker-day").datetimepicker('show');
				}else{//将选中时间作为结束时间
					$('#registerTime_range_end').val(date);
					$(".registerTime-datetimepicker-day").datetimepicker('setStartDate','xx-xx-xxxx');//传入个错误的值，让setStartDate失效从而恢复默认
					$(".registerTime-datetimepicker-day").datetimepicker('hide');
					$('#_registerTime').val(registerTime_range_start+' - '+date);
				}
			}).on('show', function(ev){
				var registerTime_range_start =  $('#registerTime_range_start').val();
				var registerTime_range_end =  $('#registerTime_range_end').val();
				if(registerTime_range_start !='' && registerTime_range_end ==''){//开始时间不为空且结束时间为空 ，则选中时间作为结束时间
					$(".registerTime-datetimepicker-day").datetimepicker('setStartDate',registerTime_range_start);
				}else{
				}
				if(registerTime_range_start != '' && registerTime_range_end != ''){//防止初始化为1899年
					$('.registerTime-datetimepicker-day').datetimepicker({
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

		function registerTime_datetimepicker_day_Initializer(){
			var registerTime_range_start =  $('#registerTime_range_start').val();
			var registerTime_range_end =  $('#registerTime_range_end').val();
			if(registerTime_range_start != '' && registerTime_range_end != ''){ //防止初始化为1899年
				$('.registerTime-datetimepicker-day').datetimepicker({
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
