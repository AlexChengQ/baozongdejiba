<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html></#escape>
    <style>body{background-color: #fff!important;}</style>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <style>
        .appContent{
            width: 100%;
        }
        .appBanner{
            position: relative;
            top: -60px;
            min-width: 1200px;
        }
        .appBanner img{
            width: 100%;
        }
        .appBannerCon{
            position: absolute;
            top: 0;
            width: 1200px;
            left: 0;
            right: 0;
            margin: 0 auto;
        }
        .appCon{
            width: 600px;
            padding-top: 60px;
        }
        .appCon_n1{
            padding-left: 168px;
            margin-top: 116px;
            text-align: center;
        }
        .appCon_title{
            font-size: 48px;
            color: #fff;
            text-align: left;
            line-height: 64px;
            padding-bottom: 36px;
        }
        .appCon_dec{
            font-size: 32px;
            color: #fff;
            height: 40px;
            text-align: left;
            padding-bottom: 62px;
        }
        .appLeftCon{

            position: relative;
            width: 200px;
            height: 60px;
            line-height: 60px;
            background: #4787f1;
            border-radius: 30px;
            margin-bottom: 40px;
        }
        .appLeftCon.ios{
            background: #383838;
        }
        .appLeftCon a{
            display: block;
            font-size: 20px;
            color: #fff;
        }
        .appLeftCon a img{
            width: auto;
            margin-right: 14px;
            position: relative;
            top: -3px;
        }
        .appLeftCon.ios a img{
            /*top: -6px;*/
        }
        .appLeftCon a:hover span{
            color: #fff!important;
        }
        .appDet_right,.appRightCon{
            width: 160px;
            float: left;

        }
        .appRightCon img{
            margin-left: 36px;
        }
        .appDet_left{
            float: left;
        }
        .appList{
            width: 1200px;
            margin: 0 auto;
        }
        .appLeft,.appRight{
            float: left;
            width: 600px;
        }
        .appList1 .appLeft{
            position: relative;
        }
        .appList1 .appLeft .absuImg{
            position: absolute;
            left: 0;
            bottom: 85px;
            -webkit-animation: updown 1.5s linear infinite 2s;
             animation: updown 1.5s linear infinite 2s;
        }
        @-webkit-keyframes updown{
            50%{-webkit-transform: translateY(6px);transform: translateY(6px)}
        }
        .appList1 .appRight{
            display: flex;
            justify-content: center;
            align-items: center;
            padding-left: 50px;
        }
        .appList1 .appRight .appText1{
            font-size: 30px;
            line-height: 54px;
            margin-top: 280px;
            color: #4787f1;
        }
        .appList1 .appRight .appText2{
            font-size: 22px;
            line-height: 42px;
            color: #666666;
        }
        .appList2{
            width: 100%;
            height: 720px;
            background: url("${base}/assets/images/EduImg/appBg2.png");
        }
        .appList2 .appList .appText1{
            font-size: 30px;
            line-height: 54px;
            margin-top: 310px;
            color: #4688f1;
        }
        .appList2 .appList .appText2{
            font-size: 22px;
            line-height: 42px;
            color: #ffffff;
        }
        .appList2 .appRight{
            position: relative;
        }
        .appListImg2{
            position: absolute;
            top: 170px;
            width: 518px;
            left: 0;
            text-align: right;
        }
        .appList3 .appLeft{
            padding-top: 100px;
        }
        .appList4{
            width: 100%;
            height: 720px;
            background: url("${base}/assets/images/EduImg/appBg4.png");
        }
        .appListHead4{
            font-size: 52px;
            line-height: 196px;
            text-align: center;
            color: #fff;
        }
        .appListImg4{
            margin: 32px 0 96px;
            text-align: center;
        }
        .appListLink{
            width: 490px;
            margin: 0 auto;
        }
        .appListLink>div{
            position: relative;
            width: 200px;
            height: 60px;
            line-height: 60px;
            background: #4787f1;
            border-radius: 30px;
            margin-bottom: 40px;
        }
        .appListLink>div.appLinkRight{
            background: #383838;
            float: right;
        }
        .appListLink>div a{
            display: block;
            font-size: 20px;
            color: #fff;
            text-align: center;
        }
        .appListLink>div a img{
            width: auto;
            margin-right: 14px;
            position: relative;
            top: -3px;
        }
        .appListLink>div a:hover span{
            color: #fff!important;
        }
        .appListLink>div{
            float: left;
        }
        .footer-container{
            margin: 0;
        }
        @media (max-width:1500px) {
            .appCon_n1{
                padding-left: 100px;
                margin-top: 66px;
            }
            .appCon_title{
                font-size: 40px;
                line-height: 52px;
                padding-bottom: 20px;
            }
            .appCon_dec{
                font-size: 22px;
                line-height: 32px;
            }

        }
        @media (max-width:1370px) {
            .appCon_n1{
                padding-left: 52px;
                margin-top: 66px;
            }
            .appCon_title{
                font-size: 36px;
                line-height: 40px;
                padding-bottom: 12px;
            }
            .appCon_dec{
                font-size: 22px;
                line-height: 32px;
            }
            .appLeftCon{
                width: 160px;
                height: 45px;
                line-height: 45px;
                margin-bottom: 20px;
            }
            .appLeftCon a{
                font-size: 14px;
            }
            .appLeftCon a img{
                width: 20px;
                margin-right: 8px;
            }
            .appDet_right, .appRightCon{
                width: 106px;
            }

        }

    </style>
        <div class="content" style="padding: 0;" xmlns="http://www.w3.org/1999/html">
            <link rel="stylesheet" href="${base}/assets/css/public.css">
        <!--top-->
            <@main.top5><#escape x as x?html></#escape></@main.top5>
            <div class="appBox">
                <div class="appBanner">
                    <img src="${base}/assets/images/EduImg/appBanner.jpg" alt="">
                    <div class="appBannerCon">
                        <div class="appCon">
                            <div class="appCon_n1">
                                <div class="appCon_title">本源溯知</div>
                                <div class="appCon_dec">专业的量子课程学习平台</div>
                                <div class="appCon_Details">
                                    <div class="appDet_left">
                                        <div class="appLeftCon"><a onclick="downloadM()"><img src="${base}/assets/images/EduImg/android.png" alt=""><span>Android下载</span></a></div>
                                        <div class="appLeftCon ios"><a onclick="downloadios()"><img src="${base}/assets/images/EduImg/iphone.png" alt=""><span>IOS下载</span></a></div>
                                    </div>
                                    <div class="appDet_right">
                                        <div class="appRightCon"><img src="${base}/assets/images/EduImg/appQrcode.png" alt=""></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="appList appList1">
                    <div class="appLeft">
                        <img src="${base}/assets/images/EduImg/appSide1.png" alt="" style="margin-left: -50px">
                        <img src="${base}/assets/images/EduImg/appTm.png" class="absuImg" alt="">
                    </div>
                    <div class="appRight">
                        <div>
                            <div class="appText1">海量专业的量子计算尖端技术</div>
                            <div class="appText2">从量子计算基础知识到量子计算高级编程，应有尽有</div>
                        </div>

                    </div>
                    <div style="clear: both"></div>
                </div>
                <div class="appList2">
                    <div class="appList ">
                        <div class="appLeft">
                            <div class="appText1">在线学习·本地观看·云端同步</div>
                            <div class="appText2">充分利用碎片化时间，一步步迈入量子计算的大门</div>
                        </div>
                        <div class="appRight">
                            <div class="appListImg2"><img src="${base}/assets/images/EduImg/appSide2.png" alt=""></div>
                        </div>
                    </div>
                </div>
                <div class="appList appList1 appList3">
                    <div class="appLeft">
                        <img src="${base}/assets/images/EduImg/appSide3.png" alt="" style="margin-left: -50px">

                    </div>
                    <div class="appRight">
                        <div>
                            <div class="appText1">海量专业的量子计算尖端技术</div>
                            <div class="appText2">从量子计算基础知识到量子计算高级编程，应有尽有</div>
                        </div>

                    </div>
                    <div style="clear: both"></div>
                </div>
                <div class="appList4">
                    <div class="appList ">
                        <div class="appListHead4">更多“黑科技”，等你来发现…</div>
                        <div class="appListImg4"><img src="${base}/assets/images/EduImg/appLogo.png" alt=""></div>
                        <div class="appListLink">

                            <div class="appLinkLeft"><a onclick="downloadM()"><img src="${base}/assets/images/EduImg/android.png" alt=""><span>Android下载</span></a></div>
                            <div class="appLinkRight"><a onclick="downloadios()"><img src="${base}/assets/images/EduImg/iphone.png" alt=""><span>IOS下载</span></a></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </#escape>
</@main.body>
<@main.footer>

<script src="${base}/assets/js/swiper.min.js"></script>
<#--edit start-->
<#--微信分享-->
<script src="${base}/assets/js/sha1.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    // 图片懒加载
    $(function() {
        $("img.lazy").lazyload();
    });

    var timestamp=parseInt(new Date().getTime()/1000);
    var infoText="";
    infoText=getQueryString("info")
    var shareDataTile="本源量子计算教育云平台";
    if(infoText!=''&&infoText!=null&&infoText!=undefined){
        shareDataTile="本源量子计算教育系列课程__"+unescape(infoText)

    }else {
        shareDataTile="本源量子计算教育系列课程"
    }
    var shareData = {
        title:  shareDataTile,
        desc: "点击查看详情",
        imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
        otherImgUrl: '',
        text: '我正在学习，很不错哦！快来一起学习吧！',
        url:location.href.split('#')[0],
        link: shareLink+"/EDU/quantumLearning.html",
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
<script>
    // var swiper = new Swiper('.swiper-container', {
    //     navigation: {nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev'},
    //     autoplay: {delay: 4500, disableOnInteraction: false},
    //     pagination: {el: '.swiper-pagination', clickable: true},
    //     slidesPerView: 1,
    //     paginationClickable: true,
    //     spaceBetween: 0,
    //     mousewheelControl: false,
    //     autoplayDisableOnInteraction: false,
    //     loop: true,
    //     pagination: {
    //         el: '.swiper-pagination',
    //         bulletElement : 'li',
    //         type: 'custom',
    //         renderCustom: function (swiper, current, total) {
    //             var _html = '';
    //             for (var i = 1; i <= total; i++) {
    //                 if (current == i) {
    //                     _html += '<div class="pagination-custom active"><i></i></div>';
    //                 }else{
    //                     _html += '<div class="pagination-custom"><i></i></div>';
    //                 }
    //             }
    //             return _html;//返回所有的页码html
    //         }
    //     },
    // });

    
    function downloadios() {
        $.post("${base}/statisticsDownload.json",{"version":"iosDown"},function(result) {

        });

        window.location.href = "https://apps.apple.com/cn/app/%E6%9C%AC%E6%BA%90%E6%BA%AF%E7%9F%A5/id1473392815"
    }

    function downloadM() {
        $.post("${base}/statisticsDownload.json",{"version":"andriodDown"},function(result) {

        });

        window.location.href = "${updUrl!}"
    }
</script>
</@main.footer>