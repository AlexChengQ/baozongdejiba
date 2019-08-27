<#global base=rc.contextPath/>
<#global validateJS="${rc.contextPath}${setting['validatejspath']!}"/>
<#global lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
<#macro header title="" charset="utf-8" lang="zh-CN">
<!DOCTYPE html>
<html>
<head>
    <title><#if title==""> <@spring.message code="project_name" /></title><#else>${title!}</title></#if>
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta name="renderer" content="webkit" />
    <meta charset="UTF-8">
    <meta name="keywords" content="本源溯知,本源量子,云平台,相干叠加,量子程序,量子计算应用,量子计算">
    <meta name="description" content="本源溯知是目前国内唯一一款专业的量子计算在线教育平台，它集合了本源量子不断更新的丰富的量子计算课程，方便学员随时了解、学习量子计算专业知识。">
<#--<meta name="viewport" content=" minimum-scale=1.0, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">-->
    <link rel="shortcut icon" href="${base}/assets/images/favicon.ico" />
    <link type="image/x-icon" href="${base}/assets/images/favicon.ico" rel="bookmark" />
    <link rel="stylesheet" href="${base}/assets/css/style.css">
    <link rel="stylesheet" href="${base}/assets/css/bootstrap.css">
    <link rel="stylesheet" href="${base}/assets/css/all.css?1.0">
    <link rel="stylesheet" href="${base}/assets/css/main.css">
    <script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
    <script src="${base}/assets/js/jquery.lazyload.min.js"></script>
    <#--<script src="${base}/assets/js/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>-->
    <script>
        var base="${base}";
        if (!window.location.origin) {
            window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
        }
        var shareLink=window.location.origin;
