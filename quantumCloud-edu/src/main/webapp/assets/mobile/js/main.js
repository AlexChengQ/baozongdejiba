// 视频页导航目录切换
$(".label_con ul li").on("click",function () {
    $(this).addClass("active").siblings().removeClass("active");
    $(".courseList").eq($(this).index()).addClass("active").siblings().removeClass("active");
})

$("#lectureUrl").on("click",function () {
    if($(this).attr("data-flag")=='1'){
        layer.msg("暂无讲义");
        return false
    }
})

//关闭弹继续播放弹出层
function viTipClose(){
    $(".vjs_tip").removeClass("active");
    $('.toAnswer').hide()
    clearTimeout(resumePlayTimeSet)
    $(".vjs_tip").children().removeClass("active");
    $(".videoStart").removeClass("show")
}

// 加载视频继续播放
function resumePlay(){
    $('#my_video_1_html5_api')[0].currentTime = resumePlayTime;
    viTipClose();
    video.play();
}


//重置视频
$(".vjs-replay-control").on("click",function () {
    video.pause();
    $("body").find(".vjs-play-control").addClass("vjs-paused")
    $("body").find(".vjs-play-control").removeClass("vjs-playing")
    $('#my_video_1_html5_api')[0].currentTime=0;
    $(".vjs-play-progress").css({"width":0})
});


// 目录点击
$("body").on('click',".vjs_menu_name",function () {
    if($(this).parent().hasClass("active")){
        $(this).parent().removeClass("active")
    }else {
        $(this).parent().addClass("active")
    }
})

// function clickPlayStates() {
//     if ( video.paused || video.ended ){
        // try {
        //     video.play();
        //     $(".videoStart").removeClass("show")
        // }catch (e) {
        //     $(".videoStart").addClass("show")
        // }
        // $(this).addClass("vjs-playing")
        // $("body").find(".video-js").addClass("vjs-playing")
        // $(this).removeClass("vjs-paused")
        // $("body").find(".vjs-play-control").removeClass("vjs-paused")
        // $("body").find(".vjs-play-control").addClass("vjs-playing")
        // $("body").find("#my_video_1_html5_api").paused = false;
        // try {
        //     $("body").find("#my_video_1_html5_api").get(0).play();
        //     $(".videoStart").removeClass("show")
        // }catch (e) {
        //     $(".videoStart").addClass("show")
        // }
//     }
// }

// <#--前往视频页-->
$("body").on("click",".video_v",function () {
    if(!$(this).parents(".video_box_left").siblings(".video_box_content").find(".lockbox").hasClass("lock")){
        window.location.href=base+"/m/mVideo.html?link="+$(this).attr("data-value");
    }else {layer.msg("请完成上一节")}

    $.post(base+"/UpdateUserScore/saveVideoDetail.json",{"type":1,"vid":$(this).attr("data-value").replace("_","")},function () {
    })
})