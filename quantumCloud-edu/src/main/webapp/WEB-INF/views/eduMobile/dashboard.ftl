<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader title="视频">
    <#escape x as x?html></#escape>
</@main.mHeader>
<@main.body >
    <#escape x as x?html>
    <meta name="description" itemprop="description" content="这是要分享的内容" />
    <div class="contentBox" style="padding: 0;">
        <link rel="stylesheet" href="${base}/assets/css/public.css">
        <!--top-->
        <div class="content">
         <@main.mobileTop>
             <#escape x as x?html></#escape>
         </@main.mobileTop>
            <style>
                body{
                    background: #f1f5f6;
                }

            </style>
            <div class="bannerOrSwiper">
                <div class="dashboardBgMobile"></div>
                <div class="mDashboardBox">
                    <div id="db_user_con">
                        <div class="db_user_header">
                            <div class="db_to_personal">
                                <a href="${base}/m/personal.html"></a>
                            </div>
                            <div class="db_sign_box">
                                <button class="NSign" onclick="signIn(this)"><i></i>未签到</button>
                                <#--<button class="YSign"><i></i>已签到</button>-->
                            </div>

                        </div>
                        <div class="db_user_content">
                            <div class="db_user_con">
                                <div class="db_userImg">
                                    <#if (USER_INFO.face)?exists>
                                        <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="picLeft">
                                    <#else>
                                        <img src="${base}/assets/images/wx_new1.jpg" alt="">
                                    </#if>
                                    <#--<img src="${base}/assets/images/wx_new1.jpg" alt="">-->
                                </div>
                                <div class="db_userInfo">
                                    <div class="db_userName">
                                       <#if USER_INFO.name?? && USER_INFO.name?length gt 11>
                                       ${USER_INFO.name?substring(0,11)}...

                                       <#else>
                                           ${USER_INFO.name!}
                                       </#if>
                                        <i></i>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="db_userApi">

                                        API Key：<span id="apikeyStr">

                                     <#if USER_INFO.apiKey??>
                                         ${(USER_INFO.apiKey)!}
                                     <#else >
                                                 <button onclick="createApiKey()" style="background:transparent;color: #428bca;border: none">生成</button>
                                     </#if>
                                    </span>
                                    </div>
                                </div>

                                <div class="studyingBox">
                                    <div class="studyingCon">
                                        <div class="studyingCon_content">
                                            <ul>
                                                <li>
                                                    <div class="studyingStates" id="integralNum">0</div>
                                                    <div class="studyingName">积分</div>
                                                </li>
                                                <li>
                                                    <div class="studyingStates" id="stdTime">0</div>
                                                    <div class="studyingName">学习天数</div>
                                                </li>
                                                <li>
                                                    <div class="studyingStates" id="askNum">0</div>
                                                    <div class="studyingName">回答问题</div>
                                                </li>
                                                <li>
                                                    <div class="studyingStates" id="bonusNum">0</div>
                                                    <div class="studyingName">获得勋章</div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="db_user_info">
                            <div class="db_info_box">
                                <div class="db_info_list">
                                    <div class="db_list_header">
                                        <div class="title">
                                            <i></i>
                                            荣誉勋章
                                        </div>
                                        <div class="db_score_info">
                                            兑换说明 <i></i>
                                            <div class="db_scoreJs">
                                                <ul>
                                                    <li>
                                                        ●积分兑换为勋章后将从用户积分账户扣除，但不影响用户获得的等级称号。
                                                    </li>
                                                    <li>
                                                        ●兑换顺序：分子勋→原子勋→中子勋→质子勋→夸克勋，获得五个勋章后将能融合成一个“量子勋”。
                                                    </li>
                                                    <li>
                                                        ●所需积分：180→分子勋；380→原子勋；580→中子勋；780→质子勋；1080→夸克勋
                                                    </li>
                                                    <li>
                                                        ●量子勋：可直接兑换真实量子计算时间，该功能即将上线！
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="db_list_honor">
                                        <div class="honor_wall">
                                        <#--<img src="${base}/assets/images/EduImg/sideLine.png" >-->
                                            <ul class="honor_wall_list">
                                                <li class="honor_1" data-type="1" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/1_dark.png" >
                                                    <div>
                                                        <span class="honorName">分子勋</span>
                                                        <span class="blueColor">x<span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                                <li class="honor_2" data-type="2" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/2_dark.png">
                                                    <div>
                                                        <span class="honorName">原子勋</span>
                                                        <span class="blueColor">x<span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                                <li class="honor_3" data-type="3" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/3_dark.png">
                                                    <div>
                                                        <span class="honorName">中子勋</span>
                                                        <span class="blueColor">x<span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                                <li class="honor_4" data-type="4" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/4_dark.png" >
                                                    <div>
                                                        <span class="honorName">质子勋</span>
                                                        <span class="blueColor">x<span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                                <li class="honor_5" data-type="5" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/5_dark.png">
                                                    <div>
                                                        <span class="honorName">夸克勋</span>
                                                        <span class="blueColor">x<span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                                <li class="honor_6" data-type="6" data-state="dark" onclick="exchangeHonor(this)">
                                                    <img src="${base}/assets/images/EduImg/6_dark.png" alt="">
                                                    <div>
                                                        <span class="honorName">量子勋</span>
                                                        <span class="blueColor">x <span class="honor_num">0</span></span>
                                                    </div>
                                                </li>
                                            </ul>
                                            <div class="prompt_box">
                                                <div class="prompt_title">是否花费180积分兑换分子勋?</div>
                                                <div class="prompt_db">
                                                    <button id="sureExchange">确定</button>
                                                    <button id="cancelExchange">取消</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="db_info_list">
                                    <div class="db_list_header">
                                        <div class="title study">
                                            <i></i>
                                            学习记录
                                        </div>
                                    </div>
                                    <div class="db_list_study">
                                        <div class="clearfix"></div>
                                        <div class="det_record_con">
                                            <ul></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="db_info_list">
                                    <div class="db_list_header">
                                        <div class="title tl">
                                            <i></i>
                                            讨论交流
                                        </div>
                                    </div>
                                    <div class="db_list_qaa">
                                        <div class="clearfix"></div>
                                        <div class="qaa_tab_box">
                                            <ul>
                                                <li class="left active" data-type="1">
                                                    <a href="javascript:void(0)">我的问题</a>
                                                </li>
                                                <li class="right" data-type="0">
                                                    <a href="javascript:void(0)">我的回答</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="discuss_right">
                                            <ul>
                                                <li></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="medal_con" style="overflow-y: auto">
                <div class="medalBg" style="position: fixed"></div>
                <div class="medal_container">
                    <div class="medal_box">
                        <div class="medal_top_box">
                            <div class="medal_img">
                                <img src="/assets/images/EduImg/MOH1.png" alt="">
                            </div>
                            <div class="medal_Name">
                                <span>分子勋</span>
                            </div>
                            <div class="medal_info">“量子的世界里，只要没人在看，<br />任何事情都会发生！”</div>
                        </div>

                        <div class="medal_user">
                            <div class="medal_user_left">
                                <img src="/assets/images/EduImg/qcodeHd.png" alt="">
                                <div style="clear: both"></div>
                                <span>扫描了解详情</span>
                            </div>
                            <div class="medal_user_right">
                                <div class="medal_right_name"><#if USER_INFO.name?? && USER_INFO.name?length gt 8>
                                <#--${USER_INFO.name?substring(0,8)}...-->${USER_INFO.name!}<#else>${USER_INFO.name!}</#if></div>
                                <div class="medal_right_js">Ta已累计获得3个勋章，<br>
                                    集满5个将解锁量子计算机<br>可用机时！</div>
                                <div class="medal_right_img"><img src="/assets/images/EduImg/medal_right_img.png" alt=""></div>
                            </div>
                        </div>

                    </div>
                    <div class="clearfix"></div>
                    <div class="medalShare">
                        <div class="share_box">
                            <ul>
                                <li class="v_share_name"><span>分享：</span></li>
                                <li class="share_copy" data-tag="share_1"><a data-id="1" href="javascript:void(0)" class="copeCode" title="复制网址"><textarea style="opacity: 0;">http://localhost/m/mVideo.html</textarea></a></li>
                                <li class="share_qq bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553763306712"><a data-id="1" href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a></li>
                                <li class="share_zone bdsharebuttonbox bdshare-button-style0-16" data-tag="share_1" data-bd-bind="1553763306712"><a data-id="1" href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"></a></li>
                                <li class="share_sina bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1553763306712"><a data-id="1" href="javascript:void(0)" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a></li>

                            </ul>
                        </div>

                    </div>
                    <div class="medal_box_close">
                        <img src="${base}/assets/images/EduImg/setUp_close.png" alt="" class="close_updBox">
                    </div>
                </div>
            </div>
        </div>
    </div>

    </#escape>
