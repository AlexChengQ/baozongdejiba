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
        <style>
            body{
                background: #f5f5f5!important;
            }
            .feedContent{
                width: 885px;
                height: 930px;
                /*margin-top: 30px;*/
                background: #fff;
                margin: 30px auto;
            }
            .feeDtitle{
                text-align: center;
                line-height: 70px;
                font-size: 24px;
                border-bottom: 1px solid #ccc;
                color: #333;
            }
            .feedBox{
                padding: 30px 70px;
            }
            .feed_details{
                width: 100%;
            }
            .feed_select{
                width: 50%;
                float: left;
                position: relative;

            }
            .feed_select_name{
                width: 86px;
                line-height: 50px;
                text-align: left;
                float: left;
            }
            .feed_select_input{
                width: 264px;
                height: 50px;


                position: relative;
                margin-left: 86px;
            }
            .feed_add{
                padding-left: 10px;
                border: 1px solid #ccc;
                cursor: pointer;
            }
            .feed_add:hover{
                box-shadow: 0 0 2px #ddd;
            }
            .feed_select_input:before{
                content: '';
                width:0;
                height:0;
                border-width:7px 7px 0;
                border-style:solid;
                border-color:#808080 transparent transparent;/*灰 透明 透明 */
                /*margin:40px auto;*/
                position:absolute;
                top: 21px;
                right: 37px;
            }
            .feed_select_input span{
                line-height: 48px;
                color: #808080;
            }
            .feed_tip1,.feed_tip2{
                display: none;
                margin-top: 5px;
                padding-left: 22px;
                color: #d81e06;
                line-height: 19px;
                height: 18px;
                background: url(${base}/assets/forImg/feedtip.png) no-repeat left;
            }
            .feed_input_box{
                width: 100%;
                height: 49px;
                line-height: 45px;
                color: #808080;
                border: 1px solid #ccc;
            }
            .feed_input input{
                padding-left: 10px;
                border: none;
                outline: none;
                box-shadow: none;
            }
            .feed_input input:focus{
                /*padding-left: 10px;*/
                border: none;
                outline: none;
                box-shadow: none;
            }
            .feed_textarea textarea{
                width: 100%;
                height: 320px;
                resize: none;
                box-shadow: none;
                border: 1px solid #ccc;
                margin: 0;
                padding: 10px;
            }
            .feed_selectBox{
                top: 49px;
                position: absolute;
                display: none;
                width: 100%;
                background: #fff;
                left:0;
                border:1px solid #ddd;

            }
            .feed_selectBox ul {
                width: 100%;
                height: 100%;

            }
            .feed_selectBox ul li{
                width: 100%;
                height: 42px;line-height: 42px;
            }
            .feed_selectBox ul li a{
                width: 100%;
                text-align: left;
                padding-left: 10px;
                display: block;
                color: #333;font-size: 12px;
            }
            .feed_selectBox ul li a:hover{
                background: #d9e2f6;
                color: #000;
            }
            .feed_upload_title{
                width: 86px;
                float: left;
                height: 100%;
                line-height: 20px;
                color: #333;
            }
            .feed_upload_con{
                margin-left: 86px;
            }
            .feed_upload_con{
                /*max-width: 300px;*/
                /*height: 200px;*/
                /*overflow: hidden;*/
            }
            .feed_upload_con img{
                max-width: 200px;
                max-height: 150px;
                cursor: pointer;
            }
            .feed_upload_con img:hover{
                box-shadow:0px 0px 5px #bbbbbb;
                border-radius: 8px;
            }
            .feed_upload_con input{
                display: none;
            }
            .feed_remark{
                display: none;
                font-size: 14px;
                color: #808080;
                margin-left: 86px;
                line-height: 60px;
            }
            .submitFeed{
                margin-top: 55px;
                width: 100%;
                height: auto;
                text-align: right;
            }
            .submitFeed a{
                width: 166px;
                height: 53px;
                line-height: 53px;
                display: block;
                float: right;
                background: #178cec;
                text-align: center;
                border-radius: 8px;
                color: #fff;
            }
            .feed_h8{
                height:80px;
            }
        </style>
        <form id="feedForm" method="post" enctype="multipart/form-data" action="${base}/qcode/forumtopic/feedback.json">
        <div class="feedContent">
            <div class="feeDtitle">意见反馈</div>
            <div class="feedBox">
                <div class="feed_details feed_h8">
                    <div class="feed_select" >

                        <div class="feed_select_name">选择版块：</div>
                        <div class="feed_select_input">
                            <div class="feed_add">
                                <span class="val">请选择板块</span>
                            </div>

                            <div class="feed_tip1">请选择板块</div>
                            <input type="hidden" id="belonged" name="belonged">
                            <div class="feed_selectBox">
                                <ul>
                                    <li><a href="javascript:;" data-id="1">QPanda</a></li>
                                    <li><a href="javascript:;" data-id="2">量子课堂</a></li>
                                    <li><a href="javascript:;" data-id="3">量子算法</a></li>
                                </ul>
                            </div>
                        </div>

                    </div>
                    <div class="feed_select" style="display:inline-block;float: none;">
                        <div class="feed_select_name">问题类型：</div>
                        <div class="feed_select_input">
                            <div class="feed_add">
                                <span class="val2">请选择问题类型</span>

                            </div>
                            <div class="feed_tip2">请选择问题类型</div>
                            <input type="hidden" id="problemType" name="problemType">
                            <div class="feed_selectBox">
                                <ul>
                                    <li><a href="javascript:;" data-value="1">页面打开慢</a></li>
                                    <li><a href="javascript:;" data-value="2">帖子种类少</a></li>
                                    <li><a href="javascript:;" data-value="3">广告太多</a></li>
                                    <li><a href="javascript:;" data-value="4">论坛功能增/减</a></li>
                                    <li><a href="javascript:;" data-value="5">帖子丢失</a></li>
                                    <li><a href="javascript:;" data-value="6">其他</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <#--<div class="clearfix"></div>-->
                <div class="feed_details">
                    <div class="feed_input_box">
                        <div class="feed_input"><input type="text" name="title" placeholder="请用一句话描述清楚问题，限5-40字" minlength="5" maxlength="40" style="width:100%;line-height: 44px;height: 44px"></div>
                    </div>

                </div>
                <div class="feed_details" style="margin-top: 40px">
                    <div class="feed_textarea_box">
                        <div class="feed_textarea"><textarea  placeholder="请填写问题详细描述" name="content" minlength="5" maxlength="40"></textarea></div>
                    </div>

                </div>
                <div class="feed_details" style="margin-top: 50px">
                    <div class="feed_upload">
                        <div class="feed_upload_title">添加图片：</div>
                        <div class="feed_upload_con"><img src="${base}/assets/forImg/feedAdd.png" alt="" onclick="$('#files').click()" id="imgFile"/><input id="files" name="files" type="file" onchange="uploadpic(this)" hidden ></div>
                        <div class="feed_remark">
                            注：最多添加4张图片，格式支持JPEG、PNG、JPG、GIF，每张图不超过8M
                        </div>
                    </div>
                </div>
                <div class="submitFeed">
                    <a href="javascript:;">提交</a>
                </div>
            </div>
        </div>
        </form>
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/wangEditor.js"></script>
<script>

