<!DOCTYPE html>
<html lang="en">
<head>
    <title>分享</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="视频分享">
    <meta name="keywords" content="本源量子">
    <meta name="author" content="">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="Cache-Control" content="no-transform ">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="shortcut icon" href="http://learn-quantum.com/assets/images/favicon.ico">
    <#--界面缩放JS-->
    <script>
        ; (function (win, lib) {
            var doc = win.document;
            var docEl = doc.documentElement;
            var metaEl = doc.querySelector('meta[name="viewport"]');
            var flexibleEl = doc.querySelector('meta[name="flexible"]');
            var dpr = 0;
            var scale = 0;
            var tid;
            var flexible = lib.flexible || (lib.flexible = {});

            if (metaEl) {
                // console.warn('将根据已有的meta标签来设置缩放比例');
                var match = metaEl.getAttribute('content').match(/initial\-scale=([\d\.]+)/);
                if (match) {
                    scale = parseFloat(match[1]);
                    dpr = parseInt(1 / scale);
                }
            } else if (flexibleEl) {
                var content = flexibleEl.getAttribute('content');
                if (content) {
                    var initialDpr = content.match(/initial\-dpr=([\d\.]+)/);
                    var maximumDpr = content.match(/maximum\-dpr=([\d\.]+)/);
                    if (initialDpr) {
                        dpr = parseFloat(initialDpr[1]);
                        scale = parseFloat((1 / dpr).toFixed(2));
                    }
                    if (maximumDpr) {
                        dpr = parseFloat(maximumDpr[1]);
                        scale = parseFloat((1 / dpr).toFixed(2));
                    }
                }
            }

            if (!dpr && !scale) {
                var isAndroid = win.navigator.appVersion.match(/android/gi);
                var isIPhone = win.navigator.appVersion.match(/iphone/gi);
                var devicePixelRatio = win.devicePixelRatio;
                if (isIPhone) {
                    // iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案
                    if (devicePixelRatio >= 3 && (!dpr || dpr >= 3)) {
                        dpr = 3;
                    } else if (devicePixelRatio >= 2 && (!dpr || dpr >= 2)) {
                        dpr = 2;
                    } else {
                        dpr = 1;
                    }
                } else {
                    // 其他设备下，仍旧使用1倍的方案
                    dpr = 1;
                }
                scale = 1 / dpr;
            }

            docEl.setAttribute('data-dpr', dpr);
            if (!metaEl) {
                metaEl = doc.createElement('meta');
                metaEl.setAttribute('name', 'viewport');
                metaEl.setAttribute('content', 'initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
                if (docEl.firstElementChild) {
                    docEl.firstElementChild.appendChild(metaEl);
                } else {
                    var wrap = doc.createElement('div');
                    wrap.appendChild(metaEl);
                    doc.write(wrap.innerHTML);
                }
            }

            function refreshRem() {
                var width = docEl.getBoundingClientRect().width;
                if (width / dpr > 540) {
                    width = 540 * dpr;
                }
                var rem = width / 10;
                docEl.style.fontSize = rem + 'px';
                flexible.rem = win.rem = rem;
            }

            win.addEventListener('resize', function () {
                clearTimeout(tid);
                tid = setTimeout(refreshRem, 300);
            }, false);
            win.addEventListener('pageshow', function (e) {
                if (e.persisted) {
                    clearTimeout(tid);
                    tid = setTimeout(refreshRem, 300);
                }
            }, false);

            if (doc.readyState === 'complete') {
                doc.body.style.fontSize = 12 * dpr + 'px';
            } else {
                doc.addEventListener('DOMContentLoaded', function (e) {
                    doc.body.style.fontSize = 12 * dpr + 'px';
                }, false);
            }


            refreshRem();

            flexible.dpr = win.dpr = dpr;
            flexible.refreshRem = refreshRem;
            flexible.rem2px = function (d) {
                var val = parseFloat(d) * this.rem;
                if (typeof d === 'string' && d.match(/rem$/)) {
                    val += 'px';
                }
                return val;
            }
            flexible.px2rem = function (d) {
                var val = parseFloat(d) / this.rem;
                if (typeof d === 'string' && d.match(/px$/)) {
                    val += 'rem';
                }
                return val;
            }

        })(window, window['lib'] || (window['lib'] = {}));
    </script>
    <style>
        body{
            width: 100%;
            height: 100%;
            position: relative;
            padding: 0;
            margin: 0;
        }
        #shareBg{
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("../../../assets/images/EduImg/share_bg.png");
            background-repeat: no-repeat;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        header{
            position: relative;
            padding-top: 0.8rem;
            width: 100%;
            text-align: center;
            height: 1.026666rem;
        }
        header img{
            width: 2.066666rem;
            height: 1.026666rem;
        }
        main{

            width: 100%;
            height: auto;
            position: relative;

        }
        #wrapper{
            padding: 0.53333rem 0.533rem 1.5rem;
        }
        #middle{
            width: 100%;
            height: 11.54rem;
            background: url("../../../assets/images/EduImg/share_conBg.png") no-repeat;
            margin: 0 auto;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        .footer{
            width: 100%;
            margin-top: 0.26rem;
            height: 2.933333333rem;
            background: url("../../../assets/images/EduImg/share_footerBg.png") no-repeat;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        .middle_con{
            position: relative;
            padding:0.8rem  1.293333rem  0;
        }
        .middle_img{
            width: 100%;
            text-align: center;
            margin-bottom: 0.8rem;
            /*height: 2.66666666666666666rem;*/
        }
        .middle_img img{
            height: 2.66666666666666666rem;
            max-width: 100%;
        }
        .middle_imgBig{

            height: 6.34666rem;
            width: 100%;
            text-align: center;
        }
        .middle_imgBig img{
            max-height: 6.34666rem;
            max-width: 100%;
            width: 100%;
        }
        .middleInfo{
            width: 100%;
            height: 3rem;
            /*height: 3.6rem;*/
        }
        .middleInfo p{
            margin: 0;
            font-size: 0.293333333333rem;
            /*font-size: 22px;*/
            color: #1a1a1a;
            padding: 0;
            line-height:0.5866667rem;

        }
        .middleInfo .middleInfo_gui{
            text-align: right;
            font-size: 0.28rem;
            /*font-size: 0.24rem;*/
            /*font-size: 18px;*/

        }
        .userInfo{
            width: 100%;
            margin-top: 1.2rem;
            height: 3.2rem;
        }
        .userInfoPhoto{
            width: 0.88rem;
            height: 0.88rem;
            max-width: 66px;
            max-height: 66px;
            overflow: hidden;
            border-radius: 50%;
            /*padding: 0.22rem 0;*/
            margin: 0 auto 0.22rem;
            -moz-box-shadow:0px 1px 6px #333333; -webkit-box-shadow:0px 1px 6px #333333; box-shadow:0px 1px 6px #333333;
        }
        .userInfoPhoto img{
            width: 0.88rem;
            height: 0.88rem;
        }
        .userInfoName{
            width: 100%;
            height: 0.48rem;
            text-align: center;
            overflow: hidden;
            font-size:0.34666666rem;
            color: #1a1a1a;
        }
        .userInfoDesignation{
            text-align: center;
        }
        #footerBox{
            overflow: hidden;
            padding: 0.66rem 0.8rem 0;
        }
        .footerLeft{
            float: left;
        }

        .FLTitle{
            font-size: 0.2933333rem;
            font-weight: normal;
            /*margin: 0 0 0.266667rem 0;*/
            margin: 0 0 0.14rem 0;
            /*margin: 0;*/
        }
        .FLBox{
            overflow: hidden;
        }
        .FLBox>div{
            float: left;
        }
        .FLBox>div.FlDay2{
            font-size: 1.2rem;
            line-height: 1.2rem;
            color: #4481e7;
            margin: 0 0.02rem;
        }
        .FLBox>div.FlDay1,.FLBox>div.FlDay3{
            color: #1a1a1a;
            font-size: 0.373333rem;
            margin-top: 0.55rem;
        }
        .footerRight{
            float: right;
            text-align: center;
        }
        .footerRight .codeImg{
            width: 1.413333rem;
            height: 1.413333rem;
        }
        .footerRight .codeImg img{
            width: 100%;
            height: 100%;
        }
        .footerRight span{
            color: #808080;
            font-size: 0.24rem;
        }
        .userInfoDesignation{
            margin: 0 auto;
            width: 1.1733333333333rem;
        }
        #middle_con{
            height: 6.2rem;
            overflow: hidden;
        }
        .userInfoDesignation img{
            width: 100%;
        }
        .module_con {
            overflow: hidden;
            padding: 0.8rem 0;
        }
        .module_con div{
            float: left;
            width: 50%;
            text-align: center;
        }
        .module_con_right img{
            width: 2.4rem;

        }
        .module_con_left{
            display: flex;
            height: 2.82666rem;
            justify-content:center;
            align-items:Center;
        }
        .module_{
            height: 2rem;
        }
        .middleInfo p span{
            color: #4688f1;
        }
    </style>
