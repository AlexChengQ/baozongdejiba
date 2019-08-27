<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
    <link rel="stylesheet" href="${base}/assets/css/swiper.css" />
<script>
</script>

</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<#if USER_INFO?? >

    <!--我的头部-->
    <section class="my">
        <aside class="my-box">
            <div class="my-pic bounceIn animated">
            	<#if USER_INFO.face ??>
            	<img src="/${setting['files.contextpath']}${USER_INFO.face?replace("\\","/")}"/ >
            	<#else>
                <img src="${base}/assets/images/my-pic.png" />
            	</#if>
            </div>
            <h1 class="my-text">${USER_INFO.name}</h1>
            <#if USER_INFO.level == 1>
            	<p class="f14 f999 text-c">一级用户</p>
            <#elseif USER_INFO.level == 2>
            	<p class="f14 f999 text-c">二级用户</p>
            <#else>
            	<p class="f14 f999 text-c">三级用户</p>
            </#if>
        </aside>
    </section>
    
    <!--我的头部结束-->
    <!--主体部分-->
    <section class="p-t-20">
        <div class="weui-cells">
            <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Mine/myProject.html')">
                <div class="weui-cell__bd">
                    <p class="f14"><i class="iconfont icon-icon2"></i>&nbsp;&nbsp;我的项目</p>
                </div>
                <div class="weui-cell__ft">
                    <span class="weui-badge">${count!0}</span>
                </div>
            </a>
            <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Mine/changePsd.html')">
                <div class="weui-cell__bd">
                    <p class="f14"><i class="iconfont icon-mima-copy"></i>&nbsp;&nbsp;修改密码</p>
                </div>
                <div class="weui-cell__ft">
                </div>
            </a>
            <a class="weui-cell weui-cell_access" onclick="logOut();">
                <div class="weui-cell__bd">
                    <p class="f14"><i class="iconfont icon-tuichu"></i>&nbsp;&nbsp;退出</p>
                </div>
                <div class="weui-cell__ft">

                </div>
            </a>
        </div>
    </section>
    </#if>
</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("我的");
	App.dragRefresh();
	
});
function tabSelect(){
	window.location.reload();
}

//退出登陆
function logOut(){
	App.setToken("");
	App.openNewWithFlag('${base}/login.html',false);
	App.close();
	
}
</script>
</@main.footer>