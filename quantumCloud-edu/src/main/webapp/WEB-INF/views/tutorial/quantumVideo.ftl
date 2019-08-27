<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header title="课程视频">
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
    <style>
        body{

            background-size: 100% 100%;
            -webkit-background-size:100% 100% ;
            background-image: url("../../../assets/images/EduImg/pl-bg.jpg")!important;

        }
        .tz-reply-report{
            z-index: 5;
        }
        .zanNum{
            float: left;
            margin-top: 3px;
        }
        .tzComment-type-right a.tzComment-delete{
            padding-left: 20px!important;
        }
    </style>

</@main.header>
<@main.body >
    <#escape x as x?html>
        <meta itemprop="name" content="本源量子"/>
        <meta itemprop="image" content="http://imgcache.qq.com/qqshow/ac/v4/global/logo.png" />
        <meta name="description" itemprop="description" content="这是要分享的内容" />
        <div onbeforeunload="return updataVideoInfo()" class="contentBox" style="padding: 0;">
            <link rel="stylesheet" href="${base}/assets/css/community.css">
            <!--top-->
            <div class="content" style="min-width:1200px; ">
                <@main.top5>
                    <#escape x as x?html></#escape>
                </@main.top5>
                <div class="bannerOrSwiper">
                    <div id="videoContent">
                        <div class="videoBox">
                            <div class="video_n1">
                                <div class="vh_n1_content">
                                    <ul>
                                        <li><span>当前位置：</span></li>
                                        <li><a href="${base}/EDU/index.html">首页  <span>></span></a></li>
                                        <li><a href="${base}/EDU/quantumLearning.html">量子课堂 <span>></span></a></li>
                                        <li><a href="javascript:void(0)" id="videoMenuName">量子计算入门基础 <span>></span></a></li>
                                        <li><a href="javascript:void(0)" id="videoName">量子计算介绍 </a></li>

                                    </ul>
                                    <style>
                                        .vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing.startShowControl .vjs-control-bar{
                                            height: 42px;
                                        }
                                        .vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing.startShowControl .vjs-control-bar .video_control_n1{
                                            opacity: 1;
                                        }
                                    </style>
                                </div>
                                <div class="video_n1_content">
                                    <div class="video_n1_title">
                                        <h1></h1>
                                    </div>
                                    <div class="video_ctrl">
                                        <div class="video_n1_left">
                                            <div class="video_control">
                                                <div class="video_control_center">
                                                    <div id="videoplayer_overlay" style="">
                                                        <div id="videoplayer_outer_container">
                                                            <div id="videoplayer_container">
                                                                <div id="videoplayer">
                                                                    <div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto"
                                                                         class="video-js startShowControl vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-playing vjs-user-inactive"
                                                                         id="my_video_1" style="width: 100%; height: 100%;">
                                                                        <video id="my_video_1_html5_api" data-link="Basic/QuantumConcept.mp4" class="vjs-tech" preload="auto" preload=""  poster=""
                                                                               data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="http://video.qpanda.cn:65520/Basic/QuantumConcept.mp4">
                                                                            <source type="video/mp4" src="http://video.qpanda.cn:65520/Basic/QuantumConcept.mp4">
                                                                        </video>
                                                                        <div></div>
                                                                        <div class="vjs-loading-spinner"></div>
                                                                        <div class="vjs-text-track-display vjs-hidden"></div>
                                                                        <div class="vjs-big-play-button" role="button" aria-live="polite" tabindex="0" aria-label="play video">
                                                                            <span aria-hidden="true"></span>
                                                                        </div>
                                                                        <div class="vjs-control-bar">
                                                                            <#--进度条-->
                                                                            <div class="video_progress">
                                                                                <div class="vjs-progress-control vjs-control">
                                                                                    <div role="slider" aria-valuenow="60.21" aria-valuemin="0" aria-valuemax="100" tabindex="0"
                                                                                         class="vjs-progress-holder vjs-slider" aria-label="video progress bar"
                                                                                         aria-valuetext="3:02">
                                                                                        <div class="vjs-load-progress" style="width: 100%;">
                                                                                            <span class="vjs-control-text" style="left: 0%; width: 0%;"><span>Loaded</span>: 0%</span>
                                                                                            <div style="left: 0%; width: 0%;"></div>
                                                                                        </div>
                                                                                        <div class="vjs-play-progress" style="width: 0%;"><span class="vjs-control-text"><span>Progress</span>: 0%</span>
                                                                                        </div>
                                                                                        <div class="vjs-seek-handle vjs-slider-handle" aria-live="off" style="left: 0%;">
                                                                                            <span class="vjs-control-text"></span></div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div style="clear:both;"></div>

                                                                            <#--控制台操作面板-->
                                                                            <div class="video_control_n1">
                                                                                <div class="vjs-play-control vjs-control  vjs-paused" role="button" aria-live="polite" tabindex="0">
                                                                                    <em class="play-text">暂停</em>
                                                                                    <em class="pause-text">播放</em>
                                                                                    <div class="vjs-control-content"><span class="vjs-control-text">Pause</span></div>
                                                                                </div>
                                                                                <div class="vjs-replay-control">
                                                                                    <em class="play-text">停止</em>
                                                                                    <div class="vjs-control-content"><span class="vjs-control-text">replay</span></div>
                                                                                </div>
                                                                                <div class="vjs-volume-control vjs-control">
                                                                                    <div role="slider" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" tabindex="0"
                                                                                         class="vjs-volume-bar vjs-slider" aria-label="volume level" aria-valuetext="100%">
                                                                                        <div class="vjs-volume-level"><span class="vjs-control-text"></span></div>
                                                                                        <div class="vjs-volume-handle vjs-slider-handle">
                                                                                            <span class="vjs-control-text" id="timesID"></span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="vjs-live-controls vjs-control">
                                                                                    <div class="vjs-live-display" aria-live="off">
                                                                                        <span class="vjs-control-text">Stream Type</span>LIVE
                                                                                    </div>
                                                                                </div>

                                                                                <div class="vjs-fullscreen-control vjs-control " role="button" aria-live="polite" tabindex="0">
                                                                                    <em class="play-text">全屏</em>
                                                                                    <div class="vjs-control-content"><span class="vjs-control-text">Fullscreen</span></div>
                                                                                </div>
                                                                                <div class="vjs-clarity-control">
                                                                                    <div class="clarityLocation"><span id="ulPx">高清</span></div>
                                                                                    <#if !USER_INFO??>
                                                                                        <div class="clarityList">
                                                                                            <ul id="pxBox">
                                                                                                <li id="p720" style="margin-bottom: 5px">超清<span>720P</span></li>
                                                                                                <li id="p360" class="active" style="margin-bottom: 5px">高清<span>360P</span></li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    <#else >
                                                                                        <div class="clarityList">
                                                                                            <ul id="pxBox">
                                                                                                <li id="p720" style="margin-bottom: 5px" onclick="chosePx(event)">超清<span>720P</span></li>
                                                                                                <li id="p360" style="margin-bottom: 5px" onclick="chosePx(event)">高清<span>360P</span></li>
                                                                                            </ul>
                                                                                        </div>
                                                                                    </#if>


                                                                                </div>
                                                                                <div class="vjs-speed-control">
                                                                                    <div class="speedLocation"><span class="speed-box">1.0x</span></div>
                                                                                    <div class="speedList">
                                                                                        <ul class="speed-list-box" onclick="choseSpeed(event)">
                                                                                            <li id="norSpeed">1.0x</li>
                                                                                            <li id="Speed125">1.25x</li>
                                                                                            <li id="fastSpeed">1.5x</li>
                                                                                            <li id="slowSpeed">2.0x</li>
                                                                                        </ul>
                                                                                    </div>

                                                                                </div>
                                                                                <div class="vjs-sound-control">
                                                                                    <div class="vjs-sound-icon">
                                                                                        <span class=""></span>
                                                                                    </div>
                                                                                    <div class="sound-change-box">
                                                                                        <div class="sound-box">
                                                                                            <div class="sound-content" id="progress-con">
                                                                                                <span class="sound-press"></span>
                                                                                                <span class="sound-button" id="scrollBar"></span>
                                                                                                <#--当前声音-->
                                                                                                <span class="sound-index"></span>
                                                                                            </div>

                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="vjs-error-display">
                                                                            <div></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="toAnswer">
                                                        <h2>恭喜你完成本节视频课程学习，请点击下方“项目检测”，完成检测后即可进入下一节学习，加油！</h2>
                                                        <#--<button>去答题</button>-->
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <#--目录-->
                                        <div class="video_n1_right">
                                            <div class="n1_right_header">
                                                <h3>章节目录</h3>
                                            </div>
                                            <div class="n1_menu_box" id="menu_scroll">
                                                <div class="vjs_menu" id="vjs_menu">
                                                    <#--<div class="vjs_menu_details">-->
                                                    <#--<div class="vjs_menu_name">-->
                                                    <#--<h4>第一章  量子计算入门基础</h4>-->
                                                    <#--<i class="vjs_menu_vjs"></i>-->
                                                    <#--</div>-->
                                                    <#--<div class="vjs_menu_list">-->
                                                    <#--<ul></ul>-->
                                                    <#--</div>-->
                                                    <#--</div>-->
                                                </div>
                                            </div>
                                        </div>
                                        <style>

                                        </style>
                                        <div class="vjs_tip">

                                            <div class="resumePlay_tips">
                                                <i onclick="viTipClose()"></i>
                                                <span>上次看到：<span id="oldVideoTime"></span></span>
                                                <button class="resumePlayBtn" onclick="resumePlay()">继续播放</button>
                                            </div>
                                            <span class="second_tips">当前音量：<span>11</span></span>
                                        </div>
                                        <div class="video_share">
                                            <ul >
                                                <style>
                                                    .bdshare-button-style0-16 a, .bdshare-button-style0-16 .bds_more{
                                                        background: transparent!important;
                                                        padding: 0;
                                                        margin: 0;
                                                        float: none;
                                                    }
                                                    .bd_weixin_popup{
                                                        width: 260px!important;
                                                        height: 300px!important;
                                                    }
                                                </style>
                                                <li class="v_share_name"><span>分享：</span></li>
                                                <li class="share_copy"  data-tag="share_1" ><a data-id="1" href="javascript:void(0)" class="copeCode" title="复制网址"><textarea style="opacity: 0;" >1111111111111111111111111</textarea></a></li>
                                                <li class="share_qq bdsharebuttonbox"  data-tag="share_1" ><a data-id="1" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                                <li class="share_wechat bdsharebuttonbox"  data-tag="share_1"><a data-id="1" href="javascript:void(0)" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></li>
                                                <li class="share_sina bdsharebuttonbox"><a data-id="1" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina"></a></li>
                                                <li class="v_share_name">观看次数：<span id="readCount"></span></li>
                                                <#--<li class="v_share_name" onclick="downloadVideo()" style="cursor: pointer">下载</li>-->
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <#--介绍与讨论交流-->
                            <div class="video_n2">
                                <div class="video_n2_left">
                                    <div class="video_n2_header">
                                        <h3>课程介绍</h3>
                                    </div>
                                    <div class="video_n2_lb">

                                        <div class="n2_lb_js"><p>本章节主要介绍了量子力学以及量子计算的发展历程，通过理解量子计算所需的基本概念和基础数学知识，能够对量子计算入门起到导引作用。</p></div>
                                        <div class="n2_lb_box">
                                            <ul>
                                                <li>
                                                    <div class="n2_lb_img">
                                                        <img src="${base}/assets/images/EduImg/Handouts.png" alt="">
                                                    </div>
                                                    <div class="n2_lb_link">
                                                        <a href="${base}/assets/lecture/QuantumWorld.pdf"  id="lectureUrl" target="_Blank">课程讲义</a>

                                                    </div>
                                                </li>
                                                <li>
                                                    <div class="n2_lb_img">
                                                        <img src="${base}/assets/images/EduImg/exercise.png" alt="">
                                                    </div>
                                                    <div class="n2_lb_link questionBox">
                                                        <a href="javascript:void(0)">项目检测</a>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                </div>
                                <div class="video_n2_right">
                                    <div class="video_n2_header">
                                        <h3>讨论交流</h3>
                                    </div>
                                    <div class="n2_jl_box" style="display: none">
                                        <div class="n2_jl_list">
                                            <ul>
                                                <li>
                                                    <i></i>
                                                    <a href="">关于Qurator-VSCode量子程序开发插件?</a>
                                                </li>
                                                <li>
                                                    <i></i>
                                                    <a href="">关于Qurator-VSCode量子程序开发插件? <em>NEW</em></a>
                                                </li>
                                                <li>
                                                    <i></i>
                                                    <a href="">关于Qurator-VSCode量子程序开发插件?</a>
                                                </li>
                                                <li>
                                                    <i></i>
                                                    <a href="">关于Qurator-VSCode量子程序开发插件?</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="pl_box">
                                <div class="tzCommentContent" style="padding-top: 10px">
                                    <div class="tzCommHead">
                                        <div class="tzCommHead_left">
                                            <div class="plTitle">课程评论</div>
                                            <div class="numBox">(666条评论)</div>
                                        </div>
                                        <div class="tzCommHead_right">
                                            <!--div>
                                                发表您的学习评价<span class="blueColor">可以获得积分哦</span>
                                            </div-->
                                        </div>
                                    </div>
                                    <div class="tzCommentReplyBox">
                                        <div class="reviewArea clearfix">
                                            <textarea class="comment-input" maxlength="140" id="contentbox" placeholder="请留下您的问题及建议，我们将积极改善！至少5字以上哦。" onkeyup="keyUP(this)" style="min-height: 80px;height: 124px;"></textarea>
                                            <div class="wordsNum"><span class="fen5 blueColor"></span> <span class="wNum">0/140</span></div>
                                            <a href="javascript:" class="plBtn">发表评论</a>
                                        </div>
                                    </div>
                                    <div class="comments-title clearfix">
                                        <div class="plTitle">评论列表</div>
                                        <ul class="sortList">
                                            <li class="firstList sortActive">评论时间</li>
                                            <#--<li>点赞数</li>-->
                                            <#--<li>回复数</li>-->
                                            <span class="showPic" style="display: none"></span>
                                        </ul>
                                        <div class="sortTitle">排序方式：</div>
                                    </div>
                                    <div class="tzCommentBox">
                                        <div class="tzComment-show-con clearfix">
                                            <div class="plListBox">
                                                <#--<div class="tzComment-replier">-->
                                                <#--<div class="tzComment-replier-img">-->
                                                <#--<img src="../../../assets/images/wx_new1.jpg" alt="">-->
                                                <#--</div>-->
                                                <#--<div class="tzComment-replier-name">本源--量子 </div>-->
                                                <#--</div>-->
                                                <#--<div class="tzComment-Content">-->
                                                <#--<div class="tzComment-Content-con">沙发大师傅</div>-->
                                                <#--<div class="tzComment-Content-type">-->
                                                <#--<div class="tzComment-type-left">-->
                                                <#--<div class="tz-reply-tiem"><span>57分钟前</span></div>-->
                                                <#--</div>-->
                                                <#--<div class="tzComment-type-right">-->
                                                <#--<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">回复</a>-->
                                                <#--<a href="javascript:;" class="zan"><span class="zanNum"></span><span class="zan_Num">0</span></a>-->
                                                <#--<a href="javascript:void(0);" class="pl-more"></a>-->
                                                <#--</div>-->
                                                <#--</div>-->
                                                <#--<div class="tz-reply-report">举报</div>-->
                                                <#--<div class="reply-textarea"></div>-->
                                                <#--<div class="reply-list-con"></div>-->
                                                <#--</div>-->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="thread-reply">
                                        <ul data-v-82963a40="" class="ft paginationNew clearfix">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="reportBoxTop" style="position: fixed;top: 0;background: rgba(0,0,0,0.3);width: 100%;height: 100%;z-index: 4001; display: none">
                    <div class="EDU_reportBox">
                        <div class="reportTitle">
                            <span class="reportClose"></span>
                            <div>请选择举报理由</div>
                        </div>
                        <div class="report_con">
                            <div class="report_con_box">
                                <div class="reportList_title">违法法律法规</div>
                                <ul>
                                    <li>
                                        <input type="radio" id="wfwg" name="report_radio1" value="1">
                                        <label for="wfwg">违法违规</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="sq" name="report_radio1" value="2">
                                        <label for="sq">色情</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="ds" name="report_radio1" value="3">
                                        <label for="ds">低俗</label>

                                    </li>
                                    <li>
                                        <input type="radio" id="zp" name="report_radio1" value="4">
                                        <label for="zp">赌博诈骗</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="report_con_box">
                                <div class="reportList_title">侵犯个人权益</div>
                                <ul>
                                    <li>
                                        <input type="radio" id="gj" name="report_radio2" value="5">
                                        <label for="gj">人身攻击</label>

                                    </li>
                                    <li>
                                        <input type="radio" id="ys" name="report_radio2" value="6">
                                        <label for="ys">侵犯隐私</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="report_con_box">
                                <div class="reportList_title">有害网站环境</div>
                                <ul>
                                    <li>
                                        <input type="radio" id="gg" name="report_radio3" value="7">
                                        <label for="gg">垃圾广告</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="wg" name="report_radio3" value="8">
                                        <label for="wg">与视频无关</label>
                                    </li>
                                    <li>
                                        <input type="radio" id="sp" name="report_radio3" value="9">
                                        <label for="sp">刷屏</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="reportBox_btn">
                                <button class="reportBox_btn_cancel">取消</button>
                                <button class="reportBox_btn_sure">确定</button>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="answerWrapper" style="position: fixed;top: 0;background: rgba(0,0,0,0.3);width: 100%;height: 100%;z-index: 4001;display: none">
                    <div class="answerBox">
                        <div class="answerBox-top">
                            <div>第一节 量子十问·上</div>
                            <span class="answerClose"></span>
                        </div>
                        <div class="answered">
                            <div class="answered-top">
                                <img src="${base}/assets/images/EduImg/badge.png" alt="">
                                <div class="answered-top-text">恭喜你完成全部检测</div>
                                <div class="answered_score">+100积分</div>
                            </div>
                            <div class="answered-bottom">
                                <ul class="answered-share">
                                    <span>分享至:</span>
                                    <li class="answered-qq bdsharebuttonbox"><a data-id="3" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                    <li class="answered-weiChaat bdsharebuttonbox"><a data-id="3" href="javascript:void(0)" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></li>
                                    <li class="answered-weiBo bdsharebuttonbox"><a data-id="3" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina"></a></li>
                                    <li class="answered-kong bdsharebuttonbox"><a data-id="3" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                    <#--<li class="answered-peng bdsharebuttonbox"><a href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>-->

                                </ul>
                                <div class="answered-bottom-right">
                                    <span id="againDo" style="border-bottom: 1px solid #808080;cursor: pointer">再做一次</span>
                                    <button class="answerBtn">下一题</button>
                                </div>
                            </div>
                        </div>
                        <div class="answerBox-con">
                            <div class="questionName">Q<span id="QOrder" style="    color: #4c4c4c;"></span>:<span data-question="" id="question" style="color: #4c4c4c;">什么是量子？</span><span>(单选题)</span></div>
                            <div class="question-con">
                                <ul class="question-conUl">
                                </ul>
                            </div>
                            <div class="errorMessage">
                            </div>
                            <div class="answerBox-bottom" style="height: 40px;margin-bottom: 0;">
                                <ul id="orderBox" style="position: relative;float:left;">
                                    <li class="ansLine">1</li>
                                    <li class="ansLine">2</li>
                                    <li class="ansLine">3</li>
                                    <li>4</li>
                                </ul>

                                <div class="answerBoxLast" style="position: relative;float: right;">
                                    <div class="pop-up">
                                        <span class="pop-up-img"></span>
                                        <div class="pop-up-text">答对了，真棒！</div>
                                    </div>
                                    <button class="answerBtn">确定</button>
                                </div>

                            </div>
                            <div class="answered-bottom" style="margin-top: 20px;">
                                <ul class="answered-share">
                                    <span>分享至:</span>
                                    <li class="answered-qq bdsharebuttonbox"><a data-id="2" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                    <li class="answered-weiChaat bdsharebuttonbox"><a data-id="2" href="javascript:void(0)" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></li>
                                    <li class="answered-weiBo bdsharebuttonbox"><a data-id="2" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina"></a></li>
                                    <li class="answered-kong bdsharebuttonbox"><a data-id="2" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                    <#--<li class="answered-peng bdsharebuttonbox"><a href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>-->

                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </#escape>
