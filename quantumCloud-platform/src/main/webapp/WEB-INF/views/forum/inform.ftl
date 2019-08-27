<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<link rel="stylesheet" href="${base}/assets/css/font-awesome.min.css">
<link rel="stylesheet" href="${base}/assets/css/community.css?1.0">
<#escape x as x?html>
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content" style="min-height:500px; min-width:1336px;">
    <!--top-->
    <@main.forumTopLevel>
        <#escape x as x?html>
        </#escape>
    </@main.forumTopLevel>
<#--主区域-->
    <div class="topicContent " style="margin-top: 20px">
        <div class="topicLeft">
            <div class="userLeft">
                <div class="user-tab">
                    <div class="ueseTabBox informBox">
                        <input type="hidden" id="userId" value="${userId!}">
                        <ul>
                            <li class="active" style="border-left: 0"><a href="javascript:;" class="comment" onclick="myForumReply()">评论<#if (noticCount.commentsCount != 0)><span id="commentsCount">#{noticCount.commentsCount}</span></#if></a></li>
                            <li><a href="javascript:;" class="follow" onclick="getFocus()">关注<#if (noticCount.focusCount != 0)><span id="focusCount">#{noticCount.focusCount}</span></#if></a></li>
                            <li><a href="javascript:;" class="Collection" onclick="getCollect('1')">收藏<#if (noticCount.collectionCount != 0)><span id="collectionCount">#{noticCount.collectionCount}</span></#if></a></li>
                            <li><a href="javascript:;" class="dianzan" onclick="getCollect('2')">点赞<#if (noticCount.pointsCount != 0)><span id="pointsCount">#{noticCount.pointsCount}</span></#if></a></li>
                            <li style="border-right: 0"><a href="javascript:;" class="notice">通知</a></li>
                        </ul>
                    </div>
                </div>
                <div class="user-controller inform-controller">
                    <#--评论-->
                    <div class="userControCase active">

                        <div class="userCon userPost">
                            <div class="userAttention" id="myForumReply">
                            </div>
                        </div>
                    </div>

                    <#--关注-->
                    <div class="userControCase ">
                        <div class="userCon userPost">
                            <div class="userAttention" id="foc">
                            </div>
                        </div>
                    </div>

                    <#--收藏-->
                    <div class="userControCase">
                        <div class="userCon userPost">
                            <div class="userAttention" id="collect">
                            </div>
                        </div>
                    </div>

                    <#--点赞-->
                    <div class="userControCase">

                        <div class="userCon userPost">
                            <div class="userAttention" id="likeForum">
                            </div>
                        </div>
                    </div>

                    <#--通知-->
                    <div class="userControCase">

                        <div class="userCon userPost">
                            <div class="userAttention">
                                <div class="noticeBox">
                                    <ul>
                                        <#--<li class="notice_detalis">-->
                                            <#--<div class="notImg"><img src="${base}/assets/forImg/3.jpg" alt=""></div>-->
                                            <#--<div class="notText">-->
                                                <#--<div class="notTitle"><a href="javascript:;">阿拉斯加的闪电</a><div class="notTime">昨天 14:59</div></div>-->
                                                <#--<div class="notContent">-->
                                                    <#--去往QPanda首页，下载最新版的QPanda文件，通常是QPanda2.0.x版本。下载到本地之后，解压缩包。Visual Studio 2017正常安装的情况下，可以直接打开QPanda-2.0.windows.sln文件。-->

                                                    <#--去往QPanda首页，下载最新版的QPanda文件，通常是QPanda2.0.x版本。下载到本地之后，解压缩包。Visual Studio 2017正常安装的情况下，可以直接打开QPanda-2.0.windows.sln文件。-->
                                                <#--</div>-->
                                            <#--</div>-->

                                        <#--</li>-->
                                        <#--<li class="notice_detalis">-->
                                            <#--<div class="notImg"><img src="${base}/assets/forImg/3.jpg" alt=""></div>-->
                                            <#--<div class="notText">-->
                                                <#--<div class="notTitle"><a href="javascript:;">阿拉斯加的闪电</a><div class="notTime">昨天 14:59</div></div>-->
                                                <#--<div class="notContent">-->
                                                    <#--去往QPanda首页，下载最新版的QPanda文件，通常是QPanda2.0.x版本。下载到本地之后，解压缩包。Visual Studio 2017正常安装的情况下，可以直接打开QPanda-2.0.windows.sln文件。-->

                                                    <#--去往QPanda首页，下载最新版的QPanda文件，通常是QPanda2.0.x版本。下载到本地之后，解压缩包。Visual Studio 2017正常安装的情况下，可以直接打开QPanda-2.0.windows.sln文件。-->
                                                <#--</div>-->
                                            <#--</div>-->

                                        <#--</li>-->
                                    </ul>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>
            </div>
        </div>
        <div class="topicRight">
            <div class="userRigth">
                <div class="userBox">
                    <div class="userPoster clearfix">
                        <div class="posterImg">
                            <img src="${base}/assets/forImg/Head.png" alt="" id="forumFace">
                        </div>
                        <div class="posterNature">
                            <div class="posterName" id="forumName"></div>
                            <div class="posterHot">
                                <div class="hotHz">
                                    <p class="hotNum" id="fs"></p>
                                    <p class="hotName">粉丝</p>
                                </div>
                                <div class="hotHz">
                                    <p class="hotNum" id="sc"></p>
                                    <p class="hotName">被收藏</p>
                                </div>
                                <div class="hotHz border-none">
                                    <p class="hotNum" id="tj"></p>
                                    <p class="hotName">被推荐</p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>

