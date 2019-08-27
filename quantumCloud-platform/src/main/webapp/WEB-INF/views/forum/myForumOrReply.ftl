<#if pager?? && (pager.entityList)?size gt 0>
    <#if (type="1")!>
        <div class="attrntBox">
            <ul>
                <#list pager.entityList as project>
                    <li class="community_detalis">
                        <div class="community_bt">
                            <div class="community_top">
                                <div class="cTop_left">
                                    <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}"><div class="title">${project.title}</div></a>
                                </div>
                                <div class="cTop_right">
                                    <div class="cTopImg"><img src="/${setting['files.contextpath']}${project.topicface!}" alt=""></div>
                                </div>
                                <div style="clear: both"></div>

                            </div>
                            <div class="community_bottom">
                                <div class="comm_publish">
                                    <div class="publ_left">
                                        <span>${project.addtime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                    </div>
                                    <div class="publ_right">
                                        <#if (project.applystatus= "已审核")!>
                                        <span><img src="${base}/assets/forImg/tzAudited.png" alt="" style="width: 56px;margin-right: 40px"></span>

                                        <#else>
                                            <span><img src="${base}/assets/forImg/tzInreview.png" alt=""  style="width: 56px;margin-right: 40px"></span>
                                        </#if>
                                        <#--<span class="publ_look">${project.applystatus!}</span>-->
                                        <span class="publ_look">${project.seecount!}</span>
                                        <span class="leaveWord">${project.replycount!}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </#list>
            </ul>
            <div class="fenye" style="width: 100%">
                <nav aria-label="Page navigation"
                     style="margin: 100px auto">
            <@main.pagination pager=pager/>
                </nav>
            </div>
        </div>
    <#else>
        <div class="attrntBox replyBox">
            <ul>
                <#list pager.entityList as project>
                    <li class="community_detalis">
                        <div class="replyNew"><span>${project.content}</span> <span class="replyTime">${project.addtime?string("yyyy-MM-dd HH:mm:ss")!}</span><span style="position: absolute;right: 10px;top: 0;">${project.applystatus}</span></div>
                        <div class="replyLine">
                            <div class="repLineImg">
                                <img src="/${setting['files.contextpath']}${project.topicface!}" alt="">
                            </div>
                            <div class="repLineCon">
                                <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}">${project.title!}</a>
                            </div>
                        </div>
                    </li>
                </#list>
            </ul>
            <div class="fenye"  style="width: 100%">
                <nav aria-label="Page navigation"
                     style="margin: 100px auto">
            <@main.pagination pager=pager/>
                </nav>
            </div>
        </div>
    </#if>

</#if>
<script>
    function toPage(page) {
        $("#startId").val(page);
        myForum(${type});
    }

    positionFooter()

</script>