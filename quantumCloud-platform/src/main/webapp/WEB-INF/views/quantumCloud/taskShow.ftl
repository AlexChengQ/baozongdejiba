<#-----author:JT------->
<#-----date:2017-12-29------->
<@main.header>
<#escape x as x?html>
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content">
<input type="hidden" id="flag">
<input type="hidden" id="projectId" value="${(qcodeProject.id)!}">
<input type="hidden" id="versionId" value="${(projectVersion.id)!}">
<input type="hidden" id="taskTypeId" value="${(qcodeProject.taskTypeId)!}">
<input type="hidden" id="code" value='${(projectVersion.code)!}'>
<!--top-->
<div class="top">
    <div class="logo">
        <span style="padding-top: 10px;">
             <img src="${base}/assets/images/benyuan.png" width="40" height="40" />
        </span>
        <span class="logo-text"><@spring.message code="project_name" /><span class="f12 " style="float:right;margin-left: 10px;">BETA</span></span>
    </div>
</div>
<!--top end-->
<!--box-->
<#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
<div class="box">
    <div class="box-left">
        <div class="project-title">
            <div class="l project-text">
            	<#if lang?? && lang?string=="en_US">
            		${qcodeProject.nameEnglish!'No introduction'}
            	<#else>
            		${(qcodeProject.name)!}
            	</#if>
                <#if (qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258))&&(qcodeProject.taskTypeId?? && qcodeProject.taskTypeId!=3)>#${projectVersion.createTime?string('yyyyMMddHHmm')} ${projectVersion.name!}</#if>
            </div>      
        </div>
        <!--tab-->
        <div id="tab">
            <ul class="tab_menu">
                <li class="selected"><@spring.message code="design" /></li>
                <li class="daima"><@spring.message code="quantum_program" /></li>
                <li class="daima"><@spring.message code="project_introduction" /></li>                
            </ul>
            <div class="tab_box">
                <div class="pr-box" id="contentCenter">
                    <div class="case">
                        <div class="case-top">                                                       
                            <div class="case-list">
                                <dl>
                                    <dt><@spring.message code="single_qubit_gates" /></dt>
                                    <dd class="pic-blue">
                                        <i class="iconfont icon-H"></i>
                                    </dd>

                                    <dd class="pic-blue">
                                        <i class="iconfont icon-NOT"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-Z"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-X"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-Y"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-Z1"></i>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt><@spring.message code="multi_qubit_gates" /></dt>
                                    <dd class="pic-green f24">
                                        <i class="iconfont icon-jia1"></i>
                                    </dd>
                                    <dd class="pic-green f24">
                                        <i class="iconfont icon-cha1"></i>
                                    </dd>
                                    <dd class="pic-yellow f24">
                                        <i class="iconfont icon-jia1"></i>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt><@spring.message code="measure" /></dt>
                                    <dd class="pic-red f18">
                                        <i class="iconfont icon-celiang"></i>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt><@spring.message code="advanced" /></dt>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-X1"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-Y1"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-Z2"></i>
                                    </dd>
                                    <dd class="pic-green f16">
                                        <i class="iconfont icon-Z3"></i>
                                    </dd>
                                </dl>
                                <dl>

                                </dl>
                                <dl>
                                </dl>
                                <!--<div class="mnq">-->
                                <!--<h5 style="margin-top: 0;"><strong>当前状态</strong></h5>-->
                                <!--<ul>-->
                                <!--<li class="mn blue-hx">模拟</li>-->
                                <!--<li>处理器</li>-->
                                <!--</ul>-->
                                <!--</div>-->
                                <dl class="dmhj" style="display: block;">
                                    <dt>代码合集</dt>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-GHZ2"></i>
                                    </dd>

                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-GHZ"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-GHZ1"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-QFT1"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-QFT"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-CZ"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-z-CNOT"></i>
                                    </dd>
                                    <dd class="pic-blue f18">
                                        <i class="iconfont icon-SWAP"></i>
                                    </dd>
                                    <dd class="pic-blue f34">
                                        <i class="iconfont icon-H1"></i>
                                    </dd>
                                </dl>
                            </div>
                                                   
                            <div class="case-js">
                                <dl>
                                    <dd class="left16">
                                        <span class="jt"></span>
                                        <p><@spring.message code="hadamard_gate" /></p>
                                        <p>H=[1 1;1 -1]/sqrt(2)</p>
                                    </dd>
                                    <dd class="left36">
                                        <span class="jt" style="left:47px;"></span>
                                        <p><@spring.message code="not_gate" /></p>
                                        <p>NOT=[0 1;1 0]</p>
                                    </dd>
                                    <dd class="left84">
                                        <span class="jt" style="left:47px;"></span>
                                        <p><@spring.message code="pi_phase_gate" /></p>
                                        <p>Z(pi)=[1 0;0 -1]</p>
                                    </dd>
                                    <dd class="left120">
                                        <span class="jt" style="left:62px;"></span>
                                        <p>X</p>
                                        <p>X=[1 -i;-i 1]/sqrt(2)</p>
                                    </dd>
                                    <dd class="left164">
                                        <span class="jt" style="left:66px;"></span>
                                        <p>Y</p>
                                        <p>Y=[1 -1;1 1]/sqrt(2)</p>
                                    </dd>
                                    <dd class="left246">
                                        <span class="jt" style="left:36px;"></span>
                                        <p>Z</p>
                                        <p>Z=[1 0;0 -i]</p>
                                    </dd>
                                </dl>
                                <dl>
                                    <dd class="left298">
                                        <span class="jt" style="left:66px;"></span>
                                        <p><@spring.message code="cnot_gate" /></p>
                                        <p> CNOT=[I(2) 0;0 NOT]</p>
                                    </dd>
                                    <dd class="left280">
                                        <span class="jt" style="left:136px;"></span>
                                        <p><@spring.message code="iswap_gate" /></p>
                                        <p>iSWAP=[1 0 0 0;0 -i 0 0;0 0 -i 0;0 0 0 1]</p>
                                        <p><@spring.message code="sqiswap_gate" /></p>
                                        <p>sqiSWAP=[1 0 0 0;0 1 -i 0;0 -i 1 0;0 0 0 1]</p>
                                    </dd>
                                    <dd class="left386">
                                        <span class="jt" style="left:80px;"></span>
                                        <p><@spring.message code="toffoli_gate" /></p>
                                        <p>Toffoli=[ I(4) 0 ; 0 CNOT]</p>
                                    </dd>
                                </dl>
                                <dl>
                                    <dd class="left370">
                                        <span class="jt" style="left:178px;"></span>
                                        <p><@spring.message code="non_demolition_qubits" /></p>
                                    	<p><@spring.message code="creg_results_qubit" /></p></dd>
                                </dl>
                                <dl>
                                    <dd class="left540">
                                        <span class="jt" style="left:92px;"></span>
                                        <p><@spring.message code="rotate_angle_around_the_x_axis" /></p>
                                        <p>RX(theta)=</p>
                                        <p>[cos(theta/2) -1i*sin(theta/2);</p>
                                        <p>-1i*sin(theta/2) cos(theta/2)]</p>

                                    </dd>
                                    <dd class="left600">
                                        <span class="jt" style="left:82px;"></span>
                                        <p><@spring.message code="rotate_angle_around_the_y_axis" /></p>
                                        <p>RY(theta)=</p>
                                        <p>[cos(theta/2) -sin(theta/2);</p>
                                        <p>sin(theta/2) cos(theta/2)]</p>

                                    </dd>
                                    <dd class="left680">
                                        <span class="jt" style="left:52px;"></span>
                                        <p><@spring.message code="rotate_angle_around_the_z_axis" /></p>
                                        <p>RZ(theta)=</p>
                                        <p>[1 0;</p>
                                        <p>0 exp(-1i*theta)]</p>

                                    </dd>
                                    <dd class="left450">
                                        <span class="jt" style="left:332px;"></span>
                                     <p><@spring.message code="two_qubit_controlled_z_gate" /></p>
                                     <p><@spring.message code="qubit_c_control" /></p>
                                     <p><@spring.message code="cr_exp_theta_desc" /></p>
                                    </dd>
                                </dl>
                                <div class="new-box" style="position:absolute;width:260px;top:10px;right:10px;">
                                    <div class="new-title">                                  
		    						<#if task.status??&&task.status=='1'>
				                                <span class="zt-orange"><@spring.message code="task_status_waiting" /></span>
				                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
		                        	<#--处理中-->
		    						<#elseif task.status??&&task.status=='2'>
					                                <span class="zt-blue"><@spring.message code="task_status_process" /></span>
					                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
		    						<#--完成-->
		    						<#elseif task.status??&&task.status=='3'>
					                                <span class="zt-green"><@spring.message code="task_status_complete" /></span>
					                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
					                                <span class="zt-del"><a onclick="showData(${task.id!});" style="cursor:pointer">结果</a></span>
		    						<#--语法错误-->
		    						<#elseif task.status??&&task.status=='4'>	
					                                <span class="zt-red"><@spring.message code="task_status_syntactic_error" /></span>
					                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
		    						<#--任务终止-->
		    						<#else>
					                                <span class="zt-yzz"><@spring.message code="task_status_terminated" /></span>
					                                ${task.startTime?string("yyyy-MM-dd HH:mm")}
		    						</#if>                                     
                                    </div>
                                </div>
                                <dl></dl>
                                <dl></dl>

                                <dl class="new-dl">
                                    <dd class="left16" style="width:160px;">
                                        <span class="jt"></span>
                                        <p>使2个比特构成纠缠态</p>
                                    </dd>
                                    <dd class="left36" style="width:160px;">
                                        <span class="jt" style="left:47px;"></span>
                                        <p>使3个比特构成最大纠缠态</p>
                                    </dd>
                                    <dd class="left84" style="width:160px;">
                                        <span class="jt" style="left:47px;"></span>
                                        <p>使6个比特构成最大纠缠态</p>
                                    </dd>
                                    <dd class="left120" style="width:160px;">
                                        <span class="jt" style="left:62px;"></span>
                                        <p>三量子比特的量子傅里叶变换</p>
                                    </dd>
                                    <dd class="left164" style="width:160px;">
                                        <span class="jt" style="left:66px;"></span>
                                        <p>四量子比特的量子傅里叶变换</p>
                                    </dd>
                                    <dd class="left246" style="width:80px;">
                                        <span class="jt" style="left:36px;"></span>
                                        <p>控制Z门</p>
                                    </dd>
                                    <dd class="left164" style="width:100px;left:300px;">
                                        <span class="jt" style="left:38px;"></span>
                                        <p>0-控制非门</p>
                                    </dd>
                                    <dd class="left164" style="width:80px;left:358px;">
                                        <span class="jt" style="left:32px;"></span>
                                        <p>交换门</p>
                                    </dd>
                                    <dd class="left164" style="width:100px;left:402px">
                                        <span class="jt" style="left:38px;"></span>
                                        <p>6比特叠加态的制备</p>
                                    </dd>
                                </dl>
                            </div>                          
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="case-box">
                        <div class="case-left">
                        <div style="width:70px;float:left;">
                    	<ul class="itemline" style="border-right:1px solid #dedede;margin-left:20px;">
                    	<#list 0..((qcodeProject.qubitNum)?default(6)-1) as i>
                    	<li>q[${i}]</li>
                    	</#list>
                    	</ul>
                    	</div>
                        <div style="width:40px;float:left;">
                    	<ul class="itemline">
                    	<#list 0..((qcodeProject.qubitNum)?default(6)-1) as i>
                    	<li>&nbsp;&nbsp;|0〉</li>
                    	</#list>
                    	</ul>
                    	<div style="display:none;">
                    	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40">
                    		<g id="svg_H">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M21.09,37.55l3.43-17.73h2.57l-1.43,7.53h7.15l1.48-7.53h2.57L33.43,37.55H30.86l1.48-7.77H25l-1.38,7.77Zm0,0" transform="translate(-8.97 -8.69)"/></g>
							</g>
	                    	<g id="svg_NOT">
								<g><rect fill="#22a5de" width="40" height="40"/><polygon fill="#fff" points="13.85 13.02 12.29 22.93 9.49 13.02 6.97 13.02 4.77 26.96 6.82 26.96 8.42 16.73 11.3 26.96 13.72 26.96 15.9 13.02 13.85 13.02"/><path fill="#fff" d="M22,12a5.56,5.56,0,0,0-2.44.54,6,6,0,0,0-2,1.59,7.65,7.65,0,0,0-1.4,2.63,11.21,11.21,0,0,0-.48,3.35,7.16,7.16,0,0,0,1.42,4.65,4.67,4.67,0,0,0,3.79,1.73,5.41,5.41,0,0,0,2.92-.83A6.4,6.4,0,0,0,26,23.31a8.79,8.79,0,0,0,.85-2.25,11.53,11.53,0,0,0,.29-2.63,7.29,7.29,0,0,0-1.4-4.67A4.56,4.56,0,0,0,22,12Zm3.08,6.48A6.82,6.82,0,0,1,24,22.6a3.54,3.54,0,0,1-3,1.58,2.8,2.8,0,0,1-2.32-1.12,4.82,4.82,0,0,1-.87-3A6.86,6.86,0,0,1,19,15.91a3.54,3.54,0,0,1,3-1.58,2.8,2.8,0,0,1,2.33,1.11A4.87,4.87,0,0,1,25.12,18.48Z" transform="translate(0 0.75)"/><polygon fill="#fff" points="28.55 13.02 28.17 15.44 30.54 15.44 28.73 26.96 30.78 26.96 32.58 15.44 34.85 15.44 35.23 13.02 28.55 13.02"/></g>
							</g>
	                    	<g id="svg_ZPi">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M19.79,33.27l.34-1.81,7.75-8.85h-6l.3-1.6h8l-.34,1.73L22.2,31.63h6.15l-.46,1.64Zm19-2.78H37.37c-.07.28-.1.38-.13.54-.32,1.57-.45,1.64-.79,3.24-.08.36-.41,1.85,0,2a1.59,1.59,0,0,0,.76.12,1.14,1.14,0,0,0,.46-.14l-.19,1a.08.08,0,0,1,0,0l0,0c-.87.13-2.15,0-2.33-1.09a6.9,6.9,0,0,1,.14-2.3c.13-.74.34-1.47.52-2.2l.32-1.21H33.62L32.1,37.4H30.79l1.31-6.91a.8.8,0,0,0-.63.25,1.35,1.35,0,0,0-.3.76H29.82a5.62,5.62,0,0,1,.1-.57,2.87,2.87,0,0,1,.24-.58,1.72,1.72,0,0,1,.76-.78,3.47,3.47,0,0,1,1.54-.27l4.62,0H39Zm0,0" transform="translate(-9.4 -9.2)"/></g>
							</g>
	                    	<g id="svg_XPi2">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M-614.14-75.43l-6.07,7.1h-2.91l7.89-9L-619.35-86h2.79l3.16,6.73,6.07-6.73h3l-7.83,8.86,4.31,8.8h-2.91Zm0,0" transform="translate(633.71 97.19)"/></g>
							</g>
	                    	<g id="svg_YPi2">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M24.67,37.59l1.09-6.08L22.54,19.9h2.67l2.37,8.75,5.77-8.75h2.86L28.5,31.57l-1.28,6.08Zm0,0" transform="translate(-9.38 -8.71)"/></g>
							</g>
	                    	<g id="svg_ZPi2">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M20.7,37.57,21.19,35l10.92-12.8H23.67l.42-2.31H35.57l-.49,2.49L24.16,35.2H33l-.42,2.37Zm0,0" transform="translate(-8.13 -8.71)"/></g>
							</g>
	                    	<g id="svg_CNOT">
								<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.91 -8.97)"/><path fill="#fff" d="M37.14,28.44H30V20.73a.8.8,0,0,0-1.59,0v7.71H20.67a.8.8,0,0,0,0,1.59h7.71V37.2a.8.8,0,0,0,1.59,0V30h7.17a.8.8,0,0,0,0-1.59Zm0,0" transform="translate(-8.91 -8.97)"/></g>
							</g>
	                    	<g id="svg_iSWAP">
								<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M29.5,28.62" transform="translate(-9.5 -8.62)"/><path fill="#fff" d="M36.69,20,29.5,27.22,22.3,20a1,1,0,0,0-1.4,1.4l7.19,7.19L20.9,35.82a1,1,0,1,0,1.4,1.4L29.5,30l7.19,7.19a1,1,0,0,0,1.4-1.4L30.9,28.63l7.19-7.19a1,1,0,1,0-1.4-1.4Zm0,0" transform="translate(-9.5 -8.62)"/></g>
							</g>
	                    	<g id="svg_Toffoli">
								<g><rect fill="#f4ba19" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.91 -8.97)"/><path fill="#fff" d="M37.14,28.44H30V20.73a.8.8,0,0,0-1.59,0v7.71H20.67a.8.8,0,0,0,0,1.59h7.71V37.2a.8.8,0,0,0,1.59,0V30h7.17a.8.8,0,0,0,0-1.59Zm0,0" transform="translate(-8.91 -8.97)"/></g>
							</g>
	                    	<g id="svg_Measure">
								<g><rect fill="#eb6666" width="40" height="40"/><path fill="#fff" d="M31,26.6l.41-1.24.93.31-.62-3.06L29.34,24.7l1,.31-.5,1.52h-.48c-6.13,0-11.1,3.33-11.1,7.42H20c0-3.19,4.2-5.81,9.33-5.82L27.38,34l1.15,0,1.92-5.78c4.63.35,8.26,2.81,8.26,5.78h1.73c0-3.72-4.11-6.81-9.47-7.34Zm0,0" transform="translate(-9.34 -8.29)"/></g>
							</g>
	                    	<g id="svg_RX">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M31,33.8a13.72,13.72,0,0,1,.36-2.88c.63-2.83,2.11-5.26,4.5-5.26s2.83,1.53,2.83,3.69a12.1,12.1,0,0,1-.22,2.38c-.63,3.33-2,5.89-4.5,5.89s-3-1.3-3-3.82ZM32.57,32a11.25,11.25,0,0,0,0,1.93c0,1.75.67,2.7,1.71,2.7s2.43-1.89,2.92-4.5Zm4.5-1a11.14,11.14,0,0,0,0-1.71c0-1.48-.54-2.56-1.66-2.56S33,28.72,33,31Zm0,0" transform="translate(-8.66 -8.82)"/><polygon fill="#fff" points="16.57 19.02 12.25 24.23 9.93 24.23 15.81 17.55 12.87 11.2 14.93 11.2 17.16 16.17 21.36 11.2 23.63 11.2 18.01 17.76 21.19 24.23 19.04 24.23 16.57 19.02"/><path fill="#606060" d="M37.66,30.81" transform="translate(-8.66 -8.82)"/></g>
							</g>
	                    	<g id="svg_RY">
								<g><rect fill="#22A5DE" width="40" height="40"/><path fill="#fff" d="M23.14,34.07l.77-4.29-2.27-8.19h1.89l1.67,6.18,4.07-6.18h2L25.8,29.83l-.9,4.29Zm7.89.69A13.08,13.08,0,0,1,31.37,32c.6-2.7,2-5,4.29-5s2.7,1.46,2.7,3.52a11.53,11.53,0,0,1-.21,2.27c-.6,3.17-1.93,5.62-4.29,5.62S31,37.16,31,34.76ZM32.49,33a10.72,10.72,0,0,0,0,1.84c0,1.67.64,2.57,1.63,2.57s2.32-1.8,2.79-4.29Zm4.29-1a10.63,10.63,0,0,0,0-1.63c0-1.42-.51-2.44-1.59-2.44s-2.32,1.93-2.32,4.07Zm0,0" transform="translate(-10 -10)"/></g>
							</g>
	                    	<g id="svg_RZ">
								<g><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M18.94,33.34l.37-2,8.52-9.72H21.21l.32-1.76h8.75l-.37,1.9-8.33,9.77h6.76l-.51,1.81Zm11.53.74a14.12,14.12,0,0,1,.37-3c.65-2.92,2.18-5.42,4.63-5.42s2.92,1.57,2.92,3.8A12.46,12.46,0,0,1,38.16,32C37.51,35.38,36.07,38,33.53,38s-3.06-1.34-3.06-3.94ZM32,32.23a11.58,11.58,0,0,0,0,2C32,36,32.74,37,33.8,37s2.5-1.94,3-4.63Zm4.63-1.06a11.47,11.47,0,0,0,0-1.76c0-1.53-.56-2.64-1.71-2.64s-2.5,2.08-2.5,4.4Zm0,0" transform="translate(-8.66 -8.95)"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.66 -8.95)"/></g>
							</g>
                    		<g id="svg_CR">
								<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#fff" d="M18.56,22.51h2.09a6.27,6.27,0,0,1-2.38,2.65,6.54,6.54,0,0,1-3.48.93,6.33,6.33,0,0,1-2-.3,5.08,5.08,0,0,1-1.62-.88,5.21,5.21,0,0,1-1.48-1.87,5.45,5.45,0,0,1-.52-2.35,7,7,0,0,1,2-4.88,6.07,6.07,0,0,1,2.08-1.42,6.53,6.53,0,0,1,2.53-.5A5.84,5.84,0,0,1,19.31,15a5.24,5.24,0,0,1,2,3H19.38A3.75,3.75,0,0,0,18,16.14a4,4,0,0,0-2.27-.64,4.33,4.33,0,0,0-1.75.36,4.71,4.71,0,0,0-1.49,1,5.16,5.16,0,0,0-1,1.66A5.21,5.21,0,0,0,11,20.5a4,4,0,0,0,1.05,2.86,3.52,3.52,0,0,0,2.68,1.12A4.68,4.68,0,0,0,17,24,4.18,4.18,0,0,0,18.56,22.51Z" transform="translate(0.16 0)"/><path fill="#fff" d="M20.64,25.87,21,24.15l7.26-8.48H22.62l.3-1.53h7.57l-.31,1.65-7.26,8.51h5.87l-.3,1.57Z" transform="translate(0.16 0)"/></g>
							</g>
								<!--<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#fff" d="M18.94,33.34l.37-2,8.52-9.72H21.21l.32-1.76h8.75l-.37,1.9-8.33,9.77h6.76l-.51,1.81Zm11.53.74a14.12,14.12,0,0,1,.37-3c.65-2.92,2.18-5.42,4.63-5.42s2.92,1.57,2.92,3.8A12.46,12.46,0,0,1,38.16,32C37.51,35.38,36.07,38,33.53,38s-3.06-1.34-3.06-3.94ZM32,32.23a11.58,11.58,0,0,0,0,2C32,36,32.74,37,33.8,37s2.5-1.94,3-4.63Zm4.63-1.06a11.47,11.47,0,0,0,0-1.76c0-1.53-.56-2.64-1.71-2.64s-2.5,2.08-2.5,4.4Zm0,0" transform="translate(-8.66 -8.95)"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.66 -8.95)"/></g>-->
						</svg>
                    	</div>
                    	</div>
                    <div class="case-bottom">
                    	
                        <div id="qcodeSvgContainer" style="display:none;float:left;">
                        </div>
                    </div>
                        </div>
                    <div class="case-bottom-right">
                        <div class="bs-callout bs-callout-info">
                            <h4><@spring.message code="set_argument" /></h4>
                        </div>
                        <div class="gran-text" id="commandTip" style="display:none;">
                            
                        </div>
                        <div class="t-p-10" style="display:none;">
                        	<label><@spring.message code="expression" />：</label>
                        	<textarea class="form-control" id="property"></textarea><font color="red">*</font>
                        </div>
                        <div class="t-p-10" style="display:none;">
                        	<label><@spring.message code="classical_register" />：</label>
                        	<select id="classicName" style="width:100px;">
                        	<#list 1..qcodeProject.classicalbitNum!10 as i>
                        	<option value="$${i-1}" >$${i-1}</option>
                        	</#list>
                        	</select>
                        </div>
                        <div class="t-p-10" style="display:none;">
                        	<label><@spring.message code="operating_gate" />：</label>
                        	<select id="iswap" style="width:100px;">
                        		<option value="iSWAP" >iSWAP</option>
                        		<option value="sqiSWAP" >&radic;iSWAP</option>
                        	</select>
                        </div>
                        <div class="t-p-10">
                            <input type="submit" class="btn btn-info" id="saveProperty" value="<@spring.message code='save' />" style="display:none;">
                        </div>
                    </div>
                    </div>
                </div>
                <div class="pr-box none" >
                	<p style="padding-left:10px;color:red;">使用“%”修饰的为注释代码，转为图形后自动取消</p>
                	<div id="qcodeTextarea" style="padding:0 10px;">
                	</div>
                </div>
                <div class="pr-box none" style="padding: 20px;min-height:300px;">
                	<#-- <#if lang?? && lang?string=="en_US">
                		${qcodeProject.descEnglish!'No introduction'}
                	<#else>
                		${qcodeProject.desc!'暂无介绍'}
                	</#if> -->
                	<div id="projectDesc" style="height:240px;">
	                	<#if qcodeProject.desc??&&qcodeProject.desc!=''>
	                		${qcodeProject.desc!}
	                	<#else>
		                	<p style="line-height:40px;font-size:16px;"><strong><@spring.message code="quantum_virtual_machine" /></strong></p>
		                	<p style="line-height:40px;font-size:16px;"><strong><@spring.message code="qemulator_1" /></strong></p>
		                	<p style="line-height:40px;font-size:16px;"><strong><@spring.message code="qemulator_2" /></strong></p>
		                	<p style="line-height:40px;font-size:16px;"><strong><@spring.message code="qemulator_3" /></strong></p>
		                	<p style="line-height:40px;font-size:16px;"><strong><@spring.message code="qemulator_4" /></strong></p> 
	                	</#if>            		
                	</div>
                	<!-- 项目描述信息 -->
                	
                	<!-- 教程案例 -->
                	<div class="form-group" style="padding-top:8%;">
                        <div class="col-sm-12">
                        	<a href="${base}/QCode/index.html?projectId=257" style="cursor:pointer;" target="_blank">
	                        	<div class="col-sm-2" style="width:200px;height:60px;color:white;text-align:center;padding-top:10px;background-color:#0F4C8A;">
					        		<@spring.message code="tutorial_case_one_demonstration"/>
					        	</div> 
				        	</a>  
                        	<a href="${base}/QCode/index.html?projectId=258" style="cursor:pointer;" target="_blank">
					        	<div class="col-sm-2" style="width:200px;height:60px;color:white;text-align:center;margin-left:20px;padding-top:10px;background-color:#0F4C8A;cursor:pointer;">
					        		<@spring.message code="tutorial_case_two_algorithm"/>
					        	</div>  
				        	</a>                           
                        </div>
                    </div>   
                        
                </div>
            </div>
        </div>
        <!--tabend-->
