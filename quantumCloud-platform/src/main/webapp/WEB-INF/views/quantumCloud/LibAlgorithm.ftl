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
    <div class="content">
        <div class="news-box"></div>
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <!--box-->
        <style>
            body{
                background: #fff;
            }
            .navbar{
                position: absolute;
            }
            .content{
                padding-top: 0!important;
            }
            .navbar{
                background: url(${base}/assets/images/jcTopBg.png) repeat-x;
                background-color: transparent;
            }

            .content{
                position: relative;
            }
            .content:before{
                content: '';
                width: 50%;
                left:0;
                top:0;
                background: #f0f4fb;
                position: absolute;
                height: 100%;
                background-size: 100% 100%;
            }


        </style>

        <div class="algContent">
            <div class="algLeft fixed">
                <div class="algLeftContent">
                    <div class="title">全部算法</div>
                    <div class="algListBox">
                        <ul>
                            <li class="active">
                                <a href="#0" title="随机数生成">随机数生成</a>
                            </li>
                            <li>
                                <a href="#1" title="D-J Algorithm">D-J Algorithm</a>
                            </li>
                            <li>
                            	<a href="#2" title="Mayer-Penny Game in Quantum">Mayer-Penny Game in Quantum</a>
                                
                            </li>
                            <li>
                                <a href="#3" title="Swap Test 算法">Swap Test 算法</a>
                            </li>
                            <li>
                                <a href="#4" title="Simon 算法">Simon 算法</a>
                            </li>
                            <li>
                                <a href="#5" title="Bernstein-Vazirani Algorithm 算法">Bernstein-Vazirani Algorithm 算法</a>
                            </li>
                            <li>
                                <a href="#6" title="HHL算法">HHL算法</a>
                            </li>
                            <li>
                                <a href="#7" title="Counterfeit Coin Game文档">Counterfeit Coin Game文档</a>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>
            <div class="algRight">
                <div class="algRight_con">
                    <div class="algRight_box">
                        <div class="jcTitle">文章导读目录:</div>
                        <div class="jcIndexList">
                            <ul>
                                <li class="active">
                                    <a href="javascript:;">问题描述</a>
                                </li>
                                <li>
                                    <a href="javascript:;">参考线路图 </a>
                                </li>
                                <li>
                                    <a href="javascript:;">参考代码 </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="algCenter">

                <div class="news-text">
                    <div class="indexes_con ">
                        <div class="indexes_box">
                            <a href="${base}/QCode/library.html">教程</a> <span>></span>
                            <a href="javascript:;">教程文档</a>
                            <span>></span>
                            <span id="nlName">随机数生成</span>
                        </div>
                    </div>
                <#--随机数-->
                    <div class="algCollCode active">
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
                                        <p>$$\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1}|x\left.  \right \rangle{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{ \sqrt{2}})}\xrightarrow{Oracle}\frac{1}{\sqrt{2^n}}\sum_{x=0}^{2^n-1} {(-1)^{f(x)}}  |x\left.  \right \rangle{(\frac{|0\left.  \right \rangle-|1\left.  \right \rangle}{ \sqrt{2}})}$$</p>

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
                                    <p>$$  FH=\begin{bmatrix}0&1\\1&0\end{bmatrix}\begin{pmatrix}1\\0\end{pmatrix}=\begin{pmatrix}0\\1\end{pmatrix}=T ,FT=\begin{bmatrix}0&1\\1&0\end{bmatrix}\begin{pmatrix}0\\1\end{pmatrix}=\begin{pmatrix}1\\0\end{pmatrix}=H $$</p>
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
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/jquery.nicescroll.min.js"></script>
<script>
    $(document).ready(function () {
        $(".footer-container.fixed-bottom").css({"position":"static"})
        Array.prototype.distinct = function(){
            var arr = this,
                    result = [],
                    i,
                    j,
                    len = arr.length;
            for(i = 0; i < len; i++){
                for(j = i + 1; j < len; j++){
                    if(arr[i] === arr[j]){
                        j = ++i;
                    }
                }
                result.push(arr[i]);
            }
            return result;
        }
        $(function () {
            getSide()
        })
        //    获取右侧导航条
        function getSide() {
            var GetArray=[];
            var html='';
            $(".algCollCode.active .alt_n_title").each(function (i,s) {
                if($(this).offset().top!=0){
                    GetArray.push($(this).offset().top)
                }
                mainPage=GetArray.distinct()
                html +='<li><a href="javascript:;" data-value="'+i+'">'+$(this).text()+'</a> </li>'
            })

            $(".jcIndexList ul").html(html)

            guide()
        }
        function guide() {
            var nav = $(".jcIndexList ul li");
//        移动位置
            var mainPage = $(".algCollCode.active .alt_n_title");
            var mainTopArr = new Array();
            for(var i=0;i<mainPage.length;i++){
                var top = mainPage.eq(i).offset().top;
                mainTopArr.push(top);
            }
            $(window).scroll(function(){
                scrollSize()
            });
            function scrollSize() {

                var scrollTop = $(this).scrollTop();
                var k;
                for(var i=0;i<mainTopArr.length;i++){
                    var s=mainTopArr[i]-20
                    if(scrollTop>=s){
                        k=i
                    }
                }
//                console.log(k)
                nav.eq(k).addClass("active").siblings().removeClass("active");
//                $(".arrow").css({top: 4+ 30*k})
            }
            $(".jcIndexList ul").find("li").on("click",function (e) {
//                console.log(mainTopArr)
//
//                console.log($(this).find("a").attr("data-value"))
                console.log(mainTopArr)
                $('html, body').animate({scrollTop:mainTopArr[($(this).find("a").attr("data-value"))]-66}, 400);

                e.preventDefault();
                e.stopPropagation()
            })

            scrollSize()
        }



        $(".algListBox ul li").each(function () {
            if($(this).find("a").attr("href")==window.location.hash){
                $(this).addClass("active").siblings().removeClass("active");
                $(".algCollCode").eq($(this).index()).addClass("active").siblings().removeClass("active");
                $(this).find("a").click()
                $("#nlName").html($(".algListBox ul li.active a").text())
            }
        })

        $(".algListBox ul li").on("click",function () {
            $(this).addClass("active").siblings().removeClass("active");
            $(".algCollCode").eq($(this).index()).addClass("active").siblings().removeClass("active");
            $("#nlName").html($(".algListBox ul li.active a").text())
            $(".alt_n_code").getNiceScroll().resize();
            $(".alt_n_code").getNiceScroll().show();
            getSide()
        })



        $(".algCenter").css({"margin-right":$(".algRight").width()})
        $("#algorithm").addClass('active').siblings().removeClass('active')
        t = $('.fixed').offset().top;
        $(window).scroll(function(){
            s = $(document).scrollTop();
            if(s > t - 10){
                $('.fixed').css('position','fixed');
                $('.fixed').css('left','auto');
                $(".algRight").css('position','absolute');

                $(".algRight").css('right','0px');
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

                $(".algRight").css('right','0');

            }
        });




        $('.jcIndexList ul li').click(function () {
            $(this).addClass('active').siblings().removeClass('active')
        })


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


    });
</script>
</@main.footer>
