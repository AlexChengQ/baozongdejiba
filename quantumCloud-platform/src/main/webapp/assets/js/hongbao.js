
// 红包
$(function () {
    $(".receive p").click(function () {
        $(".compute img").eq(1).attr("src","images/loading1.gif?ran="+Math.random());
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