</div>
<!--box end-->
</div>

</div>

<!-- Modal运算结果 -->
<div class="modal fade" id="myModa2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="width:80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2"><@spring.message code="measurement" /></h4>
            </div>
            <div class="modal-body" id="taskResult">          
            </div>
            <div class="zxjg">
                <ul>
                    <li id="startTime"><@spring.message code="execution_time" />：</li>
                    <li id="endTime"><@spring.message code="finish_time" />：</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 提示保存 -->
<div class="modal fade" id="myModa5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe7"><@spring.message code="info" /></h4>
            </div>
            <div class="modal-body">
               	 <@spring.message code="isContinue" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message code="close" /></button>
                <button type="button" class="btn btn-primary"><@spring.message code="save" /></button>
            </div>
        </div>
    </div>
</div>
<!--遮罩-->
<div class="loading none">
    <div class='loader'>
        <div class='loading-square'></div>
        <div class='loading-square'></div>
        <div class='loading-square'></div>
        <div class='loading-square'></div>
    </div>
    <div class="text-center" style="position: absolute;bottom:20px;width:100%;"><@spring.message code="switching_version" /></div>
</div>
<div class="loading-bg"></div>
</#escape>
</@main.body>
<@main.footer>
<script>
var qubitNum = ${(qcodeProject.qubitNum)?default(6)};
var classicalbitNum = ${(qcodeProject.classicalbitNum)?default(6)};
var base = "${base!''}";
fromAdmin = "${fromAdmin!''}";
var trans2CodeStatus = 0;//0：表示转换未完成，1：表示转换完成

