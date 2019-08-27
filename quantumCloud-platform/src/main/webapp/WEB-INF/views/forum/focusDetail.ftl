<#if pager?? && (pager.entityList)?size gt 0>
    <#list pager.entityList as project>
        <#if (type="1")!>
            <div class="attrntBox">
                <div class="attrList">
                    <div class="attrListBox clearfix">
                        <#if (project.face?exists)>
                            <div class="attrImg"><img src="/${setting['files.contextpath']}${project.face!}"></div>
                        <#else>
                            <div class="attrImg"><img src="${base}/assets/forImg/Head.png"></div>
                        </#if>
                        <div class="attrDetails">
                            <p class="attrName">${project.nickName!}</p>
                            <p class="attrSign">${project.autograph!}</p>
                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="focusBox">
                <ul>
                    <li class="community_detalis">
                        <div class="focusTop clearfix">
                            <div class="focLeft">
                                <div class="menBox clearfix">
                                    <div class="menImg">
                                        <img src="/${setting['files.contextpath']}${project.face!}" alt="">
                                    </div>
                                    <div class="menUser">
                                        <p class="menUserName">${project.nickName}</p>
                                        <p class="menUserTime">${project.focusDate!}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="focRight">
                                <a href="javascript:;">已关注</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </#if>
    </#list>
    <div style="clear:both;"></div>
<div class="fenye" style="width: 100%;">
    <nav aria-label="Page navigation"
         style="margin: 100px auto">
        <@main.pagination pager=pager/>
    </nav>
</div>
</#if>
<script>
    function toPage(page) {
        $("#startId").val(page);
        getFocus();
    }
</script>