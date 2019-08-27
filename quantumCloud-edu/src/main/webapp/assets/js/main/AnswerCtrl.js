// 答题
//再来一次
//data-flag 1:下一节   2：关闭    3：再来一次  4：下一题
var _Answers,count=1;
var questionArray=[]
var AnswerArray=[]
var isReload=true;
var questionEle={
    blockId:'',
    examId:'',
    questionId:'',
    this:null
};
$('#againDo').on('click',function () {
    answeredScore=0;
    questionEle.questionId=questionEle.questionId.toString().substring(0,questionEle.questionId.toString().substring().length-1);
    problemext(questionEle.blockId,questionEle.examId,questionEle.questionId+0);
    questionEle.questionId=questionEle.questionId+0;
    $('.answered').hide();
    _Answers='';
    $(".answerBtn").attr("data-flag",0)
    $('#orderBox li').removeClass('rightAns errorAns');
    $('.answerBox-con').show();
    $('.answerBtn').text(answerMessage.ensure);
    count=1;
    cleatStyle()
})
function cleatStyle() {
    dataContentText='';
    $(".question-con ul li").removeClass("rightList");
    $(".question-con ul li").removeClass("errorList");
    $('.errorMessage').hide()
    $(".question-con ul li").children('input').removeAttr('checked');
    $(".question-con ul li").children('input').removeAttr('disabled');
    $(".pop-up").attr("style","");
}
function layerOutBoxTop(){
    if($(".answerWrapper").css("display")=="block"){
        var layerOutBoxTop=($(window).height()- $(".answerBox").height())/2
        $(".answerBox").css({"margin-top":layerOutBoxTop+"px"})
    }
}
$(window).resize(function() {
    layerOutBoxTop()
});

var answerAll='',orderBox='',liLength,count=null,dataContentText='';

var _Answers;
function getQuestion(ele){
    $(ele).siblings().children('input').attr('checked',false);
    // $(ele).children('input').removeAttr('checked');
    $(ele).children('input').attr('checked',true);
    $(ele).find('input').prop('checked',true);
    $(ele).attr('checked',true);
    _Answers= $(ele);
}
$('.answerBtn').on("click",function () {
    if(_Answers==undefined||_Answers==''){
        layer.msg("请选择答案");
        return false;
    }
    var dataFlag=$(this).attr("data-flag");
    $(this).attr("data-flag",0);
    var curAnswers =$.trim(_Answers.find('label').text()).charAt(0).toUpperCase();
    if (dataFlag == "4") {
        cleatStyle();
        _Answers='';
        $('.answerBtn').text(answerMessage.ensure)
        problemext(questionEle.blockId,questionEle.examId,$("#question").attr("data-question"))
        return false;
    }
    if (dataFlag == "3") {
        cleatStyle();
        var countQuestionNum = count-1
        $('#orderBox li').eq(countQuestionNum).removeClass('rightAns errorAns');
        _Answers='';
        $('.answerBtn').text(answerMessage.ensure)
        return false;
    }
    if (dataFlag =="1") {
        $('.answerWrapper').hide();
        cleatStyle();
        $('#orderBox li').removeClass('rightAns errorAns');
        $('.answered').hide();
        $('.answerBox-con').show();
        _Answers='';
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
        $('.answerBtn').attr('data-flag','')
        answeredScore=0;
        $('.answerWrapper').hide();
        $('#orderBox li').removeClass('rightAns errorAns');
        $('.answered').hide();
        $('.answerBox-con').show();
        _Answers='';
        $('.answerBtn').text(answerMessage.ensure)
        $(questionEle.this).parents(".video_box").next(".video_box").find(".lockbox").removeClass("lock");
        count = 1;
        cleatStyle();
        if(isReload){
            window.location.reload();
        }
        return false
    }
    var questionid=$("#question").attr("data-question");
    // updateStatus(questionEle.blockId,questionEle.examId,answerAll);
    $.ajax({
        type:"POST",
        url:base+'/education/examAnswerInfo.json',
        dataType: "json",
        data:{
            questionid:questionid,
            blockid:questionEle.blockId,
            examid:questionEle.examId
        },
        success:function (data) {
            if(data.obj==null||data.obj==''){
                layer.msg(answerMessage.error)
                return false;
            }
            var rightAnswers = data.obj.answer;
            var answerdetail=data.obj.answerdetail;
            if(rightAnswers == curAnswers){
                var countQuestion = '.countQuestion'+(count-1);

                // answeredScore = answeredScore+20;
                // $('.answered_score').text('+'+answeredScore+'积分')

                $(countQuestion).addClass('rightAns');
                $('.errorMessage').hide()
                _Answers.addClass('rightList');
                $('.answerBtn').text(answerMessage.next);
                $('.answerBtn').attr("data-flag",4)
                if(count == liLength){
                    var answerArray=answerAll.substring(0,answerAll.length-1).split("|");
                    answerArray.splice(count-1,1)
                    answerArray.splice(count-1,0,"1")
                    answerAll=answerArray.join("|")+"|";
                    if(answerAll.indexOf("0")==-1&&answerAll.indexOf(" ")==-1){
                        $('.answerBox-con').hide();
                        $('.answered').show();
                        if(!isReload){
                            $('.answerBtn').text(answerMessage.close);
                            $('.answerBtn').attr("data-flag",2)
                        }else {
                            $('.answerBtn').text(answerMessage.TheNextChapter);
                            $('.answerBtn').attr("data-flag",1)
                        }

                        updateStatus(questionEle.blockId,questionEle.examId,answerAll);
                        getUserInfo();
                        count=1;
                    }else {
                        updateStatus(questionEle.blockId,questionEle.examId,answerAll);
                        getUserInfo();
                        $('.answerBtn').text(answerMessage.close);
                        $('.answerBtn').attr("data-flag",2)
                        return false
                    }

                }else {
                    // answerAll= answerAll+1+'|';                     
                    var answerArray=answerAll.substring(0,answerAll.length-1).split("|");
                    answerArray.splice(count-1,1)
                    answerArray.splice(count-1,0,"1")
                    answerAll=answerArray.join("|")+"|";
                }
                count++;
                $('.pop-up').show();
                $(".question-con ul li input").attr('disabled',true);
            }else {
                var countQuestion = '.countQuestion'+(count-1);
                $(countQuestion).addClass('errorAns');
                $('.answerBtn').attr("data-flag",3)
                $('.answerBtn').text(answerMessage.reset)
                _Answers.addClass('errorList')
                //修改errorMessage中内容
                $('.errorMessage').text(answerdetail);
                $('.errorMessage').slideDown("fast");
                $(".question-con ul li input").attr('disabled',true);
                var answerArray=answerAll.substring(0,answerAll.length-1).split("|");
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
                if(answerArray[count-1]=='1'){
                    return false;
                }

                answerArray.splice(count-1,1)
                answerArray.splice(count-1,0,"0")
                answerAll=answerArray.join("|")+"|";

                //console.log(answerAll)
            }

        }
    })
})
// 进入下一题
function problemext(blockId,examId,questionId){
    questionId=Number(questionId)+1;
    dataContentText='';
    $("#question").attr("data-question",questionId)
    $.ajax({
        type:"POST",
        url:base+'/education/examinfo.json',
        dataType: "json",
        data:{blockid:blockId,questionid:questionId,examid:examId},
        success:function (data) {
            if(data.obj==null||data.obj==''){
                layer.msg(answerMessage.error)
                return false;
            }
            $('.question-conUl').html(getAnswerHtmlPc(data));
            MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            layerOutBoxTop()
        }
    })
}
$('.answerClose').on('click',function () {
    answeredScore=0;
    cleatStyle();
    $('.answerBtn').attr('data-flag','')
    $('#orderBox li').removeClass('rightAns errorAns');
    $('.answerWrapper').hide();
    if(answerAll!=''){
        updateStatus(questionEle.blockId,questionEle.examId,answerAll);
        getUserInfo();
    }
    if(isReload){
        window.location.reload();
    }

})
// 更新答题状态
var answeredScore=0;
function updateStatus(blockId,examId,status) {
    $.ajax({
        type:"POST",
        url:base+'/education/updexaminfo.json',
        dataType: "json",
        async:false,
        data:{
            examid:examId,
            userid:userInfoId,
            status:status,
            blockid:blockId,
            addscoreflag:true
        },
        success:function (data) {
            // data.obj = answeredScore;
            if(data.obj===0){
                $('.answered_score').text(' ')
            }else {
                $('.answered_score').text('+'+data.obj+'积分')
            }
        }
    })
}

