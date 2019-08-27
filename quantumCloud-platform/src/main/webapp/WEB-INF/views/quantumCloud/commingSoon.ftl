<#-----author:JT------->
<#-----date:2018-01-09------->
<@main.header>
<#escape x as x?html>
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
<!--box-->
<#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
    <div style="margin: 0 auto; padding-top:200px;text-align: center;padding-bottom:250px;">
        <img src="${base}/assets/images/loading.gif" style="width:210px;" height="210" />
        <p style="color:#333;font-size: 28px;padding-top: 20px;">敬请期待</p>
    </div>
</#escape>
</@main.body>
<@main.footer>
<script>
    //用户下拉
    $('.mingzi').mouseenter(function () {
        $('.admin-none').css('display','block');
    });
    $('.admin-none').mouseleave(function () {
        $(this).css('display','none')
    });
    $('.admin').mouseleave(function () {
        $('.admin-none').css('display','none');

    });

</script>
</@main.footer>