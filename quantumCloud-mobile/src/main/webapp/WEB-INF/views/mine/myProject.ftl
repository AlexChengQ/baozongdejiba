<@main.header>
</@main.header> 
<@main.body>
<#if pager?? && (pager.entityList)?size gt 0>
<#list pager.entityList as project>
<div class="title-box m-t-16 case-shadow">  
    <div class="pd16" style="padding-bottom: 0;">
         <h1 class="f16">${(project.name)!}<h1>
        <#if project.pic??>
          <img src="/${setting['files.contextpath']}${project.pic?replace("\\","/")}" width="100%" height="120"/>
		<#else>
		  <img src="${base}/assets/images/pic.jpg" width="100%" height="120"/>
		</#if>		   
    </div>
    <div class="case-list">
        <a onclick="App.openNew('${base}/QCode/program.html?projectId=${project.id!}')" class="green">查看详情</a>
        <a onclick="App.confirm({message:'确定删除该项目？',callback:'delProject',params:{id:${project.id!}}});" class="red">删除</a>
    </div>
</div> 
</#list> 
   <#if (pager.entityList?size>=pager.pageSize)>
		<div class="weui-loadmore"  style="text-align: center;">
			<i class="weui-loading"></i>
			<span class="weui-loadmore__tips">正在加载</span>
		</div>
   </#if>
 
<#else>
	<#include '../common/noData.html'/>
</#if>
</@main.body>
<@main.footer>
<script>
	var hasMore = false;
	var loading = false;

	var img_url = "${setting['files.contextpath']}";
	<#if pager?? && (pager.entityList)?exists && ((pager.entityList)?size != 0)>
		hasMore = true;
		var pager ;
		var count = ${pager.totalRecords};
		var pageSize = ${pager.pageSize};
		var nextPage = ${pager.nextPage};
		var pageNum = ${pager.pageNum};
	</#if>
	
	$(function() {
		App.setTitle("我的项目");
		App.dragRefresh();
	});
	
	function onResume(){
		window.location.reload();
	}
		
	function onPageEnd(){
		if(hasMore)
		lazyLoading();
	};
	function lazyLoading(){
		if(loading){
			return;
		}
		loading = true;
		if(pageNum >= nextPage){
		  	noMore();
			return ;
	  	}
		var params = {};
	  	params.pageNum = 1;     
	  	params.limit = 8;
	  	if(pager != null){
			pager.pageNum += 1;
		  	params = pager;
		  	params.limit = pager.pageSize;
	  	}
	  	
	  	params.start = (nextPage - 1) * pageSize;
	  	$.post('${base}/Mine/myProject.json', params, function(data) {
	  	
	  		if ('401' == data.code) {
	      		App.prompt("重新登录");
	      		setTimeout(function () {
	        		App.openNew(data.message);
	      		},1000);
	    	}
		  	if(data.success) {
	  			var dataObj = data.obj.entityList;
	  			nextPage = data.obj.nextPage;
	  			pageNum = data.obj.pageNum;
	  			pager = data.obj;
				var content=getHtml(dataObj);
				$(".weui-loadmore").before(content);
				if(dataObj==null||dataObj.length<data.obj.pageSize||(data.obj.pageNum>=data.obj.nextPage)){
					loading = true;
				}else{
					loading = false;
				}
	  			if(dataObj==null || dataObj.length < data.obj.pageSize||(data.obj.pageNum>=data.obj.nextPage)){
	  				noMore();
	  				return false;
	  			}
      		}else {
      			App.prompt(data.message);
  			}
	  	});
	}
		
			//动态加载下拉数据
			function getHtml(dataObj){
				if(dataObj != null){
					var content = "";
					for(var i = 0 ; i < dataObj.length ; i++){
						var obj = dataObj[i];
						var pic = obj.pic;
						if(obj != null){
							content += '<div class="title-box m-t-16 case-shadow">  ';
							content += '	<div class="pd16" style="padding-bottom: 0;">';
							content += '		<h1 class="f16">'+obj.name+'</h1>';
							if(pic){
								content += '<img src="'+img_url + pic.replace("\\","/")+'" width="192" height="120"/>';
							}else{
								content += '<img src="${base}/assets/images/pic.jpg" />';
							} 
							content += '	</div>';
							content += '	<div class="case-list">';
							content += '		<a onclick="App.openNew('+"'${base}/QCode/program.html?projectId="+obj.id+"'"+')" class="green">查看详情</a>';
							content += '		<a onclick="App.confirm({message:'+"'确定删除该项目？'"+',callback:'+"'delProject'"+',params:{id:'+obj.id+'}});">删除</a>';
							content += '	</div>';
							content += '</div>';
						}
					}
					return content;
				}
			}
				    
		function noMore() {
		  		//拉到最底部的处理
				$(".weui-loadmore__tips").text("没有更多了");
				$(".weui-loading").css("display","none");
				//$(document.body).destroyInfinite();
			}
		
		
		function delProject(params){
				if(!isLogin()){return false;}
					$.ajax({
						url:"${base}/Mine/delProject.json",
						data:params,
						cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
						type:'post', 
						success:function(result){
							if(result.code == 401){
				                window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
					            return false;
				            }
							if(result.success){ 
								App.refreshParent();
						        window.location.reload(true);
							} else {
								App.prompt(result.message);
							}
						},
						error:function(){		
							App.prompt(messages.server_is_busy);
						}
					});	
			}    
		
</script>

</@main.footer>