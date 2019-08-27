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
                                <a href="#one">简介</a>
                            </li>
                            <li>
                                <a href="#two">Oracle是什么？</a>
                            </li>
                            <li>
                                <a href="#three">Grover搜索算法</a>
                            </li>
                            <li>
                                <a href="#four">Shor算法分解质因数</a>
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
                        <span>量子算法</span>
                    </div>
                </div>
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
                    <em>
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
                        \end{matrix}\right)\\
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
                    <em>
                        $$\begin{align*}
                        (|0\rangle+|1\rangle)\otimes(|0\rangle+|1\rangle)&=|00\rangle+|01\rangle+|10\rangle+|11\rangle\\
                        &=|0\rangle+|1\rangle+|2\rangle+|3\rangle
                        \end{align*}$$
                    </em>
                    <em>
                        第二个等式单纯是二进制到十进制的转换。这样我们就得到了2位量子态所有情况的和。并且所有的相位项都为1。在此基础上再直积一个 $|0\rangle+|1\rangle$，就得到了3位量子态所有情况的和，即 $0\sim 7$ ……最后，一直直积n次，就可以得到 $0\sim 2^n-1$ 的态之和。这样，我们得到所有比特的共同量子态表达式为
                    </em>
                    <em>
                        $$|\text{Working}\rangle|\text{Ancilla}\rangle=\left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\rangle-|1\rangle\right)$$
                    </em>
                    <em>第三步，将这个系统通过代表这个黑盒子的Oracle。Oracle是一种酉变换，它具有如下的形式</em>
                    <em>$\text{Oracle}:\quad |x\rangle|y\rangle\rightarrow |x\rangle|y\oplus f(x)\rangle$</em>
                    <em>（如果你不能理解为什么Oracle要写成这种形式，请看下一章“Oracle是什么”。）</em>
                    <em>Oracle中的 $f(x)$ 是n位输入，1位输出的函数，也就是这个黑盒子的函数形式。其中 $\oplus$ 代表模2加法（异或）。所以，将量子态通过Oracle的时候，我们会得到：</em>
                    <em>
                        $$\begin{align*}
                        \text{Oracle}&:\quad|\text{Working}\rangle|\text{Ancilla}\rangle\\
                        &\rightarrow \left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\oplus f(x)\rangle-|1\oplus f(x)\rangle\right)\\
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
                    <em>
                        $$\begin{align*}
                        H^{\otimes n}\left(\sum_{x=0}^{2^n-1} (-1)^{f(x)}|x\rangle\right)&=\sum_{x=0}^{2^n-1} (-1)^{f(x)}\sum_{y=0}^{2^n-1}(-1)^{x\cdot y}|y\rangle\\
                        &=\sum_{x,y=0\sim 2^n-1}(-1)^{f(x)+x\cdot y}|y\rangle
                        \end{align*}$$
                    </em>
                    <em>因为我们仅考察测量结果是否全部为0，所以令 $|y\rangle=|0\rangle^{\otimes n}$，计算这个分量上的系数，即</em>
                    <em>
                        $$P(y=0)=|\sum_{x=0}^{2^n-1}(-1)^{f(x)}|^2=\begin{cases}
                        1\quad f(x)\text{为常数}\\
                        0\quad f(x)\text{为平衡}\\
                        \end{cases}$$
                    </em>
                    <em>所以要么概率为1，要么概率正好一半一半抵消掉变成0。至此就是D-J算法的完全描述。我们发现量子算法的不同点在于它向黑盒子内部输入的是叠加态，所以只需要一步计算就能得到问题的答案。</em>
                    <em style="text-align:center">
                        <img style="max-width: 805px" src="${base}/assets/images/liang05.png"/>
                    </em>
                    <em>经典算法的验证次数是  $O(2^n)$ 的，量子算法算上叠加态的准备和测量的时间，需要的操作步骤为 $O(n)$。所以我们说明量子算法相对于经典算法具有指数级别加速的特性。</em>
                    <em id="two">D-J算法的问题在于它解决的问题既不实用，又具有很大的限制（要求平衡函数中必须恰好为一半0一半1）。另外，我们还对黑盒子本身的形态有要求。所以说D-J算法的理论意义是远大于其实用意义的。真正实用的量子算法将在后面进行介绍。</em>
                    <h2 >Oracle是什么？</h2>
                    <em>在介绍其它的量子算法之前，我们要对Oracle进行一些必要的说明。</em>
                    <em>最早在图灵的博士论文中，提到了一种新的计算模型：
                        “假定我们拥有某种解决数论问题的未知方法；比如说某种谕示。我们不深入这个谕示的本质，除了它不可能是一台机器这一点。通过谕示的帮助，我们可以构筑一种新的机器，它的基本过程之一就是解决某个给定的数论问题。”</em>
                    <em>图灵的这一段话描述的“谕示”即为Oracle。因为Oracle本身就能解决某种问题，在我们不深入Oracle本身时，我们可以通过Oracle扩展我们的计算能力。</em>
                    <em>这里的D-J算法，包括其它的某些量子算法都借用了图灵提到的这种新模型：谕示机。这里的Oracle是一种酉变换。它通常具有下面的两种形式：</em>
                    <em>
                        $$\begin{align*}
                        \text{Oracle}:\quad |x\rangle|y\rangle&=|x\rangle|y+f(x)\rangle\\
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
                            $$|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})\xrightarrow{\text{Oracle}}(-1)^{f(x)}|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})$$
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
                            $$H^{\bigotimes n}(2|0\rangle\langle0|-I)H^{\bigotimes n}=2|\psi\rangle\langle\psi|-I$$
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
                            $$G^k|\psi\rangle=cos(\frac{2k+1}{2}\theta)|\alpha\rangle+sin(\frac{2k+1}{2}\theta)|\beta\rangle$$
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
                        <em>
                            $$7^x=7^{x_0+2x_1+2^2x_2+...}=7^{x_0}\cdot(7^2)^{x_1}\cdot(7^4)^{x_2}...\cdot(7^{2^n})^{x_n}$$
                        </em>
                        <em>
                            $x_i$ 是x转换为二进制后每一位上对应的数码，所以它的取值无非是0或者1。这样我们就可以简单的用一个控制酉操作得到每一项，即</em>
                        <em>
                            $$\begin{align*}
                            |x_i\rangle&=|1\rangle \ :\ U_a|y\rangle\rightarrow|y\cdot 7^{2^i} (mod15)\rangle\\
                            |x_i\rangle&=|0\rangle \ :\ U_a=I
                            \end{align*}$$
                        </em>
                        <em>其中 $I$ 是单位操作。所以问题就转化为了构建“控制模乘”操作 $U_a$。
                        </em>
                        <em>
                            顺带一提，因为我们关注的点不是如何纯粹的用量子线路来描述里面的每一步操作，某些操作也不引入额外的计算时间复杂度，那么这些操作是可以用经典计算机代为完成的。就比如说这里的 $7^{2^i}$。注意到
                        </em>
                        <em>
                            $$y\cdot 7^{2^i}(mod15)=(y\cdot (7^{2^i}mod15))mod15$$
                        </em>
                        <em>
                            我们只需要事先用经典计算机将 $7^{2^i}mod15(i=0\sim N-1)$（N是选取的工作位数）全部计算出来，就可以在接下来的设计时只考虑对应的几种情况。</em>
                        <em>我们可以看出， $a^{2^i}=a^{2^{i-1}+2^{i-1}}=(a^{2^{i-1}})^2$，根据这个公式，可以列举出来对于不同的 $i$ 的取值情况，上述表达式的取值（这个过程用经典计算机就可以完成）。在例子中的这种情况中，有</em>
                        <em>
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
                        <em>
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
                        <em>
                            $$|x\rangle|f(x)\rangle+|x+T\rangle|f(x+T)\rangle+|x+2T\rangle|f(x+2T)\rangle+...=\left(|x\rangle+|x+T\rangle+|x+2T\rangle+...\right)|f(x)\rangle$$
                        </em>
                        <em>回到 $a=7$， $N=15$的例子中，我们有</em>
                        <em>
                            $$\begin{align*}
                            |\text{Working}\rangle|\text{Ancilla}\rangle&=(|0\rangle+|4\rangle+|8\rangle+...)|1\rangle\\
                            &+(|1\rangle+|5\rangle+|9\rangle+...)|7\rangle\\
                            &+(|2\rangle+|6\rangle+|10\rangle+...)|4\rangle\\
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
                        <em>
                            $$F_N = \frac{1}{\sqrt{N}} \begin{bmatrix}
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
                        <em>
                            $$\begin{align*}
                            y_k &= \frac{1}{\sqrt{4}} (\omega^{0k}+\omega^{4k}+\omega^{8k}+\omega^{12k})\\
                            &=\frac{1}{2}(1+i^k+(-1)^k+(-i)^k)
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
            </div>
        </div>

    </div>
    <div class="news-content" style="width:68%;display: none">
        <div class="news-text">
        	<div id="loading"><h4>加载中，请稍后....</h4></div>
            <div class="news-box" style="opacity:1">
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
                <em>
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
                        \end{matrix}\right)\\
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
                <em>
                	$$\begin{align*}
						(|0\rangle+|1\rangle)\otimes(|0\rangle+|1\rangle)&=|00\rangle+|01\rangle+|10\rangle+|11\rangle\\
						&=|0\rangle+|1\rangle+|2\rangle+|3\rangle
					\end{align*}$$
                </em>
                <em>
                    第二个等式单纯是二进制到十进制的转换。这样我们就得到了2位量子态所有情况的和。并且所有的相位项都为1。在此基础上再直积一个 $|0\rangle+|1\rangle$，就得到了3位量子态所有情况的和，即 $0\sim 7$ ……最后，一直直积n次，就可以得到 $0\sim 2^n-1$ 的态之和。这样，我们得到所有比特的共同量子态表达式为
                </em>
                <em>
                    $$|\text{Working}\rangle|\text{Ancilla}\rangle=\left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\rangle-|1\rangle\right)$$
                </em>
                <em>第三步，将这个系统通过代表这个黑盒子的Oracle。Oracle是一种酉变换，它具有如下的形式</em>
                <em>$\text{Oracle}:\quad |x\rangle|y\rangle\rightarrow |x\rangle|y\oplus f(x)\rangle$</em>
                <em>（如果你不能理解为什么Oracle要写成这种形式，请看下一章“Oracle是什么”。）</em>
                <em>Oracle中的 $f(x)$ 是n位输入，1位输出的函数，也就是这个黑盒子的函数形式。其中 $\oplus$ 代表模2加法（异或）。所以，将量子态通过Oracle的时候，我们会得到：</em>
                <em>
                	$$\begin{align*}
                    \text{Oracle}&:\quad|\text{Working}\rangle|\text{Ancilla}\rangle\\
                    &\rightarrow \left(\sum_{x=0}^{2^n-1} |x\rangle\right)\left(|0\oplus f(x)\rangle-|1\oplus f(x)\rangle\right)\\
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
                <em>
                	$$\begin{align*}
						H^{\otimes n}\left(\sum_{x=0}^{2^n-1} (-1)^{f(x)}|x\rangle\right)&=\sum_{x=0}^{2^n-1} (-1)^{f(x)}\sum_{y=0}^{2^n-1}(-1)^{x\cdot y}|y\rangle\\
						&=\sum_{x,y=0\sim 2^n-1}(-1)^{f(x)+x\cdot y}|y\rangle
					\end{align*}$$                    
                </em>
                <em>因为我们仅考察测量结果是否全部为0，所以令 $|y\rangle=|0\rangle^{\otimes n}$，计算这个分量上的系数，即</em>
                <em>
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
                <em>
                    $$\begin{align*}
                        \text{Oracle}:\quad |x\rangle|y\rangle&=|x\rangle|y+f(x)\rangle\\
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
					$$|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})\xrightarrow{\text{Oracle}}(-1)^{f(x)}|x\rangle(\frac{|0\rangle-|1\rangle}{\sqrt{2}})$$                 
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
        			$$H^{\bigotimes n}(2|0\rangle\langle0|-I)H^{\bigotimes n}=2|\psi\rangle\langle\psi|-I$$
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
                	$$G^k|\psi\rangle=cos(\frac{2k+1}{2}\theta)|\alpha\rangle+sin(\frac{2k+1}{2}\theta)|\beta\rangle$$
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
                <em>
                    $$7^x=7^{x_0+2x_1+2^2x_2+...}=7^{x_0}\cdot(7^2)^{x_1}\cdot(7^4)^{x_2}...\cdot(7^{2^n})^{x_n}$$
                </em>
                <em>
                    $x_i$ 是x转换为二进制后每一位上对应的数码，所以它的取值无非是0或者1。这样我们就可以简单的用一个控制酉操作得到每一项，即</em>
                <em>
                    $$\begin{align*}
                    	|x_i\rangle&=|1\rangle \ :\ U_a|y\rangle\rightarrow|y\cdot 7^{2^i} (mod15)\rangle\\
                    	|x_i\rangle&=|0\rangle \ :\ U_a=I
                    \end{align*}$$
				</em>
                <em>其中 $I$ 是单位操作。所以问题就转化为了构建“控制模乘”操作 $U_a$。
                </em>
                <em>
                                                  顺带一提，因为我们关注的点不是如何纯粹的用量子线路来描述里面的每一步操作，某些操作也不引入额外的计算时间复杂度，那么这些操作是可以用经典计算机代为完成的。就比如说这里的 $7^{2^i}$。注意到
                </em>
                <em>
                    $$y\cdot 7^{2^i}(mod15)=(y\cdot (7^{2^i}mod15))mod15$$
                </em>
                <em>
                                                  我们只需要事先用经典计算机将 $7^{2^i}mod15(i=0\sim N-1)$（N是选取的工作位数）全部计算出来，就可以在接下来的设计时只考虑对应的几种情况。</em>
                <em>我们可以看出， $a^{2^i}=a^{2^{i-1}+2^{i-1}}=(a^{2^{i-1}})^2$，根据这个公式，可以列举出来对于不同的 $i$ 的取值情况，上述表达式的取值（这个过程用经典计算机就可以完成）。在例子中的这种情况中，有</em>
                <em>
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
                <em>
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
                <em>
                    $$|x\rangle|f(x)\rangle+|x+T\rangle|f(x+T)\rangle+|x+2T\rangle|f(x+2T)\rangle+...=\left(|x\rangle+|x+T\rangle+|x+2T\rangle+...\right)|f(x)\rangle$$
                </em>
                <em>回到 $a=7$， $N=15$的例子中，我们有</em>
                <em>
                	$$\begin{align*}
                    	|\text{Working}\rangle|\text{Ancilla}\rangle&=(|0\rangle+|4\rangle+|8\rangle+...)|1\rangle\\
                    	&+(|1\rangle+|5\rangle+|9\rangle+...)|7\rangle\\
                    	&+(|2\rangle+|6\rangle+|10\rangle+...)|4\rangle\\
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
                <em>
                	$$F_N = \frac{1}{\sqrt{N}} \begin{bmatrix}
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
                <em>
                	$$\begin{align*}
                    	y_k &= \frac{1}{\sqrt{4}} (\omega^{0k}+\omega^{4k}+\omega^{8k}+\omega^{12k})\\
                    	&=\frac{1}{2}(1+i^k+(-1)^k+(-i)^k)
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
                <em>Shor算法首先把问题分解为了“经典计算机部分”和“量子计算机部分”。然后利用了量子态的叠加原理，快速取得了函数在一个很大范围内的取值（对于 $N$ 个工作比特而言，取值范围为 $0\sim2^N-1$。由于函数本身是周期的，所以自变量和函数值自动地纠缠了起来，从而对于某一个函数值来说，工作比特上的态就是一组周期数态的叠加态。在取得“周期数叠加态”之后，我们自然可以通过傅里叶变换得到这组周期数的周期，从而快速解决了这个问题。
                </em>
                <em>反过来看，之所以找函数周期问题能被量子计算机快速解决，是因为在工作比特上执行了一组Hadamard变换。它在“量子函数”的作用下，相当于同时对指数级别的自变量上求出了函数值。在数据量足够大，周期足够长的情况下，这样执行的操作总量一定会小于逐个取值寻找这个函数值在之前是否出现过——这样的经典计算机“暴力破解”法要快得多。</em>
                <em>Shor算法的难点在于如何通过给出的 $a$，$N$ 来得到对应的“量子函数”形式。进一步地讲，是否存在某种方法（准确地说是具有合理时间复杂度的方法）得到任意函数的“量子计算机版本”？限于笔者知识水平不足，我只能给出目前大概的研究结论是存在某些无法表示为量子计算机版本的函数，但是幸运地是Shor算法属于可以表示的那一类里面。</em>
                <em>最后，我们可以发现，量子计算机之所以快，和量子计算机本身的叠加特性有关，它使得在处理特定问题时，比如数据库搜索，比如函数求周期……有着比经典计算机快得多的方法。但是如果经典计算机在解决某个问题时已经足够快了，我们就不需要用量子计算机来解决了。</em>
                <em>就像Shor算法里面所描述的那样——我们将问题分解为了量子计算机去处理的“困难问题”和经典计算机去处理的“简单问题”两个部分一样。所以，量子计算机的出现，不代表经典计算机将会退出历史舞台，而是代表着人类将要向经典计算机力所不及的地方伸出探索之手。靠着量子计算机，或许我们能提出新的算法解决化学问题，从而研制出新型药物；或许我们可以建立包含所有信息的数据库，每次只需要一瞬间就能搜索到任何问题……量子云平台是我们帮助量子计算机走出的第一步，但接下来的路怎么走，我们就要和你一同见证了。
                </em>
            </div>
            </div>
        </div>
    </div>
    <div class="news-rights">
        <div class="rh"><h4><strong>章节</strong></h4></div>
        <ul>
            <li class="n-cur">
                <a href="#one">
                    <h5>Deutsch-Jozsa算法<p class="f12 f999 ">  Deutsch-Jozsa Algorithm </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#two">
                    <h5>Oracle是什么？<p class="f12 f999 "> What is Oracle?
                    </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#three">
                    <h5>Grover搜索算法<p class="f12 f999 "> Grover's Searching Algorithm  </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#four">
                    <h5>Shor算法分解质因数<p class="f12 f999 "> Shor's algorithm for factoring </p></h5>
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
     $("#algorithm").addClass('active').siblings().removeClass('active')
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
