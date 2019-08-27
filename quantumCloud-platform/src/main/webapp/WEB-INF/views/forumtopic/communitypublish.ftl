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

    <#--发表文章-->
        <div class="topicContent" style="margin-top: 0px">
            <div class="pubContent">
                <div class="pubHead">
                    <i></i>
                    <h1>写文章</h1>
                </div>
                <div class="pubImgTitle">
                    <div class="pubIssue">
                        <div class="pubImg">
                            <div class="upLoadFile">
                                <img style="max-width: 152px;" src="${base}/assets/forImg/Upload.png" alt="" onclick="$('#upLoadImg').click()" id="pic">
                                <input type="file" id="upLoadImg" onchange="uploadpic(this)">

                            </div>
                            <div class="upLoadTips">添加一张头图可以提升阅读体验哦</div>
                        </div>
                        <div>
                            <div class="pubTitle">
                                <input type="text" placeholder="起个标题吧（8-30字之间）" maxlength="30" id="title">
                            </div>
                            <div class="chooseM">
                                <span>选择版块</span>
                                <i></i>
                                <div class="chooseList">
                                    <ul>
                                        <#if blockList?? && (blockList)?size gt 0>
                                            <#list blockList as blockList>
                                                <li belong="${blockList.id}">${blockList.blockName}</li>
                                            </#list>
                                        </#if>


                                    </ul>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="pubMain">
                    <div class="pubMainBody">
                        <div class="pubEdit"></div>
                        <div class="comm_Placeholder" id="aa">请输入正文</div>
                    </div>
                </div>

                <div class="pubLabel">
                    <div class="pubLabelTitle">选择分类标签 <span class="labelNum">0/3</span><a href="javascript:;" class="addTags">添加标签</a></div>
                    <div class="pubLabelDetails clearfix">
                        <ul>
                            <#if labelList??>
                                <#list labelList as labelList>
                                    <li><a href="javascript:;" data-id="${labelList.id}">${labelList.label}</a></li>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
                <div class="pubBtn" style="">
                <#--<button class="saveEdit">存草稿</button>-->
                    <button class="publishBth" onclick="saveForum()">发布</button>
                </div>
            </div>
        </div>



    </div>
    </#escape>
