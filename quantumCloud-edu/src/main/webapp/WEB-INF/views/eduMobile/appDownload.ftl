
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" /><!-- 手机和电脑自适应代码-->
    <meta name="csrf-param" content="_csrf-frontend">
    <meta name="csrf-token" content="8bG9BWtrKxxiOkiaqgp28TjmVJSv9qnW06fwatONy_O16e1tPBJGeBZ8HfP8WjqycIMjwNmQ2ufq5pg-pcSmoQ==">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>本源云 - 分享详情</title>
    <style>
        /*手机端全局样式重置*/
        *{-webkit-box-sizing:border-box;box-sizing:border-box;-webkit-tap-highlight-color:rgba(255,0,0,0);}
        body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,input,textarea,p,th,td,video,audio,header,nav,section,footer{padding:0;margin:0;}
        body{color:#2c2c35;font-size:.14rem;overflow-y:scroll;background:#f6f6fb;line-height:1;height:100%;}
        html{height:100%;}
        form,input,textarea{outline:none;}
        img{border:none;}
        a{text-decoration:none;color:#2c2c35;}
        h1,h2,h3{font-weight:normal;}
        li{list-style-type:none;}
        .clearfix:after{content:'.';clear:both;display:block;height:0;visibility:hidden;font-size:0;line-height:0;}
        .fl{float:left;}
        .fr{float:right;}
        input[type=button],input[type=submit]{-webkit-appearance:none;outline:none;}
        [class*="icon-"]{width:.24rem;height:.24rem;vertical-align:-0.15em;fill:currentColor;overflow:hidden;}


        .d-c {
            height: 100%;
        }

        /*box-1*/
        .d-c .box-1,
        .d-c .box-2,
        .d-c .box-3 {
            width: 100%;
            position: relative;
            height: 100%;
            background: url("${base}/assets/images/AppImg/appDownBg1.jpg");
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
            overflow: hidden;
            position: relative;
        }
        .d-c .box-3{
            background-image: url("${base}/assets/images/AppImg/appDownBg3.jpg");
        }
        .d-c .box-1 .top-left {
            padding-top: .22rem;
            padding-left: .45rem;
        }
        .d-c .box-1 .top-left img {
            width: 2.05rem;
            height: .65rem;
        }
        .d-c .box-1 .top-title {
            padding-top: .17rem;
            padding-bottom: .12rem;
        }
        .d-c .box .title.active {
            -webkit-animation: title 1s 0s linear both;
            animation: title 1s 0s linear both;
        }
        @-webkit-keyframes title{
            0%{opacity:0;-webkit-transform:scaleX(1.25) scaleY(1.25);}
            100%{opacity:1;-webkit-transform:scaleX(1) scaleY(1);}
        }
        .d-c .box-1 .top-title img {
            display: block;
            width: 3.83rem;
            height: 1.12rem;
            margin: 0 auto;
        }
        .d-c .box .cont.active {
            -webkit-animation: phone 1s 0s linear both;
            animation: phone 1s 0s linear both;
        }
        .d-c .box-1 .cont.active {
            -webkit-animation: title 1s 0s linear both;
            animation: title 1s 0s linear both;
        }
        @-webkit-keyframes phone{
            0%{opacity:0;-webkit-transform:translateY(50%);}
            100%{opacity:1;-webkit-transform:translateY(0%);}
        }
        .d-c .box-1 .top-cont img {
            display: block;
            width: 100%;
            height: 6.13rem;
            margin: 0 auto;
        }
        .d-c .box-1 .top-btn,
        .d-c .box-2 .top-btn,
        .d-c .box-3 .top-btn,
        .d-c .box-2 .c1-btn,
        .d-c .box-3 .c2-btn,
        .d-c .box-4 .c3-btn {
            display: block;
            position: relative;
            width: 5.26rem;
            height: 1.2rem;
            margin: 0 auto;
        }
        .d-c .box-2{
            width: 100%;
            height: 100%;
            background: url("${base}/assets/images/AppImg/appDownBg2.jpg");
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
            overflow: hidden;
        }
        .animateBtn{animation: scaleUp 2s ease-in-out infinite;-webkit-animation: scaleUp 2s ease-in-out infinite;}
        @keyframes scaleUp{
            0%{transform: scale(1);}
            25%{transform: scale(1.05);}
            50%{transform: scale(1);}
            75%{transform: scale(1.05);}
        }
        .d-c .box-1 .top-btn img,
        .d-c .box-2 .top-btn img,
        .d-c .box-3 .top-btn img,
        .d-c .box-2 .c1-btn img,
        .d-c .box-3 .c2-btn img,
        .d-c .box-4 .c3-btn img {
            display: block;
            width: 3.92rem;
            height: 1rem;
            margin: 0 auto;
    
        }
        .d-c .box .go-next {
            display: block;
            width: .506666667rem;
            height: .506666667rem;
            margin: 0 auto;
            position: relative;
            z-index: 999;
            -webkit-animation-name: drop;
            -webkit-animation-duration: 1.5s;
            -webkit-animation-timing-function: linear;
            -webkit-animation-delay: 0s;
            -webkit-animation-iteration-count: infinite;
            -webkit-animation-play-state: running;
            animation-name: drop;
            animation-duration: 1.5s;
            animation-timing-function: linear;
            animation-delay: 0s;
            animation-iteration-count: infinite;
            animation-play-state: running;
        }
        @-webkit-keyframes drop	{
            0%{top:0; opacity:0;}
            50%{top:.25rem; opacity:1;}
            100%{top:.5rem; opacity:0;}
        }
        @keyframes drop	{
            0%{top:0; opacity:0;}
            50%{top:.25rem; opacity:1;}
            100%{top:.5rem; opacity:0;}
        }
        .d-c .box .go-next:before,
        .d-c .box .go-next:after {
            content: "";
            width: .38rem;
            height: .38rem;
            background: url(${base}/assets/images/AppImg/appDownBtn.png) no-repeat center / cover;
            position: absolute;
            left: 0;
            top: 0;
        }
        .d-c .box .go-next:after {
            top: .2rem;
        }

        /*box-2*/

        .d-c .box-2 .c1-title,
        .d-c .box-3 .c2-title {
            padding-top: 1.07rem;
            padding-bottom: .24rem;
        }
        .d-c .box-2 .c1-title {
            padding-bottom: .44rem;
        }
        .d-c .box-2 .c1-title img,
        .d-c .box-3 .c2-title img,
        .d-c .box-4 .c3-title img {
            display: block;
            width: 4.39rem;
            height: 1rem;
            margin: 0 auto;
        }
        .d-c .box-2 .c1-cont {
            padding-bottom: .18rem;
        }
        .d-c .box-2 .c1-cont img,
        .d-c .box-3 .c2-cont img,
        .d-c .box-4 .c3-cont img {
            display: block;
            width: 5.78rem;
            height: 6.72rem;
            margin: 0 auto;
        }
        .d-c .box .go-next2:before,
        .d-c .box .go-next2:after {
            background: url(${base}/assets/images/AppImg/appDownBtn.png) no-repeat center / cover;
        }

        /*box-3*/
        .d-c .box-3 .c2-title img,
        .d-c .box-4 .c3-title img {
            width: 3.73rem;
        }
        .d-c .box-3 .c2-cont {
            padding-bottom: .36rem;
        }

        /*box-4*/
        .d-c .box-4 .c3-title {
            padding-top: .97rem;
            padding-bottom: .24rem;
        }
        .d-c .box-4 .c3-cont {
            padding-bottom: .46rem;
        }

        /*iphone5/se小屏*/
        @media (device-width:320px) and (-webkit-min-device-pixel-ratio:2) {
            .d-c .box-1 .top-title {padding-top: .47rem;padding-bottom: .32rem;}
            .d-c .box-2 .c1-title,.d-c .box-3 .c2-title {padding-top: .87rem;padding-bottom: .24rem;}
            .d-c .box-4 .c3-title {padding-top: .87rem;padding-bottom: .24rem;}
        }
        /*iphone6/7/8plus大屏*/
        @media(min-device-height:736px) {
            .d-c .box-1 .top-title {padding-top: .87rem;padding-bottom: .24rem;}
            .d-c .box-2 .c1-title,.d-c .box-3 .c2-title {padding-top: .87rem;padding-bottom: .24rem;}
            .d-c .box-4 .c3-title {padding-top: .87rem;padding-bottom: .14rem;}
        }
        /*iphonex大屏*/
        @media(min-device-height:812px) {
            .d-c .box-1 .top-title {padding-top: 1.07rem;padding-bottom: .64rem;}
            .d-c .box-2 .c1-title,.d-c .box-3 .c2-title {padding-top: 1.27rem;padding-bottom: .64rem;}
            .d-c .box-4 .c3-title {padding-top: 1.17rem;padding-bottom: .64rem;}
            .d-c .box-1 .top-btn,.d-c .box-2 .c1-btn,.d-c .box-3 .c2-btn,.d-c .box-4 .c3-btn {margin-top: .5rem;}
        }
        /*ipad超大屏*/
        @media(min-device-width:768px) {
            .d-c .box-1 .top-title {padding-top: .27rem;padding-bottom: .12rem;}
            .d-c .box-2 .c1-title,.d-c .box-3 .c2-title {padding-top: .17rem;padding-bottom: .04rem;}
            .d-c .box-1 .top-cont img,.d-c .box-2 .c1-cont img,.d-c .box-3 .c2-cont img,.d-c .box-4 .c3-cont img,.d-c .box-1 .top-btn img,.d-c .box-2 .c1-btn img,.d-c .box-3 .c2-btn img,.d-c .box-4 .c3-btn img {width: 60%;height: 60%;}
            .d-c .box-1 .top-btn,.d-c .box-2 .c1-btn,.d-c .box-3 .c2-btn,.d-c .box-4 .c3-btn {margin-bottom: 0;}
            .d-c .box-4 .c3-title {padding-top: .17rem;padding-bottom: .04rem;}
        }
        .contentBox{
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 5.1rem;
        }
        .content-text{
            text-align: center;
            height: 2rem;
        }
        .content-text div{
            line-height: 0.54rem;
            height: 0.54rem;
            font-size: 0.54rem;
            color: #4688f1;
        }
        .content-text p{
            line-height: 0.95rem;
            font-size: 0.34rem;
            color: #787878;
        }
    </style>
</head>
<body>
<script>
    function srceen() {
        //根据屏幕宽度改变html的font-size值
        var body_w = document.getElementsByTagName("body")[0].clientWidth;
        var html_w = document.getElementsByTagName('html')[0];
        var ztdx = body_w / 7.5;//7.5为750/320宽度相互转化后得出的值，请勿随意更改
        html_w.style.fontSize = ztdx + "px";
    }
    srceen()
    window.onresize = function(){
        srceen();
    }
</script>
<div class="d-c" id="fullpage">
    <section class="section box box-1">
        <div class="contentBox">
            <div class="content-text">
                <div>项目检测</div>
                <p>每一个所学知识点都会有对应检测项目</p>
            </div>
            <a href="javascript:;" class="top-btn animateBtn">
                <img src="${base}/assets/images/AppImg/appDownLoad.png"/>
            </a>
            <a href="javascript:;" class="go-next go-next1"></a>
        </div>

    </section>
    <section class="section box box-2">
        <div class="contentBox">
            <div class="content-text">
                <div>入门清晰</div>
                <p>从概念引入到量子编程“步步为营”</p>
            </div>
            <a href="javascript:;" class="top-btn animateBtn">
                <img src="${base}/assets/images/AppImg/appDownLoad.png"/>
            </a>
            <a href="javascript:;" class="go-next go-next1"></a>
        </div>
    </section>
    <section class="section box box-3">
        <div class="contentBox">
            <div class="content-text">
                <div>免费参与</div>
                <p>学习量子计算行业尖端技术 </p>
            </div>
            <a href="javascript:;" class="top-btn animateBtn">
                <img src="${base}/assets/images/AppImg/appDownLoad.png"/>
            </a>

        </div>
    </section>
</div>
<script src="${base}/assets/js/jquery-3.1.1.min.js"></script>
<script src="${base}/assets/js/jquery.fullPage.js"></script>
<script src="${base}/assets/js/layer/layer/layer.js"></script>
<script>
    // 判断是否qq/微信打开
    $(window).on("load",function(){
        var ua = navigator.userAgent.toLowerCase();

        if (navigator.userAgent.match(/(iPhone|iPod|iPad);?/i)) {
            // window.location = "";
        } else {
            // window.location = "";
        }
    });

    $(function(){
        $('#fullpage').fullpage({
            scrollingSpeed:700,
            css3:true,
            onLeave:function(index,nextIndex,direction){
                if(direction==="down"){
                    $(".title").removeClass("active").eq(index).addClass("active");
                    $(".cont").removeClass("active").eq(index).addClass("active");
                }else if(direction==="up"){
                    $(".title").removeClass("active").eq(nextIndex-1).addClass("active");
                    $(".cont").removeClass("active").eq(nextIndex-1).addClass("active");
                }
            }
        });

        $(".box .go-next").on("click",function(){
            var index = $(this).parent().parent().index();
            index += 1;
            $.fn.fullpage.moveSectionDown();
            $(".title").removeClass("active").eq(index).addClass("active");
            $(".cont").removeClass("active").eq(index).addClass("active");
        });

        $('.animateBtn').click(function () {
            var down = false;
            var u = navigator.userAgent, app = navigator.appVersion;
            var isMicroMessenger = u.indexOf('MicroMessenger') > -1 ; //android终端或者uc浏览器
            var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
            if(/s=noRedirect/i.test(location.search)){ return;}
            if(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
                try {
                	if(isMicroMessenger){
                     	alert("请使用手机内置浏览器进行下载.......");
                    }else if(navigator.userAgent.match(/(iPhone|iPod|iPad);?/i)) {
                    	$.post("${base}/statisticsDownload.json",{"version":"iosDown"},function(result) {});
                    	window.location.href = "https://apps.apple.com/cn/app/%E6%9C%AC%E6%BA%90%E6%BA%AF%E7%9F%A5/id1473392815";
                    }else if(navigator.userAgent.match(/android/i)) {
                        window.location.href = "oqcoriginqc://app?param=0";//android app协议
                        setTimeout(function() {
                        	//记录下载次数
                        	$.post("${base}/statisticsDownload.json",{"version":"andriodDown"},function(result) {});
                            window.location.href = "${updUrl!}";//android 下载地址
                        }, 1000)
                    }else if(isiOS){
                    	$.post("${base}/statisticsDownload.json",{"version":"iosDown"},function(result) {});
                    	window.location.href = "https://apps.apple.com/cn/app/%E6%9C%AC%E6%BA%90%E6%BA%AF%E7%9F%A5/id1473392815";
                    }
                } catch(e) {}
            }else {
                window.location.href = "oqcoriginqc://app?param=0";//android app协议
                setTimeout(function() {
                	$.post("${base}/statisticsDownload.json",{"version":"andriodDown"},function(result) {});
                    window.location.href = "${updUrl!}";//android 下载地址
                }, 1000)
            }
        });
    })
</script>
</body>
</html>