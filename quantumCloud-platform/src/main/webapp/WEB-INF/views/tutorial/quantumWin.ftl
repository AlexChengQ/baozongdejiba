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

        <div id="context" class="company-title m-b-30"  style="margin:0px auto 0px auto; width:1200px" min-height="600px">
            <div class="list_banner" style="background:url(${base}/assets/tutImg/list_banner_8.jpg) no-repeat center center;">
                <div class="w1400">
                    <h2>|&nbsp;&nbsp;量子云平台介绍</h2>
                </div>
            </div>
            <div class="clear"></div>
            <div class="list">
                <div class="show_a">图形化量子编程界面</div>
                <div class="show_c">
                    <p>　　</p>
                    <p>　　我们的编程界面为图形化界面。通过点击选中逻辑门图标，点击插入位置，即可实现添加逻辑门，双击线路中的逻辑门即可实现删除逻辑门。即使你对编程没有了解，也可以轻松掌握量子编程。</p>
                    <p align="center"><img src="${base}/assets/tutImg/841c7167f91f483ea535851ac74c62ee.jpg" alt="图片1.jpg" width="719" height="272" /></p>
                    <p style="text-align: center;">　　<span style="font-size: 12px;">图1</span>&nbsp;</p>
                    <p>　　图1为量子线路，就像一张乐谱，而量子逻辑门则是音符，将量子逻辑门拖拽到量子线路上，即可谱写出属于你的量子算法。</p>
                    <p>　　在量子线路中，每一条线代表着一个比特随时间的演化，可以在任意位置插入量子逻辑门。当你想知道比特最终状态时，需要插入测量逻辑门，方可得到量子态的结果。</p>
                    <p align="center"><img src="${base}/assets/tutImg/166af3df1585d95486c3441333e72d0e.jpg" alt="图片2.jpg" width="749" height="116" /></p>
                    <p style="text-align: center;">　　<span style="font-size: 12px;">图2</span></p>
                    <p>　　图2为所有可调用的逻辑门。单比特门可插入在量子线路中任意一个节点;多比特门则需要插入在同一列上的至少两个节点。当你想要得到一个比特的最终状态时，需要在这个比特的最后插入测量操作。高级操作是一种自由度更高的逻辑门，之前的逻辑门都是高级操作的特殊情况，你可以通过自定义参数得到你需要的逻辑门，实现属于你的量子算法。</p>
                    <p style="text-align: center;">　　<img src="${base}/assets/tutImg/09014173a2898ccdd6b116203ab89353.jpg" alt="图片3.jpg" width="107" height="128" /></p>
                    <p style="text-align: center;">&nbsp; &nbsp; <span style="font-size: 12px;">&nbsp; &nbsp; 图3</span>&nbsp;</p>
                    <p>　　当你想要得到最终测量的结果时，点击图3中左侧的运行图标，即可将你的量子线路发送到云端，在云端对结果进行计算，并将最终结果返回到你的电脑中。</p>
                    <p>　　点击图3右侧的修改图标，可以修改重复测量的次数。由于量子的不确定性，不同的测量次数，可能会得到不同的结果。理论上，测量次数越多，得到的实验现象越接近于理论值。</p>
                    <p style="text-align: right;">&nbsp;</p>
                    <p style="text-align: right;"><span style="color: rgb(102, 102, 153);"><span style="font-size: 12px;"><span style="font-family: 黑体;">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></p>
                    <p>&nbsp;</p>        </div>
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
