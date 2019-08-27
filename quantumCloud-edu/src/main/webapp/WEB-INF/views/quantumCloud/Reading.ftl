<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html></#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
        <div class="content  clearfix" style="min-width:1200px;">
            <!--top-->
            <@main.top5>
                <#escape x as x?html></#escape>
            </@main.top5>
            <div class="bannerOrSwiper">
                <div class="banner" style="position: relative;">
                    <img src="${base}/assets/images/EduImg/jpeg_web_banner.jpg" alt="" style="width:100%;">
                </div>
                <div class="ReadingBox">
                    <div class="chooseRead">
                        <div>
                            <div class="bookSection1 sectionBtn" data-list="1" style="display: none  ">
                                <div class="sectionImg"></div>
                                <img src="${base}/assets/images/EduImg/icon_web_book2.png" alt="">
                                <h3>书籍</h3>
                            </div>
                            <div class="bookSection2 sectionBtn" data-list="1">
                                <img src="${base}/assets/images/EduImg/icon_web_book1.png" alt="">
                                <h3>书籍</h3>
                            </div>
                        </div>
                        <div class="chooseRead-line"></div>
                        <div>
                            <div class="paperSection1 sectionBtn" data-list="2">
                                <img src="${base}/assets/images/EduImg/icon_web_paper2.png" alt="">
                                <h3>论文</h3>
                            </div>
                            <div class="paperSection2 sectionBtn" style="display: none" data-list="2">
                                <img src="${base}/assets/images/EduImg/icon_web_paper1.png" alt="">
                                <h3>论文</h3>
                            </div>
                        </div>
                    </div>
                    <div class="Reading-con">
                        <div>
                            <div class="Reading-con-left">
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_1.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>量子计算与量子信息原理</h3>-->
                                            <#--<h4 class="title2">第一卷：基本概念</h4>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Giuliano Benenti</li>-->
                                                <#--<li>Giulio Casati</li>-->
                                                <#--<li>Giuliano Strini</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>王文阁  李保文 &nbsp;&nbsp;&nbsp;译</p>-->
                                            <#--<p>出版社：科学出版社</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>本书是Giuliano Benenti, Giulio Cusati 和Giuliano Strini 合著的Principles of Quantum Computation and Information I的中译本，前两章简介量子力学与经典计算的基本内容，并不需要读者事先掌撵量子力学或者经典计算的知识;后两章讨论量子计算和量子信息领域的主要成果，本书内容深人浅出，层次分明，参考文献丰富,并附有大量习题与答案.</p>-->
                                        <#--<p>本书可作为物理学、数学和计算机科学等学科的本科生和研究生的“量子计算与量子信息导论课”的教材，也可供相关专业的教师和科研人员参考。</p>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_3.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>量子计算和量子信息(一)</h3>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Michael A. Nielsen</li>-->
                                                <#--<li>Isaac L. Chuang</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>赵千川  &nbsp;&nbsp;&nbsp;译</p>-->
                                            <#--<p>清华大学出版社</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--本书是剑桥大学出版社出版的Micheal A.Nielsen 和Isaac L.Chuang合著的Quantum Computation and Quantum Information 的量子计算部分的中译本。-->
                                        <#--</p>-->
                                        <#--<p>-->
                                            <#--量子计算和量子信息是涉及物理学、计算机科学和数学等多学科的综合性交叉研究领域。本书首先介绍基础知识，然后着重介绍量子计算的主要研究成果，包括量子线路、量子Fourier变换及其应用、量子搜索算法和量子计算机的物理实现。-->
                                        <#--</p>-->
                                    <#--</div>-->
                                <#--</div>-->

                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_5.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>Principles of Quantum Computat- ion and Information</h3>-->
                                            <#--<h4 >Volume I: Basic Concepts</h4>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Giuliano Benenti</li>-->
                                                <#--<li>Giulio Casati</li>-->
                                                <#--<li>Giuliano Strini</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>World Scientific Press</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--In volume I, after providing the necessary background material in classical computation and quantum mechanics, we develop the basic principles and discuss the main results of quantum computation and information. Volume I would thus be suitable for a one-semester introductory course in quantum information and computation, for both undergraduate and graduate students. It is also our intention that volume I be useful as a general education for other readers who wish to learn the basic principles of quantum computation and information and who have the basic background in physics and mathematics acquired in undergraduate courses in physics, mathematics or computer science.-->
                                        <#--</p>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_7.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>QUANTUM COMPUTING</h3>-->
                                            <#--<h4 >From Linear Algebra to Physical Realizations</h4>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Mikio Nakahara</li>-->
                                                <#--<li>Tetsuo Ohmi </li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>CRC Press <br/> Tayler & Francis Group</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--Quantum computing and quantum information processing are emerging disciplines in which the principles of quantum physics are employed to store and process information. We use classical digital technology at almost every moment in our lives: computers, mobile phones, mp3 players, just to name a few. Even though quantum mechanics is used in the design of devices such as LSI, the logic is purely classical. This means that an AND circuit, for example, produces definitely 1 when the inputs are 1 and 1. One of the most remarkable aspects of the principles of quantum physics is the superposition principle by which a quantum system can take several different states simultaneously. The input for a quantum computing device may be a superposition of many …                                    </p>-->
                                    <#--</div>-->
                                <#--</div>-->

                            </div>
                            <div class="Reading-con-right">
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_2.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>Quantum Computer Science</h3>-->
                                            <#--<h4>An Introduction</h4>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>N.David Mermin</li>-->
                                                <#--<li>Cornell University</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>Cambridge University Press</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--In the 1990s it was realized that quantum physics has some spectacular applications in computer science. This book is a concise introduction to quantum computation, developing the basic elements of this new branch of computational theory without assuming any background in physics. It begins with a novel introduction to the quantum theory from a computer-science perspective. It illustrates the quantum-computational approach with several elementary examples of quantum speed-up, before moving to the major applications: Shor’s factoring algorithm, Grover’s search algorithm, and quantum error correction.-->
                                        <#--</p>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_4.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>Quantum Computation and Quantum Information</h3>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Michael A. Nielsen</li>-->
                                                <#--<li>Isaac L. Chuang</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>Cambridge University Press</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--This comprehensive textbook describes such remarkable effects as fast quantum algorithms, quantum teleportation, quantum cryptography, and quantum error-correction. Quantum mechanics and computer science are introduced, before moving on to describe what a quantum computer is, how it can be used to solve problems faster than “classical” computers, and its real-world implementation. It concludes with an in-depth treatment of quantum information. Containing a wealth of figures and exercises, this well-known textbook is ideal for courses on the subject, and will interest beginning graduate students and researchers in physics, computer science, mathematics, and electrical engineering.-->
                                        <#--</p>-->
                                    <#--</div>-->
                                <#--</div>-->
                                <#--<div class="book-des">-->
                                    <#--<div>-->
                                        <#--<img src="${base}/assets/images/EduImg/icon_web_6.png" alt="">-->
                                        <#--<div class="book-info">-->
                                            <#--<h3>Principles of Quantum Computat- ion and  Information</h3>-->
                                            <#--<h4>Volume II: Basic Tools and Special Topics</h4>-->
                                            <#--<ul class="book-author">-->
                                                <#--<li>Giuliano Benenti</li>-->
                                                <#--<li>Giulio Casati</li>-->
                                                <#--<li>Giuliano Strini</li>-->
                                                <#--<span class="zhu">著</span>-->
                                            <#--</ul>-->
                                            <#--<p>World Scientific Press</p>-->
                                        <#--</div>-->
                                    <#--</div>-->
                                    <#--<div class="book-Introduction">-->
                                        <#--<p>-->
                                            <#--Volume II deals with various important aspects, both theoretical and experimental, of quantum computation and information. The areas include quantum data compression, accessible information, entanglement concentration, limits to quantum computation due to decoherence, quantum error correction, and the first experimental implementations of quantum information protocols. This volume also includes a selection of special topics:chaos and the quantum-to-classical transition, quantum trajectories, quantum computation and quantum chaos, and the Zeno effect. For an understanding of this volume, a knowledge of the material discussed in the first volume is necessary.-->
                                        <#--</p>-->
                                    <#--</div>-->
                                <#--</div>-->
                            </div>
                            <div class="content-bottom">* 本页面介绍的书籍不提供在线下载阅读，请前往正规渠道购买学习</div>
                        </div>
                        <div style="display:none;">
                            <div class="paperBox">
                                <div class="paperList">
                                    <div class="paperList-title">VQNet: Library for a Quantum-Classical Hybrid Neural Network</div>
                                    <p>
                                        <span class="buleTitle">Authors: </span>
                                        <span>Zhao-Yun Chen, Cheng Xue, Si-Ming Chen, Guo-Ping Guo</span>
                                    </p>
                                    <p>
                                        <span class="buleTitle">Submitted: </span>
                                        <span>25 January, 2019; </span>
                                        <span class="buleTitle">Joriginally announced: </span>
                                        <span>January 2019.</span>

                                    </p>
                                    <div class="paperList-con">
                                        Abstract: Deep learning is a modern approach to realize artificial intelligence. Many frameworks exist to implement the machine learning task; however, performance is limited by computing resources. Using a quantum computer to accelerate training is a promising approach. The variational quantum circuit (VQC) has gained a great deal of attention because it can be run on near-term quantum computers. In this paper, we establish a new framework that merges traditional machine learning tasks with the VQC. Users can implement a trainable quantum operation into a neural network. This framework enables the training of a quantum-classical hybrid task and may lead to a new area of quantum machine learning.
                                    </div>
                                    <p>
                                        <span class="buleTitle">论文地址：</span>
                                        <span>https://arxiv.org/abs/1901.09133</span>
                                    </p>
                                </div>
                                <div class="paperList">
                                    <div class="paperList-title">OriginIR: High-Level Language for Quantum-Classical Hybrid Programming</div>
                                    <p>
                                        <span class="buleTitle">Authors: </span>
                                        <span> Zhao-Yun Chen, Guo-Ping Guo</span>
                                    </p>
                                    <p>
                                        <span class="buleTitle">Submitted: </span>
                                        <span>4 January, 2019;  </span>
                                        <span class="buleTitle">originally announced:</span>
                                        <span>January 2019.</span>
                                    </p>
                                    <div class="paperList-con">
                                        Abstract: Hybrid quantum-classical algorithms have drawn much attention because of their potential to realize the "quantum advantage" in noisy, intermediate-scale quantum (NISQ) devices. Here we introduce OriginIR, a cross-platform quantum language for hybrid programming. OriginIR can be compiled to various host backends, allowing the user to write portable quantum subprograms. The hybrid programming is based on the type system, which is used to decide where a statement should be run. We also introduce Qurator, a VSCode plugin that has OriginIR language support and two host backends.                                    <p>
                                    </div>
                                    <p>
                                    <span class="buleTitle">论文地址：</span>
                                        <span>https://arxiv.org/abs/1901.08340</span>
                                    </p>
                                </div>
                                <div class="paperList">
                                    <div class="paperList-title">64-Qubit Quantum Circuit Simulation</div>
                                    <p>
                                        <span class="buleTitle">Authors: </span>
                                        <span>Zhao-Yun Chen, Qi Zhou, Cheng Xue, Xia Yang, Guang-Can Guo, Guo-Ping Guo</span>
                                    </p>
                                    <p>
                                        <span class="buleTitle">Submitted: </span>
                                        <span>12 July, 2018; v1 submitted 19 February, 2018; </span>
                                        <span class="buleTitle"> originally announced: </span>
                                        <span class="buleTitle"> February 2018. </span>
                                    </p>
                                    <div class="paperList-con">
                                        Abstract: Classical simulations of quantum circuits are limited in both space and time when the qubit count is above 50, the realm where quantum supremacy reigns. However, recently, for the low depth circuit with more than 50 qubits, there are several methods of simulation proposed by teams at Google and IBM. Here, we present a scheme of simulation which can extract a large amount of measurement outcomes within a short time, achieving a 64-qubit simulation of a universal random circuit of depth 22 using a 128-node cluster, and 56- and 42-qubit circuits on a single PC. We also estimate that a 72-qubit circuit of depth 23 can be simulated in about 16 h on a supercomputer identical to that used by the IBM team. Moreover, the simulation processes are exceedingly separable, hence parallelizable, involving just a few inter-process communications. Our work enables simulating more qubits with less hardware burden and provides a new perspective for classical simulations.
                                    </div>
                                    <p>
                                        <span class="buleTitle">论文地址：</span>
                                        <span>https://arxiv.org/abs/1901.08340</span>
                                    </p>
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
    <script>
        $(document).ready(function () {
            $('.bookSection1').click()
        })
        var domClickArr = [],flag=null;
        $('.sectionBtn').on('click',function () {
            var list = $(this).attr('data-list');
            var type = (list-1).toString()
            console.log(type)
            $.ajax({
                type:"POST",
                url:"${base}/EDU/Reading.json",
                dataType:'json',
                data:{"type":type},
                success:function (data) {
                    if (type == 0){
                        var leftHtml='',rightHtml="";
                        data.obj.forEach(function (item,index) {
                            var html='',authorList='';
                            item.authorList.forEach(function (item,index) {
                                authorList += '<li>'+ item +'</li>'
                            })
                            html +='<div class="book-des">\n' +
                                '<div>\n' +
                                '<img src="${base}/${setting['files.contextpath']}'+item.image+'" alt="">\n' +
                                '<div class="book-info">\n' +
                                '<h3>'+ item.title +'</h3>\n' +
                                '<ul class="book-author">\n' +
                                authorList +
                                ' <span class="zhu">著</span>\n' +
                                '</ul>\n' +
                                '<p>'+item.translator  +'&nbsp;&nbsp;&nbsp;译</p>\n' +
                                '<p>'+item.publisher+'</p>' +
                                '</div>\n' +
                                '    </div>\n' +
                                '    <div class="book-Introduction">\n' +
                                '        <p>' + item.context +'</p>\n' +
                                '    </div>\n' +
                                '</div>'
                            if(index%2==0){
                                leftHtml += html
                            }else {
                                rightHtml += html
                            }
                        })
                        $('.Reading-con-left').html(leftHtml)
                        $('.Reading-con-right').html(rightHtml)
                    }else {
                        var html ='';
                        data.obj.forEach(function (item,index){
                            var authorList='';
                            item.authorList.forEach(function (item,index) {
                                authorList += item + " ,"
                            })
                            html +='<div class="paperList">\n' +
                                '<div class="paperList-title">'+item.title+'</div>\n' +
                                '<p>\n' +
                                '    <span class="buleTitle">Authors: </span>\n' +
                                '    <span>'+ authorList +'</span>\n' +
                                '</p>\n' +
                                '<p>\n' +
                                '    <span class="buleTitle">Submitted: </span>\n' +
                                '    <span>'+item.submitted +'</span>\n' +
                                '    <span class="buleTitle">Joriginally announced: </span>\n' +
                                '    <span>'+ item.joriginallyannounced +'.</span>\n' +
                                '\n' +
                                '    </p>\n' +
                                '    <div class="paperList-con">\n' +
                                item.context +
                                '    </div>\n' +
                                '    <p>\n' +
                                '        <span class="buleTitle">论文地址：</span>\n' +
                                '        <a style="color: #808080;" href='+ item.site  +'>'+ item.site +'</a>\n' +
                                '    </p>\n' +
                                '</div>\n'
                        })
                        $('.paperBox').html(html)
                    }
                }
            })
            if(flag == list){
                return false
            }
            flag = list
            $('.Reading-con>div').eq(list-1).show().siblings().hide()
            domClickArr.push($(this))
            if(domClickArr.length >1){
                var dom = domClickArr.splice(0,1)[0]
                $(dom).show().siblings().hide()
            }
            $(this).hide().siblings().show()
        })

    </script>
</@main.footer>
