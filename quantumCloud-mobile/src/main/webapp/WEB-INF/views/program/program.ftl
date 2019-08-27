<@main.header title="编程">
</@main.header>
<@main.body>
<section class="weui-tab" id="z_navbar">
<#if qcodeProject??>
<input type="hidden" id="projectId" value="${(qcodeProject.id)!}">
<input type="hidden" id="versionId" value="${(projectVersion.id)!}">
<input type="hidden" id="code" value='${projectVersion.code}'>
<input type="hidden" id="analogType" value="${(qcodeProject.analogType)!0}">
    <div class="weui-navbar">
        <a class="weui-navbar__item active" href="#design" id="code2Quantum">设计</a>
        <a class="weui-navbar__item" href="#q_program" id="quantum2Code">量子程序</a>
        <a class="weui-navbar__item" href="#program_info">项目介绍</a>
    </div>
    <div class="weui-tab__bd">
        <div id="design" class="weui-tab__bd-item active">
            <div class="title-box">
                <div class="pd16">
                <h1 class="f16 text-one">
                    ${(qcodeProject.name)!}
                    <#if (qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258))&&(qcodeProject.taskTypeId?? && qcodeProject.taskTypeId!=3)>#${projectVersion.name!}</#if>                  
                </h1>
                </div>
            </div>

            <div class="outer">
                <div id="scroll_box" class="float-left"  style="padding-top:24px;" >
                    <ul id="quantum">
                    </ul>
                </div>
                <div id="svg_parents" class="new-right">
                    <div id="inner_svg" class="new-rightbox" >
                    </div>
                </div>
            </div>
            <div class="button" style="bottom:0;position:fixed;width:100%;">
                <a class="working" onclick="running()"><i class="iconfont icon-bofang1"></i> 运行</a>
                <a onclick="App.openNew('${base}/QCode/setting.html?projectId=${qcodeProject.id!}&versionId=${projectVersion.id!}')" ><i class="iconfont icon-shezhi"></i> 设置</a>
                <a onclick="App.openNew('${base}/QCode/question.html')"><i class="iconfont icon-instruction"></i> 问题</a>
                <a onclick="App.openNew('${base}/QCode/revisions.html?projectId=${qcodeProject.id!}')"><i class="iconfont icon-banbenlishi"></i> 历史</a>
            </div>
        </div>
        <div id="q_program" class="weui-tab__bd-item">
            <div class="title-box">
                <p style="padding-left:10px;color:red;">使用“%”修饰的为注释代码，转为图形后自动取消</p>
                <div id="qcodeTextarea" style="padding:0 10px;">
                </div>
            </div>
        </div>
        <div id="program_info" class="weui-tab__bd-item">
            <div class="title-box">
                <div class="pd16 f14 f666">
                    <#if qcodeProject.desc??&&qcodeProject.desc!=''>
                        ${qcodeProject.desc!}
                    <#else>
                        <p style="line-height:40px;font-size:12px;">量子虚拟机</p>
                        <p style="line-height:40px;font-size:12px;">连接到服务器上的量子仿真</p>
                        <p style="line-height:40px;font-size:12px;">基于量子力学原理给出仿真结果</p>
                        <p style="line-height:40px;font-size:12px;">较自由的操作集合</p>
                        <p style="line-height:40px;font-size:12px;">量子比特最多可达32位</p>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</#if>
</section>
<!--运行中-->
<div class="overlay" id="running"></div>
<div class="loading" id="running-div">
    <span style="font-size:18px;">×</span>
    <img src="${base}/assets/images/gif.gif" />
    <p> 运行中...</p>