</div>
</#escape>
</@main.body>
<@main.footer>
<script>
    $(function() {
        myForumReply();
        queryUser();
    })

    $(".ueseTabBox ul li").on("click",function (index) {
        $(this).addClass("active").siblings().removeClass("active")
        $(".userControCase").eq($(this).index()).addClass("active").siblings().removeClass("active")
       positionFooter()

    })


    //查询个人信息
    function queryUser() {
        $.post('${base}/qcode/forumtopic/queryUser.json', {
            forumUserId:$("#userId").val()
        },function(data) {
            $("#forumName").html('<p>'+data.name+'</p>');
            $("#sc").html(data.collectcount);
            $("#fs").html(data.focuscount)
            $("#tj").html(data.sharcount);
            $("#forumFace").attr("src","/${setting['files.contextpath']}"+data.face);
        })
    }

    //查询关注
    function getFocus() {
        $.ajax({
            url:"${base}/qcode/forumtopic/forumFocus.html",
            data:{
                flag:"2",
                userId:$("#userId").val(),
                start:$("#startId").val(),
                type:"2",
                opType:"1"
            },
            dataType:"html",
            async:false,
            success:function(data) {
                if(data) {
                    $("#foc").empty();
                    $("#foc").html(data);
                    $("#focusCount").remove();
                    initWebSocket($("#userId").val());
                }
            }
        })
    }

    //查询收藏、点赞
    function getCollect(type) {
        var opType = "";
        if(type == 1) {
            opType = "2";
        }else {
            opType = "4";
        }
        $.ajax({
            url:"${base}/qcode/forumtopic/queryMyCollect.html",
            dataType:"html",
            data:{
                type:type,
                start:$("#startId").val(),
                opType:opType
            },
            async:false,
            success:function(data) {
                if(data) {
                    if(type == "1") {
                        $("#collect").empty();
                        $("#collect").html(data);
                        $("#collectionCount").remove();
                        initWebSocket($("#userId").val());
                    }else {
                        $("#likeForum").empty();
                        $("#likeForum").html(data);
                        $("#pointsCount").remove();
                        initWebSocket($("#userId").val());
                    }
                }
            }
        })
    }

    $("#globalSearch").on("click",function(){
        var urldata = encodeURIComponent($("#searchContent").val());
        var url = "${base}/qcode/forumtopic/index.html?isOutSearch=1&&content="+urldata;
        window.open(url);
    });
    //查询回复我的
    function myForumReply() {
        $.ajax({
            url:"${base}/qcode/forumtopic/queryMyForumReply.html",
            dataType:"html",
            data:{
                start:$("#startId").val(),
                opType:"3"
            },
            async:false,
            success:function(data) {
                if(data) {
                    $("#myForumReply").empty();
                    $("#myForumReply").html(data);
                    $("#commentsCount").remove();
                    initWebSocket($("#userId").val());
                }
            }
        })
    }

</script>
</@main.footer>