<body style="font-size: 12px">
    <div class="containerImages" style="position: relative;">
        <div id="shareBg"></div>
        <header>
            <img src="${base}/assets/images/EduImg/share_logo.png" alt="">
        </header>

        <main>
            <div id="wrapper">
                <div id="middle" class="container">
                    <div class="middle_con">
                        <div id="middle_con"></div>
                        <div class="userInfo">
                            <div style="padding-top: 0.22rem"></div>



                            <div class="userInfoPhoto">
                            <#if (USER_INFO.face)?exists>
                                <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="">
                            <#else>
                                <img src="${base}/assets/images/wx_new1.jpg" alt="">
                            </#if>
                            </div>
                            <div class="userInfoName">
                            <#if (USER_INFO.name)?exists>
                                ${USER_INFO.name}
                            <#else>

                            </#if>
                            </div>
                            <div class="userInfoDesignation">
                            <#if (level.level)?exists>

                                <#switch level.level>
                                    <#case "量子浪客">
                                        <img src="${base}/assets/images/EduImg/level1.png" alt="">
                                        <#break>
                                    <#case "量子剑心">
                                        <img src="${base}/assets/images/EduImg/level2.png" alt="">
                                        <#break>
                                    <#case "量子名士">
                                        <img src="${base}/assets/images/EduImg/level3.png" alt="">
                                        <#break>
                                    <#case "量子大师">
                                        <img src="${base}/assets/images/EduImg/level4.png" alt="">
                                        <#break>
                                    <#case "量子巨匠">
                                        <img src="${base}/assets/images/EduImg/level5.png" alt="">
                                        <#break>
                                    <#case "量子传奇">
                                        <img src="${base}/assets/images/EduImg/level6.png" alt="">
                                        <#break>
                                    <#default>
                                        <img src="${base}/assets/images/EduImg/level1.png" alt="">
                                </#switch>
                            </#if>



                            <#--<img src="${base}/assets/images/EduImg/level1.png" alt="">-->
                            </div>
                        </div>
                    </div>

                </div>
                <div class="footer">
                    <div id="footerBox">
                        <div class="footerLeft">
                            <h2 class="FLTitle">我参与本源量子科学家计划</h2>
                            <div class="FLBox">
                                <div class="FlDay1">第</div>
                                <div class="FlDay2">${studytime}</div>
                                <div class="FlDay3">天</div>
                            </div>
                        </div>
                        <div class="footerRight">
                            <div class="codeImg">
                                <img src="${base}/assets/images/EduImg/shareCode.png" alt="">

                            </div>
                            <span>长按开始学习</span>

                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

