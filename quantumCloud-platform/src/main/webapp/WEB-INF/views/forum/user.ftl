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
    <link rel="stylesheet" href="${base}/assets/css/bootstrap-datetimepicker.min.css">
    <div class="content" style="min-height:500px; min-width:1336px;">
        <!--top-->
        <@main.forumTopLevel>
            <#escape x as x?html>
            </#escape>
        </@main.forumTopLevel>


        <style>
            .loca_add{
                position: relative;
            }
            .icon-arrow-right{
                display: inline-block;
                width: 14px;
                height: 14px;
                margin-top: 1px;
                line-height: 14px;
                vertical-align: text-top;
                background-image: url(${base}/assets/forImg/glyphicons-halflings.png);
                background-position: -264px -96px;
                background-repeat: no-repeat;
            }
            .icon-arrow-left{
                display: inline-block;
                width: 14px;
                height: 14px;
                margin-top: 1px;
                line-height: 14px;
                vertical-align: text-top;
                background-image: url(${base}/assets/forImg/glyphicons-halflings.png);
                background-position: -240px -96px;
                background-repeat: no-repeat;
            }
            .next{
                background: #fff;
            }

        </style>
    <#--帖子/简介栏-->
        <div class="topicContent" style="margin-top: 20px">
            <div class="topicLeft">
                <div class="userLeft">
                    <div class="user-tab">
                        <div class="ueseTabBox">
                            <ul>
                                <li class="active" style="border-left: 0"><a href="#Article" class="Article">帖子</a></li>
                                <li><a href="#follow" class="follow" onclick="getFocus('1')">关注</a></li>
                                <li><a href="#Collection" class="Collection" onclick="getMyCollect()">收藏</a></li>
                                <li style="border-right: 0"><a href="#setting" class="Setup">设置</a></li>
                            </ul>
                        </div>

                    </div>
                    <div class="user-controller">
                        <input type="hidden" value="${forumUser.id!}" id="userId">
                    <#--帖子-->
                        <div class="userControCase active">
                            <div class="userTitle">
                                <img src="${base}/assets/forImg/daohang.png" alt=""><a href="javascript:;" class="active" onclick="myForum('1')"><i></i>我的帖子</a> <a href="javascript:;" onclick="myForum('2')"><i></i>我的回复</a>
                            </div>
                            <div class="userCon userPost">
                                <div class="userAttention" id="card">
                                </div>
                            </div>
                        </div>

                    <#--关注-->
                        <div class="userControCase">
                            <div class="userTitle">
                                <img src="${base}/assets/forImg/daohang.png" alt=""><a href="javascript:;" class="active" onclick="getFocus('1')"><i></i>我关注的</a> <a href="javascript:;" onclick="getFocus('2')"><i></i>关注我的</a>
                            </div>
                            <div class="userCon">
                                <div class="userAttention" id="foc">
                                </div>
                            </div>
                        </div>

                    <#--收藏-->
                        <div class="userControCase">
                            <div class="userTitle">
                                <img src="${base}/assets/forImg/daohang.png" alt=""><span>我的收藏</span>
                            </div>
                            <div class="userCon" style="padding-top: 0" id="myCollect">

                            </div>
                        </div>
                    <#--设置-->
                        <div class="userControCase">
                            <div class="userTitle">
                                <img src="${base}/assets/forImg/daohang.png" alt=""><span>资料设置</span>
                            </div>
                            <div class="userCon">
                                <#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
                                <#--<form method="post" id="form" action="${base}/qcode/forumtopic/community.html" autocomplete="off">-->
                                    <input type="hidden" name="id" id="id" value="${forumUser.id}">
                                    <input type="hidden" name="starV" id="starV" value="${forumUser.constellation}">
                                    <input type="hidden" name="sexV" id="sexV" value="${forumUser.sex}">
                                    <div class="userPhoto">
                                        <#if (forumUser.face?exists)!>
                                            <img id="pic" name="pic" width="99" height="87" src="/${setting['files.contextpath']}${forumUser.face!}">
                                        <#else>
                                        <#--<img id="pic" name="pic" width="180" height="100" src="/${setting['files.contextpath']}headFile/20180623164815486.jpg">-->
                                            <img id="pic" name="pic" width="99" height="87" src="${base}/assets/forImg/Head.png">
                                        </#if>
                                        <input type="hidden" id="face" name="face" value="${forumUser.face!}">
                                        <input type="hidden" id="oldFace" name="oldFace" value="${forumUser.face!}">
                                        <input type="file" style="display: none" value="上传头像" id="file" onchange="uploadpic(this)" name="file"/>
                                        <div class="upLoadImg" onclick="$('#file').click()">上传图片</div>
                                    </div>


                                    <div class="formModule">
                                    <#--<lable>-->
                                        <div class="formLeft">昵称</div>
                                        <div class="formInput"><input type="text" id="name" maxlength="32" name="name" value="${forumUser.name!}" placeholder="请输入昵称"/></div>
                                    <#--</lable>-->
                                    </div>

                                    <div class="formModule">
                                    <#--<lable>-->
                                        <div class="formLeft">绑定手机号</div>
                                        <div class="formInput"><input type="text" id="tel" name="tel" value="${forumUser.tel!}" readonly/></div>
                                    <#--</lable>-->
                                    </div>
                                    <div class="formModule">
                                        <div class="formLeft">性别</div>
                                        <div class="formInputRadio"><input type="radio" name="sex" value="0" checked/>保密<input type="radio" name="sex" value="1"/>男<input type="radio" name="sex" value="2"/>女</div>
                                    </div>
                                    <div class="formModule">
                                        <div class="formLeft">生日</div>
                                        <div class="formInput"><input type="text" id="birthday" name="birthday" value="${forumUser.birthday!}" placeholder="请输入出生日期" readonly  style="width:150px;"/></div>
                                    </div>
                                    <div class="formModule">
                                        <div class="formLeft">星座</div>
                                        <div class="formInput"> <select name="constellation" id="constellation">
                                            <#list constellation as constellation>
                                                <option value="${constellation.value}">${constellation.text}</option>
                                            </#list></select>
                                        </div>

                                    </div>

                                    <div class="formModule">
                                        <div class="formLeft">邮箱</div>
                                        <div class="formInput">
                                            <input type="text" id="email" name="email" value="${forumUser.email!}" readonly="readonly" placeholder="请输入邮箱地址"/>
                                        </div>
                                    </div>

                                    <div class="formModule">
                                        <div class="formLeft">签名</div>
                                        <div class="formInput"><textarea placeholder="介绍一下自己…" maxlength="200" name="autograph" id="autograph" cols="" rows="">${forumUser.autograph!}</textarea></div>
                                        <div style="clear:both;"></div>
                                    </div>
                                    <div class="formModule">
                                        <div class="formLeft" style="height:35px;"></div>
                                        <div class="formInputButton"><input type="button" value="保存" onclick="updUser()"/></div>

                                    </div>


                                <#--</form>-->
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
                                <#if (forumUser.face)?exists>
                                    <img src="/${setting['files.contextpath']}${forumUser.face!}" alt="">
                                <#else>
                                    <img src="${base}/assets/forImg/Head.png" alt="">
                                </#if>
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
                    <div class="userfeedback">
                        <a href="${base}/qcode/forumtopic/communityFeedback.html"><i></i> 反馈建议</a>
                        <span class="userfeedJd">></span>
                    </div>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>

    </div>
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/bootstrap-datetimepicker.min.js"></script>
<script>
    /**
     * 中文-国际化
     * @param $
     */
    (function($){
        $.fn.datetimepicker.dates['zh-CN'] = {
            days: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
            daysShort: ['周日','周一','周二','周三','周四','周五','周六'],
            daysMin: ['日','一','二','三','四','五','六'],
            months: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            monthsShort: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
            today: '今天',
            suffix: [],
            meridiem: [],
            weekStart: 1,
            format: 'yyyy-mm-dd'
        };
    }(jQuery));
    $(function() {
        if($("#id").val() == null || $("#id").val() == "") {
            $("#id").val(0);
        }
        if($("#starV").val() != null && $("#startV") != "") {
            $("#constellation").val($("#starV").val())
        }
        if($("#sexV").val() != null && $("#sexV").val() != "") {
            $("input[type='radio'][value="+$("#sexV").val()+"]").attr("checked","checked");
        }

        var image = new Image();
        image.src = $("#pic").attr("src");
//        image.onload = function(){
//            var base64 = getBase64Image(image);
//            $("#face").val(base64);
//        }

        if($("#myCollect").html() == "" || $("#foc").html() == "") {
            myForum('1');
        }
        queryUser();

        <#--var socket;-->
        <#--if(typeof(WebSocket) == "undefined") {-->
            <#--alert("您的浏览器不支持WebSocket");-->
            <#--return;-->
        <#--}-->

        <#--var addr = document.location.host;-->
        <#--socket = new WebSocket("ws://"+addr+"${base}/webSocket");-->
        <#--//打开事件-->
        <#--socket.onopen = function() {-->
        <#--};-->
        <#--//获得消息事件-->
        <#--socket.onmessage = function(msg) {-->
            <#--$("#messageNum").html(msg.data);-->
        <#--};-->
        <#--//关闭事件-->
        <#--socket.onclose = function() {-->
<#--//            alert("Socket已关闭");-->
        <#--};-->
        <#--//发生了错误事件-->
        <#--socket.onerror = function() {-->
<#--//            alert("发生了错误");-->
        <#--}-->

    })
    function uploadpic(obj) {
        var docObj = document.getElementById("file");
        var imgObjPreview = document.getElementById("pic");
        if(docObj.files[0].size > 5242880) {
            alert("图片大小超出5兆");
            return;
        }

        var AllImgExt=".jpg|.jpeg|.gif|.bmp|.png|";
        var extName = docObj.files[0].name.substring(docObj.files[0].name.lastIndexOf(".")).toLowerCase();

        if(AllImgExt.indexOf(extName+"|")==-1)
        {
            ErrMsg="该文件类型不允许上传。请上传 "+AllImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(ErrMsg);
            return false;
        }

        if (docObj.files && docObj.files[0]) {
            //火狐下，直接设img属性
            //imgObjPreview.src = docObj.files[0].getAsDataURL();
            //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
            imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
            $("#face").val(window.URL.createObjectURL(docObj.files[0]));
        } else {
            //IE下，使用滤镜
            docObj.select();
            var imgSrc = document.selection.createRange().text;
            var localImagId = document.getElementById("localImag");
            //必须设置初始大小
            localImagId.style.width = "250px";
            localImagId.style.height = "200px";
            //图片异常的捕捉，防止用户修改后缀来伪造图片
            try {
                localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters
                        .item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
            } catch (e) {
                alert("您上传的图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }
        return true;


    }
    var w=null;
    $(".ueseTabBox ul li").on("click",function (index) {
       clearTimeout(w)

        $(this).addClass("active").siblings().removeClass("active")
        $(".userControCase").eq($(this).index()).addClass("active").siblings().removeClass("active");
        w=setTimeout(function () {
            positionFooter()
        },200)

    })
    $(".ueseTabBox ul li").each(function () {
        if($(this).find("a").attr("href")==window.location.hash){
            $(this).addClass("active").siblings().removeClass("active");
            $(".userControCase").eq($(this).index()).addClass("active").siblings().removeClass("active");
            $(this).find("a").click()

        }
    })
    function getHash() {
        $(".ueseTabBox ul li").each(function () {
            if($(this).find("a").attr("href")==window.location.hash){
                $(this).addClass("active").siblings().removeClass("active");
                $(".userControCase").eq($(this).index()).addClass("active").siblings().removeClass("active");
                $(this).find("a").click()

            }
        })
    }




    $("#birthday").datetimepicker({
        language:  'zh-CN',
        format: "yyyy-mm-dd",
        showMeridian: true,
        minView: "month",
        startView:"decade",
        autoclose: true,
        todayBtn: false
    });
    $(".userTitle a").on("click",function () {
        $(this).addClass("active").siblings().removeClass("active")
    })
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
                }
                reader.readAsDataURL(file);
            } catch (e) {
                alert('图片转Base64出错啦！' + e.toString())
            }
        }
    }

    function uploadImage(img) {
        //判断是否有选择上传文件
        var imgPath = $("#file").val();
        if (imgPath == "") {
            alert("请选择上传图片！");
            return;
        }
        //判断上传文件的后缀名
        var strExtension = imgPath.substr(imgPath.lastIndexOf('.') + 1);
        if (strExtension != 'jpg' && strExtension != 'gif'
                && strExtension != 'png' && strExtension != 'bmp') {
            alert("请选择图片文件");
            return;
        }
        $.ajax({
            type: "POST",
            url: '/platform/forumuser/saveBase64Img.json',
            data: {file:img},    //视情况将base64的前面字符串data:image/png;base64,删除
            cache: false,
            success: function (data) {
                $("#pic").attr('src', '/p/files/'+data.message);
                $("#face").val('/p/files/'+data.message);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("上传失败，请检查网络后重试");
            }
        })
        ;
    }

    function updUser() {
        if($("input[name='email']")==null||$("input[name='email']")==''){
            layer.msg("邮箱不能为空");
            return false;
        }
        var formData = new FormData();
        formData.append('multipartFile', $('#file')[0].files[0]?$('#file')[0].files[0]:"");
        formData.append('email',$("#email").val());
        formData.append('name',$("#name").val());
        formData.append('tel',$("#tel").val());
        formData.append('sex',$('input:radio:checked').val());
        formData.append('birthday',$("#birthday").val());
        formData.append('constellation',$("#constellation").val());
        formData.append('autograph',$("#autograph").val());
        formData.append('oldFace',$("#oldFace").val());
        $.ajax({
            url: "${base}/platform/forumuser/updForumUser.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            processData: false,
            contentType: false,
            success:function(data) {
                data = eval('('+data+')');
                if(data.success) {
                    layer.msg(data.message)
//                    location.reload();
                }else {
                    layer.msg(data.message,{icon: 2})
                }
            }
        })
    }

    function focusUser(flag) {
        $.ajax({
            url:"${base}/platform/forumuser/forumFocus.html",
            dataType:"html",
            type:"post",
            data:{flag:flag},
            success:function(data) {
                if(data) {
                    $("#focus").html("");
                    $("#focus").html(data);
                }
            }
        })
    }

    function getBase64Image(img,width,height) {
        var canvas = document.createElement("canvas");
        canvas.width = width ? width : img.width;
        canvas.height = height ? height : img.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
        var dataURL = canvas.toDataURL();
        return dataURL;
    }

    //查询帖子
    function myForum(type) {
        $.ajax({
            url:"${base}/qcode/forumtopic/myForum.html",
            data:{
                type:type,
                userId:$("#userId").val(),
                start:$("#startId").val()
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $("#card").empty();
                    $("#card").html(data);
                }
            }
        })
    }

    $("#globalSearch").on("click",function(){
        var urldata = encodeURIComponent($("#searchContent").val());
        var url = "${base}/qcode/forumtopic/index.html?isOutSearch=1&&content="+urldata;
        window.open(url);
    });

    //查询关注
    function getFocus(flag) {
        $.ajax({
            url:"${base}/qcode/forumtopic/forumFocus.html",
            data:{
                flag:flag,
                userId:$("#userId").val(),
                type:"1"
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $("#foc").empty();
                    $("#foc").html(data);
                }
            }
        })
    }

    //查询收藏
    function getMyCollect(page) {
        $.ajax({
            url:"${base}/qcode/forumtopic/myCollect.html",
            data:{
                userId:$("#userId").val(),
                start:page
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $("#card").empty();
                    $("#myCollect").empty();
                    $("#myCollect").html(data);
                }
            }
        })
    }

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


    function toPage(page) {
        $("#startId").val(page);
        if($("#card")) {

        }
        getMyCollect(page);
    }

</script>
</@main.footer>