//模拟类型 默认Monte-Carlo类型
var analogType = ${(qcodeProject.analogType)?default(0)};

var interval;
$(document).ready(function(){
    $(".dmhj_but").click(function () {
        if($('.dmhj').is(':hidden'))
        {
            $('.dmhj').slideDown('slow');
        }else{
            $('.dmhj').slideUp('slow');
        }
    });
    $("#semi").val(1);
    $("#typeId").val(1);
    //下一步选择切换
    /*$('.zi-left').click(function () {
        $(this).addClass('bbr').siblings().removeClass('bbr')
        $(this).children("span").show().parent().siblings('.zi-left').children("span").hide();
        $("#typeId").val($(this).attr('taskType'));
    });*/
    $('.f-jiaocheng ul li').click(function () {
        $(this).addClass('bbr').siblings().removeClass('bbr')
        $(this).children("span").show().parent().siblings('.f-jiaocheng ul li').children("span").hide();
        $("#semi").val($(this).attr('semi'));
    });    
    //头部点击按钮切换
    if($("#projectId").val()==257){
        $("#jc2").removeClass('jc-but')
        $("#jc1").addClass('jc-but')
    }else{
        $("#jc1").removeClass('jc-but')
        $("#jc2").addClass('jc-but')
    }

    $("#flag").val(0);
    //初始化svg操作板
    svgBoard(qubitNum, 50, classicalbitNum, '$');
    $("#classicName").select2({
        language : 'zh-CN'
    });
    $("#iswap").select2({
        language : 'zh-CN'
    });
        $('.showone').click(function () {
            $(".first").show();
            $(".second").hide();
            $(".there").hide();
            $(".four").hide();
        });
        $('.daima').click(function () {
            $(".case-bottom").getNiceScroll().resize();
        });
        //遮罩
        $('.moda').click(function () {
            $('.loading-bg').show();
            $('.loading').show();
            setTimeout("$('.loading').hide()",5000);
            setTimeout("$('.loading-bg').hide()",5000);
        });

        $('#myModal').modal({
            backdrop: 'static',
            show:false
        });
        $('#myModa2').modal({
            backdrop: 'static',
            show:false
        });
        $('#myModa3').modal({
            backdrop: 'static',
            show:false
        });
        $('#myModa4').modal({
            backdrop: 'static',
            show:false
        });
        changeCode();

        $('script[data-url]').each(function() {
            var _this = $(this),
                    url = _this.attr('data-url');
            _this.attr('src',url);
        });
});

