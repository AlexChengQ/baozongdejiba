$(function() {
//右侧窗体高度

    //悬停展开
    //关闭click.bs.dropdown.data-api事件，使顶级菜单可点击
    $(document).off('click.bs.dropdown.data-api');
    //自动展开
    $('.nav .dropdown').mouseenter(function(i,s){
        $(this).addClass('open');
        $(".dropdown-menu").eq(0).css({"text-align":"center", "right":"-100px"});
        $(".dropdown-menu").eq(1).css({"text-align":"center", "right":"8px"});
        $(".dropdown-menu").eq(2).css({"text-align":"center", "right":"-36px"});
        $(".dropdown-menu").eq(3).css({"text-align":"center", "right":"-36px"});

        if(lan=='en_US'){//中文
            $(".dropdown-menu").eq(0).css({"text-align":"center", "right":"-100px"});
            $(".dropdown-menu").eq(1).css({"text-align":"center", "right":"8px"});
            $(".dropdown-menu").eq(2).css({"text-align":"center", "right":"-36px"});
            $(".dropdown-menu").eq(3).css({"text-align":"center", "right":"-36px"})
        }else{//英文
            $(".dropdown-menu").eq(0).css({"text-align":"center", "right":"-52px"});
            $(".dropdown-menu").eq(1).css({"text-align":"center", "right":"-30px"});
            $(".dropdown-menu").eq(2).css({"text-align":"center", "right":"-36px"});
            $(".dropdown-menu").eq(3).css({"text-align":"center", "right":"-36px"})
        }
    });
    //自动关闭
    $('.nav .dropdown').mouseleave(function(){
        $(this).removeClass('open');
    });

    $("#qcodeSvgContainer").show();

    //当文档窗口发生改变时 触发
    $(window).resize(function () {
        if($(window).width() > 1200)
            $(".logo-text-en").show();
    });

    //    结束任务 左上角×号
    $(".closeBtn").click(function () {

        if (fromAdmin != undefined && fromAdmin == "1") {prompt(messages.unauthorized_operation);return false;}
        $('#myModa3').hide();
        $(".NewConBtnBox button").attr("disabled",false)
        if($("#versionId").val()){
            window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val() + "&versionId=" + $("#versionId").val();
        }else {
            window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val();
        }
    });
    $(window).load(function () {
        $("#semi").val(1);
        $("#typeId").val(1);
        //下一步选择切换
        /*$('.zi-left').click(function () {
        $(this).addClass('bbr').siblings().removeClass('bbr')
        $(this).children("span").show().parent().siblings('.zi-left').children("span").hide();
        $("#typeId").val($(this).attr('taskType'));
    });*/
        $('.f-jiaocheng ul li').click(function () {
            $(this).addClass('bbr').siblings().removeClass('bbr')
            $(this).children("span").show().parent().siblings('.f-jiaocheng ul li').children("span").hide();
            $("#semi").val($(this).attr('semi'));
        });
        //头部点击按钮切换
        if ($("#projectId").val() == 257) {
            $("#jc2").removeClass('jc-but')
            $("#jc1").addClass('jc-but')
        } else if($("#projectId").val() == 258){
            $("#jc1").removeClass('jc-but')
            $("#jc2").addClass('jc-but')
        }

        $("#flag").val(0);

        if(isIndex!=undefined||isIndex==1){
            $("#classicName").select2({language: 'zh-CN'});
            $("#iswap").select2({language: 'zh-CN'});
            $('#myModal').modal({backdrop: 'static', show: false});
            $('#myModa2').modal({backdrop: 'static', show: false});
            $('#myModa3').modal({backdrop: 'static', show: false});
            $('#myModa4').modal({backdrop: 'static', show: false});
        }
        $('.showone').click(function () {
            $(".first").show();
            $(".second").hide();
            $(".there").hide();
            $(".four").hide();
        });
        $('.daima').click(function () {
            $(".case-bottom").getNiceScroll().resize();
        });
        //遮罩
        $('.moda').click(function () {
            $('.loading-bg').show();
            $('.loading').show();
            setTimeout("$('.loading').hide()", 5000);
            setTimeout("$('.loading-bg').hide()", 5000);
        });

        $('script[data-url]').each(function () {
            var _this = $(this),
                url = _this.attr('data-url');
            _this.attr('src', url);
        });
        //老版代码合集开关
        $(".dmhj_but").click(function () {if ($('.dmhj').is(':hidden')) {$('.dmhj').slideDown('slow');} else {$('.dmhj').slideUp('slow');}});
    });

    /*用户申请下拉框*/
    $("#select_option").click(function () {
        var index = $("#select_option option:selected").index();
        $(".select_li li").eq(index).addClass("active").siblings().removeClass("active");
    });

});
var count = 0;
function resizeScroll(){
    setTimeout(function(){
        if (count == 50){return ;}
        $(".case-left").removeAttr("style");
        count++;
        $(".nicescroll-rails-vr").remove();
        $("#ascrail2000-hr").css("top","-5px");
        $("#ascrail2000-hr").css("left","120px");
        $("#ascrail2000-hr").css("position","relative");
        resizeScroll();
    },200);
};
/*三步走*/
function shows(qb){
    var type = $("#typeId").val();
    $(".first").hide();
    $(".second").show();
    if(type==3){
        $("#projectName").val($("#projectTime").val()+"Semi-2Q");
        $("#desc").val(messages.app_js_desc);
    }else if(type==2){
        $("#projectName").val($("#projectTime").val()+"Spcd6Q");
        $("#desc").val("");
    }else{
        $("#projectName").val($("#projectTime").val()+"QEmulator");
        $("#desc").val("");
    }

    if(qb!=1){
        $(".guideId2").attr("style","");
        setTimeout(function () {CloudCLD.guideLocation(40,-175, -30,"auto","auto",-50, 13 ,-48 ,3 ,'.second');},300)
    }
}
function showt(bq){
    var name = $("#projectName").val();
    var type = $("#typeId").val();
    if(getCookie("isTip")=="0"){
        $("#analogType").attr("disabled",true)
        $("#qubitNum").attr("disabled",true)
        $("#classicalbitNum").attr("disabled",true)
    }
    if(name==''){errorMsg(messages.project_name_not_null); return false;}
    if(type==3){
        $(".four").show();
        $(".second").hide();
    }else if(type==2){
        $(".there").show();
        $(".second").hide();
        $("#qubitNumDesc").html(messages.number_of_qubits+"<br/> <span>(1-6)</span>");
        $("#analogTypeId").html(messages.analog_type);
        $("#classicalbitNumDesc").html(messages.number_of_classical_registers+"<br/> <span>(1-255)</span>");
        $("#qubitNum").val(2);
        $("#classicalbitNum").val(2);
    }else{
        $(".there").show();
        $(".second").hide();
        $("#qubitNumDesc").html(messages.number_of_qubits_1_30);
        $("#analogTypeId").html(messages.analog_type);
        $("#classicalbitNumDesc").html(messages.number_of_classical_registers_1_255);
        $("#analogType").val(0);
        $("#qubitNum").val(6);
        $("#classicalbitNum").val(6);
    }

    if(bq!=2){
        $(".guideId3").attr("style",'');
        setTimeout(function () {CloudCLD.guideLocation(100,-100, -90,"auto","auto",-50, 13 ,-48 ,4 ,'.there');},300)
    }
}
function closeme(){$(".contentt").hide();}

//返回上一步
function previousStep(flag) {
    $(".guideContent>div").attr("style","");
    if (flag==1){
        $(".first").show();
        $(".second").hide();
        if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
            CloudCLD.nextStep(2)
        }
    }
    if (flag==2){
        $(".second").show();
        $(".there").hide();
        if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
            CloudCLD.nextStep(3)
        }
    }
}

function errorMsg(message){
    var n = noty({
        text        : message,
        type        : 'error',
        dismissQueue: true,
        layout      : 'center',
        theme       : 'relax',
        timeout		: 1500,progressBar: false
    });
}
/*介绍*/
$(function(){
    function show(index) {
        $(".case-list dl").eq(index).children("dd").hover(function () {
            if(analogType==2){
                if(index==0){
                    if($(this).index()==1){
                        $(".case-js dl").eq(index).children("dd").eq($(this).index() +2).css("left","-5px")
                    }else {
                        $(".case-js dl").eq(index).children("dd").eq($(this).index() +2).css("left","30px")
                    }
                    $(".case-js dl").eq(index).children("dd").eq($(this).index() +2).show().siblings().hide();

                }else if(index==1){
                    $(".case-js dl").eq(index).children("dd").eq(1).show().siblings().hide();
                    $(".case-js dl").eq(index).children("dd").eq(1).css("left","47px");
                }else  if(index==2){
                    $(".case-js dl").eq(index).children("dd").eq($(this).index() -1).show().siblings().hide();
                    $(".case-js dl").eq(index).children("dd").eq($(this).index() -1).css("left","107px");
                }
            }else {
                $(this).append('<span class="jt"></span>');
                $(".case-js dl").eq(index).children("dd").eq($(this).index() -1).show().siblings().hide();
            }

        },function () {
            $(this).find(".jt").remove();
            $(".case-js dl").children("dd").hide();
        });
    }
    show(0);
    show(1);
    show(2);
    show(3);
    show(6);
});

function toPage(page) {
    $("#startId").val(page);
    document.getElementById("searchForm").reset();
    $("#searchForm").submit();
}




/*新的导航*/
var maxHeight = 400;

$(function(){
    $('.dropdown li').click(function () {$(this).addClass('nav_cur').siblings().removeClass('nav_cur')})
    $(".dropdown > li").hover(function() {
        var $container = $(this),
            $list = $container.find("ul"),
            $anchor = $container.find("a"),
            height = $list.height() * 1.1,
            multiplier = height / maxHeight;
        $container.data("origHeight", $container.height());
        $anchor.addClass("hover");

        $list
            .show()
            .css({paddingTop: $container.data("origHeight")});

        if (multiplier > 1) {
            $container
                .css({height: maxHeight, overflow: "hidden"})
                .mousemove(function(e) {
                    var offset = $container.offset();
                    var relativeY = ((e.pageY - offset.top) * multiplier) - ($container.data("origHeight") * multiplier);
                    if (relativeY > $container.data("origHeight")) {$list.css("top", -relativeY + $container.data("origHeight"));};
                });
        }
    }, function() {
        var $el = $(this);
        $el
            .height($(this).data("origHeight"))
            .find("ul")
            .css({ top: 0 })
            .hide()
            .end()
            .find("a")
            .removeClass("hover");
    });
});