</body>
<script src="${base}/assets/js/jquery-3.1.1.min.js"></script>
<script src="${base}/assets/js/sha1.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.js"></script>
<#--<script src="https://cdn.bootcss.com/dom-to-image/2.6.0/dom-to-image.js"></script>-->
<script>
    window.onbeforeunload=function(){$('body,html').scrollTop(0);}
    /**
     * 根据window.devicePixelRatio获取像素比
     */

    function DPR() {
        if (window.devicePixelRatio && window.devicePixelRatio > 1) {
            return window.devicePixelRatio;
        }
        return 1;
    }

    /**

     *  将传入值转为整数

     */

    function parseValue(value) {
        return parseInt(value, 10);
    };

    /**
     * 绘制canvas
     */
    async function drawCanvas (selector) {
        // 获取想要转换的 DOM 节点
        const dom = document.querySelector(selector);
        const box = window.getComputedStyle(dom);
        // DOM 节点计算后宽高
        const width = parseValue(box.width);
        const height2 = parseValue(box.height);
        const height= parseValue($(".containerImages").height())
        // 获取像素比
        const scaleBy = DPR();
        // 创建自定义 canvas 元素
        var canvas = document.createElement('canvas');
        // 设定 canvas 元素属性宽高为 DOM 节点宽高 * 像素比
        canvas.width = width * scaleBy;
        canvas.height = height * scaleBy;
        // 设定 canvas css宽高为 DOM 节点宽高
        canvas.style.width = `${width}px`;
        canvas.style.height = `${height}px`;

        // 获取画笔
        const context = canvas.getContext('2d');
        // 将所有绘制内容放大像素比倍
        context.scale(scaleBy, scaleBy);
        let x = width;
        let y = height;
        return await html2canvas(dom, {canvas,allowTaint:true,useCORS: true,taintTest: false,imageTimeout:1500, foreignObjectRendering: true,height: 3200}).then(function () {
            convertCanvasToImage(canvas, x ,y)
        })
    }

    /**
     * 图片转base64格式
     */
    function convertCanvasToImage(canvas, x, y) {

        let image = new Image();

        let _container = document.getElementsByClassName('containerImages')[0];

        let _body = document.getElementsByTagName('body')[0];

        image.width = x;

        image.height = y;

        image.src = canvas.toDataURL("image/png", 1.0);

        _body.removeChild(_container);

        document.body.appendChild(image);

        return image;

    }
    $(function () {})
    // $("body").on("click", function() {
    //     //获取节点高度，后面为克隆节点设置高度。
    //     var TargetNode=".containerImages";
    //     var height = $(TargetNode).height()
    //     //克隆节点，默认为false，不复制方法属性，为true是全部复制。
    //     var cloneDom = $(TargetNode).clone(true);
    //     //设置克隆节点的css属性，因为之前的层级为0，我们只需要比被克隆的节点层级低即可。
    //     cloneDom.css({
    //         "background-color": "white",
    //         "position": "absolute",
    //         "top": "0px",
    //         "z-index": "-1",
    //         "height": height
    //     });
    //     //将克隆节点动态追加到body后面。
    //     $("body").append(cloneDom);
    //     //插件生成base64img图片。
    //     html2canvas(cloneDom, {
    //         //Whether to allow cross-origin images to taint the canvas
    //         allowTaint: true,
    //         //Whether to test each image if it taints the canvas before drawing them
    //         taintTest: false,
    //         onrendered: function(canvas) {
    //             var img = canvas.toDataURL('image/jpeg', 1.0);
    //             //打印出来之后:data:image/jpeg;base64,/9j/4AAQSkZJRg....
    //             //可以通过chrome来查看
    //             console.log(img);
    //             $("")
    //         }
    //     });
    // });