</div>
<!--弹出-->
<aside id="aside" class="aside">
    <i class="aside-overlay hideAside"></i>
    <div class="aside-content">
        <div class="module">
            <div class="module-header">
                <h3 class="module-title">请选择</h3>
            </div>
            <div class="module-main scrollable">

                <div class="more-list">
                    <ul>
                        <div class="mod-title">
                            <strong>单比特门</strong>
                        </div>
                        <li id="H">
                            <span>
                                <img src="${base}/assets/images/h.png" />
                            </span>
                            <p>Hadamard门</p>
                            <p class="f12 f999">H=[1 1;1 -1]/sqrt(2)</p>
                        </li>
                        <li id="RXpi">
                            <span>
                                <img src="${base}/assets/images/not.png" />
                            </span>
                            <p>非门</p>
                            <p class="f12 f999">NOT=[0 1;1 0]</p>
                        </li>
                        <li id="RZpi">
                            <span>
                                <img src="${base}/assets/images/zp.png" />
                            </span>
                            <p>相位pi门</p>
                            <p class="f12 f999">Z(pi)=[1 0;0 -1]</p>
                        </li>
                        <li id="RXpi/2">
                            <span>
                                <img src="${base}/assets/images/x.png" />
                            </span>
                            <p>X</p>
                            <p class="f12 f999">X=[1 -i;-i 1]/sqrt(2)</p>
                        </li>
                        <li id="RYpi/2">
                            <span>
                                <img src="${base}/assets/images/y.png" />
                            </span>
                            <p>Y</p>
                            <p class="f12 f999">Y=[1 -1;1 1]/sqrt(2)</p>
                        </li>
                        <li id="RZpi/2">
                            <span>
                                <img src="${base}/assets/images/z.png" />
                            </span>
                            <p>Z</p>
                            <p class="f12 f999">Z=[1 0;0 -i]</p>
                        </li>
                        <div class="mod-title">
                            <strong>多比特门</strong>
                        </div>
                        <li id="CNOT">
                            <span>
                                <img src="${base}/assets/images/lvjia.png" />
                            </span>
                            <p>CNOT门</p>
                            <p class="f12 f999"> CNOT=[I(2) 0;0 NOT]</p>
                        </li>
                        <li id="ISWAP">
                            <span style="height:84px;">
                                <img src="${base}/assets/images/lvcheng.png" />
                            </span>
                            <p>iSWAP门</p>
                            <p class="f12 f999">iSWAP=[1 0 0 0;0 -i 0 0;0 0 -i 0;0 0 0 1]</p>
                            <p>sqiSWAP门</p>
                            <p class="f12 f999">sqiSWAP=[1 0 0 0;0 1 -i 0;0 -i 1 0;0 0 0 1]</p>
                        </li>
                        <li id="TOFFOLI">
                            <span>
                                <img src="${base}/assets/images/huangjia.png" />
                            </span>
                            <p>Toffoli门</p>
                            <p class="f12 f999">Toffoli=[ I(4)  0 ; 0 CNOT]</p>
                        </li>
                        <div class="mod-title">
                            <strong>测量</strong>
                        </div>
                        <li id="PMEASURE">
                            <span>
                                <img src="${base}/assets/images/celiang.png" />
                            </span>
                            <p>输出、Measure、非破坏性测量</p>
                            <p class="f12 f999">将Qubit n的测量结果保存到经典寄存器CReg的[index]索引下</p>
                        </li>
                        <div class="mod-title">
                            <strong>高级</strong>
                        </div>
                        <li id="RX" style="height:60px;" >
                            <span>
                                <img src="${base}/assets/images/x0.png" />
                            </span>
                            <p>X任意角度旋转</p>
                            <p>RX(theta)=</p>
                            <p>[cos(theta/2) -1i*sin(theta/2);</p>
                            <p>-1i*sin(theta/2) cos(theta/2)]</p>
                        </li>
                        <li id="RY" style="height:60px;" >
                            <span>
                                <img src="${base}/assets/images/y0.png" />
                            </span>
                            <p>Y任意角度旋转</p>
                            <p>RY(theta)=</p>
                            <p>[cos(theta/2) -sin(theta/2);</p>
                            <p>sin(theta/2) cos(theta/2)]</p>
                        </li>
                        <li id="RZ">
                            <span>
                                <img src="${base}/assets/images/z0.png" />
                            </span>
                            <p>Z任意角度旋转</p>
                            <p>RZ(theta)=[1 0;0 exp(-1i*theta)]</p>
                        </li>
                        <li id="CR" style="height:66px;">
                            <span>
                                <img src="${base}/assets/images/cz.png" />
                            </span>
                            <p>两比特门、CR、控制相位门</p>
                            <p>Qubit C控制+Qubit T进行绕Z轴旋转angle角度的操作</p>
                            <p>CR=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 exp(1i*theta)]</p>
                        </li>
                        <div class="mod-title">
                            <strong>组合门</strong>
                        </div>
                        <li id="GHZ2">
                            <span>
                                <img src="${base}/assets/images/GHZ(2).png" />
                            </span>
                            <p>GHZ(2)</p>
                            <p>使2个比特构成纠缠态</p>
                        </li>
                        <li id="GHZ3">
                            <span>
                                <img src="${base}/assets/images/GHZ(3).png" />
                            </span>
                            <p>GHZ(3)</p>
                            <p>使3个比特构成纠缠态</p>
                        </li>
                        <li id="GHZ6">
                            <span>
                                <img src="${base}/assets/images/GHZ(6).png" />
                            </span>
                            <p>GHZ(6)</p>
                            <p>使6个比特构成最大纠缠态</p>
                        </li>
                        <li id="QFT3">
                            <span>
                                <img src="${base}/assets/images/QFT(3).png" />
                            </span>
                            <p>QFT(3)</p>
                            <p>三量子比特的量子傅里叶变换</p>
                        </li>
                        <li id="QFT4">
                            <span>
                                <img src="${base}/assets/images/QFT(4).png" />
                            </span>
                            <p>QFT(4)</p>
                            <p>四量子比特的量子傅里叶变换</p>
                        </li>
                        <li id="CZ">
                            <span>
                                <img src="${base}/assets/images/CZ(6).png" />
                            </span>
                            <p>CZ</p>
                            <p>控制Z门</p>
                        </li>
                        <li id="z_CNOT">
                            <span>
                                <img src="${base}/assets/images/z-CNOT.png" />
                            </span>
                            <p>z-CNOT</p>
                            <p>0-控制非门</p>
                        </li>
                        <li id="SWAP">
                            <span>
                                <img src="${base}/assets/images/SWAP.png" />
                            </span>
                            <p>SWAP</p>
                            <p>交换门</p>
                        </li>
                        <li id="H6">
                            <span>
                                <img src="${base}/assets/images/H(6).png" />
                            </span>
                            <p>H(6)</p>
                            <p>6比特叠加态的制备</p>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</aside>