<#--判断设备-->
        (function() {
            if(/s=noRedirect/i.test(location.search)) return;
            if(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
                try {
                    if(
                            window.location.href.indexOf("index.html")>-1||
                            window.location.href.indexOf("dashboard.html")>-1||
                            window.location.href.indexOf("personal.html")>-1||
                            window.location.href.indexOf("video.html")>-1||
                            window.location.href.indexOf("EDU/appdownload.html")>-1||
                            window.location.href.indexOf("quantumLearning.html")>-1
                    ){
                        if( window.location.href.indexOf("video.html")>-1){
                            window.location.href='${base}/m/mVideo.html'
                        }else if( window.location.href.indexOf("EDU/appdownload.html")>-1){
                            window.location.href='${base}/eduMobile/appdownload.html'
                        }else {
                            window.location.href=window.location.href.replace("EDU","m")
                        }
                    }
                    if(/Android|Windows Phone|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {

                    } else if(/iPad/i.test(navigator.userAgent)) {
                        // window.location.href = "https://www.163.com/ipad/";
                    }
                } catch(e) {}
            }
        })();
        if(navigator.platform.indexOf("Mac") > -1) document.documentElement.classList.add("ua-mac");
        function shareVideoScore(sid) {
        <#if USER_INFO??>
        $.post("${base}/UpdateUserScore/addScoreByShare.json",{type:10},function () {
            getUserInfo();
        })

        $.post("${base}/UpdateUserScore/saveVideoDetail.json",{type:2,"vid":sid},function () {
        })
        </#if>

        }
    </script>
    <#nested>
</head>
</#macro>

<#macro mHeader title="" charset="utf-8" lang="zh-CN">
<!DOCTYPE html>
<html>
<head>
    <title>本源溯知</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta name="renderer" content="webkit" />
    <meta charset="UTF-8">
    <meta name="keywords" content="本源溯知,本源量子,云平台,相干叠加,量子程序,量子计算应用,量子计算">
    <meta name="description" content="本源溯知是目前国内唯一一款专业的量子计算在线教育平台，它集合了本源量子不断更新的丰富的量子计算课程，方便学员随时了解、学习量子计算专业知识。">
<#--<meta name="viewport" content=" minimum-scale=1.0, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">-->
    <link rel="shortcut icon" href="${base}/assets/images/favicon.ico" />
    <link type="image/x-icon" href="${base}/assets/images/favicon.ico" rel="bookmark" />
    <script type="text/javascript" src="${base}/assets/js/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="${base}/assets/mobile/css/main.css">
    <meta name="author" content="">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="Cache-Control" content="no-transform ">
    <meta http-equiv="Cache-Control" content="no-siteapp">
    <link rel="shortcut icon" href="http://learn-quantum.com/assets/images/favicon.ico">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
<#--界面缩放JS-->
    <script>
        ; (function (win, lib) {
            var doc = win.document;
            var docEl = doc.documentElement;
            var metaEl = doc.querySelector('meta[name="viewport"]');
            var flexibleEl = doc.querySelector('meta[name="flexible"]');
            var dpr = 0;
            var scale = 0;
            var tid;
            var flexible = lib.flexible || (lib.flexible = {});

            if (metaEl) {
               // console.warn('将根据已有的meta标签来设置缩放比例');
                var match = metaEl.getAttribute('content').match(/initial\-scale=([\d\.]+)/);
                if (match) {
                    scale = parseFloat(match[1]);
                    dpr = parseInt(1 / scale);
                }
            } else if (flexibleEl) {
                var content = flexibleEl.getAttribute('content');
                if (content) {
                    var initialDpr = content.match(/initial\-dpr=([\d\.]+)/);
                    var maximumDpr = content.match(/maximum\-dpr=([\d\.]+)/);
                    if (initialDpr) {
                        dpr = parseFloat(initialDpr[1]);
                        scale = parseFloat((1 / dpr).toFixed(2));
                    }
                    if (maximumDpr) {
                        dpr = parseFloat(maximumDpr[1]);
                        scale = parseFloat((1 / dpr).toFixed(2));
                    }
                }
            }

            if (!dpr && !scale) {
                var isAndroid = win.navigator.appVersion.match(/android/gi);
                var isIPhone = win.navigator.appVersion.match(/iphone/gi);
                var devicePixelRatio = win.devicePixelRatio;
                if (isIPhone) {
                    // iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案
                    if (devicePixelRatio >= 3 && (!dpr || dpr >= 3)) {
                        dpr = 3;
                    } else if (devicePixelRatio >= 2 && (!dpr || dpr >= 2)) {
                        dpr = 2;
                    } else {
                        dpr = 1;
                    }
                } else {
                    // 其他设备下，仍旧使用1倍的方案
                    dpr = 1;
                }
                scale = 1 / dpr;
            }

            docEl.setAttribute('data-dpr', dpr);
            if (!metaEl) {
                metaEl = doc.createElement('meta');
                metaEl.setAttribute('name', 'viewport');
                metaEl.setAttribute('content', 'initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
                if (docEl.firstElementChild) {
                    docEl.firstElementChild.appendChild(metaEl);
                } else {
                    var wrap = doc.createElement('div');
                    wrap.appendChild(metaEl);
                    doc.write(wrap.innerHTML);
                }
            }

            function refreshRem() {
                var width = docEl.getBoundingClientRect().width;
                if (width / dpr > 540) {
                    width = 540 * dpr;
                }
                var rem = width / 10;
                docEl.style.fontSize = rem + 'px';
                flexible.rem = win.rem = rem;
            }

            win.addEventListener('resize', function () {
                clearTimeout(tid);
                tid = setTimeout(refreshRem, 300);
            }, false);
            win.addEventListener('pageshow', function (e) {
                if (e.persisted) {
                    clearTimeout(tid);
                    tid = setTimeout(refreshRem, 300);
                }
            }, false);

            if (doc.readyState === 'complete') {
                doc.body.style.fontSize = 12 * dpr + 'px';
            } else {
                doc.addEventListener('DOMContentLoaded', function (e) {
                    doc.body.style.fontSize = 12 * dpr + 'px';
                }, false);
            }
            refreshRem();
            flexible.dpr = win.dpr = dpr;
            flexible.refreshRem = refreshRem;
            flexible.rem2px = function (d) {
                var val = parseFloat(d) * this.rem;
                if (typeof d === 'string' && d.match(/rem$/)) {
                    val += 'px';
                }
                return val;
            }
            flexible.px2rem = function (d) {
                var val = parseFloat(d) / this.rem;
                if (typeof d === 'string' && d.match(/px$/)) {
                    val += 'rem';
                }
                return val;
            }

        })(window, window['lib'] || (window['lib'] = {}));
    </script>
<#--<script src="${base}/assets/js/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>-->
    <script>
        var base="${base}";

        if (!window.location.origin) {
            window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
        }
        var shareLink=window.location.origin;
        <#--禁止缩放-->
        window.onload = function() {
            // 阻止双击放大
            var lastTouchEnd = 0;
            document.addEventListener('touchstart', function(event) {
                if (event.touches.length > 1) {
                    event.preventDefault();
                }
            });
            document.addEventListener('touchend', function(event) {
                var now = (new Date()).getTime();
                if (now - lastTouchEnd <= 300) {
                    event.preventDefault();
                }
                lastTouchEnd = now;
            }, false);

            // 阻止双指放大
            document.addEventListener('gesturestart', function(event) {
                event.preventDefault();
            });
        }
    </script>
    <#nested>
</head>
</#macro>
<#macro mobileTop>
<!--mobileTop-->
<main>
    <style>
        #appBox{
            /*width: 100%;*/
            background: #ffffff;
            padding:0  0.4rem;
            height: 1.6rem;
        }
        .appBox_left{
            height: 100%;
            float: left;
            line-height: 1.6rem;
            height: 1.6rem;
        }
        .appBox_left img{
            /*margin-left: 0.4rem;*/
            width: 0.933333rem;
            float: left;
            margin-top: 0.33333333rem;
        }
        .appBox_left span{
            font-size: 0.426666rem;
            padding-left: 0.24rem;
        }
        .appBox_right{
            float: right;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .appBox_right_a{
            display: block;

        }
        .appBox_right_a img{
            width: 2.96rem;
        }
        .menu-wrapper,.adminBox{
            top: 2.8rem;
        }
    </style>
    <div id="appBox" style="display:block;">
        <div class="appBox_left"><img src="${base}/assets/images/AppImg/appDownFree.png" alt=""><span>限时免费学习</span></div>
        <div class="appBox_right">
            <a class="appBox_right_a" href="javascript:;" id="openApp"><img src="${base}/assets/images/AppImg/appDownload1.png" alt=""></a>
        </div>
    </div>
    <header>
        <div class="header-container">
            <div class="logo">
                <a href="${base}/m/index.html" style="    line-height: 1.2rem;height: 1.2rem;display: flex;width: 3.2266667rem;justify-content: left;align-items: center;position: relative;z-index: 3">
                    <img src="${base}/assets/mobile/images/logo_index.png" alt="">
                </a>
            </div>
            <style>

            </style>
            <div class="control">
                <div class="control-box">
                    <div class="menu">
                        <i class="menu-icon"></i>
                        <div class="menu-wrapper">
                            <ul class="menu-drop">
                                <li>
                                    <div class="menu-title">
                                        <a href="javascript:void(0)">
                                            <h3>量子计算</h3>
                                            <div class="menu_toggle">
                                                <i></i>
                                            </div>
                                        </a>
                                    </div>
                                    <div class="drop_menu">
                                        <ul>
                                            <li>
                                                <a href="https://qcode.qubitonline.cn/QCode/index.html">量子虚拟机</a>
                                            </li>
                                            <li>
                                                <a href="https://qcode.qubitonline.cn/QCode/apply.html">64位量子虚拟机申请</a>
                                            </li>
                                            <li>
                                                <a href="http://game.qubitonline.cn/">小游戏</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <div class="menu-title">
                                        <a href="${base}/m/quantumLearning.html">
                                            <h3>量子学习</h3>
                                        </a>
                                    </div>
                                </li>
                                <li>
                                    <div class="menu-title">
                                        <a href="${base}/EDU/library.html">
                                            <h3>量子科普</h3>
                                        </a>
                                        <div class="menu_toggle">
                                            <i></i>
                                        </div>
                                    </div>
                                    <div class="drop_menu">
                                        <ul>
                                            <li>
                                                <a href="${base}/QCode/brief/welcome.html">教程文档</a>
                                            </li>
                                            <li>
                                                <a href="${base}/m/mReading.html">推荐阅读</a>
                                            </li>
                                            <li>
                                                <a href="https://learn-quantum.com/tutorial/quantumApps.html?defaultIndex=1">应用领域</a>
                                            </li>
                                            <li>
                                                <a href="https://learn-quantum.com/tutorial/quantumLooking.html">未来发展</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <#--<li>-->
                                    <#--<div class="menu-title">-->
                                        <#--<a href="${base}/m/appCompetition.html">-->
                                            <#--<h3>编程大赛</h3>-->
                                        <#--</a>-->
                                    <#--</div>-->
                                <#--</li>-->
                                <li>
                                    <div class="menu-title">
                                        <a href="https://qcode.qubitonline.cn/qcode/forumtopic/community.html">
                                            <h3>量子论坛</h3>
                                        </a>
                                    </div>
                                </li>
                                <#--<li>-->
                                    <#--<div class="menu-title">-->
                                        <#--<a href="http://download.qubitonline.cn/">-->
                                            <#--<h3>手机端</h3>-->
                                        <#--</a>-->
                                    <#--</div>-->
                                <#--</li>-->
                            </ul>
                        </div>
                    </div>
                    <div class="admin">
                        <div class="adminBox" style="position: fixed;z-index: 99999;">

                            <#if USER_INFO??>
                            <#--已登录-->
                            <div class="admin_con" >
                                <div class="userInfoBox">
                                    <div class="userInfocon">
                                        <div class="userInfocon_left">
                                            <div class="userInfocon_img">
                                             <#if (USER_INFO.face)?exists>
                                                 <img src="/${setting['files.contextpath']}${USER_INFO.face!}" id="picMain">
                                             <#else>
                                                 <img src="${base}/assets/images/wx_new1.jpg" alt="" id="picMain">
                                             </#if>
                                            <#--<img src="${base}/assets/images/wx_new1.jpg" alt="" id="picMain">-->
                                            </div>

                                            <div class="userInfocon_name">
                                                ${USER_INFO.name!}
                                            </div>
                                        </div>
                                        <div class="userInfocon_right" id="signIn">
                                            <button id="NSign" onclick="_hmt.push(['_trackEvent','sign']);signIn(this);">签到</button>
                                        <#--<button id="YSign">已签到</button>-->
                                        </div>
                                    </div>
                                </div>
                                <ul>
                                    <li><a href="${base}/m/dashboard.html"><i></i><span>个人中心</span></a></li>
                                    <li><a href="${base}/m/dashboard.html"><i class="dj"></i><p class="span" id="dj"></p><span>等级</span> </a></li>
                                    <li><a href="${base}/m/dashboard.html"><i class="jf"></i><p class="span" id="jfScore">0</p><span>积分</span> </a></li>
                                    <li class="gr"><a href="${base}/m/personal.html"><i class="gr"></i><span>个人信息设置</span></a></li>
                                    <li class="tc"><a href="${base}/logout.html"><i class="tc"></i><span>退出登录</span></a></li>
                                </ul>
                            </div>

                            <#else>
                            <#--未登录-->
                            <div class="admin_con">
                                <div class="userNoneBox">
                                    <div class="login_box"><a href="${base}/m/login.html">登录</a></div>
                                    <div class="registered_box"><a href="${base}/m/register.html">注册</a></div>
                                </div>
                                <ul>
                                    <li><a href="${base}/m/login.html"><i></i><span>个人中心</span></a></li>
                                    <li><a href="${base}/m/login.html"><i class="dj"></i><span>等级</span></a></li>
                                    <li><a href="${base}/m/login.html"><i class="jf"></i><span>积分</span></a></li>
                                    <li><a href="${base}/m/login.html"><i class="gr"></i><span>个人信息设置</span></a></li>
                                </ul>
                            </div>
                            </#if>


                        </div>



                        <#if USER_INFO??>
                        <#--已登录-->
                         <div class="adminUserPhoto">
                             <#--<img src="${base}/assets/images/wx_new1.jpg" alt="">-->
                         <#if (USER_INFO.face)?exists>
                         <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt=""  id="pic">
                         <#else>
                         <img src="${base}/assets/images/wx_new1.jpg" alt="" id="pic">
                         </#if>
                         </div>
                        <#else>
                        <#--未登录-->
                            <i class="admin-icon"></i>
                            <em class="admin-getI">领积分</em>
                        </#if>
                    </div>

                </div>
            </div>
        </div>
    </header>
</main>
<script type="text/javascript" src="${base}/assets/js/zepot/zepto.min.js"></script>
<script type="text/javascript" src="${base}/assets/js/zepot/touch.js"></script>
<script type="text/javascript" src="${base}/assets/js/zepot/event.js"></script>
<script>
    function shareVideoScore(sid) {
        <#if USER_INFO??>
        $.post("${base}/UpdateUserScore/addScoreByShare.json",{type:10,id:sid},function () {
            getUserInfo();
        })

        $.post("${base}/UpdateUserScore/saveVideoDetail.json",{type:2,"vid":sid},function () {
        })
        </#if>

    }
    $(function() {
            <#if !USER_INFO??>
            <#else >
                getUserInfo();//用户信息
            </#if>

        $("#openApp").on("click",function () {
            var down = false;
            var u = navigator.userAgent, app = navigator.appVersion;
            var isMicroMessenger = u.indexOf('MicroMessenger') > -1 ; //android终端或者uc浏览器
            var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
            if(/s=noRedirect/i.test(location.search)){ return;}
            if(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
                try {
                	if(isMicroMessenger){
                     	alert("请使用手机内置浏览器进行下载.......");
                    }else if(navigator.userAgent.match(/(iPhone|iPod|iPad);?/i)) {
                    	$.post("${base}/statisticsDownload.json",{"version":"iosDown"},function(result) {});
                    	window.location.href = "https://apps.apple.com/cn/app/%E6%9C%AC%E6%BA%90%E6%BA%AF%E7%9F%A5/id1473392815";
                    }else if(navigator.userAgent.match(/android/i)) {
                        window.location.href = "oqcoriginqc://app?param=0";//android app协议
                        setTimeout(function() {
                        	//记录下载次数
                        	$.post("${base}/statisticsDownload.json",{"version":"andriodDown"},function(result) {});
                            window.location.href = "https://learn-quantum.com/app/app-release_v1.0.1.apk";//android 下载地址
                        }, 1000)
                    }else if(isiOS){
                    	$.post("${base}/statisticsDownload.json",{"version":"iosDown"},function(result) {});
                    	window.location.href = "https://apps.apple.com/cn/app/%E6%9C%AC%E6%BA%90%E6%BA%AF%E7%9F%A5/id1473392815";
                    }
                } catch(e) {}
            }else {
                window.location.href = "oqcoriginqc://app?param=0";//android app协议
                setTimeout(function() {
                	$.post("${base}/statisticsDownload.json",{"version":"andriodDown"},function(result) {});
                    window.location.href = "https://learn-quantum.com/app/app-release_v1.0.1.apk";//android 下载地址
                }, 1000)
            }
        })
    });

    function getUserInfo() {
        $.post("${base}/UserInfo/getUserStdLogAndBouns.json",{num:3},
                function (result) {
                    $("#dj").html(result.userTitle);
                    $("#jfScore").html(result.score);
                    $("#grzxdj").html(result.userTitle);
                    $("#integralNum").html(result.score);
//                        $("#stdTime").html(result.userBonusVo.stdtime);
                    $("#myScore").html(result.score);
                    $("#personalScore").html(result.score);
                    $(".det_record_con").find("ul").empty();
                    try {
                        getScore(result.score)
                    }catch (e) {}
                    $.each(result.userVideoList,function(i,item) {
                        // var time = DateMinus(item.datetime);
                        itemVid=item.vid.toString().substring(0,1)+'_'+item.vid.toString().substring(1)
                        var html = "<li>\n" +
                                "<div class=\"record_img\"><img src=\"${base}/assets/images/EduImg/learnRecord.png\" alt=\"\"></div>\n" +
                                "<div class=\"det_record_js\">\n" +
                                "<div class=\"det_record_link\">\n" +
                                "<a href='${base}/m/mVideo.html?link="+itemVid+"'>"+item.title+"</a>\n" +
                                "</div>\n" +
                                "<div class=\"det_record_link\">\n";
                        if(item.datetime==null||item.datetime==''||item.datetime==undefined){
                            html +='<span></span>\n'
                        }else {
                            html +='<span>'+item.datetime.substring(0,item.datetime.length-2)+'</span>\n'
                        }
                        html += "</div>\n" +
                                "</div>\n" +
                                " </li>";
                        $(".det_record_con").find("ul").append(html);
                    })

                    $(".designation-info-box ul li").each(function() {
                        var text = $(this).text().trim();
                        if(text == result.userTitle) {
                            $('.db_userName').addClass($(this).attr("class").split(" ")[0]);
                            $(this).prevAll().addClass("active");
                            $(this).addClass("active");
                        }

                    })
                    switch (result.userTitle) {
                        case "量子浪客":
                            $('.db_userName').addClass('active1');
                            break;
                        case "量子剑心":
                            $('.db_userName').addClass('active2');
                            break;
                        case "量子名士":
                            $('.db_userName').addClass('active3');
                            break;
                        case "量子大师":
                            $('.db_userName').addClass('active4');
                            break;
                        case "量子巨匠":
                            $('.db_userName').addClass('active5');
                            break;
                        case "量子传奇":
                            $('.db_userName').addClass('active6');
                            break;
                        default:
                            $('.db_userName').addClass('active1');

                    }

                    if(result.signIn > 0) {
                        $("#signIn").html("")
                        $("#signIn").append("<button class=\"YSing active\" id='YSign'>已签到</button>");
                        var html = '<button class="YSign"><i></i>已签到</button>';
                        $(".db_sign_box").empty();
                        $(".db_sign_box").html(html);
                    }
                    initHonor(result)
                }
        )

    }
    //根据用户信息初始化荣誉勋章
    function initHonor(result) {
        if(result.userBonusVo.badge1>=1){
            $(".honor_1 .honor_num").html(result.userBonusVo.badge1);
            $('.honor_1').attr('changed','true');
            $('.honor_1').find('img').attr('src','${base}/assets/images/EduImg/1_bright.png');
            if(Number($('#integralNum').text())>=380){
                $('.honor_2').attr('changed','false');
                $('.honor_2').find('img').attr('src','${base}/assets/images/EduImg/2_available.png');
            }
        }
        if(result.userBonusVo.badge2>=1){
            $(".honor_2 .honor_num").html(result.userBonusVo.badge2);
            $('.honor_2').attr('changed','true');
            $('.honor_2').find('img').attr('src','${base}/assets/images/EduImg/2_bright.png');
            if(Number($('#integralNum').text())>=580) {
                $('.honor_3').attr('changed','false');
                $('.honor_3').find('img').attr('src','${base}/assets/images/EduImg/3_available.png');
            }
        }
        if(result.userBonusVo.badge3>=1){
            $(".honor_3 .honor_num").html(result.userBonusVo.badge3);
            $('.honor_3').attr('changed','true');
            $('.honor_3').find('img').attr('src','${base}/assets/images/EduImg/3_bright.png');
            if(Number($('#integralNum').text())>=780) {
                $('.honor_4').attr('changed','false');
                $('.honor_4').find('img').attr('src','${base}/assets/images/EduImg/4_available.png');
            }
        }
        if(result.userBonusVo.badge4>=1){
            $(".honor_4 .honor_num").html(result.userBonusVo.badge4);
            $('.honor_4').attr('changed','true');
            $('.honor_4').find('img').attr('src','${base}/assets/images/EduImg/4_bright.png');
            if(Number($('#integralNum').text())>=1080) {
                $('.honor_5').attr('changed','false');
                $('.honor_5').find('img').attr('src','${base}/assets/images/EduImg/5_available.png');
            }
        }
        if(result.userBonusVo.badge5>=1){
            $(".honor_5 .honor_num").html(result.userBonusVo.badge5);
            $('.honor_5').attr('changed','true');
            $('.honor_5').find('img').attr('src','${base}/assets/images/EduImg/5_bright.png');
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_available.png');
        }
        if(result.userBonusVo.badge6>=1){
            $(".honor_6 .honor_num").html(result.userBonusVo.badge6);
            $('.honor_6').attr('changed','true');
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_bright.png');
        }
        if(result.userBonusVo.badge1&&result.userBonusVo.badge2&&result.userBonusVo.badge3&&result.userBonusVo.badge4&&result.userBonusVo.badge5){
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_available.png');
            $('.honor_6').attr('changed','false');
        }
    }

    function signIn(e) {
        var $this=$(e)
        $.post("${base}/UpdateUserScore/signIn.json",{},
                function(result) {
                    if(result.success) {
                        $.tipsBox({
                            obj: $this,
                            str: "+10",
                            callback: function () {}
                        });
                        niceIn($this);
                        $("#signIn").html("")
                        $("#signIn").append("<button class=\"YSing active\" id='YSign'>已签到</button>");
                        var html = '<button class="YSign"><i></i>已签到</button>';
                        $(".db_sign_box").empty();
                        $(".db_sign_box").html(html);
                        getUserInfo();

                    }else {
                        $("#signIn").html("")
                        $("#signIn").append("<button class=\"YSing active\" id='YSign'>已签到</button>");
                        var html = '<button class="YSign"><i></i>已签到</button>';
                        $(".db_sign_box").empty();
                        $(".db_sign_box").html(html);
                        layer.msg(result.message);

                    }
                }
        );
        if(e.preventDefault){
            e.preventDefault();
        }else{
            window.event.returnValue == false;
        }

    }
</script>
<!--mobileTop end-->
</#macro>

<#macro mfooter>
<!-- Modal生成API KEY -->
<div class="footer-container">
    <div class="Edu_footer">
        <div class="Edu_footer_top">
            <div class="Edu_footer_top_content">
                <div class="Edu_footer_left">
                    <img src="${base}/assets/images/EduImg/logo_footer1.png" alt="logo">
                </div>
                <div class="Edu_footer_right">
                    <ul>
                        <li><a href="http://originqc.com.cn/website/companyProfile.html">关于我们</a></li>
                        <li><a href="https://qcode.qubitonline.cn/qcode/forumtopic/community.html">量子论坛</a></li>
                        <li style="margin-right: 0"><a href="http://originqc.com.cn/website/contactUs.html">联系我们</a></li>
                        <li class="edu_mobile"><i></i><span>移动版</span></li>
                        <li class="wechat"><span  title="wechat"><i></i>官方微信</span></li>
                        <div style="clear:both;"></div>
                    </ul>
                </div>

            </div>
            <div style="clear:both;"> </div>

        </div>
        <div class="Edu_footer_bottom_content">
            <ul>

                <li style="margin-right: 1.12rem">Email : oqc@originqc.com</li>
                <li>电话: 0551-63836038</li>
                <li  style="margin-right: 0.4rem">皖公网安备 34011102000802号</li>
                <li>鄂ICP备15015800号-2</li>
                <li>©2017-2019 <a href="http://originqc.com.cn/" target="_blank">合肥本源量子计算科技有限责任公司 </a>                                               </li>
            </ul>
        </div>
    </div>
</div>
<script>
    var lan = '${lang}';
    var ctxPath = "${base}";
    var fromAdmin = undefined;
    var login = <#if USER_INFO??>true<#else>false</#if>;
    var _hmt = _hmt || [];

    var forward = "${forward!}";
    var registerUrl;
    var loginUrl;
    function addClass(elements, cName) {if (!hasClass(elements, cName)) {elements.className += " " + cName;}}
    function hasClass(elements, cName) {
        return !!elements.className.match(new RegExp("(\\s|^)" + cName + "(\\s|$)"));
    } // ( \\s|^ ) 判断前面是否有空格 （\\s | $ ）判断后面是否有空格 两个感叹号为转换为布尔值 以方便做判断}

    //公共底部判断
    // 获取url数据
    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }

    var flagM=1;

    <#--签到+10-->
    (function ($) {
        $.extend({
            tipsBox: function (options) {
                options = $.extend({
                    obj: null,  //jq对象，要在那个html标签上显示
                    str: "+10",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
                    startSize: "14px",  //动画开始的文字大小
                    endSize: "50px",    //动画结束的文字大小
                    interval: 600,  //动画时间间隔
                    color: "#FFC107",    //文字颜色
                    callback: function () { }    //回调函数
                }, options);
                $("body").append("<span class='num'>" + options.str + "</span>");
                var box = $(".num");
                var left = options.obj.offset().left + options.obj.width() / 3;
                var top = options.obj.offset().top - options.obj.height();
                box.css({
                    "position": "absolute",
                    "left": left + "px",
                    "top": top + "px",
                    "z-index": 9999,
                    "font-size": options.startSize,
                    "line-height": options.endSize,
                    "color": options.color
                });
                box.animate({
                    "opacity": "0",
                    "top": top - parseInt(options.endSize) + "px"
                }, options.interval, function () {
                    box.remove();
                    options.callback();
                });
            }
        });
    })(jQuery);

    function niceIn(prop){
        prop.find('i').addClass('niceIn');
        setTimeout(function(){
            prop.find('i').removeClass('niceIn');
        },1000);
    }

    $(".copeCode").find("textarea").val(window.location.href)
    $(".copeCode").find("textarea").text(window.location.href)
    //复制链接
    $(".copeCode").on("click",function () {
        $(this).find("textarea").select(); // 选择对象
        document.execCommand("Copy"); // 执行浏览器复制命令
        layer.msg("复制链接成功");
    })
</script>
<script type="text/javascript" src="${base}/assets/js/messages_${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}.js"></script>
<script type="text/javascript" src="${base}/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/assets/js/app.js?1.1"></script>
<script>
    // 滑动的时候隐藏菜单的导航
    $(window).scroll(function(){
        $('.adminBox').hide();
        $('.menu-wrapper').hide();
        $('.db_scoreJs').hide()
    });
    if(forward!=null&&forward!=''){
        registerUrl = ctxPath+"/Register/register.html?forward="+forward;
        loginUrl = ctxPath+"/login.html?forward="+forward;
    }else{
        registerUrl = ctxPath+"/Register/register.html";
        loginUrl = ctxPath+"/login.html";
    }
    $(document).ready(function () {
        //用户下拉
        $('.admin').on("tap",function (e) {
            $(".menu-wrapper").slideUp();
            $('.adminBox').toggle();
            e.stopPropagation();
        });
        $(".adminBox").on("tap",function (e) {
            $(this).show()
            e.stopPropagation();
        })
        $(document).on('tap',function(){
            $(".adminBox").hide();
            $(".menu-wrapper").slideUp();
            $('.db_scoreJs').hide();

        });
        //    下拉菜单
        //用户下拉
        $('.menu').on("tap",function (e) {
            $(".adminBox").hide();
            if($(this).find(".menu-wrapper").css("display")=="block"){
                $(this).removeClass("active")
                $(this).find(".menu-wrapper").slideUp()
            }else {
                $(this).addClass("active")
                $(this).find(".menu-wrapper").slideDown()
            }
            e.stopPropagation()
        });
        $(".menu-wrapper").on("tap",function (e) {
            e.stopPropagation()
        })
        $(".menu-title a").on("tap",function (e) {
            e.stopPropagation()
        })
        $(".menu_toggle").on("tap",function (e) {
            if($(this).parents(".menu-title").siblings(".drop_menu").css("display")=="block"){
                $(this).parents(".menu-title").siblings(".drop_menu").slideUp()
                $(this).parents(".menu-title").parent("li").removeClass("active");
            }else {
                $(this).parents(".menu-title").siblings(".drop_menu").slideDown()
                $(this).parents(".menu-title").parent("li").addClass("active");
            }
            if(e.preventDefault){
                e.preventDefault();
            }else{
                window.event.returnValue == false;
            }
            e.stopPropagation()
        })


    });
    function setCookie(name,value){
        var Days = 7; //有效期为7天
        //取出当前日期，加上7天，得出有效截止日期
        var exp = new Date();
        exp.setTime(exp.getTime()+7*24*60*60*1000);
        document.cookie=name +"="+escape(value) +";expries     ="+exp.toGMTString();
    }
    function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }

    //社区使用
    function positionFooter() {
        // 获取页脚的高度
        footerHeight = $(".footer-container").height();
        // 获取页脚的高度
        ///scrollTop() 设置或获取位于对象最顶端和窗口中可见内容的最顶端之间的距离
        footerTop = ($(window).scrollTop()+$(window).height()-footerHeight)+"px";
        var height=$(document.body).height()+45;
        //如果页面内容高度小于屏幕高度，div#footer将绝对定位到屏幕底部，否则div#footer保留它的正常静态定位
        if(height > $(window).height())  {
            $(".footer-container").css({ position: "static",left:"0",width:"100%" }).stop().css({bottom:0});
        }else{
            $(".footer-container").css({ position: "fixed",left:"0",width:"100%" }).stop().css({bottom:0});
        }
    }
    $(function () {setTimeout(function () {footerPosition();},1)});
    var footercontainer = document.getElementsByClassName("footer-container")[0];
    function footerPosition(){
        var contentHeight = document.body.scrollHeight,//网页正文全文高度
                winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
        if(!(contentHeight > winHeight)){
            addClass(footercontainer,'fixed-bottom');
            footercontainer.style.display="block"
            positionFooter();
        } else {footercontainer.style.display="block";
            positionFooter();
        }
    }
    $(window).resize(function () {
        footerPosition();
    });

    $(function(){
        $(".navSwitch").hover(function () {$(".SwitchBtn").show()},function(){$(".SwitchBtn").hide()});
        var g=null;
        $(".UserSearchBtn").on("click",function () {clearTimeout(g);
//            $(this).css("min-width","46px");
            $(".Userinfo .InfoName").hide();
            $(this).find(".navSearch .navInput").css({"width":"158px","height":"40px","opacity":"1","margin-top":"25px"});
            $(this).find(".sea_input").css({"width":"116px"});
            $(this).find("a").hide();

        });
        $(".UserSearchBtn").on("mouseleave",function () {
            $(".Userinfo .InfoName").show();
            $this=$(this);
            $this.find(".navSearch .navInput").css({"width":"0","height":"0","opacity":"0","margin-top":"0"});
            $this.find(".sea_input").css({"width":"0"});
            $this.find("a").slideDown();
        })
    });
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?bb9a0cf2227c371a9f87950463907d08";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();

