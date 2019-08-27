<@main.header title="帖子详情">
<link rel="stylesheet" href="${base}/assets/css/font-awesome.min.css">
<link rel="stylesheet" href="${base}/assets/css/community.css?1.0">
<style>

</style>
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <style>
        #bdshare_weixin_qrcode_dialog{
            min-height: 340px!important;
        }
    </style>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <!--top-->
        <@main.forumTopLevel>
            <#escape x as x?html>
            </#escape>
        </@main.forumTopLevel>
        <!--top end-->
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>

        <style>
            .loca_add{
                position: relative;
            }
            .tzCommenTid,.tzCommenUserId{
                display: none;
            }
            .reportBox{
                position: fixed;
                width: 100%;
                top: 0;
                height: 100%;
                background: #000;
                opacity:0.5;
            }

        </style>
    <#--帖子/简介栏-->
        <div class="topicContent" style="margin-top: 20px">
            <input type="hidden" id="forumUserId" value="${forumTopicVo.userId!}">
            <div class="topicLeft">
                <div class="tz-location">
                    <div class="loca_box">
                        <span class="loca_add">  <a href="${base}/qcode/forumtopic/community.html?belonged=${forumTopicVo.belonged}"> 帖子列表</a><<a href="javascript:;"> 帖子详情</a></span>
                    </div>
                </div>
                <div class="tzHeadBox">
                    <div class="tzHeadTitle">${forumTopicVo.title!}：</div>
                    <div class="tzHeadType">
                        更新于：<span class="tzHeadoldTime">${forumTopicVo.addTime?string("yyyy/MM/dd HH:mm")!}</span>
                        <span class="tzheadBorder"></span>
                        最新回复：<span class="tzHeadTime">${forumTopicVo.newReplyTime}</span>
                        <span class="tzheadBorder"></span>
                        <textarea hidden id="localhostUrl" ></textarea>
                        <a class="tzUrlCopy" onclick="softwhy()" style="cursor: pointer;">复制链接</a>
                        <#if USER_INFO??>
                            <#if USER_INFO.id == forumTopicVo.userId>
                                <a onclick="delForum(${forumTopicVo.id!})" style="cursor: pointer;" title="删除全贴">删除</a>
                            <#else>
                                <#if USER_INFO.isModerator?? && USER_INFO.belonged??>
                                    <#if USER_INFO.belonged == forumTopicVo.belonged>
                                        <a onclick="delForum(${forumTopicVo.id!})" style="cursor: pointer;" title="删除全贴">删除</a>
                                    </#if>
                                </#if>
                            </#if>
                        </#if>
                    </div>
                </div>
                <div class="tzBrowse ">
                    <div class="tzBroBox">
                        <span class="tzBroNum">阅读 <span>${forumTopicVo.seeCount!}</span></span>
                        <span class="tzBroComm"><p>.</p><span>收藏 ${forumTopicVo.collectCount!}</span></span>
                        <span class="tzBroComm"> <p>.</p><span>评论 ${forumTopicVo.replyCount!}</span></span>
                        <span class="tzBrofino tzBroComm"><p>.</p><span>分享 ${forumTopicVo.sharCount!}</span></span>
                        <#if (forumTopicVo.isApproval &lt; 1)!>
                            <span><a href="javascript:" class="tzBroDianzan" onclick="updReplyLike(this)"><i></i></a></span>
                        <#else>
                            <span><a href="javascript:" class="tzBroDianzan active" onclick="updReplyLike(this)"><i></i></a></span>
                        </#if>
                        <#if (forumTopicVo.isCollect &lt; 1)!>
                            <span><a href="javascript:" class="tzBroSc" onclick="updCollect(this)"><i></i></a></span>
                        <#else>
                            <span><a href="javascript:" class="tzBroSc active" onclick="updCollect(this)"><i></i></a></span>
                        </#if>

                        <span><a href="javascript:" class="tzBroFx" onmouseover="changefx('',
                                '','','')" onmouseout="hid()"
                                 id="fenxiang"><i></i></a></span>


                        <div class="bdsharebuttonbox" style="" data-tag="share_1" id="av" onmouseout="addfx()" onmouseover="showfx()">
                            <p><a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友" >QQ好友</a></p>
                            <p><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信" >微信</a></p>
                            <p><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博">新浪微博</a></p>
                            <p><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间">QQ空间</a></p>
                        </div>

                    </div>
                </div>

                <div class="tzContent">
                    <p style="text-align: center">
                        <#if (forumTopicVo.topicFace??) && forumTopicVo.topicFace !=''>
                            <img src="/${setting['files.contextpath']}${forumTopicVo.topicFace!}"/>
                        </#if>
                    </p>

                    <#noescape>${forumTopicVo.content!} </#noescape>
                </div>

                <div class="tzTime">
                    <span>${forumTopicVo.addTime?string("yyyy/MM/dd HH:mm")!}</span>
                </div>
                <div class="tzToReport">
                    <a href="javascript:" onclick="ReportBtn(0)">举报</a>
                </div>

                <div class="tzCommentContent" style="padding-top: 10px">
                    <div class="tzCommHead">全部评论</div>
                    <div class="tzCommentBox">
                    </div>

                    <div class="thread-reply">
                        <ul data-v-82963a40="" class="ft paginationNew clearfix"><!----></ul>
                    </div>

                    <div class="tzCommentReplyBox">
                        <div class="reviewArea clearfix">
                            <textarea class="content comment-input" id="contentbox"
                                      placeholder="请输入评论内容&hellip;" onkeyup="keyUP(this)"
                                      style="min-height: 80px;height: 80px;"></textarea>
                            <a href="javascript:" class="plBtn">发表</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="topicRight">
            <#--发布人详情-->
                <div class="userRigth" style="border-bottom: 1px solid #e6e6e6">
                    <div class="userBox">
                        <div class="userPoster clearfix">
                            <div class="posterImg">
