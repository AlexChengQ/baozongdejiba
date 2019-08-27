<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content  clearfix" style="min-width:1200px;">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <!--box-->
        <style>
            .vidHeadPath {padding-top:15px;max-width:1200px;margin:0 auto;line-height:50px;border-bottom:1px solid #d9d9d9;}
            .vidHeadPath a {color:#1a1a1a;font-size:14px;}
            .vidHeadPath span {font-size:14px;color:#4c4c4c;}
            .vidHeadPath span.gont {font-family:"宋体","Source Han Sans","Helvetica Neue",Helvetica,Arial,sans-serif;}
            .vidOptions {padding:30px 0;margin-bottom:15px;border-bottom:1px solid #cdcccd;-moz-box-shadow:0px 6px 6px #E2E2E2;-webkit-box-shadow:0px 6px 6px #E2E2E2;box-shadow:0px 6px 6px #E2E2E2;}
            .vidOptions .OptionName {font-size:14px;float:left;color:#4c4c4c;line-height:34px;margin-right:20px;}
            .vidOptions .OptionList {float:left;}
            .vidOptions .OptionList a {display:inline-block;padding:0 15px;height:34px;line-height:34px;margin-right:12px;border:1px solid #d9d9d9;}
            .vidOptions .OptionList a.active {background:#178cec;color:#fff;border-color:#178cec;}
            .vidOptions .margin1200 {margin:0 auto;width:1200px;}
            .vidAll {background:#f5f5f5;width:100%;margin-top:-7px;/*height:100%;*/}
            .filtrateBox {max-width:1200px;margin:0 auto;padding:15px 0 30px 0;}
            .filtrateBox a {display:inline-block;padding:0 25px;color:#4c4c4c;height:34px;line-height:34px;background:#fff;float:left;border-right:2px solid #d9d9d9;}
            .filtrateBox a:last-child {border:none;}
            .filtrateBox a.active {background:#178cec;border-color:#178cec;color:#fff;}
            .vidAll .vidlisUser {padding:0;}
            .vidAll .vidlisUser li {width:282px;}
        </style>
        <div class="vidHeadPath">
            <a href="${base}/QCode/library.html">教程</a><span class="gont"> > </span> <span>视频教程</span>
        </div>
        <div class="vidOptions">
            <div class="clearfix margin1200">
                <div class="OptionName">课程类型：</div>
                <div class="OptionList"><a href="javascript:void (0)" class="active">全部</a></div>
            </div>
        </div>
        <div class="vidAll">
            <div class="vidContent">
                <div class="filtrateBox clearfix" style="display: none;"><a href="" class="active">默认排序</a><a href="">按热门</a><a href="">按最新</a></div>
                <div class="vidList">
                    <ul class="vidlisUser clearfix" style="padding-top: 50px">
                       
                        <div class="videoBox"></div>
                    </ul>
                </div>
            </div>
        </div>
        <style>
            .vjs-user-inactive .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -28px;}
           .vjs-user-active .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -28px;}
            .vidContent{background: transparent;padding-bottom: 100px;}
        </style>
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script type="text/javascript" src="${base}/assets/js/jweixin-1.0.0.js"></script>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script type='text/javascript' src="${base}/assets/js/app.js?1.1"></script>
    <script>

    var videoData=[
        {name:"全部",link:"",classify:"0"},
        {name:"基础板块",link:"",classify:"1"},
        {name:"工具板块",link:"",classify:"2"},
        {name:"编程部分",link:"",classify:"3"},
        // {name:"应用部分",link:"",classify:"4"},
        {name:"硬件介绍",link:"",classify:"4"},
        {name:"科大教程",link:"",classify:"5"},
        {name:"学术报告",link:"",classify:"6"}

    ]
    var vidDetails=[
        [
            {link:"Basic/BasicKnowledgeQuantumMechanics.mp4",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
            {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
            {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
            {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
            {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
            {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
            {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
            {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
            {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
            {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
            {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
            {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
            {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
            //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
            //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源QRunes编程",time:""},
            {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.2本源QPanda 2介绍",time:"06:01"},
            {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.3 本源QPanda的安装与配置",time:"06:58"},
            {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.4 本源QPanda 2的编程教学1",time:"09:17"},
            {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.5 本源QPanda 2的编程教学2",time:"06:08"},
            {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
            {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
            {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
            {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
            {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"},
            {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
            {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
            {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
            {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
            {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
            {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
            {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
            {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
            {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"},
            {link:"http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4",img:"${base}/assets/images/video/report1.jpg",name:"1. 学术报告",time:"1:02:05"}
        ],
        [
            //{link:"",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
            {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
            {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
            {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
            {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
        ],
        [
            {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
            {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
            {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
            {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
            {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
            {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
            {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
        ],
        [
            {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
            //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
            //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源OriginIR编程",time:""},
            {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.4 本源QPanda 2介绍",time:"06:01"},
            {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.4 本源QPanda的安装与配置",time:"06:58"},
            {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.5 本源QPanda 2的编程教学1",time:"09:17"},
            {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.6 本源QPanda 2的编程教学2",time:"06:08"}
        ],
        [
            {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
            {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
            {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
            {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
            {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"}
        ],
        [

            {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
            {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
            {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
            {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
            {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
            {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
            {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
            {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
            {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"}

        ],
        [
            {link:"http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4",img:"${base}/assets/images/video/report1.jpg",name:"1. 学术报告",time:"1:02:05"},
        ]
    ]

    var vidHtml =''
    videoData.forEach(function (value,i) {
        if(i==0){
            vidHtml +=' <a href="javascript:void (0)" class="active" data-classify='+i+'>'+value.name+'</a>'
        }else {
            vidHtml +=' <a href="javascript:void (0)" data-classify='+i+'>'+value.name+'</a>'
        }
    })
    function vidHtmls(link,img,name,time) {
        return '<li ontouchstart="videoPlay(this)" onclick="videoPlay(this)"><div class="vid_screenshot" data-value='+link+'><img src="'+img+'" alt=""></div><div class="vid_js"><span>'+name+'</span>' +
                '<span class="right">'+time+'</span></div><div class="vidHover"></div><div class="vidHoverImg"><img src="" alt=""></div></li>'
    }
    $(".OptionList").html(vidHtml)

    var vidDetailsHtml =''
    $("body").on("click",'.OptionList a',function () {
        vidDetailsHtml ='';
        $(this).addClass("active").siblings().removeClass("active");
        vidDetails[$(this).attr("data-classify")].forEach(function (value) {
            // console.log(value.img)
            vidDetailsHtml +=vidHtmls(value.link,value.img,value.name,value.time)
        })

        $(".vidlisUser").html(vidDetailsHtml)
    })
   $('.OptionList a').eq(0).click();
    var progressFlag;
    function getTools() {
        (function(window, document){
            // 获取要操作的元素
            var video = document.getElementById("my_video_1_html5_api");
            wx.config({
                // 配置信息, 即使不正确也能使用 wx.ready
                debug: false,
                appId: '',
                timestamp: 1,
                nonceStr: '',
                signature: '',
                jsApiList: []
            });
            wx.ready(function() {
                document.getElementById("my_video_1_html5_api").play();
            });
            document.getElementById("my_video_1_html5_api").play();
            var videoControls = document.getElementsByClassName("vjs-control-bar")[0];
            var videoContainer = document.getElementById("videoplayer");
            var controls = document.getElementById("video_controls");
            var playBtn = document.getElementsByClassName("vjs-play-control")[0];
            var fullScreenBtn = document.getElementsByClassName("vjs-fullscreen-control")[0];
            var progressWrap = document.getElementsByClassName("vjs-progress-control")[0];
            var playProgress = document.getElementsByClassName("vjs-play-progress")[0];
            // var showProgress = document.getElementsByClassName("vjs-play-progress")[0];
            var fullScreenFlag = false;
            $("body").find("#box-close").on("click",function () {
                clearInterval(progressFlag)
                $("#videoplayer_overlay").remove()
            })
            // 创建我们的操作对象，我们的所有操作都在这个对象上。
            var videoPlayer = {
                init: function(){
                    var that = this;
                    video.removeAttribute("controls");
                    bindEvent(video, "loadeddata", videoPlayer.initControls);
                    videoPlayer.operateControls();
                    getProgress()
                },
                initControls: function(){
                    video.play();
                    videoPlayer.showHideControls();
                    progressFlag = setInterval(getProgress, 60);

                },
                showHideControls: function(){
                    bindEvent(video, "mouseover", showControls);
                    bindEvent(videoControls, "mouseover", showControls);
                    bindEvent(video, "mouseout", hideControls);
                    bindEvent(videoControls, "mouseout", hideControls);
                },
                operateControls: function(){
                    bindEvent(playBtn, "click", play);
                    bindEvent(video, "click", play);
                    bindEvent(fullScreenBtn, "click", fullScreen);
                    bindEvent(progressWrap, "mousedown", videoSeek);
                }
            }

            videoPlayer.init();

            // 原生的JavaScript事件绑定函数
            function bindEvent(ele, eventName, func){
                if(window.addEventListener){
                    ele.addEventListener(eventName, func);
                }
                else{
                    ele.attachEvent('on' + eventName, func);
                }
            }
            // 显示video的控制面板
            function showControls(){
                $(".video-js").addClass("vjs-user-active");
                $(".video-js").removeClass("vjs-user-inactive");
            }
            // 隐藏video的控制面板
            function hideControls(){
                // 为了让控制面板一直出现，我把videoControls.style.opacity的值改为1
                $(".video-js").removeClass("vjs-user-active");
                $(".video-js").addClass("vjs-user-inactive");
            }
            // 控制video的播放
            function play(){
                if ( video.paused || video.ended ){
                    if ( video.ended ){
                        video.currentTime = 0;
                    }
                    video.play();
                    $(this).addClass("vjs-playing")
                    $("body").find(".video-js").addClass("vjs-playing")
                    $(this).removeClass("vjs-paused")
                    $("body").find("#my_video_1_html5_api").paused = false;
                    $("body").find("#my_video_1_html5_api").get(0).play();
                    progressFlag = setInterval(getProgress, 60);
                }
                else{
                    video.pause();
                    $(this).removeClass("vjs-playing")
                    $("body").find(".video-js").removeClass("vjs-playing")
                    $(this).addClass("vjs-paused");
                    $("body").find("#my_video_1_html5_api").paused = true;
                    $("body").find("#my_video_1_html5_api").get(0).pause()
                    // playBtn.innerHTML = "播放";
                    clearInterval(progressFlag);
                }
            }
            // 控制video是否全屏，额这一部分没有实现好，以后有空我会接着研究一下
            function fullScreen(){
                $(this).parent().parent().fullScreen()

                $(".vjs-play-control").addClass("vjs-playing");
                var w=null;

                clearTimeout(w)
                if(!flagTime){
                    w=setTimeout(function () {
                        $("body").find("#my_video_1_html5_api").get(0).play()
                    },300)
                }
            }
            // video的播放条
            function getProgress(){
                var percent = video.currentTime / video.duration;
                playProgress.style.width = percent * (progressWrap.offsetWidth) - 2 + "px";

                var min=parseInt(video.duration/60)
                var seconds=parseInt(video.duration%60)
                if(seconds>=10){
                    seconds=parseInt(video.duration%60)
                }else {
                    seconds='0'+parseInt(video.duration%60)
                }
                // console.log(video.duration%60);

                var PlayMin=parseInt(video.currentTime/60);
                var PlaySeconds=(video.currentTime%60).toFixed(0)
                if(PlaySeconds>=10){
                    PlaySeconds=(video.currentTime%60).toFixed(0)
                }else {
                    PlaySeconds='0'+(video.currentTime%60).toFixed(0)
                }
                // console.log(PlayMin+":"+PlaySeconds);
                var PlayTime=PlayMin+":"+PlaySeconds;



                var time=min+":"+seconds;
                $("#timesID").html(PlayTime+"/"+time)
                // console.log(video.duration/60+":"+video.duration%60)
                // showProgress.innerHTML = (percent * 100).toFixed(1)  + "%";
            }
            // 鼠标在播放条上点击时进行捕获并进行处理
            function videoSeek(e){
                if(video.paused || video.ended){
                    play();
                    enhanceVideoSeek(e);
                }
                else{
                    enhanceVideoSeek(e);
                }

            };
            //定位时间
            function enhanceVideoSeek(e){
                var percent=0;
                var length=0;
                clearInterval(progressFlag);
                length = e.pageX - progressWrap.offsetLeft-$("#videoplayer_outer_container").position().left;

                if(document.fullscreen || document.mozFullScreen || document.webkitIsFullScreen){
                    length=length+$("#videoplayer_outer_container").position().left;
                    percent = length / progressWrap.offsetWidth;
                }else {
                    percent = length / progressWrap.offsetWidth-0.03;
                }

                //console.log(percent)
                playProgress.style.width = percent * (progressWrap.offsetWidth)  + "px";
                video.currentTime = percent * video.duration;
                progressFlag = setInterval(getProgress, 60);
            };


        }(this, document))
    }
    $(document).ready(function () {
        // var NewSwiper = new Swiper('.libContainer', {
        //     slidesPerView: 3,
        //     spaceBetween: 20,
        //     loop: true,
        //     navigation: {
        //         nextEl: '.LibNext',
        //         prevEl: '.LibPrev'
        //     }
        // })
        });
//        t = $('.fixed').offset().top;
//        $(window).scroll(function () {
//            s = $(document).scrollTop();
//            if (s > t - 10) {
//                $('.fixed').css('position', 'fixed');
//                $('.fixed').css('left', '14px');
//                $('.news-content').css('margin-left', '16%');
//                if (s) {
//                    $('.fixed').css('top', 'px');
//                }
//            } else {
//                $('.fixed').css('position', '');
//                $('.news-content').css('margin-left', '');
//
//            }
//        })
        var i
        $(".toolsAll li").each(function () {
            if($(this).hasClass("active")){
//                console.log($(this).index());
                i=$(this).index()
            }
            if($(this).index()==0){
                $(this).css({"left":"0"})
            }else if($(this).index()==4){
                $(this).css({"left":"-100px"})
            }else if($(this).index()>i){
                $(this).css({"left":"-100px"})
            }
        })

        $(".toolsAll li").on("click",function () {
            $(".toolsAll li").attr("style","")
            i=$(this).index()
            // console.log(i)
            if($(this).index()==0){
                $(this).css({"left":"0"})
            }
            if($(this).index()==4){
                $(this).css({"left":"-100px"})
            }
            $(this).addClass("active").siblings().removeClass("active");

            $(".toolsAll li").each(function () {
                if($(this).index()>i){
                    $(this).css({"left":"-100px"})
                }
            })
        });

    $(".toolsAll li").hover(function () {
        $(".toolsAll li").attr("style","")
        i=$(this).index()
        // console.log(i)
        if($(this).index()==0){
            $(this).css({"left":"0"})
        }
        if($(this).index()==4){
            $(this).css({"left":"-100px"})
        }
        $(this).addClass("active").siblings().removeClass("active");

        $(".toolsAll li").each(function () {
            if($(this).index()>i){
                $(this).css({"left":"-100px"})
            }
        })
    });

</script>
</@main.footer>
