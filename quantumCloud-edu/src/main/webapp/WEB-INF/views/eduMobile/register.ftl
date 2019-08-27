<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader title="注册">
    <#escape x as x?html></#escape>
</@main.mHeader>
<@main.body >
    <#escape x as x?html>
        <div class="contentBox" style="padding: 0;">
            <!--top-->

            <div class="content">
                <@main.mobileTop>
                    <#escape x as x?html></#escape>
                </@main.mobileTop>
                <div class="bannerOrSwiper">
                    <div class="loginCtrl">
                        <div class="loginCon registered">
                            <div class="loginTitle">
                                <h2>账号登录</h2>
                            </div>
                            <div class="from-label">
                                <div class="from-enter">
                                    <input type="email" class="form-control" name="email" id="email" placeholder="<@spring.message code='placeholder_email' />" maxlength="32">
                                </div>
                            </div>
                            <div class="from-label" style="display:none;">
                                <div class="from-enter">
                                    <input type="text" placeholder="请设置您的账户名" id="name" name="name">
                                </div>
                            </div>

                            <div class="from-label">
                                <div class="from-enter">
                                    <input type="password" class="form-control" name="password" id="password" placeholder="请输入您的密码(<@spring.message code='placeholder_password_6' />)" maxlength="50">
                                </div>
                            </div>
                            <div class="from-label">
                                <div class="from-enter">
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="请再次确认密码(<@spring.message code='placeholder_password_6' />)" maxlength="50">
                                </div>
                            </div>
                            <div class="from-label">
                                <div class="from-enter">
                                    <div class="verification">
                                        <input type="text" id="captcha" name="captcha" class="form-control"  placeholder="<@spring.message code='placeholder_captcha' />" maxlength="10" />
                                    </div>
                                    <div class="codeImg" style="float:left;">
                                        <img id="captchaImage" style="cursor:pointer;" src="${base}/assets/register_vcode_image.jsp"/>
                                    </div>
                                </div>
                            </div>

                            <div class="from-submit">
                                <button onclick="register()">完成注册</button>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </#escape>
</@main.body>
<script type="text/javascript" src="${base}/assets/js/messages_${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}.js"></script>
    <script src="${base}/assets/js/md5.js"></script>
    <script src="${base}/assets/js/layer/layer/layer.js"></script>
    <script>
        // 注册
        $(".control").html("")
        $(".control").html('<a href="javascript:void(0)" class="registered_page" onclick="login()">登录已有账号</a>')
        var forward = "${forward!}";
        function register(){
            re = /^(\w-*\.*)+@(\w-?)+(\.\w+)+$/;
            if(!re.test($("#email").val())){
                layer.msg(messages.enter_email_true);
                return false;
            }
            var password = $("#password").val();
            var confirmPassword = $("#confirmPassword").val();
            /**if ((!/^[A-Za-z0-9]{8,16}$/.test(password))||(!/^[A-Za-z0-9]{8,16}$/.test(confirmPassword))) {
	 	layer.msg(messages.password_six_to_eight);
        return false;
    }*/
            if (password.length<6){
                layer.msg(messages.password_six);
                return false;
            }
            if (confirmPassword.length<6){
                layer.msg(messages.confirm_password_six);
                return false;
            }
            if(password!=confirmPassword){
                layer.msg(messages.password_not_same);
                return false;
            }
            var code = $("#captcha").val();
            if(code==''){
                layer.msg(messages.volidate_code_not_null);
                return false;
            }

            var param ={};
            param.email = $("#email").val();
            param.name = $("#name").val();
            param.orgName = $("#orgName").val();
            param.password = $.md5(password);
            param.code = code;
            //表单提交
            $.ajax({
                url:"${base}/Register/registerSave.json",
                data:param,
                cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
                type:'post',
                success:function(result){
                    if(result.code == 401){
                        window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                        return false;
                    }
                    if(result.success){
                        layer.msg("注册成功，即将跳转至登录页")
                        setTimeout(function () {
                            if(forward!=null&&forward!=''){
                                location.href = forward;
                            }else{
                                location.href = "${base}/m/login.html";
                            }
                        },1000)
                    } else {
                        layer.msg(result.message);
                    }
                },
                error:function(){
                    layer.msg(messages.register_fail);
                    loading = false;
                }
            });
        }

        // 更换验证码
        $('#captchaImage').click(function(){
            $('#captchaImage').attr("src", "${base}/assets/register_vcode_image.jsp?timestamp=" + (new Date()).valueOf());
        });

        //跳转登陆页面
        function login(){

            var forward = "${forward!}";
            if(forward!=null&&forward!=''){
                window.location.href = "${base}/m/login.html?forward="+forward;
            }else{
                window.location.href = "${base}/m/login.html";
            }

        }
    </script>