<#--                                <img src="${base}/assets/forImg/Head.png" alt="" id="forumFace">-->
                            </div>
                            <div class="posterNature">
                                <div class="posterName"><p id="forumName"></p> <#if !(USER_INFO)?exists || USER_INFO.id != forumTopicVo.userId><a href="javascript:" id="focus">关注</a></#if></div>
                                <div class="posterHot">
                                    <div class="hotHz">
                                        <p class="hotNum" id="fs">2</p>
                                        <p class="hotName">粉丝</p>
                                    </div>
                                    <div class="hotHz">
                                        <p class="hotNum" id="sc">3</p>
                                        <p class="hotName">被收藏</p>
                                    </div>
                                    <div class="hotHz border-none">
                                        <p class="hotNum" id="tj">4</p>
                                        <p class="hotName">被推荐</p>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            <#--达人热帖-->
                <div class="topicReTie">
                    <div class="eTitle" id="hotForum">
                        <h1><img src="${base}/assets/forImg/hot.png" alt=""><span>达人热帖</span></h1>
                    </div>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>


        <!--box end-->
    </div>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myprport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true">
        <div class="modal-dialog" style="width: 443px">
            <div class="modal-content" style="width: 443px;height: 630px;border-radius: 0;box-shadow: none;border: none;background: transparent;">
                <div class="tzDialogBox">
                    <div class="tzDialogContent">
                        <div class="tzDialogHead">
                            <div class="diaHeadLeft"><img src="${base}/assets/forImg/report.png" alt=""></div>
                            <div class="diaHeadright"><img class="tz-close" src="${base}/assets/forImg/reportClose.png" alt=""></div>
                            <div class="diaHeadBt">举报</div>
                        </div>
                        <div class="tzDialogContentLast">
                            <div class="title">请选择举报理由</div>
                            <div class="tzDiaLog-Line">
                                <div class="dialogDetails">
                                    <div class="diaLine">
                                        <a href="javascript:" data-id="1"><i></i>违规内容</a>
                                    </div>
                                </div>
                                <div class="dialogDetails">
                                    <div class="diaLine">
                                        <a href="javascript:" data-id="2"><i></i>涉嫌广告</a>
                                    </div>
                                </div>
                                <div class="dialogDetails">
                                    <div class="diaLine">
                                        <a href="javascript:" data-id="3"><i></i>文不对题</a>
                                    </div>
                                </div>
                                <div class="dialogDetails">
                                    <div class="diaLine">
                                        <a href="javascript:" data-id="4"><i></i>抄袭内容</a>
                                    </div>
                                </div>
                                <div class="dialogDetails">
                                    <div class="diaLine">
                                        <a href="javascript:" data-id="5"><i></i>其他理由</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="tzDialogContentLast">
                            <div class="title">举报或问题说明</div>
                            <div class="textarea"><textarea name="report" id="" cols="30" maxlength="200" rows="10"></textarea></div>
                        </div>
                        <div class="reportSubmit">
                            <div class="textMumber">还可输入<span>200</span>个字符</div>
                            <div class="tzsubmit"><button>确定</button></div>
                        </div>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
    <#--<div class="reportBox">-->
    <#--</div>-->
    <#--<div class="" style="width: 743px;height: 630px;background: #fff;position: fixed;top:0;margin: 0 auto;margin-top: 80px;left: 50%;margin-left: -315px">-->
    <#--<div class=""></div>-->
    <#--</div>-->
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>
<script src="${base}/assets/js/dialog.js"></script>
<script>
    var dzan,scang;
    //贴子点赞
    function updReplyLike(obj) {
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>
        if ($(obj).is('.active')) {
//            alert("已点赞");
//            return false;
            dzan=-1;
        }else {
            dzan=1;
            initWebSocket($("#forumUserId").val());
        }
        $(obj).toggleClass('active');
        $.ajaxSettings.async = false;
        $.post('${base}/qcode/forumtopic/updForumTopicLike.json', {
            id:${forumTopicVo.id!},
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: 0,
            approvalCount: dzan,
            forumUserId:$("#forumUserId").val()
        }, function (data) {
            if(data.success) {

            }
        })
        $.ajaxSettings.async = true;
    }
    //贴子收藏
    function updCollect(obj) {
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>
        if ($(obj).is('.active')) {
//            alert("取消收藏");
//            return false;
            scang=0;
        }else {
//            alert("成功点赞");
            scang=1;
            initWebSocket($("#forumUserId").val());
        }
        $(obj).toggleClass('active');
        $.ajaxSettings.async = false;
        $.post('${base}/qcode/forumtopic/updCollect.json', {
            isCollect:scang,
            forumTopicId:${forumTopicVo.id!},
            forumUserId:$("#forumUserId").val()
        }, function (data) {
            if(data) {

            }
        })
        $.ajaxSettings.async = true;
    }
