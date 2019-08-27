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
<div class="content" style="min-width:1336px;">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
<!--box-->
<div class="box" style="padding:0 20px 0px 20px; margin-top:0px;width:100%">
    <div class="algContent">
        <@NewLeft title="量子算法"></@NewLeft>
        <div class="algRight">
            <div class="algRight_con">
                <div class="algRight_box">
                    <div class="jcTitle">文章导读目录:</div>
                    <div class="jcIndexList">
                        <ul>
                            <li class="active">
                                <a href="#one">量子态</a>
                            </li>
                            <li>
                                <a href="#two">量子叠加性</a>
                            </li>
                            <li>
                                <a href="#three">测量和坍缩</a>
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
                        <a href="${base}/QCode/library.html">教程</a> <span>></span>
                        <a href="javascript:;">教程文档</a>
                        <span>></span>
                        <span>量子世界</span>
                    </div>
                </div>
                <div class="news-box" >
                    <h1 class="blue">量子世界 Quantum World</h1>
                    <em>我完全明白对于一个非物理专业的人而言，量子力学概念复杂、难学。有一个好消息是，我们只用去了解量子力学的一些简单概念加上一点数学的东西，甚至说不用理解薛定谔方程，就可以开始量子计算机的应用。这就像我们不用去了解CPU的工作原理，但是我们也能日常使用或者编写程序一样。</em>
                    <em id="one">一章里面，我会彻底抛弃数学公式，仅仅去介绍宽泛的概念，目的只是想让任何一个人都能了解“量子究竟是什么”这个问题。如果说你只见过地球上的江山美景，希望你能过来看看，在这无限细分、无限微小的原子里面，还有着另一片奇伟瑰怪的世界。</em>
                    <em >如果你不想被量子的诡异事实毁三观，而且你对于自己的线性代数很有自信的话，你可以直接跳入下一章，我们会在那里进行一些纯粹的计算。</em>
                    <h2>量子态 Quantum State</h2>
                    <em>简而言之，量子态就是一个微观粒子的状态。</em>
                    <em>我们描述一个粒子的状态时，总要找一些能够用来区分微观粒子的属性。就比如说我在一栋楼的1楼，就叫做“1态”，在2楼，就叫做“2态”，在地下一层，就叫做“-1态”，依次类推。微观粒子也有这样的属性，比如它的位置。</em>
                    <em>但是有时候，我正在上楼梯，进入到一个模糊的状态，这样我们就不太容易区分我到底是在“1态”还是“2态”，这时候我们需要找一些客观实在的参数去描述这一方面的属性，比如我所处的海拔。通常，在我们的日常生活中，这些描述都是连续的，因为这些参数能被分割成更小的部分。</em>
                    <em>然而，无限分割下去，到了我们不得不靠“几个原子”这种单位去描述物体的长度时，量子效应就出场了。薛定谔方程告诉我们，我们一定会遇到不可分割的最小单位。这种最小单位，我们统称为量子，这种现象，我们称为<strong>量子化</strong>。这是量子的<strong>第一个特性</strong>。</em>
                    <em>量子化的属性有很多种。但是这里我们先只考虑一个——能量。人们探索得知，原子的光谱只会有几个峰值，而不是连续的谱线，这代表了原子内电子的能量只会出现几种情况，电子不可能具有几种情况之外的中间值，这就是能量的量子化。每一种能量，我们称之为一个“<strong>能级</strong>”。</em>
                    <em>继续以一栋楼作为例子，在微观的世界里面，这栋楼的楼梯被拆掉了，这使得我要么在一楼，要么在二楼，只能在整数的楼层。但是，这不代表我就失去了上下楼的手段。这里就是量子的<strong>第二个特性</strong>——<strong>跃迁</strong>。</em>
                    <em>当一个原子中的电子获得了来自原子外的能量时，它就有可能克服能级之间能量的差距，跳到另外一个态上面。当然这个电子也可以将自己的能量释放出来，跳到能量较低的能级上面。当然，能级本身是稳定的，不管怎么跃迁，电子的能量都只能处在这几个能级上，这是原则。
                    </em>
                    <em id="two">最后，回到这一节的标题。什么是量子态呢？想象一下电子处在不同的楼层上面，我们给这些楼层命名称之为 $|1F\rangle$,$|2F\rangle$,$|3F\rangle$……，这样就可以区分出来不同的量子态。能想象到这种情形，你已经明白了什么是量子态了。尽管真实情况比我所说的复杂多了，但是至少现在，这些足矣。</em>
                    <h2>量子叠加性 Quantum Superposition</h2>
                    <em>如果只是把能级建成大楼，然后把大楼的楼梯、电梯全拆掉，（并且不问为什么会这样的话，）这件事情倒也不难理解。然而接下来的部分，我们就没办法用一般的现实去想象了。</em>
                    <em><strong>量子叠加性</strong>是量子的<strong>第三个特性</strong>。不管是出于什么契机，你大概应该听说过薛定谔的猫这个故事。故事的最后告诉我们：猫处于生与死的叠加态。什么是生与死的叠加态？既生又死？人间与冥界的夹缝之间？实际上这个故事是关于量子叠加性的一个有争议的思想实验。在解释这个故事之前，我们要先解释一点量子的东西。</em>
                    <em>首先，我们必须接受一个概念，就是量子的世界里面，同时存在几个状态是可能的。就像这栋楼里面的每个人，在不去观察他们时，他们就在所有楼层同时存在。这就是量子叠加性。</em>
                    <em>糟糕！写到这里时，我注意到这个比喻不是那么恰当。就算在现实生活中，我们也没法知道一栋大楼里面任何一个人的位置，最多知道他在办公桌上坐着的概率比较大而已。那是不是这样就是量子叠加性呢？很遗憾，并不是。量子叠加不是一种“概率性”存在，事实上，对于量子本身，它就是“同时存在”于很多状态的叠加上。</em>
                    <em>尽管这个概念多么的古怪、反直觉、难以置信，但是我不想和任何人有哲学上的辩论，而是希望你能承认它是对的。我们的量子计算机就是建立在这个原理之上。此外，无数的实验证明，当物体小到分子原子电子那个级别的时候，叠加是客观存在的，尽管<strong>没有人</strong>知道为什么。</em>
                    <em>为什么我们感受不到叠加性？如果每个粒子都有这种叠加性，那是不是作为粒子组合的人也应该具有叠加性呢？</em>
                    <em id="two-4">并不是。因为我们是由一个巨大的量的粒子构成的集合体。一个粒子虽然是叠加的，但是一群粒子就能开始体现统计的平均性。就像我们连续扔一百次硬币，还是稍微有可能出现全部是正面的情况。但是扔一亿次硬币的时候，（如果你不在硬币上面做手脚，）我们会得到一个趋于稳定的结果——正反面各一半。何况我们每个人身体里的粒子比一亿还要多几亿倍的几亿倍（差不多有27 $\sim$ 28位数那么多）。所以我们是绝无可能有叠加性的。</em>
                    <h2 id="three">测量和坍缩 Measurement And Collapse</h2>
                    <em>薛定谔宣称，不打开盒子，猫就处于生和死的“叠加态”（关于叠加态上面已经提到过了）。之后，他下一句话是：“当我们打开盒子，经过了我们的观察，猫就会坍缩到一个确定的生、死状态上”。
                    </em>
                    <em>事情又变得麻烦了。什么叫做“观察”之后“坍缩”到确定的状态上？难道不是这个装置而是第一个看到猫的人决定了猫的生死吗？</em>
                    <em>这里我们就要提出量子的<strong>第四个特性</strong>：“<strond>测量和坍缩假设</strond>”。测量和坍缩对量子态的影响仍然是一个争议话题，所以我这里用了“假设”。这个特性的描述如下：</em>
                    <em>对于一个叠加态而言，我们可以去测量它。测量的结果一定是这一组量子化之后的，确定的，分立的态之中的一个。测量得到任意的态的概率是这个叠加态和测量态的内积的平方。测量之后，叠加态就会坍缩到这个确定的态之上。</em>
                    <em>尽管看起来复杂，但简单的来说就是如果在一个人处在1楼和2楼叠加态的话，我们只能测出来他在1楼或者2楼，这个概率是由他们的叠加权重决定的。但是一旦我测出来之后，他就不再是原来那个既在1楼又在2楼的他了，而是处在一个确定的状态（1楼或者2楼）。我们的测量影响了这个粒子本身的状态。</em>
                    <em>如果看了上面一节，你已经接受了叠加本身是一种客观存在的事情了。那么测量、观察这种主观的事情是如何影响到客观的叠加的？可能你又会一头雾水了。</em>
                    <em>比较主流的理论是说因为微观粒子太小，测量仪器本身会对这个粒子产生一定的影响，导致粒子本身发生了变化。但是我们没有足够的证据证明这种说法。</em>
                    <em>回到薛定谔的猫上面来。薛定谔之所以提出这个思想实验，是想让宏观事物——猫，和微观事物——放射性原子建立“纠缠”，从而把量子力学的诡异现象从微观世界引到现实世界中来。“如果我们承认微观粒子具有这些“叠加“、”坍缩“的性质的话，那猫也具有了”——这是薛定谔的思想。关于这个问题，也没有确切的证据证明猫不是处于这样的状态。
                    </em>

                </div>
            </div>
        </div>

    </div>





    <div class="news-content" style="width:68%;display: none">
        <div class="news-text">
            <div class="news-box" >
                <h1 class="blue">量子世界 Quantum World</h1>
                <em>我完全明白对于一个非物理专业的人而言，量子力学概念复杂、难学。有一个好消息是，我们只用去了解量子力学的一些简单概念加上一点数学的东西，甚至说不用理解薛定谔方程，就可以开始量子计算机的应用。这就像我们不用去了解CPU的工作原理，但是我们也能日常使用或者编写程序一样。</em>
                <em id="one">一章里面，我会彻底抛弃数学公式，仅仅去介绍宽泛的概念，目的只是想让任何一个人都能了解“量子究竟是什么”这个问题。如果说你只见过地球上的江山美景，希望你能过来看看，在这无限细分、无限微小的原子里面，还有着另一片奇伟瑰怪的世界。</em>
                <em >如果你不想被量子的诡异事实毁三观，而且你对于自己的线性代数很有自信的话，你可以直接跳入下一章，我们会在那里进行一些纯粹的计算。</em>
                <h2>量子态 Quantum State</h2>
                <em>简而言之，量子态就是一个微观粒子的状态。</em>
                <em>我们描述一个粒子的状态时，总要找一些能够用来区分微观粒子的属性。就比如说我在一栋楼的1楼，就叫做“1态”，在2楼，就叫做“2态”，在地下一层，就叫做“-1态”，依次类推。微观粒子也有这样的属性，比如它的位置。</em>
                <em>但是有时候，我正在上楼梯，进入到一个模糊的状态，这样我们就不太容易区分我到底是在“1态”还是“2态”，这时候我们需要找一些客观实在的参数去描述这一方面的属性，比如我所处的海拔。通常，在我们的日常生活中，这些描述都是连续的，因为这些参数能被分割成更小的部分。</em>
                <em>然而，无限分割下去，到了我们不得不靠“几个原子”这种单位去描述物体的长度时，量子效应就出场了。薛定谔方程告诉我们，我们一定会遇到不可分割的最小单位。这种最小单位，我们统称为量子，这种现象，我们称为<strong>量子化</strong>。这是量子的<strong>第一个特性</strong>。</em>
                <em>量子化的属性有很多种。但是这里我们先只考虑一个——能量。人们探索得知，原子的光谱只会有几个峰值，而不是连续的谱线，这代表了原子内电子的能量只会出现几种情况，电子不可能具有几种情况之外的中间值，这就是能量的量子化。每一种能量，我们称之为一个“<strong>能级</strong>”。</em>
                <em>继续以一栋楼作为例子，在微观的世界里面，这栋楼的楼梯被拆掉了，这使得我要么在一楼，要么在二楼，只能在整数的楼层。但是，这不代表我就失去了上下楼的手段。这里就是量子的<strong>第二个特性</strong>——<strong>跃迁</strong>。</em>
                <em>当一个原子中的电子获得了来自原子外的能量时，它就有可能克服能级之间能量的差距，跳到另外一个态上面。当然这个电子也可以将自己的能量释放出来，跳到能量较低的能级上面。当然，能级本身是稳定的，不管怎么跃迁，电子的能量都只能处在这几个能级上，这是原则。
                </em>
                <em id="two">最后，回到这一节的标题。什么是量子态呢？想象一下电子处在不同的楼层上面，我们给这些楼层命名称之为 $|1F\rangle$,$|2F\rangle$,$|3F\rangle$……，这样就可以区分出来不同的量子态。能想象到这种情形，你已经明白了什么是量子态了。尽管真实情况比我所说的复杂多了，但是至少现在，这些足矣。</em>
                <h2>量子叠加性 Quantum Superposition</h2>
                <em>如果只是把能级建成大楼，然后把大楼的楼梯、电梯全拆掉，（并且不问为什么会这样的话，）这件事情倒也不难理解。然而接下来的部分，我们就没办法用一般的现实去想象了。</em>
                <em><strong>量子叠加性</strong>是量子的<strong>第三个特性</strong>。不管是出于什么契机，你大概应该听说过薛定谔的猫这个故事。故事的最后告诉我们：猫处于生与死的叠加态。什么是生与死的叠加态？既生又死？人间与冥界的夹缝之间？实际上这个故事是关于量子叠加性的一个有争议的思想实验。在解释这个故事之前，我们要先解释一点量子的东西。</em>
                <em>首先，我们必须接受一个概念，就是量子的世界里面，同时存在几个状态是可能的。就像这栋楼里面的每个人，在不去观察他们时，他们就在所有楼层同时存在。这就是量子叠加性。</em>
                <em>糟糕！写到这里时，我注意到这个比喻不是那么恰当。就算在现实生活中，我们也没法知道一栋大楼里面任何一个人的位置，最多知道他在办公桌上坐着的概率比较大而已。那是不是这样就是量子叠加性呢？很遗憾，并不是。量子叠加不是一种“概率性”存在，事实上，对于量子本身，它就是“同时存在”于很多状态的叠加上。</em>
                <em>尽管这个概念多么的古怪、反直觉、难以置信，但是我不想和任何人有哲学上的辩论，而是希望你能承认它是对的。我们的量子计算机就是建立在这个原理之上。此外，无数的实验证明，当物体小到分子原子电子那个级别的时候，叠加是客观存在的，尽管<strong>没有人</strong>知道为什么。</em>
                <em>为什么我们感受不到叠加性？如果每个粒子都有这种叠加性，那是不是作为粒子组合的人也应该具有叠加性呢？</em>
                <em id="two-4">并不是。因为我们是由一个巨大的量的粒子构成的集合体。一个粒子虽然是叠加的，但是一群粒子就能开始体现统计的平均性。就像我们连续扔一百次硬币，还是稍微有可能出现全部是正面的情况。但是扔一亿次硬币的时候，（如果你不在硬币上面做手脚，）我们会得到一个趋于稳定的结果——正反面各一半。何况我们每个人身体里的粒子比一亿还要多几亿倍的几亿倍（差不多有27 $\sim$ 28位数那么多）。所以我们是绝无可能有叠加性的。</em>
                <h2 id="three">测量和坍缩 Measurement And Collapse</h2>
                <em>薛定谔宣称，不打开盒子，猫就处于生和死的“叠加态”（关于叠加态上面已经提到过了）。之后，他下一句话是：“当我们打开盒子，经过了我们的观察，猫就会坍缩到一个确定的生、死状态上”。
                </em>
                <em>事情又变得麻烦了。什么叫做“观察”之后“坍缩”到确定的状态上？难道不是这个装置而是第一个看到猫的人决定了猫的生死吗？</em>
                <em>这里我们就要提出量子的<strong>第四个特性</strong>：“<strond>测量和坍缩假设</strond>”。测量和坍缩对量子态的影响仍然是一个争议话题，所以我这里用了“假设”。这个特性的描述如下：</em>
                <em>对于一个叠加态而言，我们可以去测量它。测量的结果一定是这一组量子化之后的，确定的，分立的态之中的一个。测量得到任意的态的概率是这个叠加态和测量态的内积的平方。测量之后，叠加态就会坍缩到这个确定的态之上。</em>
                <em>尽管看起来复杂，但简单的来说就是如果在一个人处在1楼和2楼叠加态的话，我们只能测出来他在1楼或者2楼，这个概率是由他们的叠加权重决定的。但是一旦我测出来之后，他就不再是原来那个既在1楼又在2楼的他了，而是处在一个确定的状态（1楼或者2楼）。我们的测量影响了这个粒子本身的状态。</em>
                <em>如果看了上面一节，你已经接受了叠加本身是一种客观存在的事情了。那么测量、观察这种主观的事情是如何影响到客观的叠加的？可能你又会一头雾水了。</em>
                <em>比较主流的理论是说因为微观粒子太小，测量仪器本身会对这个粒子产生一定的影响，导致粒子本身发生了变化。但是我们没有足够的证据证明这种说法。</em>
                <em>回到薛定谔的猫上面来。薛定谔之所以提出这个思想实验，是想让宏观事物——猫，和微观事物——放射性原子建立“纠缠”，从而把量子力学的诡异现象从微观世界引到现实世界中来。“如果我们承认微观粒子具有这些“叠加“、”坍缩“的性质的话，那猫也具有了”——这是薛定谔的思想。关于这个问题，也没有确切的证据证明猫不是处于这样的状态。
                </em>

            </div>
        </div>
    </div>

    <div class="news-rights" style="display: none">
        <div class="rh"><h4><strong>章节</strong></h4></div>
        <ul>
            <li class="n-cur">
                <a href="#one">
                    <h5>量子态 <p class="f12 f999">Quantum State</p></h5>
                </a>
            </li>
            <li class="">
                <a href="#two">
                    <h5>量子叠加性 <p class=" f12 f999">Quantum Superposition</p></h5>
                </a>
            </li>
            <li class="">
                <a href="#three">
                    <h5>测量和坍缩 <p class=" f12 f999 ">Measurement And Collapse</p></h5>
                </a>
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
        $("#world").addClass('active').siblings().removeClass('active')
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
