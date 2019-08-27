<@apimain.apiheader title="版本详情">
<#escape x as x?html>
 </#escape> 
</@apimain.apiheader>

<@main.body>

<#if pager?? && pager.entityList?size gt 0>
  <#assign statuss={"1":"等待","2":"处理中","3":"已完成","4":"语法错误","5":"终止"}>  <#-- 已完成 即 有结果-->
  <#list pager.entityList as qcodeTask>
	<div class="weui-cells" id="${qcodeTask.id}">
	    <div class="weui-cell">
	        <div class="weui-cell__bd">
	            <p>${qcodeTask.startTime?string('yyyy-MM-dd HH:mm:ss')}</p>
	        </div>
	        <#if qcodeTask.status??&&qcodeTask.status=='3'>
	        	<div class="weui-cell__ft "><span class="green f14 status" onclick="viewResults(${(qcodeTask.taskId)!0})">查看结果</span></div>
	        <#else>
	        	<div class="weui-cell__ft "><span class="green f14 status">${(statuss[''+qcodeTask.status])!}</span></div>
	        </#if>
	        
	    </div>
	    <div class="case-list">
	    	<#if (qcodeTask.status ==  QcodeTask.STATUS_WAITING) || (qcodeTask.status ==  QcodeTask.STATUS_PROCESS)>
	        	<a href="###" class="blue" onclick="confirmcallback("确定终止该任务？",terminateTask,${qcodeTask.id})">终止111</a>
	         	<a href="###" class="red"  onclick="confirmcallback('确定删除该任务？',delTask,${qcodeTask.id})">删除111</a>
	        <#else>
		        <a href="###" class="red" style="width: 98%;" onclick="confirmcallback('确定删除该任务？',delTask,${qcodeTask.id})" >删除</a>
	        </#if>
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
    <div class="overlay" id="result"></div>
    <div class="loading" id="result-div" style="width:100%;height: 350px;margin-top: -175px;margin-left: 0;border-radius: 0;left: 0;">
        <span style="font-size:18px;">×</span>
        <h2 style="border-bottom: 1px solid #ddd;font-size: 14px;text-align: left;padding-left: 18px;height: 40px;line-height: 40px;color: #333;">测试结果</h2>
        <div style="height: 230px;" id="taskResult">
        </div>
        <div style="border-top: 1px solid #ddd;padding-top: 16px;color: #999;">
            <div id="startTime"></div>
            <div id="endTime"></div>
        </div>
    </div>
</@main.body>
<@apimain.apifooter>
<link href="${base}/assets/views/js/program/need/layer.css" rel="stylesheet">
<script src="${base}/assets/views/js/program/layer.js"></script>
<script src="${base}/assets/js/echarts/echarts.js"></script>
<script src="${base}/assets/js/echarts/macarons.js"></script>
<script>
function confirmcallback(message,truefun,falsefun){
    layer.open({
        content: message
        ,btn: ['确定', '取消']
        ,yes: function(index){
            truefun(falsefun)
            layer.close(index);
        }
    });
    $("body").find(".layui-layer-dialog").css({"left":parseInt($(this).offsetLeft)/2+"px"})
}