</@main.body>
<@main.footer>
<#--edit start-->
    <script src="${base}/assets/js/jquery.nicescroll.min.js"></script>
    <script src="${base}/assets/js/md5.js"></script>
<#--微信分享-->
    <script src="${base}/assets/js/sha1.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
        var userInfoId='',pointNum="",pageNum="",infoText="";
        var replyIdCookie=0;
        var videoIdValue='';
        pointNum=getQueryString("point")
        pageNum=getQueryString("pagNum")
        infoText=getQueryString("info")
         <#if !USER_INFO??>
        userInfoId='';
         <#else >
        userInfoId=${USER_INFO.id!};
         </#if>
        var timestamp=parseInt(new Date().getTime()/1000);
        var shareDataTile="本源量子计算教育系列课程"
        if(infoText!=''&&infoText!=null&&infoText!=undefined){
            shareDataTile="本源量子计算教育系列课程__"+unescape(infoText)

        }else {shareDataTile="本源量子计算教育系列课程"}
        var shareData = {
            title:  shareDataTile,
            desc: "点击查看详情",
            imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
            otherImgUrl: '',
            text: '我正在学习，很不错哦！快来一起学习吧！',
            url:location.href.split('#')[0],
            link: shareLink+"/EDU/video.html?link=1_1",
            "success":function(){//分享成功后的回调函数
            },
            'cancel': function () {// 用户取消分享后执行的回调函数
                }
        }

        $.post("${base}/Wechat/ShareLearning.json",{},function (result) {
            data=result.obj;
            SignString ="jsapi_ticket="+data.ticket+"&noncestr="+data.noncestr+"&timestamp="+timestamp.toString()+"&url="+location.href.split('#')[0]
            s = new jsSHA(SignString.toString(),"TEXT");
            t = s.getHash("SHA-1", "HEX");
            var sha1Sign=t
            wx.config({
                debug: false,
                appId: data.appid,
                timestamp: timestamp,
                nonceStr: data.noncestr,
                signature: sha1Sign.toString(),
                jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            wx.ready(function() {
                wx.onMenuShareTimeline(shareData);
                wx.onMenuShareAppMessage(shareData);
                wx.onMenuShareQQ(shareData);
                wx.onMenuShareWeibo(shareData);

            });
        })
        function downloadVideo() {
            var url = $("#my_video_1_html5_api source").attr("src");
            window.open("${base}/EDU/downloadVideo.json?httpUrl="+url);
        }
    </script>
<#--百度分享-->
    <script>
        //全局变量
        var SharePage = "";
        //绑定所有分享按钮所在A标签的鼠标移入事件，从而获取动态ID
        $(function () {
            $(".bdsharebuttonbox a").mouseover(function () {
                SharePage = $(this).attr("data-id");// id==1为答题完成分享   id==2为答题中分享
            });
        });
        var share_block_text='',share_exam_text='',shareCon='';
        function setShareConfig(id,config){
            var blockShareId=parseInt($("#question").attr("data-question").substring(0,1))
            var examShareId=parseInt($("#question").attr("data-question").substring(4,1))

            if(isNaN(blockShareId)){
                blockShareId=videoIdValue.substring(0,1)
                examShareId=videoIdValue.substring(1)
            }
            share_block_text='',share_exam_text='',shareCon='';
            share_block_text =$(".index_menu_list.active").parents(".vjs_menu_list").siblings(".vjs_menu_name").find("h4").text();
            share_exam_text =$(".index_menu_list.active").find(".vjs_menu_vidName").text();
            share_exam_text=share_exam_text.substring(share_exam_text.indexOf(" ")+1)
            if(share_block_text==''||share_block_text==undefined){
                share_block_text=''
                share_exam_text =''
            }
            shareCon='本源量子计算教育系列课程__'+share_block_text+"__"+share_exam_text
            shareConWchat=escape(share_block_text+"__"+share_exam_text)
            config.bdText = shareCon;
            if(id=="tsina"){
                config.bdText = shareCon+"      "+ window.location.href;
                config.bdUrl=shareLink+"/EDU/video.html"
            }else if(id=="weixin"){
                if(SharePage=="1"){
                    config.bdUrl=shareLink+"/EDU/video.html?info="+shareConWchat
                }else if(SharePage=="2"){
                    config.bdUrl=shareLink+"/EDU/Share/Wechat/"+userInfoId+'?Sid='+blockShareId+examShareId+'&info='+shareConWchat
                }else if(SharePage=="3"){
                    config.bdUrl=shareLink+"/EDU/index.html?info="+shareConWchat
                }else {
                    config.bdUrl=shareLink+"/EDU/video.html?info="+shareConWchat
                }
            }else {
                config.bdText = shareCon
                config.bdUrl=shareLink+"/EDU/video.html";
            }
            shareVideoScore(blockShareId+examShareId)
            return config;
        }
        window._bd_share_config={
            common : {
                bdText : '本源量子计算教育系列课程',
                bdDesc : '本源量子计算教育系列课程，包含详细的量子计算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。',
                bdUrl : shareLink+"/EDU/video.html",
                bdPic : '',
                onBeforeClick:setShareConfig
            },
            "share":{
                share : [{
                    "tag" : "share_1",
                    "bdSize" : 16,
                    "bdCustomStyle":"background-image:none"
                }]
            }
        };

        //以下为js加载部分
        with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='${base}/assets/js/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
    </script>
<#--视频加载-->
    <script>

        //    获取评论
        function toLocation(size) {

            if(videoIdValue.substring(1)=="1"&&userInfoId==''){
                // userInfoId
            }else {
                <#if !USER_INFO??>
                viewLoginMin();
                return;
                </#if>
            }

            tutorialId = $(".index_menu_list.active").attr("data-id");
            $.post("${base}/EduTutorial/getReply.json",{forumTopicId:tutorialId,start:size*6},function (rusult) {
                var plHtml='';
                var reply=rusult.entityList;
                var PagePosition='';
                if(rusult.code=="401"){
                    reply=[]
                }
                reply.forEach(function (i,s) {
                    var replyOneName=''
                    if(reply[s].userface==undefined){
                        replyOneSrc="${base}/assets/images/wx_new1.jpg";
                    }else {
                        replyOneSrc="/${setting['files.contextpath']}"+reply[s].userface;
                    }
                    if( reply[s].username==undefined){
                        replyOneName=''
                    }else {
                        replyOneName=reply[s].username;
                    }
                    plHtml +='<div class="plListBox" id="reply'+reply[s].id+'"> <div class="tzComment-replier"> <div class="tzComment-replier-img"> ' +
                            '<img src="'+replyOneSrc+'" alt=""></div> ' +
                            '<div class="tzComment-replier-name">'+ replyOneName +'</div> </div> <div class="tzComment-Content"> ' +
                            '<div class="tzComment-Content-con">'+reply[s].content+'</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> ' +
                            '<div class="tz-reply-tiem"><span>'+reply[s].addtime+'</span></div> </div> <span class="tzCommenTid">'+reply[s].id+'</span> <input type="hidden" class="tzCommenPids" value="'+reply[s].pids+'"><input type="hidden" class="tzParentid" value="'+reply[s].parentid+'"><span class="tzCommenUserId">'+reply[s].userid+'</span><div class="tzComment-type-right">' ;
                    //                是否是本人
                    if(reply[s].delflag=="1"){ plHtml +='<a href="javascript:;" class="tzComment-delete">删除</a>'}

                    plHtml +='<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">回复</a> '
                    //                是否点赞
                    if(reply[s].likeflag>0){
                        plHtml +='<a href="javascript:;" class="zan  clicked"><span class="zanNum" style="background-position: -116px 0px;"></span><span class="zan_Num">'+reply[s].likecount+'</span></a>'
                    }else {
                        plHtml +='<a href="javascript:;" class="zan"><span class="zanNum"></span><span class="zan_Num">'+reply[s].likecount+'</span></a>'
                    }

                    plHtml +=' <a href="javascript:void(0);" class="pl-more" onclick="showReport(this)"></a>  <div class="tz-reply-report">举报</div> </div> </div><div class="reply-textarea"></div> <div class="reply-list-con">';
                <#--插入个人信息-->

                    //                是否是本人
                    // if(reply[s].delflag=="1"){plHtml +='<a href="javascript:;" class="tzComment-delete">删除</a>'}
                    // plHtml += '<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">评论</a>';

                    //                是否点赞
                    // if(reply[s].isapproval=='1'){
                    //     plHtml += '<a href="javascript:;" class="tzComment-zan active">赞</a></div></div><div class="reply-textarea"></div>';
                    // }else {
                    //     plHtml +=  '<a href="javascript:;" class="tzComment-zan">赞</a></div></div><div class="reply-textarea"></div>';
                    // }
                    //                是否有回复
                    if(reply[s].repduserid!=undefined||reply[s].repduserid!=null){
                        plHtml += '<div class="reply-list-con"> <div class="reply-pl-con"> <div class="reply-pl-title">引用 <a href="###">@ '+reply[s].repdusername+' </a> 的评论：</div> <div class="reply-pl-content">'+reply[s].repdcontent+'</div> </div><div class="replyList"></div></div>';
                    }

                     if(reply[s].pids.split(",").length>3){
                         plHtml +='<p class="more">引用'+(reply[s].pids.split(",").length-3)+'次评论 <a href="javascript:;">查看全部</a></p></div>';
                     }
                    plHtml += '</div></div> </div> ';
                });
                $(".tzCommentBox").html(plHtml);
                $(".numBox").text('('+rusult.totalRecords+'条评论)');
                $(".paginationNew").createPage({
                    result:rusult,
                    pageCount:rusult.totalPages,//总页数
                    current:rusult.pageNum,//当前页
                    turndown:'false',//是否显示跳转框，显示为true，不现实为false,一定记得加上引号...
                    backFn:function(p){
                    }
                })

            },"json")
        }
        // 视频di
        var video = document.getElementById("my_video_1_html5_api");
        var dataValue;
        var tutorialId;

        var resumePlayTime;
        var resumePlayTimeSet=null;
        var curTime ,videoTitle,currentTime;
        window.onload = function () {
            if (window.name == "hasLoad") {
                window.name = "";
            } else {
                window.name = "hasLoad";
            }

            var url = window.location.href;
            if(url.toString().indexOf("link") != -1 && url.toString().indexOf("isNext") != -1){
                $.ajax({
                    type:"POST",
                    url:"${base}/education/getvideoinfo.json",
                    data:{userid:userInfoId},
                    success:function (data) {
                        try {
                            var time = data.obj[0].progress
                            if(time){
                                var timeNum = time.split(":")
                                var currentTime = Number(timeNum[0])*3600+Number(timeNum[1])*60+Number(timeNum[2]);
                                $("#oldVideoTime").text(time)
                                $(".vjs_tip,.resumePlay_tips").addClass("active");
                                resumePlayTime = currentTime
                                resumePlayTimeSet=setTimeout(function () {
                                    viTipClose()
                                },30000)
                                // $('#my_video_1_html5_api')[0].currentTime = currentTime;
                            }
                        }catch (e) {}
                    }
                })
            }


        }
        // 获取视频要操作的元素
        window.onbeforeunload = function(){updataVideoInfo()}
        window.onunload = function(){updataVideoInfo()}

        // 章节目录加载


        videoData.forEach(function (value,index) {
            ishtml=''
            if(vidDetails[value.blockid]==undefined){
                return;
            }

            for(var i=0;i<vidDetails[value.blockid].length;i++){

                if(value.blockid==videoMenu_data&&i==videoIndex_data){
                    ishtml +='<li data-id='+value.blockid+(i+1)+'  class="index_menu_list active" data-value='+vidDetails[value.blockid][i].url+'><div class="vjs_menu_vidName"><a href="javascript:;">'+vidDetails[value.blockid][i].title+'</a></div></li>';
                }else {
                    ishtml +='<li data-id='+value.blockid+(i+1)+'  class="index_menu_list" data-value='+vidDetails[value.blockid][i].url+'><div class="vjs_menu_vidName"><a href="javascript:;">'+vidDetails[value.blockid][i].title+'</a></div></li>';
                }
            }
            if(value.blockid==videoMenu_data){
                vidHtml +='<div class="vjs_menu_details active"> <div class="vjs_menu_name"  data-list="'+value.blockid+'"> <h4>'+value.name+'</h4> <i class="vjs_menu_vjs"></i> </div> <div class="vjs_menu_list"> <ul>'+ishtml+'</ul> </div> </div>';
            }else {
                vidHtml +='<div class="vjs_menu_details" > <div class="vjs_menu_name"  data-list="'+value.blockid+'"> <h4>'+value.name+'</h4> <i class="vjs_menu_vjs"></i> </div> <div class="vjs_menu_list"> <ul>'+ishtml+'</ul> </div> </div>';
            }
        });
        function vidHtmls(link,img,name,time) {
            return '<li ontouch="videoPlay(this)" onclick="videoPlay(this)"><div class="vid_screenshot" data-value='+link+'><img src="'+img+'" alt=""></div><div class="vid_js"><span>'+name+'</span>' +
                '<span class="right">'+time+'</span></div><div class="vidHover"></div><div class="vidHoverImg"><img src="" alt=""></div></li>';
        }
        $("#vjs_menu").html(vidHtml)
        $(".index_menu_list.active").click()


        //视频点击切换//点击播放视频
        $("body").on("click",".index_menu_list",function (vaule,index) {
            // if($(this).hasClass("active")){
            //     return false;
            // }
            if(Number($(this).attr("data-id").substring(1))>1){
                 <#if !USER_INFO??>
                viewLoginMin();
                return;
                 </#if>
            }
            if(videoIdValue==''){
                videoIdValue=$(this).attr("data-id");
                videoTitle=$(this).children().text();
            }
            var curVideo = {
                userid:userInfoId,
                addscoreflag:false,
                progress:secondToDate($('#my_video_1_html5_api')[0].currentTime),
                title:videoTitle,
                id:videoIdValue
            }

            $('.toAnswer').hide();
            $("body").find(".video-js").addClass("vjs-playing")
            dataValue = $(this).attr("data-value");
            videoIdValue = $(this).attr("data-id");
            curTime = secondToDate($('#my_video_1_html5_api')[0].currentTime);
            videoTitle = $(this).children().text();
            var list = Number(videoIdValue.substring(0,1));
            if(isNaN(list)){
                list=0;
            }else {
                list=list-1
            }
            $('.n2_lb_js p').text(textBoxVideo[list])
            if(videoIdValue != '' && !isNaN(videoIdValue) ){
                var stateObject = {};
                var title = "";
                var newUrl = "${base}/EDU/video.html?link="+videoIdValue.substring(0,1)+"_"+videoIdValue.substring(1);
                setCookie("linkPath",videoIdValue.substring(0,1)+"_"+videoIdValue.substring(1));
                try{
                    history.pushState(stateObject,title,newUrl);
                    setCookie("linkPath",videoIdValue.substring(0,1)+"_"+videoIdValue.substring(1))
                }catch (e) {
                    if(getQueryString("link")!=getCookie("linkPath")){
                        window.location.href=newUrl
                    }
                }
            }
            if(videoIdValue){
                $.ajax({
                    type:"POST",
                    url:"${base}/education/updvideoinfo.json",
                    data:curVideo,
                    success:function (data) {
                        // console.log("更新接口上一个",data);
                    }
                });
            }
            $.ajax({
                type:"POST",
                url:"${base}/education/getvideoinfo.json",
                data:{userid:userInfoId},
                success:function (data) {
                    var curObj = data.obj;
                    curObj.forEach(function (ele,index) {
                        var curvid = ele.vid;
                        if(curvid == videoIdValue){
                            var time = ele.progress;
                            var timeNum = time.split(":");
                            var currentTime = Number(timeNum[0])*3600+Number(timeNum[1])*60+Number(timeNum[2]);
                            $("#oldVideoTime").text(time)
                            $(".vjs_tip,.resumePlay_tips").addClass("active");
                            resumePlayTime = currentTime;
                        }
                        resumePlayTimeSet=setTimeout(function () {viTipClose();},30000)
                    })
                }
            })

            //修改标题
            $(".video_n1_title h1").text($(this).find("a").text())
            $("#videoName").text($(this).find("a").text())
            $("#videoMenuName").html($(this).parents(".vjs_menu_list").siblings(".vjs_menu_name").text()+'<span> ></span>')
            $(".index_menu_list").removeClass("active");
            $(this).addClass("active")
            $(this).find("a").addClass("active");
            var pxBox = $("#ulPx").text();
            var d = new Date();
            var date=new Date(d.getFullYear()
                , d.getMonth()
                , d.getDate()
                , d.getHours()
                , d.getMinutes()
                , d.getSeconds())
            date.toUTCString();
            date=Math.floor(date.getTime()/ 1000);
            var encode=$.md5("originquantum/360p/"+dataValue+date)+"&qubit="+date;
            $("#pxBox li").each(function () {
                path="http://fast.qpanda.cn/360p/"+dataValue+"?video="+encode;
                if(pxBox ==="超清"){
                    path="http://video.qpanda.cn:65520/"+dataValue;
                }
                if(path.indexOf("QOeq0yzgt0IA") != -1){
                    path = "http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4";
                }
            })
            $('#my_video_1_html5_api').attr("src",path);
            $('#my_video_1_html5_api').attr("data-link",dataValue);
            $('#my_video_1_html5_api').find("source").attr("src",path);
            setTimeout(function () {
                $('#my_video_1_html5_api')[0].play();
            },1000)

            updReadCount($(this).attr("data-id"));
            if(pageNum!=''&&pageNum!=null){
                toLocation(pageNum-1)
            }else {
                toLocation(0);
            }
            $("#norSpeed").addClass("active").siblings().removeClass("active");
            $(".speed-box").text("1.0x");


            $.post(base+"/UpdateUserScore/saveVideoDetail.json",{"type":1,"vid":$(this).attr("data-id")},function () {
            })

        })
        var progressFlag;
        getTools()
        function getTools() {
            (function(window, document){
                // 获取要操作的元素
                var video = document.getElementById("my_video_1_html5_api");
                wx.config({
                    // 配置信息, 即使不正确也能使用 wx.ready
                    debug: false,
                    appId: '',
                    timestamp: 1,
                    nonceStr: '',
                    signature: '',
                    jsApiList: []
                });
                wx.ready(function() {
                    video.play();
                });
                var videoControls = document.getElementsByClassName("vjs-control-bar")[0];
                var videoContainer = document.getElementById("videoplayer");
                var controls = document.getElementById("video_controls");
                var playBtn = document.getElementsByClassName("vjs-play-control")[0];
                var fullScreenBtn = document.getElementsByClassName("vjs-fullscreen-control")[0];
                var progressWrap = document.getElementsByClassName("vjs-progress-control")[0];
                var playProgress = document.getElementsByClassName("vjs-play-progress")[0];
                // var showProgress = document.getElementsByClassName("vjs-play-progress")[0];
                var fullScreenFlag = false;

                // $("body").find("#box-close").on("click",function () {
                //     clearInterval(progressFlag)
                //     $("#videoplayer_overlay").remove()
                // })
                // 创建我们的操作对象，我们的所有操作都在这个对象上。
                var videoPlayer = {
                    init: function(){
                        var that = this;
                        video.removeAttribute("controls");
                        bindEvent(video, "loadeddata", videoPlayer.initControls);
                        videoPlayer.operateControls();
                        getProgress()
                    },
                    initControls: function(){
                        // video.play();
                        videoPlayer.showHideControls();
                        progressFlag = setInterval(getProgress, 60);
                    },
                    showHideControls: function(){
                        bindEvent(video, "mouseover", showControls);
                        bindEvent(videoControls, "mouseover", showControls);
                        bindEvent(video, "mouseout", hideControls);
                        bindEvent(videoControls, "mouseout", hideControls);
                    },
                    operateControls: function(){
                        bindEvent(playBtn, "click", play);
                        bindEvent(video, "click", play);
                        bindEvent(fullScreenBtn, "click", clickFullScreen);
                        bindEvent(progressWrap, "mousedown", videoSeek);
                    }
                }
                videoPlayer.init();
                // 原生的JavaScript事件绑定函数
                function bindEvent(ele, eventName, func){
                    if(window.addEventListener){
                        ele.addEventListener(eventName, func);
                    }
                    else{
                        ele.attachEvent('on' + eventName, func);
                    }
                }
                // 显示video的控制面板
                function showControls(){
                    $(".video-js").addClass("vjs-user-active");
                    $(".video-js").removeClass("vjs-user-inactive");
                }
                // 隐藏video的控制面板
                function hideControls(){
                    // 为了让控制面板一直出现，我把videoControls.style.opacity的值改为1
                    $(".video-js").removeClass("vjs-user-active");
                    $(".video-js").addClass("vjs-user-inactive");
                }
                // 控制video的播放
                function play(){
                    clearInterval(progressFlag);

                    if ( video.paused || video.ended ){
                        if(userInfoId==''&&videoIdValue.substring(1)!="1"){
                            return false;
                        }
                        $("body").find(".video-js").removeClass("startShowControl")
                        if ( video.ended ){video.currentTime = 0;}
                        video.play();
                        $(this).addClass("vjs-playing")
                        $("body").find(".video-js").addClass("vjs-playing")
                        $(this).removeClass("vjs-paused")
                        $("body").find(".vjs-play-control").removeClass("vjs-paused")
                        $("body").find(".vjs-play-control").addClass("vjs-playing")
                        $("body").find("#my_video_1_html5_api").paused = false;
                        $("body").find("#my_video_1_html5_api").get(0).play();
                        progressFlag = setInterval(getProgress, 60);
                        if(!isNaN(parseInt($(".speed-box").text()))){
                            $('#my_video_1_html5_api')[0].playbackRate=parseInt($(".speed-box").text());
                        }
                    }
                    else{
                        video.pause();
                        $("body").find(".video-js").addClass("startShowControl")
                        $(this).removeClass("vjs-playing")
                        $("body").find(".video-js").removeClass("vjs-playing")
                        $(this).addClass("vjs-paused");
                        $("body").find(".vjs-play-control").addClass("vjs-paused")
                        $("body").find(".vjs-play-control").removeClass("vjs-playing")
                        $("body").find("#my_video_1_html5_api").paused = true;
                        $("body").find("#my_video_1_html5_api").get(0).pause()
                        clearInterval(progressFlag);
                    }
                }
                // 控制video是否全屏
                function clickFullScreen(){
                    $(this).parents('#my_video_1').fullScreen();


                    if ( video.paused&&$(".vjs-play-control").hasClass("vjs-paused") || video.ended&&$(".vjs-play-control").hasClass("vjs-paused")){

                        $(".vjs-play-control").removeClass("vjs-playing");
                        $(".vjs-play-control").addClass("vjs-paused");
                        flagTime=1
                    }else {
                        $(".vjs-play-control").addClass("vjs-playing");
                        $(".vjs-play-control").removeClass("vjs-paused");
                        flagTime=0
                    }
                    var w=null;
                    clearTimeout(w)
                    if(!flagTime){
                        w=setTimeout(function () {
                            $(".vjs-play-control").addClass("vjs-playing");
                            $(".vjs-play-control").removeClass("vjs-paused");
                            $("body").find("#my_video_1_html5_api").get(0).play()

                        },300)
                    }
                }
                // video的播放条
                function getProgress(){

                    var percent = video.currentTime / video.duration;
                    playProgress.style.width = (percent * (progressWrap.offsetWidth)-2)+"px";
                    var min=parseInt(video.duration/60)
                    var seconds=parseInt(video.duration%60)
                    if(seconds>=10){
                        seconds=parseInt(video.duration%60)
                    }else {
                        seconds='0'+parseInt(video.duration%60)
                    }

                    var PlayMin=parseInt(video.currentTime/60);
                    var PlaySeconds=(video.currentTime%60).toFixed(0)
                    if(PlaySeconds>=10){
                        PlaySeconds=(video.currentTime%60).toFixed(0)
                    }else {
                        PlaySeconds='0'+(video.currentTime%60).toFixed(0)
                    }
                    var PlayTime=PlayMin+":"+PlaySeconds;
                    var time=min+":"+seconds;
                    if(isNaN(min)||isNaN(seconds)){
                        time="00:00"
                    }
                    $("#timesID").html(PlayTime+ " <span>/ "+time+"<span>");
                    if(PlaySeconds>0){
                        $("body").find(".vjs-play-control").removeClass("vjs-paused")
                        $("body").find(".vjs-play-control").addClass("vjs-playing")
                    }

                }
                // 鼠标在播放条上点击时进行捕获并进行处理
                function videoSeek(e){
                    if(userInfoId==''&&videoIdValue.substring(1)!="1"){
                        return false;
                    }
                    if(video.paused || video.ended){
                        play();
                        enhanceVideoSeek(e);
                    }
                    else{
                        enhanceVideoSeek(e);
                    }
                };
                //定位时间
                function enhanceVideoSeek(e){
                    var percent=0;
                    var length=0;
                    clearInterval(progressFlag);
                    length = e.pageX -document.getElementsByClassName("videoBox")[0].offsetLeft;

                    if(document.fullscreen || document.mozFullScreen || document.webkitIsFullScreen || document.msFullscreenElement){
                        length=length +document.getElementsByClassName("videoBox")[0].offsetLeft;
                        percent = length / progressWrap.offsetWidth;
                    }else {
                        percent = length / progressWrap.offsetWidth;
                    }
                    playProgress.style.width = percent * (progressWrap.offsetWidth)  + "px";
                    video.currentTime = percent * video.duration;
                    progressFlag = setInterval(getProgress, 60);

                };
            }(this, document));

        }

        // 获取视频讲义及题目信息
        function updReadCount(videoId) {
            $.post("${base}/EduTutorial/updReadCount.json",{"videoId":videoId},
                function(result) {
                    if(result) {
                        if(result.lectureurl==null||result.lectureurl==undefined||result.lectureurl==''){
                            $("#readCount").html(result.view);
                            $("#lectureUrl").attr("href","javascript:void(0)");
                            $("#lectureUrl").attr("data-flag","1");
                        }else {
                            $("#readCount").html(result.view);
                            $("#lectureUrl").attr("href","${base}"+result.lectureurl);
                            $("#lectureUrl").attr("target","_Blank");
                            $("#lectureUrl").attr("data-flag","0");
                        }
                    }

                })
        }
        $(".index_menu_list.active").click();
    </script>

    <!--textarea高度自适应-->
    <script type="text/javascript">
        //    点赞
        var count = 0
        tutorialId = $(".index_menu_list.active").attr("data-id");
        $('.tzCommentBox').on('click', '.zan', function () {
            var isLike=0;
            var oHid = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
            if ($(this).hasClass('clicked')){

                $(this).removeClass('clicked')
                $(this).find('.zanNum').css('background-position','-130px 0');
                $(this).find('.zan_Num').text( Number($(this).find('.zan_Num').text())-1);
                isLike=-1
                count--;
            } else {
                $.tipsBox({
                    obj: $(this),
                    str: "+1",
                    callback: function () {}
                });
                $(this).addClass('clicked')
                $(this).find('.zanNum').css('background-position','-116px 0');
                $(this).find('.zan_Num').text( Number($(this).find('.zan_Num').text())+1);
                isLike=1
                count++;
            }
            $.post("${base}/EduTutorial/videoReplyLike.json", {
                replyId: oHid,
                type:isLike
            }, function (result) {})
            // }
            // var id = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
            // var Uid = $(this).parents('.tzComment-type-right').siblings('.tzCommenUserId').html();
            // var zNum = $(this).find('.z-num').html();
        })
        // 学习页面章节展开
        var flag = true;
        //举报遮罩层
        $('.reportClose,.reportBox_btn_cancel').on('click',function () {
            $(".report_con input").each(function (event,index) {
                $(this).attr('checked',false);
                $(this).prop('checked',false);
            })
            $('.reportBoxTop').hide();
        })

        //    提交举报信息
        $('.reportBox_btn_sure').on('click',function () {
            var checkedList=[]
            $(".report_con input").each(function (event,index) {
                if($(this)[0].checked){
                    checkedList.push($(this).val())
                }
            })
            var reportId=checkedList.join(',')
            var oHid = replyIdCookie;
            if(reportId==''||reportId==null||checkedList.length==0){
                layer.msg("请选择类型后点击确定提交");
                return;
            }
            $.post("${base}/EduTutorial/reportTopicReply.json",{
                topicId:tutorialId,
                replyId:oHid,
                reportType:reportId,
                type:2,
                reportContent:''
            },function (result) {
                if(result.success){
                    layer.msg("提交成功",{time: 2000},function () {
                        $('.reportBoxTop').hide();
                        $(".report_con input").each(function (event,index) {
                            $(this).attr('checked',false);
                            $(this).prop('checked',false);
                        })
                    })
                }else {
                    layer.msg("提交失败")
                }

            })
        })

        $('.tzCommentBox').on('click', '.tz-reply-report', function () {
            $(this).hide();
            replyIdCookie=$(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html()
            $('.reportBoxTop').show();
        })

        //    删除评论
        $('.tzCommentBox').on('click', '.tzComment-delete', function () {
            var oThis = $(this);

            var oHid = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
            //var repdUserId =
            layer.confirm('确定删除该条回复吗？', {
                title:false,
                btn: ['确定','取消'] //按钮
            }, function(index){
                layer.close(index)
                $.post("${base}/EduTutorial/deleteReply.json", {
                    id: oHid
                }, function (result) {
                    oThis.parents('.tzComment-type-right').parents('.tzComment-Content-type').parents('.tzComment-Content').parents('.plListBox').remove();
                    layer.msg("删除成功")
                })
            }, function(){

            });

        });

        // 更多，举报
        function showReport(evt){
            //$('.tz-reply-report').toggle()
            $(evt).siblings('.tz-reply-report').toggle();
        }

        $(function () {
            $('#contentbox').flexText();
        });

        //textarea限制字数
        function keyUP(t) {
            var len = $(t).val().length;
            $('.wNum').text(len+'/140');
            if (len > 140) {
                $(t).val($(t).val().substring(0, 140));
                layer.msg("更多精彩评论，请前往本源官方论坛")
            }
        }

        dataValue=$(".index_menu_list.active").attr("data-value");

        $("textarea[name='report']").on("keyup",function () {
            $(".textMumber span").html(200-$(this).val().length)
        });

        var reportId='',topicId='',replyId='';
        var reportN=0;
        function ReportBtn(obj) {
            reportN=obj;
            replyId=$(obj).parents(".tz-reply-report").parents(".tzComment-type-left").siblings(".tzCommenTid").html();
            $('#myprport').modal('show');
            $("input[name='report']").html("");
        }
        $(".dialogDetails ").on("click",function () {
            $(".dialogDetails .diaLine a").removeClass("active");
            $(this).find(".diaLine a").addClass("active");
        });


        $('.tzCommentBox').on('click', '.reply-list-con .more a', function () {
            var replyPid=$(this).parents(".more").parents(".reply-list-con").siblings(".tzComment-Content-type").find(".tzCommenPids").val();
            var replyParentid=$(this).parents(".more").parents(".reply-list-con").siblings(".tzComment-Content-type").find(".tzParentid").val();
            var replyHtml='';
            var $this=$(this);
            if($(this).text()=="查看全部"){
                $(this).text("收起回复");
                $(this).parents(".more").siblings(".replyList").show();
            }else if($(this).text()=="收起回复" ){
                $(this).text("查看全部");
                $(this).parents(".more").siblings(".replyList").hide();
            }
            if($this.parents(".more").siblings(".replyList").html()!=''){
                return false;
            }

            $.post("${base}/EduTutorial/getParentReply.json",{pIds:replyPid,pId:replyParentid},function (result) {
                var replyList=result.entityList;
                replyHtml +='<div><ul>' ;
                replyList.forEach(function (i,s) {
                    replyHtml +='<li class="item"><span class="num">'+(result.entityList.length-s)+'</span><div class="replyListLine"><a href="javascript:;"><span>'+result.entityList[s].username+'</span>: </a><span class="replyLineContent">'+result.entityList[s].content+'</span> </div> <p class="replytime">'+result.entityList[s].addtime+'</p></li>';
                });
                replyHtml +='</ul></div>';
                $this.parents(".more").siblings(".replyList").html(replyHtml)
            },"json")

        });
        $(".tz-close").click(function () {
            $('#myprport').modal('hide');
        })
    </script>
    <!--点击评论创建评论条-->
    <script type="text/javascript">
        $('.tzCommentReplyBox').on('click', '.plBtn', function () {
            var len = $('.comment-input').val().length;
            if(len<=5){
                layer.msg('请输入5个字以上的评论');
                return false;
            }
            var myDate = new Date();
            curTime = myDate.getTime();
            //获取当前年
            var year = myDate.getFullYear();
            //获取当前月
            var month = myDate.getMonth() + 1;
            //获取当前日
            var date = myDate.getDate();
            var h = myDate.getHours();       //获取当前小时数(0-23)
            var m = myDate.getMinutes();     //获取当前分钟数(0-59)
            if (m < 10) m = '0' + m;
            var s = myDate.getSeconds();
            if (s < 10) s = '0' + s;
            var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
            //获取输入内容
            var oSize = $("#contentbox").val();
            // var oSize = $(this).siblings().find('.comment-input').val();
            oSize =$('<span/>').text( oSize ).html();
            <#if !USER_INFO??>
            viewLoginMin();
            return;
            </#if>
            //动态创建评论模块
            $.ajaxSettings.async = false;

            $.post("${base}/EduTutorial/addEduTutorialReply.json", {
                forumTopicId:tutorialId,
                parentId: 0,
                pIds: '',
                content: oSize
            }, function (result) {
                if(result.success) {
                    layer.msg("发表成功");
                    toLocation(0)
                }

            });
            $.ajaxSettings.async = true;
            oHtml = '<div class="tzComment-show-con clearfix"> ' +
                '<div class="plListBox"> ' +
                '<div class="tzComment-replier"> ' +
                '<div class="tzComment-replier-img"> ';
                <#if (USER_INFO.face)?exists>
                    oHtml += '<img src="/${setting['files.contextpath']}${USER_INFO.face}" alt=""> ';
                <#else>
                    oHtml += '<img src="${base}/assets/images/wx_new1.jpg" alt="">';
                </#if>
                oHtml += '</div><div class="tzComment-replier-name">${USER_INFO.name!} </div></div> '+
                    '<div class="tzComment-Content"> <div class="tzComment-Content-con">'+ oSize +'</div>'+
                    '<div class="tzComment-Content-type">'+
                    '<div class="tzComment-type-left">'+
                    '<div class="tz-reply-tiem"><span>'+ '1分钟前' +'</span></div></div>'+
                    '<div class="tzComment-type-right">'+
                    '<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">回复</a></div></div>'+
                    '<div class="tz-reply-report">举报</div><div class="reply-textarea"></div><div class="reply-list-con"></div></div></div></div>';
            <#--oHtml= '<div class="tzComment-show-con clearfix"> <div class="tzComment-replier"> <div class="tzComment-replier-img"> <img src="/p/assets/forImg/3.jpg" alt=""> </div> <div class="tzComment-replier-name">${USER_INFO.name!} </div> <div class="tzComment-replier-lc">8楼</div> </div> <div class="tzComment-Content"> <div class="tzComment-Content-con">' + oSize + '</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> <div class="tz-reply-tiem"><span>'+now+'</span></div> <div class="tz-reply-report"><a href="javascript:;">举报</a></div> </div> <div class="tzComment-type-right"> <a href="javascript:;" class="tzComment-delete">删除</a> <a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">评论</a> <a href="javascript:;" class="tzComment-zan">赞</a> </div> </div> <div class="reply-textarea"></div> <div class="reply-list-con">  </div> </div> </div>';-->
            // plListArr.push(oHtml);
            if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {
                // $(this).parents('.reviewArea ').parents('.tzCommentReplyBox ').siblings('.tzCommentBox').prepend(oHtml);
                $(this).siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');
            }


            $.post(base+"/UpdateUserScore/saveVideoDetail.json",{"type":3,"vid":tutorialId},function () {
            })


        });
        //    帖子评论的回复，创建回复块

        $('.tzCommentBox').on('click', '.pl-hf', function () {
            <#if !USER_INFO??>
            viewLoginMin();
            return;
            </#if>
            //获取回复人的名字
            var fhName = $(this).parents(".tzComment-type-right").parents(".tzComment-Content-type").parents(".tzComment-Content").siblings(".tzComment-replier").find(".tzComment-replier-name").html();
            //回复@
            var fhN = '回复&nbsp;'+'&nbsp;&nbsp;' + fhName;
            //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
            var fhHtml = '<div class="hf-con pull-left"><div class="tzComment-replier-img">';
            <#if (USER_INFO.face)?exists>
                fhHtml += '<img src="/${setting['files.contextpath']}${USER_INFO.face}" alt="">';
            <#else>
                fhHtml += '<img src="${base}/assets/images/wx_new1.jpg" alt="">';
            </#if>
            fhHtml += '</div><textarea class="comment-input hf-input" placeholder="' + fhN + '" onkeyup="keyUP(this)"></textarea> <div class="wordsNum2"><span class="wNum">0/140</span></div> <a href="javascript:;" class="hf-pl" id="hf-plBtn">评论</a>';
            //显示回复
            if ($(this).is('.hf-con-block')) {
                $(this).parents('.tzComment-type-right').parents('.tzComment-Content-type').siblings(".reply-textarea").html(fhHtml);
                $(this).removeClass('hf-con-block');
                $('#contentbox').flexText();
                $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding', '6px 15px');
                //input框自动聚焦
                $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus();
            } else {
                $(this).addClass('hf-con-block');
                $(this).parents('.tzComment-type-right').parents('.tzComment-Content-type').siblings(".reply-textarea").html("");
            }

        });

        //    取消输入框
        $(".tzCommentBox").on("click",".hf-pl-close",function () {
            $(this).parent().parent(".reply-textarea").siblings(".tzComment-Content-type").children(".tzComment-type-right").find(".tzComment-replybtn").addClass('hf-con-block');
            $(this).parent().parent(".reply-textarea").html("");
        });

        //    评论回复
        $('.tzCommentBox').on('click', '.hf-pl', function () {
            <#if !USER_INFO??>
            viewLoginMin();
            return;
            </#if>
            if($(this).siblings('.hf-input').val().length<=5){
                layer.msg('请输入5个字以上的评论');
                return false;
            }
            var oThis = $(this);
            var myDate = new Date();
            //获取当前年
            var year = myDate.getFullYear();
            //获取当前月
            var month = myDate.getMonth() + 1;
            //获取当前日
            var date = myDate.getDate();
            var h = myDate.getHours();       //获取当前小时数(0-23)
            var m = myDate.getMinutes();     //获取当前分钟数(0-59)
            if (m < 10) m = '0' + m;
            var s = myDate.getSeconds();
            if (s < 10) s = '0' + s;
            var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
            //获取输入内容
            var oHfVal = $(this).siblings('.hf-input').val();
            oHfVal =$('<span/>').text( oHfVal ).html();
            var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();

            var oHid = $(this).parents('.hf-con').parents('.reply-textarea').siblings('.tzComment-Content-type').find('.tzCommenTid').html();
            var pIds = $(this).parents('.hf-con').parents('.reply-textarea').siblings('.tzComment-Content-type').find('.tzCommenPids').val();
            var repdUserId = $(this).parents('.hf-con').parents('.reply-textarea').siblings('.tzComment-Content-type').find('.tzCommenUserId').html();
            var oAllVal = '回复@' + oHfName;
            var oldContent=oThis.parents('.hf-con').parents('.reply-textarea').parents('.tzComment-Content').find(".tzComment-Content-con").html();
            var oldName=oThis.parents('.hf-con').parents('.reply-textarea').parents('.tzComment-Content').siblings(".tzComment-replier").find(".tzComment-replier-name").html();
            $.post("${base}/EduTutorial/addEduTutorialReply.json", {
                forumTopicId:tutorialId,
                repdUserId: repdUserId,
                parentId: oHid,
                pIds: pIds,
                content: oHfVal
            }, function (result) {
                layer.msg("发表成功");
                toLocation(0)
            });
            oHtml= '<div class="tzComment-show-con clearfix">' + '<div class="plListBox"><div class="tzComment-replier"> <div class="tzComment-replier-img">';
                <#if (USER_INFO.face)?exists>
                    oHtml += '<img src="/${setting['files.contextpath']}${USER_INFO.face}" alt="">';
                <#else>
                    oHtml += '< img src="${base}/assets/images/wx_new1.jpg" alt="">';
                </#if>
            oHtml += '</div> <div class="tzComment-replier-name">${USER_INFO.name!} </div></div> <div class="tzComment-Content">'+
                    '<div class="tzComment-Content-con">' + oHfVal + '</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left">' +
                    +' <div class="tz-reply-tiem"><span>'+ '1分钟前'+'</span></div> </div> ' +
               + '</div><div class="reply-textarea"></div> <div class="reply-list-con"> <div class="reply-pl-con"> ' +
                  +  '<div class="reply-pl-title">引用 <a href="###">@'+ oldName+'</a> 的评论：</div> <div class="reply-pl-content">'+ oldContent +'</div>' +
                   + ' </div> </div> </div></div> </div>';

            <#--oHtml= '<div class="tzComment-show-con clearfix">' + '<div class="plListBox"><div class="tzComment-replier"> <div class="tzComment-replier-img"> <img src="/p/assets/forImg/3.jpg" alt=""> </div> <div class="tzComment-replier-name">${USER_INFO.name!} </div></div> <div class="tzComment-Content"> <div class="tzComment-Content-con">' + oHfVal + '</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> <div class="tz-reply-tiem"><span>'+ '1分钟前'+'</span></div> </div> ' +-->
            <#--'<div class="tzComment-type-right"><a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">回复</a> <a href="javascript:;" class="zan" onclick="zanClick()"><span class="zanNum"></span>1</a><a href="javascript:void(0);" class="pl-more"></a></div> </div><div class="reply-textarea"></div> <div class="reply-list-con"> <div class="reply-pl-con"> <div class="reply-pl-title">引用 <a href="###">@'+ oldName+'</a> 的评论：</div> <div class="reply-pl-content">'+ oldContent +'</div> </div> </div> </div></div> </div>';-->
            oThis.parents('.hf-con').parents('.reply-textarea').parents('.tzComment-Content').parents(".plListBox").parents(".tzCommentBox").prepend(oHtml) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
        });

        // <a href="javascript:;" class="tzComment-delete">删除</a>
        //    删除评论
    </script>
    <!--点击回复动态创建回复块-->
<#--滚动条滑动-->
    <script>
        setTimeout(function(){if(pointNum!=''&&pointNum!=null){$('html, body').animate({scrollTop:$("#reply"+pointNum).offset().top-10}, 400);}},500)
    </script>
    <script src="${base}/assets/js/main/QVideo.js"></script>
    <script src="${base}/assets/js/main/AnswerCtrl.js"></script>
<#--其他-->
    <script>
        //判断是否刷新
        isReload=false;
        //视频结束
        $('#my_video_1_html5_api').on('ended',function () {
            updataVideoInfo(1);
            noQuesTion()
        })
    </script>
<#--音量调节-->
    <script>
        $("#scrollBar").mousedown(function (e) {
            e.stopPropagation();
            var start = e.pageY;
            var orginPostion = $("#scrollBar").css("bottom");
            var tipTime= null;
            $(document).mousemove(function(event) {
                var end = event.pageY;
                var move = end - start;
                var currPostion = parseFloat(orginPostion) + (start - end)+11;
                var currHeight = parseFloat($("#progress-con").css("height"))
                leftNum = parseFloat(currPostion/currHeight);
                if (currPostion <= 0) {
                    $("#scrollBar").css("bottom", "-11px")
                }else {
                    clearTimeout(tipTime)
                    if (currPostion >= parseFloat($("#progress-con").css("height"))) {
                        $('#my_video_1_html5_api')[0].volume=1
                        $(".sound-index").css({"height":"100%"})
                        $("#scrollBar").css("bottom", (parseFloat($("#warp").css("height")) - parseFloat($("#scrollBar").css("height")))-11 + "px");
                        tipsClear()
                    } else {

                        volumeFlag = (currPostion-11)/parseFloat($("#progress-con").css("height"))+0.1
                        volumeFlag2 = (currPostion-11)/parseFloat($("#progress-con").css("height"))
                        if(volumeFlag>0&&volumeFlag<=1){
                            volumeFlag=volumeFlag.toFixed("1")
                            $(".vjs-sound-icon span").removeClass("volume0")
                        }else if(volumeFlag<0){
                            volumeFlag=0;
                            $(".vjs-sound-icon span").addClass("volume0")
                        }else if(volumeFlag2<=-0.1){
                            volumeFlag=0;
                            $(".vjs-sound-icon span").addClass("volume0")
                        }

                        $(".second_tips").find("span").text((volumeFlag*100).toFixed(0))
                        $(".vjs_tip").addClass("active")
                        $(".second_tips").addClass("active")
                        $('#my_video_1_html5_api')[0].volume=volumeFlag;
                        tipsClear()
                        $(".sound-index").css({"height":((currPostion)/parseFloat($("#progress-con").css("height"))*100).toFixed(2)+"%"})
                        $("#scrollBar").css("bottom", currPostion-11 + "px");
                    }
                }
            });

            function tipsClear(){
                tipTime=setTimeout(function () {
                    $(".vjs_tip").removeClass("active")
                    $(".vjs_tip").children().removeClass("active")
                },2000)
            }



            $(document).mouseup(function(event) {$(document).off("mousemove")})
        });
        var start ,orginPostion;
        var box = document.getElementById("scrollBar");
        box.addEventListener("touchstart",function(event){
            var touch ;
            if(event.touches){touch = event.touches[0];}else {touch = event;}
            event.stopPropagation();
            start = touch.pageX;
            orginPostion = $("#scrollBar").css("left");
            box.addEventListener("touchmove",function(event){
                var touch ;
                if(event.touches){touch = event.touches[0];}else {touch = event;}
                var end = touch.pageX;
                var move = end - start;
                var currPostion = parseFloat(orginPostion) + (end - start);
                var currWidth = parseFloat($("#progress-con").css("width")) - parseFloat($("#scrollBar").css("width"));
                leftNum = parseFloat(currPostion/currWidth);
                if (currPostion <= 0) {
                    $("#scrollBar").css("left", "0px");
                    $("#box").css("left" , "0");
                }else {
                    if (currPostion + parseFloat($("#scrollBar").css("width")) >= parseFloat($("#progress-con").css("width"))) {
                        $("#box").css("left" , widthPost+"px");
                        $("#scrollBar").css("left", (parseFloat($("#warp").css("width")) - parseFloat($("#scrollBar").css("width"))) + "px");
                    } else {
                        $("#scrollBar").css("left", currPostion + "px");
                        $("#box").css("left" , (leftNum*widthPost)+"px");
                    }
                }
            },false)
            box.addEventListener("touchend",function(){$(document).off("touchmove");},false);
        },false)
    </script>
</@main.footer>