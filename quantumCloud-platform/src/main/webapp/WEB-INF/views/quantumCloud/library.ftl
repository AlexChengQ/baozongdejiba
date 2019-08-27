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
            <!--top end-->
            <!--box-->
            <div class="banner" style="position: relative;"><img src="${base}/assets/images/libraries.jpg" alt="" style="width:100%;">
                <div class="libraries-title">
                    <p class="name">教程</p>
                    <#--<p class="name"><@spring.message code="tutorial" /></p>-->
                    <p >欢迎使用量子云平台，我们为您提供了详细的云平台教程，您也可以通过视频教程的学习来提高使用熟练程度。</p>
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
            <div class="vidContent">
                <div class="vidList">
                    <div class="title" id="2">视频教程</div>
                    <div class="tip">帮助你快速了解量子云计算平台以及量子算法</div>
                    <div class="vidListTab">
                        <div class="vidTabContent">
                            <div class="vidClass">
                                <div class="vidClassName">教程分类</div>
                                <div class="vidClassList">
                                    <ul>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <ul class="vidlisUser clearfix">

                        <div class="videoBox"></div>

                    </ul>
                    <div class="LibraryAll VideoAll"><a href="${base}/QCode/videoLibrary.html">更多视频 ></a> </div>
                </div>
            </div>
            <div class="libContent">
                <div class="libList">
                    <div class="title" id="3">教程案例</div>
                    <div class="tip">通过案例学习，轻松掌握量子计算云平台使用技巧</div>
                    <div class="libShuffling">
                        <div class="libContainer libContainerBox">
                            <ul class="caseUser swiper-wrapper">
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（1/8）</div>
                                        <div class="case_name">随机数生成</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#0" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（2/8）</div>
                                        <div class="case_name">D-J Algorithm</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#1" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（3/8）</div>
                                        <div class="case_name">Mayer-Penny Game in Quantum</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#2" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（4/8）</div>
                                        <div class="case_name">Swap Test 算法</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#3" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（5/8）</div>
                                        <div class="case_name">Simon 算法</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#4" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（6/8）</div>
                                        <div class="case_name">Bernstein-Vazirani Algorithm 算法</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#5" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（7/8）</div>
                                        <div class="case_name">HHL算法</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#6" class="case_href">查看详情</a>
                                    </div>
                                </li>
                                <li class="lis_case swiper-slide">
                                    <div class="case_details">
                                        <div class="case_title">教程案例（8/8）</div>
                                        <div class="case_name">Counterfeit Coin Game</div>
                                        <a href="${base}/QCode/LibAlgorithm.html#7" class="case_href">查看详情</a>
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
                                    <#--<div class="vidPageTool">-->
                                    <#--<a href="javascript:void (0)">上一页</a>-->
                                    <#--<a href="javascript:void (0)">1</a>-->
                                    <#--<a href="javascript:void (0)">2</a>-->
                                    <#--<a href="javascript:void (0)">3</a>-->
                                    <#--<a href="javascript:void (0)">下一页</a>-->
                                    <#--</div>-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="libContent" style="margin-bottom: 150px">
                <div class="libList">
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
                                        <div class="link"><a href="${base}/tutorial/quantumWhy.html">查看详情></a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <style>
                .vjs-user-inactive .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -30px;}
                .vjs-user-active .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -30px;}
            </style>
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
    <link rel="stylesheet" href="${base}/assets/css/swiper.css">
    <script type="text/javascript" src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${base}/assets/js/swiper.min.js"></script>
    <script type='text/javascript' src="${base}/assets/js/md5.js"></script>
    <script>
        var videoData=[
            {name:"全部",link:"",classify:"0"},
            {name:"基础板块",link:"",classify:"1"},
            {name:"工具板块",link:"",classify:"2"},
            {name:"编程部分",link:"",classify:"3"},
            // {name:"应用部分",link:"",classify:"4"},
            {name:"硬件介绍",link:"",classify:"4"},
            {name:"科大教程",link:"",classify:"5"},
            {name:"学术报告",link:"",classify:"6"}
        ]
        var vidDetails=[
            [
                {link:"Basic/BasicKnowledgeQuantumMechanics.mp4",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
                {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
                {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
                {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
                {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
                {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
                {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
                {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
                {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
                {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
                {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
                {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
                {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
                //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
                //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源QRunes编程",time:""},
                {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.4 本源QPanda 2介绍",time:"06:01"},
                {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.4 本源QPanda的安装与配置",time:"06:58"},
                {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.5 本源QPanda 2的编程教学1",time:"09:17"},
                {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.6 本源QPanda 2的编程教学2",time:"06:08"},
                {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
                {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
                {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
                {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
                {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"},
                {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
                {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
                {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
                {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
                {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
                {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
                {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
                {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
                {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"}
            ],
            [
                //{link:"",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
                {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
                {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
                {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
                {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
            ],
            [
                {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
                {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
                {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
                {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
                {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
                {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
                {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
            ],
            [
                {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
                //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
                //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源QRunes编程",time:""},
                {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.4 本源QPanda 2介绍",time:"06:01"},
                {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.4 本源QPanda的安装与配置",time:"06:58"},
                {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.5 本源QPanda 2的编程教学1",time:"09:17"},
                {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.6 本源QPanda 2的编程教学2",time:"06:08"}
            ],
            [
                {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
                {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
                {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
                {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
                {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"}
            ],
            [
                {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
                {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
                {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
                {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
                {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
                {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
                {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
                {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
                {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"}

            ],
            [
                {link:"http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4",img:"${base}/assets/images/video/report1.jpg",name:"1. 学术报告",time:"1:02:05"},
            ],
            <#--[-->
            <#--{link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},-->
            <#--]-->
        ]

        var vidHtml =''
        videoData.forEach(function (value,i) {
            if(i==0){
                vidHtml +=' <li class="active" data-classify='+i+'><span>'+value.name+' <i></i></span></li>'
            }else {
                vidHtml +=' <li data-classify='+i+'><span>'+value.name+' <i></i></span></li>'
            }
        })
        function vidHtmls(link,img,name,time) {
            return '<li ontouchstart="videoPlay(this)" onclick="videoPlay(this)"><div class="vid_screenshot" data-value='+link+'><img src="'+img+'" alt=""></div><div class="vid_js"><span>'+name+'</span>' +
                '<span class="right">'+time+'</span></div><div class="vidHover"></div><div class="vidHoverImg"><img src="" alt=""></div></li>'
        }
        $(".OptionList").html(vidHtml)
        $(".vidClassList ul").html(vidHtml)
        var vidDetailsHtml =''
        $("body").on("click",'.vidClassList ul li',function () {
            vidDetailsHtml ='';
            $(this).addClass("active").siblings().removeClass("active");
            var l=0;
            vidDetails[$(this).attr("data-classify")].forEach(function (value) {
                if(l<8){
                    vidDetailsHtml +=vidHtmls(value.link,value.img,value.name,value.time);
                }
                l++
            })
            $(".vidlisUser").html(vidDetailsHtml)
        })
        $('.vidClassList ul li').eq(0).click();
        var NewSwiper = new Swiper('.libContainerBox', {
            slidesPerView: 3,
            spaceBetween: 20,
            loop: true,
            navigation: {nextEl: '.LibNext', prevEl: '.LibPrev'}
        })
        var progressFlag;
        function getTools() {
            (function(window, document){
                // 获取要操作的元素
                var video = document.getElementById("my_video_1_html5_api");
                wx.config({
                    // 配置信息, 即使不正确也能使用 wx.ready
                    debug: false,
                    appId: '',
                    timestamp: 1,
                    nonceStr: '',
                    signature: '',
                    jsApiList: []
                });
                var videoControls = document.getElementsByClassName("vjs-control-bar")[0];
                var videoContainer = document.getElementById("videoplayer");
                var controls = document.getElementById("video_controls");
                var playBtn = document.getElementsByClassName("vjs-play-control")[0];
                var fullScreenBtn = document.getElementsByClassName("vjs-fullscreen-control")[0];
                var progressWrap = document.getElementsByClassName("vjs-progress-control")[0];
                var playProgress = document.getElementsByClassName("vjs-play-progress")[0];
                // var showProgress = document.getElementsByClassName("vjs-play-progress")[0];
                var fullScreenFlag = false;

                $("body").find("#box-close").on("click",function () {
                    clearInterval(progressFlag)
                    $("#videoplayer_overlay").remove()
                })
                // 创建我们的操作对象，我们的所有操作都在这个对象上。
                var videoPlayer = {
                    init: function(){
                        var that = this;
                        video.removeAttribute("controls");
                        bindEvent(video, "loadeddata", videoPlayer.initControls);
                        videoPlayer.operateControls();
                        getProgress()
                    },
                    initControls: function(){
                        video.play();
                        videoPlayer.showHideControls();
                        progressFlag = setInterval(getProgress, 60);
                    },
                    showHideControls: function(){
                        bindEvent(video, "mouseover", showControls);
                        bindEvent(videoControls, "mouseover", showControls);
                        bindEvent(video, "mouseout", hideControls);
                        bindEvent(videoControls, "mouseout", hideControls);
                    },
                    operateControls: function(){
                        bindEvent(playBtn, "click", play);
                        bindEvent(video, "click", play);
                        bindEvent(fullScreenBtn, "click", clickFullScreen);
                        bindEvent(progressWrap, "mousedown", videoSeek);
                    }
                }
                videoPlayer.init();
                // 原生的JavaScript事件绑定函数
                function bindEvent(ele, eventName, func){
                    if(window.addEventListener){
                        ele.addEventListener(eventName, func);
                    }
                    else{
                        ele.attachEvent('on' + eventName, func);
                    }
                }
                // 显示video的控制面板
                function showControls(){
                    $(".video-js").addClass("vjs-user-active");
                    $(".video-js").removeClass("vjs-user-inactive");
                }
                // 隐藏video的控制面板
                function hideControls(){
                    // 为了让控制面板一直出现，我把videoControls.style.opacity的值改为1
                    $(".video-js").removeClass("vjs-user-active");
                    $(".video-js").addClass("vjs-user-inactive");
                }
                // 控制video的播放
                function play(){
                    clearInterval(progressFlag);
                    if ( video.paused || video.ended ){
                        if ( video.ended ){video.currentTime = 0;}
                        video.play();
                        $(this).addClass("vjs-playing")
                        $("body").find(".video-js").addClass("vjs-playing")
                        $(this).removeClass("vjs-paused")
                        $("body").find("#my_video_1_html5_api").paused = false;
                        $("body").find("#my_video_1_html5_api").get(0).play();
                        progressFlag = setInterval(getProgress, 60);
                    }
                    else{
                        video.pause();
                        $(this).removeClass("vjs-playing")
                        $("body").find(".video-js").removeClass("vjs-playing")
                        $(this).addClass("vjs-paused");
                        $("body").find("#my_video_1_html5_api").paused = true;
                        $("body").find("#my_video_1_html5_api").get(0).pause()
                        clearInterval(progressFlag);
                    }
                }
                // 控制video是否全屏
                function clickFullScreen(){
                    $(this).parents('#my_video_1').fullScreen();
                    $(".vjs-play-control").addClass("vjs-playing");
                    var w=null;
                    clearTimeout(w)
                    if(!flagTime){
                        w=setTimeout(function () {
                            $("body").find("#my_video_1_html5_api").get(0).play()
                        },300)
                    }
                }
                // video的播放条
                function getProgress(){
                    var percent = video.currentTime / video.duration;
                    playProgress.style.width = (percent * (progressWrap.offsetWidth)-2)+"px";
                    var min=parseInt(video.duration/60)
                    var seconds=parseInt(video.duration%60)
                    if(seconds>=10){
                        seconds=parseInt(video.duration%60)
                    }else {
                        seconds='0'+parseInt(video.duration%60)
                    }

                    var PlayMin=parseInt(video.currentTime/60);
                    var PlaySeconds=(video.currentTime%60).toFixed(0)
                    if(PlaySeconds>=10){
                        PlaySeconds=(video.currentTime%60).toFixed(0)
                    }else {
                        PlaySeconds='0'+(video.currentTime%60).toFixed(0)
                    }
                    var PlayTime=PlayMin+":"+PlaySeconds;
                    var time=min+":"+seconds;
                    $("#timesID").html(PlayTime+"/"+time)
                }
                // 鼠标在播放条上点击时进行捕获并进行处理
                function videoSeek(e){
                    if(video.paused || video.ended){
                        play();
                        enhanceVideoSeek(e);
                    }
                    else{
                        enhanceVideoSeek(e);
                    }

                };
                //定位时间
                function enhanceVideoSeek(e){
                    var percent=0;
                    var length=0;
                    clearInterval(progressFlag);
                    length = e.pageX - progressWrap.offsetLeft-$("#videoplayer_outer_container").position().left;

                    if(document.fullscreen || document.mozFullScreen || document.webkitIsFullScreen){
                        length=length+$("#videoplayer_outer_container").position().left;
                        percent = length / progressWrap.offsetWidth;
                    }else {
                        percent = length / progressWrap.offsetWidth-0.03;
                    }
                    playProgress.style.width = percent * (progressWrap.offsetWidth)  + "px";
                    video.currentTime = percent * video.duration;
                    progressFlag = setInterval(getProgress, 60);
                };
            }(this, document));

        }

        var i;
        $(".toolsAll li").each(function () {
            if($(this).hasClass("active")){i=$(this).index()}
            if($(this).index()==0){$(this).css({"left":"0"})
            }else if($(this).index()==4){$(this).css({"left":"-100px"})
            }else if($(this).index()>i){$(this).css({"left":"-100px"})}
        })

        $(".toolsAll li").on("click",function () {
            $(".toolsAll li").attr("style","")
            i=$(this).index()
            if($(this).index()==0){$(this).css({"left":"0"})}
            if($(this).index()==4){$(this).css({"left":"-100px"})}
            $(this).addClass("active").siblings().removeClass("active");
            $(".toolsAll li").each(function () {
                if($(this).index()>i){$(this).css({"left":"-100px"});}
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
