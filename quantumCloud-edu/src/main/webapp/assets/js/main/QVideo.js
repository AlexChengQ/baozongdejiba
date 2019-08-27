// menu滚动条
$("#menu_scroll").niceScroll({
    cursoropacitymin: 0, // 当滚动条是隐藏状态时改变透明度, 值范围 1 到 0
    cursoropacitymax: 1, // 当滚动条是显示状态时改变透明度, 值范围 1 到 0
    cursorwidth: "6px", // 滚动条的宽度，单位：便素
    cursorborder: "", // CSS方式定义滚动条边框
    cursorborderradius: "3px", // 滚动条圆角（像素）
    scrollspeed: 60, // 滚动速度
    mousescrollstep: 40, // 鼠标滚轮的滚动速度 (像素)
    touchbehavior: false, // 激活拖拽滚动
    hwacceleration: true, // 激活硬件加速
    background: "#4d4d4d",// 轨道的背景颜色
    cursorcolor:'#999999',
    autohidemode: false, // 隐藏滚动条的方式, 可用的值:
    railoffset:false
});
// <#--目录展开-->
$("body").on('click',".vjs_menu_name",function () {
    if($(this).parent().hasClass("active")){
        $(this).parent().removeClass("active")
    }else {
        $(this).parent().addClass("active")
    }
    setTimeout(function () {
        $("#menu_scroll").getNiceScroll().resize();
    },100)
})
// 视频播放页js
var answerAll='',orderBox='',liLength,dataContentText='';
// 获取题目状态
function getStatus(isClick) {
    $.ajax({
        type:"post",
        url:base+'/education/userexaminfo.json',
        dataType: "json",
        data:{userid:userInfoId},
        success:function (data) {getAll(data.obj,isClick);}
    })
}
// 获取所有题目
function getAll(Status,isClick){
    $.ajax({
        type:"POST",
        url:'/education/allexaminfo.json',
        dataType: "json",
        success:function (data) {
            videoDataExam(data.obj,Status,isClick)
        }
    })
}
//获取答案状态信息处理
// questionArray 用来存放问题id    AnswerArray 用来存放问题状态
function videoDataExam(data,userInfo,isClick) {
    // if(data==''||data==null){
        questionArray=[]
    // }else {
        for(var k in data){
            if(data[k].blockid==videoIdValue.substring(0,1)&&data[k].examid==videoIdValue.substring(1)){
                questionArray.push(data[k].questionid)
            }
        }
    // }
    if(userInfo==''||userInfo==null){
        AnswerArray=[]
    }else {
        for(var p in userInfo) {
            if (userInfo[p].blockid == videoIdValue.substring(0,1) && userInfo[p].examid == videoIdValue.substring(1)) {
                AnswerArray=userInfo[p].status.split("|")
                break;
            }
        }
    }
    if(isClick ==1 ){
        AnswerTheQuestions(questionArray,AnswerArray);
    }else {
        if(questionArray=='' || questionArray == 'undefined'){
            // layer.msg("暂无题库");
            $('.toAnswer').hide();
            return false;
        }else {
            $('.toAnswer').show();

        }
    }
}

