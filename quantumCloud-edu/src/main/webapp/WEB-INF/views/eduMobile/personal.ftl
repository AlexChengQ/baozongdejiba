<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader title="视频">
    <#escape x as x?html></#escape>
     <style>
         .dashboardBgMobile{
             position: fixed;
             top: 0.6rem;
             background: url(${base}/assets/mobile/images/dashboardBgMobile.png) no-repeat;
             width: 100%;
             -webkit-background-size: 100% 100%;
             background-size: 100% 100%;
             height: 5.74rem;
         }
     </style>
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
            <div class="bannerOrSwiper">
                <div class="setUpBox">
                    <div class="setUp-con">
                        <div class="setUp-con-top">
                            <div class="headerText">头像</div>
                            <span class="arrowImg header_arrow"><img src="${base}/assets/images/EduImg/m_arrow.png" alt=""></span>
                            <div class="headImg" onclick="$('#upLoadImg').click()">
                                 <#if (USER_INFO.face)?exists>
                                     <img src="/${setting['files.contextpath']}${USER_INFO.face!}" id="picUrl">
                                 <#else>
                                     <img src="${base}/assets/images/wx_new1.jpg" alt="" id="picUrl">
                                 </#if>
                            </div>
                            <input id="upLoadImg" name="files" type="file" onchange="uploadpic(this)"  style="display: none">
                        </div>
                        <div class="setUp_name">
                             <div id="m_name">
                                 <span class="m_userName">用户名</span>
                                 <input type="hidden" value="${USER_INFO.id!}" id="userId">
                                 <span class="arrowImg"><img src="${base}/assets/images/EduImg/m_arrow.png" alt=""></span>
                                 <span class="m_blueColor userNameText">${USER_INFO.name!}</span>
                             </div>
                            <div id="m_organ">
                                <span class="m_userName">机构</span>
                                <span class="arrowImg"><img src="${base}/assets/images/EduImg/m_arrow.png" alt=""></span>
                                <span class="m_blueColor organText">${USER_INFO.orgName!}</span>
                            </div>
                        </div>
                    </div>
                    <div class="setUp_account">
                        <div class="m_Email_box">
                            <span class="m_userName">邮箱</span>
                            <span class="m_blueColor m_Email">${USER_INFO.email!}</span>
                        </div>
                       <div class="m_passWord_box">
                           <span class="m_userName">密码</span>
                           <span class="arrowImg" style="padding-top: 2px"><img src="${base}/assets/images/EduImg/m_arrow.png" alt=""></span>
                           <span class="m_blueColor" id="showUpd">修改</span>
                       </div>
                    </div>
                    <div class="m_btnBox">
                        <a href="${base}/logout.html"><button class="m_exitBtn">退出登录</button></a>
                    </div>
                </div>
                <div class="m_setBox setUp_password">
                    <div>
                        <input type="password" placeholder="请输入原密码" id="passwordOld">
                        <input type="password" placeholder="请输入新密码" id="passwordNew">
                        <input type="password" placeholder="请确认新密码" id="surePasswordNew">
                        <button class="m_sure" id="updPwd">确定</button>
                        <img src="${base}/assets/images/EduImg/setUp_close.png" alt="" class="close_updBox">
                    </div>
                </div>
                <div class="m_setBox setUp_userName">
                    <div>
                        <input type="text" placeholder="请输入新昵称" id="m_userName">
                        <button class="m_sure saveBtn">确定</button>
                        <img src="${base}/assets/images/EduImg/setUp_close.png" alt="" class="close_updBox">
                    </div>
                </div>
                <div class="m_setBox setUp_organ">
                    <div>
                        <input type="text" placeholder="请输入新的机构名称" id="m_organText" >
                        <button class="m_sure saveBtn">确定</button>
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
        $('.close_updBox').on('click',function () {
            $('.m_setBox').hide();
        });
        $('#showUpd').on("click",function () {
            $('.setUp_password').show()
        });
        $('#m_name').click(function () {
            $('.setUp_userName').show()
        });
        $('#m_organ').click(function () {
            $('.setUp_organ').show()
        })
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
                        "oldPwd":oldPwd ,
                        "pwd":pwd
                    },
                    function(result) {
                        if(result.success) {
                            layer.msg("修改成功");
                        }else {
                            layer.msg(result.message);
                        }
                        $('.m_setBox ').hide()
                    }
            )
        })
        $('.saveBtn').on('click',function () {
            var userId = $("#userId").val();
            var formData = new FormData();
            if($(this).siblings('input').attr('id') =="m_userName"){
                var userName = $('#m_userName').val();
                var orgName =$('.organText').text()
                if(userName == null || userName == '') {
                    layer.msg('用户名不能为空');
                    return
                }
            }else {
                var userName= $('.userNameText').text();
                var orgName  = $('#m_organText').val();
                if(orgName == ''){
                    layer.msg('机构名不能为空');
                    return
                }
            }
            formData.append("userId",userId);
            formData.append("name",userName);
            formData.append("orgName",orgName);
            // formData.append('multipartFile', $('#upLoadImg')[0].files[0]);
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
                        $('.userNameText').text(userName);
                        $('.organText').text(orgName)
                    }else {
                        layer.msg("修改失败");
                        return false;
                    }
                }
            })
            $('.m_setBox').hide();
        });
        $('.headImg').on('click',function () {

        });
        function uploadpic(obj) {
            var formData2 = new FormData();
            var userId = $("#userId").val();
            var userName= $('.userNameText').text();
            var orgName =$('.organText').text()
            console.log(userId,userName,orgName)

            var docObj = document.getElementById("upLoadImg");
            var imgObjPreview = document.getElementById("picUrl");
            var imgObjPreview2 = document.getElementById("pic");
            // var imgObjPreview3 = document.getElementById("picLeft");
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
                // imgObjPreview3.src = window.URL.createObjectURL(docObj.files[0]);
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
                // imgObjPreview3.style.display = 'none';
                imgObjPreview4.style.display = 'none';
                document.selection.empty();
            }
            $('#picUrl').load(function () {
                formData2.append('multipartFile', $('#upLoadImg')[0].files[0]);
                formData2.append("userId",userId);
                formData2.append("name",userName);
                formData2.append("orgName",orgName);
                console.log(formData2)
                $.ajax({
                    url:"${base}/UserInfo/updUserInfo.json",
                    traditional: true,
                    type:"post",
                    data:formData2,
                    dataType:"json",
                    processData: false,
                    contentType: false,
                    success:function(data) {
                        console.log(data)
                    }
                })
            })
            return true;
        }

    </script>
</@main.mfooter>