</script>
<script type="text/javascript" src="${base}/assets/js/layer/layer/layer.js"></script>
<link rel="stylesheet" href="${base}/assets/js/layer/layer/theme/default/layer.css">
<link rel="stylesheet" href="${base}/assets/css/swiper.css">
  <link rel="stylesheet" href="${base}/assets/fonts/iconfont.css">
<#nested>
</html>
</#macro>

<#macro top4>
<!--top-->
<!--top end-->
</#macro>

<#macro top5>
<!--top-->
<style>
    .login_bg{background: transparent!important;border-radius: 10px!important;box-shadow: none!important;}
    .layui-layer-setwin .layui-layer-close2{background: transparent;right: -19px!important;top: -11px!important;}
    .layui-layer-setwin .layui-layer-close2:before{content: '×';font-size: 18px;color: #333;}
        <#if lang?? && lang?string=="en_US">
        body{font-family: "Arial"!important;}
        <#else>
        body{font-family: "黑体", sans-serif!important;}
        </#if>
</style>
<div class="Edu_box">
    <div class="Edu_content">
        <div class="navbar-default Edu_default">
            <div class="logo">
                <a href="${base}/EDU/index.html" style="display:block;cursor: pointer;">
                    <img src="${base}/assets/images/EduImg/logo_index1.png" alt="">
                </a>

            </div>
            <#if USER_INFO??>
                <div id="userSo786" class="admin">
                    <div class="adminBox">
                        <div class="adminBoxPhoto">
                            <#if (USER_INFO.face)?exists>
                                <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="pic">
                            <#else>
                                <img src="${base}/assets/images/wx_new1.jpg" alt="">
                            </#if>
                        </div>
                        <span class="mingzi r"><#if USER_INFO.name?? && USER_INFO.name?length gt 8>${USER_INFO.name?substring(0,8)}...<#else>${USER_INFO.name!}</#if></span>
                    </div>

                    <div class="admin-none">
                        <div class="admin-sign">
                            <div class="admin-user-box">
                                <div class="admin-user-img">
                                    <#if (USER_INFO.face)?exists>
                                        <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="picMain">
                                    <#else>
                                        <img src="${base}/assets/images/wx_new1.jpg" alt="" id="picMain">
                                    </#if>
                                </div>
                                <div class="admin-user-name"><#if USER_INFO.name?? && USER_INFO.name?length gt 10>${USER_INFO.name?substring(0,10)}...<#else>${USER_INFO.name!}</#if></div>
                            </div>
                            <div class="admin-sign-box" id="signIn2">
                                <#if (USER_INFO.signIn gt 0)>
                                    <button class="YSing active" >已签到</button>
                                <#else>
                                    <button class="NSign"onclick="signIn(this)">签到</button>
                                </#if>
                            </div>
                        </div>
                        <div class="admin-list-box">
                            <ul>

                                <li>
                                    <div class="admin-list-details">
                                        <i></i><a href="${base}/EDU/dashboard.html">个人中心</a>
                                    </div>

                                </li>
                                <li>
                                    <div class="admin-list-details">
                                        <i class="dj"></i><a href="${base}/EDU/dashboard.html">等级 </a>
                                        <a href="${base}/EDU/dashboard.html" class="span" id="dj2">量子剑心</a>
                                    </div>

                                </li>
                                <li>
                                    <div class="admin-list-details">
                                        <i class="jf"></i><a href="${base}/EDU/dashboard.html">积分 </a>
                                        <a href="${base}/EDU/dashboard.html" class="span" id="jfScore2">0</a>
                                    </div>

                                </li>
                                <li class="gr">
                                    <div class="admin-list-details ">
                                        <i class="gr"></i><a href="${base}/EDU/personal.html">个人信息设置</a>
                                    </div>

                                </li>
                                <li class="logout">
                                    <div class="admin-list-details ">
                                        <i class="tc"></i><a href="${base}/logout.html">退出登录</a>
                                    </div>

                                </li>
                            </ul>
                        </div>
                    <#--<div id="triangle-up"></div>-->
                    <#--<span><a href="${base}/QCode/project.html"> </span>-->

                    <#--<span><a href="###" onclick="toModify()"><@spring.message code="modify_password" /></a></span>
                    <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a> </span>
                    <span><a href="javascript:void(0);" onclick="createKey(0);">API KEY</a> </span>-->
                    <#--<span><a href="${base}/EDU/dashboard.html">dashboard</a></span>-->
                    <#--<span><a href="${base}/logout.html"><@spring.message code="sign_out" /></a></span>-->
                    </div>
                </div>

            <#else>
                <div id="userSo786" class="admin" style="height: 60px">
                                 <span class="r" style="margin-top: 16px">
                                        <a class="login-url" onclick="viewLoginMin()" style="width: 30px"><@spring.message code="login" /></a>
                                     <#if lang?? && lang?string=="en_US">
                                         <a class="sign-up" style="margin-right: 10px"><@spring.message code="sign_up" /></a>
                                     <#else>
                                         <a class="sign-up" style="margin-left: 15px"><@spring.message code="sign_up" /></a>
                                     </#if>

                </span>
                </div>
            </#if>

            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar" style="margin-top: 13px;margin-bottom: 10px">
                        <span class="sr-only"></span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                    </button>
                </div>
                <div id="navbar" class="navbar-collapse collapse navbar-right " style="margin-top: 8px">
                    <ul class="nav navbar-nav">
                        <!-- 中文 -->
                        <li><a href="${base}/EDU/index.html"><@spring.message code="home_page" /></a></li>
                    <#--量子计算-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="quantum_computing" /></a>
                            <ul class="dropdown-menu">
                                <li><a href="https://qcode.qubitonline.cn/QCode/index.html"><@spring.message code="quantum_virtual_machine" /></a></li>
                                <li><a href="https://qcode.qubitonline.cn/QCode/apply.html"><@spring.message code="64_quantum_virtual_machine" /></a></li>
                                <li><a href="http://game.qubitonline.cn" target="_blank"><@spring.message code="mini_game" /></a></li>
                            </ul>
                        </li>
                    <#--量子学习-->
                        <li class="dropdown">
                            <a href="${base}/EDU/quantumLearning.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="quantum_learn" /></a>
                        </li>
                    <#--量子科普-->
                        <li class="dropdown">
                            <a href="${base}/EDU/library.html" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="quantum_science" /></a>
                            <ul class="dropdown-menu">
                                <li><a href="${base}/QCode/brief/welcome.html"><@spring.message code="tutorial_document" /></a></li>
                                <li><a href="${base}/EDU/Reading.html"><@spring.message code="Recommended_reading" /></a></li>
                                <li><a href="${base}/tutorial/quantumApps.html?defaultIndex=1"><@spring.message code="application_field" /></a></li>
                                <li><a href="${base}/tutorial/quantumLooking.html"><@spring.message code="development" /></a></li>
                            </ul>
                        </li>
                        <#--编程大赛-->
                        <#--<li class="dropdown">-->
                            <#--<a href="${base}/EDU/competition.html" class="dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="quantum_competition" /></a>-->
                        <#--</li>-->
                        <#--量子论坛-->
                        <li class="dropdown">
                            <a href="https://qcode.qubitonline.cn/qcode/forumtopic/community.html" class="dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false"><@spring.message code="quantum_BBS" /></a>
                        </li>
                    <#--手机端-->
                        <li><a href="${base}/EDU/appdownload.html"><@spring.message code="Mobile" /></a></li>
                    </ul>

                </div><!--/.nav-collapse -->
                <div class="Edu_side_right">
                <#--<div class="min1180 ">-->
                <#--<#if lang?? && lang?string=="en_US">-->
                <#--<a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_chinese" /></a>-->
                <#--<#else>-->
                <#--<a onclick="switchLanguage()" style="cursor:pointer"><@spring.message code="language_english" /></a>-->
                <#--</#if>-->
                <#--</div>-->
                    <div class="min1180" >
                        <#if USER_INFO??>
                            <div class="admin">
                                <div class="adminBox">
                                    <div class="adminBoxPhoto">
                                        <#if (USER_INFO.face)?exists>
                                            <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="pic">
                                        <#else>
                                            <img src="${base}/assets/images/wx_new1.jpg" alt="">
                                        </#if>
                                    </div>
                                    <span class="mingzi r"><#if USER_INFO.name?? && USER_INFO.name?length gt 8>${USER_INFO.name?substring(0,8)}...<#else>${USER_INFO.name!}</#if></span>
                                </div>

                                <div class="admin-none">
                                    <div class="admin-sign">
                                        <div class="admin-user-box">
                                            <div class="admin-user-img">
                                                <#if (USER_INFO.face)?exists>
                                                    <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="picMain">
                                                <#else>
                                                    <img src="${base}/assets/images/wx_new1.jpg" alt="" id="picMain">
                                                </#if>
                                            </div>
                                            <div class="admin-user-name"><#if USER_INFO.name?? && USER_INFO.name?length gt 10>${USER_INFO.name?substring(0,10)}...<#else>${USER_INFO.name!}</#if></div>
                                        </div>
                                        <div class="admin-sign-box" id="signIn">
                                            <#if (USER_INFO.signIn gt 0)>
                                                <button class="YSing active" >已签到</button>
                                            <#else>
                                                <button class="NSign"onclick="signIn(this)">签到</button>
                                            </#if>
                                        </div>
                                    </div>
                                    <div class="admin-list-box">
                                        <ul>

                                            <li>
                                                <div class="admin-list-details">
                                                    <i></i><a href="${base}/EDU/dashboard.html">个人中心</a>
                                                </div>

                                            </li>
                                            <li>
                                                <div class="admin-list-details">
                                                    <i class="dj"></i><a href="${base}/EDU/dashboard.html">等级 </a>
                                                    <a href="${base}/EDU/dashboard.html" class="span" id="dj">量子剑心</a>
                                                </div>

                                            </li>
                                            <li>
                                                <div class="admin-list-details">
                                                    <i class="jf"></i><a href="${base}/EDU/dashboard.html">积分 </a>
                                                    <a href="${base}/EDU/dashboard.html" class="span" id="jfScore">0</a>
                                                </div>

                                            </li>
                                            <li class="gr">
                                                <div class="admin-list-details ">
                                                    <i class="gr"></i><a href="${base}/EDU/personal.html">个人信息设置</a>
                                                </div>

                                            </li>
                                            <li class="logout">
                                                <div class="admin-list-details ">
                                                    <i class="tc"></i><a href="${base}/logout.html">退出登录</a>
                                                </div>

                                            </li>
                                        </ul>
                                    </div>
                                <#--<div id="triangle-up"></div>-->
                                <#--<span><a href="${base}/QCode/project.html"> </span>-->

                                <#--<span><a href="###" onclick="toModify()"><@spring.message code="modify_password" /></a></span>
                                <span><a href="${base}/QCode/userApplication.html"><@spring.message code="user_application" /></a> </span>
                                <span><a href="javascript:void(0);" onclick="createKey(0);">API KEY</a> </span>-->
                                <#--<span><a href="${base}/EDU/dashboard.html">dashboard</a></span>-->
                                <#--<span><a href="${base}/logout.html"><@spring.message code="sign_out" /></a></span>-->
                                </div>
                            </div>

                        <#else>
                            <div class="admin" style="height: 60px">

                                 <span class="r" style="margin-top: 16px">
                                        <a class="login-url" onclick="viewLoginMin()" style="width: 30px"><@spring.message code="login" /></a>
                                     <#if lang?? && lang?string=="en_US">
                                         <a class="sign-up" style="margin-right: 10px"><@spring.message code="sign_up" /></a>
                                     <#else>
                                         <a class="sign-up" style="margin-left: 15px"><@spring.message code="sign_up" /></a>
                                     </#if>

                </span>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
            <#if !USER_INFO??>
            <#else >
                getUserInfo();//用户信息
            </#if>

    });
    function getUserInfo() {
        $.post("${base}/UserInfo/getUserStdLogAndBouns.json",{num:3},
                function (result) {
                    $("#dj").html(result.userTitle);
                    $("#dj2").html(result.userTitle);
                    $("#jfScore").html(result.score);
                    $("#jfScore2").html(result.score);
                    $("#grzxdj").html(result.userTitle);
                    $("#integralNum").html(result.score);
//                        $("#stdTime").html(result.userBonusVo.stdtime);
                    $("#myScore").html(result.score);
                    $("#personalScore").html(result.score);
                    $(".det_record_con").find("ul").empty();
                    try {
                        getScore(result.score)
                    }catch (e) {}
                    $.each(result.userVideoList,function(i,item) {
                        // var time = DateMinus(item.datetime);
                        itemVid=item.vid.toString().substring(0,1)+'_'+item.vid.toString().substring(1)
                        var html = "<li>\n" +
                                "<div class=\"record_img\"><img src=\"${base}/assets/images/EduImg/learnRecord.png\" alt=\"\"></div>\n" +
                                "<div class=\"det_record_js\">\n" +
                                "<div class=\"det_record_link\">\n" +
                                "<a href='${base}/EDU/video.html?link="+itemVid+"'>"+item.title+"</a>\n" +
                                "</div>\n" +
                                "<div class=\"det_record_link\">\n";
                        // if(time == 0 || isNaN(time)) {
                        //     html += "<span>刚刚</span>\n";
                        // }else {
                        //     html += "<span>"+time+"天前</span>\n";
                        // }
                        if(item.datetime==null||item.datetime==''||item.datetime==undefined){
                            html +='<span></span>\n'
                        }else {
                            html +='<span>'+item.datetime.substring(0,item.datetime.length-2)+'</span>\n'
                        }

                        html += "</div>\n" +
                                "</div>\n" +
                                " </li>";
                        $(".det_record_con").find("ul").append(html);
                    })

                    $(".designation-info-box ul li").each(function() {
                        var text = $(this).text().trim();
                        if(text == result.userTitle) {
                            $('.designation-bj-end').addClass($(this).attr("class").split(" ")[0]);
                            $(this).prevAll().addClass("active");
                            $(this).addClass("active");
                        }

                    })

                    if(result.signIn > 0) {
                        $("#signIn").html("")
                        $("#signIn2").html("")
                        $("#signIn").append("<button class=\"YSing active\">已签到</button>");
                        $("#signIn2").append("<button class=\"YSing active\">已签到</button>");
                        var html = "<div class=\"sign-box active\">\n" +
                                "<button class=\"registered active\">已签到</button>\n" +
                                "<span class=\"signTrue active\">已获10积分</span>\n" +
                                "</div>";

                        html += "<div class=\"toSetBox\">\n" +
                                "                                        <a href=\"${base}/EDU/personal.html\">修改个人信息</a>\n" +
                                "                                    </div>"
                        $(".signIn-info").empty();
                        $(".signIn-info").append(html);
                    }
                    initHonor(result)
                }
        )

    }
    //根据用户信息初始化荣誉勋章
    function initHonor(result) {
        if(result.userBonusVo.badge1>=1){
            $(".honor_1 .honor_num").html(result.userBonusVo.badge1);
            $('.honor_1').attr('changed','true');
            $('.honor_1').find('img').attr('src','${base}/assets/images/EduImg/1_bright.png');
            if(Number($('#integralNum').text())>=380){
                $('.honor_2').attr('changed','false');
                $('.honor_2').find('img').attr('src','${base}/assets/images/EduImg/2_available.png');
            }
            flag1 = false;
        }
        if(result.userBonusVo.badge2>=1){
            $(".honor_2 .honor_num").html(result.userBonusVo.badge2);
            $('.honor_2').attr('changed','true');
            $('.honor_2').find('img').attr('src','${base}/assets/images/EduImg/2_bright.png');
            if(Number($('#integralNum').text())>=580) {
                $('.honor_3').attr('changed','false');
                $('.honor_3').find('img').attr('src','${base}/assets/images/EduImg/3_available.png');
            }
        }
        if(result.userBonusVo.badge3>=1){
            $(".honor_3 .honor_num").html(result.userBonusVo.badge3);
            $('.honor_3').attr('changed','true');
            $('.honor_3').find('img').attr('src','${base}/assets/images/EduImg/3_bright.png');
            if(Number($('#integralNum').text())>=780) {
                $('.honor_4').attr('changed','false');
                $('.honor_4').find('img').attr('src','${base}/assets/images/EduImg/4_available.png');
            }
        }
        if(result.userBonusVo.badge4>=1){

            $(".honor_4 .honor_num").html(result.userBonusVo.badge4);
            $('.honor_4').attr('changed','true');
            $('.honor_4').find('img').attr('src','${base}/assets/images/EduImg/4_bright.png');
            if(Number($('#integralNum').text())>=1080) {
                $('.honor_5').attr('changed','false');
                $('.honor_5').find('img').attr('src','${base}/assets/images/EduImg/5_available.png');
            }
        }
        if(result.userBonusVo.badge5>=1){
            $(".honor_5 .honor_num").html(result.userBonusVo.badge5);
            $('.honor_5').attr('changed','true');
            $('.honor_5').find('img').attr('src','${base}/assets/images/EduImg/5_bright.png');
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_available.png');
            flag5 = false;
        }
        if(result.userBonusVo.badge6>=1){
            $(".honor_6 .honor_num").html(result.userBonusVo.badge6);
            $('.honor_6').attr('changed','true');
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_bright.png');
        }
        if(result.userBonusVo.badge1&&result.userBonusVo.badge2&&result.userBonusVo.badge3&&result.userBonusVo.badge4&&result.userBonusVo.badge5){
            $('.honor_6').find('img').attr('src','${base}/assets/images/EduImg/6_available.png');
            $('.honor_6').attr('changed','false');
        }
    }

    function signIn(e) {
        var $this=$(e)
        $.post("${base}/UpdateUserScore/signIn.json",{},
                function(result) {
                    if(result.success) {
                        $.tipsBox({
                            obj: $this,
                            str: "+10",
                            callback: function () {}
                        });
                        niceIn($this);
                        $("#signIn").html("")
                        $("#signIn").append("<button class=\"YSing active\">已签到</button>");
                        var html = "<div class=\"sign-box active\">\n" +
                                "<button class=\"registered active\">已签到</button>\n" +
                                "<span class=\"signTrue active\">已获10积分</span>\n" +
                                "</div>";
                        $(".signIn-info").empty();
                        $(".signIn-info").append(html);
                        getUserInfo();

                    }else {
                        $("#signIn").html("")
                        $("#signIn").append("<button class=\"YSing active\">已签到</button>");
                        var html = "<div class=\"sign-box active\">\n" +
                                "<button class=\"registered active\">已签到</button>\n" +
                                "<span class=\"signTrue active\">已获10积分</span>\n" +
                                "</div>";
                        $(".signIn-info").empty();
                        $(".signIn-info").append(html);
                        layer.msg(result.message);

                    }
                }
        );
    }