<!--底部弹出-->
<aside id="aside_div" class="aside">
    <i class="aside-overlay hideAside"></i>
    <div class="aside-content-div" style="height:300px;">
        <div class="module module-filter-list">
            <div class="module-header">
                <h3 class="module-title">参数设置</h3>
            </div>
            <div class="module-main scrollable">
                <span class="little-text">请输入一个数学表达式，可以包括pi，不包含括号，运算符包括"+-*/^."(弧度制)
                </span>

                <div class="weui-cells weui-cells_form">

                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">表达式</label></div>
                        <div class="weui-cell__bd">
                            <input id="parameter" class="weui-input text-r" type="text" placeholder="参数必填" value="pi/4">
                        </div>
                    </div>

                </div>

            </div>
            <div class="module-footer">
                <nav class="btn-group">
                    <div class="btn-group-cell btn-reset hideAside"><a href="javascript:">取消</a></div>
                    <div class="btn-group-cell btn-submit"><a href="javascript:" id="saveParameter">完成</a></div>
                </nav>
            </div>
        </div>
    </div>
</aside>

<!--底部弹出-->
<aside id="measure" class="aside">
    <i class="aside-overlay hideAside"></i>
    <div class="aside-content-div" style="height:300px;">
        <div class="module module-filter-list">
            <div class="module-header">
                <h3 class="module-title">参数设置</h3>
            </div>
            <span class="little-text" style="position: absolute;left: 0;top:45px;font-size: 12px;width: 100%;box-sizing: border-box;">将Qubit的测量结果保存到经典寄存器上，请输入经典比特序号
            </span>
            <div class="module-main scrollable" style="top:108px;">
                <div class="express express_div">
                    <input type="hidden" id="qubit">
                    <ul id="measureQub">
                    </ul>
                </div>

            </div>
            <div class="module-footer">
                <nav class="btn-group">
                    <div class="btn-group-cell btn-reset"><a href="javascript:" id="cancel">取消</a></div>
                    <div class="btn-group-cell btn-submit"><a href="javascript:" id="saveQubit">完成</a></div>
                </nav>
            </div>
        </div>
    </div>
