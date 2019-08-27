

<@main.mHeader>
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
    <style>
        body {
            background-color: #fff !important;
        }

        .bdshare-button-style0-16 a,
        .bdshare-button-style0-16 .bds_more {
            background: transparent !important;
            padding: 0;
            margin: 0;
            float: none;
        }

        .bd_weixin_popup {
            width: 260px !important;
            height: 300px !important;
        }
    </style>
</@main.mHeader>
<@main.body>
    <#escape x as x?html>
        <div class="contentBox" style="padding: 0">
            <link rel="stylesheet" href="${base}/assets/css/public.css">
            <!--top-->
            <div class="content">
                <@main.mobileTop>
                    <#escape x as x?html></#escape>
                </@main.mobileTop>
                <div class="bannerOrSwiper">
                    <div class="EDU-banner" style="position: relative;">
                        <img src="${base}/assets/images/EduImg/app_homepage_banner.png" alt="" width="100%">
                        <div class="swiper-slide-describe banner-text">
                            <div class="slide_banner_box m-competition-banner">
                                <h1 class="banner_h1 competition_h1">本源量子首届量子编程大赛</h1>
                                <h6 class="banner_h3 competition_h3">Origin Quantum Computing+</h6>
                                <a href="#signUp_box" class="competition_apply">立即报名</a>
                            </div>

                        </div>
                    </div>
                    <div class="competition_con">
                        <div class="competition_list" id="signUp_box">
                            <div class="signUp_title">报名资料</div>
                            <div class="signUp_form">
                                <div class="basic_infor">
                                    <p class="infor_title">基本信息</p>
                                    <div>
                                        <label for="signUp_name"><span class="asterisk">姓名</span></label>
                                        <input type="text" id="signUp_name" >
                                    </div>
                                    <div>
                                        <label for="signUp_sex"><span class="asterisk">性别</span></label>
                                        <div style="display: inline-block" class="sex_box">
                                            <input type="text" id="signUp_sex" readonly>
                                            <span class="choose_sex"><img src="${base}/assets/images/EduImg/signup_icon_triangle.png" alt=""></span>
                                            <ul class="sex_list sex_toggle">
                                                <li>男</li>
                                                <li>女</li>
                                            </ul>
                                        </div>
                                        <label for="signUp_sex"><span class="asterisk">年龄</span></label>
                                        <input type="text"  id="signUp_age" onkeyup = "value=value.replace(/[^\d]/g,'')" >
                                    </div>
                                    <div>
                                        <label ><span class="asterisk">手机号</span></label>
                                        <input type="text" id="phone" onkeyup = "value=value.replace(/[^\d]/g,'')">
                                    </div>
                                    <div>
                                        <label for="">联系邮箱</label>
                                        <input type="text" id="signUp_email" >
                                    </div>
                                    <div style="position: relative">
                                        <label for="">照片</label>
                                        <span class="choose_photo">
                                            <img src="${base}/assets/images/EduImg/signup_icon_photo.png" alt="" id="formPicUrl">
                                        </span>
                                        <span class="photo_upload"  onclick="$('#formUpLoadImg').click()">上传</span>
                                        <input id="formUpLoadImg" type="file" style="display: none" onchange="formUploadpic(this)">
                                    </div>
                                </div>
                                <div class="professional_infor">
                                    <p class="infor_title" style="margin-top: 30px">职业信息</p>
                                    <div class="professional_box">
                                        <label class="professional_title"><span class="asterisk">从事行业</span></label>
                                        <div style="position: relative;display: inline-block">
                                            <input type="text" id="signUp_work" readonly>
                                            <span class="choose_professional"><img src="${base}/assets/images/EduImg/signup_icon_triangle.png" alt=""></span>
                                            <ul class="professional sex_toggle">
                                                <li class="professional_student">学生</li>
                                                <li>企业员工</li>
                                                <li>其他</li>
                                            </ul>
                                        </div>


                                    </div>
                                    <div >
                                        <label class="company_title"><span>公司</span></label>
                                        <input type="text" id="signUp_company">
                                    </div>
                                    <div>
                                        <label class="position_title"><span>职位</span></label>
                                        <input type="text" id="signUp_position">
                                    </div>
                                    <div class="degree_box">
                                        <label class="degree_title"><span>学历</span></label>
                                        <div style="position: relative;display: inline-block">
                                            <input type="text" id="signUp_degree" readonly>
                                            <span class="choose_professional"><img src="${base}/assets/images/EduImg/signup_icon_triangle.png" alt=""></span>
                                            <ul class="degree sex_toggle">
                                                <li>博士</li>
                                                <li>硕士</li>
                                                <li>本科</li>
                                                <li>专科</li>
                                                <li>其他</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div>
                                        <label >备注</label>
                                        <textarea name="" id="signUp_note" ></textarea>
                                    </div>
                                </div>
                                <button class="signUp_btn">报名</button>
                            </div>
                        </div>

                    </div>


                </div>

            </div>
        </div>
    </#escape>
