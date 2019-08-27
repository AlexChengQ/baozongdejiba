<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="论坛管理">
<#--javascript include here-->
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/qcode/forumtopic/community.html">反馈建议</a></li>
            <li class="active">查看</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form class="form-horizontal" role="form" method="post" id="searchForm" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <#if feedbackDetail?exists>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 所属版块 </label>
                                    <div class="col-md-6">
                                        <input type="text" name="belonged" value="${(feedbackDetail.belonged)!}"
                                               class="form-control" disabled/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 类型 </label>
                                    <div class="col-md-6">
                                        <input type="text" title="problemType" value="${(feedbackDetail.problemType)!}"  class="form-control" disabled />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 主题 </label>
                                    <div class="col-md-6">
                                        <input type="text" title="title" value="${(feedbackDetail.title)!}"  class="form-control" disabled />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 内容 </label>
                                    <div class="col-md-6">
                                        <textarea name="content" class="form-control" disabled>${(feedbackDetail.content)!}</textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
                                    <div class="col-md-6">
                                        <input name="addTime" type="text" value="${(feedbackDetail.addTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 附件 </label>
                                    <div class="col-md-6">
                                        <#list feedbackDetail.relationFileList as relationFile>
                                            <a href="javascript:" onclick="viewFile('${relationFile.fileId}')">${relationFile.fileName},</a>
                                        </#list>
                                    </div>
                                </div>
                            <#else>
                                <div role="alert" class="alert alert-danger ">
                                    <strong>记录不存在</strong>
                                </div>
                            </#if>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-sm-5 col-xs-offset-3">
                                        <a class="btn btn-sm btn-primary" href="${base }/qcode/forumtopic/feedback.html?id=${(feedbackDetail.id)!}">返回</a>
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

    function viewFile(fileId) {
        var image = "${base }/qcode/forumtopic/getFileById.json?fileID="+fileId;
        layer.open({
            type: 1,
            title: false,
            area: ['800px' , '520px'],
            skin: 'layui-layer-nobg', //没有背景色
            shadeClose: true,
            content:'<div><img src="'+image+'" style="width: 800px;height: 520px"></div>'
        });
    }
</script>
</@main.footer>
