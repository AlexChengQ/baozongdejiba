<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
    <style>
        body{
            background-color: #fff!important;
        }
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
</@main.header>
<@main.body>
    <#escape x as x?html>
        <div class="contentBox" style="padding: 0">
            <link rel="stylesheet" href="${base}/assets/css/public.css">
            <!--top-->
            <div class="content" style="min-width:1200px;">
                <@main.top5>
                    <#escape x as x?html></#escape>
                </@main.top5>
                <div class="bannerOrSwiper">
                    <div class="EDU-banner" style="position: relative;">
                        <img src="${base}/assets/images/edu-banner.jpg" alt="" style="width:100%;">
                        <div class="width1200">
                            <div  style="display: none" class="libraries-login">
                                <div class="user-name">
                                    <input type="text" placeholder="USER NAME" name="email">
                                    <span><img src="${base}/assets/images/user-name.png" alt=""></span>
                                </div>
                                <div class="password">
                                    <input type="password" placeholder="PASSWORD" name="password">
                                    <span ><img src="${base}/assets/images/password.png" alt=""></span>
                                </div>
                                <div>
                                    <button class="login-btn" onclick="submitLogin()">LOGIN</button>
                                </div>
                                <div class="remember">
                                    <input type="checkbox" id="rememberBox">
                                    <label for="rememberBox">REMEMBER ME</label>
                                </div>
                                <div class="login-bottom">
                                    登录查看学习进度，更可以享受积分兑换特权
                                </div>
                            </div>
                            <div class="myStydy">
                                <h1 class="myStydy_title">我的学习</h1>
                                <div class="learn_pro">
                                    <div>学习进度：</div>
                                    <div id="stdProgress">基本概念</div>
                                    <div class="studyed-process"></div>
                                </div>
                                <div class="learn_pro">
                                    <div>我的积分：</div>
                                    <div id="myScore">0</div>
                                </div>
                                <!--<div class="pro_box">
                                    <div class="learn_pro">
                                        <div>学习进度：</div>
                                        <div id="stdProgress"></div>
                                        <div class="studyed-process">已学完2/10课时</div>
                                    </div>
                                    <div class="learn_pro">
                                        <div>我的积分：</div>
                                        <div id="myScore">0</div>
                                    </div>
                                </div>-->
                                <div class="learning">
                                    <div>正在学习：</div>
                                    <div class="section_name">1.1 量子世界</div>
                                    <div class="continue_learn">继续学习</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="wrapper">
                        <div class="video-left">
                            <ul>
                            </ul>
                        </div>
                        <div class="video-right">
                            <ul>
                                <li class="listNum1" data-list="1">
                                    <div class="section_list section_list1" >
                                        <div>第一章  量子计算入门基础</div>
                                        <span class="click_show click_show1 showBtn" data-list="1"></span>
                                    </div>
                                    <div class="video-box-value video-box-value1" data-flagState = "true">
                                        <div class="title-box">
                                            <div>
                                                <div class=" top-title">
                                                    <a href="javascript(0)" name="I"></a>
                                                    <div>第一章  量子计算入门基础</div>
                                                    <span class="click_show click_show1 hideBtn" data-list="1"></span>
                                                </div>
                                                <div class="show_value_top">
                                                    <div class="show_value_top1">学完本章你将获得：</div>
                                                    <div class="show_value_top2">• 正确的量子概念思维 &nbsp;&nbsp;&nbsp;&nbsp;• 极具未来前瞻的技术理念   &nbsp;&nbsp;&nbsp;&nbsp; • 本源量子独家颁发的量子勋章</div>
                                                </div>
                                            </div>
                                        </div>
                                        <ul>
                                            <li class="video_box">
                                                <div class="video_box_left">
                                                    <div class="video_v" id="vid_1_1">
                                                        <#--<img id="player" src="${base}/assets/images/play.png" alt="">-->
                                                    </div>
                                                </div>
                                                <div class="video_box_content">
                                                    <div class="video-title">
                                                        <span>第一节 量子计算机介绍</span>
                                                        <span class="lock"></span>
                                                    </div>
                                                    <div>练习题</div>
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
                                                    <span style="font-size: 14px">已学完</span>
                                                </div>
                                            </li>
                                            <li class="video_box">
                                                <div class="video_box_left">
                                                    <div class="video_v" id="vid_1_2">
                                                        <img id="player" src="${base}/assets/images/play.png" alt="">
                                                    </div>
                                                </div>
                                                <div class="video_box_content">
                                                    <div class="video-title">
                                                        <span>第一节 量子计算机介绍</span>
                                                        <span class="lock"></span>
                                                    </div>
                                                    <div>练习题</div>
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
                                                    <span style="font-size: 14px">已学完</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </li>

                            </ul>
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
                                    <ul class="question-conUl"></ul>
                                </div>
                                <div class="errorMessage"></div>
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
        </div>
    </#escape>
