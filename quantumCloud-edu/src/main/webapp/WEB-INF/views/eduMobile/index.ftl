<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader>
    <#escape x as x?html></#escape>
</@main.mHeader>
<@main.body>
    <#escape x as x?html>
        <@main.mobileTop><#escape x as x?html></#escape></@main.mobileTop>
        <div class="main">
            <div class="swiper-container" style="margin-top: 0px;">
                <div class="swiper-wrapper">
                    <div class="swiper-slide swiper-no-swiping">
                        <img  src="${base}/assets/images/EduImg/eduuMobile-banner.png" width="100%" />
                        <div class="swiper-slide-describe">
                            <div class="slide_banner_box">
                                <div class="banner_h1">本源量子教育</div>
                                <div class="banner_h2">引 领 未 来 的 计 算 编 程 教 学</div>
                                <div class="banner_h3">
                                    本源量子计算教育系列免费课程，包含详细的量子计算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。
                                </div>
                                <a class="startLearning" href="${base}/m/quantumLearning.html">立即开始</a>
                            </div>
                        </div>
                    </div>
                    <#--<div class="swiper-slide swiper-no-swiping">-->
                        <#--<img src="${base}/assets/images/EduImg/app_education_banner.png" width="100%" style="height: 411px;"/>-->
                        <#--<div class="swiper-slide-describe">-->
                            <#--<div class="slide_banner_box">-->
                                <#--<div class="banner_h1">首届量子编程大赛</div>-->
                                <#--<div class="banner_h3" style="text-align: center;color: #fff;font-size: 12px;margin-top: 8px">提高对于量子编程的认识和理解</br>“孕育”未来的量子程序员</br>共同探索属于量子计算的未来</div>-->
                                <#--<a class="startLearning competitionLink" href="${base}/m/appCompetition.html">了解详情</a>-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->
                </div>
                <#--<div class="swiper-button-next swiper-button-white" style="height: 30px;height: 30px"></div>-->
                <#--<div class="swiper-button-prev swiper-button-white" style="height: 30px;height: 30px"></div>-->
            </div>
            <div class="index-box">
                <div class="edu-header">
                    <h2>/&nbsp;&nbsp;&nbsp;课程运作方式&nbsp;&nbsp;&nbsp;/</h2>
                </div>
                <div class="edu-details">
                    <div class="edu_describe">
                        <ul>
                            <li class="edu_describe_list">
                                <div class="edu_describe_img">
                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe1.png" alt="">
                                </div>
                                <div class="edu_describe_name"><span>免费参与</span></div>
                            </li>
                            <li class="edu_describe_list">
                                <div class="edu_describe_img">
                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe2.png" alt="">
                                </div>
                                <div class="edu_describe_name"><span>入门清晰</span></div>
                            </li>
                            <li class="edu_describe_list">
                                <div class="edu_describe_img">
                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe3.png" alt="">
                                </div>
                                <div class="edu_describe_name"><span>项目检验</span></div>
                            </li>
                            <li class="edu_describe_list">
                                <div class="edu_describe_img">
                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe4.png" alt="">
                                </div>
                                <div class="edu_describe_name"><span>交流答疑</span></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="m_course">
                <div class="edu-header course_header">
                    <h2>/&nbsp;&nbsp;&nbsp;量子计算系统课程&nbsp;&nbsp;&nbsp;/</h2>
                </div>
                <div class="course_box">
                    <ul id="course_slide" class="swiper-wrapper">
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#0">
                            <div class="m_course_con course_active  course_con1">
                                <div class="course_con_header">量子计算入门基础</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    本模块课程将会从物理源头带你深入解密量子计算，学完本课程你将会获得:
                                    <ul class="course_list">
                                        <li><i></i><span> 量子计算的“前世今生”</span></li>
                                        <li><i></i><span>量子计算的“庐山真面目”</span></li>
                                        <li><i></i><span>量子计算的奇妙特性</span></li>
                                        <li><i></i><span>量子计算涉及到的正确理解</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#1">
                            <div class="m_course_con course_con2">
                                <div class="course_con_header">量子计算编程介绍</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    本模块课程将从量子逻辑门到实际量子算法带你了解本源量子云框架结构，学完本课程你将了解：
                                    <ul class="course_list">
                                        <li><i></i><span> 本源量子云平台架设结构</span></li>
                                        <li><i></i><span>本源量子云平台工作结构</span></li>
                                        <li><i></i><span>单量子、双量子比特的解释及作用</span></li>
                                        <li><i></i><span>OriginIR量子语言</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#2">
                            <div class="m_course_con course_con3">
                                <div class="course_con_header">量子计算编程教学</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    本模块深入介绍逻辑门和量子算法的运用，逐步带你进入量子计算编程世界：
                                    <ul class="course_list">
                                        <li><i></i><span> 计算机编程的发展</span></li>
                                        <li><i></i><span>量子编程与经典编程的差异</span></li>
                                        <li><i></i><span>量子编程语言结构</span></li>
                                        <li><i></i><span>本源OriginIR和本源QPanda2</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#3">
                            <div class="m_course_con course_con4">
                                <div class="course_con_header">量子计算硬件介绍</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    本模块课程将会从物理源头带你深入解密量子计算，学完本课程你将会获得:
                                    <ul class="course_list">
                                        <li><i></i><span> 本源量子云平台架设结构</span></li>
                                        <li><i></i><span>本源量子云平台工作结构</span></li>
                                        <li><i></i><span>单量子、双量子比特的解释及作用</span></li>
                                        <li><i></i><span>OriginIR量子语言</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#5">
                            <div class="m_course_con course_con5">
                                <div class="course_con_header">中科大量子算法节选</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    本模块主要收录了科大量子计算教学视频，帮助你努力靠近量子计算领域的诸多核心知识：
                                    <ul class="course_list">
                                        <li><i></i><span> Simon algorithm</span></li>
                                        <li><i></i><span>QFT algorithm</span></li>
                                        <li><i></i><span>adiabatic theorem</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <a href="${base}/m/quantumLearning.html#7">
                                <div class="m_course_con course_con6">
                                    <div class="course_con_header">从零学量子计算破解RSA密码</div>
                                    <div class="blueLine"></div>
                                    <div class="course_dis">
                                        本模块为你介绍量子计算历史上最强大的“解密”算法，学完本章你将获得:
                                        <ul class="course_list">
                                            <li><i></i><span> RSA算法原理</span></li>
                                            <li><i></i><span> 量子傅里叶变换和量子加法器</span></li>
                                            <li><i></i><span> 模指线路、模乘线路及模加线路</span></li>
                                            <li><i></i><span> Shor算法的原理</span></li>
                                            <li><i></i><span> 在本源虚拟机上成功实施Shor算法</span></li>
                                            <li><i></i><span>...</span></li>
                                        </ul>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <li class="swiper-slide">
                            <div class="m_course_con course_con7">
                                <div class="course_con_header">从零学量子计算解决组合优化问题</div>
                                <div class="blueLine"></div>
                                <div class="course_dis">
                                    <ul class="course_list">
                                        <li><i></i><span> 即将推出</span></li>
                                        <li><i></i><span>...</span></li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="course_bottom">
                    <ul class="line_list" id="icons">
                        <li class="blue_active"></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                    <a class="startLearning slearning">立即学习</a>
                </div>

            </div>
            <div class="index-box">
                <div class="edu-header">
                    <h2>/&nbsp;&nbsp;&nbsp;&nbsp; 学术研究 &nbsp;&nbsp;&nbsp;&nbsp;/</h2>
                </div>

                <div class="bottom-video">
                    <div class="bottom-videoImg">
                        <a href="${base}/m/mVideo.html?link=6_1">
                            <img src="${base}/assets/images/EduImg/video_img_play.png">
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </#escape>
</@main.body>
<@main.mfooter>
    <script src="${base}/assets/js/swiper.min.js"></script>
