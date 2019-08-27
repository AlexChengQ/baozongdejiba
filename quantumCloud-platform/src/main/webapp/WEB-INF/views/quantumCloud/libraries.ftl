<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-width:1336px;">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <!--box-->
        <style>
            .content{
                padding-top: 0!important;
            }
            .navbar{
                background: url(${base}/assets/images/jcTopBg.png) repeat-x;
                background-color: transparent;
            }
            .navbar{
                position: absolute;
            }
            .footer-container{
                background: #262f40;
                color: #fff;
            }
            .footer-container a{
                color: #fff;
            }
            .libList .title {
                margin-top: 80px;
                width: 100%;
                text-align: center;
                font-size: 24px;
                line-height: 24px;
                color: #333;
            }

            .libList .tip {
                font-size: 16px;
                line-height: 48px;
                margin-bottom: 18px;
                text-align: center;
                color: #666;
            }

            .lisUser {
                width: 1200px;
                margin: 0 auto;
                height: auto;
                padding-bottom: 110px;

            }

            .lisUser li {
                position: relative;
                width: 400px;
                height: 200px;
                float: left;
                margin-right: 0px;
                padding: 10px;
                margin-bottom: 0px;
                cursor: pointer;
                background: #fff;
            }

            .lisUser li .lisBox {
                width: 100%;
                padding: 24px;
                height: 100%;
                border: 2px solid #f3f3f3;
                border-right: 1px solid #e6e6e6;
                border-left: 1px solid #e6e6e6;

            }

            .lisUser li.odd {
                margin-right: 0;
            }

            .lisUser li.active, .lisUser li:hover {
                background: url(${base}/assets/images/jcListbg.png);
                -webkit-background-size: 100% 100%;
                height: 200px;
                background-size: 100% 100%;
                padding: 0;
            }

            .lisUser li.active .lisBox, .lisUser li:hover .lisBox {
                padding: 36px 34px;
                border: none;
            }

            .lisDetTitle {
                font-size: 16px;
                color: #333;
                line-height: 35px;
            }

            .lisDetTips {
                padding-top: 5px;
                line-height: 24px;
                color: #666;
                font-size: 14px;
            }

            .libHref {
                position: absolute;
                right: 25px;
                bottom: 20px;
                font-size: 14px;
                color: #333;
                padding-right: 25px;
                background: url(${base}/assets/images/jcJt.png) right no-repeat;

            }

            .vidContent {
                width: 100%;
                height: 620px;
                background: #4d6980;
            }

            .vidList .title {
                font-size: 24px;
                color: #fff;
                padding-top: 60px;
                line-height: 24px;
                text-align: center;
            }

            .vidList .tip {
                color: #fff;
                text-align: center;
                font-size: 16px;
                padding-bottom: 20px;
                line-height: 48px;
            }

            .vidList {
                width: 1200px;
                margin: 0 auto;
            }

            .vidlisUser {
                padding: 70px 10px;

            }

            .vidlisUser li {
                width: 280px;
                height: 195px;
                background: #178cec;
                float: left;
                margin-right: 20px;
                margin-bottom: 20px;
                position: relative;
            }

            /*video*/
            #videoplayer_overlay video {
                outline: none;
            }

            #videoplayer_overlay {
                position: fixed;
                top: 0px;
                bottom: 0px;
                left: 0px;
                right: 0px;
                background-color: #4c4c4c;
                background-color: rgba(0, 0, 0, .7);
                z-index: 3000;
            }

            #videoplayer_outer_container {
                position: fixed;
                top: 50%;
                left: 50%;
                width: 95%;
                max-width: 854px;
                transform: translate(-50%, -50%);
                -webkit-transform: translate(-50%, -50%);
            }

            #videoplayer_container {
                position: relative;
                width: 95%;
                max-width: 854px;
                margin: 0 auto;
                color: #4d4d4d;
                background: #fff;
                box-shadow: 0 0 20px #222;
                z-index: 3001;
            }

            #videoplayer_container:before {
                content: "";
                display: block;
                padding-top: 56.25%;
            }

            #videoplayer {
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
            }
            .video-js {
                background-color: #000;
                position: relative;
                padding: 0;
                /* Start with 10px for base font size so other dimensions can be em based and
                   easily calculable. */

                font-size: 10px;
                /* Allow poster to be vertically aligned. */

                vertical-align: middle;
                /*  display: table-cell; */
                /*This works in Safari but not Firefox.*/

                /* Provide some basic defaults for fonts */

                font-weight: normal;
                font-style: normal;
                /* Avoiding helvetica: issue #376 */

                font-family: Arial, sans-serif;
                /* Turn off user selection (text highlighting) by default.
                   The majority of player components will not be text blocks.
                   Text areas will need to turn user selection back on. */

                /* user-select */
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
            }
            /* Playback technology elements expand to the width/height of the containing div
                <video> or <object> */
            .video-js .vjs-tech {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }
            /* Fix for Firefox 9 fullscreen (only if it is enabled). Not needed when
               checking fullScreenEnabled. */
            .video-js:-moz-full-screen {
                position: absolute;
            }
            #box-close {
                position: absolute;
                top: 10px;
                right: 10px;
                width: 30px;
                height: 30px;
                opacity: .35;
                cursor: pointer;
            }

            #box-close:hover {
                opacity: .75;
            }
            .vid_screenshot{
                height: 155px;
                width: 100%;
            }
            .vid_screenshot img{
                width: 100%;
            }
            .vid_js{
                line-height: 40px;
                color: #fff;
                text-align: left;
                padding: 0 16px;

            }
            .vid_js .right{
                float: right;
            }
            .vidHover,.vidHoverImg{
                position: absolute;
                width: 100%;
                height: 100%;
                background: #000;
                opacity: 0.3;
                top:0;
                display: none;
            }
            .vidHoverImg{
                width: 52px;
                height: 52px;
                top:50%;
                left:50%;
                display: none;
                margin-left: -26px;
                margin-top: -26px;

                background: url(${base}/assets/images/autoPlay.png);
                z-index: 2;
                opacity:1;
            }
            .vidlisUser li.active .vidHover,.vidlisUser li.active .vidHoverImg{
                display: block;
            }
            .lis_case{
                width: auto;
                /*margin: 0 auto;*/
                text-align: center;
                float: left;
            }
            .caseUser{
                width: 1200px;
                padding-bottom: 300px;
                margin: 0 auto;
            }
            .lis_case .case_details{
                width: 294px;
                height: 200px;
                border: 1px solid #e8ebef;
                margin: 0 auto;
            }
            .case_title{
                background: #e8ebef;
                line-height: 56px;

            }
            .case_name{
                padding: 35px 10px;
                font-size: 16px;
                color: #666;
            }
            .case_href{
                width: 122px;
                height: 33px;
                line-height: 33px;
                text-align: center;
                border-radius: 8px;
                color: #fff;
                background: #0f6ab5;
                display: inline-block;
            }
            .libraries-title{
                position: absolute;bottom: 22%;  color: #fff;  text-align: center; width: 100%;font-size: 16px;
            }
            .libraries-title p.name{
                font-size: 34px
            }
            .libShuffling {
                position: relative;
                width: 1200px;
                padding: 0 132px;
                margin: 0 auto;
                overflow: hidden;
            }
            .libShuffling ul{
                width: 1740px;
            }
            .libContainer{
                width: 100%;
                overflow: hidden;
            }
            .swiperBtn a{
                width: 29px;
                height: 52px;
                position: absolute;
                left: 50px;
                top: 60px;
                background: url(${base}/assets/images/libJt.png) center no-repeat;
            }
            .swiperBtn a.LibNext{
                right: 50px;
                left: auto;
                background-image: url(${base}/assets/images/libJtr.png);
            }
        </style>
        <div class="banner" style="position: relative;"><img src="${base}/assets/images/libraries.jpg" alt="" style="width:100%;">
        <div class="libraries-title">
            <p class="name">教程</p>
            <p >欢迎使用量子云平台，我们为您提供了详细的云平台教程，您也可以通过视频教程的学习来提高使用熟练程度。</p>
        </div>
        </div>
        <div class="libContent">
            <div class="libList">
                <div class="title">量子云计算平台教程</div>
                <div class="tip">帮助你快速了解量子云计算平台以及量子算法</div>
                <ul class="lisUser clearfix">
                    <li class="lisUser-details">
                        <div class="lisBox">
                            <div class="lisDetTitle">欢迎来到量子的世界</div>
                            <div class="lisDetTips">
                                量子云计算平台是一个主要基于真实量子芯片的云计
                                算服务，它是一个开放的平台，任何人都可以从这个
                                平台获取以下服务
                            </div>
                            <a href="${base}/QCode/brief/welcome.html" class="libHref">查看详情 </a>
                        </div>

                    </li>
                    <li class="lisUser-details">
                        <div class="lisBox">
                            <div class="lisDetTitle">量子世界</div>
                            <div class="lisDetTips">
                                了解什么是量子态、量子叠加性、测量和坍缩？
                            </div>
                            <a href="${base}/QCode/brief/world.html" class="libHref">查看详情 </a>
                        </div>
                    </li>
                    <li class="lisUser-details odd">
                        <div class="lisBox">
                            <div class="lisDetTitle">量子力学</div>
                            <div class="lisDetTips">
                                用数学的方式来展示量子世界。
                            </div>
                            <a href="${base}/QCode/brief/mechanics.html" class="libHref">查看详情 </a>
                        </div>

                    </li>
                    <li class="lisUser-details">
                        <div class="lisBox">
                            <div class="lisDetTitle">量子计算原理</div>
                            <div class="lisDetTips">
                                通过量子逻辑门来对量子态进行操作。
                            </div>
                            <a href="${base}/QCode/brief/theory.html" class="libHref">查看详情</a>
                        </div>

                    </li>
                    <li class="lisUser-details">
                        <div class="lisBox">
                            <div class="lisDetTitle">量子算法</div>
                            <div class="lisDetTips">
                                量子算法是以量子态作为输入，量子逻辑门作为操作序列的算法。
                            </div>
                            <a href="${base}/QCode/brief/algorithm.html" class="libHref">查看详情 <i></i></a>
                        </div>

                    </li>
                </ul>
            </div>
        </div>
        <div class="vidContent">
            <div class="vidList">
                <div class="title">量子云计算平台教程</div>
                <div class="tip">帮助你快速了解量子云计算平台以及量子算法</div>
                <ul class="vidlisUser clearfix">
                    <li>
                        <div class="vid_screenshot">
                            <img src="${base}/assets/images/yunpingtvideo.png" alt="">
                        </div>
                        <div class="vid_js">
                            <span>32位量子虚拟机演示视频</span> <span class="right">12:00</span>
                        </div>
                        <div class="vidHover"></div>
                        <div class="vidHoverImg"><img src="" alt=""></div>
                    </li>
                    <li>
                        <div class="vid_screenshot">
                            <img src="${base}/assets/images/appvideo.png" alt="">
                        </div>
                        <div class="vid_js">
                            <span>APP操作指南</span> <span class="right">08:00</span>
                        </div>
                        <div class="vidHover"></div>
                        <div class="vidHoverImg"><img src="" alt=""></div>
                    </li>
                    <li>
                        <div class="vid_screenshot">
                            <img src="${base}/assets/images/yunpingtvideo.png" alt="">
                        </div>
                        <div class="vid_js">
                            <span>虚拟机申请视频</span> <span class="right">15:42</span>
                        </div>
                        <div class="vidHover"></div>
                        <div class="vidHoverImg"><img src="" alt=""></div>
                    </li>
                    <li style="margin: 0">
                        <div class="vid_screenshot">
                            <img src="${base}/assets/images/yunpingtvideo2.png" alt="">
                        </div>
                        <div class="vid_js">
                            <span>云平台展示视频</span> <span class="right">17:00</span>
                        </div>
                        <div class="vidHover"></div>
                        <div class="vidHoverImg"><img src="" alt=""></div>
                    </li>


                </ul>
            </div>
        </div>
        <div class="libContent">
            <div class="libList">
                <div class="title">教程案例</div>
                <div class="tip">通过案例学习，轻松掌握量子计算云平台使用技巧</div>
                <div class="libShuffling">
                    <div class="libContainer">
                        <ul class="caseUser swiper-wrapper">
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（1/8）</div>
                                    <div class="case_name">D-J Algorithm</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（2/8）</div>
                                    <div class="case_name">HHL算法</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（3/8）</div>
                                    <div class="case_name">Mayer-Penny Game in Quantum</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（4/8）</div>
                                    <div class="case_name">Counterfeit Coin Game</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（5/8）</div>
                                    <div class="case_name">随机数生成</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（6/8）</div>
                                    <div class="case_name">Simon 算法</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（7/8）</div>
                                    <div class="case_name">Swap Test 算法</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                            <li class="lis_case swiper-slide">
                                <div class="case_details">
                                    <div class="case_title">教程案例（8/8）</div>
                                    <div class="case_name">Bernstein-Vazirani Algorithm 算法</div>
                                    <a href="javascript:;" class="case_href">查看详情</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="swiperBtn">
                        <a href="javascript:;" class="LibPrev"></a>
                        <a href="javascript:;" class="LibNext"></a>
                    </div>

                </div>

            </div>
        </div>

        <div class="box" style="padding-top:80px;display: none ">
            <div class="news-list">
                <dl>
                    <dt><h1>量子云计算平台教程</h1></dt>
                    <dd><a href="${base}/QCode/brief/welcome.html">欢迎来到量子的世界</a>
                        <p>Welcome To The World Of Quantum</p></dd>
                    <dd><a href="${base}/QCode/brief/world.html">量子世界</a>
                        <p>Quantum World</p></dd>
                    <dd><a href="${base}/QCode/brief/mechanics.html">量子力学</a>
                        <p>Quantum Mechanics</p></dd>
                    <dd><a href="${base}/QCode/brief/theory.html">量子计算原理</a>
                        <p>Theory of Quantum Computing</p></dd>
                    <dd><a href="${base}/QCode/brief/algorithm.html">量子算法</a>
                        <p>Quantum Algorithm</p></dd>

                </dl>
                <dl style="margin-top:40px;">
                    <dt><h1><@spring.message code="tutorial_case" /></h1></dt>
                    <dd><a href="${base}/QCode/index.html?projectId=257"><@spring.message code="tutorial_case_one" /></a>
                    </dd>
                    <dd><a href="${base}/QCode/index.html?projectId=258"><@spring.message code="tutorial_case_two" /></a>
                    </dd>
                </dl>
            </div>
            <!--box end-->
        </div>

    </div>
    </#escape>
</@main.body>
<@main.footer>
<script>
    $(document).ready(function () {
        var NewSwiper = new Swiper('.libContainer', {
            slidesPerView: 3,
            spaceBetween: 20,
            loop: true,
            navigation: {
                nextEl: '.LibNext',
                prevEl: '.LibPrev'
            }
        });
        t = $('.fixed').offset().top;
        $(window).scroll(function () {
            s = $(document).scrollTop();
            if (s > t - 10) {
                $('.fixed').css('position', 'fixed');
                $('.fixed').css('left', '14px');
                $('.news-content').css('margin-left', '16%');
                if (s) {
                    $('.fixed').css('top', 'px');
                }
            } else {
                $('.fixed').css('position', '');
                $('.news-content').css('margin-left', '');

            }
        })




    });
</script>
</@main.footer>