function makeChart (name) {

    var main = document.getElementById(name);
    var div = document.createElement('div');
    var width = document.body.clientWidth;
    div.style.cssText = width + 'px; height:400px';
    if ($("#"+name+":has(div)").length<2){
        $("#"+name+"").html("");
        main.appendChild(div);
    }    
    return echarts.init(div);
}

//展示运行结果数据
function showData(taskId) {
    
    $("#taskResult").empty();
    $('#myModa2').modal('show');
    var param = {};
    param.id = taskId;
    $.ajax({
        url: "${base}/QCode/getTaskData.json",
        data: param,
        cache: false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
        type: 'post',
        success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var task = result.obj;
                    var ans = JSON.parse(task.ans);
                    var keyArray = ans.key;
                    var valueArray = ans.value;
                    setTimeout(function () {
                    //加载图表  
                    var myChart = makeChart("taskResult");
                    //参数设置
                    var option;
                    if(keyArray.ansLength>30){
                            option = {
                                            color: ['#3398DB'],
                                            tooltip: {
                                                trigger: 'axis',
                                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                                }
                                            },
                                            grid: {
                                                left: '3%',
                                                right: '4%',
                                                bottom: '10%',
                                                containLabel: true
                                            },
                                            xAxis: [{
                                                type: 'category',
                                                data: keyArray,
                                                name: messages.celiangzhi,
                                                nameLocation: "middle",
                                                nameGap: 35,
                                                axisTick: {
                                                    alignWithLabel: true
                                                }
                                            }],
                                            dataZoom: [
                                                {
                                                    show: true,
                                                    startValue: 0,
                                                    endValue: 30
                                                }
                                            ],
                                            yAxis: [{
                                                type: 'value',
                                                name: messages.gailv
                                            }],
                                            series: [{
                                                name: messages.gailv,
                                                type: 'bar',
                                                barWidth: '30',
                                                data: valueArray
                                            }]
                                        };                    
                    }else{
                            option = {
                                        color: ['#3398DB'],
                                        tooltip: {
                                            trigger: 'axis',
                                            axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                            }
                                        },
                                        grid: {
                                            left: '3%',
                                            right: '4%',
                                            bottom: '10%',
                                            containLabel: true
                                        },
                                        xAxis: [{
                                            type: 'category',
                                            data: keyArray,
                                            name: messages.celiangzhi,
                                            nameLocation: "middle",
                                            nameGap: 35,
                                            axisTick: {
                                                alignWithLabel: true
                                            }
                                        }],
                                        dataZoom: [
                                            {
                                                show: true,
                                                start: 0,
                                                end: 100
                                            }
                                        ],
                                        yAxis: [{
                                            type: 'value',
                                            name: messages.gailv
                                        }],
                                        series: [{
                                            name: messages.gailv,
                                            type: 'bar',
                                            barWidth: '30',
                                            data: valueArray
                                        }]
                                    };                      
                    }
                    myChart.setOption(option);
                    $("#startTime").html(messages.zhixingshijian+"：" + task.startTime);
                    $("#endTime").html(messages.end_time+"：" + task.endTime);
                    },1000);
                    
                } else {
                    errorMsg(result.message);
                }
            },
            error: function () {
                errorMsg(messages.server_is_busy);
            }
    });
}

