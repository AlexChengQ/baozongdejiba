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
        <@NewLeft title="量子算法"></@NewLeft>
        <div class="algRight">
            <div class="algRight_con">
                <div class="algRight_box">
                    <div class="jcTitle">文章导读目录:</div>
                    <div class="jcIndexList">
                        <ul>
                            <li class="active">
                                <a href="#one">态矢</a>
                            </li>
                            <li>
                                <a href="#two">两能级系统</a>
                            </li>
                            <li>
                                <a href="#three">叠加态和测量</a>
                            </li>
                            <li>
                                <a href="#four">相位、纯态和混合态 </a>
                            </li>
                            <li>
                                <a href="#five">密度矩阵和布洛赫球 </a>
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
                        <span>量子力学</span>
                    </div>
                </div>
                <div id="loading"><h4>加载中，请稍后....</h4></div>
                <div class="news-box" style="opacity:0">
                    <h1 class="blue">量子力学 Quantum Mechanics</h1>
                    <em id="one">我个人认为，如果要去理解量子计算本身的东西，数学的东西是逃不掉的。在前面一章里面，我只展现了量子世界的许多古怪性质。其实我们处理实际的量子计算问题的时候，不需要在这些问题上面追根问底。这一章里面，我会用数学的方式去将第一章里面的内容重新表述一遍。此时，我会假定读者拥有一定的数理基础，包括矢量概念，复数运算$(i^2=-1)$，简单的概率论；如果你对于矩阵运算的方法（行矢量、列矢量、矩阵转置、矩阵乘法）很熟悉的话，那当然更好。
                    </em>
                    <h2>态矢 State Vector</h2>
                    <h3>量子态的态矢描述</h3>
                    <em>
                        右矢
                        <p>$|\psi\rangle=\left[c_1,c_2,...,c_n\right]^T$</p>
                    </em>
                    <em>
                        左矢
                        <p>$\langle\psi|=\left[c_1^*,c_2^*,...,c_n^*\right]$</p>
                    </em>
                    <em>
                        我们采用竖线和尖括号的组合描述一个量子态，其中每一个分量都是复数，右上角标T表示转置。这样的描述表示量子态是一个矢量。右矢表示一个
                        $1\times n$ 的列矢量，左矢表示一个 $n\times 1$ 的行矢量。另外，在讨论同一个问题时，如果左矢和右矢在括号内的描述相同的话，那么这两个矢量互为转置共轭。
                    </em>
                    <h3>内积和外积</h3>
                    <em>对于任意的两个量子态</em>
                    <em>$|\alpha\rangle=\left[a_1,a_2,...,a_n\right]^T$</em>
                    <em>$|\beta\rangle=\left[b_1,b_2,...,b_n\right]^T$</em>
                    <em>内积</em>
                    <em>$\langle \alpha|\beta\rangle=\sum_n a_ib_i=$一个数</em>
                    <em id="two">外积</em>
                    <em>$|\alpha\rangle\langle\beta |=\left(a_ib_j\right)_{i,j}=n\times n $矩阵</em>
                    <h2>两能级系统 Two Level System</h2>
                    <em>事物的二元化：0和1、无和有、高和低、开和关、天和地、阴和阳、生和死、产生和消灭。二元化是一种将事物关系简化的哲学。基于二进制的计算理论正是利用了这种哲学思想。
                    </em>
                    <em>在谈论量子计算原理前，我们可以先来看一看经典计算机是怎么做的。我们知道，经典计算机就是在不断的处理0、1的二进制数码，它们代表着逻辑电路中的高低电平。对于这些二进制数码的产生、传输、处理、读取，最终反馈到像显示器这种输出设备上的信号，就是一个计算机的工作流程。</em>
                    <em>对于微观量子而言，我们有一个决定粒子性质的最直接的参量——它的能量。之前就已经说过，粒子的能量只会在几个分立的能级上面取值。并且我们现在限制取值的可能性种类为两种。这就构成了两能级系统。除了某些特殊的情况之外，这两个能级必定能找出来一个较低的，称之为基态<strong>(ground state)</strong>，记为 $|g\rangle$；另一个能量较高的，称之为激发态<strong>(excited state)</strong>，记为 $|e\rangle$。</em>
                    <em>所以量子计算机里面也是由0和1来构成量子比特，只不过这里是指量子态的 $|e\rangle$ 和 $|g\rangle$。这就是一个两能级系统的特征。以列矢量的方式将它们记为</em>
                    <em>$$|e\rangle=\left(
                        \begin{matrix}
                        1\\
                        0
                        \end{matrix}\right)
                        \quad
                        |g\rangle=\left(
                        \begin{matrix}
                        0\\
                        1
                        \end{matrix}\right)$$
                    </em>
                    <em id="three">行矢量的形式记为</em>
                    <em >$$\langle e|=(\begin{matrix}
                        1&&0
                        \end{matrix})
                        \quad
                        \langle g|=(\begin{matrix}
                        0&&1
                        \end{matrix})$$
                    </em>
                    <h2>叠加态和测量 Superposition State And Measurement</h2>
                    <em>按照态矢里面的描述，这两个矢量可以构成一个二维空间的基。任何一个态都可以写为这两个基在复数空间上的线性组合，即</em>
                    <em>$|\psi\rangle=\alpha|0\rangle+\beta e^{i\theta}|1\rangle$</em>
                    <em>其中 $e^{i\theta}$ 表示模为1幅角为 $\theta$ 的复数。</em>
                    <em>我们现在就可以给测量这件事情赋予数学上的含义了。我们定义测量就是将量子态 $|\psi\rangle$ 投影到另一个态 $|\alpha\rangle$ 上。获得这个态的概率是它们内积的平方，即</em>
                    <em>$P_\alpha=|\langle \psi|\alpha\rangle|^2$</em>
                    <em>其它概率下会将量子态投影到它的正交态上面去，即</em>
                    <em id="four">$P_{\alpha_\perp}=1-P_\alpha$</em>
                    <em>测量之后量子态就坍缩到测量到的态上面。</em>
                    <h2>相位、纯态和混合态 Phase, Pure State and Mixed State</h2>
                    <em>如果说我们有办法将量子态初始化到某一个未知的叠加态上面，我们能否通过反复的测量得到它的表达式呢？看下面这种两种情况：</em>
                    <em>$$|\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$$</em>
                    <em>$$|\psi_2\rangle=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)$$</em>
                    <em>我们会发现在 $|0\rangle$，$|1\rangle$ 的方向上测量，它们的表现都是一半概率为0，一半概率为1，根本不能区分。</em>
                    <em>这里我只是想提醒你相位是某种隐含的信息，从概率上无法表示的信息。实际上，量子态的相位是量子相干性的体现。关于量子相干性的更详细信息我会在接下来的部分介绍。</em>
                    <em>现在我们再来介绍另一种情况。想象我们左手抓着一个袋子，这个袋子里面有无数的量子态。他们全部都是 $|\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$ 这种叠加态。另外我们有一个机器可以在 $|0\rangle$，$|1\rangle$ 的方向上测量。</em>
                    <em>我们每次拿出来一个态，对它进行测量，不管它是 $|0\rangle$ 还是 $|1\rangle$，都扔到右手边的另一个袋子里面。反复这个过程，这样右边袋子里面的态越来越多了。因为我们的测量结果对于这两种情况是等概率的，所以右边的袋子里面约有一半的态是 $|0\rangle$，另一半是 $|1\rangle$。</em>
                    <em>我们从右手边的袋子里面取一个出来。在我们不知道手上的这个态是什么的情况下，我们能说它和左手边袋子里面的态一样都是 $\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$ 吗？</em>
                    <em>答案是不能。右边袋子里面的态实际上是一种经典的概率叠加，和等量的红球白球装在袋子里面一样。这样的态是不具有相位的。它只能表示为</em>
                    <em>$$\begin{cases}
                        |\psi\rangle=|0\rangle;\quad P=0.5\\
                        |\psi\rangle=|1\rangle;\quad P=0.5
                        \end{cases}$$
                    </em>
                    <em id="five">这种类似于概率列表的形式。</em>
                    <em>所以说，我们定义纯态就是“纯粹的量子态”，它不仅具有概率，还具有相位（也就是量子相干性）。混合态是纯态的概率性叠加，它往往失去了（部分或全部的）相位信息。</em>
                    <h2>密度矩阵和布洛赫球 Density Matrix And Bloch Sphere</h2>
                    <em>态矢是对纯态的描述，如果要描述一个混合态，就必须写成态集合和概率的列表形式，这样非常繁琐。所以我们采用密度矩阵来描述。</em>
                    <em>对于一个纯态而言，密度矩阵可以写为</em>
                    <em>$\rho=|\psi\rangle\langle \psi|$</em>
                    <em>而对于一个混合态而言，密度矩阵的形式是</em>
                    <em>$\rho=\sum_i P_i|\psi_i\rangle\langle \psi_i|$</em>
                    <em>其中 $\{P_i,\psi_i\}$ 是系统所处的态及其概率。</em>
                    <em>密度矩阵有以下的性质：</em>

                    <div class="four-box">
                        <ul>
                            <li>对于一个两能级体系表述的态，不论是纯的还是混合的，都可以用密度矩阵 $\rho$ 表示</li>
                            <li>$\rho=\rho^2$ 当且仅当量子态时纯态时成立</li>
                            <li>$\rho$ 对角线上的分量表示整个系统如果经历一次测量，那么得到这个态的概率。</li>
                            <li>我们如果只去操作和测量一个两能级体系，那么我们是分辨不出相同的密度矩阵的。</li>

                        </ul>
                    </div>
                    <em>密度矩阵已经完备地表示了一个两能级系统可能出现的任何状态。为了更加直观地理解量子叠加态与逻辑门的作用，引入布洛赫球的概念，它能够方便的表示一个量子比特的任意状态。</em>
                    <em style="text-align: center">
                        <img src="${base}/assets/images/b.png" />
                        <img src="${base}/assets/images/liang04.png" />
                    </em>
                    <em>如果量子态是一个纯态，那么它是球面上的点。点的z坐标衡量了它的 $|0\rangle$ 和 $|1\rangle$ 的概率，即</em>
                    <em>$$P(0)=\frac{1+z}{2}$$</em>
                    <em>$$P(1)=\frac{1-z}{2}$$</em>
                    <em>所以最上面表示 $|0\rangle$ 态，最下面表示 $|1\rangle$ 态。</em>
                    <em>再沿着平行于XY平面的方向，并且穿过这个点的Z坐标，可以得到一个圆。这个圆就象征着相位的复平面。所以这个点在这个圆上交X轴的角度就是单位复数的幅角。经过这个过程我们将每个纯态都与球面上的点一一对应了起来。</em>
                    <em>对于混合态而言，因为根据我们之前的描述，混合态实际上是多个纯态的经典统计概率的叠加。对于每一个纯态分量，我们连接球心和球面上的点，可以形成一个矢量。我们根据概率列表，对所有的纯态矢量进行加权平均，即可得到混合态的矢量，即得到了混合态对应的点。</em>
                    <em>混合态是球内部的点，根据混合的程度不同，矢量的长度也不同。最大混合态是球心。它意味着这里不存在任何量子叠加性。</em>
                    <em>例如(1,0,0)和(-1,0,0)点在布洛赫球上就是在X方向上的顶点和-X方向上的顶点。我们根据刚才的叙述，知道它们对应的量子态的概率分布就是Z坐标，即为0。所以，</em>
                    <em>$$P_0(|\psi_1\rangle)=P_0(|\psi_2\rangle)=0.5$$</em>
                    <em>沿XY平面横切，得到一个圆，我们可以看到这两个点对应的幅角是 $\theta_1=0$，$\theta_2=\pi$，所以我们就可以推断出来量子态分别为</em>
                    <em>$$\begin{align*}
                        |\psi\rangle_1&=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)\\
                        |\psi\rangle_2&=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)\\
                        \end{align*}$$
                    </em>
                    <em>如果将这两个态以1/2,1/2的概率混合，在布洛赫球上面的坐标将表示为(0,0,0)，也就是球心。对应到密度矩阵的表述，即为</em>
                    <em>
                        $$\rho=\frac{1}{2}|\psi_1\rangle\langle\psi_1|+\frac{1}{2}|\psi_2\rangle\langle\psi_2|=\left(\begin{matrix}0.5&&0\\0&&0.5\end{matrix}\right)$$
                    </em>
                    <em  id="">即为最大混合态。</em>

                </div>
            </div>
        </div>

    </div>
    <div class="news-content" style="width:68%;display: none">
        <div class="news-text">
        	<div id="loading"><h4>加载中，请稍后....</h4></div>
            <div class="news-box" style="opacity:0">
                <h1 class="blue">量子力学 Quantum Mechanics</h1>
                <em id="one">我个人认为，如果要去理解量子计算本身的东西，数学的东西是逃不掉的。在前面一章里面，我只展现了量子世界的许多古怪性质。其实我们处理实际的量子计算问题的时候，不需要在这些问题上面追根问底。这一章里面，我会用数学的方式去将第一章里面的内容重新表述一遍。此时，我会假定读者拥有一定的数理基础，包括矢量概念，复数运算$(i^2=-1)$，简单的概率论；如果你对于矩阵运算的方法（行矢量、列矢量、矩阵转置、矩阵乘法）很熟悉的话，那当然更好。
                </em>
                <h2>态矢 State Vector</h2>
                <h3>量子态的态矢描述</h3>
                <em>
                                                  右矢
                    <p>$|\psi\rangle=\left[c_1,c_2,...,c_n\right]^T$</p>
                </em>
                <em>
                                                  左矢
                    <p>$\langle\psi|=\left[c_1^*,c_2^*,...,c_n^*\right]$</p>
                </em>
                <em>
                                                  我们采用竖线和尖括号的组合描述一个量子态，其中每一个分量都是复数，右上角标T表示转置。这样的描述表示量子态是一个矢量。右矢表示一个
                    $1\times n$ 的列矢量，左矢表示一个 $n\times 1$ 的行矢量。另外，在讨论同一个问题时，如果左矢和右矢在括号内的描述相同的话，那么这两个矢量互为转置共轭。
                </em>
                <h3>内积和外积</h3>
                <em>对于任意的两个量子态</em>
                <em>$|\alpha\rangle=\left[a_1,a_2,...,a_n\right]^T$</em>
                <em>$|\beta\rangle=\left[b_1,b_2,...,b_n\right]^T$</em>
                <em>内积</em>
                <em>$\langle \alpha|\beta\rangle=\sum_n a_ib_i=$一个数</em>
                <em id="two">外积</em>
                <em>$|\alpha\rangle\langle\beta |=\left(a_ib_j\right)_{i,j}=n\times n $矩阵</em>
                <h2>两能级系统 Two Level System</h2>
                <em>事物的二元化：0和1、无和有、高和低、开和关、天和地、阴和阳、生和死、产生和消灭。二元化是一种将事物关系简化的哲学。基于二进制的计算理论正是利用了这种哲学思想。
                </em>
                <em>在谈论量子计算原理前，我们可以先来看一看经典计算机是怎么做的。我们知道，经典计算机就是在不断的处理0、1的二进制数码，它们代表着逻辑电路中的高低电平。对于这些二进制数码的产生、传输、处理、读取，最终反馈到像显示器这种输出设备上的信号，就是一个计算机的工作流程。</em>
                <em>对于微观量子而言，我们有一个决定粒子性质的最直接的参量——它的能量。之前就已经说过，粒子的能量只会在几个分立的能级上面取值。并且我们现在限制取值的可能性种类为两种。这就构成了两能级系统。除了某些特殊的情况之外，这两个能级必定能找出来一个较低的，称之为基态<strong>(ground state)</strong>，记为 $|g\rangle$；另一个能量较高的，称之为激发态<strong>(excited state)</strong>，记为 $|e\rangle$。</em>
                <em>所以量子计算机里面也是由0和1来构成量子比特，只不过这里是指量子态的 $|e\rangle$ 和 $|g\rangle$。这就是一个两能级系统的特征。以列矢量的方式将它们记为</em>
                <em>$$|e\rangle=\left(
                    \begin{matrix}
                    1\\
                    0
                    \end{matrix}\right)
                    \quad
                    |g\rangle=\left(
                    \begin{matrix}
                    0\\
                    1
                    \end{matrix}\right)$$                   
                </em>
                <em id="three">行矢量的形式记为</em>
                <em >$$\langle e|=(\begin{matrix}
                    1&&0
                    \end{matrix})
                    \quad
                    \langle g|=(\begin{matrix}
                    0&&1
                    \end{matrix})$$ 
                </em>
                <h2>叠加态和测量 Superposition State And Measurement</h2>
                <em>按照态矢里面的描述，这两个矢量可以构成一个二维空间的基。任何一个态都可以写为这两个基在复数空间上的线性组合，即</em>
                <em>$|\psi\rangle=\alpha|0\rangle+\beta e^{i\theta}|1\rangle$</em>
                <em>其中 $e^{i\theta}$ 表示模为1幅角为 $\theta$ 的复数。</em>
                <em>我们现在就可以给测量这件事情赋予数学上的含义了。我们定义测量就是将量子态 $|\psi\rangle$ 投影到另一个态 $|\alpha\rangle$ 上。获得这个态的概率是它们内积的平方，即</em>
                <em>$P_\alpha=|\langle \psi|\alpha\rangle|^2$</em>
                <em>其它概率下会将量子态投影到它的正交态上面去，即</em>
                <em id="four">$P_{\alpha_\perp}=1-P_\alpha$</em>
                <em>测量之后量子态就坍缩到测量到的态上面。</em>
                <h2>相位、纯态和混合态 Phase, Pure State and Mixed State</h2>
                <em>如果说我们有办法将量子态初始化到某一个未知的叠加态上面，我们能否通过反复的测量得到它的表达式呢？看下面这种两种情况：</em>
                <em>$$|\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$$</em>
                <em>$$|\psi_2\rangle=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)$$</em>
                <em>我们会发现在 $|0\rangle$，$|1\rangle$ 的方向上测量，它们的表现都是一半概率为0，一半概率为1，根本不能区分。</em>
                <em>这里我只是想提醒你相位是某种隐含的信息，从概率上无法表示的信息。实际上，量子态的相位是量子相干性的体现。关于量子相干性的更详细信息我会在接下来的部分介绍。</em>
                <em>现在我们再来介绍另一种情况。想象我们左手抓着一个袋子，这个袋子里面有无数的量子态。他们全部都是 $|\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$ 这种叠加态。另外我们有一个机器可以在 $|0\rangle$，$|1\rangle$ 的方向上测量。</em>
                <em>我们每次拿出来一个态，对它进行测量，不管它是 $|0\rangle$ 还是 $|1\rangle$，都扔到右手边的另一个袋子里面。反复这个过程，这样右边袋子里面的态越来越多了。因为我们的测量结果对于这两种情况是等概率的，所以右边的袋子里面约有一半的态是 $|0\rangle$，另一半是 $|1\rangle$。</em>
                <em>我们从右手边的袋子里面取一个出来。在我们不知道手上的这个态是什么的情况下，我们能说它和左手边袋子里面的态一样都是 $\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)$ 吗？</em>
                <em>答案是不能。右边袋子里面的态实际上是一种经典的概率叠加，和等量的红球白球装在袋子里面一样。这样的态是不具有相位的。它只能表示为</em>
                <em>$$\begin{cases}
                    	|\psi\rangle=|0\rangle;\quad P=0.5\\
                    	|\psi\rangle=|1\rangle;\quad P=0.5
                    \end{cases}$$
                </em>
                <em id="five">这种类似于概率列表的形式。</em>
                <em>所以说，我们定义纯态就是“纯粹的量子态”，它不仅具有概率，还具有相位（也就是量子相干性）。混合态是纯态的概率性叠加，它往往失去了（部分或全部的）相位信息。</em>
                <h2>密度矩阵和布洛赫球 Density Matrix And Bloch Sphere</h2>
                <em>态矢是对纯态的描述，如果要描述一个混合态，就必须写成态集合和概率的列表形式，这样非常繁琐。所以我们采用密度矩阵来描述。</em>
                <em>对于一个纯态而言，密度矩阵可以写为</em>
                <em>$\rho=|\psi\rangle\langle \psi|$</em>
                <em>而对于一个混合态而言，密度矩阵的形式是</em>
                <em>$\rho=\sum_i P_i|\psi_i\rangle\langle \psi_i|$</em>
                <em>其中 $\{P_i,\psi_i\}$ 是系统所处的态及其概率。</em>
                <em>密度矩阵有以下的性质：</em>

                <div class="four-box">
                    <ul>
                        <li>对于一个两能级体系表述的态，不论是纯的还是混合的，都可以用密度矩阵 $\rho$ 表示</li>
                        <li>$\rho=\rho^2$ 当且仅当量子态时纯态时成立</li>
                        <li>$\rho$ 对角线上的分量表示整个系统如果经历一次测量，那么得到这个态的概率。</li>
                        <li>我们如果只去操作和测量一个两能级体系，那么我们是分辨不出相同的密度矩阵的。</li>

                    </ul>
                </div>
                <em>密度矩阵已经完备地表示了一个两能级系统可能出现的任何状态。为了更加直观地理解量子叠加态与逻辑门的作用，引入布洛赫球的概念，它能够方便的表示一个量子比特的任意状态。</em>
                <em style="text-align: center">
                    <img src="${base}/assets/images/b.png" />
                    <img src="${base}/assets/images/liang04.png" />
                </em>
                <em>如果量子态是一个纯态，那么它是球面上的点。点的z坐标衡量了它的 $|0\rangle$ 和 $|1\rangle$ 的概率，即</em>
                <em>$$P(0)=\frac{1+z}{2}$$</em>
                <em>$$P(1)=\frac{1-z}{2}$$</em>
                <em>所以最上面表示 $|0\rangle$ 态，最下面表示 $|1\rangle$ 态。</em>
                <em>再沿着平行于XY平面的方向，并且穿过这个点的Z坐标，可以得到一个圆。这个圆就象征着相位的复平面。所以这个点在这个圆上交X轴的角度就是单位复数的幅角。经过这个过程我们将每个纯态都与球面上的点一一对应了起来。</em>
                <em>对于混合态而言，因为根据我们之前的描述，混合态实际上是多个纯态的经典统计概率的叠加。对于每一个纯态分量，我们连接球心和球面上的点，可以形成一个矢量。我们根据概率列表，对所有的纯态矢量进行加权平均，即可得到混合态的矢量，即得到了混合态对应的点。</em>
                <em>混合态是球内部的点，根据混合的程度不同，矢量的长度也不同。最大混合态是球心。它意味着这里不存在任何量子叠加性。</em>
                <em>例如(1,0,0)和(-1,0,0)点在布洛赫球上就是在X方向上的顶点和-X方向上的顶点。我们根据刚才的叙述，知道它们对应的量子态的概率分布就是Z坐标，即为0。所以，</em>
                <em>$$P_0(|\psi_1\rangle)=P_0(|\psi_2\rangle)=0.5$$</em>
                <em>沿XY平面横切，得到一个圆，我们可以看到这两个点对应的幅角是 $\theta_1=0$，$\theta_2=\pi$，所以我们就可以推断出来量子态分别为</em>
                <em>$$\begin{align*}
						|\psi\rangle_1&=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)\\
						|\psi\rangle_2&=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)\\
					\end{align*}$$                   
                </em>
                <em>如果将这两个态以1/2,1/2的概率混合，在布洛赫球上面的坐标将表示为(0,0,0)，也就是球心。对应到密度矩阵的表述，即为</em>
                <em>
                    $$\rho=\frac{1}{2}|\psi_1\rangle\langle\psi_1|+\frac{1}{2}|\psi_2\rangle\langle\psi_2|=\left(\begin{matrix}0.5&&0\\0&&0.5\end{matrix}\right)$$
                </em>
                <em  id="">即为最大混合态。</em>

            </div>
        </div>
    </div>

    <div class="news-rights" style="display:none;">
        <div class="rh"><h4><strong>章节</strong></h4></div>
        <ul>
            <li class="n-cur">
                <a href="#one">
                    <h5>态矢<p class="f12 f999 "> State Vector </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#two">
                    <h5>两能级系统  <p class="f12 f999 ">Two Level System</p></h5>
                </a>
            </li>
            <li class="">
                <a href="#three">
                    <h5>叠加态和测量 <p class="f12 f999 ">Superposition State And Measurement </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#four">
                    <h5>相位、纯态和混合态 <p class="f12 f999 ">Phase, Pure State and Mixed State  </p></h5>
                </a>
            </li>
            <li class="">
                <a href="#five">
                    <h5>密度矩阵和布洛赫球  <p class="f12 f999 ">Density Matrix And Bloch Sphere </p></h5>
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
        $("#mechanics").addClass('active').siblings().removeClass('active')
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
