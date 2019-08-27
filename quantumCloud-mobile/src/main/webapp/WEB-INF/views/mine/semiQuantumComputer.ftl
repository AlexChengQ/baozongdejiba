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
    <h2 class="title-position crfff">|&nbsp;&nbsp;半导体量子芯片</h2>
</div>
<div class="title-box">
    <div class="pd16">
        <table border="1" width="100%"  cellspacing="0" class="table-box">
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
    </div>
</div>
<div class="title-box m-t-16 p-b-50">
    <h2 class="t-center p-tb-16">Semi-2Q 半导体量子芯片</h2>
    <div class="Semi-2Q-info">
        <h3>◎<strong>半导体量子芯片</strong>Semi-2Q</h3>
        <div class="t-center m-tb-10">
            <img class="Semi-2Q-img" src="${base}/assets/images/liang02.png" />
        </div>
        <div class="cr666">
            <p>半导体量子点系统可以很好的结合和利用现代半导体微电子制造工艺，通过纯电控的方式制备、操控与读取量子比特更具稳定性。与现代大规模集成电路类似，半导体量子点系统具有良好的可扩展、可集成特性，被认为是未来实现大规模实用化量子计算的最佳候选体系之一。</p>
            <p>半导体超快量子计算正处在研究阶段，已取得了很多令人满意的成果：</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>超快精确控制</strong></h3>
        <div class="cr666">
            <p>类似于经典计算机，理论上复杂的量子逻辑运算可以由单量子比特普适逻辑门和两量子比特控制非门组成。通过调节栅电极上的超快电脉冲，成功实现皮秒量级半导体量子比特超快普适逻辑门操控。进一步地，通过精确控制多路高频脉冲，成功实现半导体两量子比特超快受控非门操控。</p>
        </div>
        <h3 class="m-t-15 m-b-10">◎&nbsp;<strong>长相干快操控编码</strong></h3>
        <div class="cr666">
            <p>量子计算需要在相干时间内完成足够多的相干操控，实现长相干、快操控兼容的量子比特对量子计算尤为重要。利用半导体量子点中多电子态的轨道非对称性，成功实现长相干、快操控兼容的新型杂化量子比特编码。</p>
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
	App.setTitle("半导体量子计算机");
});
</script>
</@main.footer>