//删除task
function delTask(id){
    if(fromAdmin!=undefined && fromAdmin=="1"){
        prompt(messages.unauthorized_operation);
        return false;
    }

    if(!isLogin()){return false;}
    if(!isCase()){return false;}
    if(!isSemi()){return false;}
     if(confirm(messages.delete_task))
     {
                //表单提交
                $.ajax({
                    url:"${base}/QCode/delTask.json",
                    data:{"id":id},
                    cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                    type:'post', 
                    success:function(result){
                        if(result.code == 401){
                            window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                            return false;
                        }
                        if(result.success){ 
                            window.location.reload(true);
                        } else {
                            errorMsg(result.message);
                        }
                    },
                    error:function(){       
                        errorMsg(messages.server_is_busy);
                    }
                });
     }  
}
//终止task
function terminateTask(id){
    if(fromAdmin!=undefined && fromAdmin=="1"){
        prompt(messages.unauthorized_operation);
        return false;
    }
    
    if(!isLogin()){return false;}
    if(!isCase()){return false;}
    if(!isSemi()){return false;}
    if(confirm(messages.terminate_task))
     {
                //表单提交
                $.ajax({
                    url:"${base}/QCode/terminateTask.json",
                    data:{"id":id},
                    cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                    type:'post', 
                    success:function(result){
                        if(result.code == 401){
                            window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                            return false;
                        }
                        if(result.success){ 
                            window.location.reload(true);
                        } else {
                            errorMsg(result.message);
                        }
                    },
                    error:function(){       
                        errorMsg(messages.server_is_busy);
                    }
                });
     }  
}