</script>
<!--top end-->
</#macro>
<#macro pagination pager>
    <#if (pager.totalRecords)?default(0) != 0>
    <div class="row">
        <input type="hidden" id="startId" name="start" value="${(RequestParameters.start?default(0))!}"/>
        <nav>
            <ul class="pagination navbar-toggle">
                <li>
                    <a><font color="red">${(pager.totalRecords)!}</font><@spring.message code="strip" /></a>
                </li>
                <li>
                    <a>${(pager.totalPages)!}<@spring.message code="page" /></a>
                </li>
                <li>
                    <a aria-label="Previous" href="javascript:void(0)" onclick="toPage(0);">
                        <span aria-hidden="true">«</span>
                    </a>
                </li>
                <#if pager.pageNum gt 2>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 2)*pager.pageSize!});">${(pager.pageNum - 2)!}</a></li>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
                <#elseif pager.pageNum gt 1>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.previousPage - 1)*pager.pageSize!});">${(pager.pageNum - 1)!}</a></li>
                </#if>
                <li class="active"><a><font color="white">${(pager.pageNum)!}</font></a></li>
                <#if (pager.totalPages - pager.pageNum) gt 1>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.nextPage)*pager.pageSize!});">${(pager.nextPage + 1)!}</a></li>
                <#elseif (pager.totalPages - pager.pageNum) gt 0>
                    <li><a href="javascript:void(0)" onclick="toPage(${(pager.pageNum)*pager.pageSize!});">${(pager.nextPage)!}</a></li>
                </#if>
                <li>
                    <a aria-label="Next" href="javascript:void(0)" onclick="toPage(${(pager.totalPages-1)*pager.pageSize!});">
                        <span aria-hidden="true">»</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    </#if>
