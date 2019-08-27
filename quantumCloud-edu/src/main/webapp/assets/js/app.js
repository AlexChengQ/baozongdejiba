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


});

// function errorMsg(message){
//     var n = noty({
//         // text        : message,
//         template: '<div class="layer-custom-error"><span></span>'+message+'</div>',
//         type        : 'error',
//         dismissQueue: true,
//         layout      : 'center',
//         theme       : 'metroui',
//         timeout		: 1500000
//     });
// }
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
                        if(args.distinguish==1){
                            var start = args.current - 1
                                , end = args.current + 1;
                        }else {
                            var start = args.current - 2
                                , end = args.current + 2;
                        }

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
                    if(args.distinguish!=1){
                        if (args.current + 2 < args.pageCount - 1 && args.current >= 1 && args.pageCount > 5) {
                            obj.append('<li class="page-item"><span>...</span></li>');
                        }
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
                distinguish: 0,
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
            this.$textarea.wrap('<div class="flex-text-wrap"/>').before('<pre class="pre" style="display:none;"><span /><br /></pre>');
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
        var fullScreenTime=null;
        onFullScreenEvent(function (fullScreen) {
            clearTimeout(fullScreenTime);
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

            fullScreenTime=setTimeout(function () {
                if(!isNaN(parseInt($(".speed-box").text()))){
                    $('#my_video_1_html5_api')[0].playbackRate=parseInt($(".speed-box").text());
                }
            },500)

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
            document.msFullscreenElement;
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
        $(document).on("fullscreenchange mozfullscreenchange webkitfullscreenchange MSFullscreenChange", function (e) {
            // The full screen status is automatically
            // passed to our callback as an argument.
            callback(fullScreenStatus());
            if($(".vjs-play-control").hasClass("vjs-playing")){
                document.getElementById("my_video_1_html5_api").play();
            }
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
        '<video  id="my_video_1_html5_api" class="vjs-tech" preload="auto"  preload="" controls="" poster="" data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="'+link+'">' +
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
    // $(".video").attr("autoplay",true)
}
function appHmtl2(link) {
    var _html=' <div id="videoplayer_overlay" style="">' +
        '<div id="videoplayer_outer_container"><div id="videoplayer_container"><div id="videoplayer">' +
        '<div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto" class="video-js vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-playing vjs-user-inactive" id="my_video_1" style="width: 100%; height: 100%;">' +
        '<video  id="my_video_1_html5_api" class="vjs-tech" preload="auto"  preload="" controls="" poster="" data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="'+link+'">' +
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
        '<div class="vjs-seek-handle vjs-slider-handle" aria-live="off" style="left: 60.21%;"><span class="vjs-control-text">3:02</span></div></div></div>'+
        '<div class="vjs-fullscreen-control vjs-control " role="button" aria-live="polite" tabindex="0"><div class="vjs-control-content"><span class="vjs-control-text">Fullscreen</span></div></div>' +
        '<div style="position: relative;cursor: pointer" onmouseenter="showBOx()" onmouseleave="hideBox()"><span id="ulPx">清晰度</span><ul id="pxBox"><li id="p720" style="margin-bottom: 5px" onclick="chosePx(event)">720P</li><li id="p360" style="margin-bottom: 5px" onclick="chosePx(event)">360P</li></ul></div>'+
        '<div class="vjs-volume-control vjs-control"><div role="slider" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" tabindex="0" class="vjs-volume-bar vjs-slider" aria-label="volume level" aria-valuetext="100%"><div class="vjs-volume-level"><span class="vjs-control-text"></span></div><div class="vjs-volume-handle vjs-slider-handle"><span class="vjs-control-text"  id="timesID"></span></div></div></div><div class="vjs-mute-control vjs-control" role="button" aria-live="polite" tabindex="0"><div><span class="vjs-control-text">Mute</span></div></div><div class="vjs-playback-rate vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true"><div class="vjs-control-content"><span class="vjs-control-text">Playback Rate</span><div class="vjs-menu"><ul class="vjs-menu-content"></ul></div></div><div class="vjs-playback-rate-value">1</div></div><div class="vjs-subtitles-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Subtitles Menu"><div class="vjs-control-content"><span class="vjs-control-text">Subtitles</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">subtitles off</li></ul></div></div></div><div class="vjs-captions-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Captions Menu"><div class="vjs-control-content"><span class="vjs-control-text">Captions</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">captions off</li></ul></div></div></div><div class="vjs-chapters-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Chapters Menu"><div class="vjs-control-content"><span class="vjs-control-text">Chapters</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-title">Chapters</li></ul></div></div></div></div><div class="vjs-error-display"><div></div></div><div class="vjs-caption-settings vjs-modal-overlay vjs-hidden"><div class="vjs-tracksettings"><div class="vjs-tracksettings-colors"><div class="vjs-fg-color vjs-tracksetting"><label class="vjs-label">Foreground</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-text-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Opaque</option></select></span></div><div class="vjs-bg-color vjs-tracksetting"><label class="vjs-label">Background</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-bg-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div><div class="window-color vjs-tracksetting"><label class="vjs-label">Window</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-window-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div></div><div class="vjs-tracksettings-font"><div class="vjs-font-percent vjs-tracksetting"><label class="vjs-label">Font Size</label><select><option value="0.50">50%</option><option value="0.75">75%</option><option value="1.00" selected="">100%</option><option value="1.25">125%</option><option value="1.50">150%</option><option value="1.75">175%</option><option value="2.00">200%</option><option value="3.00">300%</option><option value="4.00">400%</option></select></div><div class="vjs-edge-style vjs-tracksetting"><label class="vjs-label">Text Edge Style</label><select><option value="none">None</option><option value="raised">Raised</option><option value="depressed">Depressed</option><option value="uniform">Uniform</option><option value="dropshadow">Dropshadow</option></select></div><div class="vjs-font-family vjs-tracksetting"><label class="vjs-label">Font Family</label><select><option value="">Default</option><option value="monospaceSerif">Monospace Serif</option><option value="proportionalSerif">Proportional Serif</option><option value="monospaceSansSerif">Monospace Sans-Serif</option><option value="proportionalSansSerif">Proportional Sans-Serif</option><option value="casual">Casual</option><option value="script">Script</option><option value="small-caps">Small Caps</option></select></div></div></div><div class="vjs-tracksettings-controls"><button class="vjs-default-button">Defaults</button><button class="vjs-done-button">Done</button></div></div><a class="icon-view-close" id="box-close" href="javascript:;">&times;</a></div></div></div></div></div>';
    return _html;
    // $(".video").attr("autoplay",true)
}
function showBox1() {
    $('.speed-list-box').show()
}
function hideBox1() {
    $('.speed-list-box').hide()
}
//切换播放速度
function choseSpeed(e){
    if($(e.target).hasClass("active")){
        return false
    }
    var target = e.target.id;
    var speedText = $('#'+target).text();
    $(e.target).addClass("active").siblings().removeClass("active")
    $('.speed-box').text(speedText)
    switch (target) {
        case 'norSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 1;
            break;
        case 'fastSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 1.5;
            break;
        case 'Speed125':
            $('#my_video_1_html5_api')[0].playbackRate = 1.25;
            break;
        case 'slowSpeed':
            $('#my_video_1_html5_api')[0].playbackRate = 2;
            break;
        default:
            $('.speed-box').text("1.0x")
            $('#my_video_1_html5_api')[0].playbackRate = 1;
    }
    // $('.speed-list-box').hide()
}

// 添加侦听时间，DOM加载完后执行。
// document.addEventListener('DOMContentLoaded', function() {
//     function audioAutoPlay() {
//         // alert("1212")
//         var bgmusic = document.getElementById('my_video_1_html5_api');
//         $("body").find("#my_video_1_html5_api").get(0).play();
//         bgmusic.play();
//         //侦听微信ready事件。
//         alert("1212")
//         document.addEventListener("WeixinJSBridgeReady", function() {
//             alert("1234")
//             $("body").find("#my_video_1_html5_api").get(0).play();
//             bgmusic.play();
//         }, false);
//     }
//     audioAutoPlay();
// });
document.addEventListener("WeixinJSBridgeReady", function() {
    // $("body").find("#my_video_1_html5_api").get(0).play();
    // bgmusic.play();
}, false);
function showBox() {
    $('#pxBox').show()
}
function hideBox() {
    $('#pxBox').hide()
}
var time = 0;
function chosePx(e) {
    if($(e.currentTarget).hasClass("active")){
        return false
    }
    var vide = document.getElementById('my_video_1_html5_api');
    dataValue=$('#my_video_1_html5_api').attr("data-link");
    var getTime =  $('#my_video_1_html5_api')[0].currentTime;

    $("body").find("#my_video_1_html5_api").get(0).pause();
    var target = e.currentTarget.id;
    var pxText = $('#'+target).text();

    $(e.currentTarget).addClass("active").siblings().removeClass("active")
    $('#ulPx').text(pxText)
    if(target == 'p360'){
        $('#ulPx').text("高清")
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
        if(path.indexOf("QOeq0yzgt0IA") != -1){
            path = "http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4";
        }
    }else{
        $('#ulPx').text("超清")
        path="http://video.qpanda.cn:65520/"+dataValue;
        if(path.indexOf("QOeq0yzgt0IA") != -1){
            path = "http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4";
        }
    }
    if(isWeiXin()){
        clearInterval(progressFlag);
        $('#my_video_1_html5_api').attr("src",path);
        document.getElementById("my_video_1_html5_api").play();
        $(this).addClass("vjs-playing")
        $("body").find(".video-js").addClass("vjs-playing")
        $(this).removeClass("vjs-paused")
    }else {
        clearInterval(progressFlag);
        $('#my_video_1_html5_api').attr("src",path);
        document.getElementById("my_video_1_html5_api").play();
        $(this).addClass("vjs-playing")
        $("body").find(".video-js").addClass("vjs-playing")
        $(this).removeClass("vjs-paused")
    }
    setTimeout(function () {
        $('#my_video_1_html5_api')[0].currentTime = getTime;
        if(!isNaN(parseInt($(".speed-box").text()))){
            $('#my_video_1_html5_api')[0].playbackRate=parseInt($(".speed-box").text());
        }
    },300)
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
var dataValue;
function videoPlay (videoPat) {
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
    if(path.indexOf("QOeq0yzgt0IA") != -1){
        path = "http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4";
    }

    if(isWeiXin()){
        $("body").append(appHmtl2(path));
        getTools();
    }else {
        $("body").append(appHmtl(path));
        getTools();
    }
    setTimeout(function () {
        $("body").find("#my_video_1_html5_api").get(0).play();
    },1000)
}
// 获取学习页目录信息
var videoData=[];
var textBox=[];
var textBoxM=[];
function getcatalog() {
    $.ajax({
        type:"post",
        cache: false,
        async: false,
        url:base+'/education/getcatalog.json',
        dataType: "json",
        success:function (data) {
            videoData=data.obj;
            videoData.forEach(function (value) {
                textBox.push(value.brief)
            })
            textBoxM= textBox
        }
    })
}
getcatalog()

// 视频列表
var vidDetails=[];
var textBoxVideo=[];//课程介绍
getVideoNameInfo()
function sortId(a,b){
    return Number(a.vid.toString().substring(1))-Number(b.vid.toString().substring(1))
}

function getVideoNameInfo() {
    $.ajax({
        type:"post",
        cache: false,
        async: false,
        url:base+'/education/videoinfo.json',
        dataType: "json",
        success:function (data) {
            for(var i = 0; i < data.obj.length; i++) {
                if(!vidDetails[data.obj[i].block]) {
                    var arr = [];
                    arr.push(data.obj[i]);
                    vidDetails[data.obj[i].block] = arr;
                }else {
                    vidDetails[data.obj[i].block].push(data.obj[i])
                    vidDetails[data.obj[i].block]=vidDetails[data.obj[i].block].sort(sortId)
                }
            }
            getCoursedescription()
        }
    })
}
//获取课程介绍
function getCoursedescription() {
    for(var i = 1; i < vidDetails.length; i++) {
        textBoxVideo.push(vidDetails[i][0].brief)
    }
}
// var textBoxM = [
//     ["• 量子计算是怎么来的 &nbsp;&nbsp;&nbsp;&nbsp;• 量子计算与经典计算的本质区别   <br> • 量子计算必备的基础知识"],
//     ['• 本源量子云平台是什么 &nbsp;&nbsp;&nbsp;&nbsp;• 量子云的设计及工作原理 <br>• 单量子、多量子比特量子语言的使用'],
//     ['• 量子编程与经典编程的差异 &nbsp;&nbsp;&nbsp;&nbsp;•量子编程语言与量子线路图 <br>• 本源量子语言及量子程序开发套件'],
//     ['• 量子计算机的整体运行及机器架构  &nbsp;&nbsp;&nbsp;&nbsp;•量子计算芯片与量子计算控制系统'],
//     ['• 最大切割问题是什么 &nbsp;&nbsp;&nbsp;&nbsp;• 泡利算符是什么&nbsp;&nbsp;&nbsp;&nbsp;•哈密顿量是什么<br>• QAOA的原理&nbsp;&nbsp;&nbsp;&nbsp;• VQNet框架的如何使用'],
//     ['• 对量子逻辑门的深层次认识 &nbsp;&nbsp;&nbsp;&nbsp;• 对量子算法的独到见解'],
//     [''],
//     ['•RSA算法原理&nbsp;&nbsp;&nbsp;•Shor算法的原理&nbsp;&nbsp;&nbsp;&nbsp;<br>•在本源虚拟机上成功实施Shor算法']
// ];
// var textBox=[
//     ["• 量子计算是怎么来的 &nbsp;&nbsp;&nbsp;&nbsp;• 量子计算与经典计算的本质区别   &nbsp;&nbsp;&nbsp;&nbsp; • 量子计算必备的基础知识"],
//     ['• 本源量子云平台是什么 &nbsp;&nbsp;&nbsp;&nbsp;• 量子云的设计及工作原理&nbsp;&nbsp;&nbsp;&nbsp;• 单量子、多量子比特量子语言的使用'],
//     ['• 量子编程与经典编程的差异 &nbsp;&nbsp;&nbsp;&nbsp;•量子编程语言与量子线路图&nbsp;&nbsp;&nbsp;&nbsp;• 本源量子语言及量子程序开发套件'],
//     ['• 量子计算机的整体运行及机器架构 &nbsp;&nbsp;&nbsp;&nbsp;•量子计算芯片与量子计算控制系统'],
//     ['• 最大切割问题是什么 &nbsp;&nbsp;&nbsp;&nbsp;• 泡利算符是什么&nbsp;&nbsp;&nbsp;&nbsp;• 哈密顿量是什么<br>• QAOA的原理&nbsp;&nbsp;&nbsp;&nbsp;• VQNet框架的如何使用'],
//     ['• 对量子逻辑门的深层次认识&nbsp;&nbsp;&nbsp;&nbsp;• 对量子算法的独到见解'],
//     [''],
//     ['•RSA算法原理&nbsp;&nbsp;&nbsp;&nbsp;•Shor算法的原理&nbsp;&nbsp;&nbsp;&nbsp;•在本源虚拟机上成功实施Shor算法']
// ];
//Mobile答题界面渲染
var dataContent='',dataContentText='';
function getAnswerHtml(data){
    dataContent='',dataContentText='';
    dataContent = data.obj.content.split("|")

    str = data.obj.questionid.toString();
    if (data.obj.content.indexOf("@@") != -1) {
        $("#question").text(data.obj.content.substring(0, data.obj.content.indexOf("@@")))
        imageAnPath = data.obj.content.substring(data.obj.content.indexOf("@@") + 2, data.obj.content.lastIndexOf("@@")) + ".png";
        dataContentText += '<li><img class="imageAnPath" src="'+base+'/assets/images/EduImg/' + imageAnPath + '" alt=""></li>'
    } else {
        $("#question").text(dataContent[0])
    }

    if(data.obj.content.indexOf("**")>-1){
        $("#question").text(data.obj.content.split("**")[0])
        dataContent=data.obj.content.split("**")[1].split("##")
    }

    $("#QOrder").html(str.substr(str.length - 1, 1));
    $("#question").attr("data-question", data.obj.questionid)
    if(data.obj.content.indexOf("**")>-1){
        for (var i = 0; i < dataContent.length; i++) {
            dataContentText += '<li >' +
                '<label class="radio_check" for="ansList' + i + '" name="ansList' + i + '">'+dataContent[i]+'</label>' +
                '</li>'
        }
    }else {
        for (var i = 1; i < dataContent.length; i++) {
            dataContentText += '<li >' +
                '<label class="radio_check" for="ansList' + i + '" name="ansList' + i + '">' + dataContent[i].replace("$$", "|") + '</label>' +
                '</li>'
        }
    }

    return dataContentText;
}
//PC答题界面渲染
function getAnswerHtmlPc(data){
    dataContent=data.obj.content.split("|");
    str=data.obj.questionid.toString();
    if(data.obj.content.indexOf("@@")!=-1){
        $("#question").text(data.obj.content.substring(0,data.obj.content.indexOf("@@")))
        imageAnPath=data.obj.content.substring(data.obj.content.indexOf("@@")+2,data.obj.content.lastIndexOf("@@"))+".png";
        dataContentText +='<li><img class="imageAnPath" src="'+base+'/assets/images/EduImg/'+imageAnPath+'" alt=""></li>'
    }else {
        $("#question").text(dataContent[0])
    }

    if(data.obj.content.indexOf("**")>-1){
        $("#question").text(data.obj.content.split("**")[0])
        dataContent=data.obj.content.split("**")[1].split("##")
    }
    // $("#question").text(dataContent[0])
    $("#QOrder").html(str.substr(str.length-1,1))
    $("#question").attr("data-question",data.obj.questionid);
    if(data.obj.content.indexOf("**")>-1){
        for(var i = 0; i<dataContent.length;i++){
            dataContentText +='<li onclick="getQuestion(this)">' +
                '<input type="radio" id="ansList'+i+'" class="answerRadio" name="ansList">' +
                '<label for="ansList'+i+'" name="ansList'+i+'">'+dataContent[i]+'</label>' +
                '</li>'
        }

    }else {
        for(var i = 1; i<dataContent.length;i++){
            dataContentText +='<li onclick="getQuestion(this)">' +
                '<input type="radio" id="ansList'+i+'" class="answerRadio" name="ansList">' +
                '<label for="ansList'+i+'" name="ansList'+i+'">'+dataContent[i].replace("$$","|")+'</label>' +
                '</li>'
        }
    }

    return dataContentText;

}
$("body").on("tap",".question-conUl li label",function (e) {
    var text = $('.answerBtn').eq(0).text();
    if(text == "再来一次" ||text == "下一题" ){
        return
    }
    $('label').removeClass('radio_checked');
    $(this).toggleClass('radio_checked');
    getQuestion($(this).parent());
    e.stopPropagation()
})

// $("body").on("tap",".question-conUl li",function (e) {
//     getQuestion($(this))
//     e.stopPropagation()
// })
var answerMessage={
    "ensure":"确定",
    "close":"关闭",
    "choose":"请选择答案",
    "next":"下一题",
    "error":"请求异常，请重试！！！",
    "TheNextChapter":"下一节",
    "reset":"再来一次",
    "noneQues":"暂无题库",
    "preQuestion":"请完成上一答题"
};
//时间格式转换
function secondToDate(result) {
    var h = Math.floor(result / 3600) < 10 ? '0'+Math.floor(result / 3600) : Math.floor(result / 3600);
    var m = Math.floor((result / 60 % 60)) < 10 ? '0' + Math.floor((result / 60 % 60)) : Math.floor((result / 60 % 60));
    var s = Math.floor((result % 60)) < 10 ? '0' + Math.floor((result % 60)) : Math.floor((result % 60));
    return result = h + ":" + m + ":" + s;
}

// 地址栏信息处理
function GetUrlRelativePath()
{
    var url = document.location.toString();
    var arrUrl = url.split("//");
    var start = arrUrl[1].indexOf("/");
    var relUrl = arrUrl[1].substring(start);//stop省略，截取从start开始到结尾的所有字符

    if(relUrl.indexOf("?") != -1){
        relUrl = relUrl.split("?")[1].split("=")[1].split("_");
    }
    return relUrl;
}

var vidHtml =''
var ishtml='';
var hashText= window.location.hash;
if(hashText==''||hashText==undefined){
    var videoMenu_data=parseInt(GetUrlRelativePath()[0])
    var videoIndex_data=parseInt(GetUrlRelativePath()[1])-1
    if(isNaN(videoMenu_data)){
        videoMenu_data=0;
        videoIndex_data=0;
    }
}else {
    var videoMenu_data=parseInt(hashText.toString().substr(1,1))
    var videoIndex_data=parseInt(hashText.toString().substr(3,1))-1
    if(isNaN(videoMenu_data)){
        videoMenu_data=0;
        videoIndex_data=0;
    }
}


//计算日期相减天数
function DateMinus(sDate){
    var sdate = new Date(sDate.replace(/-/g, "/"));
    var now = new Date();
    var days = now.getTime() - sdate.getTime();
    var day = parseInt(days / (1000 * 60 * 60 * 24));
    // var time = parseInt(days / (1000 * 60));
    // var hours = parseInt(days / (1000 * 60 * 60));
    return day;
}