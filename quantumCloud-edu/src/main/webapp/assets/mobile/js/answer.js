// 答题
//再来一次
var questionEle = {
    blockId: '',
    examId: '',
    questionId: '',
    this: null
};
var isReload=true;

var _Answers,count=1;
var questionArray=[]
var AnswerArray=[]
var scrollTopAns=0;
$('#againDo').on('click', function () {
    answeredScore = 0;
    questionEle.questionId = questionEle.questionId.toString().substring(0, questionEle.questionId.toString().length - 1);
    problemext(questionEle.blockId, questionEle.examId, questionEle.questionId + 0);
    questionEle.questionId = questionEle.questionId + 0;
    $('.answered').hide();
    $(".answerBtn").attr("data-flag",0)
    _Answers = '';
    $('#orderBox li').removeClass('rightAns errorAns');
    $('.answerBox-con').show();
    $('.answerBtn').text(answerMessage.ensure);
    count = 1;
    cleatStyle()
})
function cleatStyle() {
    dataContentText = '';
    $(".question-con ul li").removeClass("rightList");
    $(".question-con ul li").removeClass("errorList");
    $('.errorMessage').hide()
    $(".radio_check").removeClass("radio_checked")
    $(".question-con ul li").children('input').removeAttr('checked');
    $(".question-con ul li").children('input').removeAttr('disabled');
    $(".pop-up").attr("style", "");

}

function layerOutBoxTop() {
    if ($(".answerWrapper").css("display") == "block") {
        var layerOutBoxTop = ($(window).height() - $(".answerBox").height()) / 2
        $(".answerBox").css({ "margin-top": layerOutBoxTop + "px" })
    }
}
$(window).resize(function () {
    layerOutBoxTop()
});

$(window).scroll(function () {
    if ($(".answerWrapper").css("display") == "block") {
        if(scrollTopAns!=0){
            $('html, body').scrollTop(scrollTopAns);
        }else {
            scrollTopAns=$(window).scrollTop()
        }

    }
});

var answerAll = '', orderBox = '', liLength, count = null, dataContentText = '';

