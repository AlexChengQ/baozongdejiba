<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="text-c p-t-20">
    <img src="${base}/assets/images/img_06.png" width="90%" onclick="App.openNew('${base}/game/afterClick.html')"/>
</div>

<div class="text-c p-t-20">
    <img src="${base}/assets/images/img_07.png" width="90%" onclick="App.openNew('${base}/game/afterClick.html')"/>
</div>

</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("小游戏");
});
</script>
</@main.footer>