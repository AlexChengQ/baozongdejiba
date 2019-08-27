<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content" style="min-width:1200px;">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
<!--top end-->
<!--box-->
	<#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
	<form method="post" id="searchForm" action="${base}/QCode/project.html" autocomplete="off">
    <div class="my-list">
        <ul>
        	<#if pager?? && (pager.entityList)?size gt 0>
    			<#list pager.entityList as project>  
		            <li>
		                <span><a onclick="delProject(${project.id!});"><i class="iconfont icon-cha1 f16"></i></a>  </span>
		                <p>
		                	<#if lang?? && lang?string=="en_US">
			            		${project.nameEnglish!project.name}
			            	<#else>
			            		${(project.name)!}
			            	</#if>
			            </p>
		                <a href="${base}/QCode/index.html?projectId=${project.id!}"> 
		                	<#if project.pic??>
		                    <img src="/${setting['files.contextpath']}${project.pic?replace("\\","/")}" width="192" height="120"/>
		                    <#else>
		                    <img src="${base}/assets/images/pic.jpg" />
		                    </#if>		                
		                </a>
		            </li>
		         </#list>
				<#else >
                    <div style="margin: 0 auto; padding-top:100px;text-align: center;padding-bottom:250px;">
                        <div style="width: 694px;height: 400px;border: 1px solid #e5e5e5;background-color: #fff;margin: 0 auto">
							<div style="font-size: 24px;margin-top: 80px;   font-family:Source Han Sans;">您还没有项目</div>
							<div><a href="${base}/QCode/index.html" style="display: block;width: 180px;height: 34px;color: #fff;text-align: center;line-height: 34px;background-color: #22a5de;margin:  30px auto">点击去新建一个吧</a></div>
						</div>
                    </div>
		     </#if>        
        </ul>
    </div>
    <div class="fenye">
        <nav aria-label="Page navigation" style="margin: -100px auto">
			<@main.pagination pager=pager/>
        </nav>
    </div>
    </form>
<!--box end-->
</div>
</#escape>
</@main.body>
<@main.footer>
<script type="text/javascript" src="${base}/assets/js/dialog.js"></script>
<script>
function delProject(id){
	if(!isLogin()){return false;}
    Dialog.confirm({title:'<@spring.message code="Operating_instructions" />',message: messages.delete_engineering}).on(function (e) {
        if (!e) {return;}
        //表单提交
		$.ajax({
			url:"${base}/QCode/delProject.json",
			data:{"id":id},
			cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
			type:'post', 
			success:function(result){
				if(result.code == 401){
	                window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
		            return false;
	            }
				if(result.success){ 
			        window.location.reload(true);
				} else {
		  			errorMsg(result.message);
				}
			},
			error:function(){errorMsg(messages.server_is_busy);}
		});	
	});
}    
</script>
</@main.footer>