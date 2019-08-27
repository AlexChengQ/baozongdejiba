<!DOCTYPE html>
<html lang="en">
<head>
    <title>荣誉勋章</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="荣誉勋章">
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
        body{
            width: 100%;
            height: 100%;
            position: relative;
            padding: 0;
            margin: 0;
            background-color: #f7f7f7;
        }
        #shareBg{
            width: 100%;
            height: 14.33333rem;
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            margin-top: 0;
            -webkit-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            -moz-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            -ms-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);

            background-image: url("../../../assets/images/EduImg/HonorShare2.jpg");
            background-repeat: no-repeat;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        header{

        }
        #wrapper {
            color: #ffffff;
            padding: 0.9rem;
            position: relative;
            top: 0;
            text-align: center;
            margin-top: 0;
            height: 14.33333rem;
            -webkit-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            -moz-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            -ms-transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
            transition: margin-top 0.6s cubic-bezier(0.28,-0.01,0.41,1);
        }
        #Honor_con{
            height: 9.33333334rem;
            overflow: hidden;
        }
        .Honor_img {
            height: 3.25rem;
            margin: 0.26666rem 0;
        }
        .Honor_img.img1{
            height: 3.25rem;
            margin: 1.08rem 0 0.48rem ;
        }
        .Honor_img.img1 img{
            height: 3.25rem;
        }
        .Honor_img.img2{
            height: 4.053333rem;
            margin: 0.53333rem 0 0.48rem ;
        }
        .Honor_img.img2 img{
            height: 4.053333rem;
        }
        .Honor_img.img3{
            height: 3.44rem;
            margin: 0.82rem 0 0.48rem ;
        }
        .Honor_img.img3 img{
            height: 3.44rem;
        }
        .Honor_img.img4{
            height: 3.533333rem;
            margin: 0.8rem 0 0.48rem ;
        }
        .Honor_img.img4 img{
            height: 3.533333rem;
        }
        .Honor_img.img5{
            height: 2.933333rem;
            margin: 1.32rem 0 0.48rem ;
        }
        .Honor_img.img5 img{
            height: 2.933333rem;
        }
        .Honor_img.img6 img{
            height: 3.8rem;
        }
        .Honor_img.img6{
            height: 3.8rem;
            margin: 0.66666667rem 0 0.48rem ;
        }
        .Honor_img.img6 img{
            height: 3.8rem;
        }
        .HonorName{
            text-align: center;
            font-size: 0.48rem;
            line-height: 0.6rem;
            height: 0.6rem;
            margin-bottom: 0.8rem;
        }
        .HonorJs{
            font-size: 0.28rem;
            text-align: center;
            line-height: 0.48rem;
        }
        .userInfo{
            overflow: hidden;
            padding-top: 0.27rem;
            padding-bottom: 1.2rem;
        }
        .userInfo>div{
            width: 50%;
            float: left;

        }
        .userTips {
            color: #1a1a1a;

            font-size: 0.24rem;
        }
        .userLeftBox {
            text-align: center;
        }
        .userLeftBox img{
            width: 2.2rem;
            height: 2.2rem;
        }
        .userName {
            line-height: 0.733333rem;
            height: 0.733333rem;
            overflow: hidden;
        }
        .userName span{
            font-weight: 600;
            color: #1a1a1a;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
            width: 100%;
            display: block;
        }
        .userRight {
            text-align: left;
        }
        .userTipsInfo{
            line-height: 0.4rem;
            color: #1a1a1a;
        }
        .userLogo {
            margin-top: 0.3rem;
            height: 0.4rem;
        }
        .userLogo img{
            max-width: 100%;
        }
    </style>
<body style="font-size: 12px">
<div class="containerImages" style="position: relative;top: 0;left: 0;right: 0;">
    <div id="shareBg"></div>
    <main>
        <div id="wrapper">
            <div id="Honor" class="container">
                <div class="Honor_con">
                    <div id="Honor_con"></div>
                </div>
                <div class="userInfo">
                    <div class="userLeft">
                        <div class="userLeftBox">
                            <img src="${base}/assets/images/EduImg/shareCode.png" alt="">
                            <div class="userTips">
                                长按二维码了解详情
                            </div>
                        </div>
                    </div>
                    <div class="userRight">
                        <div class="userName">
                            <span>${userName}</span>
                        </div>
                        <div class="userTipsInfo">
                            Ta已累计获得${bonusNum!}个勋章，<br /> 集满5个将解锁量子计算机</br>
                            可用机时！
                        </div>
                        <div class="userLogo">
                            <img src="${base}/assets/images/EduImg/medal_right_img.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer">
                <div id="footerBox">
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

        // const height = parseValue(box.height);
        const height = parseValue($("#wrapper").height()+$("#wrapper").offset().top*2);

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

        return await html2canvas(dom, {canvas,allowTaint:false,useCORS: true, foreignObjectRendering: true,height: 3200}).then(function () {

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
    var winHeight=$(window).height()
    var shareHeight=$("#shareBg").height();
    var differencing=winHeight-shareHeight
    if(differencing>0){

        $("#wrapper").css({"margin-top":differencing/2})
        // $("#shareBg").css({"margin-top":differencing/2})
        setTimeout(function () {
            $(function () {
               drawCanvas('.containerImages');
            })
        },650)

    }
    var SidText="11"
    var honorArray=[
        {index:"1",name:"分子勋",text:"“量子的世界里，只要没人在看，任何事情都会发生！”"},
        {index:"2",name:"原子勋",text:"“越过经典计算的边界，开启量子计算的未来。”"},
        {index:"3",name:"中子勋",text:"“有人说世上没人懂得量子计算，这个断言</br>想来并不适合你。”"},
        {index:"4",name:"质子勋",text:"“如果你还没被量子计算震惊，说明</br>你还没有为它着迷。”"},
        {index:"5",name:"夸克勋",text:"“未来有什么我不知道，但我知道</br>未来肯定有量子计算!”"},
        {index:"6",name:"量子勋",text:"“下一站，量子计算机！”"}]



    HonorInfoData={}
    HidText=getQueryString("Hid")
    if(SidText==null){
        SidText="1";
    }

    function Honor(id,name,tips,index) {
        return '<div class="Honor_img img'+index+'">\n' +
                '                            <img src="${base}/assets/images/EduImg/MOH'+index+'HD.png" alt="">\n' +
                '                        </div>\n' +
                '                        <div class="HonorName"><span>'+name+'</span></div>\n' +
                '                        <div class="HonorJs">'+tips+'</div>'
    }
    for(var k in honorArray){
        if(honorArray[k].index==HidText){
            HonorInfoData=honorArray[k]
        }
    }
    if(JSON.stringify(HonorInfoData) == "{}"){
        HonorInfoData = honorArray[0];
    }
    switch (HidText) {
        case "1":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,1));
            break;
        case "2":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,2));
            break;
        case "3":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,3));
            break;
        case "4":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,4));
            break;
        case "5":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,5));
            break;
        case "6":
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,6));
            break;
        default:
            $("#Honor_con").html(Honor(HonorInfoData.index,HonorInfoData.name,HonorInfoData.text,1));

    }
    // $(".Honor_con").html(module2())
</script>


<script type="text/javascript">

    var timestamp=parseInt(new Date().getTime()/1000);
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
        link: location.href.split('#')[0],
        "success":function(){//分享成功后的回调函数
        },
        'cancel': function () {
            // 用户取消分享后执行的回调函数
        }
    }
    // console.log($.param(SignData))

    // alert(sha1Sign)

    $.post("${base}/Wechat/ShareLearning.json",{},function (result) {
        console.log(result);
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