<#if pager?? && (pager.entityList)?size gt 0>
    <div class="commentsBox">
        <ul>
        <#list pager.entityList as project>
            <li class="community_detalis inform-details">
                <div class="mentsTop clearfix">
                    <div class="menLeft">
                        <div class="menBox clearfix">
                            <div class="menImg">
                                <img src="/${setting['files.contextpath']}${project.userFace!}" alt="">
                            </div>
                            <div class="menUser">
                                <p class="menUserName">${project.userName!}</p>
                                <p class="menUserTime">${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</p>
                            </div>
                        </div>
                        <div class="menMessage">${project.content}</div>
                    </div>
                    <div class="menRight">
                        <a href="javascript:;" class="replyTabtn">
                            <input type="hidden" id="parentId" value="${project.id}"/>
                            <input type="hidden" id="replyUserId" value="${project.userId}"/>
                            <input type="hidden" id="forumTopicId" value="${project.forumTopicId}"/>
                            <input type="hidden" id="pIds" value="${project.pIds}"/>
                            回复TA
                        </a>
                    </div>

                </div>

                <div class="mentsBottom">
                    <div class="botWrite"><img src="/${setting['files.contextpath']}${project.topicFace!}" alt=""></div>
                    <div class="botTitle"><a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.forumTopicId!}">${project.title!}</a></div>
                </div>
                <div class="replyTa clearfix">

                </div>
            </li>
        </#list>
        </ul>
        <div class="fenye" style="width: 100%;">
            <nav aria-label="Page navigation"
                 style="margin: 100px auto">
            <@main.pagination pager=pager/>
            </nav>
        </div>
    </div>

</#if>
<script>
    function toPage(page) {
        $("#startId").val(page);
        myForumReply();
    }

    $(".commentsBox").on("click",".replyTabtn",function () {
        if($(this).parents(".menRight").parents(".mentsTop").siblings(".replyTa").hasClass("active")){
            $(this).parents(".menRight").parents(".mentsTop").siblings(".replyTa").html("");
            $(this).parents(".menRight").parents(".mentsTop").siblings(".replyTa").removeClass("active");
            return false;
        }
        $(this).parents(".menRight").parents(".mentsTop").siblings(".replyTa").addClass("active");
        var _html='<textarea name="reply" id="" cols="30" rows="10"></textarea> <a href="javascript:;" class="cancel">取消</a><button class="replySubmit">发送</button>'
        $(this).parents(".menRight").parents(".mentsTop").siblings(".replyTa").html(_html);

    })

    $(".commentsBox").on("click",".cancel",function () {
        $(this).parents(".replyTa").removeClass("active");
        $(this).parents(".replyTa").html("");
    })

    $(".commentsBox").on("click",".replySubmit",function () {
//        执行ajax
        var forumTopicId = $(this).parent().siblings(".mentsTop").find("input[id='forumTopicId']").val();//所需回复的评论id
        var parentId = $(this).parent().siblings(".mentsTop").find("input[id='parentId']").val();
        var replyUserId = $(this).parent().siblings(".mentsTop").find("input[id='replyUserId']").val();
        var pIds = $(this).parent().siblings(".mentsTop").find("input[id='pIds']").val();
        var content = $(this).siblings("textarea").val();
        if(content == "" || content == null) {
            alert("内容不可以为空！")
            return false;
        }
        $.post("${base}/qcode/forumtopic/addForumReply.json",{
                    forumTopicId : forumTopicId,
                    replyUserId : replyUserId,
                    parentId : parentId,
                    pIds : pIds,
                    content:content
                },function(data) {
                    if(data.success) {
                        //        发起回复，提交完成后执行下面的隐藏和移除
                        $(".replySubmit").parents(".replyTa").removeClass("active");
                        $(".replySubmit").parents(".replyTa").html("");
                        alert("回复成功")
                    }else {
                        alert("回复失败");
                    }
                },"json")

    })
    $(".userTitle a").on("click",function () {
        $(this).addClass("active").siblings().removeClass("active")
    })
</script>