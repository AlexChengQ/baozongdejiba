function allowDrop(ev)
{
    ev.preventDefault();
    $(".cat_box").addClass("active");
}

function drag(ev)
{
    ev.dataTransfer.setData("Text",ev.target.id);
}

function drop(ev)
{
    ev.preventDefault();
    var data=ev.dataTransfer.getData("Text");
    ev.target.appendChild(document.getElementById(data));
    $(".cat_box").removeClass("active");
    $(".cat").hide();
    setTimeout(function(){
        $(".overlay").show();
    },1000);
    setTimeout(function(){
        $(".tips_01").fadeIn();
    },2000);
    setTimeout(function(){
        $(".tips_02").fadeIn();
    },3000);
    setTimeout(function(){
        $(".tips_06").fadeIn();
    },4000);    
    setTimeout(function(){
        $(".bg_img").hide();
        $(".cat_box").hide();
        $(".tips_01").hide();
        $(".tips_02").hide();
        $(".tips_06").hide();
        $(".overlay").hide();
        $(".gif").show();
    },7000);
    setTimeout(function(){
        $(".check_msg").fadeIn();
    },12000);
}

$(function () {
    $(".box").height($(window).height());

    $(".check_msg a").click(function () {
        $(".gif").hide();
        $(".check_msg").hide();
        $(".bg_img01").show();
        $(".cat_box").show();
        $(".tips_03").show();
        $(".overlay").show();
    });

    $(".tips_03").click(function () {
        $(".gif_01").show();
        setTimeout(function () {
            $(".overlay").show();
            $(".cat_box").hide();
            $(".tips_03").hide();
            $(".gif_01").hide();
            var num = Math.floor(2*Math.random());
            $(".img_one").show();
            if(num==0){
                $(".tips_04").show();
            } else{
                $(".tips_05").show();
            }
        },4040);
        setTimeout(function(){
            $(".img_one").hide();
            $(".tips_04").hide();
            $(".tips_05").hide();
            $(".tips_07").fadeIn();
            $(".reset").fadeIn();
        },8000);
    });


    $(".reset").click(function () {
        $(".gif").attr("src","../images/bg2.gif?ran="+Math.random());
        $(".zz-span img").attr("src","../images/loading.gif?ran="+Math.random());
        window.location.reload();
    });
})