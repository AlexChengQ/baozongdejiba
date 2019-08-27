<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="用户管理">
<link rel="stylesheet" href="${base}/assets/kindeditor/plugins/code/prettify.css" />

</@main.header>
<@main.body>
	<#escape x as x?html>
	<section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/SysLog/index.html">用户管理</a></li>
            <li class="active">查看</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" role="form">
                    <div class="box box-primary">
                        <div class="box-body">
		 <#if entity?exists>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 用户id</label>
                <div class="col-md-6">
                    <input type="text" name="id" value="${(entity.id)!}"  class="form-control" disabled/>
                </div>
            </div>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 用户名 </label>
                <div class="col-md-6">
                    <input type="text" name="name" value="${(entity.name)!}"  class="form-control" disabled />
                </div>
            </div>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> Email </label>
                <div class="col-md-6">
                    <input type="text" name="email" value="${(entity.email)!}"  class="form-control" disabled />
                </div>
            </div>

		    <#assign levels={'3':'三级用户','2':'二级用户','1':'一级用户'}>
		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 用户等级 </label>
                <div class="col-md-6">
                    <input type="text" name="level" value="${(levels[''+entity.level])!}"  class="form-control" disabled />
                </div>
            </div>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 机构 </label>
                <div class="col-md-6">
                    <input type="text" name="orgName" value="${(entity.orgName)!}"  class="form-control" disabled />
                </div>
            </div>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 注册时间 </label>
                <div class="col-md-6">
                    <input type="text" name="registerTime" value="${(entity.registerTime?string('yyyy-MM-dd HH:mm:ss'))!}" class="form-control" disabled/>
                </div>
            </div>

		    <#assign isDisables={'0':'否','1':'是'}>
		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否禁用 </label>
                <div class="col-md-6">
                    <input type="text" name="isDisable" value="${(isDisables[''+entity.isDisable])!}"  class="form-control" disabled />
                </div>
            </div>

		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> APIKey </label>
                <div class="col-md-6">
                    <input type="text" name="apiKey" value="${(entity.apiKey)!}"  class="form-control" disabled />
                </div>
            </div>

			<#assign deleteds={'0':'否','1':'是'}>
		 	<div class="form-group">
                <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 是否删除 </label>
                <div class="col-md-6">
                    <input type="text" name="deleted" value="${(deleteds[''+entity.deleted])!}"  class="form-control" disabled />
                </div>
            </div>
		 <#else>
			<div role="alert" class="alert alert-danger ">
                <strong>记录不存在</strong>
            </div>
		 </#if>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-md-5 col-md-offset-3">
                                        <a class="btn btn-sm btn-primary" href="${base }/QcodeUser/index.html">返回</a>
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
	<script type="text/javascript">
        jQuery(function($) {
        })
    </script>
</@main.footer>