</script>
<script>
    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }
</script>
<script>
    var SidText="11"
    var shareArray={}

    shareInfoData=[
        {"id":'11',text1:"“如果你想模拟自然，你最好使用量子力学！”",text2:"If you want to make a simulation of nature, you'd better make it quantum mechanical.",guide:"——Richard Feynman ",img:"share11.png"},
        {"id":'12',text1:"“量子计算的叠加特性，能够获得远超经典计算的超级并行计算能力”",text2:"",guide:"——量子计算入门基础：《量子计算介绍》 ",img:"share12.png",imgH:"2.50666"},
        {"id":'13',text1:"“量子并不指代具体的某种物质或粒子，在物理学中它可指物质分割到最小的一个单位，是量子力学的研究对象，”",text2:"",guide:"——量子计算入门基础：《量子十问·上》",img:"share13.png",imgH:"3.2226"},
        {"id":'14',text1:"“量子计算机使用量子算法处理量子信息，一次可算出求解问题的可能性远大于经典计算机，从而实现指数级加速计算。”",text2:"",guide:"——量子计算入门基础：《量子十问·下》",img:"share14.png",imgH:"2.32"},
        {"id":'15',text1:"“狄拉克（Dirac）符号是量子力学中广泛应用于描述量子态的一套标准符号系统。”",text2:"",guide:"——量子计算入门基础：《本源量子基础教学》",img:"share15.png",imgH:"1.2"},
        {"id":'21',text1:"“本源量子云平台是国内首家基于模拟器研发且能在传统计算机上模拟 32 位量子芯片进行量子计算和量子算法编程的系统。”",text2:"",guide:"——量子计算编程初识：《量子云平台简介》",img:"share21.png",imgH:"2.66667"},
        {"id":'22',text1:"“用户通过经典计算向量子系统发起计算任务请求,量子计算机完成特定计算任务后返回经典信息，整个过程都需要量子云平台在中间协调。 ”",text2:"",guide:"—— 量子计算编程初识：《计算与量子云框架》",img:"share22.png",imgH:"3.786667"},
        {"id":'23',text1:"“在本源量子云平台上，用户通过拖动量子逻辑门添加测量指令，完成计算要求。平台据此设计量子算法对应的量子线路图，将其转化为能被量子计算系统或量子计算虚拟机识别的语言。”",text2:"",guide:"——量子计算编程初识：《量子云平台的使用教程》",img:"share23.png",imgH:"2.05333"},
        {"id":'24',text1:"“计算开始时，初态从开始演化，中间的过程用量子逻辑门U（幺正变换）来表征，直至末态。”",text2:"",guide:"——量子计算编程初识：《单量子比特及其应用》",img:"share24.png",imgH:"2.50666"},
        {"id":'25',text1:"“CNOT门：当控制位为|0>的时候，目标位不执行任何操作；但是当控制位为|1>的时候，目标位则执行对应位置上的逻辑门。”",text2:"",guide:"——量子计算编程初识：《多量子比特及其应用》",img:"share25.png",imgH:"2.32"},
        {"id":'26',text1:"“OriginIR 是本源开发的一种量子编程语言，它通过代码的形式来编写量子指令集。”",text2:"",guide:"——量子计算编程初识：《多量子比特及其应用》",img:"share26.png",imgH:"1.92"},
        {"id":'27',text1:"“ <span>D-J算法：</span>1992年David Deutsch和Richard Jozsa 提出了该算法，这是第一个展示了量子计算和经典计算在解决具体问题时具有明显差异性的典型算法。 ”",text2:"",guide:"——量子计算编程初识：《D-J算法在云平台上的测试》",img:"share27.png",imgH:"2.666667"},
        {"id":'31',text1:"“经典计算遵循宏观世界物理特性，比特信息能够被复制。而量子计算严格遵循量子力学规律，量子比特不可被复制，故量子编程环境下的变量不能被赋值。”",text2:"",guide:"——量子计算编程教学：《量子编程介绍》",img:"share31.png",imgH:"1.7333333"},
        {"id":'32',text1:"“Quantum Programming Architecture for NISQ Device Application，针对NISQ器件应用的量子编程体系。”",text2:"",guide:"——量子计算编程教学：《本源QPanda 2》",img:"share32.png",imgH:"2.693333"},
        {"id":'41',text1:"“铜粉滤波器可在4-300K的环境下正常工作，能完全吸收10MHz以上的噪声，可用于量子芯片等低温器件的测试使用。”",text2:"",guide:"——量子计算硬件介绍：《铜粉滤波器》",img:"share41.png",imgH:"0.613333"},
        {"id":'42',text1:"“集成有源Bias-Tee耦合器能够有效解决低频段输出波形失真问题，可应用于量子计算、多级/多通道信号处理系统、宽带射频/微波应用等，其通道数可定制。”",text2:"",guide:"——量子计算硬件介绍：《集成有源Bias-Tee耦合器》",img:"share42.png",imgH:"1.68"},
        {"id":'43',text1:"“电阻功分器是一个高可靠性的T型偏置器，专为需要快速上升沿和较大直流偏置的超长中频脉冲的应用而设计，该产品适用于通信系统、电子测试和量子计算实验等。”",text2:"",guide:"——量子计算硬件介绍：《电阻功分器》",img:"share43.png",imgH:"2.106666"},
        {"id":'44',text1:"“本源量子测控一体机，首款国产量子计算机控制系统，具有8个DC输出通道、8个AWG输出通道、20个RF输出通道以及4个测量通道，能够满足至少8位量子芯片的完整测控需求。”",text2:"",guide:"——量子计算硬件介绍：《量子测控一体机》",img:"share44.png",imgH:"2.50333"},
        {"id":'45',text1:"“量子芯片（或量子处理器）是指基于量子物理原理的一种芯片，它的基本逻辑单元是量子比特。操作量子芯片能够实现所设计的量子算法，完成量子计算过程。”",text2:"",guide:"——量子计算硬件介绍：《量子芯片介绍》",img:"share45.png",imgH:"2"},
    ]
    SidText=getQueryString("Sid")
    if(SidText==null){
        SidText="44";
    }

    function module1(id,text1,text2,guide,img,imgH) {
        // <!--只有图-->
        return ' <div class="middle_imgBig"><img src="${base}/assets/images/EduImg/SingleQubit.png" alt=""></div>'

    }
    function module2(id,text1,text2,guide,img,imgH) {
        if(id=="13"||id=="27"){
            marginBottom="0 0 0.4rem 0";
        }else if(id=='15'){
            marginBottom="0.8rem 0";
        }else if(id=="21"){
            marginBottom="0.34rem 0";
        }else if(id=="22"){
            marginBottom="0";
        }else if(id=="26"){
            marginBottom="0 0 1.2rem 0";
        }else if(id=="31"){
            marginBottom="0.266rem 0 0.7rem 0";
        }else if(id=="41"){
            marginBottom="1.173333rem 0 1.28rem 0";
        }else if(id=="42"){
            marginBottom="0.266rem 0 0.6rem 0";
        }else if(id=="43"){
            marginBottom="0.266rem 0 0.4rem 0";
        }else if(id=="44"){
            marginBottom="0rem 0 0.4rem 0";
        }else {
            marginBottom="0 0 0.8rem 0";
        }
       return '<div class="middle_box"><div class="middle_img" style="height: '+imgH+'rem;margin:'+marginBottom+'"><img style="height: '+imgH+'rem;" src='+"${base}/assets/images/EduImg/"+img+' alt=""></div><div class="middleInfo"><p class="middleInfo_con">'+text1+'</p>' +
               '<p class="middleInfo_gui">'+guide+'</p></div></div>'
    }
    function module3(id,text1,text2,guide,img,imgH) {
        return '<div id="module">\n' +
                '                        <div class="module_con">\n' +
                '                            <div class="module_con_left">\n' +
                '                                <p>If you want to make a simulation of nature, you\'d better make it quantum mechanical.</p>\n' +
                '                            </div>\n' +
                '                            <div class="module_con_right">\n' +
                '                                <img src="${base}/assets/images/EduImg/share11.png" alt="">\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                        <div class="module_">\n' +
                '                            <div class="middleInfo">\n' +
                '                                <p class="middleInfo_con">“如果你想模拟自然，你最好使用量子力学！”</p>\n' +
                '                                <p class="middleInfo_gui">——Richard Feynman </p>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>'
    }
    for(var k in shareInfoData){
        if(shareInfoData[k].id==SidText){
            shareArray = shareInfoData[k];
            break;
        }
    }
    if(JSON.stringify(shareArray) == "{}"){
        shareArray = shareInfoData[3];
    }
    switch (SidText) {
        case "11":
            $("#middle_con").html(module3(shareArray.id,shareArray.text1,shareArray.text2,shareArray.guide,shareArray.img,shareArray.imgH));
            break;
        case "12":
            $("#middle_con").html(module2(shareArray.id,shareArray.text1,shareArray.text2,shareArray.guide,shareArray.img,shareArray.imgH));
            break;
        case "24":
            $("#middle_con").html(module1(shareArray.id,shareArray.text1,shareArray.text2,shareArray.guide,shareArray.img,shareArray.imgH));
            break;
        default:
            $("#middle_con").html(module2(shareArray.id,shareArray.text1,shareArray.text2,shareArray.guide,shareArray.img,shareArray.imgH));

    }

    //window.addEventListener("load",drawCanvas('.containerImages'))

