<#-----author:JT------->
<#-----date:2018-01-09------->
<@main.header>
<#escape x as x?html>
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
<!--box-->
<#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
    <div class="list_banner" style="background:url(${base}/assets/images/list_banner_8.jpg) no-repeat center center;">
        <div class="w1400"><h2>|&nbsp;&nbsp;Spcd-6Q 超导量子芯片</h2></div>
    </div>
    <table border="1" width="1100px"  cellspacing="0"  class="table-box" style="margin: 0 auto;">
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
    
    <div class="list">
        <div class="show_a">Spcd-6Q 超导量子芯片</div>
        <div class="show_c">
            <p>　　◎<strong>超导量子芯片</strong>Spcd-6Q</p>
            <p align="center"><img src="${base}/assets/images/bba.jpg" alt="USTC-Super-6Q（白）.jpg" width="400" height="388" border="0"></p>
            <p>　　Spcd-6Q是基于电路量子电动力学体系构建的6位量子比特芯片。</p>
            <p>　　超导量子芯片是基于对超导约瑟夫森结构进行改造，构造出超导量子比特，并通过“量子数据总线”来实现6个超导量子比特的任意两两相互耦合。利用精确设计的脉冲序列，可以实现高保真度的量子逻辑门操作，进而能够设计并演示量子算法。</p>
            <p>&nbsp;</p>
            <p>　　◎&nbsp;<strong>超导量子比特</strong></p>
            <p>　　超导量子比特是通过对超导约瑟夫森结进行改造设计出的人造原子，我们定义该“人造原子”最低的两个能级为量子<img src="http://latex.codecogs.com/gif.latex? |0\rangle" alt="">态与量子<img src="http://latex.codecogs.com/gif.latex? |1\rangle" alt="">态。与经典比特相比，最大的区别是量子比特可以处于<img src="http://latex.codecogs.com/gif.latex? |0\rangle" alt="">和<img src="http://latex.codecogs.com/gif.latex? |1\rangle" alt="">的任意叠加态上，从而获得远大于经典比特的存储信息能力以及更强大的计算能力。</p>
            <p>&nbsp;</p>
            <p>　　◎&nbsp;<strong>量子数据总线</strong></p>
            <p>　　量子数据总线是一种强大的功能结构，借助量子数据总线中的微波光子，能够实现多个量子比特之间的长程耦合与信息传递。</p>
            <p>&nbsp;</p>
            <p>　　◎&nbsp;<strong>量子逻辑门操作</strong></p>
            <p>　　通过精确设计的脉冲序列，我们能够控制人造原子的能级演化过程，进而类比经典逻辑门操作衍化出一系列量子逻辑门操作。</p>
            <p>&nbsp;</p>
            <p>　　◎&nbsp;<strong>超导量子芯片的优势</strong></p>
            <p>　　<strong>操作数大</strong>：超导量子比特相干时间长，操作速度快，保真度高，总体能够实现上千次操作。</p>
            <p>　　<strong>工艺成熟</strong>：相对其他固态量子芯片体系，超导量子比特受材料缺陷的影响更小，利用成熟的纳米加工技术，可以实现大批量生产。</p>
            <p>　　<strong>可扩展性好</strong>：超导量子比特结构简单，调控方便，极易扩展。</p>
            <p>&nbsp;</p>
            <p style="text-align: right;"><span style="color: rgb(102, 102, 153);"><span style="font-size: 12px;"><span style="font-family: 黑体;">&nbsp;（图文版权归本站所有，如需转载，请联系我们）</span></span></span></p>        </div>
    </div>
</#escape>
</@main.body>
<@main.footer>
<script>
    //用户下拉
    $('.mingzi').mouseenter(function () {$('.admin-none').css('display','block');});
    $('.admin-none').mouseleave(function () {$(this).css('display','none')});
    $('.admin').mouseleave(function () {$('.admin-none').css('display','none');});
</script>
</@main.footer>