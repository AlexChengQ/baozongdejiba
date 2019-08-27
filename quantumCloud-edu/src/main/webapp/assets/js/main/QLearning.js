//章节收缩隐藏
var lastVideoBox,lastList;
$('body').on('click',".video-right>ul>li,.showBtn",function (e) {
    var _hash = $(this).parents('li').context.dataset.list.toString()
    window.location.hash = _hash;
    e.stopPropagation();
    var _this = $(this);
    showBox(_this);
    lastVideoBox = _this;
    lastList = _this.attr('data-list')
})
$('body').on('click','.hideBtn',function (e) {

    e.stopPropagation();
    var _this = $(this)
    hideBox(_this);
})
$('body').on('click','.taskBox',function () {

    $('.EDU-active').removeClass('EDU-active');
    $(this).find('.task-list').addClass('EDU-active');
    var _this = $(this);
    lastList = $(this).attr('data-list');
    showBox(_this);
    lastVideoBox = $('.listNum'+lastList);
    // console.log(lastVideoBox)
})

function showBox(_this) {
    var list = _this.attr('data-list');
    var section_list = ".section_list"+list;
    var videoBoxValue = ".video-box-value"+list;
    var eleClick = ".click_show"+list;
    $("body").find(videoBoxValue).attr('flagState','true');
    $("body").find(section_list).slideUp();
    $("body").find(videoBoxValue).slideDown();
    $("body").find(eleClick).css({
        'transform':'rotateZ(180deg)',
        'transition':'transform 0.5s'
    })
    if(lastList && _this.attr('data-list') != lastList){
        hideBox(lastVideoBox);
        lastVideoBox = _this;
    }
}
function hideBox(_this) {
    var list = _this.attr('data-list');
    var sectionList = ".section_list"+list;
    var videoBoxValue = ".video-box-value"+list;
    var eleClick = ".click_show"+list;
    $("body").find(sectionList).slideDown();
    $("body").find(videoBoxValue).slideUp();
    $("body").find(eleClick).css({
        'transform':'rotateZ(0deg)',
        'transition':'transform 0.5s'
    })
    $("body").find(eleClick).slideDown()
}

// <#--前往视频页-->
$("body").on("click",".video_v",function () {
    // if(!$(this).parents(".video_box_left").siblings(".video_box_content").find(".lockbox").hasClass("lock")){
    window.location.href=base+"/EDU/video.html?link="+$(this).attr("data-value");
    // }else {layer.msg("请完成上一节")}
})

//登录
$(document).keydown(function(event) {
    if (event.keyCode == 13) {submitLogin();}
});
function submitLogin() {
    var forward = "";
    var params = {};
    params['email'] = $("input[name=email]").val();
    params['password'] = $.md5($("input[name=password]").val());

    if(params['email']==''||params['email']==null){
        $("input[name=email]").attr('placeholder','请输入邮箱地址');
        $("input[name=email]").addClass("active");
        return false;
    }else {
        $("input[name=email]").removeClass("active");
    }

    if($("input[name=password]").val()==''||$("input[name=password]").val()==null){
        $("input[name=password]").attr('placeholder','请输入密码');
        $("input[name=password]").addClass("active");
        return false;
    }else {
        $("input[name=password]").removeClass("active");
    }
    $.post(base+'/doLogin.json', params, function(data) {
        if (data.success) {
            $(".ajaxError").hide();
            if($(".LoginRdLeft").find("i").hasClass("active")){
                setCookie("isCookies",1);
                setCookie("getUsername", $("input[name='email']").val());
                setCookie("getPassword", $("input[name='password']").val());
            }else{
                setCookie("isCookies",'0');
                setCookie("getUsername", '');
                setCookie("getPassword", '')
            }
            if(forward!=null&&forward!=''){
                window.parent.location.href = forward;
            }else{
                parent.location.reload();
            }

        } else {
            $(".ajaxError").show();
            $(".LoginContent").shake(2, 10, 400);
        }
    });
}