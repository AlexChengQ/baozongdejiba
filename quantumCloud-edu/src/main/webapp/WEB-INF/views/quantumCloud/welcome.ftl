<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<#escape x as x?html>
<#include "../common/left.ftl">
<@mathjax></@mathjax>
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<!--top-->
    <@main.top5>
        <#escape x as x?html>
        </#escape>
    </@main.top5>
<!--top end-->
<div class="content" style="min-width:1336px;">

<!--box-->
    <style>
        .Edu_box{
            background: #282828;
        }
        .Edu_default{
            background: #282828;
        }
    </style>
<div class="box" style="padding:0 20px 0px 20px; margin-top:0px;width:100%">
    <div class="algContent">
        <@NewLeft title="欢迎来到量子的世界"></@NewLeft>
        <div class="algRight">
            <div class="algRight_con">
                <div class="algRight_box">
                    <div class="jcTitle">文章导读目录:</div>
                    <div class="jcIndexList">
                        <ul>
                            <li class="active">
                                <a href="#one">简介</a>
                            </li>
                            <li>
                                <a href="#two">FAQ</a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="algCenter">

            <div class="news-text">
                <div class="indexes_con">
                    <div class="indexes_box">
                        <a href="${base}/EDU/library.html">教程</a> <span>></span>
                        <a href="javascript:void (0)">教程文档</a>
                        <span>></span>
                        <span>欢迎来到量子的世界</span>
                    </div>
                </div>
                <div id="one"></div>
                <div class="news-title">
                    <span class="f30 t-text f333 block">欢迎来到量子的世界</span>
                    <span class="f14 t-text f999 block p-t-6"  id="one-1">Welcome To The World Of Quantum</span>
                </div>
                <div class="news-box">
                    <h1 class="blue"><@spring.message code="brief_introduction" /></h1>
                    <em>
                        量子云计算平台是一个主要基于真实量子芯片的云计算服务，它是一个开放的平台，任何人都可以从这个平台获取以下服务：
                    </em>
                    <div class="four-box">
                        <ul>
                            <li>零基础学习量子计算的详细教程</li>
                            <li>OriginIR 量子语言编译</li>
                            <li>图形化量子计算编辑器</li>
                            <li>QEmulator 量子仿真计算</li>
                            <li>Semi-2Q和Spcd-6Q 量子计算原型机</li>
                        </ul>
                    </div>
                    <em>不论你是系统学习过量子计算的研究者，还是对“量子”一知半解甚至一无所知的门外汉，本教程都能为你提供一定的帮助。</em>
                    <em>我们将从量子力学的基本概念讲起，去粗取精，力求用最简单的语言阐明量子计算的基本理论。若是你具备简单的矩阵运算基础，那么我们相信你是能完全读懂本教程的。</em>
                    <em>本教程的编排如下：</em>
                    <div class="four-box">
                        <ul>
                            <li>量子力学的简介</li>
                            <li>量子力学基本概念</br>
                                这一部分中介绍了量子计算中需要用到的量子力学知识。我们将线性代数的知识迁移到量子力学中，使用矩阵表示量子态。
                            </li>
                            <li>
                                量子计算基本原理</br>
                                这一部分中介绍我们是如何把量子力学应用在量子计算上的。主要介绍了量子逻辑门和量子线路的概念。
                            </li>
                            <li>介绍几种量子算法</br>
                                我们首先会介绍量子计算中最基础的算法——Deutsch-Jozsa算法，之后则是Grover搜索算法和Shor分解质因数算法。
                            </li>
                            <!-- <li id="two">量子云计算平台使用指南</br>
                                如果你已经明白该如何去搭建一个量子线路，那么便发挥你的想象力，开始属于你的量子之旅吧。
                            </li> -->
                        </ul>
                    </div>
                </div>
                <div class="news-box" id="two">
                    <h1 class="blue">FAQ</h1>
                    <h2 class="f18 f000">什么是量子计算机？</h2>
                    <em >量子计算机是由量子芯片（类比经典计算机中的CPU，如Intel Core i9-7900X）和外部测控系统（类比主板如Intel X299 Chipset）构成的计算系统。量子芯片是基于量子力学原理，以量子比特（类比高低电平）为基本单位构成的。量子比特是由一个物理系统的两个能级所构成的。量子比特的行为遵循量子规律。</em>
                    <em class="liangZiPic">
                        <img src="${base}/assets/images/liang01.png" width="206" height="200">
                        <img src="${base}/assets/images/liang02.png" width="196" height="100">
                        <img src="${base}/assets/images/liang03.png" width="190" height="200">
                    </em>
                    <h2 class="f18 f000">为什么要研究量子计算机？</h2>
                    <em >最直接的理由：快！它是目前人类提出来的一个不同于冯·诺依曼体系的计算模型。由于量子态的叠加、纠缠等性质，使得这种计算模型理论上拥有指数级别的计算能力。自从P. Shor提出Shor算法，表明量子计算机能在有效时间内攻击RSA密钥体系之后，量子计算机的实现就一直是热门的研究方向。</em>
                    <h2 class="f18 f000">量子计算机是如何制造出来的？</h2>
                    <em>不同于绝大多数基于硅的经典计算机，在各种各样的体系之中，各个研究组都在尝试量子计算机的实现。这里面有离子阱、线性光学系统、超导体系、半导体体系等等。每一种都有其特殊的制造方法。但是无论哪一种，现在都只制造出来了仅有几个量子比特的体系，离真正完整的量子计算机还有很大距离。</em>
                    <!-- <h2 class="f18 f000">你们的量子计算机是何种体系？它有何优点？</h2>
                    <em>超导体系。超导体系的优点在于它的制造工艺继承了现今的半导体工艺，相对易于制造并且工艺是稳定的；扩展性好，能以一个相似的模式在一个芯片上扩展更多的量子比特；操控简单，仅采用微波进行操控，波形单一。</em> -->
                </div>
            </div>
        </div>

    </div>
    <div class="news-content" style="width:68%;display: none">
        <div class="news-text">
            <div id="one"></div>
            <div class="news-title">
                <span class="f30 t-text f333 block">欢迎来到量子的世界</span>
                <span class="f14 t-text f999 block p-t-6"  id="one-1">Welcome To The World Of Quantum</span>
            </div>
            <div class="news-box">
                <h1 class="blue"><@spring.message code="brief_introduction" /></h1>
                <em>
                    	量子云计算平台是一个主要基于真实量子芯片的云计算服务，它是一个开放的平台，任何人都可以从这个平台获取以下服务：
                </em>
                <div class="four-box">
                    <ul>
                        <li>零基础学习量子计算的详细教程</li>
                        <li>OriginIR 量子语言编译</li>
                        <li>图形化量子计算编辑器</li>
                        <li>QEmulator 量子仿真计算</li>
                        <li>Semi-2Q和Spcd-6Q 量子计算原型机</li>
                    </ul>
                </div>
                <em>不论你是系统学习过量子计算的研究者，还是对“量子”一知半解甚至一无所知的门外汉，本教程都能为你提供一定的帮助。</em>
                <em>我们将从量子力学的基本概念讲起，去粗取精，力求用最简单的语言阐明量子计算的基本理论。若是你具备简单的矩阵运算基础，那么我们相信你是能完全读懂本教程的。</em>
                <em>本教程的编排如下：</em>
                <div class="four-box">
                    <ul>
                        <li>量子力学的简介</li>
                        <li>量子力学基本概念</br>
                            这一部分中介绍了量子计算中需要用到的量子力学知识。我们将线性代数的知识迁移到量子力学中，使用矩阵表示量子态。
                        </li>
                        <li>
                            量子计算基本原理</br>
                            这一部分中介绍我们是如何把量子力学应用在量子计算上的。主要介绍了量子逻辑门和量子线路的概念。
                        </li>
                        <li>介绍几种量子算法</br>
                            我们首先会介绍量子计算中最基础的算法——Deutsch-Jozsa算法，之后则是Grover搜索算法和Shor分解质因数算法。
                        </li>
                        <!-- <li id="two">量子云计算平台使用指南</br>
                            如果你已经明白该如何去搭建一个量子线路，那么便发挥你的想象力，开始属于你的量子之旅吧。
                        </li> -->
                    </ul>
                </div>
            </div>
            <div class="news-box" id="two">
                <h1 class="blue">FAQ</h1>
                <h2 class="f18 f000">什么是量子计算机？</h2>
                <em >量子计算机是由量子芯片（类比经典计算机中的CPU，如Intel Core i9-7900X）和外部测控系统（类比主板如Intel X299 Chipset）构成的计算系统。量子芯片是基于量子力学原理，以量子比特（类比高低电平）为基本单位构成的。量子比特是由一个物理系统的两个能级所构成的。量子比特的行为遵循量子规律。</em>
                <em class="liangZiPic">
                    <img src="${base}/assets/images/liang01.png" width="206" height="200">
                    <img src="${base}/assets/images/liang02.png" width="196" height="100">
                    <img src="${base}/assets/images/liang03.png" width="190" height="200">
                </em>
                <h2 class="f18 f000">为什么要研究量子计算机？</h2>
                <em >最直接的理由：快！它是目前人类提出来的一个不同于冯·诺依曼体系的计算模型。由于量子态的叠加、纠缠等性质，使得这种计算模型理论上拥有指数级别的计算能力。自从P. Shor提出Shor算法，表明量子计算机能在有效时间内攻击RSA密钥体系之后，量子计算机的实现就一直是热门的研究方向。</em>
                <h2 class="f18 f000">量子计算机是如何制造出来的？</h2>
                <em>不同于绝大多数基于硅的经典计算机，在各种各样的体系之中，各个研究组都在尝试量子计算机的实现。这里面有离子阱、线性光学系统、超导体系、半导体体系等等。每一种都有其特殊的制造方法。但是无论哪一种，现在都只制造出来了仅有几个量子比特的体系，离真正完整的量子计算机还有很大距离。</em>
                <!-- <h2 class="f18 f000">你们的量子计算机是何种体系？它有何优点？</h2>
                <em>超导体系。超导体系的优点在于它的制造工艺继承了现今的半导体工艺，相对易于制造并且工艺是稳定的；扩展性好，能以一个相似的模式在一个芯片上扩展更多的量子比特；操控简单，仅采用微波进行操控，波形单一。</em> -->
            </div>

        </div>
    </div>
    <div class="news-rights" style="display:none;">
        <div class="rh"><h4><strong>章节</strong></h4></div>
        <ul>
            <li class="n-cur">
                <a href="#one"><h5>简介</h5></a>
            </li>
            <li class="">
                <a href="#two"><h5>FAQ</h5></a>
            </li>

        </ul>
    </div>

<!--box end-->
</div>

</div>
</#escape>
</@main.body>
<@main.footer>
<script>
    $(document).ready(function() {
        $(".algCenter").css({"margin-right":$(".algRight").width()})
        $("#welcome").addClass('active').siblings().removeClass('active')
        t = $('.fixed').offset().top;
        $(window).scroll(function(){
            s = $(document).scrollTop();
            if(s > t - 10){
                $('.fixed').css('position','fixed');
                $('.fixed').css('left','auto');
                $(".algRight").css('position','relative');
                $(".algRight").css('top','80px');
                // $(".algRight").css('right','50px');
//                $('.fixed').css('left','14px');
//                $('.news-content').css('margin-left','16%');
                if(s){
                    $('.fixed').css('top','10px');
                }
            }else{
                $('.fixed').css('position','absolute');
                $('.fixed').css('top','0');
                $('.news-content').css('margin-left','');
                $(".algRight").css('position','relative');
                $(".algRight").css('top','80px');
                $(".algRight").css('right','0');

            }
        });




        $('.jcIndexList ul li').click(function () {
            $(this).addClass('active').siblings().removeClass('active')
        })
    });
</script>
</@main.footer>
