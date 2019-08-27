<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader>
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
    <style>
        body {
            background-color: #fff !important;
        }

        .bdshare-button-style0-16 a,
        .bdshare-button-style0-16 .bds_more {
            background: transparent !important;
            padding: 0;
            margin: 0;
            float: none;
        }

        .bd_weixin_popup {
            width: 260px !important;
            height: 300px !important;
        }
        .video_v .video-progress{
            position: absolute;
            width: 100%;
            height:3px;
            background-color: #b1acac;
            z-index: 1;
            bottom: 3px;
        }
        .blue-progress{
            position: absolute;
            width: 0%;
            height: 100%;
            z-index: 2;
            background-color: #00a1ff;
        }
    </style>
</@main.mHeader>
<@main.body>
    <#escape x as x?html>
        <div class="contentBox" style="padding: 0">
            <link rel="stylesheet" href="${base}/assets/css/public.css">
            <!--top-->
            <div class="content">
                <@main.mobileTop>
                    <#escape x as x?html></#escape>
                </@main.mobileTop>
                <div class="learning_banner">
                    <div class="myStydy">
                        <h1 class="myStydy_title">我的学习</h1>
                            <div class="learn_pro">
                                <div class="sty-process">学习进度：</div>
                                <div id="stdProgress">基本概念</div>
                                <div class="studyed-process"></div>
                            </div>
                            <div class="learn_pro">
                                <div class="learn_pro_div2">我的积分：</div>
                                <div id="myScore">0</div>
                            </div>
                        <div class="learning">
                            <div class="studying">正在学习：</div>
                            <div class="section_name">1.1 量子世界</div>
                            <div class="continue_learn">继续学习</div>
                        </div>
                    </div>
                </div>
                <div class="title_box" id="menu-wrap">
                    <ul class="title_list menu-list js-menu-list" id="title_slider" style="width: auto;">
                        <li class="active_module menu-list-item">基础版块</li>
                        <li class="menu-list-item">工具版块</li>
                        <li class="menu-list-item">编程版块</li>
                        <li class="menu-list-item">硬件介绍</li>
                        <li class="menu-list-item">科大教程</li>
                    </ul>
                    <div class="white_mask"></div>
                </div>
                <#--<div class="video_top">-->
                <#--<div class="show_value_top">-->
                <#--<div class="show_value_top1">学完本章你将获得：
    </div>-->
                <#--<div class="show_value_top2">• 正确的量子概念思维 &nbsp;&nbsp;&nbsp;&nbsp;• 极具未来前瞻的技术理念 <br>•
                    本源量子独家颁发的量子勋章
            </div>-->
                <#--</div>--> <#--</div>--> <div class="m_video_box">
                    <ul>
                        <li class="video_box listNum1" data-list="1">
                            <div class="video_box_left">
                                <div class="video_v" id="vid_1_1">
                                    <div>
                                        <div class="videoBgHover"></div>
                                        <img src="../../../assets/images/video/QPanda2ProgrammingTeaching1.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="video_box_content">
                                <div class="video-title">
                                    <span>第一节 量子世界</span>
                                    <span class="lock"></span>
                                </div>
                                <div>项目检测</div>
                                <ul class="testList">
                                    <li class="finished">1</li>
                                    <li class="unfinished">2</li>
                                    <li>3</li>
                                    <li>4</li>
                                    <li>5</li>
                                </ul>
                            </div>
                            <div class="video_box_right">
                                <span class="complete"></span>
                                <span>已学完</span>
                            </div>
                        </li>
                        <li class="video_box">
                            <div class="video_box_left">
                                <div class="video_v" id="vid_1_1">
                                    <div>
                                        <div class="videoBgHover"></div>
                                        <img src="../../../assets/images/video/QPanda2ProgrammingTeaching1.png" alt="">
                                    </div>
                                </div>
                            </div>
                            <div class="video_box_content">
                                <div class="video-title">
                                    <span>第一节 量子计算机介绍</span>
                                    <span class="lock"></span>
                                </div>
                                <div>项目检测</div>
                                <ul class="testList">
                                    <li class="finished">1</li>
                                    <li>2</li>
                                    <li class="unfinished">3</li>
                                    <li>4</li>
                                    <li>5</li>
                                </ul>
                            </div>
                            <div class="video_box_right">
                                <span class="complete"></span>
                                <span>已学完</span>
                            </div>
                        </li>
                    </ul>
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
                            <div  class="errorMessage">

                            </div>
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
<#--微信分享-->
    <script src="${base}/assets/js/sha1.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
        var infoText = "";
        infoText = getQueryString("info")
        var userInfoId = ''
        <#if !USER_INFO ??>
        userInfoId= '';
        <#else >
        userInfoId=${ USER_INFO.id! };
        </#if>
        var timestamp = parseInt(new Date().getTime() / 1000);

        var shareDataTile = "本源量子计算教育系列课程"
        if (infoText != '' && infoText != null && infoText != undefined) {
            shareDataTile = "本源量子计算教育系列课程__" + unescape(infoText)

        } else {
            shareDataTile = "本源量子计算教育系列课程"
        }
        var shareData = {
            title: shareDataTile,
            desc: "点击查看详情",
            imgUrl: shareLink+'/assets/images/EduImg/shareSideLogo.png',
            otherImgUrl: '',
            text: '我正在学习，很不错哦！快来一起学习吧！',
            url: location.href.split('#')[0],
            link: shareLink+"/EDU/quantumLearning.html",
            "success": function () {//分享成功后的回调函数
            },
            'cancel': function () {
                // 用户取消分享后执行的回调函数
            }
        }

        $.post("${base}/Wechat/ShareLearning.json", {}, function (result) {
            data = result.obj;
            SignString = "jsapi_ticket=" + data.ticket + "&noncestr=" + data.noncestr + "&timestamp=" + timestamp.toString() + "&url=" + location.href.split('#')[0]
            s = new jsSHA(SignString.toString(), "TEXT");
            t = s.getHash("SHA-1", "HEX");
            var sha1Sign = t
            wx.config({
                debug: false,
                appId: data.appid,
                timestamp: timestamp,
                nonceStr: data.noncestr,
                signature: sha1Sign.toString(),
                jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            wx.ready(function () {
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
        var share_block_text, share_exam_text;
        function setShareConfig(id, config) {
            share_title = $(".index_menu_list.active").find(".vjs_menu_vidName").text();
            var blockShareId = parseInt($("#question").attr("data-question").substring(0, 1))
            var examShareId = parseInt($("#question").attr("data-question").substring(4, 1))-1
            if (isNaN(blockShareId)) {
                share_block_text = ''
                share_exam_text = ''
            } else {
                share_block_text = videoData[blockShareId-1].name
                share_exam_text = vidDetails[blockShareId][examShareId].title
            }
            shareCon = '本源量子计算教育系列课程__' + share_block_text + "__" + share_exam_text
            shareConWchat = escape(share_block_text + "__" + share_exam_text)
            config.bdText = shareCon;
            if (id == "tsina") {
                config.bdText = '本源量子计算教育系列课程__' + share_block_text + "——" + share_exam_text +"      "+shareLink+ "/EDU/index.html";
                config.bdUrl = shareLink+"/EDU/index.html"
            } else if (id == "weixin") {
                if (SharePage == "1") {
                    config.bdUrl = shareLink+"/EDU/index.html?info=" + shareConWchat
                } else if (SharePage == "2") {
                    config.bdUrl = shareLink+"/EDU/quantumLearning.html?info=" + shareConWchat
                } else if (SharePage == "3") {
                    config.bdUrl = shareLink+"/EDU/Share/Wechat/" + userInfoId + '?Sid=' + blockShareId + examShareId + '&info=' + shareConWchat
                } else {
                    config.bdUrl = shareLink+"/EDU/quantumLearning.html?info=" + shareConWchat
                }
            } else {
                config.bdText=shareCon
                config.bdUrl=shareLink+"/EDU/index.html";
            }

            return config;
        }

        window._bd_share_config = {
            common: {
                bdText: '本源量子计算教育系列课程—-',
                bdDesc: '本源量子计算教育系列课程，包含详细的量子计算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。',
                bdUrl: shareLink+'/EDU/quantumLearning.html',
                bdPic: '',
                onBeforeClick: setShareConfig
            },
            "share": {
                share: [{
                    "tag": "share_1",
                    "bdSize": 16,
                    "bdCustomStyle": "background-image:none"
                }]
            }
        };
        //以下为js加载部分
        with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = '${base}/assets/js/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
    </script>
    <script>
        // 界面渲染
        var dataUserInfoCookie = ''
        var vidHtml = '';
        var guideHtml = '';
        var problemHtml = '';
        var locationID = 0;
        var chapter = "其他";
        var dataUserIF = '';
        var index = parseInt(window.location.hash.substring(1));
        if(isNaN(index) || index==6){
            index = 0
        }else if(index>=7){
            index=index-1
        }
        $('.title_list').on('click', 'li', function () {
            vidHtml = '';
            index = Number($(this).attr("data-list"));
            if (isNaN(index) || index == undefined) {index = 0;}
            $(this).addClass('active_module').siblings().removeClass('active_module');
            getAll(dataUserInfoCookie, index);
            var stateObject = {};
            var title = "";
            var newUrl = "${base}/m/quantumLearning.html#"+index;
            history.pushState(stateObject,title,newUrl);

        });
        videoData.forEach(function (value, index) {
            if (index == 0) {
                guideHtml += ' <li class="active_module menu-list-item" data-list=' + (value.blockid-1) + '>' + value.name + '</li>'
            }else if (value.type===1) {
            }else {
                guideHtml += ' <li class="menu-list-item" data-list=' + (value.blockid-1) + '>' + value.name + '</li>'
            }
        })
        function dataInfo(obj, userInfo, index) {
            if (userInfo) {userInfo = dataUserInfoCookie;}
            ishtml = ''
            locationID = parseInt(window.location.hash.substring(1)) - 1;
            if (isNaN(locationID)) {locationID = 0}
            var indexNum = 0
            var lockFlag = false;
            var isTcFlag = 0;
            var isLockFlag = false;
            var isQuestionFlag = false;
            var isQuestionFlagNext = true
            if(vidDetails[index + 1]==undefined){
                $(".m_video_box ul").html("<div style='height: 150px;'></div>")
                return;
            }
            for (var i = 0; i < vidDetails[index + 1].length; i++) {
                problemHtml = '';
                indexNum = 0;
                for (var k in obj) {
                    if (obj[k].blockid == (index + 1) && obj[k].examid == (i + 1)) {
                        indexNum++;
                        if (userInfo == '') {
                            problemHtml += '<li data-blockid=' + obj[k].blockid + ' data-questionid=' + obj[k].questionid + ' data-examid=' + obj[k].examid + '>' + indexNum + '</li>'
                        } else {
                            for (var p in userInfo) {
                                if (userInfo[p].blockid == (index + 1) && userInfo[p].examid == (i + 1)) {
                                    dataUserInfo = userInfo[p].status.split("|");
                                    dataUserIF = userInfo[p].status;
                                    if (dataUserInfo.join("|").indexOf("0") == -1 && dataUserInfo.join("|").indexOf("1") != -1) {
                                        if (isTcFlag != userInfo[p].examid) {
                                            lockFlag = true;
                                            isTcFlag = userInfo[p].examid;
                                        }
                                    } else {
                                        lockFlag = false;
                                    }
                                    break;
                                } else {
                                    dataUserInfo = [];
                                    dataUserIF = '';
                                    isQuestionFlag = false
                                }
                            }

                            if (dataUserInfo == '') {
                                problemHtml += '<li data-blockid=' + obj[k].blockid + ' data-questionid=' + obj[k].questionid + ' data-examid=' + obj[k].examid + '>' + indexNum + '</li>'
                            } else {
                                if (dataUserInfo[indexNum - 1] == '1') {
                                    problemHtml += '<li class="finished" data-blockid=' + obj[k].blockid + ' data-questionid=' + obj[k].questionid + ' data-examid=' + obj[k].examid + '>' + indexNum + '</li>'
                                } else if (dataUserInfo[indexNum - 1] == '0') {
                                    problemHtml += '<li class="unfinished" data-blockid=' + obj[k].blockid + ' data-questionid=' + obj[k].questionid + ' data-examid=' + obj[k].examid + '>' + indexNum + '</li>'
                                } else {
                                    problemHtml += '<li data-blockid=' + obj[k].blockid + ' data-questionid=' + obj[k].questionid + ' data-examid=' + obj[k].examid + '>' + indexNum + '</li>';
                                }
                            }
                        }
                    }
                }
                for (var k in obj) {
                    if (obj[k].blockid == (index + 1) && obj[k].examid == (i + 1)) { isQuestionFlag = false; break; } else { isQuestionFlag = true; }
                }
                //1：已学完  0:学习中  -1：未学习
                var stdState = vidDetails[index + 1][i].stdStatus
                if (stdState == 0){
                    learningStatus(0,i)
                }else if(stdState == 1){
                    learningStatus(1,i)
                }else{
                    learningStatus(-1,i)
                }
                // if (i == 0 || dataUserIF.indexOf("0") == -1 && dataUserIF.indexOf(" ") == -1 && dataUserIF != '' && dataUserIF.indexOf("1") != -1) {
                //     if (dataUserIF.indexOf("0") == -1 && dataUserIF != '' && dataUserIF.indexOf(" ") == -1||isQuestionFlag && dataUserIF == '') {
                //         isLockFlag = true;
                //         learningStatus(1)
                //         dataUserIF = '';
                //     } else if (dataUserIF == '' || dataUserIF.indexOf(" ") != -1 || i == 0 && dataUserIF.indexOf(" ") != -1 || dataUserIF.indexOf("1") != -1 && dataUserIF.indexOf("0") != -1) {
                //         isLockFlag = false;
                //         learningStatus(2)
                //     } else {
                //         learningStatus(2)
                //     }
                //     isQuestionFlagNext = false;
                // } else if (isQuestionFlag && dataUserIF == '') {
                //
                //     isLockFlag = true;
                //     isQuestionFlag = true;
                //     isQuestionFlagNext = true
                //     dataUserIF = '';
                //     learningStatus(1)
                // } else if (dataUserIF.indexOf("0") != -1 && dataUserIF != '' ||
                //     dataUserIF.indexOf("0") == -1 && dataUserIF != '' && dataUserIF.indexOf("1") == -1 ||
                //     dataUserIF.indexOf("0") != -1 && dataUserIF != '' && dataUserIF.indexOf("1") != -1 ||
                //     dataUserIF.indexOf("0") > -1 && dataUserIF.indexOf(" ") != -1 && dataUserIF != '' && dataUserIF.indexOf("1") != -1 ||
                //     dataUserIF.indexOf("1") > -1 && dataUserIF.indexOf(" ") != -1 && dataUserIF != '' && dataUserIF.indexOf("1") != -1 ||
                //     dataUserIF == "" && isLockFlag && isQuestionFlagNext) {
                //
                //     isQuestionFlagNext = false;
                //     isLockFlag = false;
                //     dataUserIF = '';
                //     learningStatus(2)
                // } else if (dataUserIF == "" && isLockFlag && !isQuestionFlag) {
                //     learningStatus(2)
                //     dataUserIF = '';
                //     isLockFlag = false;
                // } else {
                //     learningStatus(3)
                //     isLockFlag = false;
                //     dataUserIF = '';
                //
                // }
            }
            if (index == locationID) {
                vidHtml += '<li class="listNum' + (index + 1) + '" data-list=' + (index + 1) + '><div class="video-box-value video-box-value' + (index + 1) + '">' +
                    '<div class="title-box"><div><div class="video_top">' +
                    '<div class="show_value_top1">学完本章你将获得：</div><div class="show_value_top2">' + textBoxM[index] + '</div>' +
                    '</div></div></div><ul>' + ishtml + ' </ul></div></li>'
            } else {
                if (index === 6){
                    return
                }
                vidHtml += '<li class="listNum' + (index + 1) + '" data-list=' + (index + 1) + '><div class="video-box-value video-box-value' + (index + 1) + '">' +
                    '<div class="title-box"><div><div class="video_top">' +
                    '<div class="show_value_top1">学完本章你将获得：</div><div class="show_value_top2">' + textBoxM[index] + '</div>' +
                    '</div></div></div><ul> ' + ishtml + '</ul></div> </li>'
            }
            // })
            $(".m_video_box ul").html(vidHtml);
            $("body").find(".taskBox").eq(locationID).click();
            getNewest();
        }
        function learningStatus(is,i) {
            var stdScale = vidDetails[index + 1][i].stdScale || -1
            if(is == 1){
                stdScale=100;
            }else if(is == -1){
                stdScale=0;
            }
            ishtml += '<li class="video_box">\n' +
                '<div class="video_box_left">\n' +
                '    <div class="video_v" data-blockid=' + (index + 1) + ' data-examid=' + (i + 1) + '  data-id=' + (index + 1) + (i + 1) + ' data-value=' + (index + 1) + '_' + (i + 1) + '>' +
                '        <div style="position: relative"><div class="videoBgHover"></div>' +
                '           <img id="player" src=' + vidDetails[index + 1][i].img + '>' +
                '           <div class="video-progress"><span class="blue-progress" style="width: '+ stdScale+'%;"></span></div>' +
                '        </div>\n' +
                '    </div>\n' +
                '</div>\n' +
                '<div class="video_box_content">\n' +
                '    <div class="video-title">\n' +
                '        <span class="chapterName">' + vidDetails[index + 1][i].title + '</span>';
            // if(is == 1 || is == 2){
            //     ishtml +='<span class="lockbox"></span>\n';
            // }else if(is == 3){
            //     ishtml +='<span class="lockbox lock"></span>\n';
            // }
            ishtml +='</div>\n' +
                '<div>项目检测</div>\n' +
                '    <ul class="testList">' + problemHtml + '</ul>\n' +
                '</div>\n' +
                '<div class="video_box_right">';
            if(is == 1){
                ishtml +='<span class="complete"></span><span >已学完</span>\n';
            }else if(is == 0){
                ishtml +=' <span class="stydying"></span><span >学习中</span>';
            }else {
                ishtml +='<span class="incomplete"></span><span >未学习</span>'
            }
            ishtml += '</div></li>'
        }
        $('.title_list').html(guideHtml)

        <#--标题菜单滑动-->
        $(function () {
            var titleWidth=0
            $('#title_slider li').each(function () {
                $(this).outerWidth(true)
                titleWidth=$(this).outerWidth(true)+titleWidth
            })
            var menu = function (wrap, menuList, menuItems) {
                var positionX = 0;
                $(menuList).attr("style", "transition-duration: 0ms;transform: translateX(0px);");
                menuList.addEventListener('touchstart', function (event) {
                    if (event.targetTouches.length == 1) {
                        var touch = event.targetTouches[0];
                        positionX = touch.pageX;
                        //确定本次拖动transform的初始值
                        var transformStr = menuList.style.transform;
                        transformStr = transformStr.substring(11);
                        var index = transformStr.lastIndexOf("p");
                        transformStr = transformStr.substring(0, index);
                        transformX = parseInt(transformStr);
                    }
                }, false);
                menuList.addEventListener('touchmove', function (event) {
                    event.preventDefault();
                    //获取当前坐标
                    if (event.targetTouches.length == 1) {
                        var touch = event.targetTouches[0];
                        menuList.style.transform = 'translateX(' + (transformX + touch.pageX - positionX) + 'px)';
                    }
                }, false);
                menuList.addEventListener('touchend', function () {
                    if($('.title_list').offset().left>0){
                        menuList.style.transform = 'translateX(0)';
                    }
                    if($('#title_slider li:last').offset().left<$(window).width()-100){
                        menuList.style.transform ="translateX("+ -(titleWidth-$(window).width()+10) +"px)";
                    }
                }, false);
            }
            var init = function () {
                var menuWrap = $('#menu-wrap');
                var menuList = $("#menu-wrap .js-menu-list")[0];
                var menuListItems = $("#menu-wrap .menu-list-item");
                menu(menuWrap, menuList, menuListItems);
            }();
        });

        // 获取章节视频问题状态
        $.ajax({
            type: "post",
            url: '${base}/education/userexaminfo.json',
            dataType: "json",
            data: { userid: userInfoId},
            success: function (data) {
                if(index>=6){
                    getAll(data.obj, index+1);
                }else {
                    getAll(data.obj, index);
                }
                dataUserInfoCookie = data.obj;
                $('.title_list li').eq(index).addClass('active_module').siblings().removeClass('active_module');
            }
        })
        //获取所以题目
        function getAll(userInfo, index) {
            $.ajax({
                type: "POST",
                url: '${base}/education/allexaminfo.json',
                dataType: "json",
                success: function (data) {
                    dataInfo(data.obj, userInfo, index)
                }
            })
        }
        var vid;
        // 继续学习按钮
        $(".continue_learn").on("click", function () {


            window.location.href="${base}/m/mVideo.html?link="+vid+"isNext=1";
        })

        function getNewest() {
            $.ajaxSettings.async = false;
            $.post("${base}/UserInfo/getNewest.json", {},
                function (result) {
                    if (result == '') {
                        $("#stdProgress").html("基本概念");
                        $(".studyed-process").html('');
                        $(".continue_learn").html("开始学习");
                        $(".section_name").html("1.1 量子世界");
                        return false
                    }
                    if (result) {
                        $("#stdProgress").html(result.name);
                        $(".studyed-process").html('已学完'+result.finishCount+'/'+result.allCount+'课时');
                        /*if (result.flag == 'video') {
                            if (result.progress == 1) {
                                var data = getNewExam(result.id);
                                if (data) {
                                    var dati = data.status;
                                    var charat = strCharPosition(dati, "|");
                                    var count = 0;
                                    var t = dati.split("|");
                                    for (var i = 0; i < t.length; i++) {
                                        if (t[i] == "1") {
                                            count++;
                                        }
                                    }
                                    var p = Number((count / charat).toFixed(2) * 50) + 50;
                                     p += "%";
                                     $("#stdProgress").html(p)
                                 } else {
                                     $("#stdProgress").html("50%")
                                 }
                             } else {
                                 $("#stdProgress").html("0");
                                }
                            }
                        } else {
                            var videoId = result.id;
                            var data = getNewVideo(videoId);
                            var dati = result.progress;
                            var charat = strCharPosition(dati, "|");
                            var count = 0;
                            var t = dati.split("|");
                            for (var i = 0; i < t.length; i++) {
                                if (t[i] == "1") {
                                    count++;
                                }
                            }
                            var p = Number((count / charat).toFixed(2) * 50);
                            if (data && data.addscore == 1) {
                                p = p + 50;
                            }
                            p += "%";
                            $("#stdProgress").html(p)
                        }*/
                        var a = parseInt(result.id.toString().substring(0, 1));
                        var b = parseInt(result.id.toString().substring(1)) - 1;
                        vid = result.id.toString().substring(0, 1)+"_"+result.id.toString().substring(1);
                        $(".section_name").html(vidDetails[a][b].title)
                    } else {
                        $("#stdProgress").html("基本概念");
                        $(".studyed-process").html('');
                    }
                }
            )
            $.ajaxSettings.async = true;
        }

        //根据视频id查询最新的答题
        function getNewExam(videoId) {
            var data = "";
            $.post("${base}/UserInfo/getNewExam.json", { "videoId": videoId }, function (result) {data = result;})
            return data;
        }

        //根据视频id查询最新的视频
        function getNewVideo(videoId) {
            var data = "";
            $.post("${base}/UserInfo/getNewVideo.json", { "videoId": videoId }, function (result) {data = result;})
            return data;
        }


        //检测一个字符在字符串中出现次数，参数字符串，一个字符，返回字符串出现的次数
        function strCharPosition(str, char) {
            var pos;
            var arr = [];
            pos = str.indexOf(char);
            while (pos > -1) {
                arr.push(pos);
                pos = str.indexOf(char, pos + 1);
            }
            return arr.length;
        };
        //章节栏fixed定位
        $(window).scroll(function () {
            if ($(window).scrollTop() > 500) {
                $('.video-left').css({'position': 'fixed', 'top': '170px'})
            } else {
                $('.video-left').css({'position': 'static'})
            }
        })
    </script>
    <script type='text/javascript' src="${base}/assets/mobile/js/answer.js"></script>
    <script src="${base}/assets/mobile/js/main.js"></script>
</@main.mfooter>