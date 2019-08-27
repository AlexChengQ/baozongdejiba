<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
<script>

</script>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <link rel="stylesheet" href="${base}/assets/css/public.css">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>

        <div id="context" class="company-title m-b-30"  style="margin:0px auto 0px auto; width:1200px" min-height="600px">
            <div class="list">
                <div class="slideTxtBox_2">
                    <div class="hd">
                        <ul>
                            <li class="on"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量子是什么&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
                            <li><span>&nbsp;&nbsp;&nbsp;量子计算机是什么&nbsp;&nbsp;&nbsp;</span></li>
                            <li><span>&nbsp;&nbsp;&nbsp;量子计算机的优势&nbsp;&nbsp;&nbsp;</span></li>
                            <li><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量子云是什么&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
                        </ul>
                    </div>
                    <div class="bd">
                        <ul>
                            <div class="show_c"><p align="center"><img alt="bafb9c3bef404f1494972c510a9dbd2a_th.jpg" width="557" height="318" src="${base}/assets/tutImg/7a8b5217d090c8a110ef30a85a111435.jpg" /></p>
                                <p style="text-align: center">　</p>
                                <p style="text-align: center">　<strong>量子是什么？</strong></p>
                                <p>　　当人们提到量子这个词的时候，就会觉得这是一个高深莫测、捉摸不透的词，但实际上量子这个概念已经悄无声息地作用在这个世界上的每一个角落。理解了&ldquo;量子&rdquo;这个词，才可以搭建从经典物理世界观到达量子物理世界观的桥梁。</p>
                                <p>　　量子物理中最重要的两个概念，一为&ldquo;量子化&rdquo;，二为&ldquo;不同量子态的叠加性&rdquo;。</p>
                                <p>&nbsp; &nbsp; &nbsp; &nbsp; 所谓量子化指的是物理量是离散的，例如一个电子的自旋只能朝上或者朝下没有其他状态。接下来我们来讲状态的叠加性。当我们把电子的自旋朝向比作硬币的正反面，经典的来看一枚硬币的状态只需要用正面和反面就可以描述。而在量子的世界里，&ldquo;硬币&rdquo;(某个物理量)是可以同时处于正面和反面的叠加状态的。换句话说，我们以同样的方法抛出数枚&ldquo;硬币&rdquo;，在经典世界里这样的实验会得到同一个结果，而在量子的世界里会随机出现&ldquo;正面&rdquo;和&ldquo;反面&rdquo;。因为测量硬币只会得到&ldquo;正面&rdquo;或者&ldquo;反面&rdquo;的结果，所以我们可以认为我们在测量前，也就是制备出硬币是处于&ldquo;正面&rdquo;与&ldquo;反面&rdquo;的叠加态的。这里最终结果的随机性不是由于实验误差导致的，而是受物理过程限制的，于是一枚&ldquo;硬币&rdquo;不再可以用&ldquo;正面&rdquo;或者&ldquo;反面&rdquo;来描述了，它可以处于&ldquo;正面&rdquo;与&ldquo;反面&rdquo;的叠加态中。</p>
                                <p>&nbsp;</p>
                                <p style="text-align: center">&nbsp;<img alt="14200006b35bbcdb2ea5.jpg" width="557" height="283" src="${base}/assets/tutImg/6ceab1bf6fa5776e76be4e06df388928.jpg" /></p>
                                <p style="text-align: center">　　<strong>量子比特是什么？</strong></p>
                                <p>　　什么是比特(bit)?</p>
                                <p>　　比特是计算机存储信息的基本单位。我们生活中常用十进制来计数，也就是用0-9这十个数字来表示所有的信息。比如今天走了8134步，在这种描述方式中，个位是4、十位是3、百位是1、千位是8。但如果要将8134存入计算机保存的话，它会被记作1111111000110，这是因为计算机是使用二进制0、1来表示的，而每一个用于存储0、1信息的单位叫做比特。</p>
                                <p>　　经典比特是用电平的高低来分别表示1和0，从而对信息进行编码。而量子比特是用什么编码0和1呢?之前我们提到过，在量子世界里，能量是一份一份出现的，这种现象被我们称为量子化。我们选取一种特殊状态的粒子，它的能量只有两种状态，低能级(基态)，高能级(激发态)。打一个比方，粒子是人，而不同的能级是台阶。站在台阶下边意味着处于基态，站在台阶上边则是处于激发态。我们把低能级编码为0，高能级编码为1，这就是量子比特。</p>
                                <p>　　我们之所以大费周章的将经典比特换成量子比特，是因为量子比特有着特有的性质：量子叠加性和量子纠缠。用庆祝新年用的一串小彩灯为例对比一下经典比特和量子比特编码的区别。对于一串小彩灯，亮代表1，灭代表0。我们可以通过读取每一个彩灯的亮灭得到其中的信息，也可以利用一些方法，操控每一个灯的亮灭，实现计算的功能。这是经典比特所能够实现的全部。而对于量子比特，每一个彩灯不止有亮或灭两种状态，还可以处在既是亮的，又是灭的状态(叠加性)。同时，一个小彩灯的状态可能取决于另一盏彩灯的状态(纠缠性)，这就意味着，同样数量的彩灯，在量子世界里的彩灯，可以储存更多的信息，实现更高效率的操作。</p>
                                <p style="text-align: right"><span style="color: rgb(128,128,128)"><span style="font-family: 黑体"><span style="font-size: 12px"><span style="color: rgb(102,102,153)">（本文图片来源于网络，如涉及版权问题，请联系我们，立即删除。文章版权归本站所有）</span></span></span></span></p>
                            </div>
                        </ul>
                        <ul style="display:none">
                            <div class="show_c"><p style="text-align: center">&nbsp; &nbsp; &nbsp;<img alt="u=3694982393,2676360793&amp;fm=26&amp;gp=0.jpg" width="600" height="341" src="${base}/assets/tutImg/c189c1156e1aeee8ad12e7bf1bbab88a.jpg" /></p>
                                <p style="text-align: center">&nbsp;</p>
                                <p>&nbsp; &nbsp; &nbsp; &nbsp; 以量子比特为基本单位制成的计算机即为量子计算机。如果想实现量子计算机的功能，对实现的装置有五个必然的要求：</p>
                                <p>　　1. 需要能构成量子比特的物理单元，也就是需要一个二能级的体系。一个二能级体系可以视作一个比特，一台真正的量子计算机需要由许许多多比特构成。</p>
                                <p>　　2. 量子比特在计算之前可以调整到我们已知的量子初态。好比每次打算盘前要把珠子复位。</p>
                                <p>　　3. 量子体系能够构建量子逻辑门，能将量子初态变换到我们需要的目标态。一些量子逻辑门可以实现经典计算中加法逻辑门之类的操作，而大部分量子逻辑门进行的操作是经典逻辑门不具有的操作，这个部分我们会在后面详细展示。</p>
                                <p>　　4. 量子比特的末态(计算结果)能够被测量。</p>
                                <p>　　5. 量子体系有足够长的退相干时间，所有的操作和测量能够在退相干时间内完成。维持量子体系是一件十分艰难的事情，它会在很短的时间内失去它作为量子体系的特性，但好在我们操作和读取可以更快，这才使得我们可以构建一台量子计算机。就像在夏天雕刻冰雕，我们要在冰雕化成水之前完成雕刻和拍照的工作。</p>
                                <p style="text-align: right"><span style="color: rgb(102,102,153)"><span style="font-size: 12px"><span style="font-family: 黑体">&nbsp;<span style="text-align: right">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></span></p>
                            </div>
                        </ul>
                        <ul style="display:none">
                            <div class="show_c"><p align="center"><img src="http://118.89.219.200/d/file/1/4/2017-08-31/b5cb4b54c8b21a95f16b1bb4f43dd719.jpg" alt="微信截图_20170831115620.jpg" width="647" height="276" align="" border="0" /></p>
                                <p>　　量子计算机在很多方面相比于传统计算机有着先天优势。</p>
                                <p>　　一、计算速度快。</p>
                                <p>　　由于量子计算机可以存储于操作0与1的相干叠加态。而传统计算机只有0,1两种状态。这意味着同样是N个比特的计算机，量子计算机一次运算最多可以操作<span style="font-size: medium;"><span style="font-family: 宋体; letter-spacing: 0pt;">2</span><sup><span style="font-family: 宋体; letter-spacing: 0pt; vertical-align: super;">n</span></sup></span>组数据，而经典计算机只能处理1组数据。以两个比特为例，经典计算机一次操作可以将01变为10。而量子计算机则可以将(|00&gt;+|01&gt;)&nbsp;变为(|10&gt;+|11&gt;)，相当于同时处理两组数据。这就意味着，随着比特数的增加，量子计算机的计算速度将获得指数级的增长!</p>
                                <p>　　二、能耗低。</p>
                                <p>　　信息论中有一个理论：信息的抹除需要消耗一定的能量。举个例子，传统计算机中，逻辑与门实现的功能为，当输入全部为1时，输出为1，否则输出为零。当得到计算结果为0后，之前的输入信息我们通过结果无法推测。这种计算成为不可逆计算。由于得到输出结果后便抹除了输入的信息，因此需要消耗能量。随着传统计算机集成度的增加，散热问题会越来越棘手。而量子计算则为可逆计算，从输出的结果可以反推出输入的数据。因此热损耗将大大降低。</p>
                                <p>　　由于量子系统的叠加性和纠缠性，可以使量子计算有着指数级别的并行度，当量子比特数目增加到一定程度，计算速度会远远超过目前最强大的计算机。差距有多大呢?假如现在有一个图书馆，我们想找到其中的一本书。如果利用经典计算机，需要一本一本的核对，直到找到了我们想要的书。而通过量子计算机，所有的书都储存在量子比特里，只需要一次查找，就可以直接定位到我们需要的书。同时，根据量子理论中的不可复制原理，量子信息无法被复制和克隆，意味着信息在传输过程中会更加的安全，私有数据很难被窃取，从而使得云计算的安全得以保障。</p>
                                <p style="text-align: right;">　<span style="color: rgb(102, 102, 153);"><span style="font-family: 黑体;"><span style="font-size: 12px;">　(图文版权归本站所有，如需转载，请联系我们)</span></span></span></p>
                            </div>
                        </ul>
                        <ul style="display:none">
                            <div class="show_c"><p style="text-align: center;">　　<img src="${base}/assets/tutImg/61574b0408f9852f3cd2c814d3e58fb9.jpg" alt="微信截图_20170831114953.jpg" width="619" height="340" /></p>
                                <p>&nbsp; &nbsp; &nbsp;量子云是以量子计算为核心的云服务。量子程序将被发送到远程量子服务器上，在云端完成它的编译、执行与测量，最后将结果传回本地。</p>
                                <p style="text-align: right;"><span style="color: rgb(102, 102, 153); font-family: 黑体; text-align: right;"><span style="color: rgb(102, 102, 153);"><span style="font-family: 黑体;"><span style="font-size: 12px;">（图文版权归本站所有，如需转载，请联系我们）</span></span></span></span></p>
                            </div>
                        </ul>
                    </div>
                </div>
                <script>

                </script>

                <div class="clear"></div>

            </div>
        </div>
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script>
$(function () {
    // urlinfo=window.location.href;
    // newsids=urlinfo.split("=");
    // newsid=parseInt(newsids[1])-1;
    // if(newsid>0){
    //     $(".slideTxtBox_2").slide({delayTime:0,pnLoop:false,defaultIndex:newsid});
    // }else{
    //     $(".slideTxtBox_2").slide({delayTime:0,pnLoop:false});
    // }
    $(".hd li").hover(function () {
        $(this).addClass("on").siblings().removeClass("on")
        $(".bd>ul").eq($(this).index()).show().siblings().hide()
    })
})
</script>
</@main.footer>
