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
                量子计算原理
                <span class="block fn f16">Theory of Quantum Computing</span>
            </h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">我们在此之前所铺垫的概念，都是为了说明一个量子比特具有的性质。那么，接下来的部分，我们会通过量子逻辑门来对量子态进行操作。</p>
                <p>经典计算中，最基本的单元是比特，而最基本的控制模式是逻辑门。我们可以通过逻辑门的组合来达到我们控制电路的目的。类似地，处理量子比特的方式就是量子逻辑门。使用量子逻辑门，我们有意识的使量子态发生演化。所以量子逻辑门是构成量子算法的基础。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">酉变换 <span class="block f14">Unitary Transformation</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">酉变换是一种矩阵，也是一种操作。它作用在量子态上得到的是一个新的量子态。使用<img src="http://latex.codecogs.com/gif.latex?U" />来表达酉矩阵，<img src="http://latex.codecogs.com/gif.latex?U^\dagger" />表示酉矩阵的转置复共轭矩阵。二者满足运算关系<img src="http://latex.codecogs.com/gif.latex?UU^\dagger=I" /> ，所以酉矩阵的转置复共轭矩阵也是一个酉矩阵，说明酉变换是一种可逆变换。</p>
                <p>一般酉变换在量子态上的作用是变换矩阵左乘以右矢进行计算的。 举个例子，例如一开始有一个量子态 <img src="http://latex.codecogs.com/gif.latex?|\psi_0\rangle" /> ，经过酉变换 <img src="http://latex.codecogs.com/gif.latex?U" /> 之后得到</p>
                <p><img src="http://latex.codecogs.com/gif.latex? |\psi\rangle=U|\psi_0\rangle" /></p>
                <p>或者也可以写为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\langle\psi|=\langle\psi_0|U^\dagger" /></p>
                <p>所以说两个矢量的内积经过同一个酉变换之后保持不变。</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\langle\varphi |\psi\rangle=\langle\varphi |U^\dagger U|\psi\rangle" /></p>
                <p>类似地，我们也可以通过酉变换表示密度矩阵的演化。</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \rho=U\rho_0U^\dagger" /></p>
                <p>这样就连混合态的演化也包含在内了。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">矩阵的指数</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">一旦我们定义了矩阵乘法，我们可以利用函数的多项式展开来定义矩阵的函数。这其中就包含矩阵的指数形式。如果A是一个矩阵，</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\exp(A)=1+A+\frac{A^2}{2!}+\frac{A^3}{3!}+..." /></p>
                <p>如果A是一个对角矩阵，<img src="http://latex.codecogs.com/gif.latex?A=\text{diag}(A_{11},A_{22},A_{33}...)" /> ，可以容易验证</p>
                <p><img src="http://latex.codecogs.com/gif.latex?A^n=\text{diag}(A^n_{11},A^n_{22},A^n_{33}...)" /></p>
                <p>从而得到</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\exp(A)=\text{diag}(e^{A_{11}},e^{A_{22}},e^{A_{33}}...)" /></p>
                <p>如果A不是一个对角矩阵，我们利用酉变换可以将它对角化</p>
                <p><img src="http://latex.codecogs.com/gif.latex?D=UAU^\dagger" /></p>
                <p>从而有</p>
                <p><img src="http://latex.codecogs.com/gif.latex?A^n=UD^nU^\dagger" /></p>
                <p>那么，类似地</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\exp(A)=U\exp(D)U^\dagger" /></p>
                <p>必须要引起注意的是</p>
                <p><img class="img-6" src="http://latex.codecogs.com/gif.latex? \exp(A+B)\neq \exp(A)\exp(B)\neq \exp(B)\exp(A)" /></p>
                <p>通常，我们称下面这种形式是以A为生成元生成的酉变换</p>
                <p><img src="http://latex.codecogs.com/gif.latex?U(\theta)=\exp(-i\theta A)" /></p>
                <p>以后会经常遇到这种矩阵的指数运算。除了上面的方法之外，你也可以利用Matlab中的expm，或者Mathematica中的MatrixExp命令进行方便地计算。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">单位矩阵</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">以单位矩阵为生成元，可以构建一种特殊的酉变换。</P>
                <p><img class="img-6" src="http://latex.codecogs.com/gif.latex? u(\theta)=\exp(-i\theta I)=\left(\begin{matrix}
                    e^{-i\theta}\\
                    &&e^{-i\theta}
                    \end{matrix}
                    \right)=\exp(-i\theta)I" /></p>
                <p>它作用在态矢上面，相当于对于态矢整体（或者说每个分量同时）乘以了一个系数。如果将这种态矢带入到密度矩阵的表达式中，会发现这一项系数会被消去。</p>
                <p>这个系数称为量子态的整体相位。因为任何操作和测量都无法分辨两个相同的密度矩阵，所以量子态的整体相位一般情况下是不会对系统产生任何影响的。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">泡利矩阵和单比特量子逻辑门 <span class="block f14 newline">Pauli Matrices And Single Qubit Quantum Logic Gates</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">泡利矩阵有三个，分别是</P>
                <p><img class="img-6p" src="http://latex.codecogs.com/gif.latex?  \sigma_x=\left( \begin{array}{cc} 0 & 1\\ 1 & 0\\ \end{array} \right)
                    \quad
                    \sigma_y=\left( \begin{array}{cc} 0 & -i\\ i & 0\\ \end{array} \right)
                    \quad
                    \sigma_z=\left( \begin{array}{cc} 1 & 0\\ 0 & -1\\ \end{array} \right)" /></p>
                <p>三个泡利矩阵所表示的泡利算符代表着对量子态矢量最基本的操作。如将 <img src="http://latex.codecogs.com/gif.latex?\sigma_x" /> 作用到 <img src="http://latex.codecogs.com/gif.latex?|0\rangle" />态上，经过矩阵运算，得到的末态为 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" /> 态。泡利矩阵的线性组合是完备的二维酉变换生成元，即所有满足 <img src="http://latex.codecogs.com/gif.latex?UU^\dagger=I" /> 的<img src="http://latex.codecogs.com/gif.latex?U" />都能通过下面这种方式得到</p>
                <p><img src="http://latex.codecogs.com/gif.latex?U=e^{-i\theta(a\sigma_x+b\sigma_y+c\sigma_z)}" /></p>
                <p>在经典范畴，单比特的门只有一种——非门。但是量子比特情况更为复杂，存在叠加态、相位，所以单比特门会有更加丰富的种类。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">Hadamard门</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">Hadamard是一种基础的建立叠加态的单比特门。它具有如下的矩阵形式：</P>
                <p><strong>\begin{equation} H=\frac{1}{\sqrt{2}} \left( \begin{array}{cc} 1 & 1\\ 1 & -1\\ \end{array} \right) \end{equation}</strong></p>
                <p><img src="http://latex.codecogs.com/gif.latex?H=\frac{1}{\sqrt{2}} \left( \begin{array}{cc} 1 & 1\\ 1 & -1\\ \end{array} \right)" /></p>
                <p>它能把 <img src="http://latex.codecogs.com/gif.latex?|0\rangle" /> 变为 <img src="http://latex.codecogs.com/gif.latex?\frac{1}{\sqrt{2}}(|0\rangle+|1\rangle)" />，把 <img src="http://latex.codecogs.com/gif.latex?|1\rangle" />变为  <img src="http://latex.codecogs.com/gif.latex?\frac{1}{\sqrt{2}}(|0\rangle-|1\rangle)" />。</p>
                <p>实际上也可以说Hadamard门是由 <img src="http://latex.codecogs.com/gif.latex?\sigma_x+\sigma_z" />  矩阵生成的。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">RX,RY,RZ门</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">分别用不同的泡利矩阵作为生成元是构成RX,RY,RZ的方法。</P>
                <p><img class="img-5" src="http://latex.codecogs.com/gif.latex? RX(\theta)=e^{-i\theta \sigma_x/2}=\left(\begin{matrix}
                    \cos(\theta/2)&&i\sin(\theta/2)\\
                    i\sin(\theta/2)&&\cos(\theta/2)
                    \end{matrix}
                    \right)" /></p>
                <p><img class="img-5" src="http://latex.codecogs.com/gif.latex? RY(\theta)=e^{-i\theta \sigma_y/2}=\left(\begin{matrix}
                    \cos(\theta/2)&&-\sin(\theta/2)\\
                    \sin(\theta/2)&&\cos(\theta/2)
                    \end{matrix}
                    \right)" /></p>
                <p><img src="http://latex.codecogs.com/gif.latex?  RZ(\theta)=e^{-i\theta \sigma_z/2}=\left(\begin{matrix}
                    e^{-i\theta/2}&&0\\
                    0&&e^{i\theta/2}
                    \end{matrix}
                    \right)" /></p>
                <p>RX,RY,RZ意味着将量子态在布洛赫球上分别绕着X,Y,Z轴旋转$\theta$角度。所以说RX，RY能带来概率幅的变化，而RZ只有相位的变化。共同使用这三种操作能使量子态在整个布洛赫球上自由移动。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">两比特量子逻辑门 <span class="block f14">Two Qubit Quantum Logic Gates</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <P class="mt10">不论是在经典计算还是量子计算中，两比特门无疑是建立比特之间的联系的最重要桥梁。不同于经典计算中的与或非门及他们的组合，量子逻辑门要求所有的逻辑操作必须是酉变换。所以输入和输出的比特数量是相等的。</P>
                <p>在描述两比特门之前，我们必须要将之前对于比特的表示方式扩展一下。我们联立两个比特的时候，采用直积的方式合成一个新的量子态，即</p>
                <p><img class="img-6p" src="http://latex.codecogs.com/gif.latex? |\psi_1\rangle_{Q1}\otimes|\psi_2\rangle_{Q2}=\left(\begin{matrix}
                    \alpha_1\\
                    \beta_1 e^{i\phi_1}
                    \end{matrix}\right)
                    \otimes
                    \left(\begin{matrix}
                    \alpha_2\\
                    \beta_2 e^{i\phi_2}
                    \end{matrix}\right)=
                    \left(\begin{matrix}
                    \alpha_1\alpha_2\\
                    \alpha_1\beta_2 e^{i\phi_2}\\
                    \alpha_2\beta_1 e^{i\phi_1}\\
                    \beta_1\beta_2 e^{i(\phi_1+\phi_2)}
                    \end{matrix}\right)" /></p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">测量和坍缩 <span class="block f14">Measurement And Collapse</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">下标表示描述了第几个量子比特上的状态。运算规则很简单，就是按照顺序把两个量子态上的分量乘在一起作为新的列矢量的分量即可。新的列矢量的维度等于直积之前两个矢量的维度之积。新的系统就包含了两个比特的所有状态。</p>
                <p>那么对于一个两比特的系统，构成它的基就是每个比特各自的基的直积，</p>
                <p><img src="http://latex.codecogs.com/gif.latex?\begin{align*}