//全局点击
    $("#globalSearch").on("click",function(){
        var urldata = encodeURIComponent($("#searchContent").val());
        window.location.href = "${base}/qcode/forumtopic/community.html?isOutSearch=1&&content="+urldata;
    });
    //百度分享开始========
    var bdText = "";
    var bdDesc = "";
    var bdUrl = "";
    var bdPic = "";
    var changefx = function(a,b,c,d){
        bdText = a;
        bdDesc = b;
        bdUrl =c;
        bdPic = d;
        $("#av").show();
    };

    function addfx() {
        $("#av").hide();
    }

    function showfx() {
        $("#av").show();
    }

    function hid() {
        $("#av").hide();
    }
    //百度分享
    window._bd_share_config = {
        common : {
            "bdSnsKey":{"tsina":"3841578527"},
            bdText : '自定义分享内容',
            bdDesc : '自定义分享摘要',
            bdUrl : '自定义分享url地址',
            bdPic : '自定义分享图片',
            bdSign:'on',
            bdMini:1,
            bdMiniList:['sqq','weixin','tsina','douban','qzone'],
            onBeforeClick:function(cmd,config){
                config.bdText = bdText;
                config.bdDesc = bdDesc;
                config.bdUrl = bdUrl;
                config.bdPic = bdPic;
                return config;
            },
            onAfterClick: function () {
                $.post('${base}/qcode/forumtopic/sharStatistics.json', {
                    id:${forumTopicVo.id!},
                    sharCount: 1
                }, function () {
                })
            }
        },
        share : [
            {
                "tag" : "share_1",
                "bdSize" : 16,
                "bdCustomStyle":""
            },
            {
                "tag" : "share_sq",
                "bdSize" : 20,
                "bdStyle":1
            },
            {
                "tag" : "share_cx",
                "bdSize" : 24,
                "bdStyle":0
            }

        ],/*
        image :{
            "viewList":["sqq","weixin","tsina"],
            "viewText":"分享到",
            "viewSize":"32"
        },*/
    };
    with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='${base}/assets/js/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
    //百度分享结束========

    //复制链接
    function softwhy() {
        var clipBoardContent = "";
        clipBoardContent += this.location.href;
        $('#localhostUrl').val(clipBoardContent);
        $('#localhostUrl').show();
        var ele = $('#localhostUrl');
        ele.select();
        document.execCommand("Copy");
        $('#localhostUrl').hide();
        layer.msg('复制成功');
    }

    function queryUser() {
        $.post('${base}/qcode/forumtopic/queryUser.json', {
            forumUserId:$("#forumUserId").val()
        },function(data) {
            $("#forumName").html('<p>'+data.name+'</p>');
            $("#sc").html(data.collectcount);
            $("#fs").html(data.focuscount);
            $("#tj").html(data.sharcount);
            if(data.face != null && data.face != '') {
                $("#forumFace").attr("src","/${setting['files.contextpath']}"+data.face);
            }
            if(data.isfocus == "1") {
                $("#focus").html("取消关注");
            }else {
                $("#focus").html("关注");
            }
            <#if USER_INFO??>
                if(data.id == ${USER_INFO.id}) {
                    $("#focus").remove();
                }
            </#if>
        })
    }