$("body").on('click', '.testList li', function (i, s) {
    dataContentText = '';
    var statusPrev = $(this).prev().attr("class");
    var hasPrev = $(this).prev().attr("data-blockid");
    if (statusPrev != "finished" && typeof (hasPrev) != "undefined") {
        layer.msg(answerMessage.preQuestion);
        return false;
    }
    $('.answered').hide();
    $('.answerBox-con').show();
    $('.answerBtn').text(answerMessage.ensure);
    count = $(this).index() + 1;
    cleatStyle()
    questionEle = $(this);
    liLength = questionEle.parent().find('li').length;
    orderBox = '';
    questionEle = { blockId: '', examId: '', questionId: '', }
    questionEle.blockId = $(this).attr("data-blockid");
    questionEle.this = $(this);
    questionEle.examId = $(this).attr("data-examid");
    questionEle.questionId = $(this).attr("data-questionid");
    liLength = $(this).parent().find('li').length;
    var titleBox = $(this).parent().siblings()[0];
    var titleText = $(titleBox).find('.chapterName').text();
    $('.answerBox-top div').text(titleText)
    cleatStyle();
    if ($(this).parents('.testList').siblings('.video-title').find(".lockbox").hasClass("lock")) {
        layer.msg(answerMessage.preQuestion);
        return false;
    }
    $('.answerWrapper').show();
    for (var a = 0; a <= $(this).parent().find('li').length - 1; a++) {
        if ($(this).parent().find('li').eq(a).hasClass("finished")) {
            answerAll = answerAll + "1" + "|"
        } else if ($(this).parent().find('li').eq(a).hasClass("unfinished")) {
            answerAll = answerAll + "0" + "|"
        } else {
            answerAll = answerAll + " " + "|"
        }
        if (a == 0 && (liLength - 1) == 0) {
            orderBox += '<li class="countQuestion' + a + '">' + '0' + (a + 1) + '</li>'

        } else if (a == 0) {
            orderBox += '<li class="countQuestion' + a + ' ansLine">' + '0' + (a + 1) + '</li>'

        } else if (a == (liLength - 1)) {
            orderBox += '<li class="countQuestion' + a + '">' + '0' + (a + 1) + '</li>'
        } else {
            orderBox += '<li class="countQuestion' + a + ' ansLine">' + '0' + (a + 1) + '</li>'
        }
    }
    $("#orderBox").html(orderBox)
    $.ajax({
        type: "POST",
        url: base+'/education/examinfo.json',
        dataType: "json",
        data: { blockid: questionEle.blockId, questionid: questionEle.questionId, examid: questionEle.examId },
        success: function (data) {
            if (data.obj == null || data.obj == '') {
                layer.msg(answerMessage.error)
                return false;
            }
            $('.question-conUl').html(getAnswerHtml(data));
            MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            layerOutBoxTop()
        }
    })
})
var _Answers;
function getQuestion(ele) {
    _Answers = ele;
}
$('.answerBtn').on("touchstart", function () {
    if (_Answers == undefined || _Answers == '') {
        layer.msg(answerMessage.choose);
        return false;
    }
    var dataFlag=$(this).attr("data-flag")
    $(this).attr("data-flag",0)
    var curAnswers = $.trim(_Answers.find('label').text()).charAt(0).toUpperCase();
    if (dataFlag == "4") {
        cleatStyle();
        _Answers = '';
        $('.answerBtn').text(answerMessage.ensure);

        problemext(questionEle.blockId, questionEle.examId, $("#question").attr("data-question"))
        return false;
    }
    if (dataFlag == "3") {
        cleatStyle();
        var countQuestionNum = count - 1
        $('#orderBox li').eq(countQuestionNum).removeClass('rightAns errorAns');
        _Answers = '';

        $('.answerBtn').text(answerMessage.ensure);
        $('label').removeClass('radio_checked');
        return false;
    }
    if (dataFlag =="1") {

        $('.answerWrapper').hide();
        $('#orderBox li').removeClass('rightAns errorAns');
        $('.answered').hide();
        $('.answerBox-con').show();
        _Answers = '';
        $('.answerBtn').text(answerMessage.ensure)
        $(questionEle.this).parents(".video_box").next(".video_box").find(".lockbox").removeClass("lock");
        count = 1;
        cleatStyle();
        if(isReload){
            window.location.reload();
        }
        return false
    }
    if (dataFlag == "2") {
        $('.answerWrapper').hide();
        $('#orderBox li').removeClass('rightAns errorAns');
        $('.answered').hide();
        $('.answerBox-con').show();
        _Answers = '';
        $('.answerBtn').text(answerMessage.ensure)
        $(questionEle.this).parents(".video_box").next(".video_box").find(".lockbox").removeClass("lock");
        count = 1;
        cleatStyle();
        scrollTopAns=0;
        if(isReload){
            window.location.reload();
        }
        return false
    }
    var questionid = $("#question").attr("data-question");
    // updateStatus(questionEle.blockId, questionEle.examId, answerAll);
    $.ajax({
        type: "POST",
        url: base+'/education/examAnswerInfo.json',
        dataType: "json",
        data: {questionid: questionid, blockid: questionEle.blockId, examid: questionEle.examId},
        success: function (data) {
            if (data.obj == null || data.obj == '') {
                layer.msg(answerMessage.error)
                return false;
            }
            var rightAnswers = data.obj.answer;
            var answerdetail = data.obj.answerdetail;
            if (rightAnswers == curAnswers) {
                var countQuestion = '.countQuestion' + (count - 1);

                // answeredScore = answeredScore + 20;
                // $('.answered_score').text('+' + answeredScore + '积分')

                $(countQuestion).addClass('rightAns');
                $('.errorMessage').hide()
                _Answers.addClass('rightList');
                $('.answerBtn').text(answerMessage.next);
                $('.answerBtn').attr("data-flag",4)
                if (count == liLength) {
                    var answerArray = answerAll.substring(0, answerAll.length - 1).split("|");
                    answerArray.splice(count - 1, 1)
                    answerArray.splice(count - 1, 0, "1")
                    answerAll = answerArray.join("|") + "|";
                    if (answerAll.indexOf("0") == -1 && answerAll.indexOf(" ") == -1) {
                        $('.answerBox-con').hide();
                        $('.answered').show();
                        if(!isReload){
                            $('.answerBtn').text(answerMessage.close);
                            $('.answerBtn').attr("data-flag",2)
                        }else {
                            $('.answerBtn').text(answerMessage.TheNextChapter);
                            $('.answerBtn').attr("data-flag",1)
                        }
                        updateStatus(questionEle.blockId, questionEle.examId, answerAll);
                        getUserInfo();
                        count = 1;
                    } else {
                        updateStatus(questionEle.blockId, questionEle.examId, answerAll);
                        getUserInfo();
                        $('.answerBtn').text(answerMessage.close);
                        $('.answerBtn').attr("data-flag",2)
                        return false
                    }

                } else {
                    var answerArray = answerAll.substring(0, answerAll.length - 1).split("|");
                    answerArray.splice(count - 1, 1)
                    answerArray.splice(count - 1, 0, "1")
                    answerAll = answerArray.join("|") + "|";
                }
                count++;
                $('.pop-up').show();
                $(".question-con ul li input").attr('disabled', true);
            } else {
                var countQuestion = '.countQuestion' + (count - 1);
                $(countQuestion).addClass('errorAns');
                $('.answerBtn').attr("data-flag",3)
                $('.answerBtn').text(answerMessage.reset)
                _Answers.addClass('errorList')
                //修改errorMessage中内容
                $('.errorMessage').text(answerdetail);
                $('.errorMessage').show();
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
                $(".question-con ul li input").attr('disabled', true);
                var answerArray = answerAll.substring(0, answerAll.length - 1).split("|");
                var math=document.getElementsByClassName("errorMessage")[0]
                MathJax.Hub.Queue(["Typeset", MathJax.Hub,math]);

                if (answerArray[count - 1] == '1') {
                    return false;
                }
                answerArray.splice(count - 1, 1)
                answerArray.splice(count - 1, 0, "0")
                answerAll = answerArray.join("|") + "|";
            }

        }
    })
})
// 进入下一题
function problemext(blockId, examId, questionId) {
    questionId = Number(questionId) + 1;
    dataContentText = ''
    $("#question").attr("data-question", questionId)
    $.ajax({
        type: "POST",
        url: base+'/education/examinfo.json',
        dataType: "json",
        data: { blockid: blockId, questionid: questionId, examid: examId },
        success: function (data) {
            if (data.obj == null || data.obj == '') {
                layer.msg(answerMessage.error)
                return false;
            }
            $('.question-conUl').html(getAnswerHtml(data));
            MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            layerOutBoxTop()
        }
    })
}
$('.answerClose').on('click', function () {
    cleatStyle();
    scrollTopAns=0;
    $('#orderBox li').removeClass('rightAns errorAns');
    $('.answerWrapper').hide();
    if (answerAll != '') {
        updateStatus(questionEle.blockId, questionEle.examId, answerAll);
        getUserInfo();
    }
    if(isReload){
        window.location.reload();
    }

})
// 更新答题状态
var answeredScore = 0;
function updateStatus(blockId, examId, status) {
    $.ajax({
        type: "POST",
        url: base+'/education/updexaminfo.json',
        dataType: "json",
        async: false,
        data: {
            examid: examId,
            userid: userInfoId,
            status: status,
            blockid: blockId,
            addscoreflag: true
        },
        success: function (data) {
            // data.obj = answeredScore;
            if(data.obj===0){
                $('.answered_score').text(' ')
            }else {
                $('.answered_score').text('+'+data.obj+'积分')
            }
        }
    })
}