$('#myModa3').on('hide.bs.modal', function (e) {
clearInterval(interval);
});
$('#myModa2').on('hide.bs.modal', function (e) {
clearInterval(interval);
if($("#flag").val()==1){
window.location.href = "${base}/QCode/index.html?projectId="+$("#projectId").val();
//window.location.reload(true);
}       
});

function random(){
        //x上限，y下限     
        var x = 3;     
        var y = 1;     
        var tip = messages.first_click_icon;
        var rand = parseInt(Math.random() * (x - y + 1) + y);
        if(rand==1){
             tip = messages.first_click_icon;
        }
        if(rand==2){
             tip = messages.same_pro_diff_result;
        }
        if(rand==3){
             tip = messages.real_liangzi;
        }
        $("#randomValue").html(tip);
}

$('#closeBtn').click(function () {
    if(fromAdmin!=undefined && fromAdmin=="1"){
        prompt(messages.unauthorized_operation);
        return false;
    }
    
    $('#myModa3').hide();
    window.location.href = "${base}/QCode/index.html?projectId="+$("#projectId").val()+"&versionId="+$("#versionId").val();
});

$('#qubitNum').on('keyup',function(){
    var type = $("#typeId").val();
    var v = $(this).val();
    var analogType = $("#analogType").val();
    if(type==1){
        if(analogType == "1"){
            if(v!=''&&(v>32||v<1)){
                $(this).val(32);
            }
        }else{
            if(v!=''&&(v>20||v<1)){
                $(this).val(20);
            }
        }
    }
    if(type==2){
        if(v!=''&&(v>6||v<1)){
            $(this).val(6);
        } 
    }
}); 
$('#classicalbitNum').on('keyup',function(){
    var v = $(this).val();
    if(v!=''&&(v>255||v<1)){
        $(this).val(255);
    }
}); 
$("#qubitNum").blur(function(){
    var type = $("#typeId").val();
    var v = $(this).val();
    var analogType = $("#analogType").val();
    if(type==1){
        if(analogType == "1"){
            if(v!=''&&(v>32||v<1)){
                $(this).val(32);
            }
        }else{
            if(v!=''&&(v>20||v<1)){
                $(this).val(20);
            }
        }
    }
    if(type==2){
        if(v!=''&&(v>6||v<1)){
            $(this).val(6);
        }          
    }
}); 
$("#classicalbitNum").blur(function(){
    var v = $(this).val();
    if(v!=''&&(v>255||v<1)){
        $(this).val(255);
    }
}); 

