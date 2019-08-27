<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="img-box m-t-16">
    <img src="${base}/assets/images/list_banner.png" width="100%" />
    <h2 class="title-position crfff">|&nbsp;&nbsp;Spcd-6Q 超导量子芯片</h2>
</div>
<div class="title-box">
    <div class="pd16">
        <table border="1" width="100%"  cellspacing="0"  class="table-box">
            <thead>
            <tr>
                <th>qubit</th>
                <th>fc/GHz</th>
                <th>fq01/GHz</th>
                <th>T1/us</th>
                <th>T2/us</th>
            </tr>
            </thead>
            <tbody>
            <tr class="table-one">
                <td>q[0]</td>
                <td>6.8587</td>
                <td>5.65</td>
                <td>1.3</td>
                <td>0.53</td>
            </tr>
            <tr class="table-two">
                <td>q[1]</td>
                <td>6.9823</td>
                <td>5.59</td>
                <td>2.1</td>
                <td>0.55</td>
            </tr>
            <tr class="table-one">
                <td>q[2]</td>
                <td>7.1885</td>
                <td>5.44</td>
                <td>2.0</td>
                <td>2.0</td>
            </tr>
            <tr class="table-two">
                <td>q[3]</td>
                <td>7.3177</td>
                <td>5.77</td>
                <td>3.4</td>
                <td>1.3</td>
            </tr>
            <tr class="table-one">
                <td>q[4]</td>
                <td>7.3938</td>
                <td>5.62</td>
                <td>4.6</td>
                <td>0.33</td>
            </tr>
            <tr class="table-two">
                <td>q[5]</td>
                <td>7.5370</td>
                <td>5.50</td>
                <td>2.1</td>
                <td>1.3</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="title-box m-t-16 p-b-50">
    <h2 class="t-center p-tb-16">Spcd-6Q 超导量子芯片</h2>
    <div class="Semi-2Q-info">
        <h3>◎<strong>超导量子芯片</strong>Spcd-6Q</h3>
        <div class="t-center m-tb-10">
            <img class="Semi-2Q-img" src="${base}/assets/images/liang01.png" />
        </div>
        <div class="cr666">
            <p>Spcd-6Q是基于电路量子电动力学体系构建的6位量子比特芯片。</p>
            <p>超导量子芯片是基于对超导约瑟夫森结构进行改造，构造出超导量子比特，并通过“量子数据总线”来实现6个超导量子比特的任意两两相互耦合。利用精确设计的脉冲序列，可以实现高保真度的量子逻辑门操作，进而能够设计并演示量子算法。</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>超导量子比特</strong></h3>
        <div class="cr666">
            <p>超导量子比特是通过对超导约瑟夫森结进行改造设计出的人造原子，我们定义该“人造原子”最低的两个能级为量子<img src="http://latex.codecogs.com/gif.latex? |0\rangle" alt="">态与量子<img src="http://latex.codecogs.com/gif.latex? |1\rangle" alt="">态。与经典比特相比，最大的区别是量子比特可以处于<img src="http://latex.codecogs.com/gif.latex? |0\rangle" alt="">和<img src="http://latex.codecogs.com/gif.latex? |1\rangle" alt="">的任意叠加态上，从而获得远大于经典比特的存储信息能力以及更强大的计算能力。</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>量子数据总线</strong></h3>
        <div class="cr666">
            <p>量子数据总线是一种强大的功能结构，借助量子数据总线中的微波光子，能够实现多个量子比特之间的长程耦合与信息传递。</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>量子逻辑门操作</strong></h3>
        <div class="cr666">
            <p>通过精确设计的脉冲序列，我们能够控制人造原子的能级演化过程，进而类比经典逻辑门操作衍化出一系列量子逻辑门操作。</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>超导量子芯片的优势</strong></h3>
        <div class="cr666">
            <p><strong>操作数大</strong>：超导量子比特相干时间长，操作速度快，保真度高，总体能够实现上千次操作。</p>
            <p><strong>工艺成熟</strong>：相对其他固态量子芯片体系，超导量子比特受材料缺陷的影响更小，利用成熟的纳米加工技术，可以实现大批量生产。</p>
            <p><strong>可扩展性好</strong>：超导量子比特结构简单，调控方便，极易扩展。</p>
        </div>
        <p style="text-align: right; padding-top: 50px; text-indent: 0;">
            <span style="color: rgb(102,102,153)">
                <span style="font-size: 12px">
                    <span>（图文版权归本站所有，如需转载，请联系我们）</span>
                </span>
            </span>
        </p>
    </div>
</div>

</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("超导量子计算机");
});
</script>
</@main.footer>