<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div style="text-align: center;position: absolute;left: 0;right:0;top:50%;margin: -140px auto 0;">
    <img src="${base}/assets/images/loading.gif" style="width:210px;" height="210" />
    <p style="color:#333;font-size: 20px;padding-top: 20px;">敬请期待</p>
</div>
</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("敬请期待");
});
</script>
</@main.footer>