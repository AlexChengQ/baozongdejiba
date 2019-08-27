<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader title="视频">
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
</@main.mHeader>
<@main.body >
    <#escape x as x?html>
    <meta itemprop="name" content="本源量子"/>
    <meta itemprop="image" content="http://imgcache.qq.com/qqshow/ac/v4/global/logo.png" />
    <meta name="description" itemprop="description" content="这是要分享的内容" />
    <div onbeforeunload="return updataVideoInfo()" class="contentBox" style="padding: 0;">
        <link rel="stylesheet" href="${base}/assets/css/community.css">
        <link rel="stylesheet" href="${base}/assets/mobile/css/video.css">
        <!--top-->
        <div class="content">
            <@main.mobileTop>
                <#escape x as x?html></#escape>
            </@main.mobileTop>
            <div class="bannerOrSwiper">
                <div id="videoContent">
                    <div class="videoBox">
                        <style>

                            .tzCommHead_left{
                                height: 1.68rem;
                                display: flex;

                            }
                            .tzCommentReplyBox{
                                border-top: 1px solid #e6e6e6;
                                margin: 0!important;
                                padding-top: 0.373333rem!important;
                            }
                            .flex-text-wrap{
                                padding: 0!important;
                            }
                            .flex-text-wrap textarea{
                                font-size: 0.32rem!important;
                                color: #ccc!important;
                                border-radius: 4px!important;
                                height: 3.2rem!important;
                                padding: 5px 10px!important;
                            }
                            .tzCommentReplyBox .reviewArea{
                                position: relative;
                                padding-bottom: 0.373333rem;
                            }
                            .wordsNum{
                                position: absolute;
                                top: 2.6666667rem;
                                right: 8px;
                            }
                            .thread-reply{
                                width: 100% !important;
                            }
                            .tzCommentReplyBox .reviewArea a{
                                margin-top: 0.32rem;
                                width: 2.1333rem;
                                font-size: 0.32rem;
                                height:0.746667rem;
                                line-height:0.746667rem;
                                border-radius: 4px;
                            }
                            .comments-title{
                                padding: 0 0.32rem;
                                height: 1.68rem;
                                line-height: 1.68rem;
                                border-bottom: 1px solid #e6e6e6;
                            }
                            .plTitle{
                                float: left;
                                color: #1a1a1a;
                                font-size: 0.4266667rem;
                            }
                            .sortTitle{
                                float: right;
                            }
                            .sortTitleName{
                                float: left;
                                color: #1a1a1a;
                                font-size: 0.373333rem;
                            }
                            .sortList{
                                font-size: 0.373333rem;
                                float: left;
                                color: #4688f1;
                            }
                            .tzCommenTid, .tzCommenUserId {
                                display: none;
                            }

                            .tz-reply-report {
                                padding: 0px 7px;
                                background-color: #fff;
                                border-radius: 5px;
                                border: 1px solid #ccc;
                                color: #808080;
                                display: none;
                                cursor: pointer;
                                position: absolute;
                                right: 0;
                                bottom: 18px;
                                z-index: 4;
                            }
                            .plListBox{
                                border-bottom: 1px solid #e6e6e6;
                                padding: 0.373333rem 0.32rem 0.28rem;

                            }
                            .tzComment-replier{
                                height: 0.8533333rem;
                                margin-bottom: 0.32rem;
                            }
                            .tzComment-replier-img{
                                height: 0.8533333rem;
                                width: 0.8533333rem;
                                margin-right: 0.4rem;
                            }
                            .tzComment-replier-name{
                                line-height: 0.8533333rem;
                            }
                            .tzComment-Content-con{
                                line-height: 0.48rem;
                                font-size: 0.373333rem;
                            }
                            .tzComment-Content-type{
                                margin: 0.16rem 0;
                                height: 0.64rem;
                                line-height: 0.64rem;
                            }
                            .pl-more {
                                background-image: url(../../../assets/images/EduImg/eduSprite.png);
                                height: 12px;
                                width: 12px;
                                top: 2px;
                                background-position: -89px 0;
                            }
                            .tzComment-type-right{
                                position: relative;
                            }
                            .tzComment-type-right a {
                                display: inline-block;
                                position: static;
                                padding: 0px !important;
                                margin-left: 20px;
                            }
                            .pl-hf {
                                font-size: 12px;
                                color: #808080!important;
                                background: none!important;
                            }
                            .reply-textarea textarea{
                                margin: 0;
                                /* position: absolute!important; */
                                /* border: 1px solid #808080; */
                                top: 0;
                                right: 0;
                                /* width: 100%; */
                                border: 0;
                                padding: 0;
                            }
                            .reply-textarea .hf-con{
                                position: relative;
                                background: #fff;
                            }
                            .reply-textarea{

                                overflow: hidden;
                                width: 100%;
                                height: 100%;
                            }
                            .hf-con.pull-left{
                                padding-left: 1.28rem;
                                position: relative;
                                width: auto;
                                float: none!important;
                            }
                            .hf-con.pull-left .tzComment-replier-img{
                                position: absolute;
                                left: 0;
                                right: 0;
                            }
                            .textArea-hf{
                                /*width: 98%;*/
                                position: relative;
                                border: 1px solid #808080;
                                padding: 0.16rem;
                                border-radius: 4px;
                            }
                            .wordsNum2{
                                position: absolute;
                                bottom: 0px;
                                right: 4px;
                                font-size: 0.32rem;
                                color: #808080;
                            }
                            .hf-con.pull-left #hf-plBtn{
                                width: 1.68rem;
                                height: 0.64rem;
                                line-height: 0.64rem;
                                font-size: 0.32rem;
                                color: #fff;
                                background-color: #4688f1;
                                margin: 0.32rem 0;
                            }
                            .EDU_reportBox{
                                width:90%;
                                background-color: #fff;
                                z-index: 4002;
                                border-radius: 5px;
                                margin: 50px auto;
                            }
                            .reportTitle{
                                position: relative;
                                border-bottom: 1px solid #ccc;
                            }
                            .reportTitle>div{
                                font-size: 18px;
                                text-align: center;
                                /*color: #4c4c4c;*/
                                width: 100%;
                                padding: 25px 0;
                                display: inline-block;
                                font-weight: bold;
                            }
                            .reportClose{
                                display: inline-block;
                                background-image: url("../../../assets/images/EduImg/eduSprite.png");
                                height:14px;
                                width:14px;
                                background-position: -74px 0;
                                position: absolute;
                                top: 11px;
                                right: 16px;
                                cursor: pointer;
                            }
                            .reportList_title{
                                font-size: 14px;
                                color: #999;
                            }
                            .report_con{
                                padding: 12px 25px;
                            }
                            .report_con ul li{
                                display: inline-block;
                                margin-right: 25px;
                            }
                            .report_con_box{
                                padding: 11px 0 ;
                            }
                            .reportBox_btn{
                                text-align: center;
                            }
                            .reportBox_btn button{
                                border-radius: 5px;
                                padding: 0 7px;
                                text-align: center;
                                font-size: 16px;
                            }
                            .reportBox_btn button.reportBox_btn_cancel:focus,.reportBox_btn button.reportBox_btn_cancel:active{
                                outline: none;
                                border: 1px solid #ccc;
                                box-shadow: none;
                            }
                            .reportBox_btn_sure{
                                background-color: rgb(70,136,241);
                                border: 0;
                                color: #fff;
                            }
                            .reportBox_btn_cancel{
                                background-color: #fff;
                                border: 1px solid #ccc;
                                color: #666;
                                margin-right: 30px;
                            }
                            .tzComment-type-right a.tzComment-delete {
                                padding-left: 20px!important;
                            }
                            .zanNum {
                                float: left;
                                margin-top: 6px;
                            }
                            .zanNum {
                                background-image: url(../../../assets/images/EduImg/eduSprite.png);
                                height: 14px;
                                width: 14px;
                                background-position: -130px 0;
                                display: inline-block;
                                margin-right: 5px;
                            }
                            .zan {
                                color: #808080;
                            }
                            .zan.clicked .zanNum{
                                background-position: -116px 0px;
                            }
                            .tzComment-type-right a{
                                margin-left: 10px;
                            }
                        </style>
                        <div class="video_n1">
                            <div class="vh_n1_content">
                                <style>
                                    .vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing.startShowControl .vjs-control-bar{
                                        height: 42px;
                                    }
                                    .vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing.startShowControl .vjs-control-bar .video_control_n1{
                                        opacity: 1;
                                    }
                                    .paginationNew>li>a, .paginationNew>li>span {
                                        position: relative;
                                        display: inline-block;
                                        padding: 6px 8px;
                                        margin-left: -1px;
                                        line-height: 1.42857143;
                                        color: #444;
                                        text-decoration: none;
                                        background-color: #fff;
                                        border: 1px solid #ddd;
                                        margin: 0 3px;
                                        outline: none;
                                    }
                                </style>

                            </div>
                            <div class="video_n1_content">
                                <div class="video_ctrl">
                                    <div class="video_n1_con">
                                        <div class="video_control">
                                            <div class="video_control_center">
                                                <div id="videoplayer_overlay" style="">
                                                    <div id="videoplayer_outer_container">
                                                        <div id="videoplayer_container">
                                                            <div id="videoplayer">
                                                                <div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto"
                                                                     class="video-js vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-playing vjs-user-inactive"
                                                                     id="my_video_1" style="width: 100%; height: 100%;">
                                                                    <video  webkit-playsinline="" playsinline="" glue-id="video" glue-component="common.component.universalPlayer.video" glue-behavior="common.behavior.player.dispatcher"  id="my_video_1_html5_api" data-link="Basic/QuantumConcept.mp4" controls="controls" class="vjs-tech" preload="auto" preload=""  poster=""
                                                                           data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="http://video.qpanda.cn:65520/Basic/QuantumConcept.mp4">
                                                                        <source type="video/mp4" src="http://video.qpanda.cn:65520/Basic/QuantumConcept.mp4">
                                                                    </video>
                                                                    <div></div>
                                                                    <div class="vjs-loading-spinner"></div>
                                                                    <div class="vjs-text-track-display vjs-hidden"></div>
                                                                    <div class="vjs-big-play-button" role="button" aria-live="polite" tabindex="0" aria-label="play video">
                                                                        <span aria-hidden="true"></span>
                                                                    </div>
                                                                    <div class="vjs-control-bar" style="display:none!important;">
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
                                                                            <div class="vjs-clarity-control" style="display:none;">
                                                                                <div class="clarityLocation"><span id="ulPx">高清</span></div>
                                                                                <#if !USER_INFO??>
                                                                                    <div class="clarityList">
                                                                                        <ul id="pxBox">
                                                                                            <li id="p720" style="margin-bottom: 5px">超清<span>720P</span></li>
                                                                                            <li id="p360" style="margin-bottom: 5px">高清<span>360P</span></li>
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
                                                                            <div class="vjs-speed-control" style="display: none">
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
                                                    <h2>恭喜你完成本节视频课程学习，请点课程介绍“项目检测”，完成检测后即可进入下一节学习，加油！</h2>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="videoStart">
                                        <div class="videoStartBg"></div>
                                    </div>

                                    <div class="vjs_tip">
                                        <div class="resumePlay_tips">
                                            <i onclick="viTipClose()"></i>
                                            <span>上次看到：<span id="oldVideoTime"></span></span>
                                            <button class="resumePlayBtn" onclick="resumePlay()">继续播放</button>
                                        </div>
                                        <span class="second_tips">当前音量：<span>11</span></span>
                                    </div>
                                    <div class="video_share" style="display:none;">
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
                                        </ul>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="AllTabBox">
                            <div class="label_con">
                                <ul>
                                    <li data-label="1">
                                        <div class="label_box">
                                            <div class="lable_name">
                                                课程介绍
                                                <span></span>
                                            </div>
                                        </div>
                                    </li>
                                    <li  class="active" data-label="2">
                                        <div class="label_box">
                                            <div class="lable_name">
                                                目录
                                                <span></span>
                                            </div>
                                        </div>
                                    </li>
                                    <li data-label="3">
                                        <div class="label_box">
                                            <div class="lable_name">
                                                课程评论
                                                <span></span>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="detLab_con">
                                <ul>
                                    <li class="courseList ">
                                        <div class="course_n1">
                                            <div class="course_n1_con">
                                                <div class="course_n1_title">
                                                    <h3 id="courseName">第一章  基础板块</h3>
                                                </div>
                                                <div class="course_n1_info">
                                                    <p>本章节主要介绍了量子力学以及量子计算的发展历程，通过理解量子计算所需的基本概念和基础数学知识，能够对量子计算入门起到导引作用。</p>
                                                </div>
                                                <div class="cursor_share">
                                                    <div class="share_box">
                                                        <ul>
                                                            <li class="v_share_name"><span>分享：</span></li>
                                                            <li class="share_copy" data-tag="share_1"><a data-id="1" href="javascript:void(0)" class="copeCode" title="复制网址"><textarea style="opacity: 0;">http://localhost/EDU/video.html?link=1_1</textarea></a></li>
                                                            <li class="share_qq bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                                            <li class="share_zone bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                                            <li class="share_sina bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></li>

                                                        </ul>
                                                    </div>
                                                    <div class="clear"></div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="division_solid"></div>
                                        <div class="course_learning padding032">
                                            <div class="course_learning_box">
                                                <ul>
                                                    <li>
                                                        <div class="n2_lb_img">
                                                            <img src="${base}/assets/images/EduImg/Handouts.png" alt="">
                                                        </div>
                                                        <div class="n2_lb_link">
                                                            <a href="javascript:void(0)" id="lectureUrl" target="_Blank" data-flag="1">课程讲义</a>

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
                                    </li>
                                    <li class="courseList active">
                                    <#--目录-->
                                        <div class="video_n2_menu padding032" >
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
                                    </li>
                                    <li class="courseList">
                                        <div id="pl_box">
                                            <div class="tzCommentContent" style="padding-top: 10px">
                                                <div class="tzCommHead padding032">
                                                    <div class="tzCommHead_left">
                                                        <div class="plTitle">课程评论</div>
                                                        <div class="numBox">(0条评论)</div>
                                                    </div>
                                                    <div class="tzCommHead_right">
                                                        <!--div>
                                                            发表您的学习评价<span class="blueColor">可以获得积分哦</span>
                                                        </div-->
                                                    </div>
                                                </div>
                                                <div class="tzCommentReplyBox padding032">
                                                    <div class="reviewArea clearfix">
                                                        <textarea class="comment-input" maxlength="140" id="contentbox" placeholder="请留下您的问题及建议，我们将积极改善！至少5字以上哦。" onkeyup="keyUP(this)" style="min-height: 80px;height: 124px;"></textarea>
                                                        <div class="wordsNum"><span class="fen5 blueColor"></span> <span class="wNum">0/140</span></div>
                                                        <a href="javascript:" class="plBtn">发表评论</a>
                                                    </div>
                                                </div>
                                                <div class="comments-title clearfix">
                                                    <div class="plTitle">评论列表</div>

                                                    <div class="sortTitle">
                                                        <div class="sortTitleName">排序方式：</div>
                                                        <ul class="sortList">
                                                            <li class="firstList sortActive">评论时间</li>
                                                        <#--<li>点赞数</li>-->
                                                        <#--<li>回复数</li>-->
                                                            <span class="showPic" style="display: none"></span>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="tzCommentBox">
                                                    <div class="tzComment-show-con clearfix">
                                                        <div class="plListBox">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="thread-reply">
                                                    <ul data-v-82963a40="" class="ft paginationNew clearfix">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
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
                            <img src="${base}/assets/images/EduImg/m_badge.png" alt="">
                            <div class="answered-top-text">恭喜你完成全部检测</div>
                            <div class="answered_score">+100积分</div>
                        </div>
                        <div class="answered-bottom">
                            <div class="answered-bottom-right">
                                <span id="againDo">再做一次</span>
                                <button class="answerBtn">下一题</button>
                            </div>
                            <div class="share_box"  style="padding-bottom:0.648648rem;overflow: hidden;float:left;width: auto;">
                                <ul>
                                    <li class="v_share_name"><span>分享：</span></li>
                                    <li class="share_copy" data-tag="share_1"><a data-id="1" href="javascript:void(0)" class="copeCode" title="复制网址"><textarea style="opacity: 0;">http://localhost/EDU/video.html?link=1_1</textarea></a></li>
                                    <li class="share_qq bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                    <li class="share_zone bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                    <li class="share_sina bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></li>

                                </ul>
                            </div>

                        </div>
                    </div>
                    <div class="answerBox-con">
                        <div class="questionName">Q<span id="QOrder" style="    color: #4c4c4c;"></span>:<span
                                data-question="" id="question"
                                style="color: #4c4c4c;">什么是量子？</span><span>(单选题)</span></div>
                        <div class="question-con">
                            <ul class="question-conUl">
                            </ul>
                        </div>
                        <div class="errorMessage" ></div>
                        <div class="answerBox-bottom">
                            <ul id="orderBox">
                                <li class="ansLine">1</li>
                                <li class="ansLine">2</li>
                                <li class="ansLine">3</li>
                                <li>4</li>
                            </ul>

                            <div class="answerBoxLast" style="position: relative;float: right;">
                                <div class="pop-up">
                                </div>
                            </div>

                        </div>
                        <div class="answered-bottom">
                            <div class="share_box" style="padding-bottom:0.648648rem;overflow: hidden;float:left;width: auto;">
                                <ul>
                                    <li class="v_share_name"><span>分享：</span></li>
                                    <li class="share_copy" data-tag="share_1"><a data-id="1" href="javascript:void(0)" class="copeCode" title="复制网址"><textarea style="opacity: 0;">http://localhost/EDU/video.html?link=1_1</textarea></a></li>
                                    <li class="share_qq bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                    <li class="share_zone bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                    <li class="share_sina bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1553656560637"><a data-id="1" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></li>

                                </ul>
                            </div>
                            <button class="answerBtn">确定</button>

                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    </#escape>
