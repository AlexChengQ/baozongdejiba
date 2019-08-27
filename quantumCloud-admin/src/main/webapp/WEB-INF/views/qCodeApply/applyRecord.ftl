<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="虚拟机申请管理">

</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/qcodeApply/index.html">虚拟机申请管理</a></li>
            <li class="active">申请记录</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form method="post" id="searchForm" action="${base}/qcodeApply/applyRecord.html" autocomplete="off">
                    <div class="box">
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th>账户名</th>
                                    <th>账户邮箱</th>
                                    <th>姓名</th>
                                    <th>电话</th>
                                    <th>邮箱</th>
                                    <th>虚拟机</th>
                                    <th>目的</th>
                                    <th>申请时间</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (list)?exists && ((list)?size != 0)>
                                        <#list list as entity>
                                        <tr>
                                            <td title="${(entity.userName)!}">${(entity.userName)!}</td>
                                            <td title="${(entity.useremail)!}">${(entity.userEmail)!}</td>
                                            <td title="${(entity.name)!}">${(entity.name)!}</td>
                                            <td title="${(entity.phone)!}">${(entity.phone)!}</td>
                                            <td title="${(entity.email)!}">${(entity.email)!}</td>
                                            <td>${(entity.vmType)!}</td>
                                            <td title="${(entity.purpose)!}">${(entity.purpose)!}</td>
                                            <td title="${(entity.applyTime?string('yyyy-MM-dd HH:mm:ss'))!}">${
(entity.applyTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                                            <td>${(entity.applyStatus)!}</td>
                                        </tr>
                                        </#list>
                                    <#else>
                                    <tr>
                                        <td colspan="5" class="error center">无记录</td>
                                    </tr>
                                    </#if>

                                </tbody>
                            </table>
                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <div class="col-md-5 col-md-offset-3">
                                    <a class="btn btn-sm btn-primary" href="${base }/qcodeApply/index.html">返回</a>
                                </div>
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
    jQuery(function ($) {
        $(".select2").select2();
    })
</script>
</@main.footer>
