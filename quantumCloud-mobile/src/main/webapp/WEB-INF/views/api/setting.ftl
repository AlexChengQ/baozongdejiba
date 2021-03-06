<@apimain.apiheader title="设置">
<#escape x as x?html>
 </#escape> 
</@apimain.apiheader>

<@main.body>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>模拟类型</p>
        </div>
        <#assign analogTypes={'0':'Monte-Carlo方法','1':'概率方法'}>
        <div class="weui-cell__ft">${(analogTypes[''+qcodeProject.analogType])!}</div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>量子比特数</p>
        </div>
        <div class="weui-cell__ft">${qcodeProject.qubitNum!}</div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>经典寄存器个数</p>
        </div>
        <div class="weui-cell__ft">${qcodeProject.classicalbitNum!}</div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>经典寄存器名</p>
        </div>
        <div class="weui-cell__ft">C</div>
    </div>
</div>
<form id="myFormId">
<input type="hidden" name="id" id="projectId"  value="${RequestParameters.projectId!}">
<#if qcodeProject.analogType?? && qcodeProject.analogType == QcodeProject.ANALOG_TYPE_MONTE>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">重复试验次数<p>(1-8192)</p></label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r" type="tel" pattern="[0-9]*"  name="repeat"  id="repeat" value="${(qcodeProject.repeat)!100}"   maxlength="4">
        </div>
    </div>
</div>
</#if>
<div class="weui-cells__title">项目介绍</div>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <textarea class="weui-textarea"  name="desc"  id="desc" rows="3" maxlength="500">${qcodeProject.desc!''}</textarea>
        </div>
    </div>
</div>
</form>
<div class="button" style="bottom:0;position:fixed;width:100%;">   
<a onclick="updateProject()"> 保存</a>
</div> 


</@main.body>
<@apimain.apifooter>
<script src="${base}/assets/validatejs/programAdd.js"></script>
<script>
	$('#repeat').on('input propertychange',function(){
	    var v = $(this).val();
	    $(this).val(v.replace(/[^0-9]+/,''));
		v = $(this).val();//再获取一次
	    if(v!=''&&(v>8192||v<1)){
	        $(this).val(8192);
	    }
	});
	
	$('#desc').on("input propertychange", function(){
        //textarea响应高度
    	this.style.height = (this.scrollHeight) + 'px';
    	filteEmoji(this);
	}); 
	
	function updateProject(){
		var analogType = '${qcodeProject.analogType}';
		if(analogType == '${QcodeProject.ANALOG_TYPE_MONTE}'){
			if(!$('#repeat').val()){
				alert("重复次数不能为空!");
				return false;
			}
		}
		if(!$("#myFormId").validateForm(updateProgram)) {
		var url= "${base}/api/program.html?projectId="+${qcodeProject.id};
			$.ajax({  
		        type:'post',  
		        traditional :true,  
		        url:"${base}/QCode/updateProject.json",
		        data:$("#myFormId").serialize(),  
		        success:function(data){
		        		console.log(data);
		        		if (data.success){
							appViewFinish(url);
							//App.refreshParent();
			        	}else{
			        		alert(data.message);
			        	}
		        },
		        error:function(data){
		        	alert('ajax错误');
		        }
		    });
		}
	}
	

</script>
</@apimain.apifooter>