</script>
<!--textarea高度自适应-->
<script type="text/javascript">
    $(function () {
        $('#contentbox').flexText();
        queryUser();
        hotForum();
    });
    //textarea限制字数
    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }
    toLocation(0);
    //    获取评论
    function toLocation(size) {
        $.post("${base}/qcode/forumtopic/getReply.json",{forumTopicId:${forumTopicVo.id!},start:size*6,belonged:${forumTopicVo.belonged}},function (rusult) {
            var plHtml='';
            var reply=rusult.entityList;
            var PagePosition='';
            reply.forEach(function (i,s) {
                plHtml +='<div class="tzComment-show-con clearfix">';
            <#--插入个人信息-->
                plHtml +='<div class="tzComment-replier"><div class="tzComment-replier-img"><img src=" /${setting['files.contextpath']}'+reply[s].userface +'" alt=""> </div><div class="tzComment-replier-name">'+ reply[s].username +'</div> <div class="tzComment-replier-lc">'+(parseInt(rusult.totalRecords)-(rusult.pageNum-1)*6-s)+'楼</div> </div>';
//                插入评论详情
                plHtml +='<div class="tzComment-Content">';

//                评论内容
                plHtml +='<div class="tzComment-Content-con">'+reply[s].content+'</div>';

                plHtml +='<div class="tzComment-Content-type"> <div class="tzComment-type-left"> <div class="tz-reply-tiem"><span>'+reply[s].addtime+'</span></div> <div class="tz-reply-report"><a href="javascript:;"  onclick="ReportBtn(this)">举报</a></div> </div> ';
                plHtml +='<span class="tzCommenTid">'+reply[s].id+'</span> <input type="hidden" class="tzCommenPids" value="'+reply[s].pids+'"><input type="hidden" class="tzParentid" value="'+reply[s].parentid+'"><span class="tzCommenUserId">'+reply[s].userid+'</span>';
                plHtml +='<div class="tzComment-type-right">';
//                是否是本人
                if(reply[s].delflag=="1"){plHtml +='<a href="javascript:;" class="tzComment-delete">删除</a>'}
                plHtml += '<a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">评论</a>';
//                是否点赞
                if(reply[s].isapproval=='1'){
                    plHtml += '<a href="javascript:;" class="tzComment-zan active">赞</a></div></div><div class="reply-textarea"></div>';
                }else {
                    plHtml +=  '<a href="javascript:;" class="tzComment-zan">赞</a></div></div><div class="reply-textarea"></div>';
                }
//                是否有回复
                if(reply[s].repduserid!=undefined||reply[s].repduserid!=null){
                    plHtml += '<div class="reply-list-con"><div class="reply-pl-con"><div class="reply-pl-title">引用 <a href="javascript:;">@ '+reply[s].repdusername+'</a> 的评论：</div><div class="reply-pl-content">'+reply[s].repdcontent+'</div></div><div class="replyList"></div>';
                }

                if(reply[s].pids.split(",").length>3){
                    plHtml +='<p class="more">引用'+(reply[s].pids.split(",").length-3)+'次评论 <a href="javascript:;">查看全部</a></p></div>';
                }

                plHtml += '</div></div></div></div>';


            });
            $(".tzCommentBox").html(plHtml);

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

    //    提交举报信息
    $(".tzsubmit button").on("click",function () {
        $(".dialogDetails ").each(function () {
            if($(this).find(".diaLine a").hasClass("active")){
                reportId=$(this).find(".diaLine a").attr("data-id")
            }
        });

        if(reportId==''||reportId==undefined){
            errorMsg("请选择举报理由");
            return false;
        }
        if($("textarea[name='report']").val()==''||$("textarea[name='report']").val()==undefined){
            errorMsg("请输入问题说明");
            return false;
        }


        if(reportN==0){
//            举报帖子
            topicId=${forumTopicVo.id};
            type='01';
        }else {
//            举报评论
            topicId=${forumTopicVo.id};
            type='02';
        }
        $.post("${base}/qcode/forumtopic/reportTopicReply.json",{
            topicId:topicId,
            replyId:replyId||"",
            reportType:reportId,
            type:type,
            reportContent:$("textarea[name='report']").val()
        },function () {
            var n = noty({
                text: "举报成功",
                type: 'success',
                dismissQueue: true,
                layout: 'topCenter',
                theme: 'relax',
                timeout: 1000,
                callback: {     // 设置回调函数
                    afterClose: function () {
                        window.location.reload(true);
                    }
                }
            });
            $('#myprport').modal('hide');
        })
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

        $.post("${base}/qcode/forumtopic/getParentReply.json",{pIds:replyPid,pId:replyParentid},function (result) {
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
    <#--回复帖子-->
    $('.tzCommentReplyBox').on('click', '.plBtn', function () {
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
        var oSize = $("#contentbox").val();
//        var oSize = $(this).siblings().find('.comment-input').val();
        oSize =$('<span/>').text( oSize ).html();
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>
        //动态创建评论模块
        $.ajaxSettings.async = false;
        $.post("${base}/qcode/forumtopic/addForumReply.json", {
            forumTopicId:${forumTopicVo.id},
            parentId: 0,
            pIds: '',
            content: oSize,
            forumUserId:$("#forumUserId").val()
        }, function (result) {
            initWebSocket($("#forumUserId").val());
            toLocation(0)
//            window.location.reload()
        });
        $.ajaxSettings.async = true;

        oHtml= '<div class="tzComment-show-con clearfix"> <div class="tzComment-replier"> <div class="tzComment-replier-img"> <img src="/p/assets/forImg/3.jpg" alt=""> </div> <div class="tzComment-replier-name">${USER_INFO.name!} </div> <div class="tzComment-replier-lc">8楼</div> </div> <div class="tzComment-Content"> <div class="tzComment-Content-con">' + oSize + '</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> <div class="tz-reply-tiem"><span>'+now+'</span></div> <div class="tz-reply-report"><a href="javascript:;">举报</a></div> </div> <div class="tzComment-type-right"> <a href="javascript:;" class="tzComment-delete">删除</a> <a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">评论</a> <a href="javascript:;" class="tzComment-zan">赞</a> </div> </div> <div class="reply-textarea"></div> <div class="reply-list-con">  </div> </div> </div>';
        if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {
           //$(this).parents('.reviewArea ').parents('.tzCommentReplyBox ').siblings('.tzCommentBox').prepend(oHtml);
           //$(this).siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');
        }
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
        var fhN = '回复@' + fhName;
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> <textarea class="content comment-input hf-input"  style="min-height: 100px;height: 100px;" placeholder="' + fhN + '" onkeyup="keyUP(this)"></textarea>  <a href="javascript:;" class="hf-pl">评论</a> <a href="javascript:;" class="hf-pl-close">取消</a></div>';
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
        $.post("${base}/qcode/forumtopic/addForumReply.json", {
            forumTopicId:${forumTopicVo.id},
            repdUserId: repdUserId,
            parentId: oHid,
            pIds: pIds,
            content: oHfVal
        }, function (result) {
            toLocation(0)
            // window.location.reload()
        });
        oHtml= '<div class="tzComment-show-con clearfix"> <div class="tzComment-replier"> <div class="tzComment-replier-img"> <img src="/p/assets/forImg/3.jpg" alt=""> </div> <div class="tzComment-replier-name">${USER_INFO.name!} </div> <div class="tzComment-replier-lc">8楼</div> </div> <div class="tzComment-Content"> <div class="tzComment-Content-con">' + oHfVal + '</div> <div class="tzComment-Content-type"> <div class="tzComment-type-left"> <div class="tz-reply-tiem"><span>'+ now+'</span></div> <div class="tz-reply-report"><a href="javascript:;">举报</a></div> </div> <div class="tzComment-type-right"> <a href="javascript:;" class="tzComment-delete">删除</a> <a href="javascript:;" class="tzComment-replybtn pl-hf hf-con-block">评论</a> <a href="javascript:;" class="tzComment-zan">赞</a> </div> </div> <div class="reply-textarea"></div> <div class="reply-list-con"> <div class="reply-pl-con"> <div class="reply-pl-title">引用 <a href="###">@'+ oldName+'</a> 的评论：</div> <div class="reply-pl-content">'+ oldContent +'</div> </div> </div> </div> </div>';
        oThis.parents('.hf-con').parents('.reply-textarea').parents('.tzComment-Content').parents(".tzComment-show-con").parents(".tzCommentBox").prepend(oHtml) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
    });

    //    删除评论
    $('.tzCommentBox').on('click', '.tzComment-delete', function () {
        var oThis = $(this);

        var oHid = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
        //var repdUserId =
        Dialog.confirm({message:'确定删除该条回复吗？'}).on(function (e) {
            if (!e) {
                return;
            }
            $.post("${base}/qcode/forumtopic/delReply.json", {
                id: oHid
            }, function (result) {
                oThis.parents('.tzComment-type-right').parents('.tzComment-Content-type').parents('.tzComment-Content').parents('.tzComment-show-con').remove();
            })
        })

    });

    //    点赞
    $('.tzCommentBox').on('click', '.tzComment-zan', function () {
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>
        var id = $(this).parents('.tzComment-type-right').siblings('.tzCommenTid').html();
        var Uid = $(this).parents('.tzComment-type-right').siblings('.tzCommenUserId').html();
        // var zNum = $(this).find('.z-num').html();
        var count;
        if ($(this).is('.active')) {

            count = -1;
        } else {

            count = 1;
        }
        $(this).toggleClass('active');

        $.post('${base}/qcode/forumtopic/updReplyLike.json', {
            id: id,
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: id,
            approvalCount: count,
            noApprovalCount: ''
        }, function () {
        })
    })

</script>
<!--点击回复动态创建回复块-->


<!--关注-->
<script type="text/javascript">

    $("#focus").on("click",function() {
        var flag = 2;
        if($(this).text() == "关注") {
            flag = 1;
        }
        $.ajax({
            url:"${base}/qcode/forumtopic/focusForum.json",
            dataType:"json",
            type:"post",
            data:{
                userId:$("#forumUserId").val(),
                flag:flag
            },
            success:function(data) {
                if(data.success) {
                    if(flag == 1) {
                        initWebSocket($("#forumUserId").val());
                        $("#focus").html("取消关注");
                        layer.msg("关注成功");
                    }else {
                        $("#focus").html("关注");
                        layer.msg("取消关注成功");
                    }

                }else {
                    if(data.message == "${base}/login.html") {
                        viewLoginMin();
                    }else{
                        layer.msg("关注失败");
                    }
                }
            }
        })
    });

    function hotForum() {
        $.ajax({
            url:"${base}/qcode/forumtopic//queryHot.html",
            dataType:"html",
            type:"post",
            success:function(data) {
                if(data) {
                    $("#hotForum").after(data);
                }
            }
        })
    }

</script>


<script>
    var ak = 'Y5brUY2qCrIjpehmh0CEQ4THLsiyY1Ti';
    var map;
    var point;
    function onblur() {}
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

    function delForum(id) {
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>

        Dialog.confirm({message:'确定删除吗？'}).on(function (e) {
            if (!e) {
                return;
            }
            $.post("${base}/qcode/forumtopic/delForum.json",{"id":id}, function(data) {
                        if(data.success) {
                            location.href = "${base}/qcode/forumtopic/community.html";
                            layer.msg(data.message);
                        }else {
                            layer.msg(data.message);
                        }
            })
        })

    }
</script>
</@main.footer>