//分页新款
(function($) {
        var ms = {
            init: function(obj, args ) {
                return (function() {
                    ms.fillHtml(obj, args);
                    ms.bindEvent(obj, args);
                })();
            },
            fillHtml: function(obj, args ) {
                return (function() {
                        obj.empty();
                        if (args.current > 1) {
                            obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.current-2)+')">&lt;上一页</a></li>');
                        } else {
//                                        obj.remove('.prevPage');
//                                        obj.append('<li class="disabled"><a tabindex="0">&lt;上一页</a></li>');
                        }
                        if (args.current != 1 && args.current >= 4 && args.pageCount != 4) {
                            obj.append('<li class="page-item"><a tabindex="3" onclick="toLocation(0)">'+1+'</a></li>');
                        }
                        if (args.current - 2 > 2 && args.current <= args.pageCount && args.pageCount > 5) {
                            obj.append('<li class="page-item"><span>...</span></li>');
                        }
                        var start = args.current - 2
                            , end = args.current + 2;
                        if ((start > 1 && args.current < 4) || args.current == 1) {end++;}
                        if (args.current > args.pageCount - 4 && args.current >= args.pageCount) {start--;}
                        for (; start <= end; start++) {
                            if (start <= args.pageCount && start >= 1) {
                                if (start != args.current) {
                                    obj.append('<li class="page-item"><a tabindex="3" onclick="toLocation('+(start-1)+')">'+start+'</a></li>');
                                } else {
                                    obj.append('<li class="page-item active"><a tabindex="3" onclick="toLocation('+(start-1)+')">'+start+'</a></li>');
                                }
                            }
                        }
                        if (args.current + 2 < args.pageCount - 1 && args.current >= 1 && args.pageCount > 5) {
                            obj.append('<li class="page-item"><span>...</span></li>');
                        }
//                                    if (args.current != args.pageCount && args.current < args.pageCount - 2 && args.pageCount != 4) {
//                                        obj.append('<a href="javascript:;" class="tcdNumber">' + args.pageCount + '</a>');
//                                    }
                        if (args.current < args.pageCount) {
                            obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.result.nextPage-1)+')">下一页&gt;</a></li>');
                        } else {
//                                        obj.remove('.nextPage');
//                                        obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.result.nextPage-1)+')">下一页&gt;</a></li>');
                        }

                        if(args.result.entityList.length==0){
                            obj.append('<li class="disabled"><a tabindex="0" >暂无数据</a></li>');
                        }
//                                    obj.append('<span class="pagecount">共' + args.pageCount + '页</span>');
//                                    if (args.turndown == 'true') {
//                                        obj.append('<span class="countYe">到第<input type="text" maxlength=' + args.pageCount.toString().length + '>页<a href="javascript:;" class="turndown">确定</a><span>');
//                                    }
                    }
                )();
            },
            bindEvent: function(obj, args) {
                return (function() {
                        obj.on("click", "a.tcdNumber", function() {
                            var current = parseInt($(this).text());
                            ms.fillHtml(obj, {
                                "current": current,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current);
                            }
                        });
                        obj.on("click", "a.prevPage", function() {
                            var current = parseInt(obj.children("span.current").text());
                            ms.fillHtml(obj, {
                                "current": current - 1,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current - 1);
                            }
                        });
                        obj.on("click", "a.nextPage", function() {
                            var current = parseInt(obj.children("span.current").text());
                            ms.fillHtml(obj, {
                                "current": current + 1,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current + 1);
                            }
                        });
                        obj.on("click", "a.turndown", function() {
                            var page = $("span.countYe input").val();
                            if (page > args.pageCount) {
                                alert("您的输入有误，请重新输入！");
                            }
                            ms.fillHtml(obj, {
                                rusult:args.result,
                                "current": page,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                        });
                    }
                )();
            }
        }
        $.fn.createPage = function(options) {
            var args = $.extend({
                result:'',
                pageCount: 10,
                current: 1,
                turndown: true,
                backFn: function() {}
            }, options);
            ms.init(this, args);
        }
    }
)(jQuery);

//输入框调整
;(function ($) {
    // Constructor
    function FT(elem) {
        this.$textarea = $(elem);
        this._init();
    }
    FT.prototype = {
        _init: function () {
            var _this = this;
            // Insert wrapper elem & pre/span for textarea mirroring
            this.$textarea.wrap('<div class="flex-text-wrap" style="min-height: 104px;height: 104px" />').before('<pre class="pre" style="display:none;"><span /><br /></pre>');
            this.$span = this.$textarea.prev().find('span');
            // Add input event listeners
            // * input for modern browsers
            // * propertychange for IE 7 & 8
            // * keyup for IE >= 9: catches keyboard-triggered undos/cuts/deletes
            // * change for IE >= 9: catches mouse-triggered undos/cuts/deletions (when textarea loses focus)
            this.$textarea.on('input propertychange keyup change', function () {_this._mirror();});

            // jQuery val() strips carriage return chars by default (see http://api.jquery.com/val/)
            // This causes issues in IE7, but a valHook can be used to preserve these chars
            $.valHooks.textarea = {
                get: function (elem) {return elem.value.replace(/\r?\n/g, "\r\n");}
            };
            // Mirror contents once on init
            this._mirror();
        }

        // Mirror pre/span & textarea contents
        , _mirror: function () {
            this.$span.text(this.$textarea.val());
        }
    };

    // jQuery plugin wrapper
    $.fn.flexText = function () {
        return this.each(function () {
            // Check if already instantiated on this elem
            if (!$.data(this, 'flexText')) {
                // Instantiate & store elem + string
                $.data(this, 'flexText', new FT(this));
            }
        });
    };

})(jQuery);

