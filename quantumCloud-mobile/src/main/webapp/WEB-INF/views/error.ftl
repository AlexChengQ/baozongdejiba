<#-----author:JT------->
<#-----date:2016-05-05------->
<@main.header>
	<#escape x as x?html> 
		<script>
			function reload(){
				location.href = app.getUrl();
			}
		</script>
	
	</#escape>
</@main.header>
<@main.body>
	<#escape x as x?html> 
	    <article class="box-content">
        	<section class="no-data">
            	<img src="${base}/assets/images/shibai.png" />
            	<h1>加载失败</h1>
			</section>
			<div class="loading">
				<a href="javascript:reload();">重新加载</a>
			</div>
		</article>
	</#escape>
</@main.body>
<@main.footer>
</@main.footer>