</aside>
    <div style="display:none;">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40">

            <g id="svg_H"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M21.09,37.55l3.43-17.73h2.57l-1.43,7.53h7.15l1.48-7.53h2.57L33.43,37.55H30.86l1.48-7.77H25l-1.38,7.77Zm0,0" transform="translate(-8.97 -8.69)"/></g>

            <g id="svg_NOT"><rect fill="#22a5de" width="40" height="40"/><polygon fill="#fff" points="13.85 13.02 12.29 22.93 9.49 13.02 6.97 13.02 4.77 26.96 6.82 26.96 8.42 16.73 11.3 26.96 13.72 26.96 15.9 13.02 13.85 13.02"/><path fill="#fff" d="M22,12a5.56,5.56,0,0,0-2.44.54,6,6,0,0,0-2,1.59,7.65,7.65,0,0,0-1.4,2.63,11.21,11.21,0,0,0-.48,3.35,7.16,7.16,0,0,0,1.42,4.65,4.67,4.67,0,0,0,3.79,1.73,5.41,5.41,0,0,0,2.92-.83A6.4,6.4,0,0,0,26,23.31a8.79,8.79,0,0,0,.85-2.25,11.53,11.53,0,0,0,.29-2.63,7.29,7.29,0,0,0-1.4-4.67A4.56,4.56,0,0,0,22,12Zm3.08,6.48A6.82,6.82,0,0,1,24,22.6a3.54,3.54,0,0,1-3,1.58,2.8,2.8,0,0,1-2.32-1.12,4.82,4.82,0,0,1-.87-3A6.86,6.86,0,0,1,19,15.91a3.54,3.54,0,0,1,3-1.58,2.8,2.8,0,0,1,2.33,1.11A4.87,4.87,0,0,1,25.12,18.48Z" transform="translate(0 0.75)"/><polygon fill="#fff" points="28.55 13.02 28.17 15.44 30.54 15.44 28.73 26.96 30.78 26.96 32.58 15.44 34.85 15.44 35.23 13.02 28.55 13.02"/></g>

            <g id="svg_ZPi"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M19.79,33.27l.34-1.81,7.75-8.85h-6l.3-1.6h8l-.34,1.73L22.2,31.63h6.15l-.46,1.64Zm19-2.78H37.37c-.07.28-.1.38-.13.54-.32,1.57-.45,1.64-.79,3.24-.08.36-.41,1.85,0,2a1.59,1.59,0,0,0,.76.12,1.14,1.14,0,0,0,.46-.14l-.19,1a.08.08,0,0,1,0,0l0,0c-.87.13-2.15,0-2.33-1.09a6.9,6.9,0,0,1,.14-2.3c.13-.74.34-1.47.52-2.2l.32-1.21H33.62L32.1,37.4H30.79l1.31-6.91a.8.8,0,0,0-.63.25,1.35,1.35,0,0,0-.3.76H29.82a5.62,5.62,0,0,1,.1-.57,2.87,2.87,0,0,1,.24-.58,1.72,1.72,0,0,1,.76-.78,3.47,3.47,0,0,1,1.54-.27l4.62,0H39Zm0,0" transform="translate(-9.4 -9.2)"/></g>

            <g id="svg_XPi2"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M-614.14-75.43l-6.07,7.1h-2.91l7.89-9L-619.35-86h2.79l3.16,6.73,6.07-6.73h3l-7.83,8.86,4.31,8.8h-2.91Zm0,0" transform="translate(633.71 97.19)"/></g>

            <g id="svg_YPi2"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M24.67,37.59l1.09-6.08L22.54,19.9h2.67l2.37,8.75,5.77-8.75h2.86L28.5,31.57l-1.28,6.08Zm0,0" transform="translate(-9.38 -8.71)"/></g>

            <g id="svg_ZPi2"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M20.7,37.57,21.19,35l10.92-12.8H23.67l.42-2.31H35.57l-.49,2.49L24.16,35.2H33l-.42,2.37Zm0,0" transform="translate(-8.13 -8.71)"/></g>

            <g id="svg_CNOT"><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.91 -8.97)"/><path fill="#fff" d="M37.14,28.44H30V20.73a.8.8,0,0,0-1.59,0v7.71H20.67a.8.8,0,0,0,0,1.59h7.71V37.2a.8.8,0,0,0,1.59,0V30h7.17a.8.8,0,0,0,0-1.59Zm0,0" transform="translate(-8.91 -8.97)"/></g>

            <g id="svg_iSWAP"><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M29.5,28.62" transform="translate(-9.5 -8.62)"/><path fill="#fff" d="M36.69,20,29.5,27.22,22.3,20a1,1,0,0,0-1.4,1.4l7.19,7.19L20.9,35.82a1,1,0,1,0,1.4,1.4L29.5,30l7.19,7.19a1,1,0,0,0,1.4-1.4L30.9,28.63l7.19-7.19a1,1,0,1,0-1.4-1.4Zm0,0" transform="translate(-9.5 -8.62)"/></g>

            <g id="svg_Toffoli"><rect fill="#f4ba19" width="40" height="40" rx="20" ry="20"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.91 -8.97)"/><path fill="#fff" d="M37.14,28.44H30V20.73a.8.8,0,0,0-1.59,0v7.71H20.67a.8.8,0,0,0,0,1.59h7.71V37.2a.8.8,0,0,0,1.59,0V30h7.17a.8.8,0,0,0,0-1.59Zm0,0" transform="translate(-8.91 -8.97)"/></g>

            <g id="svg_Measure"><rect fill="#eb6666" width="40" height="40"/><path fill="#fff" d="M31,26.6l.41-1.24.93.31-.62-3.06L29.34,24.7l1,.31-.5,1.52h-.48c-6.13,0-11.1,3.33-11.1,7.42H20c0-3.19,4.2-5.81,9.33-5.82L27.38,34l1.15,0,1.92-5.78c4.63.35,8.26,2.81,8.26,5.78h1.73c0-3.72-4.11-6.81-9.47-7.34Zm0,0" transform="translate(-9.34 -8.29)"/></g>

            <g id="svg_RX"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M31,33.8a13.72,13.72,0,0,1,.36-2.88c.63-2.83,2.11-5.26,4.5-5.26s2.83,1.53,2.83,3.69a12.1,12.1,0,0,1-.22,2.38c-.63,3.33-2,5.89-4.5,5.89s-3-1.3-3-3.82ZM32.57,32a11.25,11.25,0,0,0,0,1.93c0,1.75.67,2.7,1.71,2.7s2.43-1.89,2.92-4.5Zm4.5-1a11.14,11.14,0,0,0,0-1.71c0-1.48-.54-2.56-1.66-2.56S33,28.72,33,31Zm0,0" transform="translate(-8.66 -8.82)"/><polygon fill="#fff" points="16.57 19.02 12.25 24.23 9.93 24.23 15.81 17.55 12.87 11.2 14.93 11.2 17.16 16.17 21.36 11.2 23.63 11.2 18.01 17.76 21.19 24.23 19.04 24.23 16.57 19.02"/><path fill="#606060" d="M37.66,30.81" transform="translate(-8.66 -8.82)"/></g>

            <g id="svg_RY"><rect fill="#22A5DE" width="40" height="40"/><path fill="#fff" d="M23.14,34.07l.77-4.29-2.27-8.19h1.89l1.67,6.18,4.07-6.18h2L25.8,29.83l-.9,4.29Zm7.89.69A13.08,13.08,0,0,1,31.37,32c.6-2.7,2-5,4.29-5s2.7,1.46,2.7,3.52a11.53,11.53,0,0,1-.21,2.27c-.6,3.17-1.93,5.62-4.29,5.62S31,37.16,31,34.76ZM32.49,33a10.72,10.72,0,0,0,0,1.84c0,1.67.64,2.57,1.63,2.57s2.32-1.8,2.79-4.29Zm4.29-1a10.63,10.63,0,0,0,0-1.63c0-1.42-.51-2.44-1.59-2.44s-2.32,1.93-2.32,4.07Zm0,0" transform="translate(-10 -10)"/></g>

            <g id="svg_RZ"><rect fill="#22a5de" width="40" height="40"/><path fill="#fff" d="M18.94,33.34l.37-2,8.52-9.72H21.21l.32-1.76h8.75l-.37,1.9-8.33,9.77h6.76l-.51,1.81Zm11.53.74a14.12,14.12,0,0,1,.37-3c.65-2.92,2.18-5.42,4.63-5.42s2.92,1.57,2.92,3.8A12.46,12.46,0,0,1,38.16,32C37.51,35.38,36.07,38,33.53,38s-3.06-1.34-3.06-3.94ZM32,32.23a11.58,11.58,0,0,0,0,2C32,36,32.74,37,33.8,37s2.5-1.94,3-4.63Zm4.63-1.06a11.47,11.47,0,0,0,0-1.76c0-1.53-.56-2.64-1.71-2.64s-2.5,2.08-2.5,4.4Zm0,0" transform="translate(-8.66 -8.95)"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.66 -8.95)"/></g>

            <g id="svg_CR"><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#fff" d="M18.56,22.51h2.09a6.27,6.27,0,0,1-2.38,2.65,6.54,6.54,0,0,1-3.48.93,6.33,6.33,0,0,1-2-.3,5.08,5.08,0,0,1-1.62-.88,5.21,5.21,0,0,1-1.48-1.87,5.45,5.45,0,0,1-.52-2.35,7,7,0,0,1,2-4.88,6.07,6.07,0,0,1,2.08-1.42,6.53,6.53,0,0,1,2.53-.5A5.84,5.84,0,0,1,19.31,15a5.24,5.24,0,0,1,2,3H19.38A3.75,3.75,0,0,0,18,16.14a4,4,0,0,0-2.27-.64,4.33,4.33,0,0,0-1.75.36,4.71,4.71,0,0,0-1.49,1,5.16,5.16,0,0,0-1,1.66A5.21,5.21,0,0,0,11,20.5a4,4,0,0,0,1.05,2.86,3.52,3.52,0,0,0,2.68,1.12A4.68,4.68,0,0,0,17,24,4.18,4.18,0,0,0,18.56,22.51Z" transform="translate(0.16 0)"/><path fill="#fff" d="M20.64,25.87,21,24.15l7.26-8.48H22.62l.3-1.53h7.57l-.31,1.65-7.26,8.51h5.87l-.3,1.57Z" transform="translate(0.16 0)"/></g>
            <!--<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#fff" d="M18.94,33.34l.37-2,8.52-9.72H21.21l.32-1.76h8.75l-.37,1.9-8.33,9.77h6.76l-.51,1.81Zm11.53.74a14.12,14.12,0,0,1,.37-3c.65-2.92,2.18-5.42,4.63-5.42s2.92,1.57,2.92,3.8A12.46,12.46,0,0,1,38.16,32C37.51,35.38,36.07,38,33.53,38s-3.06-1.34-3.06-3.94ZM32,32.23a11.58,11.58,0,0,0,0,2C32,36,32.74,37,33.8,37s2.5-1.94,3-4.63Zm4.63-1.06a11.47,11.47,0,0,0,0-1.76c0-1.53-.56-2.64-1.71-2.64s-2.5,2.08-2.5,4.4Zm0,0" transform="translate(-8.66 -8.95)"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.66 -8.95)"/></g>-->
        </svg>
    </div>
    <div class="overlay" id="result"></div>
    <div class="loading" id="result-div" style="width:100%;height: 350px;margin-top: -175px;margin-left: 0;border-radius: 0;left: 0;">
        <span style="font-size:18px;">×</span>
        <h2 style="border-bottom: 1px solid #ddd;font-size: 14px;text-align: left;padding-left: 18px;height: 40px;line-height: 40px;color: #333;">测试结果</h2>
        <div id="taskResult">
        </div>
        <div style="border-top: 1px solid #ddd;padding-top: 16px;color: #999;">
            <div id="startTime"></div>
            <div id="endTime"></div>
        </div>
    </div>