</@main.body>
<@main.footer>
<style>
    .w-e-toolbar,.w-e-text-container,.w-e-menu-panel {  padding: 0;  margin: 0;  box-sizing: border-box;}.w-e-toolbar *,.w-e-text-container *,.w-e-menu-panel * {  padding: 0;  margin: 0;  box-sizing: border-box;}.w-e-clear-fix:after {  content: "";  display: table;  clear: both;}.w-e-toolbar .w-e-droplist {  position: absolute;  left: 0;  top: 0;  background-color: #fff;  border: 1px solid #f1f1f1;  border-right-color: #ccc;  border-bottom-color: #ccc;}.w-e-toolbar .w-e-droplist .w-e-dp-title {  text-align: center;  color: #999;  line-height: 2;  border-bottom: 1px solid #f1f1f1;  font-size: 13px;}.w-e-toolbar .w-e-droplist ul.w-e-list {  list-style: none;  line-height: 1;}.w-e-toolbar .w-e-droplist ul.w-e-list li.w-e-item {  color: #333;  padding: 5px 0;}.w-e-toolbar .w-e-droplist ul.w-e-list li.w-e-item:hover {  background-color: #f1f1f1;}.w-e-toolbar .w-e-droplist ul.w-e-block {  list-style: none;  text-align: left;  padding: 5px;}.w-e-toolbar .w-e-droplist ul.w-e-block li.w-e-item {  display: inline-block;  *display: inline;  *zoom: 1;  padding: 3px 5px;}.w-e-toolbar .w-e-droplist ul.w-e-block li.w-e-item:hover {  background-color: #f1f1f1;}@font-face {  font-family: 'w-e-icon';  src:url(../../assets/fonts/wangEditor.ttf) format('truetype');  font-weight: normal;  font-style: normal;}[class^="w-e-icon-"],[class*=" w-e-icon-"] {  /* use !important to prevent issues with browser extensions that change fonts */  font-family: 'w-e-icon' !important;  speak: none;  font-style: normal;  font-weight: normal;  font-variant: normal;  text-transform: none;  line-height: 1;  /* Better Font Rendering =========== */  -webkit-font-smoothing: antialiased;  -moz-osx-font-smoothing: grayscale;}.w-e-icon-close:before {  content: "\f00d";}.w-e-icon-upload2:before {  content: "\e9c6";}.w-e-icon-trash-o:before {  content: "\f014";}.w-e-icon-header:before {  content: "\f1dc";}.w-e-icon-pencil2:before {  content: "\e906";}.w-e-icon-paint-brush:before {  content: "\f1fc";}.w-e-icon-image:before {  content: "\e90d";}.w-e-icon-play:before {  content: "\e912";}.w-e-icon-location:before {  content: "\e947";}.w-e-icon-undo:before {  content: "\e965";}.w-e-icon-redo:before {  content: "\e966";}.w-e-icon-quotes-left:before {  content: "\e977";}.w-e-icon-list-numbered:before {  content: "\e9b9";}.w-e-icon-list2:before {  content: "\e9bb";}.w-e-icon-link:before {  content: "\e9cb";}.w-e-icon-happy:before {  content: "\e9df";}.w-e-icon-bold:before {  content: "\ea62";}.w-e-icon-underline:before {  content: "\ea63";}.w-e-icon-italic:before {  content: "\ea64";}.w-e-icon-strikethrough:before {  content: "\ea65";}.w-e-icon-table2:before {  content: "\ea71";}.w-e-icon-paragraph-left:before {  content: "\ea77";}.w-e-icon-paragraph-center:before {  content: "\ea78";}.w-e-icon-paragraph-right:before {  content: "\ea79";}.w-e-icon-terminal:before {  content: "\f120";}.w-e-icon-page-break:before {  content: "\ea68";}.w-e-icon-cancel-circle:before {  content: "\ea0d";}.w-e-icon-font:before {  content: "\ea5c";}.w-e-icon-text-heigh:before {  content: "\ea5f";}.w-e-toolbar {  display: -webkit-box;  display: -ms-flexbox;  display: flex;  padding: 0 5px;  /* flex-wrap: wrap; */  /* 单个菜单 */}.w-e-toolbar .w-e-menu {  position: relative;  text-align: center;  padding: 5px 10px;  cursor: pointer;}.w-e-toolbar .w-e-menu i {  color: #999;}.w-e-toolbar .w-e-menu:hover i {  color: #333;}.w-e-toolbar .w-e-active i {  color: #1e88e5;}.w-e-toolbar .w-e-active:hover i {  color: #1e88e5;}.w-e-text-container .w-e-panel-container {  position: absolute;  top: 0;  left: 50%;  border: 1px solid #ccc;  border-top: 0;  box-shadow: 1px 1px 2px #ccc;  color: #333;  background-color: #fff;  /* 为 emotion panel 定制的样式 */  /* 上传图片的 panel 定制样式 */}.w-e-text-container .w-e-panel-container .w-e-panel-close {  position: absolute;  right: 0;  top: 0;  padding: 5px;  margin: 2px 5px 0 0;  cursor: pointer;  color: #999;}.w-e-text-container .w-e-panel-container .w-e-panel-close:hover {  color: #333;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-title {  list-style: none;  display: -webkit-box;  display: -ms-flexbox;  display: flex;  font-size: 14px;  margin: 2px 10px 0 10px;  border-bottom: 1px solid #f1f1f1;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-title .w-e-item {  padding: 3px 5px;  color: #999;  cursor: pointer;  margin: 0 3px;  position: relative;  top: 1px;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-title .w-e-active {  color: #333;  border-bottom: 1px solid #333;  cursor: default;  font-weight: 700;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content {  padding: 10px 15px 10px 15px;  font-size: 16px;  /* 输入框的样式 */  /* 按钮的样式 */}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content input:focus,.w-e-text-container .w-e-panel-container .w-e-panel-tab-content textarea:focus,.w-e-text-container .w-e-panel-container .w-e-panel-tab-content button:focus {  outline: none;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content textarea {  width: 100%;  border: 1px solid #ccc;  padding: 5px;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content textarea:focus {  border-color: #1e88e5;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content input[type=text] {  border: none;  border-bottom: 1px solid #ccc;  font-size: 14px;  height: 20px;  color: #333;  text-align: left;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content input[type=text].small {  width: 30px;  text-align: center;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content input[type=text].block {  display: block;  width: 100%;  margin: 10px 0;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content input[type=text]:focus {  border-bottom: 2px solid #1e88e5;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button {  font-size: 14px;  color: #1e88e5;  border: none;  padding: 5px 10px;  background-color: #fff;  cursor: pointer;  border-radius: 3px;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button.left {  float: left;  margin-right: 10px;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button.right {  float: right;  margin-left: 10px;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button.gray {  color: #999;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button.red {  color: #c24f4a;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container button:hover {  background-color: #f1f1f1;}.w-e-text-container .w-e-panel-container .w-e-panel-tab-content .w-e-button-container:after {  content: "";  display: table;  clear: both;}.w-e-text-container .w-e-panel-container .w-e-emoticon-container .w-e-item {  cursor: pointer;  font-size: 18px;  padding: 0 3px;  display: inline-block;  *display: inline;  *zoom: 1;}.w-e-text-container .w-e-panel-container .w-e-up-img-container {  text-align: center;}.w-e-text-container .w-e-panel-container .w-e-up-img-container .w-e-up-btn {  display: inline-block;  *display: inline;  *zoom: 1;  color: #999;  cursor: pointer;  font-size: 60px;  line-height: 1;}.w-e-text-container .w-e-panel-container .w-e-up-img-container .w-e-up-btn:hover {  color: #333;}.w-e-text-container {  position: relative;}.w-e-text-container .w-e-progress {  position: absolute;  background-color: #1e88e5;  bottom: 0;  left: 0;  height: 1px;}.w-e-text {  padding: 0 10px;  overflow-y: scroll;}.w-e-text p,.w-e-text h1,.w-e-text h2,.w-e-text h3,.w-e-text h4,.w-e-text h5,.w-e-text table,.w-e-text pre {  margin: 10px 0;  line-height: 1.5;}.w-e-text ul,.w-e-text ol {  margin: 10px 0 10px 20px;}.w-e-text blockquote {  display: block;  border-left: 8px solid #d0e5f2;  padding: 5px 10px;  margin: 10px 0;  line-height: 1.4;  font-size: 100%;  background-color: #f1f1f1;}.w-e-text code {  display: inline-block;  *display: inline;  *zoom: 1;  background-color: #f1f1f1;  border-radius: 3px;  padding: 3px 5px;  margin: 0 3px;}.w-e-text pre code {  display: block;}.w-e-text table {  border-top: 1px solid #ccc;  border-left: 1px solid #ccc;}.w-e-text table td,.w-e-text table th {  border-bottom: 1px solid #ccc;  border-right: 1px solid #ccc;  padding: 3px 5px;}.w-e-text table th {  border-bottom: 2px solid #ccc;  text-align: center;}.w-e-text:focus {  outline: none;}.w-e-text img {  cursor: pointer;}.w-e-text img:hover {  box-shadow: 0 0 5px #333;}
</style>
<link rel="stylesheet" href="${base}/assets/css/font-awesome.min.css">
<script src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>
<script src="${base}/assets/js/wangEditor.js"></script>
<script>
    var belonged='';
    updatesection()
    function updatesection() {
        if (belonged==1) {
            $('.chooseM span').text('QPanda')
        }else if(belonged==3){
            $('.chooseM span').text('量子课程')
        }else if(belonged==2){
            $('.chooseM span').text('量子算法')
        }
    }
    $('.chooseM').on('click',function () {
        $(this).find('i').toggleClass('rotate-i')
        $('.chooseList').slideToggle('fast')
    })
    $('.chooseList').on('click','li',function () {
        var text = $(this).text();
        $('.chooseM span').text(text);
        belonged=$(this).attr("belong");
    })
    var labelCount = ${labelCount};//标签最大数量
    $(function() {
        $(".footer-container.fixed-bottom").css({"position":"static"})
        //显示富文本
        var S = window.wangEditor;
        var editor = new S('.pubEdit');
//        editor.customConfig.uploadImgShowBase64 = true
        editor.customConfig.uploadImgServer = '${base}/qcode/forumtopic/upload.json';
        editor.customConfig.uploadImgHooks = {
            before: function (xhr, editor, files) {
                // 图片上传之前触发
                // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，files 是选择的图片文件

                // 如果返回的结果是 {prevent: true, msg: 'xxxx'} 则表示用户放弃上传
                // return {
                //     prevent: true,
                //     msg: '放弃上传'
                // }
            },
            success: function (xhr, editor, result) {
                // 图片上传并返回结果，图片插入成功之后触发
                // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
            },
            fail: function (xhr, editor, result) {
                // 图片上传并返回结果，但图片插入错误时触发
                // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
            },
            error: function (xhr, editor) {
                // 图片上传出错时触发
                // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象
            },
            timeout: function (xhr, editor) {
                // 图片上传超时时触发
                // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象
            },

            // 如果服务器端返回的不是 {errno:0, data: [...]} 这种格式，可使用该配置
            // （但是，服务器端返回的必须是一个 JSON 格式字符串！！！否则会报错）
            customInsert: function (insertImg, result, editor) {
                // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
                // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

                // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
                result = JSON.parse(result);
                var url = "${setting['project.server.url']}"+"/${setting['files.contextpath']}"+result.data[0];
                insertImg(url)

                // result 必须是一个 JSON 格式字符串！！！否则报错
            }
        }
        editor.customConfig.onfocus = function () {
            $(".comm_Placeholder").hide();
        }
        editor.customConfig.onblur = function (html) {
        }
        // 自定义菜单配置
        editor.customConfig.menus = [
            'head',  // 标题
            'bold',  // 粗体
            'fontSize',  // 字号
            'fontName',  // 字体
            'italic',  // 斜体
            'underline',  // 下划线
            'strikeThrough',  // 删除线
            'foreColor',  // 文字颜色
            'backColor',  // 背景颜色
            'link',  // 插入链接
            'list',  // 列表
            'justify',  // 对齐方式
            'quote',  // 引用
            // 'emoticon',  // 表情
            'image',  // 插入图片
            'table',  // 表格
            //'video',  // 插入视频
            'code',  // 插入代码
            'undo',  // 撤销
            'redo'  // 重复
        ]
        editor.create()
    })
    var num = 0;
    var myLabel = 0;
    var lArray = [];
    $(".addTags").on("click",function () {
        if (num>=3){
            layer.msg('最多选择3个标签')
            return
        }
        layer.prompt({title:"请输入标签内容"},function(val, index){
            for(var i=0;i<lArray.length;i++) {
                if(val == lArray[i]) {
                    layer.msg("已有此标签！");
                    return;
                }
            }

            if(val.length > 36) {
                layer.msg("标签最长只能为36字");
                return;
            }

            $.post("${base}/qcode/forumtopic/insertLabel.json",{
                labelName:val
            },function(data) {
                if(data.success) {
                    myLabel = lArray.length + parseInt(data.message);//页面添加的和数据库中已有的此人添加标签数之和
                    if(myLabel > 4) {
                        layer.msg("每人最多添加5个标签");
                        return;
                    }
                    myLabel++;
                }else {
                    layer.msg(data.message);
                    return;
                }
                $(".pubLabelDetails ul").append('<li class="active"><a href="javascript:;" mylabel="1" data-id='+labelCount+'>'+val+' <span onclick="delTags(this,\''+val+'\')">&times;</span></a></li>')
                lArray.push(val);
                labelCount++;
                num++;
                $('.labelNum').text(num+"/3");
                layer.close(index);
            })
        });
    })

    function delTags(obj,v){
        $(obj).parent().parent().remove();
        lArray.splice($.inArray(v,lArray),1);
        myLabel--;
        labelCount--;
    }

    $(".pubLabelDetails ul li").on("click",function () {
        if($(this).hasClass('active')){
            $(this).removeClass('active');
            num--;
        }else {
            if (num>=3){
                layer.msg('最多选择3个标签')
                return
            }
            $(this).addClass('active');
            num++;
        }
        $('.labelNum').text(num+"/3");
    })

//    function uploadpic(obj) {
//        run(obj, function (data) {
//            $("#pic").attr("src",data);
//            $("#topicFace").val(data);
//        });
//    }

    function uploadpic(obj) {
        var docObj = document.getElementById("upLoadImg");
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

    $(".ueseTabBox ul li").on("click",function (index) {
        $(this).addClass("active").siblings().removeClass("active")
        $(".userControCase").eq($(this).index()).addClass("active").siblings().removeClass("active")

    })
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


    function getBase64Image(img,width,height) {
        var canvas = document.createElement("canvas");
        canvas.width = width ? width : img.width;
        canvas.height = height ? height : img.height;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
        var dataURL = canvas.toDataURL();
        return dataURL;
    }


    function saveForum() {
        <#if !USER_INFO??>
            viewLoginMin();
            return;
        </#if>
        if(belonged == "") {
            errorMsg("请选择版块");
            return false;
        }
        var arr = new Array();//固定标签
        $(".pubLabelDetails ul li").each(function () {
            if($(this).hasClass("active")) {
                arr.push($(this).find("a").attr("data-id"));
            }
        })
        if ($("#title").val() == '' || $("#title").val() == null) {
            errorMsg("请输入标题");
            return false;
        }
        if ($(".w-e-text").html() == '<p><br></p>') {
            errorMsg("请输入正文内容");
            return false;
        }
        var index = $(".w-e-text").html().indexOf("<style>");
        var content = "";
        if(index <= 0) {
            content = $(".w-e-text").html();
        }else {
            content = $(".w-e-text").html().substring(0,index)
        }

        var formData = new FormData();
        formData.append('multipartFile', $('#upLoadImg')[0].files[0]?$('#upLoadImg')[0].files[0]:"");
        formData.append('content',content);
        formData.append('title',$("#title").val());
        formData.append('labels',arr.join(","));
        formData.append('belonged',belonged);
        formData.append('myLabels',lArray.join(","));
        $.ajax({
            url:"${base}/qcode/forumtopic/addForumTopic.json",
            traditional: true,
            type:"post",
            data:formData,
            dataType:"json",
            processData: false,
            contentType: false,
            success:function(data) {
                if(data.success) {
                    layer.msg("发布成功，待审核");
                    window.location.href = "${base}/qcode/forumtopic/community.html?emailSend=1"
                }else {
                    layer.msg("发布失败",{icon:2});
                    return false;
                }
            }
        })
        sendEmail()
    }

    function sendEmail() {
        $.post("${base}/qcode/forumtopic/sendForumEmail.json",
                {
                },
                function () {

                }
        )
    }
</script>
</@main.footer>
