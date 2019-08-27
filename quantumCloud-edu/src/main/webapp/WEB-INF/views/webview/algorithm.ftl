<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header title="量子算法-Quantum Algorithm">
<#escape x as x?html>
<#include "../common/left.ftl">
<@mathjax></@mathjax>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<script>
    if( window.location.href.indexOf("app=1")>-1){
        window.location.href=window.location.href.replace("webview","brief")
    }
</script>
<div class="content" style="min-width:1200px;overflow: hidden;">

<!--box-->
    <style>
        .Edu_box{
            background: #282828;
        }
        .Edu_default{
            background: #282828;
        }
        .algCenter{
            margin: 0;
            padding: 0;

        }
        .algContent{
            margin: 0 auto;
        }
        .content{
            min-width: auto;
        }
        body{
            min-width: auto;
        }
        .box .algContent{
            width: auto;
        }
        .alt_n2_border{
            width: auto;
        }
        .alt-n2-flex{
            display: block;
        }
        .alt-ne-f1 table{
            margin: 0 auto;
        }
        .alt-ne-f1{
            margin-right: auto;
        }
        p{
            overflow-x: scroll;
        }
        /*.news-box em{*/
            /*font-size: 11px;*/
        /*}*/
        @media (max-width: 1200px){
            body .content {
                max-width: auto!important;
                min-width: auto!important;
            }
        }
    </style>