</@main.body>
<@main.footer>
<#--edit start-->
    <script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<#--微信分享-->
<script src="${base}/assets/js/sha1.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    var infoText="";
    infoText=getQueryString("info")
    var userInfoId=''
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
        link: shareLink+"/EDU/quantumLearning.html",
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
        var share_block_text,share_exam_text;
        function setShareConfig(id,config){
            share_title =$(".index_menu_list.active").find(".vjs_menu_vidName").text();
            var blockShareId=parseInt($("#question").attr("data-question").substring(0,1))
            var examShareId=parseInt($("#question").attr("data-question").substring(4,1))-1
            if(isNaN(blockShareId)){
                share_block_text=''
                share_exam_text=''
            }else {
                share_block_text=videoData[blockShareId-1].name
                share_exam_text=vidDetails[blockShareId][examShareId].title
            }
            shareCon='本源量子计算教育系列课程__'+share_block_text+"__"+share_exam_text
            shareConWchat=escape(share_block_text+"__"+share_exam_text)
            config.bdText = shareCon;
            if(id=="tsina"){
                config.bdText = '本源量子计算教育系列课程__'+share_block_text+"——"+share_exam_text+"      "+shareLink+ "/EDU/index.html";
                config.bdUrl=shareLink+"/EDU/index.html"
            }else if(id=="weixin"){
                if(SharePage=="1"){
                    config.bdUrl=shareLink+"/EDU/index.html?info="+shareConWchat
                }else if(SharePage=="2"){
                    config.bdUrl=shareLink+"/EDU/quantumLearning.html?info="+shareConWchat
                }else if(SharePage=="3"){
                    config.bdUrl=shareLink+"/EDU/Share/Wechat/"+userInfoId+'?Sid='+blockShareId+examShareId+'&info='+shareConWchat
                }else {
                    config.bdUrl=shareLink+"/EDU/quantumLearning.html?info="+shareConWchat
                }
            }else {
                config.bdText=shareCon
                config.bdUrl=shareLink+"/EDU/index.html";
            }

            return config;
        }

        window._bd_share_config={
            common : {
                bdText : '本源量子计算教育系列课程—-',
                bdDesc : '本源量子计算教育系列课程，包含详细的量子计算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。',
                bdUrl : shareLink+'/EDU/quantumLearning.html',
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
        // 图片懒加载
        window.onload = function () {
            $("img.lazy").lazyload();
        }
        // 获取章节视频问题状态
        $.ajax({
            type:"post",
            url:'${base}/education/userexaminfo.json',
            dataType: "json",
            data:{userid:${USER_INFO.id!}},
            success:function (data) {
                getAll(data.obj)
            }
        })
        //获取所以题目
        function getAll(userInfo){
            $.ajax({
                type:"POST",
                url:'${base}/education/allexaminfo.json',
                dataType: "json",
                success:function (data) {dataInfo(data.obj,userInfo)}
            })
        }
        // 界面渲染
        var vidHtml='';
        var guideHtml='';
        var problemHtml='';
        var locationID=0;
        var chapter="其他";
        var dataUserIF='';
        function dataInfo(obj,userInfo){
            videoData.forEach(function (value,index) {
                ishtml=''
                chapter='';
                if (value.type === 1){
                   return
                }
                locationID=parseInt(window.location.hash.substring(1));
                if(isNaN(locationID)){
                    locationID=1;
                }
                var indexNum=0
                var isTcFlag=0;
                var isQuestionFlag=false;
                var isQuestionFlagNext=true
                if(vidDetails[value.blockid]!=undefined&&vidDetails[value.blockid]!=null){
                    for(var i=0;i<vidDetails[value.blockid].length;i++){
                        problemHtml='';
                        indexNum=0;
                        for(var k in obj){
                            if(obj[k].blockid==value.blockid&&obj[k].examid==(i+1)){
                                indexNum++;
                                if(userInfo==''){
                                    problemHtml +='<li data-blockid='+obj[k].blockid+' data-questionid='+obj[k].questionid+' data-examid='+obj[k].examid+'>'+indexNum+'</li>'
                                }else {
                                    for(var p in userInfo){
                                        if(userInfo[p].blockid==value.blockid&&userInfo[p].examid==(i+1)){
                                            dataUserInfo=userInfo[p].status.split("|");
                                            dataUserIF=userInfo[p].status;
                                            if(dataUserInfo.join("|").indexOf("0")==-1&&dataUserInfo.join("|").indexOf("1")!=-1){
                                                if(isTcFlag!=userInfo[p].examid){
                                                    isTcFlag=userInfo[p].examid;
                                                }
                                            }
                                            break;
                                        }else {
                                            dataUserInfo=[];
                                            dataUserIF='';
                                            isQuestionFlag=false
                                        }
                                    }

                                    if(dataUserInfo==''){
                                        problemHtml +='<li data-blockid='+obj[k].blockid+' data-questionid='+obj[k].questionid+' data-examid='+obj[k].examid+'>'+indexNum+'</li>'
                                    }else {
                                        if(dataUserInfo[indexNum-1]=='1'){
                                            problemHtml +='<li class="finished" data-blockid='+obj[k].blockid+' data-questionid='+obj[k].questionid+' data-examid='+obj[k].examid+'>'+indexNum+'</li>'
                                        }else if(dataUserInfo[indexNum-1]=='0'){
                                            problemHtml +='<li class="unfinished" data-blockid='+obj[k].blockid+' data-questionid='+obj[k].questionid+' data-examid='+obj[k].examid+'>'+indexNum+'</li>'
                                        }else{
                                            problemHtml +='<li data-blockid='+obj[k].blockid+' data-questionid='+obj[k].questionid+' data-examid='+obj[k].examid+'>'+indexNum+'</li>';
                                        }
                                    }
                                }
                            }
                        }
                        for(var k in obj){
                            if(obj[k].blockid==(value.blockid)&&obj[k].examid==(i+1)){isQuestionFlag=false;break;}else {isQuestionFlag=true;}
                        }
                        //1：已学完  0:学习中  -1：未学习
                        var stdState = vidDetails[value.blockid][i].stdStatus
                        if (stdState === 0){
                            learningStatus(0,value,i)
                        }else if(stdState === 1){
                            learningStatus(1,value,i)
                        }else{
                            learningStatus(-1,value,i)
                        }
                    }
                    guideHtml +='<a href="#'+(value.blockid)+'"><li class="taskBox" data-list="'+(value.blockid)+'"><div class="task-list EDU-active">' +
                            '<div>'+value.name+'</div></div></li></a>'
                    vidHtml +='<li class="listNum'+(value.blockid)+'" data-list='+(value.blockid)+'><div class="section_list section_list'+(value.blockid)+'">' +
                            '<div>'+chapter+' '+value.name+'</div><span class="click_show click_show'+(value.blockid)+' showBtn" data-list='+(value.blockid)+'></span></div><div class="video-box-value video-box-value'+(value.blockid)+'">' +
                            '<div class="title-box"><div><div class="top-title"><a href="javascript(0)" name="'+(value.blockid)+'"></a><div>'+value.name+'</div>' +
                            '<span class="click_show hideBtn click_show'+(value.blockid)+'" data-list='+(value.blockid)+'></span></div><div class="show_value_top">' +
                            '<div class="show_value_top1">学完本章你将获得：</div><div class="show_value_top2">'+textBox[index]+'</div>' +
                            '</div></div></div><ul>'+ishtml+' </ul></div></li>'
                }

            })
            $(".video-right ul").html(vidHtml);
            $(".video-left ul").html(guideHtml);
            $("body").find(".taskBox[data-list="+locationID+"]").click()
        }
        function learningStatus(is,value,i) {
            var stdScale = vidDetails[value.blockid][i].stdScale || -1;
            if(is == 1){
                stdScale=100;
            }else if(is == -1){
                stdScale=0;
            }

            ishtml += '<li class="video_box">\n' +
                '<div class="video_box_left">\n' +
                '    <div class="video_v" data-blockid=' + (value.blockid) + ' data-examid=' + (i + 1) + '  data-id=' + (value.blockid) + (i + 1) + ' data-value=' + (value.blockid) + '_' + (i + 1) + '>' +
                '        <div style="position: relative"><div class="videoBgHover"></div>' +
                '           <img class="lazy" id="player" data-original=' + vidDetails[value.blockid][i].img + '>' +
                '           <div class="video-progress"><span class="blue-progress" style="width: '+ stdScale+'%;"></span></div>' +
                '        </div>\n' +
                '    </div>\n' +
                '</div>\n' +
                '<div class="video_box_content">\n' +
                '    <div class="video-title">\n' +
                '        <span class="chapterName">' + vidDetails[value.blockid][i].title + '</span>';
            ishtml +='        </div>\n' +
                '        <div>项目检测</div>\n' +
                '        <ul class="testList">' + problemHtml + '</ul>\n' +
                '    </div>\n' +
                '    <div class="video_box_right">';
            if(is == 1){
                ishtml +='<span class="complete"></span><span >已学完</span>\n';
            }else if(is == 0){
                ishtml +=' <span class="stydying"></span><span >学习中</span>';
            }else {
                ishtml +='<span class="incomplete"></span><span >未学习</span>'
            }
            ishtml += '</div></li>'
        }

        // 继续学习按钮
        var vid;
        $(".continue_learn").on("click",function () {
            window.location.href="${base}/EDU/video.html?link="+vid+"isNext=1";
        })

        function getNewest() {
            $.ajaxSettings.async = false;
            $.post("${base}/UserInfo/getNewest.json",{},
                    function(result) {
                        if(result==''){
                            $("#stdProgress").html("基本概念");
                            $(".studyed-process").html('');
                            $(".continue_learn").html("开始学习");
                            $(".section_name").html("1.1 量子世界");
                            return false
                        }
                        if(result) {
                            $("#stdProgress").html(result.name);
                            $(".studyed-process").html('已学完'+result.finishCount+'/'+result.allCount+'课时');
                            var a = parseInt(result.id.toString().substring(0,1));
                            var b = parseInt(result.id.toString().substring(1))-1;
                            vid = result.id.toString().substring(0, 1)+"_"+result.id.toString().substring(1)
                            $(".section_name").html(vidDetails[a][b].title)
                        }else {
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
            $.post("${base}/UserInfo/getNewExam.json",{"videoId":videoId},
                function(result) {data = result;}
            )
            return data;
        }

        //根据视频id查询最新的视频
        function getNewVideo(videoId) {
            var data = "";
            $.post("${base}/UserInfo/getNewVideo.json",{"videoId":videoId},
                    function(result) {data = result;}
            )
            return data;
        }

        $(function() {setTimeout(function () {getNewest();},300)})

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
        $(document).resize(function() {
            if($(window).scrollTop()>600){
                $('.video-left').css({'position':'fixed', 'top':'150px'})
            }else{
                $('.video-left').css({'position':'static'})
            }
        })

        $(window).scroll(function () {
            if($(window).scrollTop()>600&$("body").height()-$(window).height()-$(window).scrollTop()>160){
                $('.video-left').css({'position':'fixed', 'top':'150px','bottom':'auto'})
            }else if($("body").height()-$(window).height()-$(window).scrollTop()<160){
                $(".video-left").attr("style","")
                $('.video-left').css({'position':'fixed', 'top':'auto','bottom':'180px'})
            }else{
                $('.video-left').css({'position':'static'})
            }
        })
    </script>

<script src="${base}/assets/js/main/QLearning.js"></script>
<script src="${base}/assets/js/main/AnswerCtrl.js"></script>
</@main.footer>