</@main.body>
<@main.footer>
<script src="${base}/assets/views/js/program/program-1.0.min.js"></script>
<script>
var qubitNum = ${(qcodeProject.qubitNum)?default(6)};
var classicalbitNum = ${(qcodeProject.classicalbitNum)?default(6)};

var svgBoard;

    //编程左侧小滚动条
    $(function() {
        //适配窗口
        $(".outer").height(window.innerHeight - 170);
        $(".float-left").height(window.innerHeight - 170);
        $(".new-right").height(window.innerHeight - 170);

        $(".loading>span").click(function () {
            $(".overlay").hide();
            $(".loading").hide();
            clearInterval(window.selectTimer);
            //window.location.reload();
            var projectId = $("#projectId").val();
            location.href = "${base}/QCode/index.html?versionId=&projectId=" + projectId;
        });
        var leftScroll = $("#scroll_box");
        var rightScroll = $("#svg_parents");
        /*leftScroll.scroll(function() {
            var top = parseInt($(this).scrollTop());
            var maxTop = $("#quantum").height() - $(this).height();
            if (top > maxTop) {
                $(this).scrollTop(maxTop);
                return;
            }
            $(this).scrollTop(top);
            rightScroll.scrollTop(top);
        });*/
        rightScroll.scroll(function () {
            var top = parseInt(rightScroll.scrollTop());
            var maxTop = $("#quantum").height() - $(this).height() ;
            if (top > maxTop) {
                $(this).scrollTop(maxTop);
                return;
            }
            $(this).scrollTop(top);
            leftScroll.scrollTop(top);
        });
    });
    
    $(window).resize(function(){
        //适配窗口
        $(".outer").height(window.innerHeight - 170);
        $(".float-left").height(window.innerHeight - 170);
        $(".new-right").height(window.innerHeight - 170);
    });
    
    //编程弹出
    $(function() {
        App.setTitle("编程");
        App.setTopMenu([{name:"保存",icon:"${base}/assets/images/save.png",callback:"save()"}]);
        
        //弹出
        var elAside = $('#aside');

        $('.hideAside').on('click', function () {
            $('html').removeClass('noscroll');
            elAside.removeClass('active');
        });
        $('.more-list li').on('click', function () {
            $('html').removeClass('noscroll');
            elAside.removeClass('active');
        });
    });

    $(function() {
        //初始化q[0]和&nbsp;|0〉
        var $quantum = $("#quantum");
        var $measureQub = $("#measureQub");
        for (var i = 0; i < qubitNum; i++) {
            //var $li = $("<li><span class='r-border'>q[" + i + "]|" + 0 + "〉</span></li>");
            var $li = $("<li>q[" + i + "]&nbsp;|" + 0 + "〉</li>");
            
            $quantum.append($li);
            
            var $qub = $("<li class='weui-cell_access' value='$" + i +"'></li>");
            $qub.on("click", function() {
                $("#measureQub i").each(function(){
                    $(this).remove();
                });
                $(this).append("<i class='iconfont icon-duihao'></i>");
                $("#qubit").val($(this).attr("value"));
            });
            $qub.html("$" + i);
            $measureQub.append($qub);
        }

    });

    function addProject() {
        App.openNew('${base}/QCode/add.html')
    }
    
    var saveFlag = false;
    //保存
    function save() {
        if (saveFlag) {
            return;
        }
        saveFlag = true;
        var code = svgBoard.quantum2Code();
        code = "CREG " + classicalbitNum + "\r\n" + code;
        code = "QINIT " + qubitNum  + "\r\n" + code;

        var svgXml = svgBoard.getSvgXml();
        var projectId = $("#projectId").val();
        var versionId = $("#versionId").val();
        var param = {};
        param.projectId = projectId;
        param.versionId = versionId;
        param.code = code;
        param.svgXml = svgXml;
        var url = "${base}/QCode/save.json";
        $.post(url, param, function(response) {
            if (response.code == "401") {
                setTimeout(function () {App.openNew(response.message)}, 1500);
                return false;
            }
            if (response.success) {
                App.prompt(messages.save_success);
                //$("#versionId").val(response.obj);
                //setTimeout(function() {window.location.reload()}, 1500);
                versionId = response.obj;
                setTimeout(function() {location.href="${base}/QCode/index.html?versionId=" + versionId + "&projectId=" + projectId}, 1500);
            } else {
                error(response.message);
                saveFlag = false;
            }
        }).fail(function() { saveFlag = false;App.alert("网络异常")});
    }
    //运行代码
