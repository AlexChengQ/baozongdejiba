<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="帖子举报管理">
<#--javascript include here-->
</@main.header>
<@main.body>
<#escape x as x?html>
	<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li><a href="${base }/qcodereport/index.html">帖子举报管理</a></li>
       <li class="active">查看</li>
   </ol>
	<div class="row">
		<div class="col-md-12">
			<form class="form-horizontal" role="form">
			<div class="box box-primary">
		<div class="box-body">
		 <#if entity?exists>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 类别</label>
				<div class="col-md-6">
				    <input type="text" name="typename" value="${(entity.typename)!}"  class="form-control" disabled/>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 举报类型</label>
				<div class="col-md-6">
				    <input type="text" name="reporttypename" value="${(entity.reporttypename)!}"
                           class="form-control" disabled/>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 举报人</label>
				<div class="col-md-6">
				    <input type="text" name="reportusername" value="${(entity.reportusername)!}"
                           class="form-control" disabled/>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 帖子标题</label>
				<div class="col-md-6">
				    <input type="text" name="topictitle" value="${(entity.topictitle)!}"  class="form-control"
                           disabled/>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 评论内容</label>
				<div class="col-md-6">
                    <textarea name="replycontent" class="form-control" disabled style="height: 100px">${(entity.replycontent)
                    !}</textarea>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 举报内容</label>
				<div class="col-md-6">
                    <textarea name="reportcontent" class="form-control" disabled style="height: 100px">${(entity.reportcontent)!}</textarea>
		 		</div>
			 </div>

		 	<div class="form-group">
				<label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
				<div class="col-md-6">
				    <input name="addtime" type="text" value="${(entity.addtime?string('yyyy-MM-dd HH:mm:ss'))!}"
                           class="form-control" disabled/>
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
					<a class="btn btn-sm btn-primary" href="${base }/qcodereport/index.html">返回</a>
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
