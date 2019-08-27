<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html></#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
        <div class="contentBox" style="padding: 0">
            <style>
                body{
                    background-color: #f7f7f7;
                }
            </style>
            <link rel="stylesheet" href="${base}/assets/css/public.css">
            <!--top-->
            <div class="content" style="min-width:1200px;">
                <@main.top5>
                    <#escape x as x?html></#escape>
                </@main.top5>
                <style>


                </style>
                <div class="bannerOrSwiper">
                    <div class="dashboardBg"></div>
                    <div class="dashboard">
                        <div class="dashboard-box">
                            <div class="dashboardTop">
                                <div class="dash_header">
                                    <ul>
                                        <li><span>当前位置：</span></li>
                                        <li><a href="${base}/EDU/index.html">首页&nbsp;> </a></li>
                                        <li><a href="${base}/EDU/dashboard.html">&nbsp; 个人中心</a></li>
                                    </ul>
                                </div>
                                <div class="personal-box">
                                    <div class="personal-portrait">
                                        <#if (USER_INFO.face)?exists>
                                            <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="">
                                        <#else>
                                            <img src="${base}/assets/images/wx_new1.jpg" alt="">
                                        </#if></div>
                                    <div class="personal-info">
                                        <div class="personal-name">
                                            <div class="personalName"><#if USER_INFO.name?? && USER_INFO.name?length gt 8>
                                                <#--${USER_INFO.name?substring(0,8)}...-->
                                                    ${USER_INFO.name!}
                                                <#else>
                                                    ${USER_INFO.name!}
                                                </#if></div>
                                            <style>

                                            </style>
                                            <span class="personal-designation">
                                                 <span id="grzxdj">量子剑心</span>
                                                <div class="designation-info">
                                                <div class="designation-info-title">积分等级成长体系</div>
                                                <div class="designation-info-box">
                                                <i></i>
                                                <span class="designation-bj-start"></span>
                                                <span class="designation-bj-end"><i></i></span>
                                                <ul>
                                                <li class="level1 active">
                                                <em></em>
                                                <span>量子</br>浪客</span>
                                                </li>
                                                <li class="level2 active">
                                                <em></em>
                                                <span>量子</br>剑心</span>
                                                </li>
                                                <li class="level3">
                                                <em></em>
                                                <span>量子</br>名士</span>
                                                </li>
                                                <li class="level4">
                                                <em></em>
                                                <span>量子</br>大师</span>
                                                </li>
                                                <li class="level5">
                                                <em></em>
                                                <span>量子</br>巨匠</span>
                                                </li>
                                                <li class="level6">
                                                <em></em>
                                                <span>量子</br>传奇</span>
                                                </li>
                                                </ul>
                                                </div>
                                                </div>
                                            </span>
                                        </div>
                                        <div class="apikey-box">
                                            <div class="apikey-name">API Key：</div>
                                            <span class="apikey-str" id="apikeyStr">

                                                <#if USER_INFO.apiKey??>
                                                    ${(USER_INFO.apiKey)!}
                                                    <#else >
                                                 <button onclick="createApiKey()" style="background:transparent;color: #428bca;border: none">生成</button>
                                                </#if>

                                            </span>
                                        </div>
                                        <div class="integral-box">
                                            <div class="integral-name">积分：</div>
                                            <span class="integral-num" id="integralNum"></span>
                                        </div>
                                    </div>
                                    <div class="signIn-info">
                                        <#if USER_INFO.signIn gt 0>
                                            <div class="sign-box active">
                                                <button class="registered active">已签到</button>
                                                <span class="signTrue active">已获10积分</span>
                                            </div>
                                        <#else>
                                            <div class="sign-box">
                                                <button class="NoSignIn" onclick="_hmt.push(['_trackEvent','sign']);signIn(this)" >未签到</button>
                                                <span class="signFalse">可得10积分</span>
                                            </div>
                                        </#if>

                                        <div class="toSetBox">
                                            <a href="${base}/EDU/personal.html">修改个人信息</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="dashboardContent">
                                <div class="dash_con_box">
                                    <div class="dash_con_list">
                                        <div class="dash_details">
                                            <div class="dash_det_header">
                                                <h2>个人数据</h2>
                                            </div>
                                            <div class="dash_det_con">
                                                <ul>
                                                    <li>
                                                        <div class="dash_li_box">
                                                            <i></i>
                                                            <div class="pre_title">
                                                                <div style="float:left;">学习天数</div>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                            </div>
                                                            <div class="learningTime" id="stdTime"></div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="dash_li_box">
                                                            <i class="problemI"></i>
                                                            <div class="pre_title">
                                                                <div style="float:left;">回答问题</div>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                            </div>
                                                            <div class="learningTime" id="askNum"></div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="dash_li_box">
                                                            <i class="getI"></i>
                                                            <div class="pre_title xz">
                                                                <div style="float:left;">获得勋章</div>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                                <span></span>
                                                            </div>
                                                            <div class="learningTime" id="bonusNum"></div>
                                                        </div>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                        <div class="dash_details" style="margin-top: 30px">
                                            <div class="dash_det_header honor">
                                                <h2>荣誉勋章</h2>
                                                <span class="explai_text">兑换说明</span>
                                                <span class="pro">
                                                 <div class="honor_explain">
                                                    <p>
                                                        ●积分兑换为勋章后将从用户积分账户扣除，但不影响用户获得的等级称号。
                                                    </p>
                                                    <p>
                                                       ●兑换顺序：分子勋→原子勋→中子勋→质子勋→夸克勋，获得五个勋章后将能融合成一个“量子勋”。
                                                    </p>
                                                     <p>
                                                         ●所需积分：180→分子勋；380→原子勋；580→中子勋；780→质子勋；1080→夸克勋
                                                     </p>
                                                     <p>
                                                         ●量子勋：可直接兑换真实量子计算时间，该功能即将上线！
                                                     </p>
                                                </div>
                                            </span>
                                            </div>
                                            <div class="dash_det_con honor_con">
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
                                                        <div>
                                                            <button id="sureExchange">确定</button>
                                                            <button id="cancelExchange">取消</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="dash_con_list">
                                        <div class="dash_details even">
                                            <div class="dash_det_header">
                                                <h2>学习记录</h2>
                                            </div>
                                            <div class="dash_det_con dash_det_record">
                                                <div class="det_record_con">
                                                    <ul>
                                                        <li>
                                                            <div class="record_img"><img src="${base}/assets/images/EduImg/learnRecord.png" alt=""></div>
                                                            <div class="det_record_js">
                                                                <div class="det_record_link">
                                                                    <a href="${base}/EDU/video.html">量子计算入门基础——量子计算介绍</a>
                                                                </div>
                                                                <div class="det_record_link">
                                                                    <span>5天前</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="record_img"><img src="${base}/assets/images/EduImg/learnRecord.png" alt=""></div>
                                                            <div class="det_record_js">
                                                                <div class="det_record_link">
                                                                    <a href="${base}/EDU/video.html">量子计算入门基础——量子计算介绍</a>
                                                                </div>
                                                                <div class="det_record_link">
                                                                    <span>5天前</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="record_img"><img src="${base}/assets/images/EduImg/learnRecord.png" alt=""></div>
                                                            <div class="det_record_js">
                                                                <div class="det_record_link">
                                                                    <a href="${base}/EDU/video.html">量子计算入门基础——量子计算介绍</a>
                                                                </div>
                                                                <div class="det_record_link">
                                                                    <span>5天前</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="dash_details even" style="margin-top: 30px">
                                            <div class="dash_det_header">
                                                <h2>讨论交流</h2>
                                            </div>
                                            <div class="dash_det_con discuss_con">
                                                <div class="discuss_left">
                                                    <ul>
                                                        <li class="active" data-type="1">
                                                            <span>我的问题</span>
                                                        </li>
                                                        <li data-type="0">
                                                            <span>我的回答</span>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="discuss_right">
                                                    <ul>
                                                        <li>
                                                            <div class="discuss_title">
                                                                <span>1.答：我的回答。</span>
                                                            </div>
                                                            <div class="discuss_list_con">
                                                                <p>“问题”</p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="discuss_title">
                                                                <span>1.答：我的回答。</span>
                                                            </div>
                                                            <div class="discuss_list_con">
                                                                <p>“问题”</p>
                                                            </div>
                                                        </li>
                                                        <li>
                                                            <div class="discuss_title">
                                                                <span>1.答：我的回答。</span>
                                                            </div>
                                                            <div class="discuss_list_con">
                                                                <p>“问题”</p>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="medal_con">
                        <div class="medalBg"></div>
                        <div class="medal_container">
                            <div class="medal_box">
                                <div class="medal_img">
                                    <img src="${base}/assets/images/EduImg/MOH1.png" alt="">
                                </div>
                                <div class="medal_Name">
                                    <span>分子勋</span>
                                </div>
                                <div class="medal_info">“量子的世界里，只要没人在看，任何事情都会发生！”</div>
                                <div class="medal_user">
                                    <div class="medal_user_left">
                                        <img src="${base}/assets/images/EduImg/qcodeHd.png" alt="">
                                        <div style="clear: both"></div>
                                        <span>扫描了解详情</span>
                                    </div>
                                    <div class="medal_user_right">
                                        <div class="medal_right_name"><#if USER_INFO.name?? && USER_INFO.name?length gt 8>
                                            <#--${USER_INFO.name?substring(0,8)}...-->${USER_INFO.name!}<#else>${USER_INFO.name!}</#if></div>
                                        <div class="medal_right_js">Ta已累计获得3个勋章，<br />
                                            集满5个将解锁量子计算机<br />可用机时！</div>
                                        <div class="medal_right_img"><img src="${base}/assets/images/EduImg/medal_right_img.png" alt=""></div>
                                    </div>
                                </div>
                                <div class="medalShare">
                                    <div class="medalShareBox">
                                        <ul>
                                            <li class="shareTitle"><span>分享到：</span></li>
                                            <li class="shareWchat bdsharebuttonbox"><a href="javascript:void(0)" class="bds_weixin" data-cmd="weixin" title="分享到微信"><img class="bds_weixin" data-cmd="weixin" src="${base}/assets/images/EduImg/Wchat.png" alt="分享至QQ"></a></li>
                                            <li class="shareQQ bdsharebuttonbox"><a href="javascript:void(0)" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"><img class="bds_sqq" data-cmd="sqq"  src="${base}/assets/images/EduImg/QQ.png" alt=""></a></li>
                                            <li class="shareQZone bdsharebuttonbox"><a href="javascript:void(0)" class="bds_tqq" data-cmd="qzone" title="分享到QQ空间"><img class="bds_tqq" data-cmd="qzone" src="${base}/assets/images/EduImg/QZone.png" alt=""></a></li>
                                            <li class="shareSina bdsharebuttonbox"><a href="javascript:void(0)" class="bds_tsina" data-cmd="tsina"><img class="bds_tsina" data-cmd="tsina" src="${base}/assets/images/EduImg/Sina.png" alt=""></a></li>
                                        </ul>
                                    </div>

                                </div>
                                <div class="medal_box_close"></div>
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
    <script>
        function createApiKey(){
            $.post("${base}/QCode/createKey.json",{},function (r) {
                // console.log(r);
                $("#apikeyStr").text(r.obj)
            })
        }
        $('.medal_box_close').on('click',function () {
            $('.medal_con').hide()
        })
        var JfScore=0;
        var medalInfoArr =[
            ["“量子的世界里，只要没人在看，</br>任何事情都会发生！"],
            ["“越过经典计算的边界，开启</br>量子计算的未来。”"],
            ["“有人说世上没人懂得量子计算，这个断言</br>想来并不适合你。”"],
            ["“如果你还没被量子计算震惊，说明</br>你还没有为它着迷。”"],
            ["“未来有什么我不知道，但我知道</br>未来肯定有量子计算!”"],
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
            '   </div>\n' +
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
        var self =null;
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
            if($(ele).attr("data-state") == "available" && $(ele).attr("changed") == "true"){
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
        //关闭兑换弹框
        $('#cancelExchange').on('click',function () {
            $('.prompt_box').hide()
        });
        //确定兑换
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
            if(dataType != 6) {
                url = "${base}/UpdateUserScore/exchangeMedal.json";
            }else {
                url = "${base}/UpdateUserScore/compoundBonus.json";
            }
            dataType2 = dataType
            $.post(url,{"type":dataType},
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
        $(".discuss_left ul li").on('click',function () {
            $(this).addClass("active").siblings().removeClass("active");
            myAnswerAndAsk($(this).attr("data-type"));
        })

        $(function() {
            getAnswerBonusNum();
            myAnswerAndAsk(1);
            // getUserInfo();
        })
        //弹出卡片
        function alertMedalCon(dataType,flag) {
            $('.medal_info').html(medalInfoArr[dataType-1])
            $('.medal_right_js').html('TA本轮已累计获得'+(dataType)+'个，<br />集满5个将解锁量子计算机<br />可用机时！');
            $('.medal_img img').attr('src','${base}/assets/images/EduImg/'+dataType+'_bright.png');
            $('.medal_Name span').text($(self).find('.honorName').text())
            $('.medal_con').show();
            if(dataType==6){
                $('.medal_right_js').html('TA本轮已累计获得5个，<br />集满5个将解锁量子计算机<br />可用机时！');
                $('.medal_box').css({
                    'background':'url(../../assets/images/EduImg/medalbg2.png) no-repeat',
                    'backgroundSize':'100% 100%'
                })
                var dataType6Html =$('<div></div>').append($(self).clone()).html();
                if(flag){
                    $('.honor_wall_list').html(initHtml+dataType6Html);
                }
                var honnorNum=Number( $(".honor_num").eq(5).text())
                $(".honor_num").html("0");
                $(".honor_num").eq(5).html(honnorNum);
            }else {
                $('.medal_box').css({
                    'background':'url(../../assets/images/EduImg/medalbg1.png) no-repeat',
                    'backgroundSize':'100% 100%'
                })
            }
        }

        function myAnswerAndAsk(isAsk) {
            var html = "";
            $(".discuss_right").find("ul").empty();

            $.post("${base}/EduTutorial/askAndanswer.json",{"flag":isAsk},
                function(result) {
                    if(isAsk == 1){
                        if(result== false){
                            html = "<li class='none_discuss'>您还没有提问过，快去学习页面提问吧。~偷偷告诉你学习和提问都可以获得积分哦^_^~</li>"
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
                            html += "<a href='${base}/EDU/video.html?link="+getStringByNum(item.forumTopicId)+"&point="+item.id+"&pagNum="+replyPagNum+"'><span>1.问："+item.content+"</span></a>\n";
                        }else {
                            html += "<a href='${base}/EDU/video.html?link="+getStringByNum(item.forumTopicId)+"&point="+item.id+"&pagNum="+replyPagNum+"'><span>1.答："+item.content+"</span></a>\n";
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
                    // console.log('getAnswerNum',result)
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
</@main.footer>