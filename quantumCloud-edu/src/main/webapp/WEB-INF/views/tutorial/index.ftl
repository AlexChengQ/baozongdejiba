<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html></#escape>
    <style>
        body{
            background-color: #fff!important;
        }
    </style>
</@main.header>
<@main.body>
    <#escape x as x?html>

        <div class="content" style="padding: 0;" xmlns="http://www.w3.org/1999/html">
            <link rel="stylesheet" href="${base}/assets/css/public.css">
        <!--top-->
            <@main.top5><#escape x as x?html></#escape></@main.top5>
            <div class="bannerOrSwiper">
                <div class="swiper-container" style="margin-top: 0px;">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide swiper-no-swiping">
                            <img src="${base}/assets/images/EduImg/bannerDemo.png" width="100%"/>
                            <div class="swiper-slide-describe">
                                <div class="slide_banner_box">
                                    <div class="banner_h1">本源量子教育</br>引领未来的计算编程教学</div>
                                    <div class="banner_h3">本源量子计算教育系列课程，包含详细的量子计</br>算专业基础、高级开发课程，专为渴望接触量子</br>编程的你，打造最适合的学习方式。</div>
                                    <a  class="startLearning" href="${base}/EDU/quantumLearning.html"></a>
                                </div>
                            </div>
                        </div>
                        <#--<div class="swiper-slide swiper-no-swiping">-->
                            <#--<img src="${base}/assets/images/EduImg/education_banner.png" width="100%"/>-->
                            <#--<div class="swiper-slide-describe">-->
                                <#--<div class="slide_banner_box">-->
                                    <#--<div class="banner_h1">首届量子编程大赛</div>-->
                                    <#--<div class="banner_h3">提高对于量子编程的认识和理解</br>“孕育”未来的量子程序员</br>共同探索属于量子计算的未来</div>-->
                                    <#--<a class="startLearning competitionLink" href="${base}/EDU/competition.html">了解详情</a>-->
                                <#--</div>-->

                            <#--</div>-->
                        <#--</div>-->
                    </div>
                    <!-- Add Pagination -->
                    <#--<div class="swiper-pagination"></div>-->
                    <!-- Add Arrows -->
                    <#--<div class="swiper-button-next swiper-button-white"></div>-->
                    <#--<div class="swiper-button-prev swiper-button-white"></div>-->
                </div>
                <div class="index-container">
                    <div class="index-box">
                        <div class="index-content">
                            <div class="index-box">
                                <div class="edu-header">
                                    <i class="eh-left"></i>
                                    <i class="eh-right"></i>
                                    <span class="h2">课程运作方式</span>
                                </div>
                                <div class="edu-details">
                                    <div class="edu_describe">
                                        <ul>
                                            <li class="edu_describe_list">
                                                <div class="edu_describe_img">
                                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe1.png" alt="">
                                                </div>
                                                <div class="edu_describe_name"><span>免费参与</span></div>
                                                <div class="edu_describe_js"><span>学习量子计算行业尖端技术</span></div>
                                            </li>
                                            <li class="edu_describe_list">
                                                <div class="edu_describe_img">
                                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe2.png" alt="">
                                                </div>
                                                <div class="edu_describe_name"><span>入门清晰</span></div>
                                                <div class="edu_describe_js"><span>从概念引入到量子编程“步步为营”</span></div>
                                            </li>
                                            <li class="edu_describe_list">
                                                <div class="edu_describe_img">
                                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe3.png" alt="">
                                                </div>
                                                <div class="edu_describe_name"><span>项目检验</span></div>
                                                <div class="edu_describe_js"><span>每一个所学知识点都会有对应检测项目</span></div>
                                            </li>
                                            <li class="edu_describe_list">
                                                <div class="edu_describe_img">
                                                    <img class="lazy" data-original="${base}/assets/images/EduImg/edu_describe4.png" alt="">
                                                </div>
                                                <div class="edu_describe_name"><span>交流答疑</span></div>
                                                <div class="edu_describe_js"><span>学习过程中任何问题都可进行在线询问</span></div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="index-content">
                            <div class="index-box">
                                <div class="edu-header">
                                    <i class="eh-left"></i>
                                    <i class="eh-right"></i>
                                    <span class="h2">量子计算系统课程</span>
                                </div>
                                <div class="edu-details">
                                    <div class="edu-course-box">
                                        <ul>
                                            <a href="${base}/EDU/quantumLearning.html#1">
                                                <li class="edu-course-list ">
                                                <div class="edu-course-left">
                                                    <div class="edu-course-img">
                                                        <div class="edu-course-img-text img-text-left">量子计算入门基础</div>
                                                        <img class="lazy" data-original="${base}/assets/images/EduImg/course1.png" alt="">
                                                    </div>
                                                </div>
                                                <div class="edu-course-right">
                                                    <ul>
                                                        <li style="padding-left: 0"><span>本模块课程将会从物理源头带你深入解密量子计算，学完本课程你将会知道:</span></li>
                                                        <li><i></i><span>量子计算的“前世今生”</span></li>
                                                        <li><i></i><span>量子计算的“庐山真面目”</span></li>
                                                        <li><i></i><span>量子计算的奇妙特性</span></li>
                                                        <li><i></i><span>量子计算涉及到的正确理解</span></li>
                                                        <li><i></i><span>...</span></li>
                                                    </ul>
                                                </div>
                                            </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#2">
                                                <li class="edu-course-list Reverse">
                                                <div class="edu-course-left">
                                                    <div class="edu-course-img">
                                                        <div class="edu-course-img-text img-text-right">量子计算编程介绍</div>
                                                        <img class="lazy" data-original="${base}/assets/images/EduImg/course2.png" alt="">
                                                    </div>
                                                </div>
                                                <div class="edu-course-right">
                                                    <ul>
                                                        <li style="padding-left: 0"><span>本模块课程将从量子逻辑门到实际量子算法带你了解本源量子云框架结构，学完本课程你将了解：</span></li>
                                                        <li><i></i><span> 本源量子云平台架设结构</span></li>
                                                        <li><i></i><span>本源量子云平台工作结构</span></li>
                                                        <li><i></i><span>单量子、双量子比特的解释及作用</span></li>
                                                        <li><i></i><span>OriginIR量子语言</span></li>
                                                        <li><i></i><span>...</span></li>
                                                    </ul>
                                                </div>
                                            </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#3">
                                                <li class="edu-course-list">
                                                <div class="edu-course-left">
                                                    <div class="edu-course-img">
                                                        <div class="edu-course-img-text img-text-left">量子计算编程教学</div>

                                                        <img class="lazy" data-original="${base}/assets/images/EduImg/course3.png" alt="">
                                                    </div>
                                                </div>
                                                <div class="edu-course-right">
                                                    <ul>
                                                        <li style="padding-left: 0"><span>本模块深入介绍逻辑门和量子算法的运用，逐步带你进入量子计算编程世界：</span></li>
                                                        <li><i></i><span> 计算机编程的发展</span></li>
                                                        <li><i></i><span>量子编程与经典编程的差异</span></li>
                                                        <li><i></i><span>量子编程语言结构</span></li>
                                                        <li><i></i><span>本源OriginIR和本源QPanda2</span></li>
                                                        <li><i></i><span>...</span></li>
                                                    </ul>
                                                </div>
                                            </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#4">
                                                <li class="edu-course-list Reverse">
                                                <div class="edu-course-left">
                                                    <div class="edu-course-img">
                                                        <div class="edu-course-img-text img-text-right">量子计算硬件介绍</div>

                                                        <img class="lazy" data-original="${base}/assets/images/EduImg/course4.png">
                                                    </div>
                                                </div>
                                                <div class="edu-course-right">
                                                    <ul>
                                                        <li style="padding-left: 0"><span>本模块课程主要解析本源量子研发的量子计算机相关硬件介绍，学完本章你将认识到:</span></li>
                                                        <li><i></i><span> 量子计算信号的传输的重要性</span></li>
                                                        <li><i></i><span>量子计算控制系统的不可或缺性</span></li>
                                                        <li><i></i><span>量子计算芯片当前介绍</span></li>
                                                        <li><i></i><span>...</span></li>
                                                    </ul>
                                                </div>
                                            </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#5">
                                                <li class="edu-course-list ">
                                                    <div class="edu-course-left">
                                                        <div class="edu-course-img">
                                                            <div class="edu-course-img-text" style="right: 16%">从零学量子计算解决组合优化问题</div>
                                                            <img class="lazy" data-original="${base}/assets/images/EduImg/course8.png" alt="">
                                                        </div>
                                                    </div>
                                                    <div class="edu-course-right">
                                                        <ul>
                                                            <li style="padding-left: 0"><span>本模块将首次为你揭秘量子优化算法在现实中的应用，学完本章你将会获得：</span></li>
                                                            <li><i></i><span> 最大切割问题是什么</span></li>
                                                            <li><i></i><span>泡利算符是什么</span></li>
                                                            <li><i></i><span>哈密顿量是什么</span></li>
                                                            <li><i></i><span>QAOA的原理</span></li>
                                                            <li><i></i><span>VQNet框架的如何使用</span></li>
                                                            <li><i></i><span>...</span></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#6">
                                                <li class="edu-course-list Reverse">
                                                    <div class="edu-course-left">
                                                        <div class="edu-course-img">
                                                            <div class="edu-course-img-text img-text-left">中科大量子算法节选</div>
                                                            <img class="lazy" data-original="${base}/assets/images/EduImg/course5.png" alt="">
                                                        </div>
                                                    </div>
                                                    <div class="edu-course-right">
                                                        <ul>
                                                            <li style="padding-left: 0"><span>本模块主要收录了科大量子计算教学视频，帮助你努力靠近量子计算领域的诸多核心知识：</span></li>
                                                            <li><i></i><span> Simon algorithm</span></li>
                                                            <li><i></i><span>QFT algorithm</span></li>
                                                            <li><i></i><span>adiabatic theorem</span></li>
                                                            <li><i></i><span>...</span></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </a>
                                            <a href="${base}/EDU/quantumLearning.html#8">
                                                <li class="edu-course-list ">
                                                    <div class="edu-course-left">
                                                        <div class="edu-course-img">
                                                            <div class="edu-course-img-text" style="left: 12%">从零学量子计算破解RSA密码</div>
                                                            <img class="lazy" data-original="${base}/assets/images/EduImg/course7.png" alt="">
                                                        </div>
                                                    </div>
                                                    <div class="edu-course-right">
                                                        <ul>
                                                            <li style="padding-left: 0"><span>本模块为你介绍量子计算历史上最强大的“解密”算法，学完本章你将获得:</span></li>
                                                            <li><i></i><span>RSA算法原理</span></li>
                                                            <li><i></i><span>量子傅里叶变换和量子加法器</span></li>
                                                            <li><i></i><span>模指线路、模乘线路及模加线路</span></li>
                                                            <li><i></i><span>Shor算法的原理</span></li>
                                                            <li><i></i><span>在本源虚拟机上成功实施Shor算法</span></li>
                                                            <li><i></i><span>...</span></li>
                                                        </ul>
                                                    </div>
                                                </li>
                                            </a>



                                            <#--<a href="${base}/EDU/quantumLearning.html#6">-->
                                                <#--<li class="edu-course-list Reverse">-->
                                                    <#--<div class="edu-course-left">-->
                                                        <#--<div class="edu-course-img">-->
                                                            <#--<div class="edu-course-img-text img-text-right">量子计算学术研究</div>-->
                                                            <#--<img src="${base}/assets/images/EduImg/course6.png" alt="">-->
                                                        <#--</div>-->
                                                    <#--</div>-->
                                                    <#--<div class="edu-course-right">-->
                                                        <#--<ul>-->
                                                            <#--<li><span>本模块课程将会从物理源头带你深入解密量子计算，学完本课程你将会获得:</span></li>-->
                                                            <#--<li><i></i><span> 正确的量子概念思维；</span></li>-->
                                                            <#--<li><i></i><span>极具未来前瞻的技术理念；</span></li>-->
                                                            <#--<li><i></i><span>本源量子独家颁发的量子勋章；</span></li>-->
                                                            <#--<li><i></i><span>...</span></li>-->
                                                            <#--<li><i></i><span>...</span></li>-->
                                                            <#--<li><i></i><span>...</span></li>-->
                                                        <#--</ul>-->
                                                    <#--</div>-->
                                                <#--</li>-->
                                            <#--</a>-->
                                        </ul>
                                        <div class="edu_course_more">
                                            <a href="${base}/EDU/quantumLearning.html">立即学习</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="index-content">
                            <div class="index-box">
                                <div class="edu-header">
                                    <i class="eh-left"></i>
                                    <i class="eh-right"></i>
                                    <span class="h2">学术研究</span>
                                </div>

                                    <div class="bottom-video">
                                        <div class="bottom-videoImg">
                                            <a href="${base}/EDU/video.html?link=7_1">
                                                <img class="lazy" data-original="${base}/assets/images/EduImg/playBtn.png">
                                            </a>
                                        </div>
                                    </div>

                                <#--<div class="edu-details">-->
                                    <#--<div class="edu_hz_box">-->
                                        <#--<ul>-->
                                            <#--<li>-->
                                                <#--<div class="edu_hz_img">-->
                                                    <#--<img src="${base}/assets/images/EduImg/hz_01.png" alt="">-->
                                                <#--</div>-->
                                            <#--</li>-->
                                            <#--<li>-->
                                                <#--<div class="edu_hz_img">-->
                                                    <#--<img src="${base}/assets/images/EduImg/hz_709.png" alt="">-->
                                                <#--</div>-->
                                            <#--</li>-->
                                        <#--</ul>-->
                                        <#--<div class="edu_hz_more">-->
                                            <#--<a href="javascript:void (0)">MORE</a>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                <#--</div>-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </#escape>
