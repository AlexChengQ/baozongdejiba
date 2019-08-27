<#list versionMapList as versionMap>
<div class="jg">
    <div class="implement-one">
        <div class="xm-box">
            <div class="f16 l xm"><#if lang?? && lang?string=="en_US">${(qcodeProject.name)!}<#else>${(qcodeProject.name)!}</#if>
                                                <#--${(versionMap.version).createTime?string('yyyyMMddHHmm')}--> ${(versionMap.version).name!}</div>
            <div class="xm-but">
                <a onclick="getVersion(${(versionMap.version).id!});">
                    <i class="iconfont icon-bianji f18"></i>
                </a>
                <a onclick="delVersion(${(versionMap.version).id!});">
                    <i class="iconfont icon-lajitong f18"></i>
                </a>
            </div>
        </div>
        <div class="xm-box-list">
            <div class="l" style="padding: 16px;"
                 onclick="getVersion(${(versionMap.version).id!});">
                <#if (versionMap.version).pic??&&(versionMap.version).pic!=''>
                    <img src="/${setting['files.contextpath']}${(versionMap.version).pic?replace("\\","/")}"
                         width="192" height="120"/>
                <#else>
                    <img src="${base}/assets/images/pic.jpg"/>
                </#if>
            </div>
            <div class="r gdt">
                <#if (versionMap.taskList)?? && (versionMap.taskList)?size gt 0 >
                    <#list versionMap.taskList as task>
                    <#--等待-->
                        <#if task.status??&&task.status=='1'>
                            <div class="new-box">
                                <div class="new-title">
                                    <span class="zt-orange"><@spring.message code="task_status_waiting" /></span>
                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
                                    <span class="zt-but"><a
                                            onclick="terminateTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_termination" /></a></span>
                                    <span class="zt-del"><a
                                            onclick="delTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_delete" /></a></span>
                                </div>
                            </div>
                        <#--处理中-->
                        <#elseif task.status??&&task.status=='2'>
                            <div class="new-box">
                                <div class="new-title">
                                    <span class="zt-blue"><@spring.message code="task_status_process" /></span>
                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
                                    <span class="zt-but"><a
                                            onclick="terminateTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_termination" /></a></span>
                                    <span class="zt-del"><a
                                            onclick="delTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_delete" /></a></span>
                                </div>
                            </div>
                        <#--完成-->
                        <#elseif task.status??&&task.status=='3'>
                            <div class="new-box">
                                <div class="new-title">
                                    <span class="zt-green"><@spring.message code="task_status_complete" /></span>
                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
                                    <span class="zt-but"><a
                                            onclick="showData(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_result" /></a></span>
                                    <span class="zt-del"><a
                                            onclick="delTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_delete" /></a></span>
                                </div>
                            </div>
                        <#--语法错误-->
                        <#elseif task.status??&&task.status=='4'>
                            <div class="new-box">
                                <div class="new-title">
                                    <span class="zt-red"><@spring.message code="task_status_syntactic_error" /></span>
                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
                                    <span class="zt-del"><a
                                            onclick="delTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_delete" /></a></span>
                                </div>
                            </div>
                        <#--任务终止-->
                        <#else>
                            <div class="new-box">
                                <div class="new-title">
                                    <span class="zt-yzz"><@spring.message code="task_status_terminated" /></span>
                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
                                    <span class="zt-del"><a
                                            onclick="delTask(${task.id!});"
                                            style="cursor:pointer"><@spring.message code="task_status_delete" /></a></span>
                                </div>
                            </div>
                        </#if>
                    </#list>
                </#if>


            </div>
        </div>
    </div>
</div>
</#list>