// 学习页可用
$("body").on('click','.testList li',function (i,s) {
    dataContentText='';
    var statusPrev = $(this).prev().attr("class");
    var hasPrev = $(this).prev().attr("data-blockid");
    if(statusPrev != "finished" && typeof(hasPrev) != "undefined") {
        layer.msg(answerMessage.preQuestion);
        return false;
    }
    $('.answered').hide();
    $('.answerBox-con').show();
    $('.answerBtn').text(answerMessage.ensure);
    count=$(this).index()+1;
    cleatStyle()
    questionEle = $(this);
    liLength = questionEle.parent().find('li').length;
    orderBox='';
    questionEle={blockId:'', examId:'', questionId:'',}
    questionEle.blockId = $(this).attr("data-blockid");
    questionEle.this = $(this);
    questionEle.examId = $(this).attr("data-examid");
    questionEle.questionId = $(this).attr("data-questionid");
    liLength = $(this).parent().find('li').length;
    var titleBox =$(this).parent().siblings()[0];
    var titleText = $(titleBox).find('.chapterName').text();
    $('.answerBox-top div').text(titleText)
    cleatStyle();
    if($(this).parents('.testList').siblings('.video-title').find(".lockbox").hasClass("lock")){
        layer.msg(answerMessage.preQuestion);
        return false;
    }
    $('.answerWrapper').show();
    for(var a=0;a<=$(this).parent().find('li').length-1;a++){
        //console.log($(this).parent().find('li').attr("class"))
        if($(this).parent().find('li').eq(a).hasClass("finished")){
            answerAll=answerAll+"1"+"|"
        }else if($(this).parent().find('li').eq(a).hasClass("unfinished")){
            answerAll=answerAll+"0"+"|"
        }else{
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

            $('.question-conUl').html(getAnswerHtmlPc(data));
            MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            layerOutBoxTop()
        }
    })
})