//视频全屏显示
(function ($) {
    // Adding a new test to the jQuery support object
    $.support.fullscreen = supportFullScreen();
    // Creating the plugin
    $.fn.fullScreen = function (props) {
        if (!$.support.fullscreen || this.length != 1) {
            // The plugin can be called only
            // on one element at a time
            return this;
        }

        if (fullScreenStatus()) {

            $("#box-close").css({"right":"-80px"})
            $("#my_video_1").removeClass("vjs-fullscreen");
            $("#my_video_1").removeClass("vjs-ended");
            $("#my_video_1").removeClass("vjs-paused");
            // if we are already in fullscreen, exit
            cancelFullScreen();

            return this;
        }else {
            $("#my_video_1").addClass("vjs-fullscreen");
            $("#my_video_1").addClass("vjs-ended");
            $("#my_video_1").addClass("vjs-paused");
            $("#box-close").css({"right":"10px"})
        }
        // You can potentially pas two arguments a color
        // for the background and a callback function
        var options = $.extend({
            'background': '#111',
            'callback': function () {}
        }, props);

        // This temporary div is the element that is
        // actually going to be enlarged in full screen

        var fs = $('<div>', {
            'css': {
                'overflow-y': 'auto',
                'background': options.background,
                'width': '100%',
                'height': '100%'
            }
        });

        var elem = this;

        // You can use the .fullScreen class to
        // apply styling to your element
        elem.addClass('fullScreen');

        // Inserting our element in the temporary
        // div, after which we zoom it in fullscreen
        fs.insertBefore(elem);
        fs.append(elem);
        requestFullScreen(fs.get(0));

        fs.click(function (e) {
            if (e.target == this) {
                // If the black bar was clicked
                cancelFullScreen();
            }
        });
        elem.cancel = function () {
            cancelFullScreen();
            return elem;
        };
        onFullScreenEvent(function (fullScreen) {
            if (!fullScreen) {
                // We have exited full screen.
                // Remove the class and destroy
                // the temporary div
                    $("#box-close").css({"right":"-80px"})
                    $("#my_video_1").removeClass("vjs-fullscreen");
                    $("#my_video_1").removeClass("vjs-ended");
                    $("#my_video_1").removeClass("vjs-paused");
                    // if we are already in fullscreen, exit
                    //cancelFullScreen();

                    //return this;

                elem.removeClass('fullScreen').insertBefore(fs);
                fs.remove();
            }
            // Calling the user supplied callback
            options.callback(fullScreen);
        });
        return elem;
    };


    // These helper functions available only to our plugin scope.


    function supportFullScreen() {
        var doc = document.documentElement;
        return ('requestFullscreen' in doc) ||
            ('mozRequestFullScreen' in doc && document.mozFullScreenEnabled) ||
            ('webkitRequestFullScreen' in doc)||
            ('msRequestFullscreen' in doc);
    }

    function requestFullScreen(elem) {
        if (elem.requestFullscreen) {
            elem.requestFullscreen();
        } else if (elem.mozRequestFullScreen) {
            elem.mozRequestFullScreen();
        } else if (elem.webkitRequestFullScreen) {
            elem.webkitRequestFullScreen();
        }else if(elem.msRequestFullscreen){
            elem.msRequestFullscreen();
        }
    }

    function fullScreenStatus() {
        return document.fullscreen ||
            document.mozFullScreen ||
            document.webkitIsFullScreen||
            document.msFullscreenElement ;
    }

    function cancelFullScreen() {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        }else if(document.msExitFullscreen){
            document.msExitFullscreen()
        }
    }

    function onFullScreenEvent(callback) {
        $(document).on("fullscreenchange mozfullscreenchange webkitfullscreenchange MSFullscreenChange", function () {
            // The full screen status is automatically
            // passed to our callback as an argument.
            callback(fullScreenStatus());
        });
    }

})(jQuery);
// JavaScript Document
var flagTime=0;
//var path='http://vali.cp31.ott.cibntv.net/youku/6977E940E713A7171FEB62FCC/03000801005B2C9A85D5AE003E880348BAB34E-F210-65BC-FB34-6E283F6913F6.mp4?sid=053145202822012201600_00_Ac0998505fc404d43f6a9f9ee4c22bb7d&sign=db88667bf078d680b45b69121afbca59&ctype=50&hd=1'
function appHmtl(link) {
    var _html=' <div id="videoplayer_overlay" style="">' +
        '<div id="videoplayer_outer_container"><div id="videoplayer_container"><div id="videoplayer">' +
        '<div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto" class="video-js vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-playing vjs-user-inactive" id="my_video_1" style="width: 100%; height: 100%;">' +
        '<video  id="my_video_1_html5_api" class="vjs-tech" preload="auto"  preload=""  poster="" data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="'+link+'">' +
        '<source type="video/mp4" src="'+link+'"></video><div></div>' +
        '<div class="vjs-loading-spinner"></div><div class="vjs-text-track-display vjs-hidden"></div><div class="vjs-big-play-button" role="button" aria-live="polite" tabindex="0" aria-label="play video"><span aria-hidden="true"></span></div><div class="vjs-control-bar"><div class="vjs-play-control vjs-control  vjs-playing" role="button" aria-live="polite" tabindex="0"><div class="vjs-control-content"><span class="vjs-control-text">Pause</span></div></div><div class="vjs-current-time vjs-time-controls vjs-control"><div class="vjs-current-time-display" aria-live="off"><span class="vjs-control-text">Current Time</span> 2:02</div></div><div class="vjs-time-divider"><div><span>/</span></div></div><div class="vjs-duration vjs-time-controls vjs-control"><div class="vjs-duration-display" aria-live="off"><span class="vjs-control-text">Duration Time</span> 4:55</div></div><div class="vjs-remaining-time vjs-time-controls vjs-control"><div class="vjs-remaining-time-display" aria-live="off"><span class="vjs-control-text">Remaining Time</span> -2:53</div></div><div class="vjs-live-controls vjs-control"><div class="vjs-live-display" aria-live="off"><span class="vjs-control-text">Stream Type</span>LIVE</div></div>' +
        '<div class="vjs-progress-control vjs-control">' +
        '<div role="slider" aria-valuenow="60.21" aria-valuemin="0" aria-valuemax="100" tabindex="0" class="vjs-progress-holder vjs-slider" aria-label="video progress bar" aria-valuetext="3:02">' +
        '<div class="vjs-load-progress" style="width: 100%;">' +
        '<span class="vjs-control-text" style="left: 0%; width: 9.93072%;">' +
        '<span>Loaded</span>: 0%</span><div style="left: 14.3375%; width: 85.6625%;">' +
        '</div></div><div class="vjs-play-progress" style="width: 0%;"><' +
        'span class="vjs-control-text"><span>Progress</span>: 0%</span>' +
        '</div>' +
        '<div class="vjs-seek-handle vjs-slider-handle" aria-live="off" style="left: 60.21%;"><span class="vjs-control-text"></span></div></div></div>'+
        '<div class="vjs-fullscreen-control vjs-control " role="button" aria-live="polite" tabindex="0"><div class="vjs-control-content"><span class="vjs-control-text">Fullscreen</span></div></div>' +
        '<div style="position: relative;cursor: pointer" onmouseenter="showBox()" onmouseleave="hideBox()"><span id="ulPx">清晰度</span><ul id="pxBox"><li id="p720" style="margin-bottom: 5px" onclick="chosePx(event)">720P</li><li id="p360" style="margin-bottom: 5px" onclick="chosePx(event)">360P</li></ul></div>'+
        '<div onmouseenter="showBox1()" onmouseleave="hideBox1()"><span class="speed-box" >1.0x</span><ul class="speed-list-box" onclick="choseSpeed(event)"><li id="norSpeed">1.0x</li><li id="fastSpeed">1.5x</li><li id="slowSpeed">2.0x</li></ul></div>'+
        '<div class="vjs-volume-control vjs-control"><div role="slider" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" tabindex="0" class="vjs-volume-bar vjs-slider" aria-label="volume level" aria-valuetext="100%"><div class="vjs-volume-level"><span class="vjs-control-text"></span></div><div class="vjs-volume-handle vjs-slider-handle"><span class="vjs-control-text"  id="timesID"></span></div></div></div><div class="vjs-mute-control vjs-control" role="button" aria-live="polite" tabindex="0"><div><span class="vjs-control-text">Mute</span></div></div><div class="vjs-playback-rate vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true"><div class="vjs-control-content"><span class="vjs-control-text">Playback Rate</span><div class="vjs-menu"><ul class="vjs-menu-content"></ul></div></div><div class="vjs-playback-rate-value">1</div></div><div class="vjs-subtitles-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Subtitles Menu"><div class="vjs-control-content"><span class="vjs-control-text">Subtitles</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">subtitles off</li></ul></div></div></div><div class="vjs-captions-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Captions Menu"><div class="vjs-control-content"><span class="vjs-control-text">Captions</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">captions off</li></ul></div></div></div><div class="vjs-chapters-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Chapters Menu"><div class="vjs-control-content"><span class="vjs-control-text">Chapters</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-title">Chapters</li></ul></div></div></div></div><div class="vjs-error-display"><div></div></div><div class="vjs-caption-settings vjs-modal-overlay vjs-hidden"><div class="vjs-tracksettings"><div class="vjs-tracksettings-colors"><div class="vjs-fg-color vjs-tracksetting"><label class="vjs-label">Foreground</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-text-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Opaque</option></select></span></div><div class="vjs-bg-color vjs-tracksetting"><label class="vjs-label">Background</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-bg-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div><div class="window-color vjs-tracksetting"><label class="vjs-label">Window</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-window-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div></div><div class="vjs-tracksettings-font"><div class="vjs-font-percent vjs-tracksetting"><label class="vjs-label">Font Size</label><select><option value="0.50">50%</option><option value="0.75">75%</option><option value="1.00" selected="">100%</option><option value="1.25">125%</option><option value="1.50">150%</option><option value="1.75">175%</option><option value="2.00">200%</option><option value="3.00">300%</option><option value="4.00">400%</option></select></div><div class="vjs-edge-style vjs-tracksetting"><label class="vjs-label">Text Edge Style</label><select><option value="none">None</option><option value="raised">Raised</option><option value="depressed">Depressed</option><option value="uniform">Uniform</option><option value="dropshadow">Dropshadow</option></select></div><div class="vjs-font-family vjs-tracksetting"><label class="vjs-label">Font Family</label><select><option value="">Default</option><option value="monospaceSerif">Monospace Serif</option><option value="proportionalSerif">Proportional Serif</option><option value="monospaceSansSerif">Monospace Sans-Serif</option><option value="proportionalSansSerif">Proportional Sans-Serif</option><option value="casual">Casual</option><option value="script">Script</option><option value="small-caps">Small Caps</option></select></div></div></div><div class="vjs-tracksettings-controls"><button class="vjs-default-button">Defaults</button><button class="vjs-done-button">Done</button></div></div><a class="icon-view-close" id="box-close" href="javascript:;">&times;</a></div></div></div></div></div>';
    return _html;
}
function appHmtl2(link) {
    var _html='<div id="videoplayer_overlay" style=""><div id="videoplayer_outer_container"><div id="videoplayer_container"><div id="videoplayer"><div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto" class="video-js vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-user-active vjs-paused" id="my_video_1" style="width: 100%; height: 100%;"><video id="my_video_1_html5_api" class="vjs-tech" preload="auto" autoplay="autoplay" controls="controls" poster="" data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="'+link+'"><source type="video/mp4" src="'+link+'"></video><div></div><a class="icon-view-close" id="box-close" href="javascript:;">×</a></div></div></div></div></div>'
        return _html;
}
function showBox1() {
    $('.speed-list-box').show()
}
function hideBox1() {
    $('.speed-list-box').hide()
}
//切换播放速度
function choseSpeed(e){
    var target = e.target.id;
    var speedText = $('#'+target).text();
    $('.speed-box').text(speedText)
    switch (target) {
        case 'norSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 1;
            break;
        case 'fastSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 1.5;
            break;
        case 'slowSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 2;
            break;
        default:
            $('.speed-box').text("1.0x")
            $('#my_video_1_html5_api')[0].playbackRate = 1;
    }
    $('.speed-list-box').hide()
}

// 添加侦听时间，DOM加载完后执行。
// document.addEventListener('DOMContentLoaded', function() {});
document.addEventListener("WeixinJSBridgeReady", function() {
    // $("body").find("#my_video_1_html5_api").get(0).play();
}, false);
function showBox() {
    $('#pxBox').show();
}
function hideBox() {
    $('#pxBox').hide();
}
var time = 0;
function chosePx(e) {
    var vide = document.getElementById('my_video_1_html5_api');
    var getTime =  $('#my_video_1_html5_api')[0].currentTime;
    $("body").find("#my_video_1_html5_api").get(0).pause();
    hideBox();
    var target = e.target.id;
    var pxText = $('#'+target).text();
    $('#ulPx').text(pxText)
    if(target == 'p360'){
        var d = new Date();
        var date=new Date(d.getFullYear()
            , d.getMonth()
            , d.getDate()
            , d.getHours()
            , d.getMinutes()
            , d.getSeconds())
        date.toUTCString();
        date=Math.floor(date.getTime()/ 1000);
        //加密后缀,将originquantum+文件路径+utc时间用md5加密
        var encode=$.md5("originquantum/360p/"+dataValue+date)+"&qubit="+date;
        path="http://fast.qpanda.cn/360p/"+dataValue+"?video="+encode;

    }else{
        path="http://video.qpanda.cn:65520/"+dataValue;
    }
    //学术报告视频特殊地址处理
    if(specialPath){
        path=specialPath;
    }
    if(isWeiXin()){
        clearInterval(progressFlag);
        $('#my_video_1_html5_api').attr("src",path);
        $("body").find("#my_video_1_html5_api").get(0).play();
        $(this).addClass("vjs-playing")
        $("body").find(".video-js").addClass("vjs-playing")
        $(this).removeClass("vjs-paused")
    }else {
        clearInterval(progressFlag);
        $('#my_video_1_html5_api').attr("src",path);
        $("body").find("#my_video_1_html5_api").get(0).play();
        $(this).addClass("vjs-playing")
        $("body").find(".video-js").addClass("vjs-playing")
        $(this).removeClass("vjs-paused")
    }
    vide.currentTime = getTime;
}
function getToolsCtrl() {

    $("body").find("#my_video_1_html5_api").get(0).play();
    $("body").find(".video-js").hover(function () {
        $(".video-js").addClass("vjs-user-active");
        $(".video-js").removeClass("vjs-user-inactive");
    },function () {
        $(".video-js").removeClass("vjs-user-active");
        $(".video-js").addClass("vjs-user-inactive");
    })
    $(".vjs-fullscreen-control").on("click",function (event) {
        $(this).parent().parent().fullScreen()
        $(".vjs-play-control").addClass("vjs-playing");
        var w=null;
        clearTimeout(w)
        if(!flagTime){
            w=setTimeout(function () {
                $("body").find("#my_video_1_html5_api").get(0).play()
            },300)
        }
        event.stopPropagation();
    })

    $("body").find(".vjs-play-control").on("click",function (e) {
        if($(this).hasClass("vjs-playing")){
            flagTime=1;
            $(this).removeClass("vjs-playing")
            $("body").find(".video-js").removeClass("vjs-playing")
            $(this).addClass("vjs-paused");
            $("body").find("#my_video_1_html5_api").paused = true;
            $("body").find("#my_video_1_html5_api").get(0).pause()
            e.stopPropagation();
        }else {
            flagTime=0
            $(this).addClass("vjs-playing")
            $("body").find(".video-js").addClass("vjs-playing")
            $(this).removeClass("vjs-paused")
            $("body").find("#my_video_1_html5_api").paused = false;
            $("body").find("#my_video_1_html5_api").get(0).play();
            e.stopPropagation();
        }
    })

    $("body").find("#box-close").on("click",function () {
        $("body").find("#my_video_1_html5_api").get(0).pause();
        $("#videoplayer_overlay").remove()
    })
    $("body").find(".video-js").on("click",function (s) {
        if($(this).hasClass("vjs-playing")){
            flagTime=1;
            $(this).removeClass("vjs-playing")
            $("body").find(".video-js").removeClass("vjs-playing")
            $(this).addClass("vjs-paused");
            $("body").find("#my_video_1_html5_api").paused = true;
            $("body").find("#my_video_1_html5_api").get(0).pause();
            s.stopPropagation();
        }else {
            flagTime=0;
            $(this).addClass("vjs-playing")
            $("body").find(".video-js").addClass("vjs-playing")
            $(this).removeClass("vjs-paused")
            $("body").find("#my_video_1_html5_api").paused = false;
            $("body").find("#my_video_1_html5_api").get(0).play();
            s.stopPropagation();
        }
    })
    var l=null;
    l=setTimeout(function () {
        clearTimeout(l)
        //获取视频时间
        $(document).ready(function(){
            $("body").find("#my_video_1_html5_api").on(
                "timeupdate", function(event){
                    onTrackedVideoFrame(this.currentTime, this.duration);
                });
        });
        function onTrackedVideoFrame(currentTime, duration){
            $("#current").text(currentTime);
            $("#duration").text(duration);
            var a=currentTime/duration;
            var b=(a*100)+"%";
            document.getElementsByClassName('vjs-play-progress')[0].style.width=b;
            $("#hy").text(b);
            if(currentTime==duration){
                $("#pro").text("(已完成)");
            }
        }
    },100)
}

