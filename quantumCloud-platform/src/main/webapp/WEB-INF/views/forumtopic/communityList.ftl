<div class="tz_box">
    <div class="tzDetailList">
        <ul>
        <#if pager?? && (pager.entityList)?size gt 0>
            <#list pager.entityList as project>
                <li class="community_detalis">
                    <div class="community_bt">
                        <#if (project.topicFace)?? && project.topicFace != "">
                            <div class="community_top">
                                <div class="cTop_left">
                                    <#if (project.topicFace)?? && project.topicFace != "">
                                        <div class="cTopImg">
                                            <img src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                        </div>
                                    </#if>
                                </div>
                                <div class="cTop_right cTop_right_special">
                                    <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belongde=${belonged}"><div class="title">${project.title!}</div></a>
                                    <div class="tag">
                                        <#if (project.labelList)?size gt 0>
                                            <#list project.labelList as labelList>
                                                <span >${labelList.label!}</span>
                                            </#list>
                                        </#if>
                                    </div>
                                    <div class="community_bottom">
                                        <div class="comm_publish">
                                            <div class="publ_left">
                                                            <span class="publ_photo">
                                                                <#if (project.face)?? && project.face != "">
                                                                    <img src="/${setting['files.contextpath']}${project.face!}" alt="">
                                                                <#else>
                                                                    <img src="${base}/assets/forImg/Head.png" alt="">
                                                                </#if>
                                                            </span>
                                                <span class="pulb_name">${project.userName!}</span>
                                                <span> 于 </span>
                                                <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                                <span>发布</span>
                                                <div style="clear:both;"></div>
                                            </div>
                                            <div class="publ_right">
                                                <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                                    <#if USER_INFO.belonged == belonged>
                                                        <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                                    </#if>
                                                </#if>
                                                <span class="publ_look">${project.seeCount!}</span>
                                                <span class="leaveWord">${project.replyCount!}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="clear: both"></div>
                            </div>
                        <#else>
                            <div class="community_top">
                                <div class="cTop_left">
                                    <#if (project.topicFace)?? && project.topicFace != "">
                                        <div class="cTopImg">
                                            <img src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                        </div>
                                    </#if>
                                </div>
                                <div class="cTop_right">
                                    <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belongde=${belonged}"><div class="title">${project.title!}</div></a>
                                    <div class="tag">
                                        <#if (project.labelList)?size gt 0>
                                            <#list project.labelList as labelList>
                                                <span >${labelList.label!}</span>
                                            </#list>
                                        </#if>
                                    </div>
                                </div>
                                <div style="clear: both"></div>
                            </div>
                            <div class="community_bottom">
                                <div class="comm_publish">
                                    <div class="publ_left">
                                                            <span class="publ_photo">
                                                                <#if (project.face)?? && project.face != "">
                                                                    <img src="/${setting['files.contextpath']}${project.face!}" alt="">
                                                                <#else>
                                                                    <img src="${base}/assets/forImg/Head.png" alt="">
                                                                </#if>
                                                            </span>
                                        <span class="pulb_name">${project.userName!}</span>
                                        <span> 于 </span>
                                        <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                        <span>发布</span>
                                        <div style="clear:both;"></div>
                                    </div>
                                    <div class="publ_right">
                                        <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                            <#if USER_INFO.belonged == belonged>
                                                <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                            </#if>
                                        </#if>
                                        <span class="publ_look">${project.seeCount!}</span>
                                        <span class="leaveWord">${project.replyCount!}</span>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </li>
            </#list>
        </#if>

        </ul>
    </div>
    <div class="fenye" style="width: 100%;">
        <nav aria-label="Page navigation"
             style="margin: 100px auto">
        <@main.pagination pager=pager/>
        </nav>
    </div>
</div>