<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="weui-panel weui-panel_access">
    <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_text">
            <h4 class="weui-media-box__title weui-panel__hd p-lr-0 cr3090e5 fb f22">
                量子力学
                <span class="block fn f16">Quantum Mechanics</span>
            </h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">我个人认为，如果要去理解量子计算本身的东西，数学的东西是逃不掉的。在前面一章里面，我只展现了量子世界的许多古怪性质。其实我们处理实际的量子计算问题的时候，不需要在这些问题上面追根问底。这一章里面，我会用数学的方式去将第一章里面的内容重新表述一遍。此时，我会假定读者拥有一定的数理基础，包括矢量概念，复数运算<strong>（ <img src="http://latex.codecogs.com/gif.latex? i^2=-1"> ）</strong>，简单的概率论；如果你对于矩阵运算的方法（行矢量、列矢量、矩阵转置、矩阵乘法）很熟悉的话，那当然更好。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">态矢 <span class="block f14">State Vector</span></h4>
            <h4 class="weui-media-box__title fb f16 cr000">量子态的态矢描述</h4>
            <div class="weui-media-box__desc box-desc mb15 f666 mb30">
                <p class="mt10">右矢<p><img src="http://latex.codecogs.com/gif.latex? |\psi\rangle =\left[c_1,c_2,...,c_n\right]^T"></p></p>
                <p>左矢<p><img src="http://latex.codecogs.com/gif.latex? \langle \psi| =\left[c_1^*,c_2^*,...,c_n^*\right]"></p></p>
                <p>我们采用竖线和尖括号的组合描述一个量子态，其中每一个分量都是复数，右上角标T表示转置。这样的描述表示量子态是一个矢量。右矢表示一个
                    <img src="http://latex.codecogs.com/gif.latex? 1\times n">的列矢量，左矢表示一个 <img src="http://latex.codecogs.com/gif.latex?n\times 1">的行矢量。另外，在讨论同一个问题时，如果左矢和右矢在括号内的描述相同的话，那么这两个矢量互为转置共轭。</p>
            </div>
            <h4 class="weui-media-box__title fb f16 cr000">内积和外积</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">对于任意的两个量子态</p>
                <p><img src="http://latex.codecogs.com/gif.latex? |\alpha\rangle=\left[a_1,a_2,...,a_n\right]^T"></p>
                <p><img src="http://latex.codecogs.com/gif.latex? |\beta\rangle=\left[b_1,b_2,...,b_n\right]^T"></p>
                <p>内积</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \langle \alpha|\beta\rangle=\sum_n a_ib_i=\text{一个数}"> 一个数</p>
                <p>外积</p>
                <p><img src="http://latex.codecogs.com/gif.latex?|\alpha\rangle\langle\beta |=\left(a_ib_j\right)_{i,j}=n\times n \text{矩阵}"> 矩阵</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">两能级系统 <span class="block f14">Two Level System</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">事物的二元化：0和1、无和有、高和低、开和关、天和地、阴和阳、生和死、产生和消灭。二元化是一种将事物关系简化的哲学。基于二进制的计算理论正是利用了这种哲学思想。</P>
                <p>在谈论量子计算原理前，我们可以先来看一看经典计算机是怎么做的。我们知道，经典计算机就是在不断的处理0、1的二进制数码，它们代表着逻辑电路中的高低电平。对于这些二进制数码的产生、传输、处理、读取，最终反馈到像显示器这种输出设备上的信号，就是一个计算机的工作流程。</p>
                <p>对于微观量子而言，我们有一个决定粒子性质的最直接的参量——它的能量。之前就已经说过，粒子的能量只会在几个分立的能级上面取值。并且我们现在限制取值的可能性种类为两种。这就构成了两能级系统。除了某些特殊的情况之外，这两个能级必定能找出来一个较低的，称之为基态<strong>(ground state)</strong>，记为 <img src="http://latex.codecogs.com/gif.latex?|g\rangle">；另一个能量较高的，称之为激发态<strong>(excited state)</strong>，记为 <img src="http://latex.codecogs.com/gif.latex?|e\rangle">。</p>
                <p>所以量子计算机里面也是由0和1来构成量子比特，只不过这里是指量子态的 <img src="http://latex.codecogs.com/gif.latex?|e\rangle"> 和 <img src="http://latex.codecogs.com/gif.latex?|g\rangle">。这就是一个两能级系统的特征。以列矢量的方式将它们记为</p>
                <p><img src="http://latex.codecogs.com/gif.latex? |e\rangle=\left(
                    \begin{matrix}
                    1\\
                    0
                    \end{matrix}\right)
                    \quad
                    |g\rangle=\left(
                    \begin{matrix}
                    0\\
                    1
                    \end{matrix}\right)" /></p>
                <p>行矢量的形式记为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?  \langle e|=(\begin{matrix}
                    1&&0
                    \end{matrix})
                    \quad
                    \langle g|=(\begin{matrix}
                    0&&1
                    \end{matrix})" /></p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">叠加态和测量 <span class="block f14">Superposition State And Measurement</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">按照态矢里面的描述，这两个矢量可以构成一个二维空间的基。任何一个态都可以写为这两个基在复数空间上的线性组合，即</P>
                <p><img src="http://latex.codecogs.com/gif.latex? |\psi\rangle=\alpha|0\rangle+\beta e^{i\theta}|1\rangle" /></p>
                <p>其中 <img src="http://latex.codecogs.com/gif.latex? e^{i\theta}" /> 表示模为1幅角为 <img src="http://latex.codecogs.com/gif.latex?\theta" />的复数。</p>
                <p>我们现在就可以给测量这件事情赋予数学上的含义了。我们定义测量就是将量子态 <img src="http://latex.codecogs.com/gif.latex?|\psi\rangle" /> 投影到另一个态<img src="http://latex.codecogs.com/gif.latex?|\alpha\rangle" />上。获得这个态的概率是它们内积的平方，即</p>
                <p><img src="http://latex.codecogs.com/gif.latex?  P_\alpha=|\langle \psi|\alpha\rangle|^2" /></p>
                <p>其它概率下会将量子态投影到它的正交态上面去，即</p>
                <p><img src="http://latex.codecogs.com/gif.latex? P_{\alpha_\perp}=1-P_\alpha" /></p>
                <p>测量之后量子态就坍缩到测量到的态上面。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">相位、纯态和混合态<span class="block f14">Phase, Pure State and Mixed State</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">如果说我们有办法将量子态初始化到某一个未知的叠加态上面，我们能否通过反复的测量得到它的表达式呢？看下面这种两种情况：</P>
                <p><img src="http://latex.codecogs.com/gif.latex? |\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)"></p>
                <p><img src="http://latex.codecogs.com/gif.latex? |\psi_2\rangle=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)" /></p>
                <p>我们会发现在<img src="http://latex.codecogs.com/gif.latex?|0\rangle" />，<img src="http://latex.codecogs.com/gif.latex?|1\rangle" /> 的方向上测量，它们的表现都是一半概率为0，一半概率为1，根本不能区分。</p>
                <p>这里我只是想提醒你相位是某种隐含的信息，从概率上无法表示的信息。实际上，量子态的相位是量子相干性的体现。关于量子相干性的更详细信息我会在接下来的部分介绍。</p>
                <p>现在我们再来介绍另一种情况。想象我们左手抓着一个袋子，这个袋子里面有无数的量子态。他们全部都是<img src="http://latex.codecogs.com/gif.latex?|\psi_1\rangle=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)" />这种叠加态。另外我们有一个机器可以在<img src="http://latex.codecogs.com/gif.latex?|0\rangle$，$|1\rangle" />的方向上测量。</p>
                <p>我们每次拿出来一个态，对它进行测量，不管它是<img src="http://latex.codecogs.com/gif.latex?|0\rangle" /> 还是 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" />，都扔到右手边的另一个袋子里面。反复这个过程，这样右边袋子里面的态越来越多了。因为我们的测量结果对于这两种情况是等概率的，所以右边的袋子里面约有一半的态是  <img src="http://latex.codecogs.com/gif.latex?|0\rangle" />，另一半是 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" />。</p>
                <p>我们从右手边的袋子里面取一个出来。在我们不知道手上的这个态是什么的情况下，我们能说它和左手边袋子里面的态一样都是 <img src="http://latex.codecogs.com/gif.latex?\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)" />吗？</p>
                <p>答案是不能。右边袋子里面的态实际上是一种经典的概率叠加，和等量的红球白球装在袋子里面一样。这样的态是不具有相位的。它只能表示为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?  \begin{cases}
                    |\psi\rangle=|0\rangle;\quad P=0.5\\
                    |\psi\rangle=|1\rangle;\quad P=0.5
                    \end{cases}" /></p>
                <p>这种类似于概率列表的形式。</p>
                <p>所以说，我们定义纯态就是“纯粹的量子态”，它不仅具有概率，还具有相位（也就是量子相干性）。混合态是纯态的概率性叠加，它往往失去了（部分或全部的）相位信息。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">密度矩阵和布洛赫球 <span class="block f14">Density Matrix And Bloch Sphere</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">态矢是对纯态的描述，如果要描述一个混合态，就必须写成态集合和概率的列表形式，这样非常繁琐。所以我们采用密度矩阵来描述。</P>
                <p>对于一个纯态而言，密度矩阵可以写为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\rho=|\psi\rangle\langle \psi|" /></p>
                <p>而对于一个混合态而言，密度矩阵的形式是</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \rho=\sum_i P_i|\psi_i\rangle\langle \psi_i|" /></p>
                <p>其中<img src="http://latex.codecogs.com/gif.latex?\{P_i,\psi_i\}" />是系统所处的态及其概率。</p>
                <p>密度矩阵有以下的性质：</p>
                <ul class="box f333">
                    <li>对于一个两能级体系表述的态，不论是纯的还是混合的，都可以用密度矩阵<img src="http://latex.codecogs.com/gif.latex?\rho" />表示</li>
                    <li><img src="http://latex.codecogs.com/gif.latex?\rho=\rho^2" />当且仅当量子态时纯态时成立</li>
                    <li><img src="http://latex.codecogs.com/gif.latex?\rho" />对角线上的分量表示整个系统如果经历一次测量，那么得到这个态的概率。</li>
                    <li>我们如果只去操作和测量一个两能级体系，那么我们是分辨不出相同的密度矩阵的。</li>
                </ul>
                <p>密度矩阵已经完备地表示了一个两能级系统可能出现的任何状态。为了更加直观地理解量子叠加态与逻辑门的作用，引入布洛赫球的概念，它能够方便的表示一个量子比特的任意状态。</p>
                <p class="t-center"><img src="${base}/assets/images/b.png" />
                    <img class="img-DensityMatrix" src="${base}/assets/images/liang04.png" /></p>
                <p>如果量子态是一个纯态，那么它是球面上的点。点的z坐标衡量了它的 <img src="http://latex.codecogs.com/gif.latex?|0\rangle" /> 和 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" />的概率，即</p>
                <p><img src="http://latex.codecogs.com/gif.latex?P(0)=\frac{1+z}{2}" /></p>
                <p><img src="http://latex.codecogs.com/gif.latex? P(1)=\frac{1-z}{2}" /></p>
                <p>所以最上面表示<img src="http://latex.codecogs.com/gif.latex?|0\rangle" />态，最下面表示 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" />态。</p>
                <p>再沿着平行于XY平面的方向，并且穿过这个点的Z坐标，可以得到一个圆。这个圆就象征着相位的复平面。所以这个点在这个圆上交X轴的角度就是单位复数的幅角。经过这个过程我们将每个纯态都与球面上的点一一对应了起来。</p>
                <p>对于混合态而言，因为根据我们之前的描述，混合态实际上是多个纯态的经典统计概率的叠加。对于每一个纯态分量，我们连接球心和球面上的点，可以形成一个矢量。我们根据概率列表，对所有的纯态矢量进行加权平均，即可得到混合态的矢量，即得到了混合态对应的点。</p>
                <p>混合态是球内部的点，根据混合的程度不同，矢量的长度也不同。最大混合态是球心。它意味着这里不存在任何量子叠加性。</p>
                <p>例如(1,0,0)和(-1,0,0)点在布洛赫球上就是在X方向上的顶点和-X方向上的顶点。我们根据刚才的叙述，知道它们对应的量子态的概率分布就是Z坐标，即为0。所以，</p>
                <p><img src="http://latex.codecogs.com/gif.latex? P_0(|\psi_1\rangle)=P_0(|\psi_2\rangle)=0.5" /></p>
                <p>沿XY平面横切，得到一个圆，我们可以看到这两个点对应的幅角是</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \begin{align*}
                    \theta_1&=0\\
                    \theta_2&=\pi
                    \end{align*}" /></p>
                <p>所以我们就可以推断出来量子态分别为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\begin{align*}
|\psi\rangle_1&=\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)\\
|\psi\rangle_2&=\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)\\
\end{align*}
" /></p>
                <p>如果将这两个态以1/2,1/2的概率混合，在布洛赫球上面的坐标将表示为(0,0,0)，也就是球心。对应到密度矩阵的表述，即为</p>
                <p><img class="img-5" src="http://latex.codecogs.com/gif.latex?  \rho=\frac{1}{2}|\psi_1\rangle\langle\psi_1|+\frac{1}{2}|\psi_2\rangle\langle\psi_2|=\left(\begin{matrix}0.5\\&&0.5\end{matrix}\right)" /></p>
                <p>即为最大混合态。</p>
            </div>
        </div>
    </div>
</div></#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("量子力学");
	App.dragRefresh();
});
</script>
</@main.footer>