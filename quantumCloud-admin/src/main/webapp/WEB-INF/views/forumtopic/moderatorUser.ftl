<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
        &times;
    </button>
    <h4 class="modal-title" id="myModalLabel">
        选择用户
    </h4>
</div>
<input type="hidden" value="${belonged}" id="belonged">
<form method="post" id="searchModelForm" action="${base}/qcode/forumtopic/getModerator.html" autocomplete="off">
    <div class="box box-primary">
        <div class="box-body">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="_operContent">Email</label>
                        <input type="text" id="_email" name="email" value="${(RequestParameters.email)!}" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="col-md-offset-5 col-md-7">
                <button class="btn btn-xs btn-primary" type="button" onclick="searchResult()">查询</button>
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
                    <th style="text-align: center;" class="col-md-1"><input id="selectAll" name="checkboxs"
                                                                            type="checkbox" onchange="selectAlls(this)"/>
                    </th>
                    <th>用户名</th>
                    <th>Email</th>
                    <th>用户等级</th><#assign levels={'3':'三级用户','2':'二级用户','1':'一级用户'}>
                    <th>注册时间</th>
                </tr>
                </thead>
                <tbody>
				<#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
					<#list pager.entityList as entity>
                    <tr>
                        <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                        <td style="text-align: center;"><input id="item_${entity.id}" name="checkbox" type="checkbox" value="${entity.id}"
                                                               onclick="selectcheck(this)"
                                                               onchange="selectcheck(this)"/></td>
                        <td title="${(entity.name)!}">${(entity.name)!}</td>
                        <td title="${(entity.email)!}">${(entity.email)!}</td>
                        <td title="${(levels[''+entity.level])!}">${(levels[''+entity.level])!}</td>
                        <td title="${(entity.registerTime?string('yyyy-MM-dd HH:mm:ss'))!}">${(entity.registerTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
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
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
    </button>
    <button type="button" class="btn btn-primary" onclick="saveModerator()">
        保存
    </button>
</div>
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

        //全选
        function selectAlls(obj) {
            $(obj).closest('tr').toggleClass('active');
            if ($(obj).val() == "on") {

                $('tr').addClass('active')
                $(obj).closest('tr').removeClass('active');
                $("input[type='checkbox']").prop("checked", true);//全选
                $(obj).val("off");
            } else {

                $('tr').removeClass('active')
                $("input[type='checkbox']").removeAttr("checked");//取消全选
                $(obj).val("on");
            }
        }

        //单选
        function selectcheck(obj) {
            if ($(obj).is(":checked")) {
                $(obj).closest('tr').addClass('active');
                $("#selectAll").prop("checked", true);
                $("#selectAll").val("off");
                $("input[id^='item_']").each(function (index, item) {
                    var c = $(item).is(":checked");
                    if (!c) {
                        $("#selectAll").removeAttr("checked");
                        $("#selectAll").val("on");
                        return;
                    }
                });
            } else {
                $(obj).closest('tr').removeClass('active');
                $(obj).removeAttr("checked");
                $("#selectAll").removeAttr("checked");
                $("#selectAll").val("on");
            }
        }

        function saveModerator() {
            var ids = new Array();
            var len = $("input[name='checkbox']:checked").length;
            if(len > 5) {
                alert("每个版块最多只可设置5个版主");
                return;
			}
            $("input[name='checkbox']:checked").each(function () {
                ids.push($(this).val());
            });

            Dialog.confirm({message: "确定设置成版主？"}).on(function (callback) {
                if (callback) {
                    $.ajax({
                        type: 'post',
                        url: "${base }/qcode/forumtopic/saveOrUpdateModerator.json",
                        data: {
                            "ids":ids.join(","),
							"belonged":${belonged}
                        },
                        dataType: 'json',
                        traditional: true,
                        success: function (data) {
                            switch (data.code) {
                                case 401:
                                    var n = noty({
                                        text: data.message,
                                        type: 'error',
                                        dismissQueue: true,
                                        layout: 'topCenter',
                                        theme: 'relax',
                                        timeout: 1500,
                                        callback: {     // 设置回调函数
                                            afterClose: function () {

                                            }
                                        }
                                    });
                                    break;
                                default:
                                    if (data.success) {
                                        var n = noty({
                                            text: data.message,
                                            type: 'success',
                                            dismissQueue: true,
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 1500,
                                            callback: {     // 设置回调函数
                                                afterClose: function () {
                                                    $("#searchForm").submit();
                                                }
                                            }
                                        });
                                    } else {
                                        var n = noty({
                                            text: data.message,
                                            type: 'error',
                                            dismissQueue: true,
                                            layout: 'topCenter',
                                            theme: 'relax',
                                            timeout: 1500
                                        });
                                    }
                            }
                        },
                        error: function (data) {
                            alert('ajax错误');
                        }
                    });
                }
            });
		}

        function toPage(page) {
            $("#startId").val(page);
            checkUser(${belonged});
        }

        function searchResult() {
            checkUser(${belonged});
		}
	</script>
</body>