$(".feed_select_input").on("click",function () {
    $(this).find(".feed_selectBox").slideDown()
})
$(".feed_select_input").on("mouseleave",function () {
    $(this).find(".feed_selectBox").slideUp()
})
var plateId,problemId;
    $(".feed_selectBox ul li a").on("click",function (e) {
        console.log($(this).attr("data-id"))
        console.log($(this).attr("data-value"));
        if($(this).attr("data-id")!=undefined){
            plateId=$(this).attr("data-id");
            $(".val").html($(this).text());
            $("#belonged").val(plateId);
        }else {
            problemId=$(this).attr("data-value")
            $(".val2").html($(this).text());
            $("#problemType").val(problemId);
        }
        $(this).parents().parents().parents(".feed_selectBox").hide();
        return false;

    })

    $(".submitFeed a").on("click",function(){
        if(plateId==""||plateId==undefined){
            $(".feed_tip1").show();
            return false;
        }else {
            $(".feed_tip1").hide()
        }
        if(problemId==""||problemId==undefined){
            $(".feed_tip2").show()
            return false;
        }else {
            $(".feed_tip2").hide()
        }

        var form = new FormData(document.getElementById("feedForm"));
        $.ajax({
            url:"${base}/qcode/forumtopic/feedback.json",
            type:"post",
            data:form,
            async:true,
            processData:false,
            contentType:false,
            success:function(data){
                if(data.success) {
                    alert("提交成功");
                    window.location.href="${base}/qcode/forumtopic/community.html";
                }
            },
            error:function(e){
                alert("错误！！");
            }
        });
//        get();//此处为上传文件的进度条
//        $("#feedForm").submit();
    })

    function uploadpic(obj) {
        run(obj, function (data) {
            $("#imgFile").attr("src",data);
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
                }
                reader.readAsDataURL(file);
            } catch (e) {
                alert('图片转Base64出错啦！' + e.toString())
            }
        }
    }
</script>
</@main.footer>