function running() {

    if (svgBoard.canRun()) {
        $("#running").show();
        $("#running-div").show();
        $("#running-div>span").hide();
        var code = svgBoard.quantum2Code();
        code = "CREG " + classicalbitNum + "\r\n" + code;
        code = "QINIT " + qubitNum  + "\r\n" + code;
        
        var svgXml = svgBoard.getSvgXml();
        var projectId = $("#projectId").val();
        var versionId = $("#versionId").val();

        var param = {};
        param.code = code;
        param.svgXml = svgXml;
        param.versionId = versionId;
        param.projectId = projectId;
        //获取测量门数组
        param.meaarr = svgBoard.getMeasures();
        var url = "${base}/QCode/running.json";
        $.post(url, param, function(response) {
            if (response.code == "401") {
                setTimeout(function (){App.openNew(response.message)}, 1500);
                return false;
            }
            if (response.success) {
                var obj = response.obj;
                if (obj) {
                    //任务状态
                    var status = obj.status;
                    //任务id
                    var taskId = obj.taskId;
                    var alreadyShow = false;
                    if (status == 3) {
                        if (alreadyShow) {
                            return;
                        }
                        alreadyShow = true;
                        setTimeout(function(){selectTaskStatus(JSON.parse(obj.ans))}, 1000);
                        $("#running-div>span").show();
                    } else if (status == 4) {
                    	clearInterval(window.selectTimer);
                        $("#running").hide();
                        $("#running-div").hide();
                        error(messages.task_status_syntactic_error);
                    } else {
                        //5秒查询一次任务状态
                        window.selectTimer = setInterval(function () {selectTaskStatus(taskId)}, 5000);
                    } 
                    $("#running-div>span").show();
                }
            } else {
                error(response.message);
                $("#running").hide();
                $("#running-div").hide();
            }
        }).fail(function() { App.alert("网络异常"); $("#running-div>span").show();});
    }
}