</script>


<script type="text/javascript">

    var timestamp=parseInt(new Date().getTime()/1000);
    jsonString={
        "errcode":0,
        "errmsg":"ok",
        "ticket":"HoagFKDcsGMVCIY2vOjf9n-B-KyAwASNUajuS9t2YzczmVOPGDjTCPg5ioiwm9Cx_aF8A2-yHqxcUkgvabstzQ",
        "expires_in":7200}
    var shareDataTile="本源量子计算教育系列课程";
    var infoText="";
    infoText=getQueryString("info");
    if(infoText!=''&&infoText!=null&&infoText!=undefined){
        shareDataTile="本源量子计算教育系列课程__"+unescape(infoText)
    }else {
        shareDataTile="本源量子计算教育系列课程"
    }
    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
    }
    var shareLink=window.location.origin;
    var shareData = {
        title:  shareDataTile,
        desc: "点击查看详情",
        imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
        otherImgUrl: '',
        text: '我正在学习，很不错哦！快来一起学习吧！',
        url:location.href.split('#')[0],
        link: location.href.split('info')[0],
        "success":function(){//分享成功后的回调函数
        },
        'cancel': function () {
        // 用户取消分享后执行的回调函数
        }
    }

    $.post("${base}/Wechat/ShareLearning.json",{},function (result) {
        data=result.obj;
        SignString ="jsapi_ticket="+data.ticket+"&noncestr="+data.noncestr+"&timestamp="+timestamp.toString()+"&url="+location.href.split('#')[0]
        s = new jsSHA(SignString.toString(),"TEXT");
        t = s.getHash("SHA-1", "HEX");
        var sha1Sign=t
        wx.config({
            debug: false,
            appId: data.appid,
            timestamp: timestamp,
            nonceStr: data.noncestr,
            signature: sha1Sign.toString(),
            jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
        wx.ready(function() {
            wx.onMenuShareTimeline(shareData);
            wx.onMenuShareAppMessage(shareData);
            wx.onMenuShareQQ(shareData);
            wx.onMenuShareWeibo(shareData);

        });
    })

</script>
</html>