</@main.body>
<@main.mfooter>

    <script>
        $(document).on("click",function () {
            $('.sex_list').addClass('sex_toggle')
            $(".professional").addClass('sex_toggle')
            $(".degree").addClass('sex_toggle')
        })
        //性别下拉框
        $('.sex_box').on('click',function (e) {
            e.stopPropagation()
            $('.sex_list').toggleClass('sex_toggle')
        })
        $('.sex_list').on('click','li',function () {
            var text = $(this).text()
            $('#signUp_sex').val(text)
            $('.sex_list').removeClass('sex_toggle')
        })
        //从事行业下拉框
        $('.professional_box').on("click",function (e) {
            e.stopPropagation()
            $(".professional").toggleClass('sex_toggle')
        })
        var num = null,degreeFlag=false,positionFlag=false;
        $('.professional').on('click','li',function () {
            num = $(this).index()
            $("#signUp_work").focus();
            $("#signUp_work").val($(this).text())
            $("#signUp_work").blur();
        })
        //学历下拉框
        $('.degree_box').on("click",function (e) {
            e.stopPropagation()
            $(".degree").toggleClass('sex_toggle')
        })
        $('.degree').on('click','li',function () {
            var text = $(this).text()
            $('#signUp_degree').val(text)
            $('.degree').removeClass('sex_toggle')
        })
        //监听从事行业值的变化
        $('#signUp_work').bind('input propertychange blur change', function(){
            if(num == 0){
                $(".degree_title span").addClass("asterisk")
                $(".company_title span").removeClass("asterisk")
                $(".position_title span").removeClass("asterisk")
                degreeFlag = true
                positionFlag = false
            }else if(num == 1){
                degreeFlag = false
                positionFlag = true
                $(".company_title span").addClass("asterisk")
                $(".position_title span").addClass("asterisk")
                $(".degree_title span").removeClass("asterisk")
            }else {
                degreeFlag = false
                positionFlag = false
                $(".degree_title span").removeClass("asterisk")
                $(".company_title span").removeClass("asterisk")
                $(".position_title span").removeClass("asterisk")
            }
        })


        function formUploadpic(obj) {
            var docObj = document.getElementById("formUpLoadImg");
            var imgObjPreview = document.getElementById("formPicUrl");
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
        $('.signUp_btn').on('click',function () {
            var formData = new FormData();
            var name = $('#signUp_name').val(),
                sex = $('#signUp_sex').val(),
                age = $('#signUp_age').val(),
                phone = $('#phone').val(),
                email = $('#signUp_email').val(),
                work = $('#signUp_work').val(),
                company = $('#signUp_company').val(),
                position = $('#signUp_position').val(),
                degree = $('#signUp_degree').val(),
                note = $('#signUp_note').val();
            if(name == "" || sex == "" || age == "" || phone == "" || work == ""){
                layer.msg("必填项不能为空",false);
                return false
            }
            if(degreeFlag){
                if($("#signUp_degree").val() == ""){
                    layer.msg("学历不能为空",false);
                    return false
                }
            }
            if(positionFlag){
                if($("#signUp_company").val() == "" || $("#signUp_position").val() == ""){
                    layer.msg("公司或者职位不能为空",false);
                    return false
                }
            }
            var $email=$("#signUp_email").val();
            if($email){
                if(!$email.match(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/)){
                    layer.msg("邮箱格式不正确，请重新输入！");
                    $("#signUp_email").focus();
                    return false;
                }
            }
            formData.append('multipartFile', $('#formUpLoadImg')[0].files[0]);
            formData.append('name', name);
            formData.append("sex",sex);
            formData.append("age",age);
            formData.append("phone",phone);
            formData.append("work",work);
            formData.append("note",email);
            formData.append("company",company);
            formData.append("position",position);
            formData.append("degree",degree);
            formData.append("note",note);
            $.ajax({
                url:"${base}/matchSignUp/addData.json",
                traditional: true,
                type:"post",
                data:formData,
                dataType:"json",
                processData: false,
                contentType: false,
                success:function(data) {
                    if(data.success) {
                        layer.msg("报名成功",{icon: 1,time: 3000},function () {
                            window.location.href = "${base}/m/appCompetition.html"
                        });
                    }else {
                        layer.msg("报名失败");
                        return false;
                    }
                }
            })


        })

    </script>




</@main.mfooter>