</@main.body>
<@main.mfooter>
<#--edit start-->
    <script type='text/javascript' src="${base}/assets/js/md5.js"></script>
    <script>
        function createApiKey(){
            $.post("${base}/MobileQcode/createKey.json",{},function (r) {
                $("#apikeyStr").text(r.obj)
            })
        }
        $('.db_score_info i').on('tap',function (e) {
            $('.db_scoreJs').show()
            e.stopPropagation()

        });
        $('.medal_box_close').on('click',function () {
            $('.medal_con').hide()
        })
        var JfScore=0;
        var medalInfoArr =[
            ["“量子的世界里，只要没人在看，<br />任何事情都会发生！"],
            ["“越过经典计算的边界，开启<br />量子计算的未来。”"],
            ["“有人说世上没人懂得量子计算，这个断言<br />想来并不适合你。”"],
            ["“如果你还没被量子计算震惊，说明<br />你还没有为它着迷。”"],
            ["“未来有什么我不知道，但我知道<br />未来肯定有量子计算!”"],
            ["“下一站，量子计算机！”"]
        ]
        var initHtml='<li class="honor_1" data-type="1" data-state="dark" onclick="exchangeHonor(this)">\n' +
                '    <img src="${base}/assets/images/EduImg/1_dark.png" >\n' +
                '    <div>\n' +
                '        <span class="honorName">分子勋</span><span class="blueColor">x<span class="honor_num">0</span></span>\n' +
                '    </div>\n' +
                '</li>\n' +
                '<li class="honor_2" data-type="2" data-state="dark" onclick="exchangeHonor(this)">\n' +
                '    <img src="${base}/assets/images/EduImg/2_dark.png">\n' +
                '    <div>\n' +
                '        <span class="honorName">原子勋</span><span class="blueColor">x<span class="honor_num">0</span></span>\n' +
                '    </div>\n' +
                '</li>\n' +
                '<li class="honor_3" data-type="3" data-state="dark" onclick="exchangeHonor(this)">\n' +
                '    <img src="${base}/assets/images/EduImg/3_dark.png">\n' +
                '    <div>\n' +
                '        <span class="honorName">中子勋</span><span class="blueColor">x<span class="honor_num">0</span></span>\n' +
                '    </div>\n' +
                '</li>\n' +
                '<li class="honor_4" data-type="4" data-state="dark" onclick="exchangeHonor(this)">\n' +
                '    <img src="${base}/assets/images/EduImg/4_dark.png" >\n' +
                '    <div>\n' +
                '        <span class="honorName">质子勋</span><span class="blueColor">x<span class="honor_num">0</span></span>\n' +
                '    </div>\n' +
                '</li>\n' +
                '<li class="honor_5" data-type="5" data-state="dark" onclick="exchangeHonor(this)">\n' +
                '    <img src="${base}/assets/images/EduImg/5_dark.png">\n' +
                '    <div>\n' +
                '        <span class="honorName">夸克勋</span><span class="blueColor">x<span class="honor_num">0</span></span>\n' +
                '    </div>\n' +
                '</li>';
        var self = null;
        function getScore(score){
            $('.honor_1').attr({'data-state':'available','changed':'false'});
            if(score>=180){
                $('.honor_1 img').attr('src','${base}/assets/images/EduImg/1_available.png');
            }
            if(score>=380){
                $('.honor_2').attr('data-state','available');
            }
            if(score>=580){
                $('.honor_3').attr('data-state','available');
            }
            if(score>=780){
                $('.honor_4').attr('data-state','available');
            }
            if(score>=1080){
                $('.honor_5').attr('data-state','available');
                $('.honor_6').attr('data-state','available');
            }
        }
        function exchangeHonor(ele){
            self = ele;
            var dataType = Number($(ele).attr('data-type'));
            //判断是否已到兑换:是？显示卡片：显示兑换弹框
            if($(ele).attr("changed") == "true"){
                alertMedalCon(dataType,false)
            }else {
                switch (dataType) {
                    case 1:
                        $('.prompt_title').text('是否花费180积分兑换分子勋?')
                        break;
                    case 2:
                        $('.prompt_title').text('是否花费380积分兑换原子勋?')
                        break;
                    case 3:
                        $('.prompt_title').text('是否花费580积分兑换中子勋?')
                        break;
                    case 4:
                        $('.prompt_title').text('是否花费780积分兑换质子勋?')
                        break;
                    case 5:
                        $('.prompt_title').text('是否花费1080积分兑换夸克勋?')
                        break;
                    case 6:
                        $('.prompt_title').text('是否立即合成？')
                        break;
                }
                $('.prompt_box').show();
            }
        }
        $('#cancelExchange').on('click',function () {
            $('.prompt_box').hide()
        });
        $('#sureExchange').on('click',function () {
            var state = $(self).attr('data-state');
            var dataType = Number($(self).attr('data-type'));
            //判断是否是可兑换状态
            if(state == 'available'&&$(self).attr('changed')=='false') {
                showHonor(state,dataType);
                $('.prompt_box').hide()
            }else {
                layer.msg("兑换失败（积分不足或者没有解锁上一个勋章）");
            }

        });
        var dataType2=1;
        //兑换并弹出分享兑换
        function showHonor(state,dataType){
            var url = "";
            if($(self).attr("data-type") != 6) {
                url = "${base}/UpdateUserScore/exchangeMedal.json";
            }else {
                url = "${base}/UpdateUserScore/compoundBonus.json";
            }
            dataType2 = dataType
            $.post(url,{"type":$(self).attr("data-type")},
                    function(result) {
                        if(!result.success&&result.responseData==undefined){
                            layer.msg(result.message);
                            return false;
                        }
                        if(result.success || result.responseData.success) {
                            $(self).attr('changed','true');
                            $(self).next().attr('changed','false');
                            $(self).find('img').attr('src','${base}/assets/images/EduImg/'+dataType+'_bright.png');
                            $(self).find('.honor_num').text(Number($(self).find('.honor_num').text())+1);
                            if(Number($('#integralNum').text())-(180+(dataType-1)*200)>(180+(dataType-1)*200)){
                                $(self).next().find('img').attr('src','${base}/assets/images/EduImg/'+(dataType+1)+'_available.png');
                            }
                            var medalCount=Number($(".honor_6").find(".honor_num").text());
                            if(isNaN(medalCount)){
                                medalCount=0;
                            }
                            alertMedalCon(dataType,true)
                            getUserInfo();
                            getAnswerBonusNum();
                        }else {
                            layer.msg(result.responseData.message)
                        }
                    }
            )
        }
        $(".qaa_tab_box ul li").on('click',function () {
            $(this).addClass("active").siblings().removeClass("active");
            myAnswerAndAsk($(this).attr("data-type"));
        })
        //弹出卡片
        function alertMedalCon(dataType,flag) {
            $('.medal_info').html(medalInfoArr[dataType-1])
            $('.medal_right_js').html('TA本轮已累计获得'+(dataType)+'个，<br />集满5个将解锁量子计算机<br />可用机时！');
            $('.medal_img img').attr('src','${base}/assets/images/EduImg/'+dataType+'_bright.png');
            $('.medal_Name span').text($(self).find('.honorName').text())
            $('.medal_img').addClass("img"+dataType)
            $('.medal_con').show();
            if(dataType==6){
                $('.medal_right_js').html('TA本轮已累计获得5个，<br />集满5个将解锁量子计算机<br />可用机时！');
                $('.medal_box').css({
                    'background':'url(../../assets/mobile/images/dbShareBg1.png) no-repeat',
                    'backgroundSize':'100% 100%'
                })
                var dataType6Html =$('<div></div>').append($(self).clone()).html();
                if(flag){
                    $('.honor_wall_list').html(initHtml+dataType6Html);
                }
                var honnorNum=Number( $(".honor_num").eq(5).text())
                $(".honor_num").html("0");
                $(".honor_num").eq(5).html(honnorNum);
                flag = true;
            }else {
                $('.medal_box').css({
                    'background':'url(../../assets/mobile/images/dbShareBg2.png) no-repeat',
                    'backgroundSize':'100% 100%'
                })
            }
        }
        $(function() {
            getAnswerBonusNum();
            myAnswerAndAsk(1);
            // getUserInfo();
        })

        function myAnswerAndAsk(isAsk) {
            var html = "";
            $(".discuss_right").find("ul").empty();

            $.post("${base}/EduTutorial/askAndanswer.json",{"flag":isAsk},
                    function(result) {
                        if(isAsk == 1){
                            if(result== false){
                                html = "<li class='none_discuss'>   您还没有提问过，快去学习页面提问吧。<br />~偷偷告诉你学习和提问都可以获得积分哦^_^~~</li>"
                            }
                        }else {
                            if(result== false){
                                html = "<li class='none_discuss'>您还没有回答过相关问题,请前往课程学习页面选择回答问题。~偷偷告诉你优质回答可以获得积分哦^_^~</li>"
                            }
                        }

                        $.each(result,function(i,item) {
                            var replyPagNum = getPagerNumById(item.id,item.forumTopicId);
                            html += "<li><div class=\"discuss_title\">\n";
                            if(isAsk == 1) {
                                html += "<a href='${base}/m/mVideo.html?link="+getStringByNum(item.forumTopicId)+"&point="+item.id+"&pagNum="+replyPagNum+"'><span>"+(i+1)+".问："+item.content+"</span></a>\n";
                            }else {
                                html += "<a href='${base}/m/mVideo.html?link="+getStringByNum(item.forumTopicId)+"&point="+item.id+"&pagNum="+replyPagNum+"'><span>"+(i+1)+".答："+item.content+"</span></a>\n";
                            }
                            html += "</div><div class=\"discuss_list_con\"><p>"+item.repdContent+"</p></div></li>";
                        })
                        $(".discuss_right").find("ul").html(html);
                    }
            )
        }

        function getAnswerBonusNum() {
            $.post("${base}/UserInfo/getAnswerNum.json",{},
                    function(result) {
                        if(result) {
                            $("#askNum").html(result.myasknum);
                            $("#bonusNum").html(result.bonusnum);
                            $("#stdTime").html(result.stdtime);
                        }
                    }
            )
        }




        function getStringByNum(num) {
            var a = num.toString().substring(0,1);
            var b = num.toString().substring(1);
            return a+"_"+b;
        }


        //根据id查询页面
        function getPagerNumById(replyId,videoId) {
            var replyPagNum = 0;
            $.ajaxSettings.async = false;
            $.post("${base}/EduTutorial/getPagerNumById.json",
                    {
                        "replyId":replyId,
                        "videoId":videoId
                    },
                    function (result) {
                        if(result) {
                            replyPagNum = result;
                        }
                    }
            )
            $.ajaxSettings.async = true;
            return replyPagNum;
        }
    </script>

<#--分享-->
    <script>
        var share_title;
        var baseInfo = "${base}/assets/js/"
        function setShareConfig(id,config){
            if(id=="tsina"){
                config.bdText='本源量子计算教育系列课程'+"    "+shareLink+"/EDU/index.html"
            }else if(id=="weixin"){
                if(dataType2==""||dataType2==undefined){
                    dataType2="1"
                }
                config.bdText = '本源量子计算教育系列课程';
                config.bdUrl = shareLink+"/EDU/Share/Bonus/"+${USER_INFO.id!}+"?Hid="+dataType2;
            }else {
                config.bdText = '本源量子计算教育系列课程';
                config.bdUrl=shareLink+"/EDU/index.html";
            }
            return config;
        }

        window._bd_share_config={
            common : {
                bdText : '本源量子计算教育系列课程',
                bdDesc : '本源量子计算教育系列课程，包含详细的量子计算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。',
                bdUrl :  shareLink+"/EDU/index.html",
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
</@main.mfooter>