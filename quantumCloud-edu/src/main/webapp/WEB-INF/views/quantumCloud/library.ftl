<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html></#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
        <div class="content  clearfix" style="min-width:1200px;">
            <!--top-->
            <@main.top5>
                <#escape x as x?html></#escape>
            </@main.top5>
            <div class="bannerOrSwiper">
                <div class="banner" style="position: relative;"><img src="${base}/assets/images/library.jpg" alt="" style="width:100%;">
                    <div class="libraries-title">
                        <p class="name">教程</p>
                        <p >欢迎使用量子云平台，我们为您提供了详细的云平台教程，您也可以通过视频教程的学习来提高使用熟练程度。</p>
                    </div>
                </div>
            </div>
            <div class="libContent">
                <div class="libList">
                    <div class="title" id="1">教程文档</div>
                    <div class="tip">帮助你快速了解量子云计算平台以及量子算法</div>
                    <ul class="lisUser clearfix">
                        <li class="lisUser-details">
                            <div class="lisBox">
                                <#--<div class="lisDetTitle"><@spring.message code="welcome_to_the_quantum_world" /></div>-->
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
                                <#--<div class="lisDetTitle"><@spring.message code="quantum_world" /></div>-->
                                <div class="lisDetTitle">量子世界</div>
                                <div class="lisDetTips">了解什么是量子态、量子叠加性、测量和坍缩？</div>
                                <a href="${base}/QCode/brief/world.html" class="libHref">查看详情 </a>
                            </div>
                        </li>
                        <li class="lisUser-details odd">
                            <div class="lisBox">
                                <#--<div class="lisDetTitle"><@spring.message code="quantum_mechanics" /></div>-->
                                <div class="lisDetTitle">量子力学</div>
                                <div class="lisDetTips">用数学的方式来展示量子世界。</div>
                                <a href="${base}/QCode/brief/mechanics.html" class="libHref">查看详情 </a>
                            </div>

                        </li>
                        <li class="lisUser-details">
                            <div class="lisBox">
                                <#--<div class="lisDetTitle"><@spring.message code="principles_of_quantum_computation" /></div>-->
                                <div class="lisDetTitle">量子计算原理</div>
                                <div class="lisDetTips">通过量子逻辑门来对量子态进行操作。</div>
                                <a href="${base}/QCode/brief/theory.html" class="libHref">查看详情</a>
                            </div>

                        </li>
                        <li class="lisUser-details">
                            <div class="lisBox">
                                <#--<div class="lisDetTitle"><@spring.message code="quantum_algorithm" /></div>-->
                                <div class="lisDetTitle">量子算法</div>
                                <div class="lisDetTips">量子算法是以量子态作为输入，量子逻辑门作为操作序列的算法。</div>
                                <a href="${base}/QCode/brief/algorithm.html" class="libHref">查看详情 <i></i></a>
                            </div>

                        </li>
                    </ul>
                    <div class="LibraryAll"><a href="${base}/QCode/brief/welcome.html">更多教程 ></a></div>
                </div>
            </div>
            <div class="bookBox">
                <div class="book-tilte">
                    <h2>推荐阅读</h2>
                    <p>帮你深入学习量子计算</p>
                </div>
                <div class="book-con">
                    <div class="book-con-left">
                        <img src="${base}/assets/images/EduImg/icon_book.png" >
                        <div>
                            <h4>丰富的书籍</h4>
                            <h3>学术书籍</h3>
                        </div>
                    </div>
                    <div class="book-con-right">
                        <img src="${base}/assets/images/EduImg/icon_paper.png" alt="">
                        <div>
                            <h4>专业的量子</h4>
                            <h3>学术论文</h3>
                        </div>
                    </div>
                </div>
                <div>
                    <a style="color: #fff" href="${base}/EDU/Reading.html">查看详情 ></a>
                </div>
            </div>
            <div class="libContent">
                <div class="libList">
                    <div class="title">应用领域</div>
                    <div class="tip">量子技术在生活上的广泛应用</div>
                    <div class="libShuffling toolsContent">
                        <div class="libContainer toolsBox">
                            <div class="toolCollont">
                                <div class="toolsAll">
                                    <ul>
                                        <li class="active">
                                            <div class="jcTouY"></div>
                                            <img class="bgImg1" src="${base}/assets/images/tools1.jpg" alt="">
                                            <img class="bgImg2" src="${base}/assets/images/tools1_1.jpg" alt="">
                                            <div class="toolsBg1"></div>
                                            <div class="toolWang">
                                                <div class="toolsImgMin">
                                                    <img src="${base}/assets/images/toolsAi.png" alt="">
                                                </div>
                                                <div class="toolsBorder"></div>
                                                <div class="toolsName">人工智能</div>
                                                <div class="toolsJs">信息处理对改进人工智能机器学习至关重要，而量子计算机在完成这项任务上堪称完美。量子计算机可以分析大量数据，为人工智能机器提供提高性能所需的反馈。</div>
                                                <a class="toolsHref" href="${base}/tutorial/quantumApps.html?defaultIndex=1">查看详情</a>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="jcTouY"></div>
                                            <img class="bgImg1" src="${base}/assets/images/tools2.jpg" alt="">
                                            <img class="bgImg2" src="${base}/assets/images/tools2_1.jpg" alt="">
                                            <div class="toolsBg1"></div>
                                            <div class="toolWang">
                                                <div class="toolsImgMin">
                                                    <img src="${base}/assets/images/toolsSw.png" alt="">
                                                </div>
                                                <div class="toolsBorder"></div>
                                                <div class="toolsName">生物科技</div>
                                                <div class="toolsJs">量子技术在生物科技领域的应用也是如火如荼。通过量子计算机模拟得到分子相互作用以及化学反应的原理，从而在发现新材料，研制新型药物。</div>
                                                <a class="toolsHref" href="${base}/tutorial/quantumApps.html?defaultIndex=2">查看详情</a>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="jcTouY"></div>
                                            <img class="bgImg1" src="${base}/assets/images/tools3.jpg" alt="">
                                            <img class="bgImg2" src="${base}/assets/images/tools3_1.jpg" alt="">
                                            <div class="toolsBg1"></div>
                                            <div class="toolWang">
                                                <div class="toolsImgMin">
                                                    <img src="${base}/assets/images/toolsdata.png" alt="">
                                                </div>
                                                <div class="toolsBorder"></div>
                                                <div class="toolsName">数据处理</div>
                                                <div class="toolsJs">量子计算能提供我们解决那些超越传统计算机功能的复杂问题的能力。对于某些特定的计算任务而言，量子计算机的潜在计算速度比常规超级计算机要快得多。</div>
                                                <a class="toolsHref" href="${base}/tutorial/quantumApps.html?defaultIndex=3">查看详情</a>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="jcTouY"></div>
                                            <img class="bgImg1" src="${base}/assets/images/tools4.jpg" alt="">
                                            <img class="bgImg2" src="${base}/assets/images/tools4_1.jpg" alt="">
                                            <div class="toolsBg1"></div>
                                            <div class="toolWang">
                                                <div class="toolsImgMin">
                                                    <img src="${base}/assets/images/toolsSs.png" alt="">
                                                </div>
                                                <div class="toolsBorder"></div>
                                                <div class="toolsName">搜索引擎</div>
                                                <div class="toolsJs">利用量子新算法，避免不可控制的蛮力计算，使得机器学习更加的高效准确。因此，“神速”也是量子信息技术的另一大优势。</div>
                                                <a class="toolsHref" href="${base}/tutorial/quantumApps.html?defaultIndex=4">查看详情</a>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="jcTouY"></div>
                                            <img class="bgImg1" src="${base}/assets/images/tools5.jpg" alt="">
                                            <img class="bgImg2" src="${base}/assets/images/tools5_1.jpg" alt="">
                                            <div class="toolsBg1"></div>
                                            <div class="toolWang">
                                                <div class="toolsImgMin">
                                                    <img src="${base}/assets/images/toolsYs.png" alt="">
                                                </div>
                                                <div class="toolsBorder"></div>
                                                <div class="toolsName">物流运输</div>
                                                <div class="toolsJs">城市交通管制无论是在空中还是在地面上，量子计算的应用都有助于简化交通控制。它们将使用新的算法快速的计算最优路线，从而实现高效的调度，减少交通拥堵。</div>
                                                <a class="toolsHref" href="${base}/tutorial/quantumApps.html?defaultIndex=5">查看详情</a>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="libContent">
                <div class="libList develop">
                    <div class="title">未来发展</div>
                    <div class="tip">放眼未来，为你展示量子计算机的可能性</div>
                    <div class="libShuffling toolsContent">
                        <div class="libContainer">
                            <div class="developBox">
                                <div class="quotes">
                                    随着量子比特的增多，量子计算的潜力会得到更深的挖掘。然而，真正的容错量子计算仍有很长的路要走……
                                </div>
                                <div class="devLinkBox">
                                    <div class="developCon">
                                        <div class="title">量子计算机的未来在何方？</div>
                                        <div class="devConTips">所谓历史局限性，就是当人们考虑新生事物时总会按照旧有的思路，去寻求现有体系中它的替代与优化作用，而不曾想在未来开辟新的领域。</div>
                                        <div class="link">
                                            <a href="${base}/tutorial/quantumLooking.html">查看详情></a>
                                        </div>
                                    </div>
                                    <div class="developCon">
                                        <div class="title">为什么我们要建立量子云计算平台？</div>
                                        <div class="devConTips">由于量子计算机的体系是微观体系，对于温度带来的噪声干扰会非常的敏感。
                                            一旦噪声带来的影响与我们量子体系的能级间隔相当，就会对我们的实验结果造成极大的干扰。</div>
                                        <div class="link"><a href="${base}/tutorial/quantumCreate.html">查看详情></a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box" style="padding-top:80px;display: none ">
                <div class="news-list">
                    <dl>
                        <dt><h1>视频教程</h1></dt>
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
    <script type="text/javascript" src="${base}/assets/js/swiper.min.js"></script>
    <script type='text/javascript' src="${base}/assets/js/md5.js"></script>
    <script>
        var i;
        $(".toolsAll li").each(function () {
            if($(this).hasClass("active")){
                i=$(this).index()
            }
            if($(this).index()==0){
                $(this).css({"left":"0"})
            }else if($(this).index()==4){
                $(this).css({"left":"-100px"})
            }else if($(this).index()>i){
                $(this).css({"left":"-100px"})
            }
        })

        $(".toolsAll li").on("click",function () {
            $(".toolsAll li").attr("style","")
            i=$(this).index()
            if($(this).index()==0){
                $(this).css({"left":"0"})
            }
            if($(this).index()==4){
                $(this).css({"left":"-100px"})
            }
            $(this).addClass("active").siblings().removeClass("active");

            $(".toolsAll li").each(function () {
                if($(this).index()>i){
                    $(this).css({"left":"-100px"})
                }
            })
        });

        $(".toolsAll li").hover(function () {
            $(".toolsAll li").attr("style","")
            i=$(this).index()
            if($(this).index()==0){
                $(this).css({"left":"0"})
            }
            if($(this).index()==4){
                $(this).css({"left":"-100px"})
            }
            $(this).addClass("active").siblings().removeClass("active");

            $(".toolsAll li").each(function () {
                if($(this).index()>i){
                    $(this).css({"left":"-100px"})
                }
            })
        });
    </script>
</@main.footer>