jQuery(function($) {
    
    var parentId = "inner_svg", lineNum = qubitNum, stepNum = 50, stepWidth = 50, lineStartX = 10, lineStartY = 50, lineDistance = 50;
    svgBoard = new SvgBoard(parentId, lineNum, stepNum, stepWidth, lineStartX, lineStartY, lineDistance);
    svgBoard.analogType = $("#analogType").val();
    svgBoard.init();
    $("#quantum").height($("#inner_svg").height());
    var doorMap = initDoorMap(lineNum);
    svgBoard.doorMap = doorMap;
    var code = $("#code").val();
    if (code) {
        code = code.replace("CREG " + classicalbitNum, "");
        code = code.replace("QINIT " + lineNum, "");
        //code = code.replace(/'/g, "\"");
        svgBoard.code2quantum(code);
    }
    $('.more-list li').on("click", function() {
        var commandId = $(this).attr("id");
        var temp = svgBoard.doorMap[commandId];
        var classicsBit = svgBoard.eventBook.currentEntity;
        var door;
        if (temp instanceof SingleDoor) {
            if (svgBoard.quantumCheckout(classicsBit)) {
                door = new SingleDoor(temp.code, temp.svgId, temp.isVoid, temp.width, temp.height);
                if (!door.isVoid) {
                    door.parameter = temp.parameter;
                    if (door.parameter == undefined) {
                        classicsBit.quantumDoor = door;
                        showParameter();
                        return;
                    }
                }
                door.setClassicsBit(classicsBit);
                svgBoard.codeArray.push(classicsBit);
            }
        } else if (temp instanceof MultiDoor) {
            if (svgBoard.quantumCheckout(classicsBit)) {
                door = new MultiDoor(temp.code, temp.svgId, temp.doorNum, temp.isVoid, temp.width, temp.height, temp.lineColour, temp.bothEnds);
                if (!door.isVoid) {
                    door.parameter = temp.parameter;
                    if (door.parameter == undefined) {
                        classicsBit.quantumDoor = door;
                        showParameter();
                        return;
                    }
                }
                door.setFirstClassicsBit(classicsBit);
                svgBoard.codeArray.push(classicsBit);
            }
        } else if (temp instanceof MeasureDoor) {
            if (svgBoard.measureCheckout(classicsBit)) {
                door = new MeasureDoor(temp.code, temp.svgId, temp.width, temp.height);
                if (svgBoard.analogType == 0) {
                    classicsBit.quantumDoor = door;
                    $("#measureQub i").each(function() {
                        $(this).remove();
                    });
                    var dom = $("#measureQub li")[classicsBit.lineIndex];
                    $(dom).append("<i class='iconfont icon-duihao'></i>");
                    $("#qubit").val("$" + classicsBit.lineIndex);
                    showMeasure();
                    return;
                }
                door.setClassicsBit(classicsBit);
                svgBoard.measureArray.push(classicsBit);
            }
        } else if (temp instanceof CombinationDoor) {
            classicsBit.inactivation();
            if (!temp.checkCode(classicsBit, svgBoard)) {
                svgBoard.eventBook.currentEntity = null;
                return;
            }
            temp.addAllDoor(classicsBit, svgBoard);
        }

    });
    
    $("#saveParameter").on("click", function() {
        var parameter = $('#parameter').val();

        $('html').removeClass('noscroll');
        $('#aside_div').removeClass('active');
        if(parameter == '' || !expressionRegexp(parameter)) {
            error(messages.expression_is_not_legal);
            return;
        }
        var classicsBit = svgBoard.eventBook.currentEntity;
        classicsBit.quantumDoor.parameter = parameter;
        if (classicsBit.quantumDoor instanceof SingleDoor) {
            classicsBit.quantumDoor.setClassicsBit(classicsBit);
        } else if (classicsBit.quantumDoor instanceof MultiDoor) {
            classicsBit.quantumDoor.setFirstClassicsBit(classicsBit);
        }
        svgBoard.codeArray.push(classicsBit);
    });
    
    $("#quantum2Code").on("click", function() {
        quantum2Code(svgBoard);
    });
    
    $("#code2Quantum").on("click", function() {
        if (codeMirror.getValue) {
            svgBoard.code2quantum(codeMirror.getValue());
        }
    });

    $("#saveQubit").on("click", function() {
        var parameter = $('#qubit').val();
        $('html').removeClass('noscroll');
        $('#measure').removeClass('active');
        var classicsBit = svgBoard.eventBook.currentEntity;
        classicsBit.quantumDoor.parameter = parameter;
        classicsBit.quantumDoor.setClassicsBit(classicsBit);
        svgBoard.codeArray.push(classicsBit);
        svgBoard.measureArray.push(classicsBit);
    });
    
    var elAside = $('#aside_div');
    $('.hideAside').on('click', function () {
        $('html').removeClass('noscroll');
        elAside.removeClass('active');
        if (!(svgBoard.eventBook.currentEntity.quantumDoor instanceof MeasureDoor)) {
            svgBoard.eventBook.currentEntity.inactivation();
            if (svgBoard.eventBook.currentEntity.quantumDoor instanceof MultiDoor) {
                svgBoard.eventBook.currentEntity = null;
            }
        }
    });
    var measureAside = $('#measure');
    $("#cancel").on('click', function () {
        $('html').removeClass('noscroll');
        measureAside.removeClass('active');
        svgBoard.eventBook.currentEntity.inactivation();
    });
});

