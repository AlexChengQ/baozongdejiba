<@apimain.apiheader title="历史版本">
<#escape x as x?html>
 </#escape> 
</@apimain.apiheader>

<@main.body>
<#if pager?? && pager.entityList?size gt 0>
<div class="topDiv">
  <#list pager.entityList as qcodeProjectVersion>
	<div class="title-box m-t-16 case-shadow" id="${qcodeProjectVersion.id!}">
	    <div class="pd16" style="padding-bottom: 0;">
	        <h1 class="f16"> ${qcodeProjectVersion.name!} 创建时间：${qcodeProjectVersion.createTime?string('yyyy-MM-dd HH:mm:ss')}</h1>
            <#if qcodeProjectVersion.pic??&&qcodeProjectVersion.pic!=''>
               	<img src="${base}/${setting['files.contextpath']}${qcodeProjectVersion.pic?replace("\\","/")}" width="100%" />
            <#else>
               	<img src="${base}/assets/images/pic.jpg"  width="100%"/>
            </#if>   	        
	    </div>
	    <div class="case">
	        <a href="javascript:void(0)" onclick="changeVersion(${qcodeProjectVersion.projectId!},${qcodeProjectVersion.id!});" class="blue" >切换版本${qcodeProjectVersion.projectId!},${qcodeProjectVersion.id!}</a>
	        <a href="javascript:void(0)" onclick="vDetails(${qcodeProjectVersion.id!})" class="green">查看任务</a>
	        <a href="javascript:void(0)" class="red" onclick="delVersions(${qcodeProjectVersion.id!})">删除</a>
	    </div>
	</div> 
  </#list>
  <#if (pager.entityList?size>=pager.pageSize)>
		<div class="weui-loadmore"  style="text-align: center;">
			<i class="weui-loading"></i>
			<span class="weui-loadmore__tips">正在加载</span>
		</div>
   </#if>
</div>  
<#else>
	<#include '../common/noData.html'/>
</#if>
</@main.body>
<@apimain.apifooter>
<link href="${base}/assets/views/js/program/need/layer.css" rel="stylesheet">
<script src="${base}/assets/views/js/program/layer.js"></script>
<script>
$(function() {
	//App.setTitle("历史版本");
	//App.dragRefresh();
});	
	var picPath = '${base}/${setting['files.contextpath']}';
	var hasMore = false;
	var loading = false;
	<#if pager?? && (pager.entityList)?exists && ((pager.entityList)?size != 0)>
		hasMore = true;
		var pager ;
		var count = '${pager.totalRecords}';
		var pageSize = '${pager.pageSize}';
	</#if>

	//下拉加载
	function onPageEnd(){
		if(hasMore)
		lazyLoading();
	};

function confirmcallback(message,truefun,falsefun){
   // var msg=confirm(message);

    // if(msg==true){
    //     // alert("确定");
    //     delVersion(falsefun)
    //     truefun;
    //     return true;
    // }else{
    //     // alert("取消");
    //     falsefun;
    //     return false;
    // }
    //询问框
    layer.open({
        content: message
        ,btn: ['确定', '取消']
        ,yes: function(index){
            delVersion(falsefun)
            layer.close(index);
        }
    });
    $("body").find(".layui-layer-dialog").css({"left":parseInt($(this).offsetLeft)/2+"px"})
}

// 查看任务
	function vDetails(id) {
        window.injectedObject.skipWebviewFunction("${base}/api/revisionsDetail.html?versionId="+id,"任务详情")
    }
    //删除任务
	function delVersions(id) {
        confirmcallback('确定删除该版本？',delVersion,id);
    }
	function lazyLoading(){
		if(loading){
			return;
		}
		loading = true;
		if(count<=pageSize){
		  	noMore();
			return ;
	  	}
		var params = {};
	  	params.pageNum = 2;     
	  	params.limit = 10;
	  	if(pager!=null){
			pager.pageNum +=1;
		  	params = pager;
		  	params.limit = pager.pageSize;
	  	}
	  	//params.projectId = '${RequestParameters.projectId!}';
	  	
	  	params.start= (params.pageNum-1)*params.limit;
	  	
	  	$.post("${base}/api/revisions.json", params, function(data){
	      	if(data.success) {
		  			var dataObj = data.obj.entityList;
		  			pager = data.obj;
		  			var content=loadingData(dataObj);
		  			$(".weui-loadmore").before(content);
		  			if(dataObj==null||dataObj.length<data.obj.pageSize||(data.obj.pageNum>=data.obj.nextPage)){
		  				noMore();
		  				return false;
		  			}
				if(dataObj==null||dataObj.length<data.obj.pageSize||(data.obj.pageNum>=data.obj.nextPage)){
					loading = true;
				}else{
					loading = false;
				}
	      	}else {
	      		alert(data.message);
	  		}
	  	});
	}
	

	
	//动态加载下拉数据
	function loadingData(dataObj){
		if(dataObj!=null){
	  		var content = "";
			for(var i=0;i<dataObj.length;i++){
				var obj = dataObj[i];
				if(obj!=null){
					content += '<div class="title-box m-t-16 case-shadow" id="'+obj.name+'">';
					content += '	<div class="pd16" style="padding-bottom: 0;">';
					content += '		<h1 class="f16">'+obj.name+'创建时间：'+obj.createTime+'</h1>';
					content += '		<img src="${base}/'+picPath+obj.pic.replace("\\","/")+'" width="100%" />';
					content += '	</div>';
					content += '	<div class="case">';
					content += '		<a href="javascript:void(0)" onclick="window.injectedObject.skipWebviewFunction("${base}/api/program.html?projectId='+obj.projectId+'&versionId='+obj.id+'","版本详情");" class="blue">切换版本</a>';
					content += '		<a href="javascript:void(0)" onclick="window.injectedObject.skipWebviewFunction("${base}/api/program.html?projectId='+obj.projectId+'&versionId='+obj.id+'","版本详情");" class="green">查看详情</a>';
					content += '		<a href="###" class="red" onclick="confirmcallback('+'"确定删除该版本？",'+delVersion,obj.id+');">删除</a>';
					content += '	</div>';
					content += '</div>';
				}
			}
			return content;
		}
	};
	function noMore(){
	 	$(".weui-loadmore__tips").text("没有更多了");
		$(".weui-loading").css("display","none");
		//$(document.body).destroyInfinite();
	}
	
	//切换版本
	function changeVersion(pId,vId){
		<#--location.href="${base}/api/index.html?versionId="+vId+'&projectId='+pId;	-->
		//App.closeParent();
		var url="${base}/api/program.html?versionId="+vId+"&projectId="+pId;
		appViewFinish(url);
	}
	
	//删除版本
	function delVersion(id){
	var params={};
	params.id=id;
	console.log(params);
		$.ajax({
			type:'post',
			url:"${base}/QCode/delVersion.json",
			data:params,
			success:function(data){
				if(data.code == 401){
		                window.location.href = data.message; //开发测试时调用的pc浏览器登录页面
			            return false;
		         }
				if (data.success){
                    layer.open({
                        content: '成功删除'
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                    });
						//$("#"+params.id).remove();
						location.reload();
						window.location.reload();
						//App.refreshParent();
		        	}else{
                    layer.open({
                        content: data.message
                        ,skin: 'msg'
                        ,time: 2 //2秒后自动关闭
                    });

		        	}
			},
			error:function(data){
                layer.open({
                    content: "ajax错误"
                    ,skin: 'msg'
                    ,time: 2 //2秒后自动关闭
                });
			}
		});
	}

</script>

</@apimain.apifooter>