</@main.body>
<@main.footer>

<script src="${base}/assets/js/swiper.min.js"></script>
<#--edit start-->
<#--微信分享-->
<script src="${base}/assets/js/sha1.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    // 图片懒加载
    $(function() {
        $("img.lazy").lazyload();
    });

    var timestamp=parseInt(new Date().getTime()/1000);
    var infoText="";
    infoText=getQueryString("info")
    var shareDataTile="本源量子计算教育云平台";
    if(infoText!=''&&infoText!=null&&infoText!=undefined){
        shareDataTile="本源量子计算教育系列课程__"+unescape(infoText)

    }else {
        shareDataTile="本源量子计算教育系列课程"
    }
    var shareData = {
        title:  shareDataTile,
        desc: "点击查看详情",
        imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
        otherImgUrl: '',
        text: '我正在学习，很不错哦！快来一起学习吧！',
        url:location.href.split('#')[0],
        link: shareLink+"/EDU/quantumLearning.html",
        "success":function(){//分享成功后的回调函数
        },
        'cancel': function () {
            // 用户取消分享后执行的回调函数
        }
    }
    $.post("${base}/Wechat/ShareLearning.json",{},function (result) {
        data=result.obj;
        SignString ="jsapi_ticket="+data.ticket+"&noncestr="+data.noncestr+"&timestamp="+timestamp.toString()+"&url="+location.href.split('#')[0]
        s = new jsSHA(SignString.toString(),"TEXT");
        t = s.getHash("SHA-1", "HEX");
        var sha1Sign=t
        wx.config({
            debug: false,
            appId: data.appid,
            timestamp: timestamp,
            nonceStr: data.noncestr,
            signature: sha1Sign.toString(),
            jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        });
        wx.ready(function() {
            wx.onMenuShareTimeline(shareData);
            wx.onMenuShareAppMessage(shareData);
            wx.onMenuShareQQ(shareData);
            wx.onMenuShareWeibo(shareData);

        });
    })
</script>
<script>
    // var swiper = new Swiper('.swiper-container', {
    //     navigation: {nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev'},
    //     autoplay: {delay: 4500, disableOnInteraction: false},
    //     pagination: {el: '.swiper-pagination', clickable: true},
    //     slidesPerView: 1,
    //     paginationClickable: true,
    //     spaceBetween: 0,
    //     mousewheelControl: false,
    //     autoplayDisableOnInteraction: false,
    //     loop: true,
    //     pagination: {
    //         el: '.swiper-pagination',
    //         bulletElement : 'li',
    //         type: 'custom',
    //         renderCustom: function (swiper, current, total) {
    //             var _html = '';
    //             for (var i = 1; i <= total; i++) {
    //                 if (current == i) {
    //                     _html += '<div class="pagination-custom active"><i></i></div>';
    //                 }else{
    //                     _html += '<div class="pagination-custom"><i></i></div>';
    //                 }
    //             }
    //             return _html;//返回所有的页码html
    //         }
    //     },
    // });
</script>
</@main.footer>