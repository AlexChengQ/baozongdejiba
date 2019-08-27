<#-----author:JT------->
<#-----date:2018-01-09------->
<@main.header>
<#escape x as x?html></#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content">
<!--top-->
<@main.top5>
<#escape x as x?html></#escape>
</@main.top5>
<!--top end-->
<!--box-->
<#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
    <div class="list_banner" style="background:url(${base}/assets/images/list_banner_8.jpg) no-repeat center center;">
        <div class="w1400"><h2>|&nbsp;&nbsp;半导体量子芯片</h2></div>
    </div>
    <table border="1" width="1100"  cellspacing="0" class="table-box" style="margin: 0 auto">
        <thead>
            <tr>
                <th>qubit</th>
                <th>T1/ns</th>
                <th>T2/ns</th>
                <th>fidelity</th>
            </tr>
        </thead>
        <tbody>
            <tr class="table-one">
                <td>q[0]</td>
                <td>19</td>
                <td>1.2</td>
                <td rowspan="3" style="line-height: 90px;">0.68</td>
            </tr>
            <tr class="table-two">
                <td>q[1]</td>
                <td>18</td>
                <td>5.59</td>
            </tr>
        </tbody>
    </table>
    <div class="list">
        <div class="show_a">Semi-2Q 半导体量子芯片</div>
        <div class="show_c">
            <p>◎<strong>半导体量子芯片</strong>Semi-2Q</p>
            <p align="center"><img border="0" alt="半导体图2.jpg" width="400" height="203" src="${base}/assets/images/aab.jpg"></p>
            <p align="center">&nbsp;</p>
            <p>　　半导体量子点系统可以很好的结合和利用现代半导体微电子制造工艺，通过纯电控的方式制备、操控与读取量子比特更具稳定性。与现代大规模集成电路类似，半导体量子点系统具有良好的可扩展、可集成特性，被认为是未来实现大规模实用化量子计算的最佳候选体系之一。</p>
            <p>　<strong>　</strong>半导体超快量子计算正处在研究阶段，已取得了很多令人满意的成果：</p>
            <p>◎&nbsp;<strong>超快精确控制</strong></p>
            <p>&nbsp;</p>
            <p>　　类似于经典计算机，理论上复杂的量子逻辑运算可以由单量子比特普适逻辑门和两量子比特控制非门组成。通过调节栅电极上的超快电脉冲，成功实现皮秒量级半导体量子比特超快普适逻辑门操控。进一步地，通过精确控制多路高频脉冲，成功实现半导体两量子比特超快受控非门操控。</p>
            <p>◎&nbsp;<strong>长相干快操控编码</strong></p>
            <p>&nbsp;</p>
            <p>　　量子计算需要在相干时间内完成足够多的相干操控，实现长相干、快操控兼容的量子比特对量子计算尤为重要。利用半导体量子点中多电子态的轨道非对称性，成功实现长相干、快操控兼容的新型杂化量子比特编码。</p>
            <p>&nbsp;</p>
            <p style="text-align: right"><span style="color: rgb(102,102,153)"><span style="font-size: 12px"><span style="font-family: 黑体">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></p>        </div>
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