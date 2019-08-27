
<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<link rel="stylesheet" href="${base}/assets/css/font-awesome.min.css">
<link rel="stylesheet" href="${base}/assets/css/community.css?1.0">
<link rel="stylesheet" href="${base}/assets/css/swiper.css">
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
<div class="content" style="min-height:500px; min-width:1336px;">
    <!--top-->
        <@main.forumTop><#escape x as x?html></#escape></@main.forumTop>
    <style>
        .swiper-button-next{
            background: url("${base}/assets/forImg/bannerRight.png")!important;
            right: 0;
        }
        .swiper-button-prev{
            background: url("${base}/assets/forImg/bannerLeft.png")!important;
            left: 0;
        }
        .swiper-button-next,.swiper-button-prev{
            height: 80px;
            background-size: 100% 100%;
            width: 50px;
            opacity: 0.3;
        }
        .topSwiper:hover .swiper-button-white{
            opacity: 1;
        }
        .swiper-wrapper a{
            display: block;
        }
        .swiper-wrapper a:hover{
            opacity: 1!important;
        }
    </style>

    <#--帖子/简介栏-->
<div class="topicContent">
    <form method="post" id="searchForm" action="${base}/qcode/forumtopic/index.html" autocomplete="off">
        <input type="hidden" value="${content}" id="content" name="content">
        <div class="topicLeft">
            <div class="topSwiper">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><a href="https://qcode.qubitonline.cn/qcode/forumtopic/communitydetail.html?id=136&belonged=1"><img src="${base}/assets/forImg/banner1.jpg" alt=""></a></div>
                        <div class="swiper-slide"><a href="https://learn-quantum.com/EDU/index.html"><img src="${base}/assets/forImg/banner2.jpg" alt=""></a></div>
                        <div class="swiper-slide"><a href="https://qcode.qubitonline.cn/qcode/forumtopic/communitydetail.html?id=78&belonged="><img src="${base}/assets/forImg/banner3.jpg" alt=""></a></div>
                    </div>
                    <div class="swiper-button-next swiper-button-white"></div>
                    <div class="swiper-button-prev swiper-button-white"></div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>
            <div class="tzContent">
                <div class="tz_box">
                    <div class="tzDetailList">
                        <ul>
                    <#if pager?? && (pager.entityList)?size gt 0>
                    <#list pager.entityList as project>
                    <li class="community_detalis">
                        <div class="community_bt">
                        <#if (project.topicFace)?? && project.topicFace != "">
                            <div class="community_top">
                                <div class="cTop_left">
                                    <#if (project.topicFace)?? && project.topicFace != "">
                                        <div class="cTopImg">
                                            <img data-src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                        </div>
                                    </#if>
                                </div>
                                <div class="cTop_right cTop_right_special">
                                    <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belonged=${project.belonged}"><div class="title">${project.title!}</div></a>
                                    <div class="tag">
                                        <#if (project.labelList)?size gt 0>
                                            <#list project.labelList as labelList>
                                                <span >${labelList.label!}</span>
                                            </#list>
                                        </#if>
                                    </div>
                                    <div class="community_bottom">
                                        <div class="comm_publish">
                                            <div class="publ_left">
                                                <span class="publ_photo">
                                                    <#if (project.face)?? && project.face != "">
                                                        <img data-src="/${setting['files.contextpath']}${project.face!}" alt="">
                                                    <#else>
                                                        <img src="${base}/assets/forImg/Head.png" alt="">
                                                    </#if>
                                                </span>
                                                <span class="pulb_name">${project.userName!}</span>
                                                <span> 于 </span>
                                                <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                                <span>发布在</span>
                                                <span>[
                                                    <#--<#if (project.belonged)?? && project.belonged=="1">-->
                                                    <#--QPanda-->
                                                    <#--<#elseif (project.belonged)?? &&project.belonged=="3">-->
                                                    <#--量子课程-->
                                                    <#--<#elseif (project.belonged)?? &&project.belonged=="2">-->
                                                    <#--量子算法-->
                                                    <#--<#else >-->
                                                    <#--其他-->
                                                    <#--</#if>-->
                                                    ${project.blockName}
                                                    ]</span>
                                                <div style="clear:both;"></div>
                                            </div>
                                            <div class="publ_right">
                                                <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                                    <#if USER_INFO.belonged == project.belonged>
                                                        <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                                    </#if>
                                                </#if>
                                                <span class="publ_look">${project.seeCount!}</span>
                                                <span class="leaveWord">${project.replyCount!}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <#else>
                            <div class="community_top">
                                <div class="cTop_right">
                                    <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belongde=${project.belonged}"><div class="title">${project.title!}</div></a>
                                    <div class="tag">
                                        <#if (project.labelList)?size gt 0>
                                            <#list project.labelList as labelList>
                                                <span >${labelList.label!}</span>
                                            </#list>
                                        </#if>
                                    </div>
                                </div>
                                <div class="cTop_left">
                                    <#if (project.topicFace)?? && project.topicFace != "">
                                        <div class="cTopImg">
                                            <img data-src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                        </div>
                                    </#if>
                                </div>
                                <div style="clear: both"></div>
                            </div>
                            <div class="community_bottom">
                                <div class="comm_publish">
                                    <div class="publ_left">
                                        <span class="publ_photo">
                                            <#if (project.face)?? && project.face != "">
                                                <img data-src="/${setting['files.contextpath']}${project.face!}" alt="">
                                            <#else>
                                                <img src="${base}/assets/forImg/Head.png" alt="">
                                            </#if>
                                        </span>
                                        <span class="pulb_name">${project.userName!}</span>
                                        <span> 于 </span>
                                        <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                        <span>发布在</span>
                                        <span>
                                            [
                                                    <#--<#if (project.belonged)?? && project.belonged=="1">-->
                                                    <#--QPanda-->
                                                    <#--<#elseif (project.belonged)?? &&project.belonged=="3">-->
                                                    <#--量子课程-->
                                                    <#--<#elseif (project.belonged)?? &&project.belonged=="2">-->
                                                    <#--量子算法-->
                                                    <#--<#else >-->
                                                    <#--其他-->
                                                    <#--</#if>-->
                                        ${project.blockName}
                                            ]
                                        </span>
                                        <div style="clear:both;"></div>
                                    </div>
                                    <div class="publ_right">
                                        <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                            <#if USER_INFO.belonged == project.belonged>
                                                <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                            </#if>
                                        </#if>
                                        <span class="publ_look">${project.seeCount!}</span>
                                        <span class="leaveWord">${project.replyCount!}</span>
                                    </div>
                                </div>
                            </div>
                        </#if>
                        </div>
                    </li>
                    </#list>
                    </#if>
                        </ul>
                    </div>
                    <div class="fenye" style="width: 100%;">
                        <nav aria-label="Page navigation"
                             style="margin: 100px auto">
                    <@main.pagination pager=pager/>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="topicRight">
    <#--发布新帖-->
        <div class="topDeliver">
            <button onclick="saveForum()"></button>
        </div>
    <#--社区公告-->
        <div class="index_noticeBox">
            <div>社区公告</div>
            <ul>
                <li><i>1</i><a href="https://qcode.qubitonline.cn/qcode/forumtopic/communitydetail.html?id=24&belongde="><span>本源量子互动论坛隐私政策</span><span class="notice_time">2019-05-21</span></a></li>
            </ul>
        </div>
    <#--达人热帖-->
        <div class="topicReTie">
            <div class="eTitle" id="hotForum">
                <h1><img src="${base}/assets/forImg/hot.png" alt=""><span>达人热帖</span></h1>
            </div>
        </div>
        <div class="topicReTie"  style="padding-bottom: 50px">
            <div class="eTitle">
                <h1><img src="${base}/assets/forImg/Look.png" alt=""><span>最新看点</span></h1>
            </div>
            <div class="watchList">
                <ul>
                <#--<li class="watDetailsHaveImg">-->
                <#--<a href="https://mp.weixin.qq.com/s/db6xzhj-ic6XD_4xCjhh3w" target="_blank" class="watFont6"><i></i>合肥——青年眼中的大IP</a>-->
                <#--<div class="watShowImg"><img src="${base}/assets/images/wx_new1.jpg" alt=""></div>-->
                <#--</li>-->


                    <li class="watDetails active">
                        <a href="https://mp.weixin.qq.com/s/db6xzhj-ic6XD_4xCjhh3w" target="_blank"  class="watFont4"><i></i>合肥——青年眼中的大IP</a>
                        <div class="watShowImg"><img src="${base}/assets/images/wx_new1.jpg" alt=""></div>
                    </li>
                    <li class="watDetails">
                        <a href="https://mp.weixin.qq.com/s/iJ6wi2zgwE3ayueeFvTDnw" target="_blank"  class="watFont4"><i></i>【新品】国内首款量子软件开发包QPanda 2.0 升级发布!</a>
                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new2.jpg" alt=""></div>
                    </li>
                    <li class="watDetails">
                        <a href="https://mp.weixin.qq.com/s/8IQ1y0GLBCHM9wM0Dhsn-w" target="_blank"  class="watFont4"><i></i>中共安徽省委常委、统战部部长刘莉莅临本源量子考察调研</a>
                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new3.jpg" alt=""></div>
                    </li>
                    <li class="watDetails">
                        <a href="https://mp.weixin.qq.com/s/p6NCgCp9UjGSTaUUCEfdGw" target="_blank"  class="watFont4"><i></i>安徽省人大常委会副主任谢广祥莅临本源量子考察调研</a>
                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new4.jpg" alt=""></div>
                    </li>
                    <li class="watDetails">
                        <a href="https://mp.weixin.qq.com/s/InQjr466cQ_fArqtz3uDhA" target="_blank"  class="watFont4"><i></i>本源量子致力于中国量子计算产业上下游全面发展——暨合肥市高新区管委会主任宋道军莅临我公司调研…</a>
                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new5.jpg" alt=""></div>
                    </li>
                    <li class="watDetails">
                        <a href="https://mp.weixin.qq.com/s/UqxrCfdbMlsCvZdkXlZ61w" target="_blank"  class="watFont4"><i></i>本源量子计算云平台64位量子本源量子计算云平台64位量子…</a>
                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new6.jpg" alt=""></div>
                    </li>

                </ul>
            </div>
        </div>
    </div>
