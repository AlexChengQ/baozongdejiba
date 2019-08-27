<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html>
    <style>
        .mn {background: inherit!important;color: inherit;}
        .div1{width:auto;height:auto; /*display: none;*/background: #fff;position: absolute;z-index: 100; /*cursor:move;*/}
    </style>
    <script type="text/x-mathjax-config">
        //Mathjax相关配置
        MathJax.Hub.Config({
            showProcessingMessages: false,  //关闭js加载过程信息
            messageStyle: "none",  //不显示信息
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath:  [ ["$", "$"] ],   //行内公式选择$
                displayMath: [ ["$$","$$"] ],  //段内公式选择$$
                skipTags: ['script', 'noscript', 'style', 'textarea', 'pre','code','a'],  //避开某些标签
                ignoreClass:"comment-content"  //避开含该Class的标签
            },
            "HTML-CSS": {
                availableFonts: ["STIX","TeX"],   //可选字体
                imageFont: null   //去除图片加载
            }
        });
        MathJax.Hub.Queue(function () {
            <#--document.getElementsByClassName("news-box")[0].style.opacity=1;-->
            <#--if (document.getElementById("loading")) {-->
                <#--document.getElementById("loading").style.display="none";-->
            <#--}-->
        });
    </script>
    <script type="text/javascript" src="${base}/assets/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content">
        <style>
            body{background: #f5f5f5!important;}
            /*#noty_center_layout_container li   {*/
                /*!*border: none!important;*!*/
                /*border-radius:8px!important;*/
                /*background: transparent!important;*/
                /*-moz-box-shadow:0px 1px 6px #333333; -webkit-box-shadow:0px 1px 6px #333333; box-shadow:0px 1px 6px #333333;*/
            /*}*/
            /*.layer-custom-error {*/
                /*background: #fff;*/
                /*height: 80px;*/
                /*line-height: 80px;*/
                /*color: #c01a20;*/
                /*position: relative;*/
                /*font-size: 20px;*/
                /*!*border-radius: 8px;*!*/
                /*padding: 0 60px 0 130px;*/
                /*text-align: center;*/

                /*!*-moz-box-shadow:0px 1px 6px #333333; -webkit-box-shadow:0px 1px 6px #333333; box-shadow:0px 1px 6px #333333;*!*/
            /*}*/
            <#--.layer-custom-error {-->
                <#--content: '';-->
                <#--position: absolute;-->
                <#--left: 60px;-->
                <#--width: 35px;-->
                <#--height: 35px;-->
                <#--background: url(${base}/assets/images/tipImg1.png);-->
            <#--}-->
        </style>
        <input type="hidden" id="flag">
        <input type="hidden" id="projectId" value="${(qcodeProject.id)!}">
        <input type="hidden" id="versionId" value="${(projectVersion.id)!}">
        <input type="hidden" id="taskTypeId" value="${(qcodeProject.taskTypeId)!}">
        <input type="hidden" id="code" value='${(projectVersion.code)!}'>
        <!--top-->
        <@main.top5>
            <#escape x as x?html></#escape>
        </@main.top5>
        <!--top end-->
        <!--box-->
        <#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
        <style>
        </style>
        <#if lang?? && lang?string=="en_US">
            <style>
                .LayerTitle {width: 366px;}
                .LayerContent{height: 320px;}
            </style>
        </#if>
        <div class="NewContent">
            <div class="NewBox" id="NewBox">
                <div class="NewTab">
                    <ul>
                        <li class="active"><a href="javascript:;"><@spring.message code="design" /></a></li>
                        <div class="tabImg"><img src="${base}/assets/images/tabImg.png" alt=""></div>
                        <li><a href="javascript:;"><@spring.message code="quantum_program" /></a></li>
                    </ul>
                    <div class="New_guide"><button onclick="CloudCLD.to_guide_btn()">新手引导</button></div>
                </div>
                <div class="NewName">
                    <#if (lang?? && lang?string=="en_US") && (qcodeProject.nameEnglish??)>
                        ${(qcodeProject.nameEnglish)!}
                    <#else>
                        ${(qcodeProject.name)!}
                    </#if>
                        <#if (qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258))&&(qcodeProject.taskTypeId?? && qcodeProject.taskTypeId!=3)>
                        <#--${projectVersion.createTime?string('yyyyMMddHHmm')}-->
                            <#if projectVersion.name?exists>
                                # ${projectVersion.name!}
                            </#if>
                        </#if>
                </div>
                <div class="NewModule">
                    <div class="NewModuleLeft">
                        <div style="display:none;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40">
                                <style>
                                    .st1, .st0 {fill: #fff;transform: translate(10px, 10px);}
                                    .stl2 {width: 30px;height: 30px;}
                                </style>
                                <g id="svg_H">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <path fill="#FFFFFF" d="M29.534,32.814h-1.887l1.188-6.584h-7.395l-1.188,6.584h-1.887l2.637-14.61h1.887l-1.146,6.348h7.395   l1.146-6.348h1.887L29.534,32.814z"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_NOT">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <path fill="#FFFFFF" d="M18.459,30.553h-1.822l-4.317-9.264c-0.122-0.262-0.211-0.52-0.267-0.777h-0.047   c-0.007,0.267-0.087,0.823-0.239,1.668l-1.511,8.373H8.734l2.149-11.909h1.93l4.185,9.104c0.199,0.43,0.314,0.704,0.344,0.822   h0.031c0.009-0.338,0.088-0.918,0.236-1.737l1.478-8.188h1.522L18.459,30.553z"/>
                                        <path fill="#FFFFFF" d="M21.814,24.74c0.347-1.922,1.144-3.452,2.389-4.59c1.247-1.138,2.758-1.707,4.538-1.707   c1.655,0,2.887,0.556,3.696,1.668c0.809,1.112,1.052,2.56,0.73,4.344c-0.349,1.933-1.143,3.465-2.383,4.598   c-1.239,1.133-2.726,1.699-4.458,1.699c-1.691,0-2.947-0.557-3.765-1.669C21.741,27.973,21.493,26.524,21.814,24.74z    M23.452,24.617c-0.26,1.441-0.101,2.595,0.478,3.464s1.46,1.304,2.644,1.304c1.271,0,2.344-0.417,3.22-1.25   s1.448-1.998,1.719-3.494c0.277-1.538,0.137-2.725-0.423-3.56c-0.559-0.835-1.456-1.253-2.691-1.253   c-1.215,0-2.279,0.441-3.19,1.322C24.294,22.031,23.709,23.188,23.452,24.617z"/>
                                        <path fill="#FFFFFF" d="M42.704,20.012h-3.438l-1.902,10.541h-1.545l1.902-10.541h-3.421l0.247-1.369h8.403L42.704,20.012z"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_ZPi">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <path fill="#FFFFFF" d="M27.919,17.931L17.062,30.539h8.39l-0.308,1.701H13.938l0.118-0.653l10.784-12.522h-7.852l0.309-1.71   h10.726L27.919,17.931z"/>
                                        <path fill="#FFFFFF" d="M36.494,25.393h-1.729l-0.837,4.636c-0.132,0.73,0.06,1.096,0.574,1.096c0.183,0,0.422-0.052,0.719-0.152   l-0.214,1.183c-0.358,0.125-0.701,0.188-1.027,0.188c-1.259,0-1.756-0.737-1.489-2.214l0.854-4.735h-2.906l-0.837,4.643   c-0.183,1.009-0.401,1.744-0.657,2.205h-1.428c0.279-0.48,0.51-1.221,0.689-2.22l0.836-4.628c-0.638,0.015-1.312,0.245-2.021,0.692   l0.228-1.262c0.466-0.369,1.136-0.555,2.01-0.555h7.438L36.494,25.393z"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_XPi2">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <text xmlns="http://www.w3.org/2000/svg" transform="matrix(0.9841 0 -0.1776 0.9841 17.5835 32.2402)" fill="#FFFFFF" font-family="'MicrosoftYaHei'" font-size="20">X</text>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_YPi2">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <text xmlns="http://www.w3.org/2000/svg" transform="matrix(0.9841 0 -0.1776 0.9841 17.5835 32.2402)" fill="#FFFFFF" font-family="'MicrosoftYaHei'" font-size="20">Y</text>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_ZPi2">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M45,40c0,2.763-2.238,5-5,5H10c-2.762,0-5-2.237-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <text xmlns="http://www.w3.org/2000/svg" transform="matrix(0.9841 0 -0.1776 0.9841 17.5835 32.2402)" fill="#FFFFFF" font-family="'MicrosoftYaHei'" font-size="20">Z</text>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_CNOT">
                                    <g>
                                        <rect fill="#B3DE7B" index="1" width="40" height="40" rx="20" ry="20" cx="20" cy="20" r="20" transform="translate(5 5)"/>
                                    <#--<circle xmlns="http://www.w3.org/2000/svg" fill="#B3DE7B" cx="25" cy="25.334" r="20"/>-->
                                        <path fill="#FFFFFF" data-dis="1" d="M25.882,26.969v8.257h-1.689v-8.257h-8.256V25.28h8.256v-8.257h1.689v8.257h8.238v1.688H25.882z"/>
                                    </g>
                                </g>
                                <g id="svg_iSWAP">
                                    <g>
                                    <#--<circle fill="#B3DE7B" cx="25" cy="25" r="20"/>-->
                                        <rect fill="#B3DE7B" index="1" width="40" height="40" rx="20" ry="20" cx="20" cy="20" r="20" transform="translate(5 5)"/>
                                        <path fill="#FFFFFF" d="M24.986,41.313c-6.932-0.005-13.105-4.382-15.402-10.921c-0.195-0.644,0.152-1.326,0.787-1.548  c0.634-0.223,1.331,0.095,1.58,0.719c1.945,5.532,7.17,9.235,13.035,9.239c5.872-0.002,11.102-3.714,13.039-9.257  c0.149-0.423,0.511-0.735,0.952-0.818c0.44-0.084,0.892,0.074,1.186,0.414c0.292,0.34,0.381,0.811,0.233,1.232  C38.104,36.923,31.925,41.31,24.986,41.313L24.986,41.313z M39.236,21.351c-0.536,0-1.013-0.34-1.188-0.847  c-1.915-5.578-7.161-9.324-13.059-9.326c-5.898-0.002-11.146,3.742-13.064,9.319c-0.246,0.625-0.939,0.945-1.575,0.728  c-0.635-0.218-0.986-0.896-0.797-1.541c2.265-6.592,8.465-11.017,15.436-11.016c6.97,0.001,13.169,4.429,15.432,11.021  c0.133,0.383,0.072,0.807-0.164,1.137C40.021,21.155,39.642,21.351,39.236,21.351L39.236,21.351z M39.236,21.351"/>
                                        <path fill="#FFFFFF" d="M10.738,13.813c-0.693,0-1.255,0.563-1.255,1.256v5.021c0,0.693,0.562,1.255,1.255,1.255  s1.255-0.562,1.255-1.255v-5.021c0-0.333-0.132-0.652-0.367-0.888S11.071,13.813,10.738,13.813L10.738,13.813z"/>
                                        <path fill="#FFFFFF" d="M39.236,28.682c-0.333,0-0.652,0.133-0.889,0.367c-0.234,0.236-0.367,0.555-0.367,0.889v5.021  c0.001,0.693,0.563,1.255,1.256,1.255c0.692,0,1.255-0.562,1.256-1.255v-5.021C40.492,29.244,39.929,28.682,39.236,28.682  L39.236,28.682z"/>
                                        <path fill="#999999" d="M39.236,28.682"/>
                                        <path fill="#FFFFFF" d="M22.396,24.17v-0.892c0.594-0.071,1.094-0.17,1.499-0.297c0.404-0.127,0.865-0.33,1.38-0.605h0.784v8.615   c0,0.301,0.043,0.526,0.129,0.677s0.206,0.26,0.36,0.328c0.153,0.068,0.435,0.102,0.843,0.102h0.505V33h-5.5v-0.902h0.44   c0.479,0,0.802-0.043,0.967-0.129c0.165-0.086,0.281-0.207,0.349-0.365c0.068-0.157,0.102-0.526,0.102-1.106V24.17H22.396z    M25.125,17.531c0.344,0,0.638,0.12,0.881,0.36c0.243,0.24,0.365,0.532,0.365,0.875s-0.122,0.638-0.365,0.881   c-0.243,0.244-0.537,0.365-0.881,0.365s-0.638-0.122-0.881-0.365c-0.244-0.243-0.365-0.537-0.365-0.881s0.122-0.635,0.365-0.875   C24.487,17.651,24.781,17.531,25.125,17.531z"/>


                                    </g>
                                </g>
                                <g id="svg_Toffoli">
                                    <g>
                                    <#--<circle fill="#B3DE7B" cx="25" cy="25" r="20"/>-->
                                        <rect fill="#B3DE7B" index="1" width="40" height="40" rx="20" ry="20" cx="20" cy="20" r="20" transform="translate(5 5)"/>
                                        <path fill="#999999" d="M39.236,28.682"/>
                                        <path fill="#FFFFFF" d="M24.875,17.621h-5.238v16.066h-2.355V17.621h-5.215v-2.086h12.809V17.621z"/>
                                        <path fill="#FFFFFF" d="M24.712,30.518c0-1.07,0.299-1.915,0.896-2.534s1.408-0.929,2.432-0.929c0.973,0,1.735,0.298,2.288,0.894   s0.829,1.419,0.829,2.47c0,1.023-0.295,1.85-0.885,2.479s-1.381,0.943-2.373,0.943c-0.969,0-1.742-0.305-2.32-0.914   S24.712,31.514,24.712,30.518z M25.884,30.482c0,0.746,0.188,1.334,0.565,1.764s0.884,0.645,1.521,0.645   c0.656,0,1.156-0.21,1.5-0.63s0.516-1.022,0.516-1.808c0-0.789-0.172-1.395-0.516-1.816s-0.844-0.633-1.5-0.633   c-0.645,0-1.153,0.221-1.526,0.662S25.884,29.713,25.884,30.482z"/>
                                        <path fill="#FFFFFF" d="M35.862,25.074c-0.215-0.113-0.447-0.17-0.697-0.17c-0.719,0-1.078,0.445-1.078,1.336v0.967h1.518v0.949   h-1.518v5.531H32.95v-5.531h-1.107v-0.949h1.107v-1.02c0-0.695,0.2-1.241,0.601-1.638s0.909-0.595,1.526-0.595   c0.328,0,0.59,0.037,0.785,0.111V25.074z"/>
                                        <path fill="#FFFFFF" d="M40.022,25.074c-0.215-0.113-0.447-0.17-0.697-0.17c-0.719,0-1.078,0.445-1.078,1.336v0.967h1.518v0.949   h-1.518v5.531H37.11v-5.531h-1.107v-0.949h1.107v-1.02c0-0.695,0.2-1.241,0.601-1.638s0.909-0.595,1.526-0.595   c0.328,0,0.59,0.037,0.785,0.111V25.074z"/>
                                    </g>
                                </g>
                                <g id="svg_Measure">
                                    <g>
                                        <path fill="#999999" d="M39.236,28.682"/>
                                        <path fill="#F65353" d="M45,40c0,2.762-2.238,5-5,5H10c-2.762,0-5-2.238-5-5V10c0-2.761,2.238-5,5-5h30c2.762,0,5,2.239,5,5V40z"/>
                                        <path fill="#FFFFFF" d="M27.363,22.546l0.592-1.787l1.35,0.449l-0.898-4.433L25,19.795l1.414,0.45l-0.717,2.195    C25.465,22.434,25.233,22.43,25,22.43c-8.867,0-16.064,4.819-16.064,10.729h2.506c0-4.614,6.073-8.397,13.502-8.417l-2.771,8.482    l1.671-0.065l2.771-8.356c6.701,0.5,11.943,4.07,11.943,8.356h2.506C41.064,27.783,35.111,23.312,27.363,22.546L27.363,22.546z     M27.363,22.546"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_RX">
                                    <g>
                                        <path xmlns="http://www.w3.org/2000/svg" fill="#178CEC" d="M46,40.042c0,2.762-2.238,5-5,5H10.999c-2.761,0-5-2.238-5-5v-30c0-2.761,2.239-5,5-5H41  c2.762,0,5,2.239,5,5V40.042z"/>
                                        <text xmlns="http://www.w3.org/2000/svg" transform="matrix(0.9659 0 -0.2588 0.9659 14.1191 33.0625)"><tspan x="0" y="0" fill="#FFFFFF" font-family="'MicrosoftYaHei'" font-size="20.7055">X</tspan><tspan x="13.355" y="0" fill="#FFFFFF" font-family="'MicrosoftYaHei'" font-size="12.4233">θ</tspan></text>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_RY">
                                    <g>

                                        <path fill="#178CEC" d="M46,40.042c0,2.763-2.238,5-5,5H10.999c-2.761,0-5-2.237-5-5v-30c0-2.761,2.239-5,5-5H41  c2.762,0,5,2.239,5,5V40.042z"/>
                                        <path fill="#FFFFFF" d="M30.135,17.936l-7.542,9.56l-1.491,5.566h-1.963l1.479-5.518l-2.279-9.609h2.236l1.477,6.699   c0.004,0.006,0.039,0.329,0.103,0.966h0.029c0.151-0.273,0.37-0.592,0.657-0.957l5.215-6.709H30.135z"/>
                                        <path fill="#FFFFFF" d="M28.878,28.357c0.429-1.602,1.049-2.836,1.859-3.702c0.811-0.868,1.755-1.301,2.833-1.301   c2.059,0,2.654,1.617,1.788,4.851c-0.43,1.602-1.05,2.838-1.86,3.707c-0.812,0.869-1.732,1.303-2.764,1.303   c-0.992,0-1.652-0.427-1.98-1.279C28.427,31.082,28.468,29.889,28.878,28.357z M29.966,28.65c-0.29,1.184-0.338,2.08-0.144,2.689   c0.193,0.609,0.611,0.914,1.252,0.914c0.625,0,1.195-0.313,1.711-0.939c0.516-0.628,0.94-1.516,1.276-2.664H29.966z M34.299,27.742   c0.535-2.289,0.172-3.433-1.09-3.433c-0.586,0-1.145,0.298-1.675,0.894c-0.531,0.596-0.971,1.442-1.319,2.54H34.299z"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_RZ">
                                    <g>
                                        <path fill="#178CEC" d="M46,40.042c0,2.763-2.238,5-5,5H10.999c-2.761,0-5-2.237-5-5v-30c0-2.761,2.239-5,5-5H41  c2.762,0,5,2.239,5,5V40.042z"/>
                                        <path fill="#FFFFFF" d="M29.958,18.522L17.804,31.334h8.526l-0.463,1.729H14.48l0.178-0.664l12.072-12.724h-7.979l0.465-1.739   h10.899L29.958,18.522z"/>
                                        <path fill="#FFFFFF" d="M28.878,28.357c0.429-1.602,1.049-2.836,1.859-3.702c0.811-0.868,1.755-1.301,2.833-1.301   c2.059,0,2.654,1.617,1.788,4.851c-0.43,1.602-1.05,2.838-1.86,3.707c-0.812,0.869-1.732,1.303-2.764,1.303   c-0.992,0-1.652-0.427-1.98-1.279C28.427,31.082,28.468,29.889,28.878,28.357z M29.966,28.65c-0.29,1.184-0.338,2.08-0.144,2.689   c0.193,0.609,0.611,0.914,1.252,0.914c0.625,0,1.195-0.313,1.711-0.939c0.516-0.628,0.94-1.516,1.276-2.664H29.966z M34.299,27.742   c0.535-2.289,0.172-3.433-1.09-3.433c-0.586,0-1.145,0.298-1.675,0.894c-0.531,0.596-0.971,1.442-1.319,2.54H34.299z"/>
                                        <rect style="opacity:0;" index="1" fill="#22a5de" width="40" height="40" transform="translate(5 5)"/>
                                    </g>
                                </g>
                                <g id="svg_CR">
                                    <g>
                                        <rect fill="#B3DE7B" index="1" width="40" height="40" rx="20" ry="20" cx="20" cy="20" r="20" transform="translate(5 5)"/>
                                    <#--<rect x="9.483" y="8.647" fill="none" width="31.033" height="32.705"/>-->

                                        <path fill="#FFFFFF" d="M23.849,33.113c-1.113,0.586-2.51,0.879-4.189,0.879c-2.168,0-3.9-0.688-5.196-2.064   s-1.943-3.199-1.943-5.465c0-2.435,0.729-4.394,2.188-5.878s3.311-2.227,5.557-2.227c1.445,0,2.64,0.205,3.584,0.615v2.041   c-1.081-0.599-2.27-0.898-3.564-0.898c-1.687,0-3.061,0.562-4.122,1.685s-1.592,2.638-1.592,4.545c0,1.811,0.495,3.248,1.484,4.313   s2.286,1.596,3.887,1.596c1.497,0,2.799-0.338,3.906-1.016V33.113z"/>
                                        <path fill="#FFFFFF" d="M37.922,33.738h-2.305l-2.51-4.199c-0.502-0.84-0.961-1.41-1.377-1.713   c-0.418-0.303-0.916-0.455-1.494-0.455H28.83v6.367h-1.953V18.612h4.609c1.471,0,2.623,0.355,3.457,1.064   c0.832,0.709,1.25,1.703,1.25,2.979c0,2.096-1.121,3.457-3.359,4.082v0.049c0.416,0.176,0.775,0.427,1.078,0.752   c0.303,0.326,0.695,0.883,1.178,1.67L37.922,33.738z M28.83,20.321v5.341h2.305c0.891,0,1.615-0.26,2.172-0.781   s0.836-1.205,0.836-2.051c0-0.788-0.254-1.403-0.762-1.846s-1.248-0.664-2.217-0.664H28.83z"/>

                                    </g>
                                </g>
                                <!--<g><rect fill="#89bc55" width="40" height="40" rx="20" ry="20"/><path fill="#fff" d="M18.94,33.34l.37-2,8.52-9.72H21.21l.32-1.76h8.75l-.37,1.9-8.33,9.77h6.76l-.51,1.81Zm11.53.74a14.12,14.12,0,0,1,.37-3c.65-2.92,2.18-5.42,4.63-5.42s2.92,1.57,2.92,3.8A12.46,12.46,0,0,1,38.16,32C37.51,35.38,36.07,38,33.53,38s-3.06-1.34-3.06-3.94ZM32,32.23a11.58,11.58,0,0,0,0,2C32,36,32.74,37,33.8,37s2.5-1.94,3-4.63Zm4.63-1.06a11.47,11.47,0,0,0,0-1.76c0-1.53-.56-2.64-1.71-2.64s-2.5,2.08-2.5,4.4Zm0,0" transform="translate(-8.66 -8.95)"/><path fill="#606060" d="M37.28,31.13" transform="translate(-8.66 -8.95)"/></g>-->
                            </svg>
                        </div>
                        <div class="modLeft_l clearfix" style=";height: 395px;overflow:hidden">
                            <ul>
                                <#list 0..((qcodeProject.qubitNum)?default(6)-1) as i>
                                    <li><div class="modleft_ll">q[${i}]</div><div class="modleft_lr">I0></div></li>
                                </#list>
                            </ul>
                        </div>
                    <#--<div class="modLeft_r"></div>-->
                    </div>
                    <div class="NewModuleRight">
                        <div class="modRight_top">
                            <ul><#list 1..50 as n><li>${n}</li></#list></ul>
                        </div>
                        <div class="modRight_center" id="modRight_center"></div>
                        <div class="simulate_box">
                            <div class="pointTag pointTag1"><img src="${base}/assets/images/guideTag.png" alt=""></div>
                            <#--添加单比特门-->
                            <div class="pointTag pointTag2"><img src="${base}/assets/images/guideTag.png" alt=""></div>
                            <#--添加单比特门成功-->
                            <div class="pointTag pointTag3">
                                <img src="${base}/assets/images/New_H.png" alt="">
                            </div>
                        <#--添加多比特门-->
                            <div class="pointTag pointTag4"><img src="${base}/assets/images/guideTag.png" alt=""></div>
                            <div class="pointTag pointTag5"><img src="${base}/assets/images/guideTag1.png" alt=""></div>
                            <div class="pointTag pointTag6"><img src="${base}/assets/images/guideTag2.png" alt=""></div>
                            <#--添加测量门-->
                            <div class="pointTag pointTag7"><img src="${base}/assets/images/guideTag.png" alt=""></div>
                            <#--添加测量门2-->
                            <div class="pointTag pointTag8"><img src="${base}/assets/images/guideTag.png" alt=""></div>

                            <#--第二段开始1-->
                            <div class="pointTag pointTag9"></div>
                        </div>
                    </div>
                </div>
                <div class="pr-box none" style="width: 96%;overflow: hidden;margin: 0 auto;">
                    <p style="padding-left:10px;color:red;"><@spring.message code="annotation_prompt" /></p>
                    <div id="qcodeTextarea" style="padding:0 10px;"></div>
                </div>
                <div class="NewConsole">
                    <div class="NewConBtnBox">
                        <#if qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258)>
                            <button class="New_add" onclick="CloudCLD.openAdd();"><i></i><span><@spring.message code="new" /></span></button>
                        <#elseif isOldUser!='2'>
                            <button class="New_add" onclick="CloudCLD.openAdd();"><i></i><span><@spring.message code="new" /></span></button>
                        <#else>
                            <button class="New_add" onclick="CloudCLD.visitorAdd();"><i></i><span><@spring.message code="new" /></span></button>
                        </#if>
                        <button class="New_edit" onclick="CloudCLD.openSave();"><i></i><span><@spring.message code="edit" /></span></button>
                        <button class="New_run" onclick="CloudCLD.running();"><i></i><span><@spring.message code="run" /></span></button>
                        <#if qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258)>
                            <button class="New_save" onclick="CloudCLD.save();"><i></i><span><@spring.message code="save" /></span></button>
                        </#if>
                    </div>
                </div>

            </div>

            <div class="LayerSetting">
                <div class="LaySetTitle"><@spring.message code="set_argument" /></div>
                <div class="LaySetJs"  id="commandTip"></div>
                <div class="LaySetLine1">
                    <div class="title"><sapn>*</sapn><@spring.message code="expression" />：</div>
                    <div class="titleBeWorth">
                        <#if qcodeProject.analogType?? && qcodeProject.analogType==2>
                            <select class="form-control" name="property" id="property" >
                                <option>pi/4</option>
                                <option>pi/2</option>
                                <option>3*pi/4</option>
                            </select>
                        <#else>
                            <textarea class="form-control" id="property"></textarea>
                        </#if>
                    <#--<font color="red">*</font>-->
                    </div>
                </div>
                <div class="LaySetLine2">
                    <div class="title"><sapn>*</sapn><@spring.message code="classical_register" />：</div>
                    <div class="titleBeWorth">
                        <select id="classicName" style="width:100px;">
                            <#list 1..qcodeProject.classicalbitNum!10 as i>
                                <option value="$${i-1}">$${i-1}</option>
                            </#list>
                        </select>
                    </div>
                </div>
                <div class="LaySetLine3">
                    <div class="title"><sapn>*</sapn><@spring.message code="operating_gate" />：</div>
                    <div class="titleBeWorth">
                        <select id="iswap" style="width:100px;">
                            <option value="iSWAP">iSWAP</option>
                            <option value="sqiSWAP">&radic;iSWAP</option>
                        </select>
                    </div>
                </div>
                <div class="LayConfirm">
                    <button id="savePropertyClear" value="<@spring.message code="cancel" />" style="/* display:none; */"><@spring.message code="cancel" /></button>
                    <input type="submit" id="saveProperty" value="<@spring.message code="save" />" style="/* display:none; */">
                </div>

            </div>
            <div class="LayerContent" id="LayerContent">
                <div class="pointTag pointTag10"></div>
                <div class="LayerMove" id="LayerMove">
                    <div class="LayerClose"></div>
                    <div class="LayerTitle">
                        <h1>
                            <@spring.message code="Select_element" />
                        </h1>
                    </div>
                </div>
                <div class="Layer_Con">
                    <div class="Layer_sort_con ">
                        <div class="sort_con_title"><@spring.message code="single_qubit_gates" />：</div>
                        <div class="sort_con_list">
                            <ul>
                                <li type="H" class="step11" imgName="New_H.png" id="dragH">
                                    <span>H</span>
                                    <p class="sort_tip_name"><@spring.message code="hadamard_gate" /></p>
                                    <p class="sort_tip_hw">$$H=\begin{bmatrix}\frac{1}{\sqrt{2}} &\frac{1}{\sqrt{2}}\\\frac{1}{\sqrt{2}}&\frac{1}{\sqrt{2}}\end{bmatrix} $$</p>
                                </li>
                                <li type="NOT" id="dragNOT" imgName="New_Not.png">
                                    <span>NOT</span>
                                    <p class="sort_tip_name"><@spring.message code="not_gate" /></p>
                                    <p class="sort_tip_hw">$$NOT=\begin{bmatrix}0&1\\1&0\end{bmatrix}$$</p>
                                </li>
                                <li type="ZPi" id="dragZPi" imgName="New_Zπ.png">
                                    <span>Zπ</span>
                                    <p class="sort_tip_name"><@spring.message code="pi_phase_gate" /></p>
                                    <p class="sort_tip_hw">$$Z= \begin{bmatrix}1&0\\0&-1\end{bmatrix}$$</p>
                                </li>
                                <li type="XPi2" id="dragXPi2" imgName="New_Xpi2.png">
                                    <span>X</span>
                                    <p class="sort_tip_name">X(𝜋/2)</p>
                                    <p class="sort_tip_hw">$$X= \begin{bmatrix}\frac{1}{\sqrt{2}}&\frac{-i}{\sqrt{2}}\\ \frac{-i}{\sqrt{2}}&\frac{1}{\sqrt{2}} \end{bmatrix} $$</p>
                                </li>
                                <li type="YPi2" id="dragYPi2" imgName="New_Ypi2.png">
                                    <span>Y</span>
                                    <p class="sort_tip_name">Y(𝜋/2)</p>
                                    <p class="sort_tip_hw">$$Y= \begin{bmatrix}\frac{1}{\sqrt{2}}&\frac{-1}{\sqrt{2}}\\ \frac{1}{\sqrt{2}}&\frac{1}{\sqrt{2}} \end{bmatrix} $$</p>
                                </li>
                                <li type="ZPi2" id="dragZPi2" imgName="New_Zpi2.png">
                                    <span>Z</span>
                                    <p class="sort_tip_name">Z(𝜋/2)</p>
                                    <p class="sort_tip_hw">$$Z= \begin{bmatrix}1 & 0 \\ 0 & i \end{bmatrix}$$</p>
                                </li>
                                <li type="RX" id="dragRX" imgName="New_Xpi.png">
                                    <span>Xθ</span>
                                    <p class="sort_tip_name"><@spring.message code="rotate_angle_around_the_x_axis" /></p>
                                    <p class="sort_tip_hw">$$\text{RX}(\theta)=\begin{bmatrix}\cos (\theta/2) & -i\sin (\theta/2) \\ -i\sin (\theta/2) & \cos (\theta/2) \end{bmatrix}$$</p>
                                </li>
                                <li type="RY" id="dragRY" imgName="New_Ypi.png">
                                    <span>Yθ</span>
                                    <p class="sort_tip_name"><@spring.message code="rotate_angle_around_the_y_axis" /></p>
                                    <p class="sort_tip_hw">$$\text{RY}(\theta)=\begin{bmatrix}\cos (\theta/2) & -\sin (\theta/2) \\ \sin (\theta/2) & \cos (\theta/2) \end{bmatrix}$$</p>
                                </li>

                                <li type="RZ" id="dragRZ" imgName="New_Zpi.png" style="padding: 0">
                                    <span>Zθ</span>
                                    <p class="sort_tip_name"><@spring.message code="rotate_angle_around_the_z_axis" /></p>
                                    <p class="sort_tip_hw">$$\text{RZ}(\theta)=\begin{bmatrix}1 & 0 \\ 0 & e^{i\theta} \end{bmatrix}$$</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="Layer_sort_con  Layer_sort_second">
                        <div class="sort_con_title"><@spring.message code="multi_qubit_gates" />：</div>
                        <div class="sort_con_list">
                            <ul>
                                <li type="CNOT" id="dragCNOT" class="step13" imgName="New_Cont.png">
                                    <svg style="margin-top: -3px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" enable-background="new 0 0 30 30" xml:space="preserve">
                                            <g>
	<path fill="#656766" d="M21.043,16.951h-5.521v5.496h-1.918v-5.496H8.107v-1.943h5.496V9.511h1.918v5.497h5.521V16.951z"/>
</g>
                                        </svg>
                                    <p  class="sort_tip_name"><@spring.message code="cnot_gate" /></p>
                                    <p class="sort_tip_hw">$$\text{CNOT}=\left(\begin{matrix}
                                        1&& && && \\
                                        &&1 && && \\
                                        &&  && 0&&1\\
                                        && &&1&&0
                                        \end{matrix}
                                        \right)$$</p>
                                </li>
                                <li type="iSWAP" id="dragiSWAP" imgName="New_Iswp.png">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" enable-background="new 0 0 30 30" xml:space="preserve">
                                        <g>
	<rect x="4.02" y="-1.245" fill="none" width="20.391" height="21.489"/>
	<path fill="#656766" d="M15.064,25.901c-4.555-0.003-8.611-2.879-10.12-7.175c-0.128-0.424,0.1-0.872,0.517-1.018   c0.417-0.146,0.875,0.063,1.039,0.472c1.277,3.636,4.711,6.068,8.564,6.071c3.857-0.002,7.295-2.44,8.566-6.083   c0.098-0.277,0.336-0.482,0.625-0.537c0.291-0.056,0.588,0.049,0.781,0.271c0.191,0.224,0.25,0.533,0.152,0.811   C23.684,23.017,19.623,25.9,15.064,25.901L15.064,25.901z M24.428,12.786c-0.354,0-0.666-0.224-0.781-0.557   c-1.258-3.665-4.705-6.126-8.581-6.127C11.19,6.1,7.742,8.56,6.482,12.224c-0.162,0.411-0.617,0.621-1.035,0.478   C5.03,12.559,4.8,12.114,4.924,11.69c1.488-4.332,5.562-7.239,10.142-7.238c4.581,0.001,8.653,2.911,10.14,7.242   c0.088,0.251,0.049,0.53-0.107,0.747C24.943,12.656,24.693,12.786,24.428,12.786L24.428,12.786z"/>
	<path fill="#656766" d="M5.703,7.833c-0.456,0-0.825,0.37-0.825,0.825v3.299c0,0.456,0.369,0.825,0.825,0.825   c0.455,0,0.824-0.37,0.824-0.825V8.658c0-0.219-0.087-0.428-0.241-0.583S5.922,7.833,5.703,7.833L5.703,7.833z"/>
	<path fill="#656766" d="M24.428,17.602c-0.221,0-0.43,0.088-0.584,0.242c-0.154,0.155-0.242,0.364-0.242,0.583v3.3   c0,0.456,0.371,0.824,0.826,0.824c0.453,0,0.824-0.368,0.824-0.824v-3.3C25.252,17.972,24.883,17.602,24.428,17.602L24.428,17.602z   "/>
	<g>
		<path fill="#656766" d="M13.363,14.638v-0.586c0.39-0.047,0.719-0.112,0.984-0.196s0.568-0.217,0.907-0.397h0.515v5.66    c0,0.198,0.028,0.347,0.084,0.445c0.057,0.099,0.137,0.171,0.236,0.216c0.102,0.045,0.285,0.066,0.555,0.066h0.332v0.593h-3.613    v-0.593h0.288c0.314,0,0.527-0.028,0.636-0.085c0.109-0.057,0.185-0.136,0.229-0.24c0.045-0.103,0.066-0.345,0.066-0.726v-4.158    H13.363z M15.155,10.275c0.227,0,0.42,0.079,0.579,0.236c0.16,0.158,0.24,0.35,0.24,0.575c0,0.226-0.08,0.42-0.24,0.579    c-0.159,0.16-0.353,0.24-0.579,0.24c-0.226,0-0.419-0.08-0.578-0.24c-0.16-0.159-0.24-0.353-0.24-0.579    c0-0.226,0.08-0.417,0.24-0.575C14.736,10.354,14.93,10.275,15.155,10.275z"/>
	</g>
</g>
                                    </svg>

                                    <p  class="sort_tip_name"><@spring.message code="iswap_gate" /></p>
                                    <p  class="sort_tip_hw">
                                        $$\text{iSW}(\theta)=\left(\begin{matrix}
                                        1&&0&&0&&0\\
                                        0&&\cos(\theta) && -i\sin(\theta)&&0\\
                                        0&& -i\sin(\theta)&&\cos(\theta)&&0\\
                                        0&&0&&0&&1
                                        \end{matrix}
                                        \right)$$
                                    </p>
                                </li>
                                <li type="Toffoli" id="dragToffoli" imgName="New_Toff.png">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" enable-background="new 0 0 30 30" xml:space="preserve">
<g>
	<path fill="#656766" d="M18.401,7.354h-5.716v17.53h-2.569V7.354H4.426V5.079h13.976V7.354L18.401,7.354z"/>
	<path fill="#656766" d="M14.14,22.246c0-0.873,0.244-1.559,0.729-2.063c0.488-0.506,1.148-0.758,1.98-0.758   c0.795,0,1.414,0.244,1.865,0.729s0.676,1.154,0.676,2.012c0,0.832-0.24,1.508-0.721,2.02c-0.48,0.514-1.125,0.768-1.934,0.768   c-0.789,0-1.418-0.25-1.891-0.744C14.374,23.713,14.14,23.059,14.14,22.246z M15.093,22.219c0,0.605,0.154,1.086,0.461,1.436   c0.309,0.352,0.721,0.525,1.24,0.525c0.533,0,0.939-0.17,1.223-0.514c0.279-0.342,0.42-0.832,0.42-1.473s-0.141-1.135-0.42-1.479   c-0.283-0.344-0.689-0.516-1.223-0.516c-0.527,0-0.941,0.178-1.244,0.539S15.093,21.592,15.093,22.219z"/>
	<path fill="#656766" d="M23.222,17.814c-0.176-0.096-0.365-0.141-0.566-0.141c-0.588,0-0.881,0.361-0.881,1.088v0.787h1.238v0.775   h-1.238v4.504h-0.924v-4.504h-0.902v-0.775h0.902v-0.83c0-0.566,0.164-1.012,0.488-1.334c0.328-0.324,0.74-0.486,1.244-0.486   c0.268,0,0.48,0.031,0.639,0.09V17.814z"/>
	<path fill="#656766" d="M26.612,17.814c-0.176-0.096-0.365-0.141-0.568-0.141c-0.588,0-0.881,0.361-0.881,1.088v0.787h1.24v0.775   h-1.24v4.504h-0.926v-4.504h-0.9v-0.775h0.9v-0.83c0-0.566,0.166-1.012,0.492-1.334c0.326-0.324,0.74-0.486,1.242-0.486   c0.268,0,0.482,0.031,0.641,0.09V17.814z"/>
</g>
</svg>

                                    <p  class="sort_tip_name"><@spring.message code="toffoli_gate" /></p>
                                    <p  class="sort_tip_hw">$$\text{Toffoli}= \begin{bmatrix}I(6) & 0 \\ 0 & NOT \end{bmatrix}$$</p>
                                </li>
                                <li type="CR" id="dragCR" imgName="New_CR.png">
                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="30px" height="30px" viewBox="0 0 30 30" enable-background="new 0 0 30 30" xml:space="preserve">
                                        <g>
	<path fill="#656766" d="M13.971,19.57c-0.891,0.469-2.008,0.703-3.352,0.703c-1.734,0-3.12-0.551-4.156-1.652   c-1.037-1.102-1.555-2.559-1.555-4.371c0-1.948,0.583-3.516,1.75-4.703c1.167-1.188,2.648-1.781,4.445-1.781   c1.156,0,2.112,0.164,2.867,0.492v1.633c-0.864-0.479-1.815-0.719-2.852-0.719c-1.349,0-2.448,0.449-3.297,1.348   c-0.849,0.898-1.273,2.111-1.273,3.637c0,1.448,0.396,2.598,1.188,3.449c0.792,0.852,1.828,1.277,3.109,1.277   c1.198,0,2.239-0.271,3.125-0.813V19.57z"/>
	<path fill="#656766" d="M25.229,20.07h-1.844l-2.008-3.359c-0.401-0.672-0.769-1.129-1.102-1.371s-0.731-0.363-1.195-0.363h-1.125   v5.094h-1.563V7.969h3.688c1.177,0,2.099,0.284,2.766,0.852c0.667,0.568,1,1.362,1,2.383c0,1.677-0.896,2.766-2.688,3.266v0.039   c0.333,0.141,0.621,0.341,0.863,0.602c0.242,0.261,0.556,0.706,0.941,1.336L25.229,20.07z M17.955,9.336v4.273h1.844   c0.714,0,1.293-0.208,1.738-0.625c0.445-0.417,0.668-0.963,0.668-1.641c0-0.63-0.203-1.122-0.609-1.477   c-0.406-0.354-0.997-0.531-1.773-0.531H17.955z"/>
</g>
</svg>
                                    <p  class="sort_tip_name"><@spring.message code="two_qubit_controlled_z_gate" /></p>
                                    <p  class="sort_tip_hw"><@spring.message code="qubit_c_control" /></p>
                                    <p><@spring.message code="cr_exp_theta_desc" /></p>
                                </li>
                                <li type="Measure" class="step18 step19" id="dragMeasure" imgName="New_Measure.png">
                                    <svg style="margin-top: 3px"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="图层_1" x="0px" y="0px" width="35.172px" height="20.821px" viewBox="0 0 35.172 20.821" enable-background="new 0 0 35.172 20.821" xml:space="preserve">
                                        <g>
	                                        <g>
		<path fill="#656766" d="M19.261,7.625l0.592-1.787l1.35,0.449l-0.897-4.433l-3.407,3.02l1.414,0.45l-0.717,2.194    c-0.232-0.006-0.465-0.01-0.697-0.01c-8.867,0-16.064,4.818-16.064,10.729H3.34c0-4.613,6.073-8.397,13.501-8.417l-2.771,8.483    l1.671-0.066l2.771-8.356c6.701,0.5,11.943,4.071,11.943,8.356h2.506C32.962,12.862,27.009,8.391,19.261,7.625L19.261,7.625z"/>
	                                        </g>
                                        </g>
                                    </svg>
                                    <p  clasts="sort_tip_name"><@spring.message code="non_demolition_qubits" /></p>
                                    <p  class="sort_tip_hw"><@spring.message code="creg_results_qubit" /></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="Layer_sort_con odd  sort_con_even">
                        <div class="sort_con_title "><@spring.message code="code_collection" />：</div>
                        <div class="sort_con_list">
                            <ul>
                                <li id="GHZ2" type="GHZ2"  xNum="2" yNum="2" imgName="GHZ2.png">
                                    <div class="odd">GHZ</div>
                                    <div class="even">(2)</div>
                                    <p  class="sort_tip_hw"><@spring.message code="entangled_state2" /></p>
                                </li>
                                <li id="GHZ3" type="GHZ3"  xNum="3" yNum="3" imgName="GHZ3.png">
                                    <div class="odd">GHZ</div>
                                    <div class="even">(3)</div>
                                    <p  class="sort_tip_hw"><@spring.message code="entangled_state3" /></p>
                                </li>
                                <li id="GHZ6" type="GHZ6"  xNum="6" yNum="6" imgName="GHZ6.png">
                                    <div class="odd">GHZ</div>
                                    <div class="even">(6)</div>
                                    <p  class="sort_tip_hw"><@spring.message code="entangled_state6" /></p>
                                </li>
                                <li id="QFT3" type="QFT3" xNum="6" yNum="3" imgName="QFT3.png">
                                    <div class="odd">QFT</div>
                                    <div class="even">(3)</div>
                                    <p  class="sort_tip_hw"><@spring.message code="Quantum_Fourier" /></p>
                                </li>
                                <li id="QFT4" type="QFT4"  xNum="10" yNum="4" imgName="QFT4.png">
                                    <div class="odd">QFT</div>
                                    <div class="even">(4)</div>
                                    <p  class="sort_tip_hw"><@spring.message code="Quantum_Fourier_four" /></p>
                                </li>
                                <li id="CZ" type="CZ" xNum="3" yNum="2" imgName="CZ6.png">
                                    <span>CZ</span>
                                    <p  class="sort_tip_hw"><@spring.message code="Control_Z_door" /></p>
                                </li>
                                <li style="line-height:16px;" class="p5"  id="z-CNOT" type="z-CNOT" xNum="3" yNum="2" imgName="z-CNOT.png">
                                    <span>
                                        Z-</br>
                                        CONT
                                    </span>
                                    <p  class="sort_tip_hw"><@spring.message code="control_non_gate" /></p>
                                </li>
                                <li class="p5" id="SWAP" type="SWAP"  xNum="3" yNum="2" imgName="SWAP.png">
                                    <span>SWAP</span>
                                    <p  class="sort_tip_hw"><@spring.message code="swap_gate" /></p>

                                </li>
                                <li class="p5" id="H6" type="H6" class="pic-blue f34" xNum="1" yNum="6" imgName="H6.png">
                                    <span>H(6)</span>
                                    <p  class="sort_tip_hw"><@spring.message code="Preparation6_bit_states" /></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="Layer_sort_con  sort_con_even" style="display: none">
                        <div class="sort_con_title"><@spring.message code="A_key_to_add" />：</div>
                        <div class="sort_con_list ">
                            <ul>
                                <li>
                                    <a href="${base}/QCode/index.html?projectId=257" style="display:block;">
                                        <div class="odd">D-J</div>
                                        <div class="even"><@spring.message code="algorithm" /></div>
                                        <p  class="sort_tip_hw">D-J算法介绍</p>
                                    </a>

                                </li>
                                <li>
                                    <div class="odd">Grover</div>
                                    <div class="even"><@spring.message code="algorithm" /></div>
                                    <p  class="sort_tip_hw">Grover算法介绍</p>
                                </li>
                                <li>
                                    <div class="odd">HHL</div>
                                    <div class="even"><@spring.message code="algorithm" /></div>
                                    <p  class="sort_tip_hw">HHL算法介绍</p>
                                </li>
                                <li>
                                    Game
                                    <p  class="sort_tip_hw">Game介绍</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="MyProContent">
        <div class="MyProBox clearfix">
            <div class="ProDetails newProject" style="display: none">
                <a href="javascript:;" onclick="CloudCLD.openAdd();">
                    <img src="${base}/assets/images/newProject.png" alt="">
                    <p>新建项目</p>
                </a>
            </div>
                <#if (qcodeProject.id?? && !(qcodeProject.id=257||qcodeProject.id=258))&&(qcodeProject.taskTypeId?? && qcodeProject.taskTypeId!=3)>
                    <#if versionMapList?? && versionMapList?size gt 0 >
                        <#list versionMapList as versionMap>
                                <div class="ProDetails HosProject">
                                    <p class="HosTitle">
                                            <#if lang?? && lang?string=="en_US">${qcodeProject.nameEnglish!''}<#else>${(qcodeProject.name)!}</#if>
                                        #${(versionMap.version).name!}
                                    </p>
                                    <div class="HosStateBox">
                                        <ul>
                                            <#if (versionMap.taskList)?? && (versionMap.taskList)?size gt 0 >
                                                <#list versionMap.taskList as task>
                                                <#--等待-->
                                                    <#if task.status??&&task.status=='1' &&task_has_next??>
                                                    <li class="projectList clearfix">
                                                        <div class="proListTop">
                                                            <div class="state"><@spring.message code="Project_status" />： <span class="green"><@spring.message code="task_status_waiting" /></span></div>
                                                            <div class="sTime"><span>${task.startTime?string("yyyy-MM-dd HH:mm")}</span></div>
                                                        </div>
                                                        <div class="proOperation">
                                                            <a onclick="CloudCLD.terminateTask(${task.id!});" class="gerColor"><@spring.message code="task_status_termination" /></a>
                                                            <a onclick="CloudCLD.delTask(${task.id!});" class="delColor"><@spring.message code="task_status_delete" /></a>
                                                        </div>
                                                    </li>
                                                    <#--处理中-->
                                                    <#elseif task.status??&&task.status=='2'>
                                                         <li class="projectList clearfix">
                                                             <div class="proListTop">
                                                                 <div class="state"><@spring.message code="Project_status" />： <span class="green"><@spring.message code="task_status_process" /></span></div>
                                                                 <div class="sTime"><span>${task.startTime?string("yyyy-MM-dd HH:mm")}</span></div>
                                                             </div>
                                                             <div class="proOperation">
                                                                 <a onclick="CloudCLD.terminateTask(${task.id!});" class="gerColor"><@spring.message code="task_status_termination" /></a>
                                                                 <a onclick="CloudCLD.delTask(${task.id!});" class="delColor"><@spring.message code="task_status_delete" /></a>
                                                             </div>
                                                         </li>
                                                    <#--完成-->
                                                    <#elseif task.status??&&task.status=='3'&&!ur_has_next>
                                                       <li class="projectList clearfix">
                                                           <div class="proListTop">
                                                               <div class="state"><@spring.message code="Project_status" />： <span class="blue"><@spring.message code="task_status_complete" /></span></div>
                                                               <div class="sTime"><span>${task.startTime?string("yyyy-MM-dd HH:mm")}</span></div>
                                                           </div>
                                                           <div class="proOperation">
                                                               <a onclick="CloudCLD.showData(${task.id!});"><@spring.message code="task_status_result" /></a>
                                                               <a onclick="CloudCLD.delTask(${task.id!});" class="delColor"><@spring.message code="task_status_delete" /></a>
                                                           </div>
                                                       </li>
                                                    <#--语法错误-->
                                                    <#elseif task.status??&&task.status=='4'>
                                                        <li class="projectList clearfix">
                                                            <div class="proListTop">
                                                                <div class="state"><@spring.message code="Project_status" />： <span class="green"><@spring.message code="task_status_syntactic_error" /></span></div>
                                                                <div class="sTime"><span>${task.startTime?string("yyyy-MM-dd HH:mm")}</span></div>
                                                            </div>
                                                            <div class="proOperation">
                                                                <a onclick="CloudCLD.delTask(${task.id!});" class="gerColor"><@spring.message code="task_status_delete" /></a>
                                                            </div>
                                                        </li>
                                                    <#--任务终止-->
                                                    <#else>
                                                        <li class="projectList clearfix">
                                                            <div class="proListTop">
                                                                <div class="state"><@spring.message code="Project_status" />： <span class="green"><@spring.message code="task_status_terminated" /></span></div>
                                                                <div class="sTime"><span>${task.startTime?string("yyyy-MM-dd HH:mm")}</span></div>
                                                            </div>
                                                            <div class="proOperation">
                                                                <a onclick="CloudCLD.delTask(${task.id!});" class="sotColor"><@spring.message code="task_status_delete" /></a>
                                                            </div>
                                                        </li>
                                                    </#if>
                                                </#list>
                                            </#if>
                                        </ul>
                                    </div>
                                    <div class="ProDetailsLeft">
                                        <div class="HosImgBox" onclick="CloudCLD.getVersion(${(versionMap.version).id!});">
                                            <#if (versionMap.version).pic??&&(versionMap.version).pic!=''>
                                                <img src="/${setting['files.contextpath']}${(versionMap.version).pic?replace("\\","/")}" width="192" height="120"/>
                                            <#else>
                                                <img src="${base}/assets/images/pic.jpg"/>
                                            </#if>
                                        </div>
                                        <div class="HosProjectJs">
                                            <div class="HosProjectJscontent">项目描述：量子链是首个兼
                                                容比特币UTXO模型和以太坊虚拟机（EVM）的PoS智能合约平台，通
                                                过全新设计的账户抽象层（AAL）将比特币和以太坊生态连接。量子链

                                                “面向移动端”的战略将会促进区块链技术的产品化并提高区块链行业
                                                的易用性，搭建区块链与真实商业社会的桥梁。量子链的开发团队不
                                                仅集合了来自于比特币和以太坊社区的开发者
                                                ，还有来自于全球知名企业的人才（如百度、阿里巴巴、腾讯、纳斯达克等）。</div>
                                        </div>
                                    </div>
                                    <a href="javascript:;" onclick="CloudCLD.delVersion(${(versionMap.version).id!});" class="HosProjectDel">&times;</a>
                                </div>
                        </#list>
                        </div>
                    </#if>
                </#if>
            <div class="MyPrijectAll">
                <a href="javascript:void (0);" onclick="saveProject()"><@spring.message code="View_more" /></a>
            </div>
        </div>
    </div>
    </div>
    <style>
        /*模态框样式修改*/
        .modal-header{height: 50px;border: none;font-size: 18px;color: #fff;line-height: 20px;background: #178cec;}
        button.close{opacity:1;}
        button.close:hover{opacity:1;}
        .modal-body .contentt{padding: 25px 75px 0;}
        .modal-body{padding: 0;}
        .modal-footer{border-top: none;}
        .form-group label{padding-left: 0;font-size: 16px;color: #333;width: 90px;text-align: left;}
        .form-horizontal .control-label{text-align: left;}
        .contentt .col-sm-9{width: 400px;}
        #myModa4 .form-horizontal .form-group .col-sm-9 input,.contentt .col-sm-9 input{box-shadow: none;padding-left: 12px;width: 100%;font-size: 14px;color: #333;border: 1px solid #808080;line-height: 36px;height: 36px;}
        .contentt .col-sm-9 input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {  color: #333;  }
        .contentt .col-sm-9 input:-moz-placeholder, textarea:-moz-placeholder {  color:#333;}
        .contentt .col-sm-9 input::-moz-placeholder, textarea::-moz-placeholder {  color:#333; }
        .contentt .col-sm-9 input:-ms-input-placeholder, textarea:-ms-input-placeholder {  color:#333;  }
        .contentt .col-sm-9 textarea::-webkit-input-placeholder, textarea::-webkit-input-placeholder {  color: #808080;  }
        .contentt .col-sm-9 textarea:-moz-placeholder, textarea:-moz-placeholder {  color:#808080;}
        .contentt .col-sm-9 textarea::-moz-placeholder, textarea::-moz-placeholder {  color:#808080; }
        .contentt .col-sm-9 textarea:-ms-input-placeholder, textarea:-ms-input-placeholder {  color:#808080;  }
        #myModa4 .form-horizontal .form-group .col-sm-9 textarea, .contentt .col-sm-9 textarea{padding: 12px;color: #808080;box-shadow: none;width: 100%;border: 1px solid #808080;height: 100px;}
        .second{height: auto;}
        .modal-footer{padding: 20px 15px;margin-right: -70px;}
        .modal-footer button{padding: 7px 18px;border: none;background: #178cec;color: #fff;}
        .there .col-sm-6{width: 215px;padding: 0;margin-left: 30px;}
        .there .control-label{width: 257px;float: left;line-height: 16px;padding: 0;}
        .there .control-label{text-align: right;font-size: 16px;color: #333;}
        .there .control-label span{font-size: 14px;}
        #myModa4 .form-horizontal .form-group .col-sm-9 select,.there .col-sm-6 input,.there .col-sm-6 select{box-shadow: none;padding-left: 12px;width: 100%;font-size: 14px;color: #333;border: 1px solid #808080;line-height: 36px;height: 36px;}
        .modal-footer .prev{margin-right: 22px;}
        .modal-header button span{color:#fff;color: #fff;text-shadow: none;opacity: 1;font-weight: 400;font-size: 22px;line-height: inherit;font-family:'宋体';}
        #myModa4 .form-horizontal .form-group{margin: 20px 0;padding: 0 30px;}
        #myModa4 .form-horizontal .form-group .col-sm-9{padding: 0 0 0 28px;}
        #myModa4 .form-horizontal .form-group .control-label{text-align: right;padding-right: 0;}
        .modal-sm .modal-footer{margin-right: 0;}
        .modal-sm .modal-body{padding: 15px;}
    </style>
    <!-- Modal 项目新增-->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document" style="width:639px;"><!--style="width:294px;" -->
            <div class="modal-content" style="width: 639px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true" >&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"><@spring.message code="new" /></h4>
                </div>
                <div class="modal-body">
                    <div class="contentt clear">
                        <div class="first" id="vectoring1">
                            <input type="hidden" id="typeId" value="1">
                            <div class="zi">
                                <div class="zi-left" taskType="1" style="width:100%;">
                                    <p><strong style="font-size:18px"><@spring.message code="qemulator" /></strong></p>
                                    <p><@spring.message code="qemulator_1" /></p>
                                    <p><@spring.message code="qemulator_2" /></p>
                                    <p><@spring.message code="qemulator_3" /></p>
                                    <p><@spring.message code="qemulator_4" /></p>
                                    <span class="green f22 r block" style="position: absolute;bottom:0;right:10px">
                                    <i class="iconfont icon-duihao"></i>
                                </span>
                                </div>
                                <div class="zi-left" taskType="2" disabled="disabled" style="display:none;">
                                    <p><strong><@spring.message code="spcd_6q" /></strong></p>
                                    <p><@spring.message code="spcd_6q_1" /></p>
                                    <p><@spring.message code="spcd_6q_2" /></p>
                                    <p><@spring.message code="spcd_6q_3" /></p>
                                    <p><@spring.message code="spcd_6q_4" /></p>
                                    <span class="green f22 r none" style="position: absolute;bottom:0;right:10px">
                                    <i class="iconfont icon-duihao"></i>
                                </span>
                                    <p class="red" style="padding-bottom: 3px;"><@spring.message code="come_soon" /></p>
                                </div>
                                <div class="zi-left" taskType="3" style="display:none;">
                                    <p><strong><@spring.message code="semi_2q" /></strong></p>
                                    <p><@spring.message code="semi_2q_1" /></p>
                                    <p><@spring.message code="semi_2q_2" /></p>
                                    <p><@spring.message code="semi_2q_3" /></p>
                                    <p><@spring.message code="semi_2q_4" /></p>
                                    <span class="green f22 r none" style="position: absolute;bottom:0;right:10px">
                                    <i class="iconfont icon-duihao"></i>
                                </span>
                                    <p class="red" style="padding-bottom: 3px;"><@spring.message code="come_soon" /></p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="shows()"><@spring.message code="next" /></button>
                            </div>
                        </div>
                        <div class="second" id="vectoring2" style="display:none;">
                            <form class="form-horizontal">
                                <div class="form-group" style="margin-bottom: 28px">
                                    <label for="inputEmail3"
                                           class="col-sm-3 control-label"><@spring.message code="projectname" /></label>
                                    <div class="col-sm-9">
                                        <input type="hidden" id="projectTime"
                                               value="${.now?string('yyyyMMdd')}_${.now?string('HHmmss')}_">
                                        <input type="text" class="form-control" id="projectName" onkeydown="if(event.keyCode==13){event.keyCode=0;event.returnValue=false;}"
                                               placeholder="<@spring.message code='placeholder_projectName' />"
                                               maxlength="50">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom: 2px">
                                    <label for="inputEmail3"
                                           class="col-sm-3 control-label"><@spring.message code="projectdesc" /></label>
                                    <div class="col-sm-9">
                                        <textarea type="text" class="form-control" id="desc"
                                                  placeholder="<@spring.message code='placeholder_desc' />"
                                                  maxlength="500" style="resize:none;"></textarea>
                                    </div>
                                </div>
                            </form>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="previousStep(1)"><@spring.message code="previous" /></button>
                                <button type="button" class="btn btn-primary" onclick="showt()"><@spring.message code="next" /></button>
                            </div>
                        </div>
                        <div class="there" id="vectoring3" style="display:none;">
                            <form class="form-horizontal">
                                <div class="form-group" style="margin-bottom:28px">
                                    <label for="inputEmail6" class="col-sm-2 control-label" style="margin-top: 10px" id="analogTypeId"></label><!-- 模拟类型 -->
                                    <div class="col-sm-6">
                                        <select class="form-control" name="analogType" id="analogType" oninput="checkQubitNum(this)" onpropertychange="checkQubitNum(this)">
                                            <option value="0"><@spring.message code="monte_carlo_method" /></option>
                                            <option value="1"><@spring.message code="probability_method" /></option>
                                            <option value="2"><@spring.message code="Quantum_chip" /></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom:28px">
                                    <label for="inputEmail6" class="col-sm-2 control-label" id="qubitNumDesc"></label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" id="qubitNum"
                                               oninput="checkQubitNum(this)" onpropertychange="checkQubitNum(this)"
                                               onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)"
                                               onblur="this.v();">
                                    </div>
                                </div>
                                <div class="form-group" style="margin-bottom:0px">
                                    <label for="inputEmail8" class="col-sm-2 control-label" id="classicalbitNumDesc"></label>
                                    <div class="col-sm-6">
                                        <input type="" class="form-control" id="classicalbitNum" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();">
                                    </div>
                                </div>
                            </form>
                            <div class="modal-footer">
                                <#if isOldUser=='2'>
                                    <button type="button" class="btn btn-primary prev" onclick="previousStep(2);"><@spring.message code="previous" /></button>
                                    <button type="button" class="btn btn-primary" onclick="CloudCLD.visitorSaveProject();"><@spring.message code="save" /></button>
                                <#else>
                                    <button type="button" class="btn btn-primary prev" onclick="previousStep(2);"><@spring.message code="previous" /></button>
                                    <button type="button" class="btn btn-primary" onclick="CloudCLD.saveProject();"><@spring.message code="save" /></button>
                                </#if>

                            </div>
                        </div>
                        <div class="four" id="vectoring3" style="display: none;">
                            <div class="f-jiaocheng">
                                <input type="hidden" id="semi" value="1">
                                <ul>
                                    <li class="bbr" semi="1" style="height:200px;">
                                        <img src="${base}/assets/images/p1.png" width="100%"/>
                                        <h2><@spring.message code="dj_demonstration_of_qubit_1" /></h2>
                                        <p><strong>f(x)=0</strong></p>
                                        <p style="text-align: left;font-size: 12px;display: none;"><@spring.message code="dj_demonstration_of_qubit_desc_1" /></p>
                                        <span class="green f22  none"><i class="iconfont icon-duihao"></i></span>
                                    </li>
                                    <li semi="2" style="height:200px;">
                                        <img src="${base}/assets/images/p2.png" width="100%"/>
                                        <h2><@spring.message code="dj_demonstration_of_qubit_2" /></h2>
                                        <p><strong>F（x）=1</strong></p>
                                        <p style="text-align: left;font-size: 12px;display: none;"><@spring.message code="dj_demonstration_of_qubit_desc_2" /></p>
                                        <span class="green f22  none"><i class="iconfont icon-duihao"></i></span>
                                    </li>
                                    <li semi="3" style="height:200px;">
                                        <img src="${base}/assets/images/p3.png" width="100%"/>
                                        <h2><@spring.message code="dj_demonstration_of_qubit_3" /></h2>
                                        <p><strong>F（x）=x</strong></p>
                                        <p style="text-align: left;font-size: 12px;display: none;"><@spring.message code="dj_demonstration_of_qubit_desc_3" /></p>
                                        <span class="green f22  none"><i class="iconfont icon-duihao"></i></span>
                                    </li>
                                    <li semi="4" style="height:200px;">
                                        <img src="${base}/assets/images/p4.png" width="100%"/>
                                        <h2><@spring.message code="dj_demonstration_of_qubit_4" /></h2>
                                        <p><strong>F（x）=x </strong></p>
                                        <p style="text-align: left;font-size: 12px;display: none;"><@spring.message code="dj_demonstration_of_qubit_desc_4" /></p>
                                        <span class="green f22  none"><i class="iconfont icon-duihao"></i></span>
                                    </li>
                                </ul>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="CloudCLD.saveProject();"><@spring.message code="save" /></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
                <div class="modal-body" id="taskResult"></div>
                <div class="zxjg">
                    <ul>
                        <li id="startTime"><@spring.message code="execution_time" />：</li>
                        <li id="endTime"><@spring.message code="finish_time" />：</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="myModa3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close closeBtn" aria-label="Close" data-dismiss="modal" style="display:block;" id="closeBtn"><span aria-hidden="true">×</span></button>
                    <h4 class="modal-title" id="myModalLabe3"><@spring.message code="running" /></h4>
                </div>
                <div class="modal-body">
                    <div class="page">
                        <div class="circle-loader">
                            <div class="circle-line">
                                <div class="circle circle-blue"></div>
                                <div class="circle circle-blue"></div>
                                <div class="circle circle-blue"></div>
                            </div>
                            <div class="circle-line">
                                <div class="circle circle-yellow"></div>
                                <div class="circle circle-yellow"></div>
                                <div class="circle circle-yellow"></div>
                            </div>
                            <div class="circle-line">
                                <div class="circle circle-red"></div>
                                <div class="circle circle-red"></div>
                                <div class="circle circle-red"></div>
                            </div>
                            <div class="circle-line">
                                <div class="circle circle-green"></div>
                                <div class="circle circle-green"></div>
                                <div class="circle circle-green"></div>
                            </div>
                        </div>
                    </div>

                    <div class="progress_bar">
                        <div class="pro-bar">
                            <small class="progress_bar_title">
                                <span id="randomValue"><@spring.message code="first_click_prompt" /></span>
                            <#--<span class="progress_number"><@spring.message code="progress" />:0%</span>-->
                            </small>
                        <#--<span class="progress-bar-inner" style="background-color: #049dff; width: 0;" data-value="0" data-percentage-value="0"></span>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModa4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content vectoring22">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabe4"><@spring.message code="edit_project" /></h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmai25" class="col-sm-2 control-label" style="width:130px;" id="analogTypeId"><@spring.message code="analog_type" /></label><!-- 模拟类型 -->
                            <div class="col-sm-9">
                                <select class="form-control" name="analogType" id="analogType" disabled>
                                    <option value="0"
                                            <#if qcodeProject.analogType?? && qcodeProject.analogType?string=="0">selected</#if>><@spring.message code="monte_carlo_method" /></option>
                                    <option value="1"
                                            <#if qcodeProject.analogType?? && qcodeProject.analogType?string=="1">selected</#if>><@spring.message code="probability_method" /></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmai20" class="col-sm-2 control-label" style="width:130px;"><@spring.message code="number_of_qubits" /></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="inputEmai20"
                                       value="${(qcodeProject.qubitNum)!20}" readOnly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmai21" class="col-sm-2 control-label" style="width:130px;"><@spring.message code="number_of_classical_registers" /></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="inputEmai21"
                                       value="${(qcodeProject.classicalbitNum)!255}" readOnly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmai22" class="col-sm-2 control-label" style="width:130px;"><@spring.message code="name_of_classical_registers" /></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="inputEmai22" value="c" readOnly>
                            </div>
                        </div>
                        <#if qcodeProject.analogType?? && (qcodeProject.analogType?string=="0" || qcodeProject
                        .analogType?string=="2")>
                            <div class="form-group">
                                <label for="inputEmai23" class="col-sm-2 control-label" style="width:130px;"><@spring.message code="measurement_repeat_times" />(1-8192)</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="updateRepeat" value="${(qcodeProject.repeat)!100}"
                                           onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,'');}).call(this)" onblur="this.v();">
                                </div>
                            </div>
                        </#if>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label" style="width:130px;"><@spring.message code="projectdesc" /></label>
                            <div class="col-sm-9">
                                <textarea type="text" class="form-control" id="updateDesc" maxlength="500" style="resize:none;"><#if lang?? && lang?string=="en_US">${qcodeProject.descEnglish!''}<#else>${qcodeProject.desc!''}</#if></textarea>
                            </div>
                        </div>
                    </form>
                    <div class="modal-footer" style="margin-right: 0;padding-right: 30px">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="CloudCLD.updateProject();"><@spring.message code="save" /></button>
                    </div>
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
                <div class="modal-body"><@spring.message code="isContinue" /></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><@spring.message code="close" /></button>
                    <button type="button" class="btn btn-primary"><@spring.message code="save" /></button>
                </div>
            </div>
        </div>
    </div>
    <!--遮罩-->
    <div id="isOldUser" style="display: none">${isOldUser!}</div>
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
    <#--新手引导-->
    <div class="guideContentBg"></div>
    <div class="guideContent">
        <div class="guideId1">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointTo.png" alt="点击"></div>
                <div class="guideText">点击这里</br>可以新建一个项目</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(2)">下一步</a></div>
                </div>
            </div>
        </div>
        <div class="guideId2">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">量子仿真 <span>QEmulator</span></br>点击下一步</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;"  onclick="CloudCLD.nextStep(3)">下一步</a></div>
                </div>
            </div>
        </div>
        <div class="guideId3">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">修改您的项目名称及添加备注说明</br>然后执行下一步操作</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(4)">下一步</a></div>
                </div>
            </div>
        </div>
        <div class="guideId4">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">点击保存进入下一步</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;"  onclick="CloudCLD.nextStep(5)">下一步</a></div>
                </div>
            </div>
        </div>

        <#--下一段引导-->
        <div class="guideId6">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">在这里可以选择自己想要操作的比特门</br>点击下一步</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(7)">下一步</a></div>
                </div>
            </div>

        </div>
        <div class="guideId7">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">点击这里</br>出现可供使用的量子逻辑门操作</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>

        <#--打开弹窗-->
        <div class="guideId8">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">点击这里</br>出现可供使用的量子逻辑门操作</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(9)">下一步</a></div>
                </div>
            </div>
        </div>
        <#--单比特门插入-->
        <div class="guideId9">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">可供使用的量子逻辑门操作。</br>点击下一步</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(10)">下一步</a></div>
                </div>
            </div>

        </div>

        <div class="guideId10">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键选择插入量子比特门的位置。</br>点击这里</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId11">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键选择要插入的单比特门。</br>点击这里</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>

        </div>
        <div class="guideId12">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">恭喜！您已成功插入单量子比特门</br>点击下一步
                </div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(13)">下一步</a></div>
                </div>
            </div>
        </div>
    <#--多比特门插入-->
        <div class="guideId13">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键</br>选择将要放置受控比特门的位置
                </div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>

        </div>
        <div class="guideId14">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键，选择要插入的两比特量子门</br>点击这里</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                <#--<div class="guide_next_box"><a href="javascript:;" onclick="nextStep(8)">下一步</a></div>-->
                </div>
            </div>

        </div>
        <div class="guideId15">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键，选择此列中的控制比特的点</br></div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId16">
        <div class="guide_con">
            <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
            <div class="guideText">操作成功，点击下一步继续操作</br></div>
            <div class="guide_function clearfix">
                <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(17)">下一步</a></div>
            </div>
        </div>
    </div>
        <#--测量门插入-->
        <div class="guideId17">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">下面将要在量子线路中插入测量操作</br>请单击选择需要测量的线路上的点</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId18">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键选择测量图标</br></div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId19">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">你已完成比特的测量操作</br>这里可以选择测量结果对应的经典寄存器</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(20)">下一步</a></div>
                </div>
            </div>
        </div>

        <div class="guideId20">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键选择需要测量的点</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId21">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">单击左键选择测量图标</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div>
                </div>
            </div>
        </div>
        <div class="guideId22">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToLeft.png" alt="点击"></div>
                <div class="guideText">你已完成两个比特的测量操作</br>点击下一步</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(23)">下一步</a></div>
                </div>
            </div>
        </div>

        <#--编辑-->
        <div class="guideId23">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointTo.png" alt="点击"></div>
                <div class="guideText">点击这里</br>可以编辑一个项目</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(24)">下一步</a></div>
                </div>
            </div>
        </div>
        <div class="guideId24">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointToRight.png" alt="点击"></div>
                <div class="guideText">可以修改重复实验次数及保存</div>
                <div class="guide_function clearfix">
                    <div class="guide_close_box"><a href="javascript:;">我知道了，马上体验</a></div>
                    <div class="guide_next_box"><a href="javascript:;" onclick="CloudCLD.nextStep(25)">下一步</a></div>
                </div>
            </div>

        </div>
        <#--运行-->
        <div class="guideId25">
            <div class="guide_con">
                <div class="pointTo"><img src="${base}/assets/images/pointTo.png" alt="点击"></div>
                <div class="guideText">点击运行</div>
                <div class="guide_function clearfix"><div class="guide_close_box one"><a href="javascript:;">我知道了，马上体验</a></div></div>
            </div>
        </div>
    </div>
    <div id="qcodeProjectNameEnglish" style="display:none;">${qcodeProject.nameEnglish!}</div>
    </#escape>
</@main.body>
<@main.footer>
<#--edit start-->
<script type="text/javascript" src="${base}/assets/js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="${base}/assets/js/qcode.js?1.1"></script>
<script type="text/javascript" src="${base}/assets/js/noty/jquery.noty.packaged.js"></script>
<script type="text/javascript" src="${base}/assets/js/echarts/echarts.js" data-url="${base}/assets/js/echarts/echarts.js" ></script>
<script type="text/javascript" data-url="${base}/assets/js/echarts/macarons.js"></script>
<link rel="stylesheet" href="${base}/assets/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="${base}/assets/codemirror/addon/fold/foldgutter.css">
<link rel="stylesheet" href="${base}/assets/codemirror/addon/dialog/dialog.css">
<link rel="stylesheet" href="${base}/assets/codemirror/theme/monokai.css">
<script src="${base}/assets/codemirror/lib/codemirror.js"></script>
<script src="${base}/assets/codemirror/addon/search/searchcursor.js"></script>
<script src="${base}/assets/codemirror/addon/search/search.js"></script>
<script src="${base}/assets/codemirror/addon/dialog/dialog.js"></script>
<script src="${base}/assets/codemirror/addon/edit/matchbrackets.js"></script>
<script src="${base}/assets/codemirror/addon/edit/closebrackets.js"></script>
<script src="${base}/assets/codemirror/addon/comment/comment.js"></script>
<script src="${base}/assets/codemirror/addon/wrap/hardwrap.js"></script>
<script src="${base}/assets/codemirror/addon/fold/foldcode.js"></script>
<script src="${base}/assets/codemirror/addon/fold/brace-fold.js"></script>
<script src="${base}/assets/codemirror/mode/javascript/javascript.js"></script>
<script src="${base}/assets/codemirror/keymap/sublime.js"></script>
<#--edit end-->
<script type="text/javascript" src="${base}/assets/js/code2Trans.js"></script>
<script type="text/javascript" src="${base}/assets/js/dragTrans.js"></script>
<script>

    var lineTS=${qcodeProject.qubitNum!};
    var tabIndex = 0;
    var qubitNum = ${(qcodeProject.qubitNum)?default(6)};
    var classicalbitNum = ${(qcodeProject.classicalbitNum)?default(6)};
    var base = "${base!''}";
    //模拟类型 默认Monte-Carlo类型    //判断类型，类型为2 时，代表量子芯片
    var analogType = ${(qcodeProject.analogType)?default(0)};
    var interval;
    fromAdmin = "${fromAdmin!''}";
    var lan = '${lang}';
    var trans2CodeStatus = 0;//0：表示转换未完成，1：表示转换完成
    var analogType = ${qcodeProject.analogType};

     <#if lang?? && lang?string=="en_US">
         var qcodeProjectName = $("#qcodeProjectNameEnglish").text().replace(/(^\s*)|(\s*$)/g,"");
     <#else>
         var qcodeProjectName = " ${(qcodeProject.name)!}";
     </#if>
    var userLevel = '${USER_INFO.level!1}'; //用户等级
    var isOldUser = ${isOldUser!};

    function saveProject() {
        <#if USER_INFO??>
            window.location.href = "${base}/QCode/project.html";
        <#else>
            viewLoginMin();
        </#if>

    }
    Operating_instructions="<@spring.message code="Operating_instructions" />";
    CloudCLD = new Cloud({});
    CloudCLD.init();

//    界面滚动条
    $("#modRight_center").niceScroll({
        cursoropacitymin: 0, // 当滚动条是隐藏状态时改变透明度, 值范围 1 到 0
        cursoropacitymax: 1, // 当滚动条是显示状态时改变透明度, 值范围 1 到 0
        cursorwidth: "8px", // 滚动条的宽度，单位：便素
        cursorborder: "", // CSS方式定义滚动条边框
        cursorborderradius: "", // 滚动条圆角（像素）
        scrollspeed: 60, // 滚动速度
        mousescrollstep: 40, // 鼠标滚轮的滚动速度 (像素)
        touchbehavior: false, // 激活拖拽滚动
        hwacceleration: true, // 激活硬件加速
        background: "#e1e1e1",// 轨道的背景颜色
        cursorcolor:'#178cec',
        autohidemode: false, // 隐藏滚动条的方式, 可用的值:
        // true | // 无滚动时隐藏
        // "cursor" | // 隐藏
        // false | // 不隐藏,
        // "leave" | // 仅在指针离开内容时隐藏
        // "hidden" | // 一直隐藏
        // "scroll", // 仅在滚动时显示
        railoffset:false
    });
    // free your immagination

    // $("#ascrail2000-hr").remove().appendTo("#contentCenter");
    // resizeScroll();
    $(".box-right").getNiceScroll().resize();

    //编辑器外点击隐藏悬浮框
    $('.NewBox').on('click',function () {
        $(".LayerContent").hide();
    })
</script>
</@main.footer>