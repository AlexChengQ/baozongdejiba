<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="推送管理">

</@main.header>
<@main.body>
<#escape x as x?html>  
<section class="content">
	<ol class="breadcrumb">
		<li></li>
       <li>推送管理</li>
    </ol>
	<div class="row">
		<div class="col-md-12">
			<form method="post" id="searchForm" action="${base}/QcodePush/index.html" autocomplete="off">
                <input type="hidden" value="${(qcodePushVo.title)!}" id="title">
                <input type="hidden" value="${qcodePushVo.content}" id="content">
                <input type="hidden" value="${qcodePushVo.id}" id="mailId">
				<div class="box box-primary">
				<div class="box">
                    <div class="box-header with-border">
                        <div class="btn-group">
							<@shiro.hasAnyRoles name="ADMIN,QcodePush:save">
                                <input type="file" id="file" name="file" ref="content" class="form-control"/>
							</@shiro.hasAnyRoles>
                        </div>
                        <div class="col-md-offset-5 col-md-7">
                            <button type="button" class="btn btn-sm btn-primary btn-save">重新发送</button>
                        </div>
					</div>
		            <div class="box-body table-responsive no-padding">
						<table class="table table-bordered table-hover dataList">
							<thead>
								<tr>
									<#if flag == "1">
                                        <th>无效邮箱用户名</th>
                                        <th>无效邮箱</th>
									<#else >
                                        <th>有效邮箱发送失败用户名</th>
                                        <th>有效邮箱发送失败邮箱</th>
									</#if>

								</tr>
							</thead>
							<tbody>
							<#if flag == "1">
								<#if (failedList.invalid)?exists && ((failedList.invalid)?size != 0)>
									<#list failedList.invalid as entity>
                                    <tr>
                                        <td title="${(entity.name)!}">${(entity.name)!}</td>
                                        <td title="${(entity.email)!}">${(entity.email)!}</td>
                                    </tr>
									</#list>

								<#else>
                                <tr><td colspan="2" class="error center">无记录</td></tr>
								</#if>
							<#else >
								<#if (failedList.validUnsent)?exists && ((failedList.validUnsent)?size != 0)>
									<#list failedList.validUnsent as entity>
                                    <tr>
                                        <td title="${(entity.name)!}">${(entity.name)!}</td>
                                        <td title="${(entity.email)!}">${(entity.email)!}</td>
                                    </tr>
									</#list>
								<#else>
                                <tr><td colspan="2" class="error center">无记录</td></tr>
								</#if>
							</#if>

						 	</tbody>
						</table>
                        <div class="col-md-offset-5 col-md-7">
                            <button type="button" class="btn btn-sm btn-primary btn-send">重新发送</button>
                        </div>
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
                $(".btn-save").click(function(){
                    var docObj = document.getElementById("file");
                    var file = docObj.files;
                    var formData = new FormData();
                    formData.append('multipartFiles', $('#file')[0].files[0]);
                    formData.append("title",$("#title").val());
                    formData.append("content",$("#content").val());
                    formData.append("id",$("#mailId").val());
                    $.ajax({
                        type:'post',
                        traditional :true,
                        processData: false,
                        contentType: false,
                        url:'${base}/QcodePush/readXlsxSendMail.json',
                        data:formData,
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
                                                window.location.href = '${base }/QcodePush/index.html'
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
                                                    window.location.href = '${base }/QcodePush/index.html'
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
                });

                $(".btn-send").click(function(){

                    var formData = {};
                    formData.title = $("#title").val();
                    formData.content = $("#content").val();
                    formData.id = $("#mailId").val();
                    $.post('${base}/QcodePush/sendMailAgain.json',
                            formData
                            , function (data) {
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
                                                window.location.href = '${base }/QcodePush/index.html'
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
                            })
                    <#--$.ajax({-->
                        <#--type:'post',-->
                        <#--url:'${base}/QcodePush/sendMailAgain.json',-->
                        <#--data:formData,-->
                        <#--success:function(data){-->
                            <#--switch(data.code){-->
                                <#--case 401:-->
                                    <#--var n = noty({-->
                                        <#--text        : data.message,-->
                                        <#--type        : 'error',-->
                                        <#--dismissQueue: true,-->
                                        <#--layout      : 'topCenter',-->
                                        <#--theme       : 'relax',-->
                                        <#--timeout		: 1500,-->
                                        <#--callback: {     // 设置回调函数-->
                                            <#--afterClose: function() {-->
                                                <#--window.location.href = '${base }/QcodePush/index.html'-->
                                            <#--}-->
                                        <#--}-->
                                    <#--});-->
                                    <#--break;-->
                                <#--default:-->
                                    <#--if (data.success){-->
                                        <#--var n = noty({-->
                                            <#--text        : data.message,-->
                                            <#--type        : 'success',-->
                                            <#--dismissQueue: true,-->
                                            <#--layout      : 'topCenter',-->
                                            <#--theme       : 'relax',-->
                                            <#--timeout		: 1500,-->
                                            <#--callback: {     // 设置回调函数-->
                                                <#--afterClose: function() {-->
                                                    <#--window.location.href = '${base }/QcodePush/index.html'-->
                                                <#--}-->
                                            <#--}-->
                                        <#--});-->
                                    <#--}else{-->
                                        <#--var n = noty({-->
                                            <#--text        : data.message,-->
                                            <#--type        : 'error',-->
                                            <#--dismissQueue: true,-->
                                            <#--layout      : 'topCenter',-->
                                            <#--theme       : 'relax',-->
                                            <#--timeout		: 1500-->
                                        <#--});-->
                                    <#--}-->
                            <#--}-->
                        <#--},-->
                        <#--error:function(data){-->
                            <#--alert('ajax错误');-->
                        <#--}-->
                    <#--});-->
                })
            });


		</script>

</@main.footer>
