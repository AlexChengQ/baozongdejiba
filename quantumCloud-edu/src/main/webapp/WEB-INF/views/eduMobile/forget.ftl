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
                                <h2>重置密码</h2>
                            </div>
                            <div class="from-label">
                                <div class="label">
                                    <p>注册邮箱</p>
                                </div>
                                <div class="from-enter">
                                    <input type="email" class="form-control" name="email" id="email" placeholder="<@spring.message code='placeholder_email' />" maxlength="32">
                                </div>
                            </div>

                            <div class="from-submit">
                                <button onclick="save();"><@spring.message code="send_volidate_message" /></button>
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
       $(".control").html("")
       function save(){
           layer.open({
               title: false,
               btn:false,
               closeBtn:0
               ,content: '发送中....'
           });
           re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
           if(!re.test($("#email").val())){
               layer.msg(messages.enter_email_true);
               return false;
           }else {

               // layer.msg("发送中")
           }



           var param ={};
           param.email = $("#email").val();

           // layer.msg("发送中",{shade :true})
           //表单提交
           $.ajax({
               url:"${base}/Mine/sendCheckEmail.json",
               data:param,
               async:false,
               cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
               type:'post',
               success:function(result){
                   if(result.code == 401){
                       window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                       return false;
                   }
                   if(result.success){
                       layer.msg(messages.send_message_login_mail)

                       setTimeout(function () {
                           window.location.href = "${base}/m/index.html";
                       },2000)
                   } else {
                       layer.msg(result.message);
                   }
               },
               error:function(){
                   layer.msg(messages.option_fail);
                   loading = false;
               }
           });
       }

   </script>
