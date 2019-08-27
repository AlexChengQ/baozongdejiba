<div class="userCollection ">
    <ul>
        <#if pager?? && (pager.entityList)?size gt 0>
            <#list pager.entityList as project>
                <li>
                    <div class="collBox clearfix">
                        <div class="clooImg">
                            <#if (project.topicface?exists)!>
                                <img src="/${setting['files.contextpath']}${project.topicface!}" alt="">
                            </#if>
                        </div>
                        <div class="clooTitle">
                            <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}">${project.title!}</a>
                            <span class="clooTime">${project.addtime}</span>
                            <a href="javascript:;" class="clooDelet" onclick="delCollect(${project.id!})"></a>
                        </div>
                    </div>
                </li>
            </#list>
        </#if>
    </ul>
    <div class="fenye" style="width: 100%;">
        <nav aria-label="Page navigation"
             style="margin: 100px auto">
    <@main.pagination pager=pager/>
        </nav>
    </div>
</div>

<script>
    function delCollect(forumTopicId) {
        $.post('${base}/qcode/forumtopic/updCollect.json', {
            isCollect:0,
            forumTopicId:forumTopicId,
        }, function (data) {
            if(data.success) {
                getMyCollect();
                alert(data.message);
            }

        })
    }

    positionFooter()
</script>