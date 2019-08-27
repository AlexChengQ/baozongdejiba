<@main.header title="设置">
<#escape x as x?html>
 </#escape> 
</@main.header>

<@main.body>
<div class="title-box m-t-16">
    <div class="js-three">
        <img src="${base}/assets/images/one.png" />
        <h2 class="blue p-t-6">量子仿真QEmulator</h2>
        <p class="f999">连接到服务器上的量子仿真</p>
        <p class="f999">基于量子力学原理给出仿真结果</p>
        <P class="f999">较自由的操作集合</P>
        <p class="f999">量子比特最多可达30位</p>
    </div>
</div>

<div class="title-box m-t-16">
    <div class="js-three">
        <img src="${base}/assets/images/two.png" />
        <h2 class="p-t-6">超导量子芯片Spcd-6Q</h2>
        <p class="f999">较长的相干时间——信息被最大程度的保存</p>
        <p class="f999">普适量子逻辑门操作集合</p>
        <P class="f999">6位量子比特</P>
        <p class="f999">支持多种算法的演示</p>
    </div>
</div>

<div class="title-box m-t-16">
    <div class="js-three">
        <img src="${base}/assets/images/three.png" />
        <h2 class="p-t-6">半导体量子芯片Semi-2Q</h2>
        <p class="f999">利用电荷进行编码</p>
        <p class="f999">超快操作速度（皮秒级）</p>
        <P class="f999">受限的操作集合</P>
        <p class="f999">用于2量子位D-J算法的演示</p>
    </div>
</div>
<div class="weui-cells__title">芯片参数</div>
<div class="title-box m-t-16">
    <div class="pd16">
        <h3>超导量子比特</h3>
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
<div class="title-box m-t-16">
    <div class="pd16">

        <h3>超导量子比特</h3>
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
</@main.body>
<@main.footer>
</@main.footer>