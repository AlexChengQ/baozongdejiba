<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
<script>

</script>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <link rel="stylesheet" href="${base}/assets/css/public.css">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>
        <style>
            .Edu_box{
                background: #282828;
            }
        </style>
        <div id="context" class="company-title m-b-30"  style="margin:0px auto 0px auto; width:1200px" min-height="600px">
            <div class="list_banner" style="background:url(${base}/assets/tutImg/list_banner_3.jpg) no-repeat center center;">
                <div class="w1400">
                    <h2>|&nbsp;&nbsp;量子计算机的展望</h2>
                </div>
            </div>
            <div class="clear"></div>
            <div class="list">
                <div class="show_a">为什么我们要建立量子云计算平台？</div>
                <div class="show_c">
                    <p>　　由于量子计算机的体系是微观体系，对于温度带来的噪声干扰会非常的敏感。一旦噪声带来的影响与我们量子体系的能级间隔相当，就会对我们的实验结果造成极大的干扰。</p>
                    <p>　　因此，量子芯片需要工作在极低温的环境。如此苛刻的环境要求，意味着量子计算机很难像手机，个人电脑那样普及。而量子云计算平台，将用户对量子计算机的操作通过网络传达到服务器中，通过服务器对量子计算机进行操作，最后将实验结果通过网络返回到用户电脑中。利用网络间接的实现了用户对量子计算机的操作。</p>
                    <p>　　在线量子云计算平台示意图如下：</p>
                    <p align="center"><img src="http://118.89.219.200/d/file/3/13/2017-08-31/7494221deff079feeef9db5dad80b33f.jpg" alt="中科大量子实验室.jpg" width="800" height="1118" align="" border="0" /></p>
                    <p style="text-align: right;"><span style="color: rgb(102, 102, 153);"><span style="font-size: 12px;"><span style="font-family: 黑体;">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></p>        </div>
            </div>

            <div class="clear"></div>
        </div>
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script>
$(function () {
    // urlinfo=window.location.href;
    // newsids=urlinfo.split("=");
    // newsid=parseInt(newsids[1])-1;
    // if(newsid>0){
    //     $(".slideTxtBox_2").slide({delayTime:0,pnLoop:false,defaultIndex:newsid});
    // }else{
    //     $(".slideTxtBox_2").slide({delayTime:0,pnLoop:false});
    // }
    $(".hd li").hover(function () {
        $(this).addClass("on").siblings().removeClass("on")
        $(".bd>ul").eq($(this).index()).show().siblings().hide()
    })
})
</script>
</@main.footer>
