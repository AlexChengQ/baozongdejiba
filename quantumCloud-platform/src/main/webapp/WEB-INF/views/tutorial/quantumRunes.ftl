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
            .winExplainContent{
                width: 100%;
                padding: 10px;
                background: #322f3a;
                margin-top: 20px;
            }
            .winExplainContent p{
                text-align: left;
                color: #c1c1c1;;
                font-weight: 700;
            }
        </style>
        <div id="context" class="company-title m-b-30"  style="margin:0px auto 0px auto; width:1200px" min-height="600px">
            <div class="list_banner" style="background:url(${base}/assets/tutImg/list_banner_8.jpg) no-repeat center center;">
                <div class="w1400">
                    <h2>|&nbsp;&nbsp;量子云平台介绍</h2>
                </div>
            </div>
            <div class="clear"></div>
            <div class="list">
                <div class="show_a">量子程序语言OriginIR</div>
                <div class="show_c">
                    <p>　　OriginIR语言是由合肥本源量子计算科技有限责任公司独立开发的一种量子编程语言。此语言简单易学，每一种图形化界面的操作，都有相应的语句与之对应。图形化界面的操作修改，也会自动的修改所对应的量子程序。当你熟练掌握OriginIR语言后，可以更加方便快捷的操作量子态。更为强大的是，OriginIR语言可以实现对量子态任意操作的定义，从而不再将量子操作局限在现有的量子逻辑门中。</p>
                    <p>　　如下，示意3比特的Grover算法（部分）：</p>
                    <p align="center"><img src="${base}/assets/tutImg/870190acbafff2ade5799fe017b9a542.png" alt="图片1.png" width="391" height="265" /></p>
                    <p align="center">&nbsp;</p>
                    <p style="text-align: right;"><span style="color: rgb(102, 102, 153);"><span style="font-size: 12px;"><span style="font-family: 黑体;">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></p>
                </div>
                <div class="show_a">
                    <div class="winExplain"><h1>说明：</h1></div>
                    <img src="${base}/assets/tutImg/wenti.png" alt="" style="width: 100%;height: 100%">
                    <div class="winExplainContent">
                        <p>1.单比特逻辑门：点击它之后，再点击下方格点可以房子到指定位置。</p>
                        <p>2.多比特逻辑门：点击它之后，先选择一个格点，放置之后，要再选择一个（绿色）或者两个（黄色）同一列格点。</p>
                        <p>3.测量图标：点击它之后，再点击下方格点可以放置到指定位置，可以选择用于保存的经典寄存器，参见7。</p>
                        <p>4.高级操作：点击它之后，再点击下方格点可以放置到指定位置，此处可以自定义操作角度，参见8</p>
                        <p>5.空白操作：点击它之后，可以选择上方的逻辑门图标，将它放置到这个位置。</p>
                        <p>6.已放置的逻辑门图标：选中之后，可以对它的属性进行修改，参见7或者8。双击可以删除它</p>
                        <p>7.经典寄存器选择：选择测量结果将保存到的经典寄存器上。经典寄存器的维度在初始化时定义。</p>
                        <p>8.角度输入：这里可以输入高级操作时的角度。你可以输入包含pi的数学表达式。角度将会以弧度制计算</p>
                        <p>8.量子程序：点击这里可以切换到量子程序的显示。</p>
                    </div>
                </div>
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
