<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class=" text-c" style="padding-top: 100px;">
    <img src="${base}/assets/images/game_bg.png" width="60%" />
    <p class="text-c p-t-20">请使用PC端打开官网体验最佳效果</p>
    <p class="text-c p-t-6">www.qubitonline.cn</p>
</div>
</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("小游戏");
	App.dragRefresh();
});
</script>
</@main.footer>