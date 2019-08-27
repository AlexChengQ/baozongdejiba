<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.header>
    <#escape x as x?html>
        <@main.mathjax></@main.mathjax>
    </#escape>
    <style>
        body{
            background-color: #fff!important;
        }

        .bdshare-button-style0-16 a, .bdshare-button-style0-16 .bds_more{
            background: transparent!important;
            padding: 0;
            margin: 0;
            float: none;
        }
        .bd_weixin_popup{
            width: 260px!important;
            height: 300px!important;
        }
    </style>

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
                    <div class="EDU-banner" style="position: relative;">
                        <img src="${base}/assets/images/EduImg/homepage_banner.png" alt="">
                        <div class="swiper-slide-describe banner-text">
                            <div class="slide_banner_box">
                                <h1 class="banner_h1 competition_h1">本源量子首届量子编程大赛</h1>
                                <h6 class="banner_h3 competition_h3">Origin Quantum Computing+</h6>
                                <a href="${base}/EDU/signUp.html" class="competition_apply">立即报名</a>
                            </div>

                        </div>
                    </div>
                    <div class="competition_nav">
                        <ul>
                            <li class="nva_list"><a href="javascript:void(0)" class="nav_active">首页</a></li>
                            <li class="nva_list"><a href="javascript:void(0)">赛事详情</a></li>
                            <#--<li class="nva_list"><a href="javascript:void(0)">立即报名</a></li>-->
                            <li><a href="https://qcode.qubitonline.cn/qcode/forumtopic/index.html">讨论交流</a></li>
                            <li class="competition_results"><a href="javascript:void(0)">结果公布</a></li>
                        </ul>
                    </div>
                    <div class="competition_con">
                        <div class="competition_list">
                            <div class="Introduction">
                                <div class="Introduction_title">
                                    <p>Introduction</p>
                                    <p>大赛介绍</p>
                                </div>
                                <div class="Introduction_con">
                                    <p>
                                        量子计算是遵循量子力学规律进行运算的新型运算模式，在特殊的问题上，量子计算体现出了惊人的潜力，
                                        与传统的二进制运算模式相比量子计算采用量子比特进行信息处理，形成了强大的并行计算能力，
                                        使得在运算速度上远优于传统计算机。量子计算介于这样的优势，未来在物流运输、
                                        生物制药、人工智能等领域都将有着重要的影响。
                                    </p>
                                    <p>
                                        为此本源团队希望通过本次量子编程大赛，进一步提高人们对于量子编程的认识和理解，
                                        “孕育”未来的量子程序员，共同探索属于量子计算的未来。
                                    </p>
                                </div>
                            </div>
                            <div class="Schedule">
                                <div class="Schedule_con">
                                    <div class="Introduction_title">
                                        <p>Schedule</p>
                                        <p>赛程安排</p>
                                    </div>
                                    <div class="Schedule_date">
                                        <ul>
                                            <li>报名时间：7 月 20 日—7 月 27 日</li>
                                            <li> 比赛时间：7 月 29 日—8 月 3 日</li>
                                            <li>结果公布：8 月08 日</li>
                                            <li>奖励发放：自比赛结果公布起 15 日内发放 <span>(以邮寄方式发放)</span></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="Award">
                                <div class="Introduction_title">
                                    <p>Award</p>
                                    <p>奖项设置</p>
                                </div>
                                <div class="Award_con">
                                    <div class="first_prize">
                                        <h5>一等奖（1 人）</h5>
                                        <p>1500RMB</p>
                                        <p>荣誉证书 本源币奖励</p>
                                        <p>本源量子教材 本源优先录取机会</p>
                                        <p>本源量子高级开发课程优先体验权</p>
                                    </div>
                                    <div class="second_prize">
                                        <h5>二等奖（2 人）</h5>
                                        <p>1000RMB</p>
                                        <p>荣誉证书 本源币奖励</p>
                                        <p>本源量子教材 本源优先录取机会</p>
                                    </div>
                                    <div class="third_prize">
                                        <h5>三等奖（3 人）</h5>
                                        <p>500RMB</p>
                                        <p>荣誉证书 本源币奖励</p>
                                    </div>
                                    <div class="fourth_prize">
                                        <h5>四等奖（20 人）</h5>
                                        <p>荣誉证书 本源币奖励</p>
                                    </div>
                                </div>
                                <div class="note">
                                    <p class="note_first">
                                        【备注】 一、二、三等奖选手均可推荐国内外一流高校交流机会并可以推荐国内外一流企业实习工作机会
                                    </p>
                                    <p>
                                        本源币（云积分）奖励可用于本源量子各类收费服务
                                    </p>
                                    <p>
                                        所有获奖选手都可获得本源量子纪念 T 恤一件
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="competition_list" style="display: none" >
                            <div class="competition_content">
                                <div class="Introduction_title">
                                    <p>Content</p>
                                    <p>比赛内容 </p>
                                </div>
                                <div class="Introduction_con">
                                    <p>
                                        利用本源 QPanda 作为主要工具，解决量子计算问题 <br>
                                        包括但不仅限于：量子态的制备、量子算法线路设计、量子程序优化和 量子算法应用等
                                    </p>
                                </div>
                            </div>
                            <div class="Schedule">
                                <div class="Schedule_con">
                                    <div class="Introduction_title">
                                        <p>Form</p>
                                        <p>比赛形式</p>
                                    </div>
                                    <div class="Form_con">
                                        <ul>
                                            <li>本次比赛一律采用线上比赛模式<span>（线上报名、线上试题公示、线上内容提交、线上结果公示），详细时间请参阅赛程安排</span></li>
                                            <li>评委会将保持 “公正 公平” 为原则对参赛选手提交的内容进行统一审评</li>
                                            <li>审评完成后将公布最终的获奖名单</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="Criteria">
                                <div class="Introduction_title">
                                    <p>Criteria</p>
                                    <p>评选标准</p>
                                </div>
                                <div class="Criteria_con">
                                    <ul>
                                        <li>参赛选手需在规定时间内提交试题内容</li>
                                        <li>审评人员将对选手提交的程序进行测试，并以程序运行的速度、准确率等方面进行评判</li>
                                        <li>比赛结果将按分数由高到低依次排序，如分数相同会根据试题提交时间决定最终的排名</li>
                                        <li>如在比赛规定时间内未完成全部给定试题内容，也可提交</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="Reference">
                                <div class="Introduction_title">
                                    <p>Reference</p>
                                    <p>参考学习资料、课程 </p>
                                </div>
                                <div class="Reference_con">
                                    <p>
                                        本源 QPanda 开发者使用文档：<br>
                                        <a href="https://qpanda-2.readthedocs.io/zh_CN/latest/index.html">https://qpanda-2.readthedocs.io/zh_CN/latest/index.html</a>
                                    </p>
                                    <p>
                                        本源教育云限时免费课程：<br>
                                        <a href="https://learn-quantum.com/EDU/index.html">https://learn-quantum.com/EDU/index.html</a>
                                    </p>
                                </div>

                            </div>
                        </div>
                        <div class="competition_list" style="display: none" id="signUp_box">
                            <div class="signUp_title">报名资料</div>
                            <div class="signUp_form">
                                <div class="basic_infor">
                                    <p class="infor_title">基本信息</p>
                                    <div>
                                        <label for="signUp_name"><span>*</span>姓名</label>
                                        <input type="text" id="signUp_name" >
                                    </div>
                                    <div>
                                        <label for="signUp_sex"><span>*</span>性别</label>
                                        <div style="display: inline-block" class="sex_box">
                                            <input type="text" id="signUp_sex" readonly>
                                            <span class="choose_sex"><img src="${base}/assets/images/EduImg/signup_icon_triangle.png" alt=""></span>
                                            <ul class="sex_list sex_toggle">
                                                <li>男</li>
                                                <li>女</li>
                                            </ul>
                                        </div>
                                        <label for="signUp_sex"><span>*</span>年龄</label>
                                        <input type="text"  id="signUp_age" onkeyup = "value=value.replace(/[^\d]/g,'')" >
                                    </div>
                                    <div>
                                        <label ><span>*</span>手机号</label>
                                        <input type="text" id="phone" onkeyup = "value=value.replace(/[^\d]/g,'')">
                                    </div>
                                    <div>
                                        <label for="">联系邮箱</label>
                                        <input type="text" id="signUp_email"  value="${(email)!}">
                                    </div>
                                    <div style="position: relative">
                                        <label for="">照片</label>
                                        <span class="choose_photo">
                                            <input type="hidden" id="face" name="face">
                                            <img src="${base}/assets/images/EduImg/signup_icon_photo.png" alt="" id="picUrl">
                                        </span>
                                        <span class="photo_upload"  onclick="$('#upLoadImg').click()">上传</span>
                                        <input id="upLoadImg" type="file" style="display: none" onchange="uploadpic(this)">
                                    </div>
                                </div>
                                <div class="professional_infor">
                                    <div>
                                        <label >从事行业</label>
                                        <input type="text" id="signUp_work">
                                    </div>
                                    <div>
                                        <label >公司</label>
                                        <input type="text" id="signUp_company">
                                    </div>
                                    <div>
                                        <label >职位</label>
                                        <input type="text" id="signUp_position">
                                    </div>
                                    <div>
                                        <label >学历</label>
                                        <input type="text" id="signUp_degree">
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
<@main.footer>
    <script>
        $(document).on("click",function () {
               $('.sex_list').addClass('sex_toggle')
        })
        $('.sex_box').on('click',function (e) {
            e.stopPropagation()
            $('.sex_list').toggleClass('sex_toggle')
        })
        $('.sex_list').on('click','li',function () {
            var text = $(this).text()
            $('#signUp_sex').val(text)
            $('.sex_list').removeClass('sex_toggle')
        })
        $('.competition_results').on('click',function () {
            alert("敬请期待")
        })
        $('.nva_list').on('click',function () {
            var index = $(this).index()
            if($('.nva_list a').hasClass("nav_active")){
                $('.nva_list a').removeClass('nav_active')
            }
            $(this).find('a').addClass('nav_active')
            $('.competition_list').eq(index).show().siblings().hide()
        })
        $('.competition_apply').on('click',function () {
            $('.competition_list').eq(2).show().siblings().hide()
        })
        //上传照片
        function uploadpic(obj) {
            var docObj = document.getElementById("upLoadImg");
            var imgObjPreview = document.getElementById("picUrl");
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
            updloadImg();
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
            if(name == "" || sex == "" || age == "" || phone == ""){
                layer.msg("必填项不能为空",false);
                return false
            }
            if(sex == "男") {
                sex = '1';
            }else {
                sex = '0';
            }


            formData.append("userId","${USER_INFO.id}");
            formData.append('userName', name);
            formData.append("sex",sex);
            formData.append("age",age);
            formData.append("tel",phone);
            formData.append("industry",work);
            formData.append("email",email);
            formData.append("company",company);
            formData.append("position",position);
            formData.append("education",degree);
            formData.append("remarks",note);
            formData.append("face",$("#face").val());
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
                        layer.msg("提交成功");
                    }else {
                        layer.msg("提交失败");
                        return false;
                    }
                }
            })


        })


        function updloadImg() {
            var formData = new FormData();
            formData.append('imgFile', $('#upLoadImg')[0].files[0]?$('#upLoadImg')[0].files[0]:"");
            $.ajax({
                url:"${base}/matchSignUp/uploadImg.json",
                traditional: true,
                type:"post",
                data:formData,
                dataType:"json",
                async:false,
                processData: false,
                contentType: false,
                success:function(data) {
                    var img = data.obj;
                    $("#face").val(img);
                },
            })
        }

    </script>
</@main.footer>