$("body").on('click','.questionBox',function () {
    answerAll=''
    questionArray=[]
    AnswerArray=[]
    if(!$('#my_video_1_html5_api')[0].paused){
        $('#my_video_1_html5_api').click();
    }
    getStatus(1);

})
// 打开答题窗口
//暂无题库
function noQuesTion() {
    $.ajax({
        type:"post",
        url:base+'/education/userexaminfo.json',
        dataType: "json",
        data:{userid:userInfoId},
        success:function (data) {
            getAll(data.obj,2)
        }
    });
}
// 获取测试题目
function AnswerTheQuestions(questionArray,AnswerArray) {
    answerAll='';
    dataContentText='';
    if(questionArray==''){
        layer.msg("暂无题库");
        $('.toAnswer').hide();
        return false;
    }else {
        $('.answered').hide();
        $('.answerBox-con').show();
        $('.answerBtn').text("确定");
        count=1;
        cleatStyle()
        questionEle = $(this);
        liLength = questionEle.parent().find('li').length;
        orderBox='';
        questionEle={blockId:'', examId:'', questionId:'',}
        questionEle.blockId = videoIdValue.substring(0,1);
        questionEle.this = $(this);
        questionEle.examId = videoIdValue.substring(1);;
        questionEle.questionId = questionArray[0];
        liLength = questionArray.length;

        var titleText = $(".index_menu_list.active").find('.vjs_menu_vidName').text();
        $('.answerBox-top div').text(titleText)
        cleatStyle();
        $('.answerWrapper').show();

        for(var a=0;a<=questionArray.length-1;a++){
            if(AnswerArray[a]=="1"){
                answerAll=answerAll+"1"+"|"
            }else {
                answerAll=answerAll+" "+"|"
            }

            if(a==0&&(liLength-1)==0){
                orderBox +='<li class="countQuestion'+a+'">'+'0'+(a+1)+'</li>'

            }else if(a==0){
                orderBox +='<li class="countQuestion'+a+' ansLine">'+'0'+(a+1)+'</li>'

            }else if(a==(liLength-1)){
                orderBox +='<li class="countQuestion'+a+'">'+'0'+(a+1)+'</li>'
            }else {
                orderBox +='<li class="countQuestion'+a+' ansLine">'+'0'+(a+1)+'</li>'
            }
        }
        $("#orderBox").html(orderBox)
        $.ajax({
            type:"POST",
            url:base+'/education/examinfo.json',
            dataType: "json",
            data:{blockid:questionEle.blockId,questionid:questionEle.questionId,examid:questionEle.examId},
            success:function (data) {
                if(data.obj==null||data.obj==''){
                    layer.msg("请求异常，请重试！！！")
                    return false;
                }

                $('.question-conUl').html(getAnswerHtmlPc(data));
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
                layerOutBoxTop()
            }
        })
    }

}



// 加载视频继续播放
function resumePlay(){
    $('#my_video_1_html5_api')[0].currentTime = resumePlayTime;
    viTipClose()
    video.play();
}
//关闭弹继续播放弹出层
function viTipClose(){
    $(".vjs_tip").removeClass("active");
    $('.toAnswer').hide()
    clearTimeout(resumePlayTimeSet)
    $(".vjs_tip").children().removeClass("active")
}
//视频结束
function updataVideoInfo(flag){
    var scoreFlag=null;
    var currentTime = $('#my_video_1_html5_api')[0].currentTime;
    var curTime = secondToDate(currentTime);
    var videoTitle = $('.video_n1_title h1').text();
    if (flag === 1){
        scoreFlag = true
    } else {
        scoreFlag = false
    }
    $.ajax({
        type:"POST",
        url:base+"/education/updvideoinfo.json",
        async:false,
        data:{
            userid:userInfoId,
            addscoreflag:scoreFlag,
            progress:curTime,
            title:videoTitle,
            id:videoIdValue
        },
        success:function (data) {}
    });
    // window.location.href='http://localhost/EDU/video.html?link=1_5'
    $.ajax({
        type:"POST",
        url:base+"/education/getvideoinfo.json",
        async:false,
        data:{
            userid:userInfoId
        },
        success:function (data) {
        }
    })
    getUserInfo();

}
//重置视频
$(".vjs-replay-control").on("click",function () {
    video.pause();
    $("body").find(".vjs-play-control").addClass("vjs-paused")
    $("body").find(".vjs-play-control").removeClass("vjs-playing")
    $('#my_video_1_html5_api')[0].currentTime=0;
    $(".vjs-play-progress").css({"width":0})
});
//判断没有讲义阻止跳转并提示
$("#lectureUrl").on("click",function () {
    if($(this).attr("data-flag")=='1'){
        layer.msg("暂无讲义");
        return false
    }
})

