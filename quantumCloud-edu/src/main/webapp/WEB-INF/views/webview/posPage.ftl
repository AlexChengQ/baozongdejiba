<!DOCTYPE html>
<html lang="en">
<head>
    <title>科普</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="科普">
    <meta name="keywords" content="本源量子">
    <meta name="author" content="">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="Cache-Control" content="no-transform ">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="shortcut icon" href="http://learn-quantum.com/assets/images/favicon.ico">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
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
                console.warn('将根据已有的meta标签来设置缩放比例');
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
        *{
            padding: 0;
            margin: 0;
        }
        body{
            width: 100%;
            height: 100%;
            position: relative;
            /*padding: 0 0.533333rem;*/
            margin: 0;
            background-color: #fff;
        }
        .banner a{
            width: 100%;
            display: block;
        }
        .banner img{

            width: 9.46rem;
            text-align: center;
        }

        ul{margin: 0;padding: 0;}
        dl,dt,dd{margin: 0;padding: 0;list-style: none;}
        ul, li {list-style: none;}
        em {font-style: normal}
        .container{
            padding-top: 0.16rem;
            padding-bottom: 0.32rem;
        }
        .listDetails{
            padding: 0 0.6rem;
            color: #4688f1;
            height:0.85333333333333rem;
            position: relative;
            line-height: 0.85333333333333rem;
            font-size: 0.37333333333333rem;
        }
        .listDetails i{
            position: absolute;
            background: url(${base}/assets/images/EduImg/eduSprite.png) no-repeat;
            height: 15px;
            width: 13px;
            background-position: -362px -0px;
            top: 50%;
            left: 0px;
            margin-top: -8px;

        }
        .listDetails i.yy{
            width: 14px;
            height: 13px;
            margin-top: -7px;
            background-position: -362px -18px;
        }
        .listDetails i.fz{
            width: 14px;
            height: 14px;
            background-position: -362px -35px;
        }
        .listChild li{
            line-height: 0.66666666666667rem;
            height: 0.66666666666667rem;
            padding: 0 0.6rem;
            position: relative;
        }
        .listChild li a{
            display: block;
            text-decoration: none;
            line-height:0.66666666666667rem;
            font-size: 0.37333333333333rem;

            color: #787878;
        }
        .listChild li a .i-con{
            position: absolute;

            /*border-left: 0;*/
            /*border-right: 0;*/
            left:0;
            top:0;
            width: 0.6rem;
            /*margin-top: 28px;*/
            height: 100%;
        }
        .listChild li a .i-con i{
            margin-top: 0.2rem;
            margin-left: 0.1rem;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 7.5px 6px 0 6px;
            border-color: #dcdcdc transparent transparent transparent;

            display: block;
        }
        .listChild li a .i-con i.active{
            animation:rotates 0.6s;
            -webkit-animation:rotates 0.6s ;
            transform: rotate(180deg);
        }

        @keyframes rotates
        {
            0% {transform: rotate(0deg);}
            100% {transform: rotate(180deg);}
        }

        @-webkit-keyframes rotates /*Safari and Chrome*/
        {
            0% {transform: rotate(0deg);}
            100% {transform: rotate(180deg);}
        }
        .listEnd{
            display: none;
        }
        .listEnd li{
            line-height: 0.66666666666667rem;
            height: 0.66666666666667rem;
            padding: 0 0 0 0.4rem ;
        }
        .listEnd li a{
            color: #b4b4b4;
            line-height: 0.56rem;
            font-size: 0.32rem;
            display: block;
        }
        .posList{

        }

    </style>
<body style="font-size: 12px">
<div class="containerImages" style="position: relative;top: 0;left: 0;right: 0; padding: 0.4rem 0.26666667rem 0;">
    <main>
        <div id="wrapper">
            <div class="banner">
                <a href="javascript:viod(0)"><img src="${base}/assets/images/AppImg/webviewBanner.png" alt=""></a>
            </div>
            <div id="posPage" class="container">
                <div class="posList">
                    <ul class="listBig">
                        <li>
                            <div class="listDetails"><i></i>教程文档</div>
                            <ul class="listChild">
                                <li><a href="${base}/QCode/webview/welcome.html"><span>欢迎来到量子世界</span></a></li>
                                <li><a href="${base}/QCode/webview/world.html"><span>量子世界</span></a></li>
                                <li><a href="${base}/QCode/webview/mechanics.html"><span>量子力学</span></a></li>
                                <li><a href="${base}/QCode/webview/theory.html"><span>量子计算原理</span></a></li>
                                <li style="height: auto;">
                                    <a href="${base}/QCode/webview/algorithm.html"><div class="i-con"><i></i></div><span>量子算法</span></a>
                                    <ul class="listEnd">
                                        <li><a href="${base}/QCode/webview/algorithm.html#1"><span>随机数生成</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#2"><span>D-J Algorithm</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#3"><span>Mayer-Penny Game in Quantum</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#4"><span>Swap Test 算法</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#5"><span>Simon 算法</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#6"><span>Bernstein-Vazirani Algorithm 算法</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#7"><span>HHL算法</span></a></li>
                                        <li><a href="${base}/QCode/webview/algorithm.html#8"><span>Counterfeit Coin Game文档</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <div class="listDetails"><i class="yy"></i>应用领域</div>
                            <ul class="listChild">
                                <li><a href="${base}/tutorial/mField.html?defaultIndex=1"><span>人工智能</span></a></li>
                                <li><a href="${base}/tutorial/mField.html?defaultIndex=3"><span>数据处理</span></a></li>
                                <li><a href="${base}/tutorial/mField.html?defaultIndex=4"><span>搜索引擎</span></a></li>
                                <li><a href="${base}/tutorial/mField.html?defaultIndex=5"><span>物流运输</span></a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="listDetails"><i class="fz"></i>未来发展</div>
                            <ul class="listChild">
                                <li><a href="${base}/tutorial/mDevelop1.html"><span>量子计算机的未来在何方？</span></a></li>
                                <li><a href="${base}/tutorial/mDevelop2.html"><span>为什么我们要建立量子云计算平台？</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="footer">
            </div>
        </div>
    </main>
</div>

</body>
<script src="${base}/assets/js/jquery-3.1.1.min.js"></script>
<script>
    $(".i-con").on("click",function (e) {

        if($(".listEnd").css("display")=="block"){
            $(".listEnd").slideUp();
            $(this).find("i").removeClass("active");
        }else {
            $(".listEnd").slideDown();
            $(this).find("i").addClass("active");
        }
        e.stopPropagation();
        e.preventDefault();
    })
</script>
</html>