<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__hd t-center">
        <p class=" f333 f24">欢迎来到量子的世界</p>
        <p>Welcome To THE WORLD OF QUANTUM</p>
    </div>
    <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_text">
            <h4 class="weui-media-box__title cr3090e5 fb f22">简介</h4>
            <div class="weui-media-box__desc">
                <p class="f666">量子云计算平台是中国科学院量子信息重点实验室，固态量子计算研究组主导开发的，主要基于真实量子芯片的云计算服务。这是一个开放的平台，任何人都可以从这个平台获取以下服务。</p>
                <ul class="box f333">
                    <li>零基础学习量子计算的详细教程</li>
                    <li>OriginIR 量子语言编译</li>
                    <li>图形化量子计算编辑器</li>
                    <li>QEmulator 量子仿真计算</li>
                    <li>Semi-2Q和Spcd-6Q 量子计算原型机</li>
                </ul>
                <p class="f666">不论你是系统学习过量子计算的研究者，还是对“量子”一知半解甚至一无所知的门外汉，本教程都能为你提供一定的帮助。我们将从量子力学的基本概念讲起，去粗取精，力求用最简单的语言阐明量子计算的基本理论。若是你具备简单的矩阵运算基础，那么我们相信你是能完全读懂本教程的。本教程的编排如下：</p>
                <ul class="box f333">
                    <li>量子力学的简介</li>
                    <li>量子力学基本概念<br>这一部分中介绍了量子计算中需要用到的量子力学知识。我们将线性代数的知识迁移到量子力学中，使用矩阵表示量子态。</li>
                    <li>量子计算基本原理<br>这一部分中介绍我们是如何把量子力学应用在量子计算上的。主要介绍了量子逻辑门和量子线路的概念。</li>
                    <li>介绍几种量子算法<br>我们首先会介绍量子计算中最基础的算法——Deutsch-Jozsa算法，之后则是Grover搜索算法和Shor分解质因数算法。</li>
                    <li>Semi-2Q和Spcd-6Q 量子计算原型机</li>
                </ul>
            </div>
        </div>
        <div class="weui-media-box weui-media-box_text">
            <h4 class="weui-media-box__title cr3090e5 fb f22">FAQ</h4>
            <h4 class="weui-media-box__title f18 fb cr000">什么是量子计算机？</h4>
            <div class="weui-media-box__desc mb10">
                <p class="f666">量子计算机是由量子芯片（类比经典计算机中的CPU，如Intel Core i9-7900X）和外部测控系统（类比主板如Intel X299 Chipset）构成的计算系统。量子芯片是基于量子力学原理，以量子比特（类比高低电平）为基本单位构成的。量子比特是由一个物理系统的两个能级所构成的。量子比特的行为遵循量子规律。</p>
                <div class="t-center mt10 mb15">
                    <img src="${base}/assets/images/liang01.png" width="30%" />
                    <img src="${base}/assets/images/liang02.png" width="30%" />
                    <img src="${base}/assets/images/liang03.png" width="30%" />
                </div>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">为什么要研究量子计算机？</h4>
            <div class="weui-media-box__desc mb10">
                <p class="f666">最直接的理由：快！它是目前人类提出来的一个不同于冯·诺依曼体系的计算模型。由于量子态的叠加、纠缠等性质，使得这种计算模型理论上拥有指数级别的计算能力。自从P. Shor提出Shor算法，表明量子计算机能在有效时间内攻击RSA密钥体系之后，量子计算机的实现就一直是热门的研究方向。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">量子计算机是如何制造出来的？</h4>
            <div class="weui-media-box__desc mb10">
                <p class="f666">不同于绝大多数基于硅的经典计算机，在各种各样的体系之中，各个研究组都在尝试量子计算机的实现。这里面有离子阱、线性光学系统、超导体系、半导体体系等等。每一种都有其特殊的制造方法。但是无论哪一种，现在都只制造出来了仅有几个量子比特的体系，离真正完整的量子计算机还有很大距离。</p>
            </div>
        </div>
    </div>
</div></#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("欢迎来到量子世界");
	App.dragRefresh();
});
</script>
</@main.footer>