<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <div class="container">
            <div class="row" style="margin-top: 150px">

                <div class="col-xl-12 col-sm-12 col-md-6">
                    <div style="width: 100%;height: 520px;background-color: #fff;position: relative">
                        <#--密码修改-->
                        <div class="modal-header" style="height: 50px;border-bottom: 2px dashed #e3e3e3;"><h4 class="modal-title" id="myModalLabel"><@spring.message code='Resetpassword' /></h4></div>
                        <div class="modal-body">
                            <form class="form-horizontal">
                                <div class="form-group">
                                    <label for="inputPassword3"
                                           class="col-sm-2 control-label"><@spring.message code="password" /></label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" name="password" id="password"
                                               placeholder="<@spring.message code='placeholder_password_6' />"
                                               maxlength="50">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPassword8"
                                           class="col-sm-2 control-label"><@spring.message code="confirm_password" /></label>
                                    <div class="col-sm-10">
                                        <input type="password" class="form-control" name="confirmPassword"
                                               id="confirmPassword"
                                               placeholder="<@spring.message code='placeholder_password_6' />"
                                               maxlength="50">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <#--<div class="modal-footer" style="text-align: left;position: absolute;bottom: 0;width: 100%;    border-top:2px dashed #e5e5e5;padding: 15px;">-->
                        <div class="modal-footer" style="text-align: right;border-top:1px solid #e5e5e5;padding: 15px;">
                            <button style="" type="button" class="btn btn-primary" onclick="savePassword();"><@spring.message code="save" /></button>
                        </div>
                        <#--个人信息修改-->
                        <div class="modal-header" style="height: 50px;border-bottom: 2px dashed #e3e3e3;"><h4 class="modal-title" id="myModalLabel"><@spring.message code='Account' /></h4></div>
                            <form id="myFormId">
                                <div class="modal-body">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label
                                                   class="col-sm-2 control-label"><@spring.message code="application_Email" /></label>
                                            <div class="col-sm-10 base_div" style="margin-top: 7px">
                                                <span>${userInfo.email}</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="name"
                                                   class="col-sm-2 control-label"><@spring.message code="application_name" /></label>
                                            <div class="col-sm-10 base_div">
                                                <input type="text" class="form-control" id="name" name="name"
                                                       value="${userInfo.name}" maxlength="20"
                                                       placeholder="<@spring.message code="application_placeholder_name" />">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="orgName"
                                                   class="col-sm-2 control-label"><@spring.message code="application_organization" /></label>
                                            <div class="col-sm-10 base_div">
                                                <input type="text" class="form-control" id="orgName" name="orgName"
                                                       value="${userInfo.orgName}" maxlength="20"
                                                       placeholder="<@spring.message code="application_placeholder_orgName" />">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary  "
                                        onclick="saveApplication()"><@spring.message code="application_submit" /></button>
                            </div>
                    </div>

                </div>
                <div class="col-xl-12 col-sm-12 col-md-6">
                    <div style="width: 100%;height: 520px;background-color: #fff;position: relative">
                        <div class="modal-header" style="height: 50px;border-bottom: 2px solid #e3e3e3;"><h4 class="modal-title" id="myModalLabel">API Key</h4></div>
                        <div class="modal-body">
                            <div class="contentt clear">
                                <div>
                                    <input type="hidden" id="typeId" value="1">
                                    <div class="zi">
                                        <div class="zi-left" taskType="1" style="width:100%;">
                                            <p id="apiKeyContent">${(userInfo.apiKey)!}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="" style="text-align: center;position: absolute;bottom: 0;width: 100%;    border-top: 2px solid #e5e5e5;padding: 15px;">
                            <button type="button" class="btn btn-primary"
                                    onclick="createKey(1);"><@spring.message code="regenerate"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--box end-->
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script type='text/javascript' src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>
<script >
    $(document).ready(function () {
        //用户等级的设置
        $("select[name=level]").find("option[value='${userInfo.level!}']").attr("selected", true);
        $("select[name=level]").find("option[value='${userInfo.level!}']").click();
        checkEmail();
    });
    function checkEmail() {
        re = /^(\w-*\.*)+@(\w-?)+(\.\w+)+$/;
        if (!re.test($("#email").val())) {
            $('#email').val('');
        }
    }
    function saveApplication() {
        if (validateFormData()) {
            $.ajax({
                type: 'post',
                traditional: true,
                url: '${base}/QCode/updUserInfo.json',
                data: $("#myFormId").serialize(),
                success: function (data) {
                    switch (data.code) {
                        case 401:
                            var n = noty({
                                text: data.message,
                                type: 'error',
                                dismissQueue: true,
                                layout: 'topCenter',
                                theme: 'relax',
                                timeout: 1500,
                                callback: {     // 设置回调函数
                                    afterClose: function () {}
                                }
                            });
                            break;
                        default:
                            if (data.success) {
                                var n = noty({
                                    text: messages.user_application_is_submit,
                                    type: 'success',
                                    dismissQueue: true,
                                    layout: 'topCenter',
                                    theme: 'relax',
                                    timeout: 1500,
                                    callback: {     // 设置回调函数
                                        afterClose: function () {}
                                    }
                                });
                            } else {errorMsg(data.message);}
                    }
                },
                error: function (data) {errorMsg(messages.server_is_busy);}
            });
        }
    }
    function validateFormData() {
        re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
//        if (!re.test($("#name").val())) {
//            errorMsg(messages.name_not_null);
//            return false;
//        }
        if ($("#name").val()=='') {
            errorMsg(messages.name_not_null);
            return false;
        }
        if ($("#orgName").val() == '') {
            errorMsg(messages.org_not_null);
            return false;
        }
        return true;
    }
    var isEmail = "${isEmail!''}";

    function savePassword(){
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();
        var email = "${userInfo.email!}";
        var createTime = "";
        if(isEmail!=null && isEmail!=undefined && isEmail=="true"){
            email = "${emailStr!''}";
            createTime = "${createTimeStr!''}";
        }

        /**if ((!/^[A-Za-z0-9]{8,16}$/.test(password))||(!/^[A-Za-z0-9]{8,16}$/.test(confirmPassword))) {
	 	errorMsg(messages.password_six_to_eight);
        return false;
    }*/
        if (password.length<6){
            errorMsg(messages.password_six);
            return false;
        }
        if (confirmPassword.length<6){
            errorMsg(messages.confirm_password_six);
            return false;
        }
        if(password!=confirmPassword){
            errorMsg(messages.password_not_same);
            return false;
        }
        var param ={};
        param.confirmPassword = confirmPassword;
        param.password = password;
        param.email = email;
        param.createTime = createTime;
        param.isEmail = isEmail;

        //表单提交
        $.ajax({
            url:"${base}/Mine/modifySave.json",
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
                    var n = noty({
                        text        : messages.pwd_update_success,
                        type        : 'success',
                        dismissQueue: true,
                        layout      : 'topCenter',
                        theme       : 'relax',
                        timeout		: 1500,
                        callback: {     // 设置回调函数
                            afterClose: function() { window.location.href = "${base}/logout.html";}
                        }
                    });
                } else {errorMsg(result.message);}
            },
            error:function(){
                errorMsg(messages.option_fail);
                loading = false;
            }
        });
    }


    //生成API KEY
    //isRepeat是否重新生成
    function createKey(isRepeat){
        var param ={};
        param.isRepeat = isRepeat;
        $.ajax({
            url:"${base}/QCode/createKey.json",
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            data:param,
            type:'post',
            success:function(result){
                if(result.code == 401){
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if(result.success){
                    $("#apiKeyContent").text(result.obj);
                    //$('#apiKeyModel').modal('show');
                } else {errorMsg(messages.option_fail);}
            },
            error:function(){errorMsg(messages.option_fail);}
        });
    }
</script>
</@main.footer>