<div class="box" style="font-size11px;margin-top:0px;width:100%">
    <div class="algContent">
        <div class="algCenter">

            <div class="news-text">

                <div id="loading"><h4>加载中，请稍后....</h4></div>
                <div class="news-box" style="opacity:0">
                    <h1 class="blue">量子算法 Quantum Algorithm</h1>
                    <em id="one">量子算法是以量子态作为输入，量子逻辑门作为操作序列的算法。对于n个量子比特的系统，由于态的叠加和相位的存在，相当于会有 $2^n$ 那么多的独立分量。此时，每一个门操作都会涉及到所有分量的同时变化，所以量子计算机具有（随量子比特数目的增长）指数级增长的运算能力。</em>
                    <h2>Deutsch-Jozsa算法 Deutsch-Jozsa Algorithm</h2>
                    <em>首先介绍一种最简单的量子算法，Deutsch-Jozsa算法。</em>
                    <em>D-J算法是一种经过设计的情况，它证明了量子算法相对于经典算法有指数级别的加速能力。D-J算法的问题描述是这样的：</em>
                    <em>如果你具有一个黑盒子，黑盒子里面是一些逻辑门，这个黑盒子可以接受n位的输入，并且产生一个1位的输出。并且我们已知黑盒子有两种可能性：</em>
                    <em>1、对于所有的输入，它只输出0或者1——我们称之为“常数”；</em>
                    <em>2、恰好对于一半的输入，输出为0，另一半输入，输出为1——我们称之为“平衡”。问题是：对于一个随机的盒子，要区分盒子到底是“平衡”的还是“常数”的。注意，我们不考虑这两种情况之外的输出分布情况，例如对于一个2位输入的黑盒子，输入00输出0，而输入01,10,11都输出1，此时它既不属于“平衡”也不属于“常数”，故被排除到了讨论之外。
                    </em>
                    <em>如果在经典计算的角度上去看，我们要一个一个地检查输出的情况。因为输入是n位的，所以一共具有 $2^n$ 种情况（每位上都是0/1两种可能）。不需要检查所有的情况来验证它到底是哪一种盒子，但是最坏的情况下，你检查了一半的情况（ $2^{n-1}$ ），得到了一样的结果，例如全为0。这时，你需要再检查一种情况，如果它是0，那么一定是“常数”的；如果它是1，那么一定是“平衡”的。</em>

                    <em>其中Target_Function就是这个黑盒子，而bitNum代表输入比特个数。</em>
                    <em>然而，量子计算机只需要通过一步运算就可以得到结果。</em>
                    <em style="text-align:center">
                        <img src="${base}/assets/images/a.png" />
                    </em>
                    <em>如图：是这个过程的量子算法线路图。图中H代表Hadamard门，Oracle就是这个黑盒子。Readout表示在这里对量子比特进行测量。下面对整个过程进行理论分析。</em>
                    <em>第一步，制备n个工作（Working）比特到 $|0\rangle$ 态，与一个辅助（Ancillary）比特到 $|1\rangle$。</em>
                    <em>第二步，所有比特都经过Hadamard变换到叠加态上。由Hadamard门和量子态的矩阵形式，我们可得</em>
                    <em  style="overflow-x: scroll">
                        $$\begin{align*}
                        H|0\rangle&=\frac{1}{\sqrt{2}}\left(\begin{matrix}
                        1&&1\\
                        1&&-1
                        \end{matrix}
                        \right)
                        \left(\begin{matrix}
                        1\\
                        0
                        \end{matrix}\right)=\frac{1}{\sqrt{2}}\left(\begin{matrix}
                        1\\
                        1
                        \end{matrix}\right)
                        H|1\rangle&=\frac{1}{\sqrt{2}}\left(\begin{matrix}
                        1&&1\\
                        1&&-1
                        \end{matrix}
                        \right)
                        \left(\begin{matrix}
                        0\\
                        1
                        \end{matrix}\right)=\frac{1}{\sqrt{2}}\left(\begin{matrix}
                        1\\
                        -1
                        \end{matrix}\right)
                        \end{align*}$$
                    </em>
                    <em>我们发现 $1/\sqrt{2}$ 是个很让人讨厌的系数，而且它在整个操作过程中也只会出现在所有表达式的最外面，所以接下来的计算里面我们忽略归一化条件。忽略这个系数不会影响矩阵分量之间的比例关系，所以忽略它完全不会受到影响。除非我们马上要开始计算概率了，这个时候我们再去对矩阵做归一化就行了。</em>
                    <em>那么简化的描述就变成了</em>
                    <em >
                        $$\begin{align*}
                        H: \quad |0\rangle &\rightarrow |0\rangle+|1\rangle\\
                        \quad |1\rangle &\rightarrow |0\rangle-|1\rangle
                        \end{align*}$$
                    </em>
                    <em>此时我们可以将所有的n个工作比特直积起来。回顾直积的定义，我们将两个工作比特直积起来</em>
                    <em  style="overflow-x: scroll">
                        $$\begin{align*}
                        (|0\rangle+|1\rangle)\otimes(|0\rangle+|1\rangle)&=|00\rangle+|01\rangle+|10\rangle+|11\rangle
                        &=|0\rangle+|1\rangle+|2\rangle+|3\rangle
                        \end{align*}$$
                    </em>
                    <em>
                        第二个等式单纯是二进制到十进制的转换。这样我们就得到了2位量子态所有情况的和。并且所有的相位项都为1。在此基础上再直积一个 $|0\rangle+|1\rangle$，就得到了3位量子态所有情况的和，即 $0\sim 7$ ……最后，一直直积n次，就可以得到 $0\sim 2^n-1$ 的态之和。这样，我们得到所有比特的共同量子态表达式为
                    </em>
                    <em style="overflow-x: scroll">
                        $$|\text{Working}\rangle|\text{Ancilla}\rangle=\left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\rangle-|1\rangle\right)$$
                    </em>
                    <em>第三步，将这个系统通过代表这个黑盒子的Oracle。Oracle是一种酉变换，它具有如下的形式</em>
                    <em>$\text{Oracle}:\quad |x\rangle|y\rangle\rightarrow |x\rangle|y\oplus f(x)\rangle$</em>
                    <em>（如果你不能理解为什么Oracle要写成这种形式，请看下一章“Oracle是什么”。）</em>
                    <em>Oracle中的 $f(x)$ 是n位输入，1位输出的函数，也就是这个黑盒子的函数形式。其中 $\oplus$ 代表模2加法（异或）。所以，将量子态通过Oracle的时候，我们会得到：</em>
                    <em style="overflow-x: scroll">
                        $$\begin{align*}
                        \text{Oracle}&:\quad|\text{Working}\rangle|\text{Ancilla}\rangle
                        &\rightarrow \left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\oplus f(x)\rangle-|1\oplus f(x)\rangle\right)
                        &=\ \left(\sum_{x=0}^{2^n-1} (-1)^{f(x)}|x\rangle\right)\left(|0\rangle-|1\rangle\right)
                        \end{align*}$$
                    </em>
                    <em>意即 $f(x)=1$ 时，这一项会使 $|0\rangle-|1\rangle \rightarrow |1\rangle-|0\rangle$，即附带了一个-1的相位。当 $f(x)=0$ 时，不附带这个相位。</em>
                    <em>
                        第四步，丢弃辅助比特，仅对前面的n个工作比特全部执行Hadamard操作。如果所有的  $f(x)$ 都具有相同的值，那么工作比特将继续保持所有分量的相位一致（全为1或者-1）；如果 $f(x)$ 具有一半0一半1的输出，那么工作比特将有一半的分量为1，另一半的分量为-1。
                    </em>
                    <em>
                        简单而言，如果Oracle是常数的，那么经过Oracle前后，量子态不会发生任何变化，此时将工作比特全部通过Hadamard门操作，必然会返回到初始的态（全部为 $|0\rangle$ )。如果Oracle是平衡的，那么经过Oracle前后，量子态会变成和初态不同的态，再经过Hadamard门之后，必然不会得到初始态。（之所以要求0和1必须恰好各为一半，是为了保证此时量子态在初始态上面的概率分量为0，详见下面数学描述）
                    </em>
                    <em>
                        此时对所有比特进行测量。如果我们测到所有的量子比特都在0上，说明黑盒子是常数的。否则说明黑盒子是平衡的。
                    </em>
                    <em>下面对这个过程进行数学描述。</em>
                    <em>任意基矢态（非叠加态）的Hadamard变换形式如下</em>
                    <em>
                        $$H^{\otimes n}|x\rangle=\sum_{x=1}^{2^n-1}(-1)^{x\cdot y} |y\rangle$$
                    </em>
                    <em>
                        其中 $x\cdot y$ 代表按位或操作。将它带入到上面的表达式中，可得
                    </em>
                    <em style="overflow-x: scroll">
                        $$\begin{align*}
                        H^{\otimes n}\left(\sum_{x=0}^{2^n-1} (-1)^{f(x)}|x\rangle\right)&=\sum_{x=0}^{2^n-1} (-1)^{f(x)}\sum_{y=0}^{2^n-1}(-1)^{x\cdot y}|y\rangle
                        &=\sum_{x,y=0\sim 2^n-1}(-1)^{f(x)+x\cdot y}|y\rangle
                        \end{align*}$$
                    </em>
                    <em>因为我们仅考察测量结果是否全部为0，所以令 $|y\rangle=|0\rangle^{\otimes n}$，计算这个分量上的系数，即</em>
                    <em style="overflow-x: scroll">
                        $$P(y=0)=|\sum_{x=0}^{2^n-1}(-1)^{f(x)}|^2=\begin{cases}
                        1\quad f(x)\text{为常数}\\
                        0\quad f(x)\text{为平衡}\\
                        \end{cases}$$
                    </em>
                    <em>所以要么概率为1，要么概率正好一半一半抵消掉变成0。至此就是D-J算法的完全描述。我们发现量子算法的不同点在于它向黑盒子内部输入的是叠加态，所以只需要一步计算就能得到问题的答案。</em>
                    <em style="text-align:center">
                        <img src="${base}/assets/images/liang05.png"/>
                    </em>
                    <em>经典算法的验证次数是  $O(2^n)$ 的，量子算法算上叠加态的准备和测量的时间，需要的操作步骤为 $O(n)$。所以我们说明量子算法相对于经典算法具有指数级别加速的特性。</em>
                    <em id="two">D-J算法的问题在于它解决的问题既不实用，又具有很大的限制（要求平衡函数中必须恰好为一半0一半1）。另外，我们还对黑盒子本身的形态有要求。所以说D-J算法的理论意义是远大于其实用意义的。真正实用的量子算法将在后面进行介绍。</em>
                    <h2 >Oracle是什么？</h2>
                    <em>在介绍其它的量子算法之前，我们要对Oracle进行一些必要的说明。</em>
                    <em>最早在图灵的博士论文中，提到了一种新的计算模型：
                        “假定我们拥有某种解决数论问题的未知方法；比如说某种谕示。我们不深入这个谕示的本质，除了它不可能是一台机器这一点。通过谕示的帮助，我们可以构筑一种新的机器，它的基本过程之一就是解决某个给定的数论问题。”</em>
                    <em>图灵的这一段话描述的“谕示”即为Oracle。因为Oracle本身就能解决某种问题，在我们不深入Oracle本身时，我们可以通过Oracle扩展我们的计算能力。</em>
                    <em>这里的D-J算法，包括其它的某些量子算法都借用了图灵提到的这种新模型：谕示机。这里的Oracle是一种酉变换。它通常具有下面的两种形式：</em>
                    <em style="overflow-x: scroll">
                        $$\begin{align*}
                        \text{Oracle}:\quad |x\rangle|y\rangle&=|x\rangle|y+f(x)\rangle
                        |x\rangle|y\rangle&=|x\rangle|y\cdot f(x)\rangle
                        \end{align*}$$
                    </em>
                    <em>注意：第一，这里的乘法不是按位乘法而是普通乘法。第二，在讨论这里的 $|x\rangle$,$|y\rangle$ 代表的量子态时，并没有指定它们的位数。但是无论是加法还是乘法，它们的运算也是要做取模运算的（不存在溢出的情况）。</em>
                    <em>不论是哪种形式，都是在一组量子态为
                        $|x\rangle$
                        时将函数 $f(x)$ 的值引入到另一个和它并列的一组量子态中。我们在讨论包含Oracle的算法时，我们都会假定Oracle能在一个单位时间内输出“谕示”内容的黑盒子——就像D-J算法中描述的那样。它内部的量子线路究竟如何，我们是不关心的。</em>
                    <em>
                        但是也有另一种情况——我们要通过函数的解析表达式将一个函数用量子线路表达出来。这一种就像是分析Oracle的“内部构造”。虽然一般来说它具有和Oracle相同的酉变换形式，但是不能被看作一个单位时间内能告诉你“谕示”内容的黑盒子，所以它的构造方式决定了它的执行时间。我们称这种构造为“量子函数(Quantum function)”。
                    </em>
                    <em   id="three">
                        接下来的部分，我们会举两个相对实用的量子算法的例子。其中一个是用了一个代表数据库的Oracle，然后进行搜索的Grover算法；另一个是用量子线路构建“量子函数”，解决质因数分解问题的Shor算法。
                    </em>
                    <h2>Grover搜索算法 Grover's Searching Algorithm</h2>
                    <!--<em>Grover算法假定了一个数据库模型，它具有如下形式：</em>-->
                    <!--<em>-->
                    <!--<img src="http://latex.codecogs.com/gif.latex?  \begin{cases}-->
                    <!--f(x)=0\quad x\neq x_0\\-->
                    <!--f(x)=1\quad x=x_0-->
                    <!--\end{cases}" />-->
                    <!--</em>-->
                    <!--<em>-->
                    <!--其中 <img src="http://latex.codecogs.com/gif.latex?x_0" /> 代表一个未知的数据库索引。即除了在这个索引时取值为1之外，其它的取值都为0。类似于D-J算法，这个数据库是以一个Oracle给出的，即-->
                    <!--</em>-->
                    <!--<em>-->
                    <!--<img src="http://latex.codecogs.com/gif.latex?\text{Oracle} \quad |x\rangle|y\rangle\rightarrow|x\rangle|y\oplus f(x)\rangle" />-->
                    <!--</em>-->
                    <!--<em>-->
                    <!--\subsection{Shor算法质因数分解 Shor's Algorithm For Factoring}-->
                    <!--</em>-->

                    <div id="wmd-preview" class="wmd-preview f16 f666" style="text-align: left;">
                        <div class="md-section-divider"></div>
                        <p data-anchor-id="japo">接下来，我们介绍一种更有实用意义的算法，Grover搜索算法。 <br>
                            什么是搜索算法呢？举一个简单的例子，在下班的高峰期，我们要从公司回到家里。开车走怎样的路线才能够耗时最短呢？我们最简单的想法，当然是把所有可能的路线一次一次的计算，根据路况计算每条路线所消耗的时间，最终可以得到用时最短的路线，即为我们要找的最快路线。这样依次的将每一种路线计算出来，最终对比得到最短路线。搜索的速度与总路线数N相关，记为 $O(N)$
                            。而采用量子搜索算法，则可以以 $O\left(\sqrt N\right)$ 的速度进行搜索，要远快于传统的搜索算法。
                        </p>
                        <p data-anchor-id="lkvw">
                            那么我们怎么实现Grover搜索算法呢？ <br>
                            首先，我们先化简一下搜索模型。我们将所有数据存在数据库中，假设我们有n个量子比特，用来记录数据库中的每一个数据的索引，一共可以表示  $2^n$
                            个数据，记为N个。我们希望搜索得到的数据有M个。为了表示一个数据是否我我们搜索的结果。我们建立一个函数：
                            $$f(x)=\left\{
                            \begin{aligned}
                            & 0 &  (x\neq x_0)  \\
                            &1& (x=x_0) \\
                            \end{aligned}
                            \right.$$
                            其中 $x_0$ 为我们的搜索目标的索引值。也就是说，当我们搜索到我们的目标时，我们的函数值 $f(x)$ 置为1，如果搜索的结果不是我们的目标时，$f(x)$ 置为0。
                        </p>
                        <p data-anchor-id="2fvr">
                            接下来，我们假设有一个量子Oracle可以识别搜索问题的解，是别的结果通过Oracle的一个量子比特给出。我们可以将Oracle定义为
                            $$|x\rangle|q\rangle\xrightarrow{Oracle} |x\rangle|q\bigoplus f(x)\rangle$$
                            其中 $|q\rangle$ 是一个结果寄存器,$\bigoplus$
                            是二进制加法，通过Oracle，我们可以实现，当搜索的索引为我们的目标结果时，结果寄存器翻转；反之，结果寄存器值不变。从而我们可以通过判断结果寄存器的值，来确定搜索的对象是否为我们要的目标值。
                        </p>
                        <p data-anchor-id="crq5">
                            如此描述Oracle有些抽象，Oracle对量子态的具体操作是什么样的呢？同D-J算法相似，我们先将初态制备在
                            $|0\rangle^{\bigotimes n}|1\rangle$态上，$|0\rangle^{\bigotimes n}$ 为查询寄存器，$|1\rangle$为结果寄存器。
                            经过Hardmard门操作后，可以将查询寄存器的量子态，变为所有结果的叠加态。换句话说，经过了Hardmard门，我们就可以得到所有结果的索引。而结果寄存器则变为  $\frac{|0\rangle-|1\rangle}{\sqrt{2}}$
                            接下来，使其通过Oracle，可以对每一个索引都进行一次检验，如果是我们的目标结果，则将答案寄存器的量子态进行0、1翻转，即答案寄存器变为
                            $\frac{|1\rangle-|0\rangle}{\sqrt{2}}=-\frac{|0\rangle-|1\rangle}{\sqrt{2}}$
                            ，而查询寄存器不变。而当检验的索引不是我们要求的结果时，寄存器均不发生改变。因此，Oracle可以换一种表示方式
                            $$|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})\xrightarrow{\text{Oracle}}\\(-1)^{f(x)}|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})$$
                            其中，$|x\rangle$ 是查询寄存器的等额叠加态中的一种情况。 <br>
                            也就是说，Oracle的作用，是通过改变了解的相位，标记了搜索问题的解。
                        </p>
                        <p data-anchor-id="kxqs">
                            现在，我们已经将搜索问题的解通过相位标记区分出来了。那么如何能够将量子态的末态变为已标记出的态呢？
                        </p>
                        <p data-anchor-id="674v">
                            我们将问题换一种思路进行考虑。我们知道，当查询寄存器由初态经过Hardmard门后，会变为所有可能情况的等额叠加态。也就是说，它包含着所有搜索问题的解与非搜索问题的解。我们将这个态记为
                            $$|\psi\rangle=\frac{1}{\sqrt{N}} \sum\limits_{x}|x\rangle$$

                            我们将所有非搜索问题的解定义为一个量子态 $|\alpha\rangle$ ,其中$\sum\nolimits_{x_1}$ 代表着 $x$ 上所有非搜索问题的解的和。 <br>
                            $$|\alpha\rangle=\frac{1}{\sqrt{N-M}} \sum\limits_{x_1}|x\rangle$$

                            同理，我们将所有搜索问题的解定义为一个量子态 $|\beta\rangle$,其中 $\sum\nolimits_{x_2}$ 代表着 $x$ 上所有搜索问题的解的和。
                            $$|\beta\rangle=\frac{1}{\sqrt{M}} \sum\limits_{x_2}|x\rangle$$
                        </p>

                        <p data-anchor-id="adn1">显然，$|\beta\rangle$
                            为我们期望的最终的量子态，而且 $|\alpha\rangle$ 和 $|\beta\rangle$ 相互正交。利用简单的代数运算，我们就可以将初态 $|\psi\rangle$ 重新表示为
                            $$|\psi\rangle=\sqrt{\frac{N-M}{N}}|\alpha\rangle+\sqrt{\frac{M}{N}}|\beta\rangle$$
                        </p>

                        <p data-anchor-id="768g">
                            也就是说，我们用搜索问题的解的集合和非搜索问题的解的集合，重新定义了初始态换句话说，我们的初态属于 $|\alpha\rangle$ 与 $|\beta\rangle$
                            张成的空间。因此，我们可以用平面向量来表示这三个量子态，如图。
                        </p>
                        <p data-anchor-id="x3cb" style="text-align:center">
                            <img src="http://static.zybuluo.com/fcky123/gow8ur8m1885pv36zpr30tce/Grover.png" alt="图片" style="width:250px;">
                        </p>
                        <p data-anchor-id="oa9z">那么，Oracle作用在新的表示方法下的初态会产生怎样的影响呢？</p>
                        <p data-anchor-id="m4ik">我们知道，Oracle的作用是用负号标记搜索问题的解，因此相当于将 $|\beta\rangle$
                            内每一个态前均增加一个负号，将所有的负号提取出来，可以得到：
                            $$|\psi\rangle\xrightarrow{\text{Oracle}}\sqrt{\frac{N-M}{N}}|\alpha\rangle-\sqrt{\frac{M}{N}}|\beta\rangle$$
                            对应在平面向量中，相当于将 $|\psi\rangle$ 做关于 $|\alpha\rangle$ 轴的对称。
                        </p>
                        <p data-anchor-id="tyqj">但是，仅仅有这一种操作，是无法将量子态从 $|\psi\rangle$ 变为 $|\beta\rangle$。我们还需要另一种对称操作。</p>
                        <p data-anchor-id="7u55">第二种对称操作，是将量子态关于$|\psi\rangle$ 对称的操作。这个操作由三个部分构成。 <br>
                            1、将量子态经过一个Hardmard门。 <br>
                            2、对量子态进行一个相位变换，将 $|0\rangle^{\bigotimes n} $态的系数保持不变，将其他的量子态的系数增加一个负号。相当于 $2|0\rangle\langle0|-I$ 酉变换算子。 <br>
                            3、再经过一个Hardmard门。 <br>
                            这三步操作的数学表述为
                            $$H^{\bigotimes n}(2|0\rangle\langle0|-I)\\H^{\bigotimes n}=2|\psi\rangle\langle\psi|-I$$
                            <br>
                            上述过程涉及到复杂的量子力学知识，如果你不理解，没关系。你只需要知道，这三部分的操作，只是为了实现将量子态关于$|\psi\rangle$
                            对称即可。如果你想了解为什么这三步操作可以实现，可以阅读关于量子计算相关书籍进一步理解。
                        </p>
                        <p data-anchor-id="nxch">
                            前面介绍的两种对称操作，合在一起称为一次Grover迭代。假设初态$|\psi\rangle$与 $|\alpha\rangle$ 可以表示为
                            $$|\psi\rangle=cos\frac{\theta}{2}|\alpha\rangle+sin{\frac{\theta}{2}}|\beta\rangle$$
                        </p>
                        <p>
                            对比$(7)$ 式，很容易得到，
                            $$cos\frac{\theta}{2}=\sqrt{\frac{N-M}{N}}$$
                        </p>
                        <p>
                            可以从几何图像上看到，每一次Grover迭代，可以使量子态逆时针旋转 $\theta$。经历了k次Grover迭代，末态的量子态为：
                            $$G^k|\psi\rangle=cos(\frac{2k+1}{2}\theta)|\alpha\rangle+\\sin(\frac{2k+1}{2}\theta)|\beta\rangle$$
                        </p>
                        <p id="four">
                            因此，经过多次迭代操作，总可以使末态在$|\beta\rangle$ 态上概率很大，满足精确度的要求。经过严格的数学推导，可证明，迭代的次数R满足
                            $$R\leq\frac{\pi}{4}\sqrt{\frac{N}{M}}$$
                        </p>
                        <h2>Shor算法质因数分解 Shor's Algorithm For Factoring</h2>
                        <em>
                            将两个质数乘起来，例如907*641=581387，是一件小学生都能做到的事情，用计算机去处理，看起来也没有什么难度。但是如果我给你581387，让你去找它的质因数，问题就变得很复杂了。也许你可以用计算机一个一个的去尝试，但是当数字变得更大，达到成百上千位的时候，就连计算机也无能为力。世界上面有很多问题都是这样，难以找到答案，但是一旦找到答案就很容易去验证。类似的问题我们称之为NP问题。NP问题之所以难于处理，是因为它的时间复杂度往往具有指数级别。这意味着随着问题规模的线性扩大，需要的时间却是指数增长的。利用这个原理，人们创造了RSA算法，它利用大数难以分解，但是易于验证的原理，对数据进行有效的加密。
                        </em>
                        <em>
                            量子计算机有将问题指数加速的能力，那是否意味着能攻克所有的NP问题呢？很遗憾，不能。但是幸运的是，我们有能力把“质因数分解”的时间复杂度降低到多项式级别，使大数分解问题的解决变为可能。这就是Shor算法。Shor算法的提出意味着RSA密钥的安全性受到了挑战。下面我们就来介绍Shor算法的内容。
                        </em>
                        <h2>问题的转化</h2>
                        <em>
                            Shor算法首先将质因数分解问题转换成了一个子问题，下面我们来看问题的转换过程。假设我们待分解的数为 $N$，
                        </em>
                        <em>STEP 1：随机取一个正整数$ {1}<{a}<{N}$，定义一个函数: $f(x)=a^x\ mod\ N$
                        </em>
                        <em>
                            STEP 2：这个函数一定是一个周期函数，寻找到它的周期为 $r$。（这一步将使用量子计算机完成）
                        </em>
                        <em>STEP 3：如果 $r$ 为奇数，那么回到STEP 1。如果 $r$ 为偶数，那么计算 $f(r/2)$。</em>
                        <em>
                            STEP 4：如果 $f(r/2)=-1$，那么回到STEP 1。否则，计算
                            $f(r/2)+1$ 和 $f(r/2)-1$ 分别对于N的最大公约数。
                        </em>
                        <em>
                            STEP 5：这两个最大公约数就是 $N$ 的两个质因数
                        </em>
                        <em>举个例子，对于21而言，假设我们选择 $a=2$，那么</em>
                        <em>STEP 1：定义函数 $f(x)=2^x\ mod\ N$</em>
                        <em>STEP 2：发现它的周期为6。</em>
                        <em>STEP 3：计算出 $f(3)=8$ </em>
                        <em>STEP 4：计算7和9分别对于21的最大公因数 $\text{gcd}(7,21)=7$， $\text{gcd}(9,21)=3$</em>
                        <em>检验知7和3都是21的质因数，于是我们得到了问题的答案。</em>
                        <h2>函数的引入</h2>
                        <em>我们要为STEP 1中描述的函数找到它引入量子计算机的方式。这种函数被称为模指数（Modular Exponential）函数，在经典逻辑电路中，它已经被以各种形式设计了出来。所以现在，我们要为它准备一个量子线路的版本。</em>
                        <em>根据在“Oracle是什么”这一节里面提到的量子函数概念，我们需要构建出一个酉变换U使得：</em>
                        <em>
                            $$U|x\rangle|y\rangle=|x\rangle|y\cdot a^x (mod N)\rangle$$
                        </em>
                        <em>这种情况是一种比较普适的情况，我们令 $y=1$，那么后面的这一组量子比特就作为辅助比特存储了 $f(x)$ 的计算结果。我们先来找一种比较简单的情况来分析具体问题，可以便于对其中的变量分解转换的理解。选取要分解的质因数15，和一个比15小的任意正整数7，所以我们要构建这样的酉变换：</em>
                        <em>
                            $$U|x\rangle|1\rangle=|x\rangle|7^x (mod 15)\rangle$$
                        </em>
                        <em>
                            首先要提到的一点是要表示  $7^x (mod 15)\rangle$，就意味着我们的辅助比特的取值是从0~14的，为了表示这个数，需要用到4个比特，即从0000~1110。对于前面的工作比特来说，它的位数选择比较自由，而且选取的位数越多，我们得到正确结果的概率越大，这一点在后面会解释。
                        </em>
                        <em>乍一看这个函数让我们有些无从下手，所以我们要对它进行一定的转换，比如先把x转化为二进制：</em>
                        <em style="overflow-x: scroll">
                            $$7^x=7^{x_0+2x_1+2^2x_2+...}=7^{x_0}\cdot(7^2)^{x_1}\cdot(7^4)^{x_2}...\cdot(7^{2^n})^{x_n}$$
                        </em>
                        <em>
                            $x_i$ 是x转换为二进制后每一位上对应的数码，所以它的取值无非是0或者1。这样我们就可以简单的用一个控制酉操作得到每一项，即</em>
                        <em style="overflow-x: scroll">
                            $$\begin{align*}
                            |x_i\rangle&=|1\rangle \ :\ U_a|y\rangle\rightarrow|y\cdot 7^{2^i} (mod15)\rangle
                            |x_i\rangle&=|0\rangle \ :\ U_a=I
                            \end{align*}$$
                        </em>
                        <em>其中 $I$ 是单位操作。所以问题就转化为了构建“控制模乘”操作 $U_a$。
                        </em>
                        <em>
                            顺带一提，因为我们关注的点不是如何纯粹的用量子线路来描述里面的每一步操作，某些操作也不引入额外的计算时间复杂度，那么这些操作是可以用经典计算机代为完成的。就比如说这里的 $7^{2^i}$。注意到
                        </em>
                        <em style="overflow-x: scroll">
                            $$y\cdot 7^{2^i}(mod15)=(y\cdot (7^{2^i}mod15))mod15$$
                        </em>
                        <em>
                            我们只需要事先用经典计算机将 $7^{2^i}mod15(i=0\sim N-1)$（N是选取的工作位数）全部计算出来，就可以在接下来的设计时只考虑对应的几种情况。</em>
                        <em>我们可以看出， $a^{2^i}=a^{2^{i-1}+2^{i-1}}=(a^{2^{i-1}})^2$，根据这个公式，可以列举出来对于不同的 $i$ 的取值情况，上述表达式的取值（这个过程用经典计算机就可以完成）。在例子中的这种情况中，有</em>
                        <em style="overflow-x: scroll">
                            $$\begin{align*}
                            i&=0 \quad 7^{2^i}mod15=7\\
                            i&=1 \quad 7^{2^i}mod15=4\\
                            i&=2 \quad 7^{2^i}mod15=1\\
                            i&\geq3 \quad 7^{2^i}mod15=1
                            \end{align*}$$
                        </em>
                        <em>
                            也就是说我们只需要对应设计 $U_a|y\rangle\rightarrow|7y\ mod15\rangle$，$U_a|y\rangle\rightarrow|4y\ mod15\rangle$ 两种就可以达到设计目的了。
                        </em>
                        <em>最后我们来看一下引入了函数，量子态变成了什么。</em>
                        <em>
                            首先是一组Hadamard变换，它们只作用在一组N个工作比特上，所以这个总状态就会变成
                        </em>
                        <em style="overflow-x: scroll">
                            $$|\text{Working}\rangle|\text{Ancilla}\rangle=\left(\sum_{x=0}^{2^{N}-1} |x\rangle\right) |00...001\rangle$$
                        </em>
                        <em>在量子函数作用在这一组量子态时，相当于这个函数的自变量从0到 $2^{N}-1$ 的所有取值都被保存到了辅助比特上。也就是说，工作比特的每个状态分量都和辅助比特的一个状态分量纠缠在了一起。</em>
                        <em>
                            $\sum |x\rangle|f(x)\rangle$
                        </em>
                        <em>在之前的计算中，我们知道了 $f(x)=a^x (mod N)$ 是一个周期函数，假设它的周期是T。明显地，</em>
                        <em>
                            $f(x)=f(x+T)=f(x+2T)....$
                        </em>
                        <em>那么</em>
                        <em style="overflow-x: scroll">
                            $$|x\rangle|f(x)\rangle+|x+T\rangle|f(x+T)\rangle+|x+2T\rangle|f(x+2T)\rangle+...=\left(|x\rangle+|x+T\rangle+|x+2T\rangle+...\right)|f(x)\rangle$$
                        </em>
                        <em>回到 $a=7$， $N=15$的例子中，我们有</em>
                        <em style="overflow-x: scroll">
                            $$\begin{align*}
                            |\text{Working}\rangle|\text{Ancilla}\rangle&=(|0\rangle+|4\rangle+|8\rangle+...)|1\rangle
                            &+(|1\rangle+|5\rangle+|9\rangle+...)|7\rangle
                            &+(|2\rangle+|6\rangle+|10\rangle+...)|4\rangle
                            &+(|3\rangle+|7\rangle+|11\rangle+...)|13\rangle
                            \end{align*}$$
                        </em>
                        <em>
                            因为这个态是一个纠缠态，所以当我们测量辅助比特时，工作比特就会坍缩成对应的那种情况。但是不论你得到辅助比特的测量值是什么，工作比特总是会只保留为每个分量都恰好为一组周期数的叠加态。那么这一组叠加态表示的数的周期将会通过量子傅里叶变换来快速完成。
                        </em>
                        <h2>量子傅里叶变换</h2>
                        <em>
                            寻找态的周期可以通过量子傅里叶变换来快速完成。我们先以 $|0\rangle+|4\rangle+|8\rangle+...$为例子来看看量子傅里叶变换是怎么做的，之后你就会发现它对于1,5,9,13...或是2,6,10,14...都能得到类似的结果。
                        </em>
                        <em>如图所示，量子傅里叶变换有两个重要的部分，第一是递归的依次控制旋转（CROT）操作，第二部分是改变比特的顺序。</em>
                        <em>数学表达上，每一项都是用离散傅里叶变换的形式去处理的。</em>
                        <em>
                            $$y_k = \frac{1}{\sqrt{N}} \sum_{j=0}^{N-1} x_j \omega^{jk}$$
                        </em>
                        <em>其中 $x_j$ 表示输入量子态的第 $j$ 个分量，而 $k$ 表示输出量子态的分量，如果用 $n$ 个量子比特表示，则 $\omega=e^{\frac{2\pi i}{2^n}}=e^{\frac{2\pi i}{N}}$。而从矩阵上来看，则为</em>
                        <em style="overflow-x: scroll">
                            $$F_N= \frac{1}{\sqrt{N}} \begin{bmatrix}
                            1&1&1&1&\cdots &1 \\
                            1&\omega&\omega^2&\omega^3&\cdots&\omega^{N-1} \\
                            1&\omega^2&\omega^4&\omega^6&\cdots&\omega^{2(N-1)}\\ 1&\omega^3&\omega^6&\omega^9&\cdots&\omega^{3(N-1)}\\
                            \vdots&\vdots&\vdots&\vdots&&\vdots\\
                           1&\omega^{N-1}&\omega^{2(N-1)}&\omega^{3(N-1)}&\cdots&\omega^{(N-1)(N-1)}
                            \end{bmatrix}$$
                        </em>
                        <em>不妨假设工作比特只有4个。那么输入的量子态则为</em>
                        <em>
                            $|\text{Input}\rangle=|0\rangle+|4\rangle+|8\rangle+|12\rangle$
                        </em>
                        <em>
                            这样就代表 $x_0=x_4=x_8=x_{12}=1$，并且 $\omega=e^{2\pi i/16}$，其它分量上都为0。根据傅里叶变换的公式我们可以计算出
                        </em>
                        <em style="overflow-x: scroll">
                            $$\begin{align*}
                            y_k &= \frac{1}{\sqrt{4}} (\omega^{0k}+\omega^{4k}+\omega^{8k}+\omega^{12k})&=\frac{1}{2}(1+i^k+(-1)^k+(-i)^k)
                            \end{align*}$$
                        </em>
                        <em>这里就是工作比特执行完量子傅里叶变换之后的输出态上的每个分量（第k个分量）的值。从而我们可以得到
                            $y_0=y_4=y_8=y_{12}=\frac{1}{2}$，其它情况下 $y_k=0\ (k\neq 0,4,8,12)$， 那么最后输出的量子态则为</em>
                        <em>
                            $|\text{Output}\rangle=|0\rangle+|4\rangle+|8\rangle+|12\rangle$
                        </em>
                        <h2>利用连分数分解得到周期</h2>
                        <em>在最后的测量时，我们会随机得到0，4，8，12四个结果中的一个，但是这个结果并不是周期。但是量子傅里叶变换的结果揭示了一点：</em>
                        <em>
                            $$\omega^{irx}=e^{2\pi i rx/2^N}\sim 1$$
                        </em>
                        <em>其中我们假设测量结果是 $x$，总工作比特数为 $N$，函数的周期为 $r$。那么我们有</em>
                        <em>
                            $$\frac{x}{2^N}=\frac{c}{r}$$
                        </em>
                        <em>
                            其中 $c$ 为一个未知的整数。所以我们可以通过这个式子近似地找出函数周期。例如 $x=4$，$N=4$，我们有
                        </em>
                        <em>
                            $$\frac{c}{r}=\frac{1}{4}$$
                        </em>
                        <em>
                            这样我们就找到了周期r=4。Shor算法的量子计算机部分至此解出。你可以检验一下 $f(x)=7^x (mod15)$ 这个函数的周期是否确实为4。你也可以检验一下$f(r/2)+1$ 和 $f(r/2)-1$ 和15的最大公因数是否就是15的质因数。
                        </em>
                        <em>有时候 $x/2^N$ 并不一定能顺利约出合理的 $r$，这样我们就可以通过连分数分解法，得到一个逼近的分数，从而获得 $r$。这里就不再细讲了。
                        </em>
                        <h2>Shor算法的总结</h2>
                        <em>Shor算法首先把问题分解为了“经典计算机部分”和“量子计算机部分”。然后利用了量子态的叠加原理，快速取得了函数在一个很大范围内的取值（对于 $n$ 个工作比特而言，取值范围为 $0\sim2^n-1$。由于函数本身是周期的，所以自变量和函数值自动地纠缠了起来，从而对于某一个函数值来说，工作比特上的态就是一组周期数态的叠加态。在取得“周期数叠加态”之后，我们自然可以通过傅里叶变换得到这组周期数的周期，从而快速解决了这个问题。
                        </em>
                        <em>反过来看，之所以找函数周期问题能被量子计算机快速解决，是因为在工作比特上执行了一组Hadamard变换。它在“量子函数”的作用下，相当于同时对指数级别的自变量上求出了函数值。在数据量足够大，周期足够长的情况下，这样执行的操作总量一定会小于逐个取值寻找这个函数值在之前是否出现过——这样的经典计算机“暴力破解”法要快得多。</em>
                        <em>Shor算法的难点在于如何通过给出的 $a$，$n$ 来得到对应的“量子函数”形式。进一步地讲，是否存在某种方法（准确地说是具有合理时间复杂度的方法）得到任意函数的“量子计算机版本”？限于笔者知识水平不足，我只能给出目前大概的研究结论是存在某些无法表示为量子计算机版本的函数，但是幸运地是Shor算法属于可以表示的那一类里面。</em>
                        <em>最后，我们可以发现，量子计算机之所以快，和量子计算机本身的叠加特性有关，它使得在处理特定问题时，比如数据库搜索，比如函数求周期……有着比经典计算机快得多的方法。但是如果经典计算机在解决某个问题时已经足够快了，我们就不需要用量子计算机来解决了。</em>
                        <em>就像Shor算法里面所描述的那样——我们将问题分解为了量子计算机去处理的“困难问题”和经典计算机去处理的“简单问题”两个部分一样。所以，量子计算机的出现，不代表经典计算机将会退出历史舞台，而是代表着人类将要向经典计算机力所不及的地方伸出探索之手。靠着量子计算机，或许我们能提出新的算法解决化学问题，从而研制出新型药物；或许我们可以建立包含所有信息的数据库，每次只需要一瞬间就能搜索到任何问题……量子云平台是我们帮助量子计算机走出的第一步，但接下来的路怎么走，我们就要和你一同见证了。
                        </em>
                    </div>
                </div>

            <#--随机数-->
                <div class="algCollCode">
                    <div class="altContentTitle">随机数生成器（Random Number Generator）</div>

                    <div class="altContentSketch">
                        随机数的制备相对来说是简单的。我们知道，现在计算机生产的随机数，其实并非真正的随机数。经典随机数可以理解为一个函数的输入和输出。
                        在经典计算当中，所得的随机数是由一个函数所产生，意味着如果人们知道输入，就能预测得到输出。但是量子随机数是
                        真随机（Truly Random），得意于量子测量结果的不可预测性，也即是量子测量的输出是不可预测的，完全随机分布。那量子态编码的输出，自然就是真随机数了。
                    </div>
                    <div class="altContentSketch" style="padding-top: 0">
                        简单思路，随机数的制备其实就是对叠加态的测量。测量后得到的随机数就是真随机数。也可以通过少量
                        的量子位测量然后搜集输出结果，以此来制备随机源。比如，制备0到127中的一个随机数，这里提供一个简单思路。
                    </div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <div class="alt_n_img">
                                <img src="${base}/assets/images/algSjs1.png" alt="">
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <div class="alt_n_code">
                                    <pre>
