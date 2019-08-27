<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">请输入旧密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r  filteEmoji" type="password" id="oldPsd" name="oldPsd"  placeholder="请输入">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">请输入新密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r filteEmoji" type="password" id="password" name="password" placeholder="请输入">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">确认新密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r filteEmoji" type="password" id="confirmPsd" name="confirmPsd" placeholder="请输入">
        </div>
    </div>

</div></#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/md5.js"></script>
<script type='text/javascript' src="${base}/assets/views/js/mine/setPassword.js"></script>
</@main.footer>