$(function() {
    $(".loading>span").click(function () {
        $(".overlay").hide();
        $(".loading").hide();
    });
});	
	var hasMore = false;
	var loading = false;
	<#if pager?? && (pager.entityList)?exists && ((pager.entityList)?size != 0)>
		hasMore = true;
		var pager ;
		var count = '${pager.totalRecords}';
		var pageSize = '${pager.pageSize}';
		var statuss=["","等待","处理中","已完成","语法错误","终止"];
		var STATUS_WAITING = ${QcodeTask.STATUS_WAITING!};
		var STATUS_PROCESS = ${QcodeTask.STATUS_PROCESS!};
		var STATUS_END = ${QcodeTask.STATUS_END!};
	</#if>
	
	//下拉加载
	function onPageEnd(){
		if(hasMore)
		lazyLoading();
	};
	
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
	  	params.versionId = "${RequestParameters.versionId!}";
	  	
	  	params.start= (params.pageNum-1)*params.limit;
	  	$.post("${base}/QCode/revisionsDetail.json", params, function(data){
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
					content += '<div class="weui-cells" id="'+obj.id+'">';
					content += '	<div class="weui-cell">';
					content += '		<div class="weui-cell__bd">';
					content += ' 			<p>'+obj.startTime+'</p>';
					content += '		</div>';
					content += '		<div class="weui-cell__ft "><span class="green f14 status" >'+statuss[obj.status]+'</span></div>';
					content += '	</div>';
					content += '	<div class="case-list">';
					if((obj.status == STATUS_WAITING) || (obj.status == STATUS_PROCESS)){
						content += '	<a href="###" class="blue" onclick="confirmcallback('+'"确定终止该任务？"'+',terminateTask,'+obj.id+')">终止</a>';
						content += '	<a href="###" class="red"  onclick="confirmcallback('+'"确定删除该任务？"'+',delTask,${qcodeTask.id})">删除</a>'; 
					}else{
						content += '	<a href="###" class="red"  onclick="confirmcallback('+'"确定删除该任务？"'+',delTask,${qcodeTask.id})">删除</a>';
					}
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
//删除task
function delTask(id){
	var params={};
	params.id=id;
	$.ajax({
		type:'post',
		url:"${base}/QCode/delTask.json",
		data:params,
		success:function(data){
			if(data.code == 401){
	                window.location.href = data.message; //开发测试时调用的pc浏览器登录页面
		            return false;
	         }
			if (data.success){
					alert("成功删除");
					window.location.reload();
					setTimeout(function() {window.location.reload()}, 1500);
	        	}else{
	        		alert(data.message);
	        	}
		},
		error:function(data){
			alert('ajax错误');
		}
	});
}
	
//终止task
function terminateTask(params){
	//表单提交
	$.ajax({
		url:"${base}/QCode/terminateTask.json",
		data:params,
		cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
		type:'post', 
		success:function(result){
			if(result.code == 401){
                window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
	            return false;
            }
			if(result.success){ 
		      	alert("成功终止");
		      	setTimeout(function() {window.location.reload()}, 1500);
			} else {
	  			alert(data.message);
			}
		},
		error:function(){		
		 	alert('ajax错误');
		}
	});
}

function viewResults(taskId) {
  var url = "${base}/QCode/getTaskRate.json";
  var param = new Object();
  param.taskId = taskId;
  $.post(url, param, function(response) {
    if ('401' == response.code) {
      alert("重新登录");
      //setTimeout(function (){App.openNew(response.message)}, 1500);
      return false;
    }
    if (response.success) {
        var task = response.obj;
        var status = task.status;
        
        if (status == 3 || status == 5) {
            setTimeout(function () {displayResult(task)}, 1000);
        } else if(status == 4) {
            alert(messages.task_status_syntactic_error);
            setTimeout(function() {window.location.reload()}, 1500);
        }
    } else {
        alert(response.message);
        setTimeout(function() {window.location.reload()}, 1500);
    }
  }).fail(function() {alert("网络异常")});
}

function displayResult(task) {

    $("#running").hide();
    $("#running-div").hide();
    $("#result").show();
    $("#result-div").show();
    var ans = JSON.parse(task.ans);
    var keyArray = ans.key;
    var valueArray = ans.value;
    var myChart = makeChart("taskResult");
    //参数设置
    var option;
    if (keyArray.length >4 ) {
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                top: 30,
                left: '3%',
                right: '4%',
                bottom: '12%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                data: keyArray,
                name: messages.celiangzhi,
                nameLocation: "middle",
                nameGap: 20,
                axisTick: {
                    alignWithLabel: true
                }
            }],
            dataZoom: [{
                type: 'slider',
                startValue: 0,
                endValue: 4
            }],
            yAxis: [{
                type: 'value',
                name: messages.gailv
            }],
            series: [{
                name: messages.gailv,
                type: 'bar',
                barWidth: '20',
                data: valueArray
            }]
        };
    } else {
        option = {
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                top: 30,
                left: '3%',
                right: '3%',
                bottom: '12%',
                containLabel: true
            },
            xAxis: [{
                type: 'category',
                data: keyArray,
                name: messages.celiangzhi,
                nameLocation: "middle",
                nameGap: 20,
                axisTick: {
                    alignWithLabel: true
                }
            }],
            dataZoom: [
                {
                    type: 'slider',
                    start: 0,
                    end: 100
                }
            ],
            yAxis: [{
                type: 'value',
                name: messages.gailv
            }],
            series: [
                {
                    name: messages.gailv,
                    type: 'bar',
                    barWidth: '20',
                    data: valueArray
                }
            ]
        };
    }
    
    myChart.setOption(option);
    $("#startTime").html(messages.zhixingshijian+"：" + task.startTime);
    $("#endTime").html(messages.end_time+ "：" + task.endTime);
}

function makeChart (name) {
    
    var main = document.getElementById(name);
    var opts = {height: 230};
    var myEcharts = echarts.init(main);
    myEcharts.resize(opts);
    return myEcharts;
}
</script>
</@apimain.apifooter>