function isWeiXin(){
    //window.navigator.userAgent属性包含了浏览器类型、版本、操作系统类型、浏览器引擎类型等信息，这个属性可以用来判断浏览器类型
    var ua = window.navigator.userAgent.toLowerCase();
    //通过正则表达式匹配ua中是否含有MicroMessenger字符串
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return true;
    }else{
        return false;
    }
}
var dataValue,specialPath=null,videoSetTime=null;
function videoPlay (videoPat) {
    clearInterval(videoSetTime);
    specialPath=null;
    var host=window.location.hostname;
    var path='';
    dataValue = $(videoPat).find(".vid_screenshot").attr("data-value");
    //获取utc时间
    var d = new Date();      
    var date=new Date(d.getFullYear()
        , d.getMonth()
        , d.getDate()
        , d.getHours()
        , d.getMinutes()
        , d.getSeconds())
        date.toUTCString();
    date=Math.floor(date.getTime()/ 1000);
    //加密后缀,将originquantum+文件路径+utc时间用md5加密
    var encode=$.md5("originquantum/360p/"+dataValue+date)+"&qubit="+date;
    path="http://fast.qpanda.cn/360p/"+dataValue+"?video="+encode;
    //学术报告视频特殊地址处理
    var  num = $('li.active').attr('data-classify');
    var num2 = $('.OptionList a.active').attr('data-classify');
    var num3 =  $('.vidlisUser>li.active').index()
    if(num == '6' || num2 == '6' || (num3+1) ==31){
        path='http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4?video='+encode;
        specialPath = path;
    }

    //if(isWeiXin()){}else {}
    (function() {
        if(/s=noRedirect/i.test(location.search)) return;
        if(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
            try {
                if(/Android|Windows Phone|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
                    $("body").append(appHmtl2(path));
                    $("body").find("#box-close").on("click",function () {
                        $("body").find("#my_video_1_html5_api").get(0).pause();
                        $("#videoplayer_overlay").remove()
                    })
                } else if(/iPad/i.test(navigator.userAgent)) {}
            } catch(e) {}
        }else {
            $("body").append(appHmtl(path));
            getTools();
        }
    })();

    videoSetTime=setInterval(function () {
        if($("body").find("#my_video_1_html5_api").get(0).paused){
            $("body").find("#my_video_1_html5_api").get(0).play();
        }else {
            clearInterval(videoSetTime)
        }
    },1000)
}

