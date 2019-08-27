<@main.header title="设置">
<#escape x as x?html>
 </#escape> 
</@main.header>

<@main.body>
<div class="weui-cells weui-cells_radio">
    <label class="weui-cell weui-check__label" for="x11">
        <div class="weui-cell__bd">
            <p> 量子仿真QEmulator</p>
            <p class="f12 f999 p-t-4"> 连接到服务器上的量子仿真</p>
            <p class="f12 f999 p-t-4">基于量子力学原理给出仿真结果</p>
            <p class="f12 f999 p-t-4">较自由的操作集合</p>
            <p class="f12 f999 p-t-4">量子比特最多可达32位</p>
        </div>
        <div class="weui-cell__ft">
            <input type="radio" class="weui-check" name="radio1" id="x11"  checked="checked">
            <span class="weui-icon-checked"></span>
        </div>
    </label>
</div>
<form id="myFormId">
<div class="weui-cells weui-cells_form">
	<input type="hidden" name ="taskTypeId"  id="taskTypeId" value="1">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">项目名称</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r" type="text"  value="${.now?string('yyyyMMdd')}_${.now?string('HHmmss')}_QEmulator" placeholder="请输入" name="name" id="name" maxlength="50">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">项目描述</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r filteEmoji" type="text" placeholder="请输入"  name="desc" id="desc" maxlength="500">
        </div>
    </div>
    <a class="weui-cell weui-cell_access" href="javascript:;"   id="host-modal">
        <div class="weui-cell__bd">
            <p>项目类型<input type="hidden" name="analogType" id="analogType" ></p>
        </div>
        <div class="weui-cell__ft  bz-text" style="font-size:16px;"">
            请选择
        </div>
    </a>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label" style="width:136px;">量子比特数<p class="f12 f999">(1-32,20以上需要二级用户或以上权限)</p></label></div>
        <div class="weui-cell__bd"> 
            <input class="weui-input text-r" type="tel" pattern="[0-9]*" placeholder="请输入"  name="qubitNum" id="qubitNum"   oninput="checkQubitNum(this)"  onpropertychange="checkQubitNum(this)"    maxlength="2">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label" style="width:136px;">经典寄存器个数<p class="f12 f999">(1-255,用于保存测量值)</p></label></div>
        <div class="weui-cell__bd">
            <input class="weui-input text-r" type="tel" pattern="[0-9]*" placeholder="请输入"  name="classicalbitNum" id="classicalbitNum" oninput="checkClassicalbitNum()"  onpropertychange="checkClassicalbitNum()"   maxlength="3">
        </div>
    </div>
</div>
</form>
   <!--项目类型弹出-->
<aside id="aside" class="aside pop_box">
    <i class="aside-overlay hideAside"></i>
    <div class="aside-content aside_diff" >
        <div class="module module-filter-list">
            <div class="module-header">
                <h3 class="module-title">请选择</h3>
            </div>
            <div class="module-main scrollable" style="top: 44px;">
                <div class="express">
                    <ul>
                        <li class="weui-cell_access hideAside"  value="0">Monte-Carlo方法</li>
                        <li  class="weui-cell_access hideAside" value="1">概率方法</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</aside>
<!--弹出结束-->
   
    
</@main.body>
<@main.footer>
<script src="${base}/assets/validatejs/programAdd.js"></script>
<script>
	 $(function () {
		App.setTitle("新增项目");
		App.setTopMenu([{name:"保存",icon:"${base}/assets/images/save.png",callback:"saveProject()"}]);
        $(document).ready(function () {
            $('.express ul li').click(function () {
                $(".bz-text").html($(this).html());
                $("#analogType").val($(this).val());
                checkQubitNum();
            });
        })
    })


	//检查量子比特数的正确输入
	function checkQubitNum(){//模拟类型 与 量子比特数 联动
		var userLevel = '${USER_INFO.level}'; //用户等级
		var analogType = $("#analogType").val();//模拟类型 
		var qubitNum = $('#qubitNum').val();// 量子比特数
		$('#qubitNum').val(qubitNum.replace(/[^0-9]+/,''));
		qubitNum = $('#qubitNum').val();//再获取一次
		if( qubitNum > 20 ){
			if(userLevel == '1'){
				$('#qubitNum').val(20);
			}else{
				switch(analogType){
					case "0" : {$('#qubitNum').val(20);} ;break;
					case "1" : { qubitNum >32 ?  $('#qubitNum').val(32) :'' ;};break; 
					default  : {};break;
				}
			}
		}else if( qubitNum != ''&& qubitNum < 1 ){
			$('#qubitNum').val(6);
		}
		
		
	}
	
	//检查经典寄存器个数的正确输入
	function checkClassicalbitNum(){
		var classicalbitNum = $('#classicalbitNum').val();// 经典寄存器个数
		$('#classicalbitNum').val(classicalbitNum.replace(/[^0-9]+/,''));
		classicalbitNum = $('#classicalbitNum').val();//再获取一次
		if( classicalbitNum > 225 ){
			$('#classicalbitNum').val(255);
		}else if(classicalbitNum != ''&&  classicalbitNum < 1){
			$('#classicalbitNum').val(6);
		}
		filteEmoji(	this);
	}
	
	function saveProject(){
		if(!$("#myFormId").validateForm(saveProgramAdd)) {
			$.ajax({  
		        type:'post',  
		        traditional :true,  
		        url:"${base}/QCode/saveProject.json",
		        data:$("#myFormId").serialize(),  
		        success:function(data){
		        		if (data.success){
			        		//$("#myFormId input").val('');
			        		var qcodeProjectVersionResult = data.obj;
			        		window.location.href = "${base}/QCode/index.html?projectId="+qcodeProjectVersionResult.projectId+"&versionId="+qcodeProjectVersionResult.id;
			        		App.closeParent();
			        	}else{
			        		App.prompt(data.message);
			        	}
		        },
		        error:function(data){
		        	App.prompt('ajax错误');
		        }
		    });
		}
	}
	

</script>

</@main.footer>