function checkQubitNum(element){//模拟类型 与 量子比特数 联动
    var userLevel = '${USER_INFO.level!1}'; //用户等级
    var analogType = $("#myModal  #analogType").val();//模拟类型 
    var qubitNum = $('#myModal  #qubitNum').val();// 量子比特数
    if((qubitNum > 20) ){
        if(userLevel == '1'){
            $('#qubitNum').val(20);
        }else{
            switch(analogType){
                case "0" : {$('#qubitNum').val(20);} ;break;
                case "1" : { qubitNum >32 ?  $('#qubitNum').val(32) :'' ;};break; 
                default  : {};break;
            }
        }
    }
}

function changeCode() {
    var code = $("#code").val();
    if (code) {
        code = code.replace("CREG " + classicalbitNum, "");
        code = code.replace("QINIT " + qubitNum, "");
        code2Trans(code);
    } else {
        svgBoard(qubitNum, 50, classicalbitNum, '$');
    }
}

var tabIndex = 0;
$(function () {
    //主设计窗体切换TAB
    var $tab_li = $('#tab ul li');
    $tab_li.click(function(){
        var index = $tab_li.index(this);
        if(tabIndex == index){//当前tab下 再次点击当前页面 不做操作
            return false;
        }
        if(index == 1 && !checkGrammar()){
            return;
        }
        if(index==0){
            var result = code2Trans();
            //if(result!=false){
                $(this).addClass('selected').siblings().removeClass('selected');
                $('div.tab_box > div').eq(index).show().siblings().hide();
                tabIndex = index;
            //}
        }else if(index == 1){
            $(this).addClass('selected').siblings().removeClass('selected');
            $('div.tab_box > div').eq(index).show().siblings().hide();
            trans2Code();
            tabIndex = index;
        }else{
            if(tabIndex == 1){
                var result = code2Trans();
                //if(result!=false){
                    $(this).addClass('selected').siblings().removeClass('selected');
                    $('div.tab_box > div').eq(index).show().siblings().hide();
                    tabIndex = index;
                //}
                
            }else{
                $(this).addClass('selected').siblings().removeClass('selected');
                $('div.tab_box > div').eq(index).show().siblings().hide();
                tabIndex = index;
            }
        }
        $(".case-bottom").getNiceScroll().resize();
    });
});
</script>
<script type="text/javascript" src="${base}/assets/js/code2Trans.js"></script>
<script type="text/javascript" src="${base}/assets/js/dragTrans.js"></script>
</@main.footer>
