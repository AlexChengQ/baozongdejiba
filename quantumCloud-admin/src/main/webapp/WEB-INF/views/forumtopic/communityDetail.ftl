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
            <li><a href="${base }/qcode/forumtopic/community.html">论坛管理</a></li>
            <li class="active">查看</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <input hidden name="applyStatus" value="${(entity.applyStatus)!}">
                <form class="form-horizontal" role="form" method="post" id="searchForm"
                      action="${base}/qcode/forumtopic/forumtopicdetail.html?id=#{(entity.id)!}" autocomplete="off">
                    <div class="box box-primary">
                        <div class="box-body">
                            <#if entity?exists>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 姓名 </label>
                                    <div class="col-md-6">
                                        <input type="text" name="username" value="${(entity.userName)!'游客'}"
                                               class="form-control" disabled/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 主题 </label>
                                    <div class="col-md-6">
                                        <input type="text" title="title" value="${(entity.title)!}"  class="form-control" disabled />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 内容 </label>
                                    <div class="col-md-6">
                                        <textarea name="content" class="form-control" disabled>${(entity.content)!}</textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="form-field-1" class="col-md-3 control-label no-padding-right"> 创建时间 </label>
                                    <div class="col-md-6">
                                        <input name="addTime" type="text" value="${(entity.addTime?string('yyyy-MM-dd HH:mm:ss'))!}"  class="form-control" disabled/>
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
                                        <#if entity.applyStatus ==  '0' >
                                            <a class="btn btn-sm btn-primary btn-Auditing" href="javaScript:void(0)" onclick="return upd('${base}/qcode/forumtopic/forumTopicAudit.json',{id:'${(entity.id)!}',
                                                    applyStatus:'1'});">审核通过</a>
                                        </#if>
                                        <a class="btn btn-sm btn-primary" href="${base }/qcode/forumtopic/community.html?applyStatus=${(entity.applyStatus)!}">返回</a>
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