</@main.body>
<@main.mfooter>
<#--edit start-->
<script src="${base}/assets/js/md5.js"></script>
<script src="${base}/assets/js/jquery.nicescroll.min.js"></script>
<#--微信分享-->
<script src="${base}/assets/js/sha1.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    var userInfoId=''
    var pointNum="",pageNum="",infoText="";
    var videoIdValue='';
    var replyIdCookie=0;
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
    }else {
        shareDataTile="本源量子计算教育系列课程"
    }
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
        'cancel': function () {
            // 用户取消分享后执行的回调函数
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
    with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='${base}/assets/js/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
<script>
    <#--章节渲染-->
    var dataValue;
    var tutorialId;

    var resumePlayTime;
    var resumePlayTimeSet=null;
    var vidDetailsHtml ='';
    var curTime ,videoTitle,currentTime;
    var progressFlag;

    videoData.forEach(function (value,index) {
        ishtml=''
        if(vidDetails[value.blockid]==undefined){
            return;
        }
        for(var i=0;i<vidDetails[value.blockid].length;i++){
            if(value.blockid==videoMenu_data&&i==videoIndex_data){
                ishtml +='<li data-id='+value.blockid+(i+1)+'  class="index_menu_list active" data-value='+vidDetails[value.blockid][i].url+'><div class="vjs_menu_vidName"><a href="javascript:;">'+vidDetails[value.blockid][i].title+'</a></div></li>'
            }else {
                ishtml +='<li data-id='+value.blockid+(i+1)+'  class="index_menu_list" data-value='+vidDetails[value.blockid][i].url+'><div class="vjs_menu_vidName"><a href="javascript:;">'+vidDetails[value.blockid][i].title+'</a></div></li>'
            }
        }
        if(value.blockid==videoMenu_data){
            vidHtml +='<div class="vjs_menu_details active"> <div class="vjs_menu_name"  data-list="'+value.blockid+'"> <h4>'+value.name+'</h4> <i class="vjs_menu_vjs"></i> </div> <div class="vjs_menu_list"> <ul>'+ishtml+'</ul> </div> </div>'
        }else {
            vidHtml +='<div class="vjs_menu_details" > <div class="vjs_menu_name"  data-list="'+value.blockid+'"> <h4>'+value.name+'</h4> <i class="vjs_menu_vjs"></i> </div> <div class="vjs_menu_list"> <ul>'+ishtml+'</ul> </div> </div>'
        }
    })
    $("#vjs_menu").html(vidHtml)
    $(".index_menu_list.active").click()




    //点击播放视频
    $("body").on("click",".index_menu_list",function () {
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
            useriduserid:userInfoId,
            addscoreflag:false,
            progress:secondToDate($('#my_video_1_html5_api')[0].currentTime),
            title:videoTitle,
            id:videoIdValue
        }
        $('html,body').animate({scrollTop:0},300)
        currentTime = $('#my_video_1_html5_api')[0].currentTime;
        $('.toAnswer').hide();
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
        $("#courseName").text($(this).parents(".vjs_menu_list").siblings(".vjs_menu_name").find("h4").text())
        $('.course_n1_info p').text(textBoxVideo[list]);
        if(videoIdValue != '' && !isNaN(videoIdValue) ){
            var stateObject = {};
            var title = "";
            var newUrl = "${base}/m/mVideo.html?link="+videoIdValue.substring(0,1)+"_"+videoIdValue.substring(1);
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

                }
            });
        }

        $.ajax({
            type:"POST",
            url:"${base}/education/getvideoinfo.json",
            data:{
                userid:userInfoId
            },
            success:function (data) {
                var curObj = data.obj;
                curObj.forEach(function (ele,index) {
                    var curvid = ele.vid;
                    if(curvid == videoIdValue){
                        var time = ele.progress;
                        var timeNum = time.split(":");
                        var currentTime = Number(timeNum[0])*3600+Number(timeNum[1])*60+Number(timeNum[2]);
                        $("#oldVideoTime").text(time)
                        // $(".vjs_tip,.resumePlay_tips").addClass("active");
                        resumePlayTime = currentTime;
                        // $('#my_video_1_html5_api')[0].currentTime = currentTime
                    }
                    // resumePlayTimeSet=setTimeout(function () {
                    //     viTipClose()
                    // },30000)
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
        $("#pxBox li").each(function (i) {
            path="http://fast.qpanda.cn/360p/"+dataValue+"?video="+encode;
            if(pxBox ==="超清"){
                path="http://video.qpanda.cn:65520/"+dataValue;
            }
            if(path.indexOf("QOeq0yzgt0IA") != -1){
                path = "http://1254321318.vod2.myqcloud.com/7885907dvodgzp1254321318/e9ee9bde5285890786124998662/QOeq0yzgt0IA.mp4";
            }
            $('#my_video_1_html5_api').attr("src",path);
            $('#my_video_1_html5_api').attr("data-link",dataValue);
            $('#my_video_1_html5_api').find("source").attr("src",path);
            $('#my_video_1_html5_api')[0].play();
                // if(userInfoId!=''||videoIdValue.substring(1)=="1"){
                //     if(i==1){
                //         clickPlayStates()
                //     }
                // }
        })
        updReadCount($(this).attr("data-id"));
        if(pageNum!=''&&pageNum!=null){
            toLocation(pageNum-1)
        }else {
            toLocation(0);
        }

        $.post(base+"/UpdateUserScore/saveVideoDetail.json",{"type":1,"vid":$(this).attr("data-id")},function () {
        })

    });

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
    //视频结束
    $('#my_video_1_html5_api').on('ended',function () {
        updataVideoInfo(1);
        noQuesTion()
    })

</script>
<script src="${base}/assets/mobile/js/answer.js"></script>
<script src="${base}/assets/mobile/js/main.js"></script>
<#--视频-->
<script>
    // $(window).scroll(function(event){
    //     // var videoTop=$(".videoBox").offset().top
    //     // var videoN1=$(".video_n1").height();
    //     // var heightMain=$(".header-container").height();
    //     // if($(window).scrollTop()>heightMain){
    //     //     $(".video_n1").css({"position":"fixed","width":"100%","z-index":"10","top":"0"})
    //     //     $(".AllTabBox").css({"margin-top":videoN1})
    //     // }else if($(window).scrollTop()<=heightMain){
    //     //     $(".video_n1,.AllTabBox").attr("style",'')
    //     // }else {
    //     //     $(".video_n1,.AllTabBox").attr("style",'')
    //     // }
    //     // $('.adminBox').hide();
    //     // $('.menu-wrapper').hide()
    // });
    // 获取视频要操作的元素
    var video = document.getElementById("my_video_1_html5_api");
    window.onload = function () {
        if (window.name == "hasLoad") {
            // location.reload();
            window.name = "";
        } else {
            window.name = "hasLoad";
        }
        var url = window.location.href;
        if(url.toString().indexOf("link") != -1 && url.toString().indexOf("isNext") != -1){
            $.ajax({
                type:"POST",
                url:"${base}/education/getvideoinfo.json",
                data:{
                    userid:userInfoId
                },
                success:function (data) {
                    try {
                        var time = data.obj[0].progress
                        if(time){
                            var timeNum = time.split(":")
                            var currentTime = Number(timeNum[0])*3600+Number(timeNum[1])*60+Number(timeNum[2]);
                            $("#oldVideoTime").text(time)
                            resumePlayTime = currentTime
                        }
                    }catch (e) {}
                }
            })
        }
    }
    //视频结束
    function updataVideoInfo(flag){
        var scoreFlag=null;
        var currentTime = $('#my_video_1_html5_api')[0].currentTime;
        var curTime = secondToDate(currentTime);
        var videoTitle = $('.index_menu_list.active a').text();
        if (flag === 1){
            scoreFlag = true
        } else {
            scoreFlag = false
        }
        $.ajax({
            type:"POST",
            url:"${base}/education/updvideoinfo.json",
            async:false,
            data:{
                userid:userInfoId,
                addscoreflag:scoreFlag,
                progress:curTime,
                title:videoTitle,
                id:videoIdValue
            },
            success:function (data) {
            }
        });
        $.ajax({
            type:"POST",
            url:"${base}/education/getvideoinfo.json",
            async:false,
            data:{
                userid:userInfoId
            },
            success:function (data) {
                console.log(data)
            }
        })
        getUserInfo();

    }
    window.onbeforeunload = function(){updataVideoInfo()}
    window.onunload = function(){updataVideoInfo()}
    //判断是否刷新
    isReload=false;
</script>
<!--textarea高度自适应-->
<script type="text/javascript">
    // <a href="javascript:;" class="tzComment-zan">赞</a>
    //    点赞
    var count = 0
    tutorialId = $(".index_menu_list.active").attr("data-id");
    $('.tzCommentBox').on('click', '.zan', function () {
        var isLike=0;
        var oHid = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
        if ($(this).hasClass('clicked')){
            $(this).removeClass('clicked')
            $(this).find('.zan_Num').text( Number($(this).find('.zan_Num').text())-1);
            isLike=-1;
            count--;
        } else {
            $.tipsBox({
                obj: $(this),
                str: "+1",
                callback: function () {}
            });
            $(this).addClass('clicked')
            $(this).find('.zan_Num').text( Number($(this).find('.zan_Num').text())+1);
            isLike=1;
            count++;
        }
        $.post("${base}/EduTutorial/videoReplyLike.json", {
            replyId: oHid,
            type:isLike
        }, function (result) {})
    })
    // 学习页面章节展开
    var flag = true;
    // $('.sortList li').on('click',function () {
    //     var eleText = $(this).text();
    //     $('.sortList li').toggle();
    //     $(this).text($('.firstList').text())
    //     $('.firstList').text(eleText);
    //     if(flag){
    //         $('.sortList').css({
    //             'border':'1px solid #ccc'
    //         })
    //         $('.showPic').css({
    //             'background-position':'-38px 0'
    //         })
    //         flag = false
    //     }else {
    //         $('.showPic').css({
    //             'background-position':'-50px 0'
    //         })
    //         $('.sortList').css({
    //             'border':'1px solid transparent'
    //         })
    //         flag = true
    //     }
    // })

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
        replyIdCookie=$(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html()
        $(this).hide()
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
    function showReport(ele){
        $(ele).siblings('.tz-reply-report').show()
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
    // toLocation(0);
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
                if( reply[s].username==undefined){
                    replyOneName=''
                }else {
                    replyOneName=reply[s].username;
                }
                plHtml +='<div class="plListBox" id="reply'+reply[s].id+'"> <div class="tzComment-replier"> <div class="tzComment-replier-img"> ';
                        <#--'<img src="${base}/assets/images/wx_new1.jpg" alt=""></div> ' +-->
                if(reply[s].userface == null || reply[s].userface == '') {
                    plHtml += '<img src="${base}/assets/images/wx_new1.jpg" alt=""></div> ';
                }else {
                    plHtml +=  '<img src="/${setting['files.contextpath']}'+reply[s].userface+'" alt=""></div> ';
                }
                   plHtml +=  '<div class="tzComment-replier-name">'+ replyOneName +'</div> </div> <div class="tzComment-Content"> ' +
                        '<div class="tzComment-Content-con">'+reply[s].content+'</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> ' +
                        '<div class="tz-reply-tiem"><span>'+reply[s].addtime+'</span></div> </div> <span class="tzCommenTid">'+reply[s].id+'</span> <input type="hidden" class="tzCommenPids" value="'+reply[s].pids+'"><input type="hidden" class="tzParentid" value="'+reply[s].parentid+'"><span class="tzCommenUserId">'+reply[s].userid+'</span><div class="tzComment-type-right"> ';
                //                是否是本人
                if(reply[s].delflag=="1"){ plHtml +='<a href="javascript:;" class="tzComment-delete">删除</a>'}

                plHtml +='<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">回复</a> '
                //                是否点赞
                if(reply[s].likeflag>0){
                    plHtml +='<a href="javascript:;" class="zan  clicked"><span class="zanNum"></span><span class="zan_Num">'+reply[s].likecount+'</span></a>'
                }else {
                    plHtml +='<a href="javascript:;" class="zan"><span class="zanNum"></span><span class="zan_Num">'+reply[s].likecount+'</span></a>'
                }

                plHtml +=' <a href="javascript:void(0);" class="pl-more" style="margin:0" onclick="showReport(this)" ></a>  <div class="tz-reply-report">举报</div> </div> </div><div class="reply-textarea"></div> <div class="reply-list-con">';
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
                    plHtml += '<div class="reply-list-con"> <div class="reply-pl-con"> <div class="reply-pl-title">引用 <a href="###">@ '+reply[s].repdusername+' </a> 的评论：</div> <div class="reply-pl-content">'+reply[s].repdcontent+'</div> </div> </div>';
                }

                // if(reply[s].pids.split(",").length>3){
                //     plHtml +='<p class="more">引用'+(reply[s].pids.split(",").length-3)+'次评论 <a href="javascript:;">查看全部</a></p></div>';
                // }
                plHtml += '</div></div> </div> ';
            });
            $(".tzCommentBox").html(plHtml);
            $(".numBox").text('('+rusult.totalRecords+'条评论)');
            $(".paginationNew").createPage({
                result:rusult,
                pageCount:rusult.totalPages,//总页数
                current:rusult.pageNum,//当前页
                distinguish: 1,
                turndown:'false',//是否显示跳转框，显示为true，不现实为false,一定记得加上引号...
                backFn:function(p){
                }
            })

        },"json")
    }
    dataValue=$(".index_menu_list.active").attr("data-value");
    // $(".index_menu_list.active").click()
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
        $('.wNum').text(0+'/140');
        var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
        if($("#contentbox").val().match(regRule)){
            layer.msg('暂不支持表情输入');
            return false;
        }
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

        oSize = oSize.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g, "");
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
        fhHtml += '</div><div class="textArea-hf"><textarea class="comment-input hf-input" placeholder="' + fhN + '" onkeyup="keyUP(this)"></textarea><div class="wordsNum2"><span class="wNum">0/140</span></div></div>  <a href="javascript:;" class="hf-pl" id="hf-plBtn">回复</a>';
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
        if($(this).siblings(".textArea-hf").find('.hf-input').val().length<=5){
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
        var oHfVal = $(this).siblings('.textArea-hf').find('.hf-input').val();

        oHfVal = oHfVal.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g, "");
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
    // label_con
    if(pointNum!=''&&pointNum!=null){
        $(".label_con ul li").eq(2).click();
        $(".index_menu_list.active").click();
        setTimeout(function(){
            $('html, body').animate({scrollTop:$("#reply"+pointNum).offset().top-10}, 300);
        },100)
    }else {
        $(".index_menu_list.active").click();
    }
</script>

</@main.mfooter>