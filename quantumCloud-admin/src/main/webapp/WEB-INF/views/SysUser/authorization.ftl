<#-----author:lvliang------->
<#-----date:2016-10-13------->
<@main.header title="用户管理">
</@main.header>

<@main.body>
	<#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/SysUser/index.html">用户管理</a></li>
            <li class="active">授权</li>
        </ol>
        <div class="row">
            <div class="col-xs-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form" >
                    <input type="hidden" id="id" name="id" value="${(entity.id)!}"/>
                    <input type="hidden" id="roleId" name="roleId"/>
                    <div class="panel panel-default">
                        <div class="panel-body">
							<#if entity?exists>
                                <div class="form-group">
                                    <label for="val" class="col-sm-2 control-label no-padding-right">角色名称</label>
                                    <div class="col-sm-9">
                                        <select class="form-control select2" style="width:48%;float:left;" id="role">
                                            <option value="">-</option>
											<#if roleList?exists>
												<#list roleList as role>
                                                    <option value="${role.roleId!}">${role.roleName!}</option>
												</#list>
											</#if>
                                        </select>
                                        <select class="form-control" style="width:48%;margin-left:3%;display: none;float:left;	" id="seedRole" onchange="seedRoleChange(this);">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-group">
                                        <div class="col-sm-5 col-xs-offset-3">
                                            <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                            <a class="btn btn-sm btn-primary" href="${base }/SysUser/index.html">返回</a>
                                        </div>
                                    </div>
                                </div>
							<#else>
                                <div role="alert" class="alert alert-danger ">
                                    <strong>记录不存在</strong>
                                </div>
							</#if>
                        </div>
                    </div>
                </form>
            </div>
        </div>
	</section>
	</#escape>
</@main.body>

<@main.footer>
<script type="text/javascript">
    $(document).ready(function(){
        $(".select2").select2();

        $(".btn-save").click(function(){
            if($("#roleId").val()==""){
                var n = noty({
                    text        : "请选择用户角色",
                    type        : 'error',
                    dismissQueue: true,
                    layout      : 'topCenter',
                    theme       : 'relax',
                    timeout		: 1500
                });
            }else{
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/SysUser/authorization.json',
                    data:$("#myFormId").serialize(),
                    success:function(data){
                        if(data.code == '401'){
                            location.href = data.message;
                        }else{
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
                                        	window.location.href = "${base }/SysUser/index.html";
                                        }
                                    }
                                });
                                $("#myModel").hide();
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
                        alert(data.message);
                    }
                });
            }
        });
    });
</script>
<link rel="stylesheet" href="${base}/assets/plugins/spinner/bootstrap-spinner.css" />
<script src="${base}/assets/plugins/spinner/jquery.spinner.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#role").change(function(){
            $("#seedRole").empty();
            var id = $(this).val();
            $.ajax({
                type:'post',
                traditional :true,
                url:'${base}/SysRole/relRole.json',
                data:"id="+id,
                success:function(data){
                    if (data.success){
                        var list = eval(data.message);
                        $("#seedRole").append("<option value='"+id+"'>全部</option>");
                        for(var i=0;i<list.length;i++){
                            $("#seedRole").append("<option value='"+list[i]["roleId"]+"'>"+list[i]["roleName"]+"</option>");
                        }
                        $("#seedRole").show();
                    }else{
                        $("#seedRole").hide();

                    }
                    $("#roleId").val(id);
                }
            });
        });
    });
    function seedRoleChange(id){
        $("#roleId").val(id.value);
    }
</script>
</@main.footer>