// 获取题目状态
function getStatus(isClick) {
    $.ajax({
        type:"post",
        url:base+'/education/userexaminfo.json',
        dataType: "json",
        data:{userid:userInfoId},
        success:function (data) {
            getAllVideo(data.obj,isClick)
        }
    })
}
// 获取所有题目
function getAllVideo(Status,isClick){
    $.ajax({
        type:"POST",
        url:base+'/education/allexaminfo.json',
        dataType: "json",
        success:function (data) {
            videoDataExam(data.obj,Status,isClick)
        }
    })
}
//获取答案状态信息处理
// questionArray 用来存放问题id    AnswerArray 用来存放问题状态
function videoDataExam(data,userInfo,isClick) {
    questionArray=[]
    // if(data==''||data==null){
    //     questionArray=[]
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
    getStatus(1);//1判断是不是点击，
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
            getAllVideo(data.obj,2)//2为播放完获取状态
        }
    });
}
function AnswerTheQuestions(questionArray,AnswerArray) {
    answerAll='';
    dataContentText='';
    if(questionArray==''){
        layer.msg(answerMessage.noneQues);
        $('.toAnswer').hide();
        return false;
    }else {
        $('.answered').hide();
        $('.answerBox-con').show();
        $('.answerBtn').text(answerMessage.ensure);
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
                    layer.msg(answerMessage.error)
                    return false;
                }
                $('.question-conUl').html(getAnswerHtml(data));
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            }
        })
    }

}