function showParameter() {
    var elAside = $('#aside_div');
    setTimeout(function () {
        elAside.addClass('active');
        $.smartScroll(elAside, '.scrollable');
        $('html').addClass('noscroll');
    }, 200);
}


function showMeasure() {
    var elAside = $('#measure');
    setTimeout(function () {
        elAside.addClass('active');
        $.smartScroll(elAside, '.scrollable');
        $('html').addClass('noscroll');
    }, 200);
}

function selectTaskStatus(taskId) {
  var projectId = $("#projectId").val();
  var versionId = $("#versionId").val();
  var url = "${base}/QCode/getTaskRate.json";
  var param = new Object();
  param.taskId = taskId;
  $.post(url, param, function(response) {
    if ('401' == response.code) {
      App.prompt("重新登录");
      setTimeout(function(){App.openNew(response.message)}, 1500);
      return false;
    }
    if (response.success) {
        var task = response.obj;
        var status = task.status;
        
        if (status == 3 || status == 5) {
            setTimeout(function () {displayResult(task)}, 1000);
            clearInterval(window.selectTimer);
        } else if(status == 4) {
        	clearInterval(window.selectTimer);
            $("#running").hide();
            $("#running-div").hide();
            error(messages.task_status_syntactic_error);
        }
    } else {
        error(response.message);
        clearInterval(window.selectTimer);
    }
  }).fail(function() {clearInterval(window.selectTimer);});
}

function displayResult(task) {

    $("#running").hide();
    $("#running-div").hide();
    $("#result").show();
    $("#result-div").show();
    var ans = JSON.parse(task.ans);
    var keyArray = ans.key;
    var valueArray = ans.value;
    var myChart = makeChart("taskResult");
    //参数设置
    var option;
    if (keyArray.length > 4) {
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                top: 30,
                left: '3%',
                right: '4%',
                bottom: '12%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                data: keyArray,
                name: messages.celiangzhi,
                nameLocation: "middle",
                nameGap: 20,
                axisTick: {
                    alignWithLabel: true
                }
            }],
            dataZoom: [{
                type: 'slider',
                startValue: 0,
                endValue: 4
            }],
            yAxis: [{
                type: 'value',
                name: messages.gailv
            }],
            series: [{
                name: messages.gailv,
                type: 'bar',
                barWidth: '20',
                data: valueArray
            }]
        };
    } else {
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                top: 30,
                left: '3%',
                right: '3%',
                bottom: '12%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                data: keyArray,
                name: messages.celiangzhi,
                nameLocation: "middle",
                nameGap: 20,
                axisTick: {
                    alignWithLabel: true
                }
            }],
            dataZoom: [
                {
                    type: 'slider',
                    start: 0,
                    end: 100
                }
            ],
            yAxis: [{
                type: 'value',
                name: messages.gailv
            }],
            series: [
                {
                    name: messages.gailv,
                    type: 'bar',
                    barWidth: '20',
                    data: valueArray
                }
            ]
        };
    }
    
    myChart.setOption(option);
    $("#startTime").html(messages.zhixingshijian + "：" + task.startTime);
    $("#endTime").html(messages.end_time + "：" + task.endTime);
}

//校验参数
function expressionRegexp(expression) {
    var regexpStr = "-?(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d+))\\s*(?:(?:(?:[+*-]\\s*(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d+)))|(?:\\/\\s*(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d*[1-9])))|(?:\\^\\d+))\\s*)*";
    //var regexp = /^\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*$/;
    var regexp = new RegExp(regexpStr);
    return regexp.test(expression);
}

function makeChart(name) {
    
    var main = document.getElementById(name);
    var opts = {height: 230};
    var myEcharts = echarts.init(main);
    myEcharts.resize(opts);
    return myEcharts;
}

function tabSelect(){
	window.location.reload();
}
</script>
</@main.footer>