</div>
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/swiper.min.js"></script>
<script src="${base}/assets/js/wangEditor.js"></script>
<script>
    //；轮播图
    var swiper = new Swiper('.swiper-container', {
        navigation: {nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev'},
        autoplay: false,
        autoplay: {delay: 4500, disableOnInteraction: false},
        pagination: {el: '.swiper-pagination', clickable: true},
        slidesPerView: 1,
        paginationClickable: true,
        spaceBetween: 0,
        mousewheelControl: false,
        autoplayDisableOnInteraction: false,
        loop: true
    });

    $(".watchList li").hover(function () {
        $(this).addClass("active").siblings().removeClass("active")
    })

    $(".community_summary").each(function (i, s) {
        $(this).on("mouseenter", function () {
            if ($(this).html().replace(/(^\s+)|(\s+$)/g, "").length > 75) {
                $(this).css({"max-height": "62px"})
            }
        });
        $(this).on("mouseleave", function () {
            if ($(this).html().replace(/(^\s+)|(\s+$)/g, "").length > 75) {
                $(this).css({"max-height": "24px"})
            }
        })
    });


    $(".tzTab").on("mouseover",function () {
        $(this).find(".dropdown-tab").show();
    });

    $(".tzTab").on("mouseout",function () {
        $(this).find(".dropdown-tab").hide();
    });

    $(document).click(function(event){
        var _con = $('.tzTab');   // 设置目标区域
        if(!_con.is(event.target) && _con.has(event.target).length === 0){ // Mark 1
            //$('#divTop').slideUp('slow');   //滑动消失
            $('.dropdown-tab').hide();          //淡出消失
        }
    });
    //    弹框显示
    $("#comm_append").on("click", function () {
        $("#myModal2").modal('show');
    });
    //    发布主题
    $("#publish_btn").on("click", function () {
        //console.log($("#title").val())
        //console.log($(".w-e-text").html())
        if ($("#title").val() == '' || $("#title").val() == null) {
            errorMsg("请输入标题");
            return false;
        }
        if ($(".w-e-text").html() == '<p><br></p>') {
            errorMsg("请输入正文内容");
            return false;
        }
        $.post("${base}/qcode/forumtopic/addForumTopic.json", {
            title: $("#title").val(),
            content: $(".w-e-text").html(),
            topicFace:$("#topicFace").attr("src")
        }, function (result) {
//            console.log(result);
            window.location.reload()
        })

    });

    <#--if(${isApply}!=1){-->
    <#--$('#myModal').modal('show');-->
    <#--}-->
    var ak = 'Y5brUY2qCrIjpehmh0CEQ4THLsiyY1Ti';
    var map;
    var point;

    function onblur() {

    }


    var telRegex = /^1([35789]\d|4[57])\d{8}$/;
    var eamilRegex = /^([\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?)+$/;

    function subimitUserApply() {
        var name = $('#name').val();
        var phone = $('#phone').val();
        var email = $('#email').val();
        var vmType = $('#vmType  option:selected').val();
        var purpose = $('#purpose').val();
        var code = $('#captcha').val();
        if (name == '') {
            errorMsg(messages.name_not_null);
            return false;
        }

        if (phone == '') {
            errorMsg(messages.phone_not_null);
            return false;
        }
        if (!telRegex.test(phone)) {
            errorMsg(messages.phone_is_proper);
            return false;
        }

        if (email == '') {
            errorMsg(messages.email_not_null);
            return false;
        }
        if (!eamilRegex.test(email)) {
            errorMsg(messages.email_is_proper);
            return false;
        }
        if (vmType == 0) {
            errorMsg(messages.vmType_not_null);
            return false;
        }
        if (purpose == '') {
            errorMsg(messages.purpose_not_null);
            return false;
        }
        if (code == '') {
            errorMsg(messages.volidate_code_not_null);
            return false;
        }
        //   是否同意用户申请协议
        if (!$("input[type='checkbox']").is(':checked')) {
            errorMsg(messages.checkbox_is);
            return false;
        }
        var param = {};
        param.name = name;
        param.phone = phone;
        param.email = email;
        param.vmType = vmType;
        param.purpose = purpose;
        param.code = code;
        $('.btn').attr('disabled', true);
        $('.btn').text('请稍候......');
        //表单提交
        $.ajax({
            url: "${base}/QCode/userApply.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                $('.btn').attr('disabled', false);
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.apply_is_submit,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1500,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                window.location.reload(true);
                            }
                        }
                    });
                } else {
                    errorMsg(result.message);
                }
            },
            error: function () {
                errorMsg(messages.server_is_busy);
            }
        });

    }

    function queryList() {
        $('#searchForm').submit();
    }


    function uploadpic(obj) {
        run(obj, function (data) {
            $("#topicFace").attr("src",data);
        });
    }

    function run(input_file, get_data) {
        /*input_file：文件按钮对象*/
        /*get_data: 转换成功后执行的方法*/
        if (typeof (FileReader) === 'undefined') {
            alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
        } else {
            try {
                /*图片转Base64 核心代码*/
                var file = input_file.files[0];
                //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
                if (!/image\/\w+/.test(file.type)) {
                    alert("请确保文件为图像类型");
                    return false;
                }
                var reader = new FileReader();
                reader.onload = function () {
                    get_data(this.result);
                };
                reader.readAsDataURL(file);
            } catch (e) {
                alert('图片转Base64出错啦！' + e.toString())
            }
        }
    }

    function getForumList(obj,timeOrder,repTime,label) {
        var txt = $(obj).text();
        if(str(timeOrder)) {
            $("#timeOrder").html(txt);
            $("#timeOrderV").val(timeOrder);
        }
        if(str(repTime)) {
            $("#repTime").html(txt);
            $("#repTimeV").val(repTime);
        }
        if(str(label)) {
            $("#label").html(txt);
            $("#labelV").val(label);
        }

        $.ajax({
            url:"${base}/qcode/forumtopic/communityList.html",
            data:{
                timeOrder:$("#timeOrderV").val(),
                repTime:$("#repTimeV").val(),
                label:$("#labelV").val()
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $(".tzContent").empty();
                    $(".tzContent").html(data);
                }
            }
        })
    }

    <#--$(".searchBtn").on("click",function(){-->
    <#--$.ajax({-->
    <#--url:"${base}/qcode/forumtopic/communityList.html",-->
    <#--data:{-->
    <#--timeOrder:$("#timeOrderV").val(),-->
    <#--repTime:$("#repTimeV").val(),-->
    <#--label:$("#labelV").val(),-->
    <#--content:encodeURI($("#content").val()),-->
    <#--belonged:${belonged}-->
    <#--},-->
    <#--dataType:"html",-->
    <#--success:function(data) {-->
    <#--if(data) {-->
    <#--$(".fenye").remove();-->
    <#--$(".tzContent").empty();-->
    <#--$(".tzContent").html(data);-->
    <#--}-->
    <#--}-->
    <#--})-->
    <#--});-->

    //板块外搜索
    $('#searchContent').keypress(function (e) {
        if(e.keyCode==13){
            $("#globalSearch").click()
        }
    })
    $("#globalSearch").on("click",function(){
        var urldata = encodeURIComponent($("#searchContent").val());
        var url = "${base}/qcode/forumtopic/community.html?isOutSearch=1&&content="+urldata;
        window.open(url);
    });

    function hotForum() {
        $.ajax({
            url:"${base}/qcode/forumtopic/queryHot.html",
            dataType:"html",
            type:"post",
            success:function(data) {
                if(data) {
                    $("#hotForum").after(data);
                }
            }
        })
    }

    function saveForum() {
    <#if USER_INFO??>
        window.location.href = "${base}/qcode/forumtopic/communityPublish.html";
    <#else>
        viewLoginMin();
    </#if>

    }

    function str(obj) {
        var flag = false;
        if(obj != null && obj != 'undefined') {
            flag = true;
        }
        return flag;
    }

    $(function() {
    <#--if('${isOutSearch}' != "1") {-->
        hotForum();
        // }
    })

    function setTop(forumTopicId) {
        $.post("${base}/qcode/forumtopic/setTop.json",{
                    "forumTopicId":forumTopicId
                },
                function (data) {
                    alert("置顶成功");
                    window.location.reload();
                })
    }
    window.onload=function (ev) {
        positionFooter();
        initWebSocket('');
    }

</script>
</@main.footer>
