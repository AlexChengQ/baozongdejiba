<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html></#escape>
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
                    <div class="dashboardBg" style="height: 60px;background-size: 100% auto "></div>
                    <div class="setUpBox">
                        <ul class="setUp-top">
                            <li>当前位置:</li>
                            <li><a href="${base}/EDU/index.html">首页&nbsp;> </a></li>
                            <li><a href="${base}/EDU/personal.html">&nbsp; 个人信息设置</a></li>
                        </ul>
                        <div class="setUp-con">
                            <div class="setUp-con-left">
                                <div class="personal-msg">
                                    <div class="headImg">
                                        <#if (USER_INFO.face)?exists>
                                            <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="picLeft">
                                        <#else>
                                            <img src="${base}/assets/images/wx_new1.jpg" alt="">
                                        </#if>
                                    </div>
                                    <div class="headRight">
                                        <input type="hidden" value="${USER_INFO.id!}" id="userId">
                                        <div class="userName">${USER_INFO.name!}</div>
                                        <div class="headLevel">${USER_INFO.userTitle!}</div>
                                        <div>积分：<span class="integral" id="personalScore">${USER_INFO.score!}</span></div>
                                    </div>
                                </div>
                                <ul>
                                    <li class="perActive" id="personal-list1">个人资料</li>
                                    <li id="personal-list2">密码修改</li>
                                </ul>
                            </div>
                            <div class="setUp-con-right">
                                <div class="con-title userName">个人资料</div>
                                <div class="conBox">
                                    <div class="conBox-left">
                                        <div >
                                            <div class="user-text">账号:</div>
                                            <div class="user-msg">${USER_INFO.email!}</div>
                                        </div>
                                        <div class="accountBox">
                                            <label class="user-text" for="userName">用户名:</label>
                                            <input class="user-msg" placeholder="${USER_INFO.name!}" id="userName" disabled="disabled" value="${USER_INFO.name}">
                                            <button class="btn-style" style="float: right;" >修改</button>
                                        </div>
                                        <div class="accountBox">
                                            <label class="user-text" for="organ">机构:</label>
                                            <input class="user-msg" placeholder="${USER_INFO.orgName!}" id="organ" disabled="disabled" value="${USER_INFO.orgName}">
                                            <button class="btn-style btn-style2" style="float: right">修改</button>
                                        </div>
                                        <div class="saveBtn-box">
                                            <button class="saveBtn btn-style">保存</button>
                                        </div>
                                    </div>
                                    <div class="conBox-right">
                                        <div class="userImg">
                                            <#if (USER_INFO.face)?exists>
                                                <img src="/${setting['files.contextpath']}${USER_INFO.face!}" alt="" id="picUrl">
                                            <#else>
                                                <img src="${base}/assets/images/wx_new1.jpg" alt="">
                                            </#if>
                                            <#--<img src="/${setting['files.contextpath']}${USER_INFO.face!}" id="picUrl"/>-->
                                        </div>
                                        <button class="modifyImg" onclick="$('#upLoadImg').click()">修改头像</button>
                                        <input id="upLoadImg" name="files" type="file" onchange="uploadpic(this)" hidden="" style="display: none">
                                    </div>
                                </div>
                                <div class="password-change" >
                                    <div>
                                        <label for="passwordOld">原密码：</label>
                                        <input type="password" id="passwordOld" name="passwordOld" placeholder="请输入原密码">
                                    </div>
                                    <div>
                                        <label for="passwordNew">新密码：</label>
                                        <input type="password" id="passwordNew" name="passwordNew" placeholder="至少六位">
                                    </div>
                                    <div>
                                        <label for="sure-passwordNew">确认密码：</label>
                                        <input type="password" id="surePasswordNew" name="surePasswordNew" placeholder="至少六位">
                                    </div>
                                    <div>
                                        <button class="btn-style" id="updPwd">确定</button>
                                    </div>
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
    <script>

        $('.setUp-con-left ul li').on('click',function () {
            $(this).addClass('perActive').siblings().removeClass('perActive')
            var target = $(this).attr('id');
            if(target =='personal-list1'){
                $('.conBox').show();
                $('.password-change').hide()
            }else {
                $('.conBox').hide();
                $('.password-change').show()
            }
        })
        var inputText;
        $('.btn-style').on('click',function () {
            var inputEle = $(this).siblings()[1];
            inputText =$(inputEle).val()
            $(inputEle).val('').attr('disabled',false).focus();
        })

        $("#updPwd").on('click',function() {
            var oldPwd = $("#passwordOld").val();
            var pwd = $("#passwordNew").val();
            var surePwd = $("#surePasswordNew").val();
            if(oldPwd == null || oldPwd == '') {
                layer.msg("原密码不能为空");
                return;
            }
            if(oldPwd.length < 6) {
                layer.msg("密码长度最少为6");
                return;
            }

            if(pwd == null || pwd == '') {
                layer.msg("密码不能为空");
                return;
            }

            if(pwd.length < 6) {
                layer.msg("密码长度最少为6");
                return;
            }

            if(surePwd == null || surePwd == '') {
                layer.msg("确认密码不能为空");
                return;
            }

            if(surePwd.length < 6) {
                layer.msg("密码长度最少为6");
                return;
            }

            if(surePwd != pwd) {
                layer.msg("两次输入密码不一致");
                return;
            }

            $.post("${base}/UserInfo/updPwd.json",
                    {
                        "oldPwd":$.md5(oldPwd) ,
                        "pwd":$.md5(pwd)
                    },
                    function(result) {
                        if(result.success) {
                            layer.msg("修改成功");
                        }else {
                            layer.msg(result.message);
                        }
                    }
            )
        })

         $('.saveBtn').on('click',function () {
             var userName = $('#userName').val();
             var orgName  = $('#organ').val();
             var userId = $("#userId").val();
             if(userName == null || userName == '') {
                layer.msg("用户名不能为空",false);
                return;
             }
             var formData = new FormData();
             formData.append('multipartFile', $('#upLoadImg')[0].files[0]);
             formData.append("userId",userId);
             formData.append("orgName",orgName);
             formData.append("name",userName);
             $.ajax({
                 url:"${base}/UserInfo/updUserInfo.json",
                 traditional: true,
                 type:"post",
                 data:formData,
                 dataType:"json",
                 processData: false,
                 contentType: false,
                 success:function(data) {
                     if(data.success) {
                         layer.msg("修改成功");
                     }else {
                         layer.msg("修改失败");
                         return false;
                     }
                 }
             })

         })
        function uploadpic(obj) {
            var docObj = document.getElementById("upLoadImg");
            var imgObjPreview = document.getElementById("picUrl");
            var imgObjPreview2 = document.getElementById("pic");
            var imgObjPreview3 = document.getElementById("picLeft");
            var imgObjPreview4 = document.getElementById("picMain");
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
                imgObjPreview2.src = window.URL.createObjectURL(docObj.files[0]);
                imgObjPreview3.src = window.URL.createObjectURL(docObj.files[0]);
                imgObjPreview4.src = window.URL.createObjectURL(docObj.files[0]);
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
                imgObjPreview2.style.display = 'none';
                imgObjPreview3.style.display = 'none';
                imgObjPreview4.style.display = 'none';
                document.selection.empty();
            }
            return true;


        }

    </script>
</@main.footer>