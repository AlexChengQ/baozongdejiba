<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" href="${base}/assets/css/hongbao.css">
</head>
<body style="overflow: hidden;">

<div class="hb_title">
    <div>量子红包--<span>本源红包</span></div>
</div>
<!--box-->
    <canvas id="canvas" style="position: relative; background-color: #fed261;"></canvas>
    <div class="hongbao_box">
        <div class="hongbao_msg">
            本源量子红包是首个利用量子算法生成的红包。当您点击领取红包时，量子程序就会被发送到后端执行，由获得的测量值决定了红包中的金额。量子红包的程序通过国内首个量子软件开发包Q-Panda开发，详情请移步<a
                href="https://github.com/OriginQ/Q-Panda" target="_blank">GitHub</a>。
        </div>    
        <div class="compute">
            <img src="${base}/assets/images/hb_07.png" alt="">
            <img src="${base}/assets/images/loading1.gif" alt="">
        </div>
        <div class="receive">
            <div>量子红包</div>
            <img src="${base}/assets/images/hb_01.png" alt="">
            <span>量子程序执行中！</span>
            <p>立即领取</p>
        </div>
        <div class="scan">
            <img class="hb_04" src="${base}/assets/images/hb_04.png" alt="">
            <img class="hb_05" src="${setting['showqrcode']}${ticket!}" alt="">
            <img class="hb_06" src="${base}/assets/images/hb_06.png" alt="">
            <div>微信扫码</div>
            <p>每个手机号仅限一次</p>
        </div>        
    </div>

<!--box end-->

<script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${base}/assets/js/radiation.js"></script>
<script type="text/javascript">

//红包
$(function () {
 $(".receive p").click(function () {
	 $(".compute img").eq(1).attr("src","${base}/assets/images/loading1.gif?ran="+Math.random());
     $(".compute").show();
     $(".receive span").show();
     $(".hongbao_msg").hide();
     setTimeout(function () {
         $(".compute").hide();
         $(".receive").hide();
         $(".receive span").hide();
         $(".scan").show();
     },2100);
     setTimeout(function () {
         $(".hb_05").addClass("active");
     },2300)
 });
});


</script>
</body>
</html>