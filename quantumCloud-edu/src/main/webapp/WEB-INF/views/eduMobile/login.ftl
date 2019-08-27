<#-----author:lxt------->
<#-----date:2016-05-05------->
<@main.mHeader title="登录">
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
                        <div class="loginCon">
                            <div class="loginTitle">
                                <h2>账号登录</h2>
                            </div>
                            <div class="from-label">
                                <div class="label">
                                    <p>账号</p>
                                </div>
                                <div class="from-enter">
                                    <input type="text" placeholder="请输入Email地址" id="email" name="email">
                                </div>
                            </div>
                            <div class="from-label">
                                <div class="label">
                                    <p>密码</p>
                                </div>
                                <div class="from-enter">
                                    <input type="password" placeholder="请输入密码" id="password" name="password">
                                </div>
                            </div>
                            <div class="from-checkbox">
                                <div class="from-checked">
                                    <i></i>
                                    <span>记住账号</span>
                                </div>
                                <div class="forget">
                                     <a href="javascript:void(0)" onclick="toForget()">忘记密码?</a>
                                </div>
                            </div>
                            <div class="from-submit">
                                <button onclick="submitLogin()">登录</button>
                            </div>
                            <div class="registered_link">
                                <a href="javascript:void (0)" class="btn-sign-up">没有账号立即注册</a>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </#escape>
</@main.body>
    <script src="${base}/assets/js/md5.js"></script>
    <script src="${base}/assets/js/layer/layer/layer.js"></script>
    <script>
        // 登录
        $(".control").html("")
        $(".from-checked").on("click",function () {
            if($(this).hasClass("active")){
                $(this).removeClass("active")
            }else {
                $(this).addClass("active")
            }
        })

        $(document).keydown(function(event) {
            if (event.keyCode == 13) {
                submitLogin();
            }
        });

        if(getCookie("isCookies")==1){
            $(".from-checked").addClass("active");
            $("input[name='email']").val(getCookie("getUsername"));
            $("input[name='password']").val(getCookie("getPassword"))
        }else {
            $("input[name='email']").val('');
            $("input[name='password']").val('')
        }

        <#--if (window.parent != window) {-->

        <#--window.parent.location.href = "${base}/login";-->
        <#--}-->


        $(document).ready(function() {
            var forward = "${forward!}";
            $(".btn-sign-up").click(function() {

                if(forward!=null&&forward!=''){
                    parent.location.href = "${base}/m/register.html?forward="+forward;
                }else{
                    parent.location.href = "${base}/m/register.html";
                }

            });

            $(".to_wechat").click(function() {
                parent.location.href = "${weChatLogin!}"
            });

        });


        //设置cookie
        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays*24*60*60*1000));
            var expires = "expires="+d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;
        }
        //获取cookie
        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i=0; i<ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0)==' ') c = c.substring(1);
                if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
            }
            return "";
        }
        //清除cookie
        function clearCookie(name) {
            setCookie(name, "", -1);
        }
        //忘记密码
        function toForget(){
            window.parent.location.href="${base}/m/forget.html";
        }


        //    完成登录
        var forward = "${forward!}";
        function submitLogin() {
            var forward = "${forward!}";
            var params = {};
            params['email'] = $("input[name=email]").val();
            params['password'] = $.md5($("input[name=password]").val());

            if(params['email']==''||params['email']==null){
                $("input[name=email]").attr('placeholder','请输入邮箱地址');
                $("input[name=email]").addClass("active");
                return false;
            }else {
                $("input[name=email]").removeClass("active");
            }

            if($("input[name=password]").val()==''||$("input[name=password]").val()==null){
                $("input[name=password]").attr('placeholder','请输入密码');
                $("input[name=password]").addClass("active");
                return false;
            }else {
                $("input[name=password]").removeClass("active");
            }
            $.post('${base}/doLogin.json', params, function(data) {
                if (data.success) {
                    $(".ajaxError").hide();
                    if($(".from-checked").hasClass("active")){
                        setCookie("isCookies",1);
                        setCookie("getUsername", $("input[name='email']").val());
                        setCookie("getPassword", $("input[name='password']").val());
                    }else{
                        setCookie("isCookies",'0');
                        setCookie("getUsername", '');
                        setCookie("getPassword", '')
                    }
                    if(forward!=null&&forward!=''){
                        window.parent.location.href = forward;
                    }else{
                        window.location.href='${base}/m/index.html'
                    }

                } else {
                    layer.msg(data.message)
                }
            });
        }

    </script>
