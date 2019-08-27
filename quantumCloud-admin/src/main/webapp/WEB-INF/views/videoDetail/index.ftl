<a onclick="exportList()" style="    float: right;
    margin-top: -45px;
    margin-right: 19px;">导出</a>
        <div class="row">
            <div class="col-md-12">
                    <div class="box">
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th class="hide">id</th>
                                    <th>视频名称</th>
                                    <th>视频链接</th>
                                    <th>上传时间</th>
                                    <th>是否免费</th><#assign frees={'1':'否','0':'是'}>
                                    <th>播放次数</th>
                                    <th>分享次数</th>
                                    <th>评论次数</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if (pager.entityList)?exists && ((pager.entityList)?size != 0)>
                                        <#list pager.entityList as entity>
                                        <tr>
                                            <td class="pk hide" id="id" title="${(entity.id)!}">${(entity.id)!}</td>
                                            <td title="${(entity.title)!}">${(entity.title)!}</td>
                                            <td title="${(entity.videourl)!}">${(entity.videourl)!}</td>
                                            <td title="${(entity.addTime?string('yyyy-MM-dd'))!}">${(entity
                                            .addTime?string('yyyy-MM-dd'))!}</td>
                                            <td >${(frees[''+entity.free])!}</td>
                                            <td title="${(entity.playcount)!}">${(entity.playcount)!}</td>
                                            <td title="${(entity.sharecount)!}">${(entity.sharecount)!}</td>
                                            <td title="${(entity.replycount)!}">${(entity.replycount)!}</td>
                                        </tr>
                                        </#list>
                                    <#else>
                                    <tr>
                                        <td colspan="10" class="error center">无记录</td>
                                    </tr>
                                    </#if>
                                </tbody>
                            </table>
                        </div>
                        <div class="fenye" style="width: 100%;">
                            <nav aria-label="Page navigation"
                                 style="margin: 100px auto">
                            <@main.pagination pager=pager/>
                            </nav>
                        </div>
            </div>
        </div>
        </div>
    </section>
        <script>
            function toPage(page) {
                $("#startId").val(page);
                getList(2);
            }

        </script>