</#macro>
<#macro body>
<body>
    <#nested>
<div class="model-icon">本源量子</div>
<div class="first-bg" style="display:none;">
    <div class="first-del">
        <a href="###"><i class="iconfont icon-cha1"></i></a>
    </div>
    <div class="first-pic bounceIn animated">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <#--<img src="${base}/assets/images/a1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img src="${base}/assets/images/b1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img src="${base}/assets/images/c1.png" />-->
                </div>
                <div class="swiper-slide">
                    <#--<img src="${base}/assets/images/d1.png" />-->
                </div>
                <div class="swiper-slide">
                    <div class="ljty">
                        <a href="###"><@spring.message code="immediate_experience" /></a>
                    </div>
                    <#--<img src="${base}/assets/images/e1.png" />-->
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
            <!-- Add Arrows -->
            <div class="swiper-button-next swiper-button-white"></div>
            <div class="swiper-button-prev swiper-button-white"></div>
        </div>
    </div>
</div>
</body>
</#macro>
<#macro footer>
<!-- Modal生成API KEY -->
<div class="modal fade" id="apiKeyModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="display:none;">
    <div class="modal-dialog" role="document" style="width:500px;"><!--style="width:294px;" -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">API KEY</h4>
            </div>
            <div class="modal-body">
                <div class="contentt clear">
                    <div>
                        <input type="hidden" id="typeId" value="1">
                        <div class="zi">
                            <div class="zi-left" taskType="1" style="width:100%;">
                                <p id="apiKeyContent"></p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="createKey(1);"><@spring.message code="regenerate"/></button>
                            <button type="button" class="btn btn-primary" onclick="closeModel();"><@spring.message code="close"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer-container">
    <div class="Edu_footer">
        <div class="Edu_footer_top">
            <div class="Edu_footer_top_content">
                <ul>
                    <li class="footer_logo"><img src="${base}/assets/images/EduImg/logo_footer1.png" alt="logo"></li>
                    <li><a href="http://originqc.com.cn/website/companyProfile.html">关于我们</a></li>
                    <li><a href="https://qcode.qubitonline.cn/qcode/forumtopic/community.html">量子论坛</a></li>
                    <li><a href="http://originqc.com.cn/website/contactUs.html">联系我们</a></li>
                    <li class="edu_mobile"><i></i><span>移动版</span></li>
                    <li class="wechat"><span  title="wechat"><i></i></span></li>
                    <div style="clear:both;"></div>
                </ul>
            </div>
            <div style="clear:both;"> </div>

        </div>
        <div class="Edu_footer_bottom_content">
            <ul>
                <li>©2017-2019 <a href="http://originqc.com.cn/" target="_blank">合肥本源量子计算科技有限责任公司 </a>                                               </li>
                <li>鄂ICP备15015800号-2</li>
                <li>皖公网安备 34011102000802号</li>
                <li>电话: 0551-63836038</li>
                <li>Email : oqc@originqc.com</li>
            </ul>
        </div>
    </div>
