<div <#if (type="1")!>class="enshrineBox"<#else>class="dianzanBox"</#if>>
    <ul>
    <#list pager.entityList as project>
        <li class="community_detalis">
            <div class="dzTop">
                <div class="dzTitle"><i></i>
                    <#list project.collectList as collect>
                        ${collect.userName},
                    </#list>
                    ${project.collectList?size}人<#if type='1'>收藏<#else >点赞</#if></div>
            </div>
            <div class="mentsBottom">
                <div class="botWrite"><img src="/${setting['files.contextpath']}${project.face!}" alt=""></div>
                <div class="botTitle"><a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.forumTopicId!}">${project.title}</a></div>
            </div>
        </li>
    </#list>
    </ul>
</div>
<div class="fenye" style="width: 100%;">
    <nav aria-label="Page navigation"
         style="margin: 100px auto">
    <@main.pagination pager=pager/>
    </nav>
</div>
<script>
    function toPage(page) {
        $("#startId").val(page);
//        getCollect('2');
        initWebSocket($("#userId").val());
    }
</script>