<#--edit start-->
<#--微信分享-->
    <script src="${base}/assets/js/sha1.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${base}/assets/js/jquery.lazyload.min.js"></script>
    <script type="text/javascript">


        var timestamp = parseInt(new Date().getTime() / 1000);
        var infoText = "";
        infoText = getQueryString("info")
        var shareDataTile = "本源量子计算教育云平台";
        if (infoText != '' && infoText != null && infoText != undefined) {
            shareDataTile = "本源量子计算教育系列课程__" + unescape(infoText)

        } else {
            shareDataTile = "本源量子计算教育系列课程"
        }
        var shareData = {
            title: shareDataTile,
            desc: "点击查看详情",
            imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
            otherImgUrl: '',
            text: '我正在学习，很不错哦！快来一起学习吧！',
            url: location.href.split('#')[0],
            link: shareLink+"/EDU/quantumLearning.html",
            "success": function () {//分享成功后的回调函数
            },
            'cancel': function () {
                // 用户取消分享后执行的回调函数
            }
        }
        $.post("${base}/Wechat/ShareLearning.json", {}, function (result) {
            console.log(result);
            data = result.obj;
            SignString = "jsapi_ticket=" + data.ticket + "&noncestr=" + data.noncestr + "&timestamp=" + timestamp.toString() + "&url=" + location.href.split('#')[0]
            s = new jsSHA(SignString.toString(), "TEXT");
            t = s.getHash("SHA-1", "HEX");
            var sha1Sign = t
            wx.config({
                debug: false,
                appId: data.appid,
                timestamp: timestamp,
                nonceStr: data.noncestr,
                signature: sha1Sign.toString(),
                jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            wx.ready(function () {
                wx.onMenuShareTimeline(shareData);
                wx.onMenuShareAppMessage(shareData);
                wx.onMenuShareQQ(shareData);
                wx.onMenuShareWeibo(shareData);

            });
        })
    </script>
    <script>
        // 图片懒加载
        $(function() {
            $("img.lazy").lazyload();
        });
        $('.slearning').on('click',function () {
            window.location.href="${base}/m/quantumLearning.html#"+$('.blue_active').index();
        })
        var swiper = new Swiper('.course_box', {
            navigation: false,
            autoplay: false,
            pagination: {el: '.swiper-pagination', clickable: true},
            slidesPerView: 1,
            paginationClickable: true,
            spaceBetween: 12,
            mousewheelControl: false,
            autoplayDisableOnInteraction: false,
            loop: true,
            pagination: {
                el: '.course_bottom #icons',
                bulletElement : 'li',
                type: 'custom',
                renderCustom: function (swiper, current, total) {
                    var _html = '';
                    for (var i = 1; i <= total; i++) {
                        if (current == i) {
                            _html += '<li class="blue_active"></li>';
                        }else{
                            _html += '<li></li>';
                        }
                    }
                    return _html;//返回所有的页码html
                }
            },
        });
        // var swiper2 = new Swiper('.swiper-container', {
        //     navigation: {nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev'},
        //     autoplay: {delay: 45000, disableOnInteraction: false},
        //     pagination: {el: '.swiper-pagination', clickable: true},
        //     slidesPerView: 1,
        //     paginationClickable: true,
        //     spaceBetween: 12,
        //     mousewheelControl: false,
        //     autoplayDisableOnInteraction: false,
        //     loop: true,
        // });

    </script>

</@main.mfooter>