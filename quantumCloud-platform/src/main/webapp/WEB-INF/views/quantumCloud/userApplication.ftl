<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>
<div class="content" style="min-height:500px; min-width:1336px;">
<!--top-->
<@main.top5>
<#escape x as x?html> 
</#escape>
</@main.top5>
  <form id="myFormId" >
<div class="modal-dialog" role="document">
    <div class="modal-content" style="box-shadow: 0 1px 4px rgb(217, 217, 217);-webkit-box-shadow: 0 1px 4px rgb(217, 217, 217);">

        <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel"><@spring.message code="application_form_title" /></h4>
    </div>
        <div class="modal-body">
            <div  class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label"><@spring.message code="application_Email" /></label>
                    <div class="col-sm-10 base_div">
                        <input type="email" class="form-control" id="email" name="email"  value="${USER_INFO.email}"  maxlength="20" placeholder="<@spring.message code="application_placeholder_email" />">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-header">
            <h4 class="modal-title" id=""><@spring.message code="application_application" /></h4>
        </div>
        <div class="modal-body">
            <div class="form-horizontal">
                <div class="form-group">
                    <label for="select_option" class="col-sm-2 control-label"><@spring.message code="application_level" /></label>
                    <div class="col-sm-5">
                        <select class="form-control" id="select_option" name="level"  >
                            <option value="1"><@spring.message code="application_level_one" /></option>
                            <option value="2"><@spring.message code="application_level_two" /></option>
                            <option value="3"><@spring.message code="application_level_three" /></option>
                        </select>
                    </div>
                    <div class="col-sm-5">
                        <ul class="select_li">
                            <li class="active"><@spring.message code="application_level_one_simulation" /></li>
                            <li><@spring.message code="application_level_two_simulation" /></li>
                            <li><@spring.message code="application_level_three_simulation" /></li>
                        </ul>
                    </div>
                </div>
                <div class="form-group">
                    <label for="select_div" class="col-sm-2 control-label"><@spring.message code="application_base" /></label>
                    <div class="col-sm-10">
                       <textarea class="form-control" id="base"  name="base" rows="3" maxlength="50" placeholder="<@spring.message code='application_placeholder_base' />"  style="resize:none;"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword4" class="col-sm-2 control-label"><@spring.message code="application_target" /></label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id="target"  name="target" rows="3" maxlength="500" placeholder="<@spring.message code='application_placeholder_target' />" style="resize:none;"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary  " onclick ="save()"><@spring.message code="application_submit" /></button>
        </div>
    </div>
</div>
</form>
<!--box end-->
</div>
</#escape>
</@main.body>
<@main.footer>
<script type='text/javascript' src="${base}/assets/js/noty/jquery.noty.packaged.min.js"></script>
<script>

    $(document).ready(function() {
    	//用户等级的设置
   		$("select[name=level]").find("option[value='${USER_INFO.level!}']").attr("selected",true);
   		$("select[name=level]").find("option[value='${USER_INFO.level!}']").click();
    	checkEmail();
    
    
        // t = $('.fixed').offset().top;
        // $(window).scroll(function(){
        //     s = $(document).scrollTop();
        //     if(s > t - 10){
        //         $('.fixed').css('position','fixed');
        //         $('.fixed').css('left','14px');
        //         $('.news-content').css('margin-left','16%');
        //         if(s){
        //             $('.fixed').css('top','px');
        //         }
        //     }else{
        //         $('.fixed').css('position','');
        //         $('.news-content').css('margin-left','');
        //
        //     }
        // });
    });
    
    
    function checkEmail(){
    	re = /^(\w-*\.*)+@(\w-?)+(\.\w+)+$/;
		if(!re.test($("#email").val())){
			$('#email').val('');
		}
    }

	function save(){
			if(validateFormData()) {
				$.ajax({  
			        type:'post',  
			        traditional :true,  
			        url:'${base}/QCode/userApplicationSave.json',  
			        data:$("#myFormId").serialize(),  
			        success:function(data){
			        	switch(data.code){
			        	case 401:
			        		var n = noty({
					            text        : data.message,
					            type        : 'error',
					            dismissQueue: true,
					            layout      : 'topCenter',
					            theme       : 'relax',
					            timeout		: 1500,
					            callback: {     // 设置回调函数
							        afterClose: function() {
							        	
							        }
							    }
					        });
		        			break;
		        		default:
			        		if (data.success){
				        		var n = noty({
						            text        : messages.application_is_submit,
						            type        : 'success',
						            dismissQueue: true,
						            layout      : 'topCenter',
						            theme       : 'relax',
						            timeout		: 1500,
						            callback: {     // 设置回调函数
								        afterClose: function() {
								        	
								        }
								    }
						        });
				        	}else{
				        		errorMsg(data.message);
				        	}
			        	}
			        },
			        error:function(data){
			        	errorMsg(messages.server_is_busy);
			        }
			    });
			}
	 }
	 function validateFormData(){
	 	re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
		if(!re.test($("#email").val())){
			errorMsg(messages.enter_email_true);
      	  	return false;  
		}	
		if($("#base").val()==''){
			errorMsg(messages.base_not_null);
       	 	return false;  
		}	
		if($("#target").val()==''){
			errorMsg(messages.target_not_null);
       	 	return false;  
		}			
		return true;
	 }
</script>
</@main.footer>