void rondamNumber()
{
 init();
 QProg & random = CreateEmptyQProg();
 //Create an empty program named etangle

 auto qbit0 = qAlloc();
 auto qbit1 = qAlloc();
 auto qbit2 = qAlloc();
 auto qbit3 = qAlloc();
 auto qbit4 = qAlloc();
 auto qbit5 = qAlloc();
 auto qbit6 = qAlloc();

 // allocate 6 qubits

 auto cbit0 = cAlloc();
 auto cbit1 = cAlloc();
 auto cbit2 = cAlloc();
 auto cbit3 = cAlloc();
 auto cbit4 = cAlloc();
 auto cbit5 = cAlloc();
 auto cbit6 = cAlloc();
 // allocate 7 cbits

 random
  << H(qbit0)
  << H(qbit1) << H(qbit2) << H(qbit3)
  << H(qbit4) << H(qbit5) << H(qbit6)
  << Measure(qbit0, cbit0) << Measure(qbit1, cbit1)
        << Measure(qbit2, cbit2) << Measure(qbit3, cbit3)
        << Measure(qbit4, cbit4) << Measure(qbit5, cbit5)
  << Measure(qbit6, cbit6);
 // Required quantum circuit.

 load(random);
 // And then load it into the quantum computer.

 run();
 // simply run it.

 auto resultMap = getResultMap();
 // you can get the result map, which save all the
 // measurement results in the classical register(CBit)
 auto Num000 = resultMap["c0"];
 auto Num001 = resultMap["c1"];
 auto Num010 = resultMap["c2"];
 auto Num011 = resultMap["c3"];
 auto Num101 = resultMap["c4"];
 auto Num110 = resultMap["c5"];
 auto Num111 = resultMap["c6"];

 cout <<"The random number of this production is;"
  << Num000 << Num001 << Num010
  << Num011 << Num101 << Num110 << Num111;

 finalize();
 // Use finalize() to tell the quantum computer to stop.
}                                    </pre>
                            </div>
                        </div>
                    </div>
                </div>



            <#--DJ算法-->
                <div class="algCollCode ">
                    <div class="altContentTitle">Deutsch-Jozsa Algorithm</div>
                    <div class="altContentSketch">通常，开发量子计算的主要驱动力来源于量子计算相较于经典计算体现的优越性。通常也是从这样的比较里来认识量子计算。通过简单直观的对比，来扣住“量子霸权”真正含义所在，下面就从简单Deutsch问题说起。</div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n2">
                                <p>考虑函数：</p>
                                <p>$f:\{0,1\}^n \rightarrow \{0,1\} $</p>
                                <p>我们保证有如下两种可能性:</p>
                                <p>（1）$f$是常数的（Constant）,即是对$x\in\{0,1\}^n $,都有$f(x)=0$或$f(x)=1$.</p>
                                <p>（2）$f$是平衡的（Balanced）,对于输入的$x\in\{0,1\}^n $，$f(x)$出输出0和1的个数相同。</p>
                                <p>算法的目标：判断函数$f$是什么类型。</p>
                            </div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">经典算法情况：</div>
                                <div class="alt_n2_info">
                                    <p>在最简单的情况下，最少也需要2次才能判断函数属于什么类型。因为需要第二个输出才能判断最终函数的类型。对于n位输入时，最坏的情况下需要次才能确认。</p>
                                </div>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title">量子算法:</div>
                                <div class="alt_n2_info">
                                    <p>通过构造Oracle的方式，仅需运行一次就能确定函数属于哪一类。</p>

                                </div>
                            </div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">植入步骤：</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algDj2.png" alt="">
                                    </div>
                                    <p>第一步，制备n个工作（Working）比特到 $|0 \left.  \right \rangle$态，与一个辅助（Ancillary）比特到 $|1 \left.  \right \rangle$。第二步，所有比特都经过Hadamard变换，使系统处于叠加态上。</p>
                                    <p>$$|0\left.  \right \rangle^{\otimes_n}|1\left.  \right \rangle\xrightarrow{H^{\otimes_{n+1}}}\frac{1}{ \sqrt{2^n}}\sum_{x=0}^{2^n-1}|x\left.  \right \rangle{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{ \sqrt{2}})}$$</p>

                                    <p>第三步，系统通过Oracle ，一种酉变换，满足：</p>
                                    <p>$$U_f:|x\left.  \right \rangle|y\left.  \right \rangle \longrightarrow  |x\left.  \right \rangle|y\oplus f(x)\left.  \right \rangle$$</p>

                                    <p>这时候，系统状态为：</p>
                                    <p style="overflow-x: scroll">$$\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1}|x\left.  \right \rangle{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{ \sqrt{2}})}\xrightarrow{Oracle}\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1} {(-1)^{f(x)}}  |x\left.  \right \rangle{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{ \sqrt{2}})}$$</p>

                                    <p>当时$f(x)=1$，会使得$\frac{|0\left.  \right \rangle-|1\left.  \right \rangle }{\sqrt{2}} \longrightarrow  \frac{|1\left.  \right \rangle-|0\left.  \right \rangle }{\sqrt{2}}$，发生相位的翻转。</p>
                                    <p>第四步：去除辅助比特，执行Bell测量。如果输出全部为0，则是$f$是常数的，反之，这是平衡的。</p>
                                </div>
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <div class="alt_n_img" style="padding: 0">
                                <img src="${base}/assets/images/algDj6.png" style="width:60%;" alt="">
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <div class="alt_n_code">
                                    <pre>
                                        /*
Copyright (c) 2017-2018 Origin Quantum Computing. All Right Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

#include "DJ_Algorithm.h"

void DJ_Algorithm()
{
 bool fx0 = 0, fx1 = 0;
 cout << "input the input function" << endl
  << "The function has a boolean input" << endl
  << "and has a boolean output" << endl
  << "f(0)= (0/1)?";
 cin >> fx0;
 cout << "f(1)=(0/1)?";
 cin >> fx1;
 vector&lt;bool> oracle_function({ fx0,fx1 });
 cout << "Programming the circuit..." << endl;
 init();
 auto q1 = qAlloc();
 auto q2 = qAlloc();
 auto c1 = cAlloc();

 Reset_Qubit(q1, false);
 Reset_Qubit(q2, true);

 append(Two_Qubit_DJ_Algorithm_Circuit(q1, q2, c1, oracle_function));

 run();

 //auto resultMap = getResultMap();
 if (getCBitValue(c1) == false)
 {
  cout << "Constant function!";
 }
 else if (getCBitValue(c1) == true)
 {
  cout << "Balanced function!";
 }
}

QProg & Two_Qubit_DJ_Algorithm_Circuit(
 Qubit * qubit1,
 Qubit * qubit2,
 CBit * cbit,
 vector&lt;bool> oracle_function)

{
 auto &prog = CreateEmptyQProg();
 //Firstly, create a circuit container

 prog << H(qubit1) << H(qubit2);
 // Perform Hadamard gate on all qubits

 if (oracle_function[0] == false
  &&
  oracle_function[1] == false)
  // different oracle leads to different circuit
  // f(x) = oracle_function[x]
 {
  // f(x) = 0, do nothing
 }
 else if (oracle_function[0] == false
  &&
  oracle_function[1] == true
  )
 {
  // f(x) = x;
  prog << CNOT(qubit1, qubit2);
 }
 else if (oracle_function[0] == true
  &&
  oracle_function[1] == false
  )
 {
  // f(x) = x + 1;
  prog << RX(qubit2)
   << CNOT(qubit1, qubit2)
   << RX(qubit2);
 }
 else if (oracle_function[0] == true
  &&
  oracle_function[1] == true
  )
 {
  // f(x) = 1
  prog << RX(qubit2);
 }

 // Finally, Hadamard the first qubit and measure it
 prog << H(qubit1) << Measure(qubit1, cbit);
 return prog;
}
                                    </pre>
                            </div>
                        </div>
                    </div>
                </div>

            <#--PQ-->
                <div class="algCollCode">
                    <div class="altContentTitle">PQ Penny flip </div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                        <#--<div class="alt_n_title">问题描述</div>-->
                            <div class="alt_n_info">
                                量子计算机利用诸如叠加和纠缠之类的量子力学现象来进行计算。
                                这在经典计算机上是无法计算的，量子算法在其经典计算对比下，
                                呈指数级加速。Harrow, Hassidim和Lloyd（HHL）提出了一种求解线性系统$Ax=b$(其中A是算子，
                                x，b是向量)中$x$信息的量子线性系统分析。HHL算法解决了什么样的问题？那就是求解线性方程的问题，
                                众所周知，线性系统是很多科学和工程领域的核心，由于HHL算法在特定条件下实现了相较于经典算法有指数加速效果，
                                从而未来能够在机器学习、数值计算等场景有优势体现。配合Grover算法在数据方面的加速，将是未来量子机器学习，
                                人工智等科技得以突破的关键性技术。
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title">游戏说明：</div>
                                <div class="alt_n2_info">
                                    <p>这是一个硬币（便士）反转的游戏，游戏由两个玩家和一个可翻转硬币组成。和以往的游戏一
                                        样，玩家在游戏开始之前，彼此都可以接受任何的策略，但是游戏开始之后，彼此没有任何交流和通信。游戏开始之前，玩家彼此，而且双眼
                                        被蒙住，不可以看到当前翻转投掷硬币的状态。考虑玩家P和Q，以及一枚初始化处于H面（数字1，表示H,国徽面是T面）的硬币，如下：
                                    </p>
                                    <div class="alt_n2_img"><img src="${base}/assets/images/algPq1.png" alt=""></div>
                                </div>
                                <div class="alt_n2_title">游戏规则：</div>
                                <div class="alt_n2_info">
                                    <p>初始的硬币状态是朝上(H)。</p>
                                    <p>P，Q共同可以翻转该硬币。每次翻转后，玩家不可以看自己翻转的情况。</p>
                                    <p>每个玩家可以自由翻转或者不翻转。</p>
                                    <p>翻转的顺序是：Q $\rightarrow $ P $\rightarrow $ Q。</p>
                                    <p>游戏结束，如果硬币是H面，Q赢，如果是T面，P赢。</p>
                                </div>
                            </div>

                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">经典策略：</div>
                            <div class="alt_n_info">

                                经典博弈情况下,对于？Q的最后一步, P,Q都不知道硬币的状态。也即是说，P,Q在翻转和不之间是出于随机化的, 所以P,Q都有50/50 的获胜机会。对于玩家P,Q随机的选取，最后的获胜统计结果必然是两两50%。
                                </br>但是，出现了一个这样乐趣的事情，有一天，P和Q在玩该游戏的时候，发现Q已经连续多次赢得游戏，无论P是否做翻转操作。那是因为，Q用一个量子策略捉弄P从而一直赢得游戏。
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">量子策略：</div>
                            <div class="alt_n_info">

                                <p>考虑编码硬币的两个状态，分别为：</p>
                                <p>$$H= \begin{pmatrix}0\\1\end{pmatrix} ,T= \begin{pmatrix}0\\1\end{pmatrix} $$</p>
                                <p>如上文，H和T分别表示硬币的正反面，下面给定翻转操作，F为翻转，I为不翻转，分别为：</p>
                                <p>$$  F=\begin{bmatrix}0&1\\1&0\end{bmatrix} , I=\begin{bmatrix}1&0\\0&1\end{bmatrix} $$</p>
                                <p>验证FH=T,FT=H,并且验证不翻转的情况：</p>
                                <p style="overflow-x: scroll">$$  FH=\begin{bmatrix}0&1\\1&0\end{bmatrix}\begin{pmatrix}1\\0\end{pmatrix}=\begin{pmatrix}0\\1\end{pmatrix}=T ,FT=\begin{bmatrix}0&1\\1&0\end{bmatrix}\begin{pmatrix}0\\1\end{pmatrix}=\begin{pmatrix}1\\0\end{pmatrix}=H $$</p>
                                <p>$$ IH=\begin{bmatrix}1&0\\0&1\end{bmatrix} \begin{pmatrix}1\\0\end{pmatrix} = \begin{pmatrix}1\\0\end{pmatrix} =H,IT=\begin{bmatrix}1&0\\0&1\end{bmatrix} \begin{pmatrix}0\\1\end{pmatrix} = \begin{pmatrix}0\\1\end{pmatrix} =T $$</p>
                                <p>可见，F操作，可以翻转（Flip）硬币。在经典游戏中, 我们只限于使用F和I的翻转, 它可
                                    以改变状态或保持状态，在量子世界中, 我们可有额外的操作, 数学上由酉矩阵（Unitary matrices）
                                    表示。回顾基础部分所涉及到的叠加态（Superposition）的概念，
                                    量子世界里，有办法将状态置于硬币正反面的一个叠加态（可以想象成硬币翻转的时候，处于在正面和反面的一个叠加态里）</p>
                                <p>这里，我们考虑一个酉矩阵U（Hadamard Gate）,在游戏博弈的时候，P将采用这种翻转。</p>
                                <p>$$U=\frac{1}{ \sqrt{2}}\begin{bmatrix}1&1\\1&-1\end{bmatrix}$$</p>
                                <p>在回顾游戏的步骤，第一步初始化的硬币处于$H= \begin{pmatrix}0\\1\end{pmatrix}$，第二步P执行翻转，此处P执行U翻转，把状态置为：</p>
                                <p>$$UH=\frac{1}{ \sqrt{2}}\begin{bmatrix}1&1\\1&-1\end{bmatrix} \begin{pmatrix}0\\1\end{pmatrix}=\frac{1}{ \sqrt{2}}\begin{pmatrix}1\\1\end{pmatrix}=S^{HT}$$</p>
                                <p>第三步，Q执行翻转，可以看到出，无论Q执行X或者I操作，状态始终保持不变。最后一步，P在执行一次U操作，状态变化为：</p>
                                <p>$$US^{HT}=\frac{1}{2}\begin{bmatrix}1&1\\1&-1\end{bmatrix} \begin{pmatrix}1\\1\end{pmatrix}=\begin{pmatrix}0\\1\end{pmatrix}=H$$</p>
                                <p>状态恢复到H,所以Q一直赢得游戏。</p>

                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_info">QPanda 里实施过程 ：
                                    <div class="alt_n2_border">
                                        <p>1.定义随机数生产，生成随机数，模拟P是否选择翻转。</p>
                                        <p>2.询问用户，需要多少“硬币”（状态），定义为N。</p>
                                        <p>3.初始化N个比特。</p>
                                        <p>4.模拟Q的第一步操作，对N个状态执行U门（Hadamard gate）。</p>
                                        <p>5.模拟P对任意状态执行F或者I操作（采用随机数的结果作为选择依据）。</p>
                                        <p>6.模拟Q最后一步操作。对所有状态执行U门操作。</p>
                                        <p>测量，输出结果，得到结果为00…0，告知恭喜胜利！</p>
                                    </div>
                                </div>

                            </div>


                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <div class="alt_n_img">
                                <img src="${base}/assets/images/algPq2.png" alt="" style="width:auto;">
                            </div>
                        </div>
                    </div>
                </div>

            <#--Swap Test Operation-->
                <div class="algCollCode">
                    <div class="altContentTitle">Swap Test Operation</div>
                    <div class="altContentSketch" style="padding-bottom: 10px">Swap Test操作是量子算法中一种有效的操作工具。Swap Test操作主要用于计算两个量子态内积的平方，从而判断两个量子态的接近程度。</div>
                    <div class="altContentSketch" style="padding-top: 0">   一些量子算法的原理是基于Swap Test,比如量子异常检测算法[1]，量子岭回归[2]，量子指纹识别[3]等。下面简单介绍下Swap Test的原理。</div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n_info">
                                给定两个未知的量子态$|\phi\left.  \right \rangle$和$|\Psi \left.  \right \rangle$，要判断这两个量子态的接近程度，即计算$|\left \langle {\phi|\Psi} \right \rangle|^2$。
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">操作目标：</div>
                            <div class="alt_n_info">
                                判断这两个未知量子态的接近程度，计算$|\left \langle {\phi|\Psi} \right \rangle|^2$
                            </div>

                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">操作线路</div>
                            <div class="alt_n_info">
                                Swap Test操作的量子线路如图1所示，其中$|\phi\left.  \right \rangle$和$|\Psi \left.  \right \rangle$表示两个未知量子态，整个操作的核心步骤是用一个辅助量子比特对$|\phi\left.  \right \rangle$和$|\Psi \left.  \right \rangle$进行控制交换操作，在控制交换操作前后均对辅助比特执行Hadamard操作。整个过程量子态的演化路径如下：
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algSt1.png" alt="">
                                    </div>
                                    <p>(1)初始态：$|0\left.  \right \rangle|\phi\left.  \right \rangle|\Psi \left.  \right \rangle$</p>
                                    <div class="alt_n2_img">

                                    </div>
                                    <p>(2)给辅助比特加Hadamard操作后，态演化为：</p>
                                    <p>$\frac{1}{\sqrt{2} }{(|0\left.  \right \rangle+|1\left.  \right \rangle)}|\phi\left.  \right \rangle|\Psi \left.  \right \rangle$</p>
                                    <p>(3)辅助量子比特对和进行控制交换操作后，态演化为：</p>
                                    <p>$\frac{1}{\sqrt{2} }{(|0\left.  \right \rangle |\phi\left.  \right \rangle|\Psi \left.  \right \rangle+|1\left.  \right \rangle|\Psi\left.  \right \rangle| \phi\left.  \right \rangle)}$</p>
                                    <p>(4)再次给辅助量子比特加Hadamard操作后，态演化为：</p>
                                    <p>$\frac{1}{2}|0\left.  \right \rangle{(|\phi\left.  \right \rangle|\Psi \left.  \right \rangle+|\Psi\left.  \right \rangle| \phi\left.  \right \rangle)} + \frac{1}{2}|1\left.  \right \rangle{(|\phi\left.  \right \rangle|\Psi \left.  \right \rangle-|\Psi\left.  \right \rangle| \phi\left.  \right \rangle)}$</p>
                                    <p>(5)对辅助比特进行测量，测量到和的概率分别为：</p>
                                    <p>
                                        $p_0=\frac{1}{2}{(1+|\left \langle {\phi|\Psi} \right \rangle|^2)}$

                                    </p>
                                    <p> $p_1=\frac{1}{2}{(1-|\left \langle {\phi|\Psi} \right \rangle|^2)}$</p>

                                    <p>从而根据测量得到的$p_0$或$p_1$即可得到$|\left \langle {\phi|\Psi} \right \rangle|^2$，判断$|\phi \left.  \right \rangle$和$|\Psi \left.  \right \rangle$的接近程度。</p>
                                </div>
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <p>下面是一份用QPanda实现的Swap Test操作的程序源码，其中$|\phi \left.  \right \rangle$和$|\Psi \left.  \right \rangle$均是单比特态；</p>
                            <div class="alt_n_code">
                                    <pre>
QProg swaptest_QProg(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec, vector&lt;double>& phi)
{

    QProg  swaptest_qprog = CreateEmptyQProg();
    swaptest_qprog << H(qVec[0]);
    //initial state
    swaptest_qprog << RY(qVec[1], phi[0])<&lt;RZ(qVec[1], phi[1]);
    swaptest_qprog << RY(qVec[2], phi[2]) << RZ(qVec[2], phi[3]);
    //control swap
    QCircuit controlswap = CreateEmptyCircuit();
    controlswap << CNOT(qVec[1], qVec[2])<< CNOT(qVec[2], qVec[1])<&lt;CNOT(qVec[1], qVec[2]);
    vector&lt;Qubit*> qvtemp;
    qvtemp.push_back(qVec[0]);
    controlswap.setControl(qvtemp);
    swaptest_qprog << controlswap;
    swaptest_qprog <&lt;H(qVec[0])<< Measure(qVec[0], cVec[0]);
    return swaptest_qprog;
}
void swaptest()
{
    cout << "Swap Test Algorithm\n" << endl;
    cout << "Initialize phi" << endl;
    double theta1;
    double alpha1;
    double theta2;
    double alpha2;
    vector&lt;double> phi;
    cout << "input theta1:" << endl;
    cin >> theta1;
    cout << "input alpha1:" << endl;
    cin >> alpha1;
    cout << "input theta2:" << endl;
    cin >> theta2;
    cout << "input alpha2:" << endl;
    cin >> alpha2;
    cout << "phi=" << cos(theta1 / 2) << "*|0>+" << exp(1i*alpha1)*sin(theta1 / 2) << "|1>" << endl;
    cout << "psi=" << cos(theta2 / 2) << "*|0>+" << exp(1i*alpha2)*sin(theta2 / 2) << "|1>" << endl;
    phi.push_back(theta1);
    phi.push_back(alpha1);
    phi.push_back(theta2);
    phi.push_back(alpha2);

    cout<<" Programming the circuit..." << endl;
    init();
    vector&lt;Qubit*> qVec;
    vector&lt;CBit*> cVec;
    for (auto i = 0; i < 3 ; i++)
    {
        qVec.push_back(qAlloc());
    }
    cVec.push_back(cAlloc());
    double prob;
    size_t times=0;
    for (auto i = 0; i < 1000; i++)
    {
        if (swaptest1(qVec, cVec, phi))
        {
            times++;
        }
    }
    prob = times*0.001;
    cout << "|&lt;phi|psi>|^2=" << 1 - 2 * prob << endl;
    return;
}
bool swaptest1(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec, vector&lt;double>& phi)
{
    init();
    auto bvAlgorithm = swaptest_QProg(qVec, cVec, phi);
    append(bvAlgorithm);
    run();
return getCBitValue(cVec[0]);
}
                                    </pre>
                            </div>
                        </div>

                        <div class="alt_n">
                            <div class="alt_n_title">参考文献</div>
                            <div class="alt_n_info">
                                <p>[1].Nana Liu,Patrick Rebentrost,arXiv:1710.07405vl.</p>
                                <p>[2].CH Yu,F Gao,QY Wen.arXiv:1707.09524,2017.</p>
                                <p>[3].H.Buhrman,R.Cleve,J.Watrous,and R.de wolf, Quantum fingerprinting, Phys.Rev.Lett.87,167902.</p>
                            </div>
                        </div>
                    </div>
                </div>

            <#--Simon-->
                <div class="algCollCode">
                    <div class="altContentTitle">Simon's Algorithm</div>
                    <div class="altContentSketch">
                        Simon问题是Daniel Simon在1994年提出。它是一个计算问题, 可以在量子计算机上以指数速度相较经典计算机更快地解决。虽然这个问题本身目前没有在实际应用中产生实际价值, 但它的趣味内涵在于它证明了量子算法可以比任何经典算法更快地解决这个问题。
                        </br>Simon的算法也启发了Shor算法（详细请查阅Shor量子算法）。这两个问题都是阿贝尔隐子群（Abelian hidden subgroup problem）问题的特例, 而且是现今已知有效的量子算法。
                    </div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n2">
                                <p>给定一个方程：</p>
                                <p>$f:\{0,1\}^n\longrightarrow\{0,1\}^n$</p>
                                <p>存在$s\in\{0,1\}^n$，对所有的$x,y\in\{0,1\}^n$，满足下面的性质：</p>
                                <p>$f(x)=f(y)$当且仅当$x=y$或$x\oplus y=s$ <span>（这里$\otimes$表示模2加。)</span></p>


                            </div>
                        </div>
                        <div class="alt_n">

                            <div class="alt_n_title">算法目标：</div>
                            <div class="alt_n2">
                                <div class="alt_n2_title"> 寻找s</div>
                                <div class="alt_n2_info">
                                    <p>例：n=2的Simon问题,考虑2量子比特。注意，如果目标$s=0^n$，那这个函数是1对1（one-to-one）的，
                                        此处不考虑。反之，则是一个二对一(two-to-one)的函数，几种情况如下图（函数值任意给定）：</p>

                                    <div class="alt-n2-flex" style="    padding: 20px 0;">
                                        <div class="alt-ne-f1">
                                            <div>(1) s=01;</div>
                                            <table border="1">
                                                <tr>
                                                    <th>$x$</th>
                                                    <th>$f(x)$</th>
                                                </tr>
                                                <tr>
                                                    <td>00</td>
                                                    <td>1</td>
                                                </tr>
                                                <tr>
                                                    <td>01</td>
                                                    <td>1</td>
                                                </tr>
                                                <tr>
                                                    <td>10</td>
                                                    <td>0</td>
                                                </tr>
                                                <tr>
                                                    <td>11</td>
                                                    <td>0</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="alt-ne-f1">
                                            <div>(2) s=10;</div>
                                            <table border="1">
                                                <tr>
                                                    <th>$x$</th>
                                                    <th>$f(x)$</th>
                                                </tr>
                                                <tr>
                                                    <td>00</td>
                                                    <td>1</td>
                                                </tr>
                                                <tr>
                                                    <td>01</td>
                                                    <td>2</td>
                                                </tr>
                                                <tr>
                                                    <td>10</td>
                                                    <td>1</td>
                                                </tr>
                                                <tr>
                                                    <td>11</td>
                                                    <td>2</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="alt-ne-f1" style="margin:0;">
                                            <div>(3) s=11;</div>
                                            <table border="1">
                                                <tr>
                                                    <th>$x$</th>
                                                    <th>$f(x)$</th>
                                                </tr>
                                                <tr>
                                                    <td>00</td>
                                                    <td>1</td>
                                                </tr>
                                                <tr>
                                                    <td>01</td>
                                                    <td>3</td>
                                                </tr>
                                                <tr>
                                                    <td>10</td>
                                                    <td>3</td>
                                                </tr>
                                                <tr>
                                                    <td>11</td>
                                                    <td>1</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <p>
                                        在（1）很容易看出$f(00)=f(01)=1$，$f(10)=f(11)=0$，因此$00\oplus01=01$，$10\oplus11=01$，推出$s=01$。经典算法最低需要2次的才能确定，一般情况下，对于n比特的问题估计找到目标s最糟糕的情况下要消耗多达$2^{n-1}+1$次。
                                        但是在量子算法里，1次就解决了这个问题。
                                    </p>
                                </div>
                            </div>

                        </div>

                        <div class="alt_n">

                            <div class="alt_n_title">量子Oracle</div>
                            <div class="alt_n_info">
                                <p>Simon问题的量子Oracle(考虑s=11)</p>
                                <p> 考虑n=2的Simon问题，此时需要2量子比特的变量和2量子比特的函数，合计需要4量子比特。</p>
                                <p>$|x_ox_1\left.  \right \rangle|00\left.  \right \rangle\xrightarrow{uf}|x_ox_1\left.  \right \rangle|00\oplus f(x_0x_1)\left.  \right \rangle=|x_0x_1\left.  \right \rangle|f(x_0x_1)\left.  \right \rangle$</p>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title"> 下面考虑Simon问题的Oracle:</div>
                                <div class="alt_n2_info"></div>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title"> 线路图如下:</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algSa1.png" alt="">
                                        <p>上面的这个量子Oracle可以加入Hadamard门，对前两个量子比特做H操作，等价于：</p>
                                        <img src="${base}/assets/images/algSa2.png" alt="">
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">过程</div>
                            <div class="alt_n_info">
                                <p>$$|0000\left.  \right \rangle \xrightarrow{H \otimes H \otimes I\otimes I}|++\left.  \right \rangle|00\left.  \right \rangle\xrightarrow{u_f} \frac{1}{2}{[(|00\left.  \right \rangle+|11\left.  \right \rangle)|1\left.  \right \rangle +(|01\left.  \right \rangle+|10\left.  \right \rangle)|3\left.  \right \rangle }   \xrightarrow{H \otimes H \otimes I\otimes I}\frac{1}{2}{[(|00\left.  \right \rangle+|11\left.  \right \rangle)|1\left.  \right \rangle +(|00\left.  \right \rangle-|11\left.  \right \rangle)|3\left.  \right \rangle ]}$$</p>
                                <p> (注意：$|3\left.  \right \rangle$是我定义的函数值)</p>
                                <p>因此，最下面的两个位分别对应了$|1\left.  \right \rangle$和$|3\left.  \right \rangle$，测量上面的两量子位，$|00\left.  \right \rangle$和$|11\left.  \right \rangle$则会被以50%的概率被观察到。</p>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title"> 下面是QPanda的实施过程：</div>
                                <div class="alt_n2_info">

                                    <div class="alt_n2_border">
                                        <p>1.	初始化4个量子比特。</p>
                                        <p>2.	创建线路图: q[0], q[1]分别做Hadamard操作。</p>
                                        <p>3.	对q[0]，q[2]和q[1], q[2]分别执行CNOT操作。</p>
                                        <p>4.	对q[3]执行NOT操作。</p>
                                        <p>5.	再对q[0]，q[1]分别做Hadamard操作</p>
                                        <p>6.	最后测量全部量子逻辑位，输出结果。</p>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <p>QPanda代码 (s=11)</p>
                            <div class="alt_n_code">
                                    <pre>
QProg Simon_QProg(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec, vector&lt;int> funvalue)
{
    size_t length = cVec.size();
    auto simon_qprog = CreateEmptyQProg();
    for (auto i = 0; i < length; i++)
    {
        simon_qprog << H(qVec[i]);
    }
    simon_qprog << oraclefunc(qVec,funvalue);
    for (auto i = 0; i < length; i++)
    {
        simon_qprog << H(qVec[i]);
    }
    for (auto i = 0; i < length; i++)
    {
        simon_qprog << Measure(qVec[i],cVec[i]);
    }
    return simon_qprog;
}

//f(x),x is 2bits variable
QCircuit oraclefunc(vector&lt;Qubit*> qVec, vector&lt;int> funvalue)
{
    auto length = qVec.size() / 2;
    auto  func = CreateEmptyCircuit();
    for (auto i = 0; i < 4; i++)
    {
        func << controlfunc(qVec,i, funvalue[i]);
    }
    return func;
}
QCircuit controlfunc(vector&lt;Qubit*> qVec,size_t index, int value)
{
    auto length = qVec.size() / 2;
    auto  cfunc = CreateEmptyCircuit();
    vector&lt;Qubit*> qvtemp;
    qvtemp.insert(qvtemp.begin(), qVec.begin(), qVec.begin() + length);
    if (index == 1)
    {
        cfunc << X(qVec[0]);
    }
    else if (index == 2)
    {
        cfunc << X(qVec[1]);
    }
    else if (index == 0)
    {
        cfunc << X(qVec[0]);
        cfunc << X(qVec[1]);
    }
    if (value == 1)
    {
        QGate temp = X(qVec[3]);
        temp.setControl(qvtemp);
        cfunc << temp;
    }
    else if (value == 2)
    {
        QGate temp1 = X(qVec[2]);
        temp1.setControl(qvtemp);
        cfunc << temp1;
    }
    else if (value == 3)
    {
        QGate temp2 = X(qVec[2]);
        temp2.setControl(qvtemp);
        cfunc << temp2;
        QGate temp3 = X(qVec[3]);
        temp3.setControl(qvtemp);
        cfunc << temp3;
    }
    if (index == 1)
    {
        cfunc << X(qVec[0]);
    }
    else if (index == 2)
    {
        cfunc << X(qVec[1]);
    }
    else if (index == 0)
    {
        cfunc << X(qVec[0]);
        cfunc << X(qVec[1]);
    }
    return cfunc;
}
                                    </pre>
                            </div>
                        </div>


                        <div class="alt_n">

                            <div class="alt_n_title">附录：</div>
                            <div class="alt_n_info">

                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title"> Simon问题(s=11）的线路图设计参考图：</div>
                                <div class="alt_n2_img"><img src="${base}/assets/images/algSa3.png" alt=""></div>
                                <div class="alt_n2_info">
                                    <p>
                                        这里，测定结果得$|00\left.  \right \rangle$的时候，表示没有得到任何的信息，当测量得到$|11\left.  \right \rangle$的时候，就得到了s=11，也就是说Simon量子算法里面，0以外的获取s的概率为50%。
                                    </p>

                                </div>
                                <div class="alt_n2_info">s=10的线路图参考，流程和思路和上面完全一致，测试用。</div>
                                <div class="alt_n2_info">s= 10:</div>
                                <div class="alt_n2_img"><img src="${base}/assets/images/algSa4.png" alt=""></div>
                            </div>


                        </div>
                    </div>
                </div>

            <#--BV算法-->
                <div class="algCollCode">
                    <div class="altContentTitle">Bernstein-VaziraniAlgorithm</div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n2">
                                <p>input:</p>
                                <p>考虑一个经典的布尔函数：</p>
                                <p>$f:\{0,1\}^n\longrightarrow\{0,1\}$</p>
                                <p>存在$s\in \{0,1\}^n$，再定义一个函数：</p>
                                <p>$f_s(x)=\left \langle {s,x} \right \rangle,x\in \{0,1\}^n$</p>
                                <p>s是一个未知的向量，通常称s为隐藏字符串（Hidden string），其中$\left \langle {s,x} \right \rangle$表示内积（inner product），定义为：</p>
                                <p>$\left \langle {s,x} \right \rangle=s_0x_0\oplus s_1x_1\oplus..\oplus s_nx_n$</p>
                                <p>（符号$\otimes$在所出现的量子算法文中都表示布尔加或模2加。）:</p>
                                <p>Output：</p>
                                <p>算法目标：找到s.</p>
                            </div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">经典算法情况：</div>
                                <div class="alt_n2_info">
                                    <p>由于对该函数的每个经典查询只能生成1位的信息, 而任意隐藏字符串 s 具有$n$位的信息, 所以经典查询复杂性是$O(n)$。</p>
                                </div>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title">量子算法:</div>
                                <div class="alt_n2_info">
                                    <p>Bernstein-Vazirani的工作建立在Deutsch和Jozsa早期工作理论上来探索量子查询复杂度。他们对该领域的
                                        贡献是一个用于隐藏字符串问题的量子算法, 该算法的非递归量子查询复杂度仅为1，同比经典情况$O(n)$。这一量子算法的真正突破在于加快查询复杂度, 而不是执行时间本身。</p>
                                    <p style="margin-top: 18px">案例：考虑n=3时的Bernstein-Vazirani问题。变量是3比特时，二进制表示为$x_0x_1x_2$，常数s则表示为$s_0s_1s_2$，因此所求的常数s总共有8个。此时，问题函数描述如下：</p>
                                    <p style="margin-top: 18px">$f_s(x_0x_1x_2)=s_0x_0\oplus s_1x_1 \oplus s_2x_2$</p>
                                    <p style="margin-top: 18px">不难看出，对于经典算法而言，如果是$f_s(100)=s_0,f_s(010)=s_1,f_s(001)=s_2$，
                                        那么最少也需要3次调用函数才可以确定常量$s=s_0s_1s_2$。但是对于量子算法而言，使用下面的量子Oracle计算，1次就可以决定$s=s_0s_1s_2$，其计算复杂度为$O(1)$。</p>
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algBv1.png" alt="">
                                    </div>
                                    <p>分析上图：</p>
                                    <p>$$|0\left.  \right \rangle|1\left.  \right \rangle\xrightarrow{H\otimes H\otimes H\otimes H} \frac{1}{ 2\sqrt{2}}\sum_{x=0}^{7}|X\left.  \right \rangle\otimes {(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})} $$</p>
                                    <p>$$\xrightarrow{uf}\frac{1}{ 2\sqrt{2}}\sum_{x=0}^{7}{(-1)^\left \langle {s,x} \right \rangle}|x\left.  \right \rangle\otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}$$</p>
                                    <p>$$\xrightarrow{H\otimes H\otimes H\otimes H} \frac{1}{ 2\sqrt{2}}\sum_{x=0，y=0}^{7}{(-1)^{\left \langle {s,x} \right \rangle\otimes \left \langle {x,y} \right \rangle}} |y\left.  \right \rangle\otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}\Xi|s> \otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}$$</p>
                                    <p>不失一般性：</p>
                                    <p>$$|0\left.  \right \rangle^n|1\left.  \right \rangle\xrightarrow{H^{\otimes(n+1)}}\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1}|X\left.  \right \rangle\otimes {(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})} $$</p>
                                    <p>$$\xrightarrow{uf}\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1}{(-1)^\left \langle {s,x} \right \rangle}|x\left.  \right \rangle\otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}$$</p>
                                    <p>$$\xrightarrow{H^{\otimes(n+1)}} \frac{1}{ \sqrt{2^n}}\sum_{x=0，y=0}^{2^n-1}{(-1)^{\left \langle {s,x} \right \rangle\oplus \left \langle {x,y} \right \rangle}} |y\left.  \right \rangle\otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}\Xi|s\left.  \right \rangle \otimes{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{\sqrt{2}})}$$</p>
                                </div>
                            </div>

                            <div class="alt_n2">
                            <#--<div class="alt_n2_title">植入步骤：</div>-->
                                <div class="alt_n2_info">

                                </div>
                            </div>

                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <p style="margin-top: 10px">下面给出两组案例,分别是s=101和s=111</p>
                            <div class="alt_n2">
                                <div class="alt_n2_title">s=101</div>
                                <div class="alt_n2_img"><img src="${base}/assets/images/algBv2.png" alt=""></div>
                                <div class="alt_n2_info">
                                    <p>过程：略</p>
                                    <p>量子语言 :</p>
                                    <div class="alt_n2_border">
                                        <p>RX 3,"pi"</p>
                                        <p>H 0</p>
                                        <p>H 1</p>
                                        <p>H 2</p>
                                        <p>H 3</p>
                                        <p>CNOT 0,3</p>
                                        <p>CNOT 2,3</p>
                                        <p>H 0</p>
                                        <p>H 1</p>
                                        <p>H 2</p>
                                        <p>MEASURE 0,$0</p>
                                        <p>MEASURE 1,$1</p>
                                        <p>MEASURE 2,$2</p>
                                    </div>
                                    <p>这时，输出的结果，指代了s。通过验证,输出结果为：</p>
                                    <div class="alt_n2_img"><img src="${base}/assets/images/algBv3.png" alt=""></div>
                                </div>
                            </div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">s=111时：</div>

                                <div class="alt_n2_info">
                                    <p>线路图设计为：</p>
                                    <div class="alt_n2_img"><img src="${base}/assets/images/algBv4.png" alt=""></div>
                                    <p>测量结果：</p>
                                    <div class="alt_n2_img"><img src="${base}/assets/images/algBv6.png" alt=""></div>
                                    <p>量子语言 :</p>
                                    <div class="alt_n2_border">
                                        <p>RX 3,"pi"</p>
                                        <p>H 0</p>
                                        <p>H 1</p>
                                        <p>H 2</p>
                                        <p>H 3</p>
                                        <p>CNOT 0,3</p>
                                        <p>CNOT 1,3</p>
                                        <p>CNOT 2,3</p>
                                        <p>H 0</p>
                                        <p>H 1</p>
                                        <p>H 2</p>
                                        <p>MEASURE 0,$0</p>
                                        <p>MEASURE 1,$1</p>
                                        <p>MEASURE 2,$2</p>
                                    </div>

                                </div>
                            </div>

                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <div class="alt_n_code">
                                    <pre>
QProg BV_QProg(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec, vector&lt;bool>& a, bool b)
{
    if (qVec.size() != (a.size()+1))
    {
        throw exception("error");
    }
    size_t length = qVec.size();
    QProg  bv_qprog = CreateEmptyQProg();
    bv_qprog << X(qVec[length - 1]);
    for (auto iter = qVec.begin(); iter != qVec.end(); iter++)
    {
        bv_qprog << H(*iter);
    }
    for (auto i=0;i&lt;length-1;i++)
    {
        if (a[i])
        {
            bv_qprog << CNOT(qVec[i], qVec[length - 1]);
        }
    }
    for (auto i = 0; i < length - 1; i++)
    {
        bv_qprog << H(qVec[i]);
    }
    for (auto i = 0; i < length - 1; i++)
    {
        bv_qprog << Measure(qVec[i], cVec[i]);
    }


    return bv_qprog;
}
void BernsteinVaziraniAlgorithm()
{
    cout << "Bernstein Vazirani Algorithm\n" << endl;
    cout << "f(x)=a*x+b\n" << endl;
    cout << "input a" << endl;
    string stra;
    cin >> stra;
    vector&lt;bool> a;
    for (auto iter = stra.begin(); iter != stra.end(); iter++)
    {
        if (*iter == '0')
        {
            a.push_back(0);
        }
        else
        {
            a.push_back(1);
        }
    }
    cout << "input b" << endl;
    bool b;
    cin >> b;
    cout << "a=\t" << stra << endl;
    cout << "b=\t" << b << endl;
    cout<<" Programming the circuit..." << endl;
    size_t qbitnum = a.size();
    init();
    vector&lt;Qubit*> qVec;
    vector&lt;CBit*> cVec;
    for (auto i = 0; i < qbitnum ; i++)
    {
        qVec.push_back(qAlloc());
        cVec.push_back(cAlloc());
    }
    qVec.push_back(qAlloc());
    auto bvAlgorithm = BV_QProg(qVec, cVec, a, b);
    append(bvAlgorithm);
    run();
    string measure;
    cout << "a=\t";
    for (auto iter = cVec.begin(); iter != cVec.end(); iter++)
    {
        cout << getCBitValue(*iter);
    }
    cout <<  "\n"<<"b=\t" << b << endl;
    return;
}
                                    </pre>
                            </div>
                        </div>
                    </div>
                </div>



            <#--HHL算法-->
                <div class="algCollCode  ">
                    <div class="altContentTitle">HHL算法</div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n_info">
                                量子计算机利用诸如叠加和纠缠之类的量子力学现象来进行计算。
                                这在经典计算机上是无法计算的，量子算法在其经典计算对比下，
                                呈指数级加速。Harrow, Hassidim和Lloyd（HHL）提出了一种求解线性系统$Ax=b$(其中A是算子，
                                x，b是向量)中$x$信息的量子线性系统分析。HHL算法解决了什么样的问题？那就是求解线性方程的问题，
                                众所周知，线性系统是很多科学和工程领域的核心，由于HHL算法在特定条件下实现了相较于经典算法有指数加速效果，
                                从而未来能够在机器学习、数值计算等场景有优势体现。配合Grover算法在数据方面的加速，将是未来量子机器学习，
                                人工智等科技得以突破的关键性技术。
                            </div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">HHL算法的输入和输出:</div>
                                <div class="alt_n2_info">
                                    <p>输入：一个n*n的矩阵A和一个n维向量b。</p>
                                    <p> 输出：n维向量x，满足Ax=b。</p>
                                    <div class="alt_n2_img" style="padding-bottom: 25px">
                                        <img src="${base}/assets/images/algHhl1.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="alt_n2">
                                <div class="alt_n2_title">HHL的的限制条件的：</div>
                                <div class="alt_n2_info">
                                    <p>1.输入的矩阵，必须是adjoint矩阵，当A不是Hermitian时，需要构造成adjoint矩阵。算法的输入部分如图1中红色方框所标出。输入q[2]存放在底部寄存器中，输入A作为相位估计中酉算子的一个组成部分。</p>
                                    <p style="padding-top: 18px"> 2.输出x的形式：算法的输出如红色部分标出（同一个寄存器）。底部寄存器存放的是一个蕴含了向量x的量子态。 此处不需要知道这个状态具体情况。</p>
                                </div>
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <div class="alt_n_img">
                                <img src="${base}/assets/images/algHhl2.png" alt="">
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <div class="alt_n_code">
                                    <pre>
#include "HHL_Algorithm.h"

void HHL_Algorithm()
{
    map&lt;string, bool> temp;
    int x0 = 0;
    int x1 = 0;
    for (size_t i = 0; i < 1000;i++)
    {
        temp = hhlalgorithm();
        if (temp["c0"])
        {
            if (temp["c1"])
            {
                x1++;
            }
            else
            {
                x0++;
            }
        }
    }
    int sum = x0 + x1;
    cout << "prob0:" << x0*1.0/sum << endl;
    cout << "prob1:" << x1*1.0/sum << endl;
}

map&lt;string, bool> hhlalgorithm()
{
    init();
    int qubitnum = 4;
    vector&lt;Qubit*> qv;
    for (size_t i = 0; i < qubitnum; i++)
    {
        qv.push_back(qAlloc());
    }
    vector&lt;CBit*> cv;
    int cbitnum = 2;
    for (size_t i = 0; i < cbitnum; i++)
    {
        cv.push_back(cAlloc());
    }
    auto hhlprog =CreateEmptyQProg();
    hhlprog << RY(qv[3], PI / 2);       //  change vecotr b in equation Ax=b
    hhlprog << hhl(qv, cv);
    load(hhlprog);
    run();
    auto resultMap = getResultMap();
    finalize();
    return resultMap;
}

int HHL_Test(int repeat)
{
	try
	{
		init();
		int qubitnum = 4;
		vector&lt;Qubit*> qv;
		for (size_t i = 0u; i < qubitnum; i++)
		{
			qv.push_back(qAlloc());
		}
		vector&lt;CBit*> cv;
		int cbitnum = 2;
		for (size_t i = 0u; i < cbitnum; i++)
		{
			cv.push_back(cAlloc());
		}
		auto hhlprog = CreateEmptyQProg();
		hhlprog << RY(qv[3], PI / 2);
		hhlprog << hhl(qv, cv);
		load(hhlprog);

		int x0 = 0;
		int x1 = 1;
		for (size_t i = 0u; i < repeat; ++i)
		{
			run();
			auto resultMap = getResultMap();
			if (resultMap["c0"])
			{
				if (resultMap["c1"])
				{
					x1++;
				}
				else
				{
					x0++;
				}
			}
		}
		finalize();
		cout << "x0: " << x0 << endl
			<< "x1: " << x1 << endl;
	}
	catch (QPandaException &e)
	{
		cout << e.what();
		return 1;
	}
	return 0;
}


QProg hhl(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec)
{
    ClassicalCondition cc0=bind_a_cbit(cVec[0]);

	// meaningless sentence
    QCircuit  ifcircuit = CreateEmptyCircuit();

    QCircuit  PSEcircuit = hhlPse(qVec);//PSE
    QCircuit  CRot = CRotate(qVec);//control-lambda
    QCircuit  PSEcircuitdag = hhlPse(qVec);
    //hhl circuit
    QProg  PSEdagger = CreateEmptyQProg();

    PSEdagger << PSEcircuitdag.dagger() << Measure(qVec[3], cVec[1]);
    QIfProg  ifnode = CreateIfProg(cc0, &PSEdagger);
    QProg  hhlProg = CreateEmptyQProg();
    //hhlProg << PSEcircuit <&lt;CRot<<  Measure(qVec[0], cVec[0])<&lt;ifnode;
    hhlProg << PSEcircuit << CRot << Measure(qVec[0], cVec[0]) << ifnode;
    return hhlProg;
}
QCircuit hhlPse(vector&lt;Qubit*> qVec)
{
    QCircuit  PSEcircuit = CreateEmptyCircuit();
    PSEcircuit << H(qVec[1]) << H(qVec[2]) << RZ(qVec[2], 0.75*PI);
    QGate  gat1 = CU(PI, 1.5*PI, -0.5*PI, PI / 2, qVec[2], qVec[3]);
    QGate   gat2 = CU(PI, 1.5*PI, -PI, PI / 2, qVec[1], qVec[3]);
    PSEcircuit << gat1 << RZ(qVec[1], 1.5*PI) << gat2;
    PSEcircuit << CNOT(qVec[1], qVec[2]) << CNOT(qVec[2], qVec[1]) << CNOT(qVec[1], qVec[2]);
    //PSEcircuit << gat1 << RZ_GATE(q1, 1.5*PI)<&lt;gat2 ;
QGate  gat3 = CU(-0.25*PI, -0.5*PI, 0, 0, qVec[2], qVec[1]);
PSEcircuit << H(qVec[2]) << gat3 << H(qVec[1]);     //PSE over
    return PSEcircuit;
}
QCircuit CRotate(vector<Qubit*> qVec)
{
    QCircuit  CRot = CreateEmptyCircuit();
    vector&lt;Qubit *> controlVector;
    controlVector.push_back(qVec[1]);
    controlVector.push_back(qVec[2]);
    QGate  gat4 = RY(qVec[0], PI);
    gat4.setControl(controlVector);
    QGate  gat5 = RY(qVec[0], PI / 3);
    gat5.setControl(controlVector);
    QGate  gat6 = RY(qVec[0], 0.679673818908);  //arcsin(1/3)
    gat6.setControl(controlVector);
    CRot << X(qVec[1]) << gat4 << X(qVec[1]) << X(qVec[2]) << gat5 << X(qVec[2]) << gat6;
    //CRot << X(qVec[1]) << gat4 << X(qVec[1]);
    return CRot;
}
                                    </pre>
                            </div>
                        </div>
                    </div>
                </div>

            <#--cc-->
                <div class="algCollCode ">
                    <div class="altContentTitle">Counterfeit Coin Problem</div>
                    <div class="alt_n_con">
                        <div class="alt_n">
                            <div class="alt_n_title">问题描述</div>
                            <div class="alt_n_info">
                                E.D.Schell在1945年1月版的美国数学月刊上提出了假币问题，初始问题是给定
                                一定数量的硬币，其中一枚假币的质量和其他真币的质量不一样（外形一
                                样，但质量轻），给定一个天平，可用来确定哪一枚是假币（通过天平的倾斜与否来判断重量差异）。
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">理解问题：</div>
                            <div class="alt_n_info"></div>

                            <div class="alt_n2">
                                <div class="alt_n2_title">假设给定10枚硬币，其中一枚硬币是假的，质量比真硬币轻。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc1.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第一步，将10枚硬币均分为两组，每一组包含5个硬币：</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc2.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第二步，使用天平来判断：</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc3.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第三步：根据倾斜程度，可以判断假币在哪一个分组里，如下图，假硬币在左侧。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc4.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第四步，将包含假币的5枚硬币拿出来。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc5.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第五步，将5枚硬币划分为2组2枚的，外加单独1枚。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc6.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第六步，把2组硬币放入天平，查看天平倾斜情况。如果天平，持平，则额外的哪一枚是假币。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc7.png" alt="" style="width:auto;">
                                    </div>
                                </div>

                                <div class="alt_n2_title">第七步，判断天平倾斜情况，如果是下面的情况，表明左侧包含了假币。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc8.png" alt="" style="width:auto;">
                                    </div>
                                </div>
                                <div class="alt_n2_title">第八步，判断可能包含假币的两枚，分别放入天平两侧，一次性就可以判断出真假。</div>
                                <div class="alt_n2_info">
                                    <div class="alt_n2_img">
                                        <img src="${base}/assets/images/algCc9.png" alt="" style="width:auto;" >
                                    </div>
                                </div>
                                <div class="alt_n2_title" >如上问题是对十个硬币的判断。（如上参考维基百科）</div>
                                <div class="alt_n2_info">
                                    当然，该问题在不同的参考文献里有不同的版本，本实验算法里假设：
                                    <p>1.真币的重量均等，假币的质量也均等，假币的质量比真币轻。</p>
                                    <p>2.天平只给我们提供两个信息，平衡（两组币的重量相同）或倾斜。</p>
                                </div>
                                <div class="alt_n2_info" style="padding: 10px 0">
                                    算法简述：给定N个外形一样的硬币，其中有k个假币，真币的质量均相等，假币质量轻。
                                </div>
                                <div class="alt_n2_inof">算法目标：找出这k个假币。</div>
                                <div class="alt_n2_info" style="padding-top: 10px ">策略：·</div>
                                <div class="alt_n2_info">
                                    本实验算法主要是Berstein 和 Vazirani 奇偶校验问题的一个应用，在经典策略里面，每次测量只能有一次，左右两边相同数的硬币数判断。而量子算法是通过构建叠加态从而对经典策略基础上的改进，我们可以同时查询叠加的左右两边状态。</div>
                            </div>

                        </div>

                        <div class="alt_n">
                            <div class="alt_n_title">量子策略模型简述：</div>
                            <div class="alt_n_info">
                                在该问题里，平衡的天平模型可以用一个Oracle来刻画。简称B-Oracle(Balance Oracle)，它是一个N位的寄存器：$x_1x_2...x_N \in \{0,1\}^N$，
                                为了检索这些值，我们需要做一个查询（Query）,查询字符$q_1q_2...q_n \in \{0,1,-1\}^N$,其中包括相同数量的1和-1（数量定义为$L$）。该Oracle返回1位的答案$X$，定义如下：
                            </div>
                            <div class="alt_n_info">
                            <#--$$ X=\begin{Bmatrix}1&\sum_{i=1}^{N}{x_iq_i=0}\\0&Otherwise\end{Bmatrix} $$-->

                                $$X=\left\{\begin{matrix}
                                1&\sum_{i=1}^{N}{x_iq_i=0}\\0&Otherwise
                                \end{matrix}\right.$$
                            </div>
                            <div class="alt_n_info">考虑$x_1x_2...x_N$表示N个硬币，而且0表示硬币质量均等，1表示有一个假币。因此，$q_i=1$意味着我们把硬币$x_i$放在天平右侧，$q_i=-1$则表示将$x_i$放在左侧盘里。这个时候我们必须保证，有相同数量的1和-1（天平里左右两侧放入相同数量的硬币），答案$X$正确的模拟了天平秤。如：</div>
                            <div class="alt_n_info">$X=0$</div>
                            <div class="alt_n_info">则表示天平两边相等，反之$X=1$表示倾斜。</div>
                            <div class="alt_n_info">有效的构造转化W(这里的思想可以参考Gervor算法). 从上面我们也可看出，如果N个硬币里包含了k（k大于1）个假币，那么Find(k)的复杂度是多项式时间复杂，我们已经在Bernstein-Vazirani算法接触了k=2的情况（请参考我们算法库里的Bernstein-Vazirani Algorithm ）。本算法主要目的是展示量子算法的优越性，因此只考虑包含一个假币的情况（即k=1）。</div>
                            <div class="alt_n_info">在参考论文里[2]，查找所有 k 假硬币的量子查询复杂度是入下表, 给定输入如上描述。</div>
                            <div class="alt_n_img"><img src="${base}/assets/images/algCc10.png" alt=""></div>
                            <div class="alt_n_info">通过上表，比较清晰的展示了量子策略的优越性，尤其在多假币的情况下，当然，我们一个假币的情况，但是在硬币为N的时候，量子测量一次就可以完成。
                                一个假币的情况，详情请看Counterfeit Coin Game的参考线路图：</div>

                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考线路图：</div>
                            <div class="alt_n_img">
                                <img src="${base}/assets/images/algCc11.png" alt="">
                                <p style="text-align: left">线路说明：紫色的if表示的是测量判断，根据输出的经典信息来判断是否需要执行下一步的操作。上面线路图里判定条
                                    件，如果输出为0的时候，则需要执行0 对应的操作，实际上就是从新执
                                    行一遍量子线路，反之，执行$U_f$操作，$U_f$指代了错误币所在位置的控制非门，目标位最后一位。</p>
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考代码：</div>
                            <div class="alt_n_code">
                                    <pre>
QProg counterfeitCoin_QProg(vector&lt;Qubit*> qVec, vector&lt;CBit*> cVec, int position)
{
    QProg prog = CreateEmptyQProg();
    QProg endprog = CreateEmptyQProg();
    QProg whileprog = CreateEmptyQProg();
    QCircuit qcir = CreateEmptyCircuit();
    ClassicalCondition cc = bind_a_cbit(cVec[cVec.size() - 1]);
    for (auto iter = qVec.begin(); iter != qVec.end() - 1; iter++)
    {
        qcir << H(*iter);
        endprog << H(*iter);
    }
    for (auto iter = qVec.begin(); iter != qVec.end() - 1; iter++)
    {
        endprog << Measure(*iter, cVec[iter - qVec.begin()]);
    }
    for (auto iter = qVec.begin(); iter != qVec.end() - 1; iter++)
    {
        qcir << CNOT(*iter, *(qVec.end() - 1));
    }
    whileprog << qcir << Measure(qVec[qVec.size() - 1], cVec[cVec.size() - 1]);
    QWhileProg WhileNode = CreateWhileProg(cc, &whileprog);
    QIfProg ifnode = CreateIfProg(cc, &endprog);
    prog << qcir << Measure(qVec[qVec.size() - 1], cVec[cVec.size() - 1]) << WhileNode
        << X(qVec[qVec.size() - 1]) << H(qVec[qVec.size() - 1])
        << CNOT(qVec[position], qVec[cVec.size() - 1])
        << endprog;
    return prog;
}

void counterfeitCoinGame()
{
    cout << "Counterfeit Coin Game Algorithm\n" << endl;
    cout << "eight coins ,one coin is counterfeit" << endl;
    cout << "choose the position of the counterfeit coin(0~7)" << endl;
    int position;
    cin >> position;
    cout<<" Programming the circuit..." << endl;
    init();
    vector&lt;Qubit*> qVec;
    vector&lt;CBit*> cVec;
    for (auto i = 0; i < 9 ; i++)
    {
        qVec.push_back(qAlloc());
        cVec.push_back(cAlloc());
    }
    auto ccAlgorithm = counterfeitCoin_QProg(qVec, cVec, position);
    append(ccAlgorithm);
    bool isSuccess=true;
    run();
    int itemp = 0;
    for (auto i = 0; i < cVec.size() - 1; i++)
    {
        if (getCBitValue(cVec[i]))
        {
            itemp++;
        }
    }
    if (itemp > 1)
    {
        for (auto i = 0; i < cVec.size() - 1; i++)
        {
            if (!getCBitValue(cVec[i]))
            {
                cout << "The position of counterfeit coin is :" << i << endl;
            }
        }
    }
    else
    {
        for (auto i = 0; i < cVec.size() - 1; i++)
        {
            if (getCBitValue(cVec[i]))
            {
                cout << "The position of counterfeit coin is :" << i << endl;
            }
        }
    }
    return;
}
                                    </pre>
                            </div>
                        </div>
                        <div class="alt_n">
                            <div class="alt_n_title">参考文献</div>
                            <div class="alt_n_info">
                                <p>[1].https://en.wikipedia.org/wiki/Balance_puzzle</p>
                                <p>[2].《Quantum Counterfeit Coin Problems》</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

<!--box end-->
</div>
</div>
</#escape>
</@main.body>

<script src="${base}/assets/js/jquery.nicescroll.min.js"></script>
<script>
    $(function () {


        var hashNum= Number(window.location.hash.slice(1));
        if(hashNum>0&&hashNum<7){
            $(".news-box").hide();
            $(".algCollCode").eq(hashNum-1).addClass("active").siblings().removeClass("active");
        }
        $(".alt_n_code").niceScroll({

            cursorcolor: "#535353", // 改变滚动条颜色，使用16进制颜色值
            cursoropacitymin: 1, // 当滚动条是隐藏状态时改变透明度, 值范围 1 到 0
            cursoropacitymax: 1, // 当滚动条是显示状态时改变透明度, 值范围 1 到 0
            cursorwidth: "8px", // 滚动条的宽度，单位：便素
            cursorborder: "", // CSS方式定义滚动条边框
            cursorborderradius: "", // 滚动条圆角（像素）
            scrollspeed: 60, // 滚动速度
            mousescrollstep: 40, // 鼠标滚轮的滚动速度 (像素)
            touchbehavior: false, // 激活拖拽滚动
            hwacceleration: true, // 激活硬件加速
            background: "#e1e1e1",// 轨道的背景颜色
            autohidemode: false, // 隐藏滚动条的方式, 可用的值:
            // true | // 无滚动时隐藏
            // "cursor" | // 隐藏
            // false | // 不隐藏,
            // "leave" | // 仅在指针离开内容时隐藏
            // "hidden" | // 一直隐藏
            // "scroll", // 仅在滚动时显示
            railoffset:false
        });  // free your immagination
    })

</script>