|0\rangle_{Q_1Q_2}&=|00\rangle=|0\rangle_{Q1}\otimes|0\rangle_{Q2}\\
|1\rangle_{Q_1Q_2}&=|01\rangle=|0\rangle_{Q1}\otimes|1\rangle_{Q2}\\
|2\rangle_{Q_1Q_2}&=|10\rangle=|1\rangle_{Q1}\otimes|0\rangle_{Q2}\\
|3\rangle_{Q_1Q_2}&=|11\rangle=|1\rangle_{Q1}\otimes|1\rangle_{Q2}
\end{align*}" /></p>
                <p>单比特门在两比特系统下的表示可以写为</p>
                <p><img src="http://latex.codecogs.com/gif.latex?U=U_1\otimes U_2" /></p>
                <p>其中 <img src="http://latex.codecogs.com/gif.latex?U_1" /> 和 <img src="http://latex.codecogs.com/gif.latex?U_2" />  表示在第一个或第二个比特上各自的操作。注意，<img src="http://latex.codecogs.com/gif.latex?U_1\otimes U_2\neq U_2\otimes U_1" /> ，所以比特的顺序一旦决定，就不可发生改变。</p>
                <p>在这个基础上，我们可以介绍一些对两比特共同进行操作的量子逻辑门。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">控制非门</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">控制非门(Control-NOT)，通常用CNOT进行表示，是一种普遍使用的两比特门。它具有如下的矩阵形式</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \text{CNOT}=\left(\begin{matrix}
                    1\\
                    &&1\\
                    && && &&1\\
                    && && 1
                    \end{matrix}
                    \right)" /></p>
                <p>它的含义是当控制比特为0状态时，目标比特不发生改变；当控制比特为1状态时，使目标比特做非操作（或者也可以说是 <img src="http://latex.codecogs.com/gif.latex?RX(\pi)" /> ）操作。要注意的是控制比特和目标比特的地位是不能交换的。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">控制相位门</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">控制相位门和控制非门类似，通常记为CR(CPhase)，只不过当控制比特为1状态时，目标比特做RZ操作。</p>
                <p><img src="http://latex.codecogs.com/gif.latex? \text{CR}(\theta)=\left(\begin{matrix}
                    1\\
                    &&1\\
                    && &&1\\
                    && && &&e^{-i\theta}
                    \end{matrix}
                    \right)" /></p>
                <p>稍微有点特殊的是，控制相位门例交换控制比特和目标比特的角色，矩阵形式不会发生任何改变。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">iSWAP门</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">iSWAP门的主要作用是交换两个比特的状态，并且给他们赋予 <img src="http://latex.codecogs.com/gif.latex?\pi/2" /> 相位。经典电路中也有SWAP门，但是iSWAP是量子计算中特有的。iSWAP门在某些体系中是较容易实现的两比特逻辑门，它是由 <img src="http://latex.codecogs.com/gif.latex?\sigma_x\otimes\sigma_x+\sigma_y\otimes\sigma_y" />  作为生成元构成的。</p>
                <p><img class="img-6" src="http://latex.codecogs.com/gif.latex? \text{iSWAP}(\theta)=\left(\begin{matrix}
                    1\\
                    &&\cos(\theta/2) && i\sin(\theta/2)\\
                    && i\sin(\theta/2)&&\cos(\theta/2)\\
                    && && &&1
                    \end{matrix}
                    \right)" /></p>
                <p>通常我们会用一个完整的翻转，即$\theta=\pi$的情况来指代iSWAP。当角度为iSWAP的一半时，即  <img src="http://latex.codecogs.com/gif.latex?\theta=\pi/2" />  ，我们称之为  <img src="http://latex.codecogs.com/gif.latex?\sqrt{\text{iSWAP}}" /> 。</p>
                <p>对于iSWAP门而言，两个比特之间是地位对等的，不存在控制和受控的关系。</p>
            </div><h4 class="weui-media-box__title f18 fb cr000">量子线路 <span class="block f14">Quantum Circuit</span></h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">现在我们可以把这些门组合起来形成量子的线路了。对于一系列的酉变换而言，它其实就相当于对初始的量子态按次序进行左乘操作，即</p>
                <p><img src="http://latex.codecogs.com/gif.latex? |\psi\rangle_{\text{末态}}=U_n U_{n-1}....U_2U_1|\psi\rangle_{\text{初始}}" /></p>
                <p>对于矩阵乘法而言，一般不具备可交换性，所以我们最先对量子态进行的操作是 <img src="http://latex.codecogs.com/gif.latex?U_1" /> ，之后是 <img src="http://latex.codecogs.com/gif.latex?U_2" /> ……，最后是 <img src="http://latex.codecogs.com/gif.latex?U_n" /> 。</p>
                <p>对于我们的界面而言，每一条线代表一个量子比特。最左边定义了初始的状态。然后从左至右表示了酉变换的操作顺序。通常一个完整的量子线路上面不会只有一个量子比特。除了单比特操作之外，也会有跨越两个比特的双比特逻辑门操作符号。比如图中的CNOT。</p>
                <p>线路的最后将会有测量的图标。一个完全没有测量的电路是没有意义的。投影测量会按照量子态的概率分量随机得到0或者1。</p>
            </div>
            <h4 class="weui-media-box__title f18 fb cr000">保真度和退相干 <span class="block f14">Fidelity And Decoherence</span></h4>
            <h4 class="weui-media-box__title fb f16 cr000">保真度</h4>
            <div class="weui-media-box__desc box-desc mb15 f666 mb30">
                <p class="mt10">不像经典电路中，高电平具有一定的容忍值。叠加态上每个分量的叠加概率是个连续量，所以不可避免的，任何操作都会存在误差。</p>
                <p>我们可以同样通过测量（或者内积）来定义量子态的保真度。如果我们想操作一个态到 <img src="http://latex.codecogs.com/gif.latex?|0\rangle" /> ，实际上却操作到了 <img src="http://latex.codecogs.com/gif.latex?\sqrt{0.999}|0\rangle+\sqrt{0.001}|1\rangle" /> ，这样我们在 <img src="http://latex.codecogs.com/gif.latex?|0\rangle" /> 方向上测量时，只有99.9%的概率得到正确的结果。我们定义</p>
                <p><img src="http://latex.codecogs.com/gif.latex?F=|\langle \psi|\phi\rangle|^2" /></p>
                <p>为  <img src="http://latex.codecogs.com/gif.latex?|\psi\rangle" /> 相对  <img src="http://latex.codecogs.com/gif.latex?|\phi\rangle" /> 的保真度。</p>
                <p>保真度是衡量量子线路质量的最主要参量。</p>
            </div>
            <h4 class="weui-media-box__title fb f16 cr000">退相干</h4>
            <div class="weui-media-box__desc box-desc mb15 f666">
                <p class="mt10">退相干是导致保真度下降的主要原因。存在两种退相干机制</p>
                <P>第一，振幅退激发。就像水往低处流的道理一样，量子态的高能态不是那么稳定，而是存在向低能态缓慢退激发的过程。这种现象又称为弛豫过程。</P>
                <P>弛豫过程在密度矩阵上面表现为 <img src="http://latex.codecogs.com/gif.latex?\rho_{22}" /> 项的指数衰减，由于总概率为1， <img src="http://latex.codecogs.com/gif.latex?\rho_{11}" /> 在相对提高。</P>
                <P><img src="http://latex.codecogs.com/gif.latex?  \begin{cases}
                    \rho_{22}(t)=\rho_{22}(0)e^{-t/T_1}\\
                    \rho_{11}(t)=1-\rho_{22}(t)
                    \end{cases}" /></P>
                <P>第二，相位退相干。之前提到过混合态就是失去了部分或者全部相位信息的量子态。因为噪声的影响，会造成量子态本身的经典统计上的分裂。从而导致相位的丢失。</P>
                <P>退相干在密度矩阵上表现为非对角项的指数衰减。</P>
                <P><img src="http://latex.codecogs.com/gif.latex? \begin{cases}
                    \rho_{21}(t)=\rho_{21}(0)e^{-t/T_2}\\
                    \rho_{12}(t)=\rho^{*}_{21}(t)
                    \end{cases}" /></P>
                <P>这两个过程都会以一种随时间指数衰减的模式导致量子信息流失到外界。其中 <img src="http://latex.codecogs.com/gif.latex?T_1" /> ， <img src="http://latex.codecogs.com/gif.latex?T_2" /> 就是描述这两个过程所使用的参量。它们越大意味着量子信息的保存时间越长，原则上在整个量子线路中所消耗的总时间不应该超过这两个参量中的任何一个。</P>
            </div>
        </div>
    </div>
</div></#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("量子计算原理");
	App.dragRefresh();
});
</script>
</@main.footer>