$("body").on("mouseenter",".vidlisUser li",function () {
    if(isWeiXin()){
        videoPlay ($(this));
    }else {
        $(this).addClass("active").siblings().removeClass("active")
    }
})
$("body").on("mouseleave",".vidlisUser li",function () {
    $(this).removeClass("active");
})
function Cloud(options){}
Cloud.prototype = {
    init: function () {
        var _this=this;
        //初始化svg操作板
        _this.changeCode();
        //第一个按钮点击
        $(".pointTag1").on("click",function () {
            _this.clearStyle ();
            $(".pointTag10").show();
            $("rect[qi='1'][qs='3']").click()
            setTimeout(function () {
                _this.guideLocation(90,0,-60,"auto","auto",-50, 13 ,-48 ,8 ,'.LayerContent');
            },200)
        })
        //第二个按钮点击
        $(".pointTag2").on("click",function () {
           _this.clearStyle ()
            $(".LayerContent").css({"z-index":"auto"});
            $("rect[qi='0'][qs='1']").click();

            setTimeout(function () {
                $("#LayerContent").show();
                _this.guideLocation(-10,50,0,0,0,0, 13 ,-48 ,11 ,'.step11');
            },200)
        })
        //第三个按钮点击
        $(".pointTag4").on("click",function () {
            _this.clearStyle ()
            $(".LayerContent").css({"z-index":"auto"})
            $(".step11").attr("style","");
            $("rect[qi='0'][qs='2']").click();
            setTimeout(function () {
                $("#LayerContent").show();
                _this.guideLocation(-10,50,0,0,0,0, 13 ,-48 ,14 ,'.step13');
            },200)
        })

        $(".pointTag5").on("click",function () {
            _this.clearStyle ()
            $(".step13").attr("style","");
            $("rect[qi='2'][qs='2']").click();
            setTimeout(function () {
                _this.guideLocation(25,50,0,0,0,0, 13 ,-48 ,16 ,'.pointTag6');
            },200)
        })

        $(".pointTag7").on("click",function () {
            _this.clearStyle ()
            $(".step13").attr("style","");
            $(".LayerContent").css({"z-index":"auto"})
            $("rect[qi='0'][qs='3']").click();
            setTimeout(function () {
                $("#LayerContent").show();
                _this.guideLocation(-20,60,0,0,0,0, 13 ,-48 ,18 ,'.step18');
            },200)
        })
        $(".pointTag8").on("click",function () {
            _this.clearStyle ()
            $(".step13").attr("style","");
            $(".LayerContent").css({"z-index":"auto"})
            $("rect[qi='1'][qs='3']").click();
            setTimeout(function () {
                $("#LayerContent").show();
                _this.guideLocation(-20,60,0,0,0,0, 13 ,-48 ,21 ,'.step19');
            },200)
        })


        //隐藏新手引导
        $(".guide_close_box a").on("click",function () {
            $(".simulate_box>div").attr("style","");
            $(".guideContent>div").attr("style","");
            $(".NewConBtnBox>div").attr("style","");
            $(".LayerContent").attr("style","");
            $(".NewModule").attr("style","");
            $(".New_add").attr("style","");
            $(".guideContent").hide();
            $(".guideContentBg").hide();
            setCookie("isNext","0");
            setCookie("isTip","1");
            setCookie("isCookie","0");
            $(".modal-backdrop").removeClass("in")
            $("#analogType").attr("disabled",false)
            $("#qubitNum").attr("disabled",false)
            $("#classicalbitNum").attr("disabled",false)
            $.ajax('/QCode/updUser.json', {}, function () {}, "json")

        })

        //新手引导，判断为哪种模式
        setTimeout(function () {
            $.get('/QCode/getUserStatus.json', {}, function (data) {
                if (data.message == '0') {//新用户第一次登录时
                    _this.to_guide();
                } else if (getCookie("isCookie") == '1') {//新手引导第一段
                    _this.to_guide();
                } else if (getCookie("isCookie") == '0' && getCookie("isNext") == '1') {//新手引导第二段
                    _this.to_guide();
                }
            }, "json")
        }, 300);

        //点击×，关闭引导
        $('.close').on("click", function () {
            $(".guide_close_box a").click();
            $(".first").show();
            $(".second").hide();
            $(".there").hide();
            $(".four").hide();
        })
        //是否展示新手引导按钮
        if ($(".showone").text().toString() == " 新增 ") {$('#to_guide_btn').show()}

        $(function () {
//    待使用
            //主设计窗体切换TAB
            var $tab_li = $('.NewTab ul li');
            $tab_li.click(function () {
                var index = $tab_li.index(this);
                if (tabIndex == index) {//当前tab下 再次点击当前页面 不做操作
                    return false;
                }
                // 重置样式
                $(".LayerSetting").hide()
                //property
                $(".LaySetLine1").hide();

                //iswap
                $(".LaySetLine3").hide();
                $("#commandTip").hide();

                //classicName
                $(".LaySetLine2").hide();
                Dialog.confirm({title:Operating_instructions,message: index == 0 ? messages.Confirm_tab_tip0 : messages.Confirm_tab_tip1}).on(function (e) {
                    if (!e) {return;}
                    if (index == 1 && !checkGrammar("","")) {return;}
                    if (index == 0) {
                        var result = code2Trans();
                        if(result!=false){
                            $tab_li.eq(0).addClass('active').siblings().removeClass('active');
                            $('#NewBox .pr-box').hide();
                            $(".NewModule").show();
                            $(".NewConsole").show()
                            tabIndex = index;
                            $("#ascrail2000-hr").show();
                        }
                    } else if (index == 1) {
                        $tab_li.eq(1).addClass('active').siblings().removeClass('active');
                        $('#NewBox .pr-box').show();
                        $(".NewModule").hide();
                        $(".NewConsole").hide()
                        trans2Code();
                        tabIndex = index;
                        $("#ascrail2000-hr").hide();
                    } else {
                        if (tabIndex == 1) {
                            var result = code2Trans();
                            if(result!=false){
                                $tab_li.eq(1).addClass('active').siblings().removeClass('active');
                                $('#NewBox .pr-box').show();
                                $(".NewModule").hide();
                                $(".NewConsole").hide()
                                trans2Code();
                                tabIndex = index;
                            }
                        } else {
                            $tab_li.eq(0).addClass('active').siblings().removeClass('active');
                            $('#NewBox .pr-box').show();
                            $(".NewModule").show();
                            $(".NewConsole").show();
                            trans2Code();
                            tabIndex = index;
                        }
                    }
                    $(".modRight_center").getNiceScroll().resize();
                    count = 0;
                })
            });
            $tab_li.hover(function () {
                var index = $tab_li.index(this);
                if (tabIndex == index) {//当前tab下 再次点击当前页面 不做操作
                    return false;
                }
                $('.tab_menu').find("li").eq(index).css("background", "#59c3f0");

            }, function () {
                var index = $tab_li.index(this);
                if (tabIndex == index) {//当前tab下 再次点击当前页面 不做操作
                    return false;
                }
                $('.tab_menu').find("li").eq(index).css("background", "");
            });
        });

        $(document).keyup(function(event){
            if(event.keyCode ==13){
                if($("#myModal .first").css("display")=="block"){shows()}
                else if($("#myModal .second").css("display")=="block"){showt()}
                else  if($("#myModal .second").css("display")=="block"){saveProject();}
            }
        });

        $('#updateRepeat').on('keyup', function () {
            var v = $(this).val();
            if (v != '' && (v > 8192 || v < 1)) {$(this).val(8192);}
        });

        $('#myModa3').on('hide.bs.modal', function (e) {clearInterval(interval);});
        $('#myModa2').on('hide.bs.modal', function (e) {
            clearInterval(interval);
            if ($("#flag").val() == 1) {
                window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val();
                //window.location.reload(true);
            }
        });

        $('#closeBtn').click(function () {
            if (fromAdmin != undefined && fromAdmin == "1") {
                prompt(messages.unauthorized_operation);
                return false;
            }
            $('#myModa3').hide();
            window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val() + "&versionId=" + $("#versionId").val();
        });
        $('#qubitNum').on('keyup', function () {
            var type = $("#typeId").val();
            var v = $(this).val();
            var analogType = $("#analogType").val();
            if (type == 1) {
                if (analogType == "1") {
                    if(userLevel=="3"){
                        if (v != '' && (v > 42 || v < 1)) {
                            $(this).val(42);
                        }
                    }else if(userLevel=="2"){
                        if (v != '' && (v > 32 || v < 1)) {
                            $(this).val(32);
                        }
                    }else{
                        if (v != '' && (v > 20 || v < 1)) {
                            $(this).val(20);
                        }
                    }

                }else if(analogType == "0"){
                    if (v != '' && (v > 20 || v < 1)) {
                        $(this).val(20);
                    }
                }else {
                    if(userLevel=="3"){
                        if (v != '' && (v > 42 || v < 1)) {
                            $(this).val(42);
                        }
                    }else if(userLevel=="2"){
                        if (v != '' && (v > 32 || v < 1)) {
                            $(this).val(32);
                        }

                    }else{
                        if (v != '' && (v > 20 || v < 1)) {
                            $(this).val(20);
                        }
                    }
                }
            }
            if (type == 2) {
                if (v != '' && (v > 6 || v < 1)) {
                    $(this).val(6);
                }
            }
        });
        $('#classicalbitNum').on('keyup', function () {
            var v = $(this).val();
            if (v != '' && (v > 255 || v < 1)) {$(this).val(255);}
        });
        $("#qubitNum").blur(function () {
            var type = $("#typeId").val();
            var v = $(this).val();
            var analogType = $("#analogType").val();
            if (type == 1) {
                if(userLevel=="3"){
                    if (analogType == "1") {
                        if (v != '' && (v > 42 || v < 1)) {$(this).val(42);}
                    } else {
                        if (v != '' && (v > 20 || v < 1)) {$(this).val(20);}
                    }
                }else if(userLevel=="2"){
                    if (analogType == "1") {
                        if (v != '' && (v > 32 || v < 1)) {$(this).val(32);}
                    } else {
                        if (v != '' && (v > 20 || v < 1)) {$(this).val(20);}
                    }
                }else{
                    if (v != '' && (v > 20 || v < 1)) {$(this).val(20);}
                }


            }
            if (type == 2) {
                if (v != '' && (v > 6 || v < 1)) {$(this).val(6);}
            }
        });
        $("#classicalbitNum").blur(function () {
            var v = $(this).val();
            if (v != '' && (v > 255 || v < 1)) {$(this).val(255);}
        });

        //英文状态下边距缩小
        if (lan == 'en_US') {//中文
            $(".case-list dl").css({"padding": "0 16px"})
            $(".admin").css({"width": "128px"})
        }
        //    显示提示框
        var hoveTime =null;
        $(".Layer_Con .Layer_sort_con .sort_con_list ul li").hover(function (index) {
            var _tipsHtml="";
            var TpisName=$(this).find(".sort_tip_name").text();
            var TpisContent=$(this).find(".sort_tip_hw").html();
            _tipsHtml='<div class="LayerPublicAlert"><div class="tipTitle">'+TpisName+'</div><p style="display:block;">'+TpisContent+'</p></div>';
            $(this).append(_tipsHtml);
            var $this=$(this);
//        MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
            hoveTime=setTimeout(function () {
                var leftNum=-$(".LayerPublicAlert").width()/2+"px";
                $this.find(".LayerPublicAlert").css({"margin-left":leftNum});
                $(".LayerPublicAlert").show();
            },200)
        },function () {
            clearTimeout(hoveTime);
            $(this).find(".LayerPublicAlert").remove();
        })
        //    隐藏悬浮框
        $(".LayerClose").on("click",function () {$(".LayerContent").hide();})
        var w = document.getElementById("modRight_center");
        w.onscroll=function(e) {
            // 重置样式
            $(".LayerSetting").hide()
            //property
            $(".LaySetLine1").hide();
            //iswap
            $(".LaySetLine3").hide();
            $("#commandTip").hide();
            //classicName
            $(".LaySetLine2").hide();
            $(".modRight_top").css({"margin-left":-w.scrollLeft});
            $(".modLeft_l ul").css({"margin-top":-w.scrollTop});
        }
    },
    //获取项目的参数，渲染到虚拟机
    changeCode : function () {
        var code = $("#code").val();
        if (code) {
            code = code.replace("CREG " + classicalbitNum, "");
            code = code.replace("QINIT " + qubitNum, "");
            code2Trans(code);
        } else {svgBoard(qubitNum, 100, classicalbitNum, '$');}
    },
    // <#--新手引导开始-->
    guideLocation : function (top , left , pointTop , pointLeft ,pointBottom , pointRight, tagTop ,tagLeft , stepNumber ,$className) {
        if(getCookie("isTip")!=0&&getCookie("isTip")==1||getCookie("isTip")==null&&getCookie("isTip")==null){return false;}
        $($className).show()
        $(".guideContent").show();
        $(".guideContentBg").show();
        if(stepNumber=="7"||stepNumber=="10"||stepNumber=="12"||stepNumber=="13"||stepNumber=="15"||stepNumber=="16"||stepNumber=="17"||stepNumber=="20"){
            var guideTop = $(".NewModuleRight")[0].offsetTop+$($className)[0].offsetTop-$(document).scrollTop()+top;
            var guideLeft =$(".NewModuleRight")[0].offsetLeft+ $($className)[0].offsetLeft-$(document).scrollLeft()+left;
            var positionName = "static";
        }else if(stepNumber=="8"||stepNumber=="19"||stepNumber=="22"){
            var guideTop = $($className)[0].offsetTop+$($className).outerHeight()+top-$(document).scrollTop();
            var guideLeft = $($className)[0].offsetLeft+$($className).outerWidth()/4+left-$(document).scrollLeft();
            if(stepNumber=="19"||stepNumber=="22"){guideLeft =$(".LayerSetting").offset().left+$($className).outerWidth()+left;}
            var positionName = "absolute";
            $($className).css({"z-index":"1062"});
        }else if(stepNumber=="2"||stepNumber=="3"||stepNumber=="4"||stepNumber=="24"){
            var guideTop = $($className).offset().top+($($className).outerHeight()+top)-$(document).scrollTop();
            var guideLeft = $($className).offset().left+($($className).outerWidth()/2+left)-$(document).scrollLeft();
            var positionName = "absolute";
            $($className).css({"position":"relative","z-index":"1062"});
        }else if(stepNumber=="6"||stepNumber=="9"||stepNumber=="11"||stepNumber=="14"||stepNumber=="18"||stepNumber=="21"){
            var guideTop = $($className).offset().top+($($className).outerHeight()+top)-$(document).scrollTop();
            var guideLeft = $($className).offset().left+($($className).outerWidth()/4+left)-$(document).scrollLeft();
            if(stepNumber=="11"||stepNumber=="14"||stepNumber=="18"||stepNumber=="21"){var positionName = "static";}else {var positionName = "absolute";}
            $($className).css({"position":"relative","z-index":"1062","background":"#fff"});
        }else {
            var guideTop = $($className).offset().top-$(document).scrollTop()-($(".guideId"+stepNumber+"").outerHeight()+top);
            var guideLeft = $($className).offset().left-$(document).scrollLeft()-($(".guideId"+stepNumber+"").outerWidth()+left);
            var positionName = "absolute";
            $($className).css({"position":"relative","z-index":"1062"});
        }
        // if(stepNumber==6||stepNumber==7){
        if($(document).width()<1400&&stepNumber==24||$(document).width()<1400&&stepNumber==2||$(document).width()<1400&&stepNumber==3||$(document).width()<1400&&stepNumber==4){
            $(".guideContent").css({"top":guideTop+$(document).scrollTop()-$($className).outerHeight()*0.2, "left":guideLeft*0.8, "display":"block", "position":"absolute"});
            $(".guideId"+stepNumber+"").css({"display":"block"});
        }else {
            $(".guideContent").css({"top":guideTop+$(document).scrollTop(), "left":guideLeft, "display":"block", "position":"absolute"});
            $(".guideId"+stepNumber+"").css({"display":"block"});
        }
        var stepNumberScroll=stepNumber;
        $(window).scroll(function () {
            if($(".guideId"+stepNumber+"").css("display")!="block"){
                return false;
            }
            if(stepNumberScroll==2||stepNumberScroll==3||stepNumberScroll==4||stepNumberScroll==24){
                if($(document).width()<1400){
                    $(".guideContent").css({"top":guideTop+$(document).scrollTop()-$($className).outerHeight()*0.2, "left":guideLeft*0.8, "display":"block", "position":"absolute"});
                }else {
                    $(".guideContent").css({"top":guideTop+$(document).scrollTop(), "left":guideLeft, "display":"block", "position":"absolute"});
                }
            }
        })

        $(".guideId"+stepNumber+" .pointTo").css({"top":pointTop, "left":pointLeft, "bottom":pointBottom, "right":pointRight, "position":positionName, "display":"block"});
        $(".guideId"+stepNumber+" .pointTag").css({"top":tagTop, "left":tagLeft, "position":"relative"});
    },
    nextStep : function (Num) {
        var _this=this;
        if(Num==9){
            $("#LayerContent").show();
        }
        if(Num == 0){_this.guideLocation(70,50, "auto","auto",-60,-88, 13 ,-48 ,1 ,'.New_add');}
        else if(Num == 2) {$(".New_add").click();}
        else if(Num == 3) {shows();}
        else if(Num == 4) {showt();}
        else if(Num == 5) {if(isOldUser=='2') {_this.visitorSaveProject();}else{_this.saveProject()}}
        else if(Num == 7) {
            _this.clearStyle ();
            setTimeout(function () {_this.guideLocation(30,60, 0,0, 0,0, 13 ,-48 ,7 ,'.pointTag1');},300)
        }else if(Num == 9) {
            $(".pointTag10").show();
            $(".guideId8").attr("style","");
            $(".LayerContent").css({"z-index":"auto"});
            _this.guideLocation(90,60, -60,"auto","auto",-50, 13 ,-48 ,9 ,'.Layer_Con');
        }
        else if(Num == 10) {
            _this.clearStyle ();
            $(".Layer_Con").attr("style","");
            _this.guideLocation(30,60, 0,0, 0,0, 13 ,-48,10,'.pointTag2');
        }
        else if(Num == 13) {
            _this.clearStyle ();
            _this.guideLocation(30,60, 0,0, 0,0, 13 ,-48,13,'.pointTag4');
        }
        else if(Num == 17) {
            _this.clearStyle ();
            $(".LayerContent").css("z-index","auto");
            _this.guideLocation(30,60, 0,0, 0,0, 13 ,-48,17,'.pointTag7');
        }
        else if(Num == 20) {
            _this.clearStyle ();
            $(".LayerContent").css("z-index","auto");
            _this.guideLocation(30,60, 0,0, 0,0, 13 ,-48,20,'.pointTag8');
        }
        else if(Num == 23) {_this.clearStyle ();_this.guideLocation(70,50, "auto","auto",-60,-88, 13 ,-48,23 ,'.New_edit');}
        else if(Num == 24) {$(".New_edit").click();}
        else if(Num ==25) {_this.updateProject();}
    },
    clearStyle : function  () {
        $(".pointTag10").hide();
        $(".simulate_box>div").attr("style","");
        $(".guideContent>div").attr("style","");
        $(".NewConBtnBox>div").attr("style","");
        $(".LayerContent").attr("style","");
        $(".LayerSetting").attr("style","");
        $(".NewModule").attr("style","");
        $("#analogType").attr("disabled",false)
        $("#qubitNum").attr("disabled",false)
        $("#classicalbitNum").attr("disabled",false)
    },
    //新手引导按钮
    to_guide_btn : function () {
        setCookie("isCookie", "1");//
        setCookie("isNext", "0");//防止不执行第一段，直接执行第二段
        window.location.reload();
    },
    //isTip:是否关闭引导   isTip=1;引导关闭
    //isNext:是否进入下一阶段引导引导   isNext=1;进入下一阶段引导
    //isCookie:点击进入新手引导   isCookie=0;新手引导关闭
    to_guide : function () {
        var _this = this;
        setCookie("isTip", 0);//引导开启
        $("#ascrail2000-hr").hide();
        if (getCookie('isNext') == 1 || getCookie("isCookie") == 1 && getCookie('isNext') == 1) {// 第二段
            $(".pointTag9").show();
            _this.guideLocation(20,60, -20,"auto","auto",-50, 13 ,-48 ,6 ,'.NewModule');
        } else {//第一段
            _this.guideLocation(70,50, "auto","auto",-60,-88, 13 ,-48 ,1 ,'.New_add');
        }
    },
    //运行代码
    running:function () {
        var _this=this;
        var repeat = $('#updateRepeat').val();
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (canRun()) {
            _this.random();
            var code = trans2Code();
            var code2 = "[";
            if (analogType == 2) {
                code2 += transCode();
                code2 += "]";
            } else {
                var code = trans2Code();
                code = "CREG " + classicalbitNum + "\r\n" + code;
                code = "QINIT " + qubitNum + "\r\n" + code;
            }
            if (parseInt(trans2CodeStatus) == 0) {
                errorMsg(messages.init_waiting);
                return false;
            }
            $('#myModa3').modal('show');
            setTimeout(function () {
                $("#closeBtn").attr("style", "display:block;")
            }, 30000);
            $("#taskResult").empty();

            var svgXml = getSvgXml();
            var projectId = $("#projectId").val();
            var versionId = $("#versionId").val();
            $("#flag").val(1);
            var param = {};
            param.code2 = code2;
            param.code = code;
            param.svgXml = svgXml;
            param.versionId = versionId;
            param.projectId = projectId;
            //获取测量门数组
            var meaarr = new Array();
            $("#svgBoard rect[type='Measure']").each(function () {
                meaarr[meaarr.length] = $(this).attr("qi");
            });
            param.meaarr = meaarr.join(",");
            $(".NewConBtnBox button").attr("disabled","disabled");
            $.ajax({
                url: base+"/QCode/running.json",
                data: param,
                cache: false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                type: 'post',
                success: function (result) {
                    if (result.code == 401) {
                        window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                        return false;
                    }
                    if (result.success) {
                        var obj = result.obj;
                        //任务状态
                        var status = obj.status;
                        //任务id
                        var taskId = obj.taskId;
                        var alreadyShow = false;
                        if (status == '3') {
                            if (alreadyShow) {return;}
                            alreadyShow = true;
                            setTimeout(function () {
                                $('#myModa3').modal('hide');
                                $('#myModa2').modal('show');
                                var ans = JSON.parse(obj.ans);
                                var keyArray = ans.key;
                                var valueArray = ans.value;
                                setTimeout(function () {
                                    //加载图表
                                    var myChart = CloudCLD.makeChart("taskResult");
                                    //参数设置
                                    var option;
                                    if (keyArray.ansLength > 30) {
                                        option = {
                                            color: ['#3398DB'],
                                            tooltip: {
                                                trigger: 'axis',
                                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                                }
                                            },
                                            grid: {
                                                left: '3%',
                                                right: '4%',
                                                bottom: '10%',
                                                containLabel: true
                                            },
                                            xAxis: [{
                                                type: 'category',
                                                data: keyArray,
                                                name: messages.celiangzhi,
                                                nameLocation: "middle",
                                                nameGap: 35,
                                                axisTick: {
                                                    alignWithLabel: true
                                                }
                                            }],
                                            dataZoom: [
                                                {
                                                    show: true,
                                                    startValue: 0,
                                                    endValue: 30
                                                }
                                            ],
                                            yAxis: [{
                                                type: 'value',
                                                name: messages.gailv
                                            }],
                                            series: [{
                                                name: messages.gailv,
                                                type: 'bar',
                                                barWidth: '30',
                                                data: valueArray
                                            }]
                                        };
                                    } else {
                                        option = {
                                            color: ['#3398DB'],
                                            tooltip: {
                                                trigger: 'axis',
                                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                                }
                                            },
                                            grid: {
                                                left: '3%',
                                                right: '4%',
                                                bottom: '10%',
                                                containLabel: true
                                            },
                                            xAxis: [{
                                                type: 'category',
                                                data: keyArray,
                                                name: messages.celiangzhi,
                                                nameLocation: "middle",
                                                nameGap: 35,
                                                axisTick: {
                                                    alignWithLabel: true
                                                }
                                            }],
                                            dataZoom: [
                                                {
                                                    show: true,
                                                    start: 0,
                                                    end: 100
                                                }
                                            ],
                                            yAxis: [{
                                                type: 'value',
                                                name: messages.gailv
                                            }],
                                            series: [{
                                                name: messages.gailv,
                                                type: 'bar',
                                                barWidth: '30',
                                                data: valueArray
                                            }]
                                        };
                                    }
                                    myChart.setOption(option);
                                    $("#startTime").html(messages.zhixingshijian + "：" + obj.startTime);
                                    $("#endTime").html(messages.end_time + "：" + obj.endTime);
                                }, 1000);
                            }, 3000);
                        } else if (status == '4') {
                            var n = noty({
                                text: messages.task_status_syntactic_error,
                                type: 'error',
                                dismissQueue: true,
                                layout: 'topCenter',
                                theme: 'relax',
                                timeout: 1000,
                                callback: {     // 设置回调函数
                                    afterClose: function () {
                                        window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val() + "&versionId=" + $("#versionId").val();
                                    }
                                }
                            });
                        } else {
                            //5秒查询一次任务状态
                            interval = setInterval(function () {
                                var paramAns = {};
                                paramAns.taskId = taskId;
                                $.ajax({
                                    url: base+"/QCode/getTaskRate.json",
                                    data: paramAns,
                                    cache: false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                                    type: 'post',
                                    success: function (result) {
                                        if (result.code == 401) {
                                            window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                                            return false;
                                        }
                                        if (result.success) {
                                            var task = result.obj;
                                            var status = task.status;
                                            if (status == '3') {
                                                if (alreadyShow) {
                                                    return;
                                                }
                                                alreadyShow = true;
                                                $('#myModa3').modal('hide');
                                                $('#myModa2').modal('show');
                                                var ans = JSON.parse(task.ans);
                                                var keyArray = ans.key;
                                                var valueArray = ans.value;
                                                setTimeout(function () {
                                                    //加载图表
                                                    var myChart = CloudCLD.makeChart("taskResult");
                                                    //参数设置
                                                    var option;
                                                    if (keyArray.ansLength > 30) {
                                                        option = {
                                                            color: ['#3398DB'],
                                                            tooltip: {
                                                                trigger: 'axis',
                                                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                                                }
                                                            },
                                                            grid: {
                                                                left: '3%',
                                                                right: '4%',
                                                                bottom: '10%',
                                                                containLabel: true
                                                            },
                                                            xAxis: [{
                                                                type: 'category',
                                                                data: keyArray,
                                                                name: messages.celiangzhi,
                                                                nameLocation: "middle",
                                                                nameGap: 35,
                                                                axisTick: {
                                                                    alignWithLabel: true
                                                                }
                                                            }],
                                                            dataZoom: [
                                                                {
                                                                    show: true,
                                                                    startValue: 0,
                                                                    endValue: 30
                                                                }
                                                            ],
                                                            yAxis: [{
                                                                type: 'value',
                                                                name: messages.gailv
                                                            }],
                                                            series: [{
                                                                name: messages.gailv,
                                                                type: 'bar',
                                                                barWidth: '30',
                                                                data: valueArray
                                                            }]
                                                        };
                                                    } else {
                                                        option = {
                                                            color: ['#3398DB'],
                                                            tooltip: {
                                                                trigger: 'axis',
                                                                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                                                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                                                }
                                                            },
                                                            grid: {
                                                                left: '3%',
                                                                right: '4%',
                                                                bottom: '10%',
                                                                containLabel: true
                                                            },
                                                            xAxis: [{
                                                                type: 'category',
                                                                data: keyArray,
                                                                name: messages.celiangzhi,
                                                                nameLocation: "middle",
                                                                nameGap: 35,
                                                                axisTick: {
                                                                    alignWithLabel: true
                                                                }
                                                            }],
                                                            dataZoom: [
                                                                {
                                                                    show: true,
                                                                    start: 0,
                                                                    end: 100
                                                                }
                                                            ],
                                                            yAxis: [{
                                                                type: 'value',
                                                                name: messages.gailv
                                                            }],
                                                            series: [{
                                                                name: messages.gailv,
                                                                type: 'bar',
                                                                barWidth: '30',
                                                                data: valueArray
                                                            }]
                                                        };
                                                    }
                                                    myChart.setOption(option);
                                                    $("#startTime").html(messages.zhixingshijian + "：" + task.startTime);
                                                    $("#endTime").html(messages.end_time + "：" + task.endTime);
                                                    clearInterval(interval);
                                                }, 1000);
                                            } else if (status == '4') {
                                                var n = noty({
                                                    text: messages.task_status_syntactic_error,
                                                    type: 'error',
                                                    dismissQueue: true,
                                                    layout: 'topCenter',
                                                    theme: 'relax',
                                                    timeout: 1000,
                                                    callback: {     // 设置回调函数
                                                        afterClose: function () {
                                                            window.location.href = base+"/QCode/index.html?projectId=" + $("#projectId").val() + "&versionId=" + $("#versionId").val();
                                                        }
                                                    }
                                                });
                                            }
                                        } else {
                                            errorMsg(result.message);
                                            clearInterval(interval);
                                            $("#closeBtn").attr("style", "display:block;")
                                        }
                                    },
                                    error: function () {
                                        errorMsg(messages.server_is_busy);
                                    }
                                });

                            }, 5000);
                        }

                    } else {
                        $('#myModa3').modal('hide');
                        $(".NewConBtnBox button").attr("disabled",false)
                        errorMsg(result.message);

                    }
                },
                error: function () {
                    $(".NewConBtnBox button").attr("disabled",false)
                    errorMsg(messages.server_is_busy);

                }
            });
        }
        $(".guide_close_box a").click();
        $(".New_run").attr("style","")
        setCookie("isNext","0");
        setCookie("isTip","1");
        setCookie("isCookie","0");
        $.ajax('/QCode/updUser.json', {}, function () {}, "json")
    },
    visitorRunning : function () {
        var param = {};
        var code = trans2Code();
        code = "CREG " + classicalbitNum + "\r\n" + code;
        code = "QINIT " + qubitNum + "\r\n" + code;

        var svgXml = getSvgXml();
        $("#flag").val(1);
        var param = {};
        param.code = code;
        param.svgXml = svgXml;
        //获取测量门数组
        var meaarr = new Array();
        $("#svgBoard rect[type='Measure']").each(function () {
            meaarr[meaarr.length] = $(this).attr("qi");
        });
        param.meaarr = meaarr.join(",");
        $.ajax({
            url: base+"/QCode/visitorRunning.json",
            data: param,
            cache: false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    // window.location.href = base+"/login.html";
                    saveProject()
                } else {
                    $('#myModa3').modal('hide');
                    errorMsg(result.message);
                }
            },
            error: function () {//errorMsg(messages.server_is_busy);
            }
        });
    },
    makeChart : function (name) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        var main = document.getElementById(name);
        var div = document.createElement('div');
        var width = document.body.clientWidth;
        div.style.cssText = width + 'px; height:400px';
        if ($("#" + name + ":has(div)").length < 2) {
            $("#" + name + "").html("");
            main.appendChild(div);
        }
        return echarts.init(div);
    },
    //code有改动保存为项目新版本
    saveProjectVersion : function () {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }

        if (!isLogin()) {return false;};
        if (!isCase()) {return false;};
        if (!isSemi()) {return false;};
        var param = {};
        //param.projectId = $(projectId!);
        param.code = $("#code").val();
        //表单提交
        $.ajax({
            url: base+"/QCode/saveProjectVersion.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.new_version,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1000,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                window.location.reload(true);
                            }
                        }
                    });

                } else {errorMsg(result.message);}
            },
            error: function () {errorMsg(messages.server_is_busy);}
        });
    },
    //新增项目 新增时长
    saveProject : function () {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }

        if (!isLogin()) {return false;}
        var param = {};
        var name = $("#projectName").val();
        var semi = $("#semi").val();
        var type = $("#typeId").val();
        var desc = $("#desc").val();
        var analogType = $("#analogType").val();
        var qubitNum;
        var classicalbitNum;
        if (type == 3) {
            qubitNum = 2;
            classicalbitNum = 6;
        } else {
            qubitNum = $("#qubitNum").val();
            classicalbitNum = $("#classicalbitNum").val();
        }
        if (name == '') {
            errorMsg(messages.project_name_not_null);
            return false;
        }
        if (qubitNum == '') {
            errorMsg(messages.liangzishu_not_null);
            return false;
        }
        if (classicalbitNum == '') {
            errorMsg(messages.biteshu_not_null);
            return false;
        }

        param.name = name;
        param.semi = semi;
        param.desc = desc;
        param.taskTypeId = type;
        param.qubitNum = qubitNum;
        param.classicalbitNum = classicalbitNum;
        param.analogType = analogType;

        //表单提交
        $.ajax({
            url: base+"/QCode/saveProject.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.create_success,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1000,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                $(".clear input").val("");
                                if (getCookie("isTip") != 1 && getCookie("isTip") != null) {
                                    setCookie("isNext", "1");
                                }
                                window.location.href = base+"/QCode/index.html";
                            }
                        }
                    });
                } else {
                    errorMsg(result.message);
                    showsf();
                }
            },
            error: function () {errorMsg(messages.server_is_busy);}
        });
    },
    // 游客新增项目
    visitorSaveProject : function () {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }

        var param = {};
        var name = $("#projectName").val();
        var semi = $("#semi").val();
        var type = $("#typeId").val();
        var desc = $("#desc").val();
        var analogType = $("#analogType").val();
        var qubitNum;
        var classicalbitNum;
        if (type == 3) {
            qubitNum = 2;
            classicalbitNum = 6;
        } else {
            qubitNum = $("#qubitNum").val();
            classicalbitNum = $("#classicalbitNum").val();
        }
        if (name == '') {
            errorMsg(messages.project_name_not_null);
            return false;
        }
        if (qubitNum == '') {
            errorMsg(messages.liangzishu_not_null);
            return false;
        }
        if (classicalbitNum == '') {
            errorMsg(messages.biteshu_not_null);
            return false;
        }

        param.name = name;
        param.semi = semi;
        param.desc = desc;
        param.taskTypeId = type;
        param.qubitNum = qubitNum;
        param.classicalbitNum = classicalbitNum;
        param.analogType = analogType;

        //表单提交
        $.ajax({
            url: base+"/QCode/visitorSaveProject.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.create_success,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1000,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                $(".clear input").val("");
                                if (getCookie("isTip") != 1 && getCookie("isTip") != null) {
                                    setCookie("isNext", "1");
                                }
                                window.location.href = base+"/QCode/index.html";
                            }
                        }
                    });
                } else {
                    errorMsg(result.message);
                    showsf();
                }
            },
            error: function () {errorMsg(messages.server_is_busy);}
        });
    },
    //展示运行结果数据
    showData : function (taskId) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }

        $("#taskResult").empty();
        $('#myModa2').modal('show');
        var param = {};
        param.id = taskId;
        $.ajax({
            url: base+"/QCode/getTaskData.json",
            data: param,
            cache: false, //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var task = result.obj;
                    var ans = JSON.parse(task.ans);
                    var keyArray = ans.key;
                    var valueArray = ans.value;
                    setTimeout(function () {
                        //加载图表
                        var myChart = CloudCLD.makeChart("taskResult");
                        //参数设置
                        var option;
                        if (keyArray.ansLength > 30) {
                            option = {
                                color: ['#3398DB'],
                                tooltip: {
                                    trigger: 'axis',
                                    axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                    }
                                },
                                grid: {
                                    left: '3%',
                                    right: '4%',
                                    bottom: '10%',
                                    containLabel: true
                                },
                                xAxis: [{
                                    type: 'category',
                                    data: keyArray,
                                    name: messages.celiangzhi,
                                    nameLocation: "middle",
                                    nameGap: 35,
                                    axisTick: {
                                        alignWithLabel: true
                                    }
                                }],
                                dataZoom: [
                                    {
                                        show: true,
                                        startValue: 0,
                                        endValue: 30
                                    }
                                ],
                                yAxis: [{
                                    type: 'value',
                                    name: messages.gailv
                                }],
                                series: [{
                                    name: messages.gailv,
                                    type: 'bar',
                                    barWidth: '30',
                                    data: valueArray
                                }]
                            };
                        } else {
                            option = {
                                color: ['#3398DB'],
                                tooltip: {
                                    trigger: 'axis',
                                    axisPointer: { // 坐标轴指示器，坐标轴触发有效
                                        type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                                    }
                                },
                                grid: {
                                    left: '3%',
                                    right: '4%',
                                    bottom: '10%',
                                    containLabel: true
                                },
                                xAxis: [{
                                    type: 'category',
                                    data: keyArray,
                                    name: messages.celiangzhi,
                                    nameLocation: "middle",
                                    nameGap: 35,
                                    axisTick: {
                                        alignWithLabel: true
                                    }
                                }],
                                dataZoom: [
                                    {
                                        show: true,
                                        start: 0,
                                        end: 100
                                    }
                                ],
                                yAxis: [{
                                    type: 'value',
                                    name: messages.gailv
                                }],
                                series: [{
                                    name: messages.gailv,
                                    type: 'bar',
                                    barWidth: '30',
                                    data: valueArray
                                }]
                            };
                        }
                        myChart.setOption(option);
                        $("#startTime").html(messages.zhixingshijian + "：" + task.startTime);
                        $("#endTime").html(messages.end_time + "：" + task.endTime);
                    }, 1000);

                } else {
                    errorMsg(result.message);
                }
            },
            error: function () {
                errorMsg(messages.server_is_busy);
            }
        });
    },
    //打开项目保存弹出窗
    openSave : function () {
        var _this=this;
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        $('#myModa4').modal('show');
        setTimeout(function () {
            $(".New_edit").attr("style","")
            $(".guideId23").attr("style","")
            setTimeout(function () {_this.guideLocation(40,-175, -30,"auto","auto",-75, 13 ,-48 ,24 ,'.vectoring22');},300)
        }, 300)
    },
    //更新项目
    updateProject : function () {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        if (!isCase()) {return false;}
        if (!isSemi()) {return false;}
        var param = {};
        var _this = this;
        var projectId = $("#projectId").val();
        var repeat = $("#updateRepeat").val();
        if (repeat == '') {
            errorMsg(messages.repert_not_null);
            return false;
        }
        var desc = $("#updateDesc").val();
        param.projectId = projectId;
        param.desc = desc;
        param.repeat = repeat;
        //表单提交
        $.ajax({
            url: base+"/QCode/updateProject.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    $("#myModa4").hide();
                    var n = noty({
                        text: messages.project_edit_success,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1000,
                        callback: {     // 设置回调函数
                            afterClose: function () {

                                $("#projectDesc").html(desc);
                            }
                        }
                    });
                } else {
                    errorMsg(result.message);
                    showsf();
                }
            },
            error: function () {
                errorMsg(messages.server_is_busy);
            }
        });
        if(getCookie("isTip")==0) {
            $(".guideId24").attr("style", "");
            setTimeout(function () {
                _this.guideLocation(70, 50, "auto", "auto", -60, -88, 13, -48, 25, '.New_run');
            }, 300)
        }
    },
    openAdd : function () {
        var _this = this;
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;}
        if (!isLogin()) {return false;};
        $('#myModal').modal('show');
        $("#vectoring1").show().siblings().hide();
        // shows()
        if(getCookie("isTip")==0){
            $(".guideId1").attr("style","");
            $(".New_add").attr("style","");
            setTimeout(function () {_this.guideLocation(75,-100, -30,"auto","auto",-50, 13 ,-48 ,2 ,'.first');}, 300)
        }
        //    e.preventDefault();
    },
    //游客创建新版本
    visitorAdd : function () {
        var _this =this;
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        $('#myModal').modal('show');
        if(getCookie("isTip")==0) {
            $(".guideId1").attr("style", "");
            $(".New_add").attr("style", "");
            setTimeout(function () {_this.guideLocation(75, -100, -30, "auto", "auto", -50, 13, -48, 2, '.first');}, 300)
        }
        //    e.preventDefault();
    },
    //获取版本
    getVersion : function (id) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        $('.loading-bg').show();
        $('.loading').show();
        //表单提交
        $.ajax({
            url: base+"/QCode/getVersion.json",
            data: {"id": id},
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var obj = result.obj;
                    setTimeout(function () {
                        flagM=0;
                        $('.loading').hide()
                        $('.loading-bg').hide()
                        $("#svgBoard").remove();
                        //$(obj.svgXml).appendTo("#qcodeSvgContainer");
                        $("#code").val(obj.code);
                        CloudCLD.changeCode();

                        var str = qcodeProjectName + "#" + (obj.createTime).substring(0, 4) + (obj.createTime).substring(5, 7) + (obj.createTime).substring(8, 10) + (obj.createTime).substring(11, 13) + (obj.createTime).substring(14, 16) + " " + obj.name;
                        $(".project-text").html(str);
                        $(".NewName").html(str);
                        $("#versionId").val(obj.id);
                        $("[focus=true]").each(function () {
                            if ($(this).attr("id")) {$(this).click();}
                        });
                        //返回页面顶部
                        $(window).scrollTop(0);
                    }, 1000);
                } else {
                    errorMsg(result.message);
                }
            },
            error: function () {errorMsg(messages.server_is_busy);}
        });
    },
    //删除版本
    delVersion : function (id) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        if (!isCase()) {return false;}
        if (!isSemi()) {return false;}
        Dialog.confirm({title:Operating_instructions,message: messages.delete_version}).on(function (e) {
            if (!e) {return;}
            //表单提交
            $.ajax({
                url: base+"/QCode/delVersion.json",
                data: {"id": id},
                cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                type: 'post',
                success: function (result) {
                    if (result.code == 401) {
                        window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                        return false;
                    }
                    if (result.success) {
                        window.location.reload(true);
                    } else {
                        errorMsg(result.message);
                    }
                },
                error: function () {errorMsg(messages.server_is_busy);}
            });
        });
    },
    //删除task
    delTask : function (id) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        if (!isCase()) {return false;}
        if (!isSemi()) {return false;}
        Dialog.confirm({title:Operating_instructions,message: messages.delete_task}).on(function (e) {
            if (!e) {return;}
            //表单提交
            $.ajax({
                url: base+"/QCode/delTask.json",
                data: {"id": id},
                cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                type: 'post',
                success: function (result) {
                    if (result.code == 401) {
                        window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                        return false;
                    }
                    if (result.success) {
                        window.location.reload(true);
                    } else {errorMsg(result.message);}
                },
                error: function () {errorMsg(messages.server_is_busy);}
            });
        });
    },
    //终止task
    terminateTask : function (id) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        if (!isLogin()) {return false;}
        if (!isCase()) {return false;}
        if (!isSemi()) {return false;}
        if (confirm(messages.terminate_task)) {
            //表单提交
            $.ajax({
                url: base+"/QCode/terminateTask.json",
                data: {"id": id},
                cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                type: 'post',
                success: function (result) {
                    if (result.code == 401) {
                        window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                        return false;
                    }
                    if (result.success) {
                        window.location.reload(true);
                    } else {
                        errorMsg(result.message);
                    }
                },
                error: function () {
                    errorMsg(messages.server_is_busy);
                }
            });
        }
    },
    //保存
    save : function () {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }

        if (!isLogin()) {return false;}
        if (!isCase()) {return false;}
        if (!isSemi()) {return false;}
        if (parseInt(tabIndex) == 1) {
            if (code2Trans() == false) {return false;}
        }
        var code = trans2Code();
        if(code==false){
            return false;
        }
        if (code == "") {
            errorMsg(messages.must_be_operated);
            return false;
        }
        code = "CREG " + classicalbitNum + "\r\n" + code;
        code = "QINIT " + qubitNum + "\r\n" + code;
        if (parseInt(trans2CodeStatus) == 0) {
            errorMsg(messages.init_waiting);
            return false;
        }
        var svgXml = getSvgXml();
        var projectId = $("#projectId").val();
        var versionId = $("#versionId").val();
        var param = {};
        param.projectId = projectId;
        param.versionId = versionId;
        param.code = code;
        param.svgXml = svgXml;
        $(".NewConBtnBox button").attr("disabled","disabled")
        //表单提交
        $.ajax({
            url: base+"/QCode/save.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.save_success,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'bootstrapTheme',
                        timeout: 1000,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                window.location.reload(true);
                            }
                        }
                    });
                } else {
                    $(".NewConBtnBox button").attr("disabled",false)
                    errorMsg(result.message);

                }
            },
            error: function () {
                $(".NewConBtnBox button").attr("disabled",false)
                errorMsg(messages.server_is_busy);

            }
        });
    },
    checkQubitNum : function (element) {//模拟类型 与 量子比特数 联动

        var analogType = $("#myModal  #analogType").val();//模拟类型
        var qubitNum = $('#myModal  #qubitNum').val();// 量子比特数
        if (analogType == 2) {
            $('#qubitNum').val(6);
            $('#classicalbitNum').val(6);
            $('#qubitNum').attr("disabled", "disabled")
            $('#classicalbitNum').attr("disabled", "disabled")
        } else {
            if($('#qubitNum').val()==''){
                // $('#qubitNum').val(6);
                // $('#classicalbitNum').val(6);
            }

            $('#qubitNum').removeAttr("disabled")

            $('#classicalbitNum').removeAttr("disabled")
        }

        if ((qubitNum > 20)) {
            if (userLevel == '1') {
                $('#qubitNum').val(20);
            }else if (userLevel == '3') {
                // qubitNum > 42 ? $('#qubitNum').val(42) : '';
                switch (analogType) {
                    case "0" : {$('#qubitNum').val(20);};break;
                    case "1" : {qubitNum > 42 ? $('#qubitNum').val(42) : '';};break;
                    default  : {};break;
                }
            } else {
                // qubitNum > 32 ? $('#qubitNum').val(32) : '';
                switch (analogType) {
                    case "0" : {$('#qubitNum').val(20);};break;
                    case "1" : {qubitNum > 32 ? $('#qubitNum').val(32) : '';};break;
                    default  : {};break;
                }
            }
        }
    },
    //获取随机数
    random : function () {
        //x上限，y下限
        var x = 3;
        var y = 1;
        var tip = messages.first_click_icon;
        var rand = parseInt(Math.random() * (x - y + 1) + y);
        if (rand == 1) {
            tip = messages.first_click_icon;
        }
        if (rand == 2) {
            tip = messages.same_pro_diff_result;
        }
        if (rand == 3) {
            tip = messages.real_liangzi;
        }
        $("#randomValue").html(tip);
    }
}