</div>
<script>
    var lan = '${lang}';
    var ctxPath = "${base}";
    var fromAdmin = undefined;
    var login = <#if USER_INFO??>true<#else>false</#if>;

    var forward = "${forward!}";
    var registerUrl;
    var loginUrl;
    function addClass(elements, cName) {if (!hasClass(elements, cName)) {elements.className += " " + cName;}}
    function hasClass(elements, cName) {
        return !!elements.className.match(new RegExp("(\\s|^)" + cName + "(\\s|$)"));
    } // ( \\s|^ ) 判断前面是否有空格 （\\s | $ ）判断后面是否有空格 两个感叹号为转换为布尔值 以方便做判断}

    //公共底部判断
    // 获取url数据
    function getQueryString(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }
    var flagM=1;
</script>
<script type="text/javascript" src="${base}/assets/js/app.js?1.1"></script>
<script>
    if(forward!=null&&forward!=''){
        registerUrl = ctxPath+"/Register/register.html?forward="+forward;
        loginUrl = ctxPath+"/login.html?forward="+forward;
    }else{
        registerUrl = ctxPath+"/Register/register.html";
        loginUrl = ctxPath+"/login.html";
    }

    //弹出小框的登录
    function viewLoginMin(){
        layer.open({
            type : 2,
            title: false,
            closeBtn: 1, //不显示关闭按钮
            move : false,
            shade :0.1,
            area : [ '632px', '342px' ],
            shift : 2,
            skin:"login_bg",
            content : [ ctxPath+"/login.html", 'no' ]
        });
    }
    $(".sign-up").attr("href",registerUrl);
    $(document).ready(function () {
        //遮罩
        $('.moda').click(function () {
            $('.loading-bg').show();
            $('.loading').show();
            setTimeout("$('.loading').hide()",5000);
            setTimeout("$('.loading-bg').hide()",5000);
        });

        //用户下拉
        $('.admin').mouseenter(function () {
            $('.admin-none').css('display','block');
        }).mouseleave(function(e){
            $('.admin-none').css('display','none');
        });

    });

    function toModify(){window.location.href="${base}/Mine/modify.html";}

    function setCookie(name,value){
        var Days = 7; //有效期为7天
        //取出当前日期，加上7天，得出有效截止日期
        var exp = new Date();
        exp.setTime(exp.getTime()+7*24*60*60*1000);
        document.cookie=name +"="+escape(value) +";expries     ="+exp.toGMTString();
    }
    function getCookie(name){
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }
    <#--// 是否登录-->
    <#--function isLogin() {-->
        <#--<#if !USER_INFO??>-->
            <#--errorMsg(messages.visitor_no_right);-->
            <#--//window.location.href="${base}/login.html"-->
            <#--return false;-->
        <#--<#else>-->
            <#--return true;-->
        <#--</#if>-->
    <#--}-->


    //切换语言
    function switchLanguage(){
        var url=window.location.href;
        var lan = '${lang}';
        if(lan=='en_US'){//中文
            if(url.indexOf("?lang=")>0 || url.indexOf("&lang=")>0){
                url = changeURLPar(url,'lang','zh_CN');
            }else{
                if(url.indexOf("?")>0){
                    url = url　+ "&lang=zh_CN";
                }else{
                    url = url　+ "?lang=zh_CN";
                }
            }
        }else{//英文
            if(url.indexOf("?lang=")>0 || url.indexOf("&lang=")>0){
                url = changeURLPar(url,'lang','en_US');
            }else{
                if(url.indexOf("?")>0){
                    url = url　+ "&lang=en_US";
                }else{
                    url = url　+ "?lang=en_US";
                }
            }
        }
        window.location.href=url;
    }
    //修改URL参数
    function changeURLPar(destiny, par, par_value){
        var pattern = par+'=([^&]*)';
        var replaceText = par+'='+par_value;
        if (destiny.match(pattern)){
            var tmp = '/\\'+par+'=[^&]*/';
            tmp = destiny.replace(eval(tmp), replaceText);
            return (tmp);
        }else{
            if (destiny.match('[\?]')){
                return destiny+'&'+ replaceText;
            }else{
                return destiny+'?'+replaceText;
            }
        }
        return destiny+'\n'+par+'\n'+par_value;
    }
    //生成API KEY
    //isRepeat是否重新生成
    function createKey(isRepeat){
        var param ={};
        param.isRepeat = isRepeat;
        $.ajax({
            url:"${base}/QCode/createKey.json",
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            data:param,
            type:'post',
            success:function(result){
                if(result.code == 401){
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if(result.success){
                    $("#apiKeyContent").text(result.obj);
                    $('#apiKeyModel').modal('show');
                } else {
                    errorMsg(messages.option_fail);
                }
            },
            error:function(){
                errorMsg(messages.option_fail);
            }
        });
    }


    // var footerHeight = 0;
    // var footerTop = 0;
    $(function () {setTimeout(function () {footerPosition();},1)});
    //社区使用
    function positionFooter() {
        // 获取页脚的高度
        footerHeight = $(".footer-container").height();
        // 获取页脚的高度
        ///scrollTop() 设置或获取位于对象最顶端和窗口中可见内容的最顶端之间的距离
        footerTop = ($(window).scrollTop()+$(window).height()-footerHeight)+"px";
        var height=$(document.body).height()+45;
        //如果页面内容高度小于屏幕高度，div#footer将绝对定位到屏幕底部，否则div#footer保留它的正常静态定位
        if(height > $(window).height())  {
            $(".footer-container").css({ position: "static",left:"0",width:"100%" }).stop().css({bottom:0});
        }else{
            $(".footer-container").css({ position: "fixed",left:"0",width:"100%" }).stop().css({bottom:0});
        }
    }
    var footercontainer = document.getElementsByClassName("footer-container")[0];
    function footerPosition(){
        var contentHeight = document.body.scrollHeight,//网页正文全文高度
                winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
        if(!(contentHeight > winHeight)){
            addClass(footercontainer,'fixed-bottom');
            footercontainer.style.display="block"
            positionFooter();
        } else {footercontainer.style.display="block";
            positionFooter();
        }
    }
    $(window).resize(function () {footerPosition();});

    $(function(){
        $(".navSwitch").hover(function () {$(".SwitchBtn").show()},function(){$(".SwitchBtn").hide()});
        var g=null;
        $(".UserSearchBtn").on("click",function () {clearTimeout(g);
//            $(this).css("min-width","46px");
            $(".Userinfo .InfoName").hide();
            $(this).find(".navSearch .navInput").css({"width":"158px","height":"40px","opacity":"1","margin-top":"25px"});
            $(this).find(".sea_input").css({"width":"116px"});
            $(this).find("a").hide();

        });
        $(".UserSearchBtn").on("mouseleave",function () {
            $(".Userinfo .InfoName").show();
            $this=$(this);
            $this.find(".navSearch .navInput").css({"width":"0","height":"0","opacity":"0","margin-top":"0"});
            $this.find(".sea_input").css({"width":"0"});
            $this.find("a").slideDown();
        })
    });

    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?bb9a0cf2227c371a9f87950463907d08";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

<script type="text/javascript" src="${base}/assets/js/messages_${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}.js"></script>
<script type="text/javascript" src="${base}/assets/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${base}/assets/js/bootstrap.min.js"></script>
<#--<script type="text/javascript" src="${base}/assets/js/bootstro.js"></script>-->
<#--<script type="text/javascript" src="${base}/assets/js/qiao.js"></script>-->
<#--<script type="text/javascript" src="${base}/assets/plugins/select2/select2.js"></script>-->
<#--<script type="text/javascript" src="${base}/assets/js/dialog.js"></script>-->
<script type="text/javascript" src="${base}/assets/js/layer/layer/layer.js"></script>
<link rel="stylesheet" href="${base}/assets/js/layer/layer/theme/default/layer.css">

<#--<link rel="stylesheet" href="${base}/assets/js/popup/popup/style.css" />-->
<#--<link rel="stylesheet" href="${base}/assets/plugins/select2/select2.css">-->
<#--<script type="text/javascript" src="${base}/assets/js/popup/drag.js"></script>-->
<#--<script type="text/javascript" src="${base}/assets/js/popup/dialog.js"></script>-->
<#--<script src="${base}/assets/js/formValidator/validateEngine.js"></script>-->
<link rel="stylesheet" href="${base}/assets/css/swiper.css">
<link rel="stylesheet" class="cssLazy" href="">
<script type="text/javascript">
    (function ($) {
        $.extend({
            tipsBox: function (options) {
                options = $.extend({
                    obj: null,  //jq对象，要在那个html标签上显示
                    str: "+10",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
                    startSize: "14px",  //动画开始的文字大小
                    endSize: "50px",    //动画结束的文字大小
                    interval: 600,  //动画时间间隔
                    color: "#FFC107",    //文字颜色
                    callback: function () { }    //回调函数
                }, options);
                $("body").append("<span class='num'>" + options.str + "</span>");
                var box = $(".num");
                var left = options.obj.offset().left + options.obj.width() / 3;
                var top = options.obj.offset().top - options.obj.height();
                box.css({
                    "position": "absolute",
                    "left": left + "px",
                    "top": top + "px",
                    "z-index": 9999,
                    "font-size": options.startSize,
                    "line-height": options.endSize,
                    "color": options.color
                });
                box.animate({
                    "opacity": "0",
                    "top": top - parseInt(options.endSize) + "px"
                }, options.interval, function () {
                    box.remove();
                    options.callback();
                });
            }
        });
    })(jQuery);

    function niceIn(prop){
        prop.find('i').addClass('niceIn');
        setTimeout(function(){
            prop.find('i').removeClass('niceIn');
        },1000);
    }

    $(".copeCode").find("textarea").val(window.location.href)
    $(".copeCode").find("textarea").text(window.location.href)
    //复制链接
    $(".copeCode").on("click",function () {
        $(this).find("textarea").select(); // 选择对象
        document.execCommand("Copy"); // 执行浏览器复制命令
        layer.msg("复制链接成功");
    })
    $(window).load(function() {
        $(".cssLazy").attr("href",'${base}/assets/fonts/iconfont.css?v1.0')
        if("${USER_INFO}" != '') {
            setInterval(funcTest,5000);
        }
    });

    function funcTest(){
        $.post("${base}/InspectHeart/inspect.json",function(result) {

        })

    }

    window.onload = funcTest;
</script>
    <#nested>
</html>
</#macro>


<#-- Mathjax 公共js -->
<#macro mathjax>
    <style>
        .mn {
            background: inherit!important;
            color: inherit;
        }
        img{
            max-width: 100%;
        }
    </style>
    <script type="text/x-mathjax-config">
        //Mathjax相关配置
        MathJax.Hub.Config({
            showProcessingMessages: false,  //关闭js加载过程信息
            messageStyle: "none",  //不显示信息
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath:  [ ["$", "$"] ],   //行内公式选择$
                displayMath: [ ["$$","$$"] ],  //段内公式选择$$
                skipTags: ['script', 'noscript', 'style', 'textarea', 'pre','code','a'],  //避开某些标签
                ignoreClass:"comment-content"  //避开含该Class的标签
            },
            "HTML-CSS": {
                availableFonts: ["STIX","TeX"],   //可选字体
                imageFont: null   //去除图片加载
            }
        });

    </script>
    <script type="text/javascript" src="${base}/assets/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <#nested>
</#macro>