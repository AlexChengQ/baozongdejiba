<#-- Mathjax 公共js -->
<#macro mathjax>
    <style>
        .mn {
            background: inherit!important;
            color: inherit;
        }
        img{
            max-width: 100%;
        }
    </style>
    <script type="text/x-mathjax-config">
        //Mathjax相关配置
        MathJax.Hub.Config({
            showProcessingMessages: false,  //关闭js加载过程信息
            messageStyle: "none",  //不显示信息
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath:  [ ["$", "$"] ],   //行内公式选择$
                displayMath: [ ["$$","$$"] ],  //段内公式选择$$
                skipTags: ['script', 'noscript', 'style', 'textarea', 'pre','code','a'],  //避开某些标签
                ignoreClass:"comment-content"  //避开含该Class的标签
            },
            "HTML-CSS": {
                availableFonts: ["STIX","TeX"],   //可选字体
                imageFont: null   //去除图片加载
            }
        });
        MathJax.Hub.Queue(function () {
            document.getElementsByClassName("news-box")[0].style.opacity=1;
            if (document.getElementById("loading")) {
                document.getElementById("loading").style.display="none";
            }
        });
    </script>
    <script type="text/javascript" src="${base}/assets/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
    <#nested>
</#macro>


<#--公共左侧栏-->
<#macro left title="">
    <div class="news-left fixed">

        <div class="fh"><h4>${title}</h4></div>
        <ul>
            <li id="welcome" class="n-cur" >
                <a href="${base}/QCode/brief/welcome.html">
                    <h5>欢迎来到量子的世界<p class="f12 f999 ">Welcome To The World Of Quantum</p></h5>
                </a>
            </li>

            <li id="world" class="" >
                <a href="${base}/QCode/brief/world.html">
                    <h5>量子世界<p class="f12 f999 ">Quantum World</p></h5>
                </a>
            </li>

            <li id="mechanics" class="" >
                <a href="${base}/QCode/brief/mechanics.html">
                    <h5>量子力学<p class="f12 f999 ">Quantum Mechanics</p></h5>
                </a>
            </li>

            <li id="theory" class="" >
                <a href="${base}/QCode/brief/theory.html">
                    <h5>量子计算原理<p class="f12 f999 ">Theory of Quantum Computing</p></h5>
                </a>
            </li>

            <li id="algorithm" class="" >
                <a href="${base}/QCode/brief/algorithm.html">
                    <h5>量子算法<p class="f12 f999 ">Quantum Algorithm</p></h5>
                </a>
            </li>

        </ul>
        <div class="lh">
            <i class="iconfont icon-icon"></i>
            <a href="${base}/QCode/library.html">返回至列表</a>
        </div>
    </div>
    <#nested>
</#macro>

<#macro NewLeft title="" type="">

<style>

</style>
<style>
    .footer-container{
        margin-top: 0;
    }
    body{
        background: #fff;
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
    /*.content:after{*/
    /*content: '';*/
    /*width: 50%;*/
    /*right:0;*/
    /*top:0;*/
    /*position: absolute;*/
    /*height: 100%;*/
    /*!*background: #fff;*!*/
    /*}*/
    .algContent{
        width: 1200px;
        margin: 0px auto 0;
        position: relative;
    }
    .algLeft{
        width: 210px;
        position: absolute;
        top:0;
        left:0;

    }
    .algLeftContent{
        padding-top: 86px;
        margin-left: 20px;
        width: 190px;
        /*background: #ecf0f4;*/
    }
    .algLeftContent .title{
        padding-left: 15px;
        line-height: 24px;
        padding-bottom: 20px;
        border-bottom: 1px solid #ccc;
        text-align: left;
        font-size: 24px;color: #1a1a1a;
    }
    .algListBox li{
        border-bottom: 1px solid #ccc;

        line-height: 65px;
    }
    .algListBox li a{
        padding-left: 15px;
        font-size: 18px;
        color: #333;
        display: block;
    }
    .algListBox li a.active{
        color: #178cec;
    }
    .algListBox li.active a{
        color: #178cec;
    }
    .algCenter{
        width: auto;
        padding: 0 24px;
        margin-left: 210px;
        margin-right: 105px;
        background: #fff;
    }
    .indexes_con{
        padding-top: 5px;
        border-bottom: 1px solid #ccc;
    }
    .indexes_box{
        line-height: 42px;
    }
    .indexes_box a{
        font-size: 14px;
        color: #178cec;
    }
    .indexes_box span{
        color: #333;
        margin: 0 5px;
    }
    .algRight_con{
        padding-top: 134px;
    }
    .algRight_box{
        width: 100%;
        border-left: 2px solid #e6e6e6;
        padding-bottom: 80px;
    }
    .jcTitle{
        line-height: 28px;
        font-size: 14px;
        text-align: left;
        margin-left: 13px;
        color: #333;
        margin-bottom: 12px;
    }
    .algRight{
        float: right;
        min-width: 105px;
        /*position: absolute;*/
        top:0;
        right:0;
        z-index: 56;
    }
    .jcIndexList{
        margin-left: -2px;
    }
    .jcIndexList ul li{
        line-height: 14px;
        font-size: 14px;
        border-left: 2px solid #e6e6e6;

        padding: 8px 0;
        margin-bottom: 12px;
    }
    .jcIndexList ul li a{
        color: #999;
        padding-left: 13px;
    }
    .jcIndexList ul li.active{
        border-color: #178cec;
    }
    .jcIndexList ul li.active a{
        color: #178cec;
    }
    .algorithm_con{
        width: 100%;
        padding-left: 25px;
    }
    .algorithm_con ul li{

    }
    .algorithm_con ul li a{
        font-size: 14px;
        color: #808080!important;
    }
    .algorithm_con ul li.active a{
        color: #178cec!important;
    }
    
    .algorithm_sub a{
    	line-height:20pt;
    }
</style>
<div class="algLeft fixed">
    <div class="algLeftContent">
        <div class="title">全部算法</div>
        <div class="algListBox">
            <ul>
                <li id="welcome" class="active">
                    <a href="${base}/QCode/brief/welcome.html"><@spring.message code="welcome_to_the_quantum_world" /></a>
                </li>
                <li id="world">
                    <a href="${base}/QCode/brief/world.html"><@spring.message code="quantum_world" /></a>
                </li>
                <li id="mechanics">
                    <a href="${base}/QCode/brief/mechanics.html"><@spring.message code="quantum_mechanics" /></a>
                </li>
                <li id="theory">
                    <a href="${base}/QCode/brief/theory.html"><@spring.message code="principles_of_quantum_computation" /></a>
                </li>
                <li id="algorithm">
                    <a href="${base}/QCode/brief/algorithm.html"><@spring.message code="quantum_algorithm" /></a>
                    <div class="algorithm_con" style="display:none;">
                        <ul class="algorithm_sub">
                            <li>
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
                </li>

            </ul>
        </div>
    </div>
</div>
    <#nested>
</#macro>