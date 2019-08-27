<div class="RetList">
<#if (hotList)?size gt 0>
    <ul>
    <#list hotList as project>
        <li class="retDetails">
            <div class="RetPt">
            <#if (project.topicface)??&&project.topicface!="">
                <img src="/${setting['files.contextpath']}${project.topicface!}" alt="">
            </#if>
            </div>
            <div class="rEtText">
                <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}">
                <div class="RetTitle">${project.title}</div>
                </a>
                <div class="RetView">
                    <span class="RetLook">${project.seecount!}</span>
                    <span class="RetSupport">${project.approvalcount}</span>
                </div>
            </div>
            <div class="Retborder-bottom">
            </div>
        </li>
        </#list>
    </ul>
</#if>
</div>