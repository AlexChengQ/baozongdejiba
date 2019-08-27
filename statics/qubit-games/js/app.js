var tabIndex = 0;
$(function () {
    //主设计窗体切换TAB
    var $tab_li = $('#tab ul li');
    $tab_li.click(function(){
    	var index = $tab_li.index(this);
    	if(tabIndex == index){//当前tab下 再次点击当前页面 不做操作
    		return false;
    	}
    	if(index == 1 && !checkGrammar()){
    		return;
    	}
    		
        if(index==0){
        	var result = code2Trans();
        	if(result!=false){
                $(this).addClass('selected').siblings().removeClass('selected');
                $('div.tab_box > div').eq(index).show().siblings().hide();
            	tabIndex = index;
        	}
        }else if(index == 1){
            $(this).addClass('selected').siblings().removeClass('selected');
            $('div.tab_box > div').eq(index).show().siblings().hide();
        	trans2Code();
        	tabIndex = index;
        }else{
        	if(tabIndex == 1){
	        	var result = code2Trans();
	        	if(result!=false){
		        	$(this).addClass('selected').siblings().removeClass('selected');
		            $('div.tab_box > div').eq(index).show().siblings().hide();
		        	tabIndex = index;
	        	}
        	}else{
        		$(this).addClass('selected').siblings().removeClass('selected');
	            $('div.tab_box > div').eq(index).show().siblings().hide();
	        	tabIndex = index;
        	}
        }
    	$(".case-bottom").getNiceScroll().resize();
    });
});


$(function() {
//右侧窗体高度
	
    $("#qcodeSvgContainer").show();

    //当文档窗口发生改变时 触发
    $(window).resize(function () {
    	if($(window).width() > 1200)
    		$(".logo-text-en").show();
    });

    $(".case-bottom").niceScroll({
        cursorcolor: "#535353", // 改变滚动条颜色，使用16进制颜色值
        cursoropacitymin: 0, // 当滚动条是隐藏状态时改变透明度, 值范围 1 到 0
        cursoropacitymax: 1, // 当滚动条是显示状态时改变透明度, 值范围 1 到 0
        cursorwidth: "8px", // 滚动条的宽度，单位：便素
        cursorborder: "", // CSS方式定义滚动条边框
        cursorborderradius: "", // 滚动条圆角（像素）
        scrollspeed: 60, // 滚动速度
        mousescrollstep: 40, // 鼠标滚轮的滚动速度 (像素)
        touchbehavior: false, // 激活拖拽滚动
        hwacceleration: true, // 激活硬件加速
        background: "#e1e1e1",// 轨道的背景颜色
        autohidemode: false, // 隐藏滚动条的方式, 可用的值:
        // true | // 无滚动时隐藏
        // "cursor" | // 隐藏
        // false | // 不隐藏,
        // "leave" | // 仅在指针离开内容时隐藏
        // "hidden" | // 一直隐藏
        // "scroll", // 仅在滚动时显示
        railoffset:false
    });
    
    $("#ascrail2000-hr").remove().appendTo("#contentCenter");
    
    resizeScroll();
    
    
    $(".box-right").getNiceScroll().resize();
    

    // $(".box-right").niceScroll({
    //     cursorborder:"",
    //     cursorwidth: "8px", // 滚动条的宽度，单位：便素
    //     cursorcolor:"#535353",
    //     cursorborder: "", // CSS方式定义滚动条边框
    //     boxzoom:true,
    //     background: "#e1e1e1",// 轨道的背景颜色
    //     railoffset:false}); // First scrollable DIV
    // $(".box-right").getNiceScroll().resize();
});
var count = 0;
function resizeScroll(){
	setTimeout(function(){
    	if (count == 50){
    		return ;
    	}
		$(".case-left").removeAttr("style");
    	count++;
    	$(".nicescroll-rails-vr").remove();
        $("#ascrail2000-hr").css("top","-5px");
        $("#ascrail2000-hr").css("left","120px");
        $("#ascrail2000-hr").css("position","relative");
        resizeScroll();
    },200);	
};

/*三步走*/
function shows(){
	var type = $("#typeId").val();
    $(".first").hide();
    $(".second").show();
	if(type==3){
	    $("#projectName").val($("#projectTime").val()+"Semi-2Q");
	    $("#desc").val(messages.app_js_desc);
	}else if(type==2){
	    $("#projectName").val($("#projectTime").val()+"Spcd6Q");
	    $("#desc").val("");
	}else{
	    $("#projectName").val($("#projectTime").val()+"QEmulator");
	    $("#desc").val("");
	}
}
function showt(){
	var name = $("#projectName").val();
	var type = $("#typeId").val();
	if(name==''){errorMsg(messages.project_name_not_null); return false;}
	if(type==3){
		$(".four").show();
	    $(".second").hide();
	}else if(type==2){
		$(".there").show();
	    $(".second").hide();
	    $("#qubitNumDesc").html(messages.number_of_qubits+"<br/>(1-6)");
	    $("#analogTypeId").html(messages.analog_type);
	    $("#classicalbitNumDesc").html(messages.number_of_classical_registers+"<br/>(1-255)");
	    $("#qubitNum").val(2);
	    $("#classicalbitNum").val(2);
	}else{
		$(".there").show();
	    $(".second").hide();
	    $("#qubitNumDesc").html(messages.number_of_qubits_1_30);
	    $("#analogTypeId").html(messages.analog_type);
	    $("#classicalbitNumDesc").html(messages.number_of_classical_registers_1_255);
	    $("#qubitNum").val(6);
	    $("#classicalbitNum").val(6);
	}
}
function closeme(){
    $(".contentt").hide();


}

function errorMsg(message){
	var n = noty({
        text        : message,
        type        : 'error',
        dismissQueue: true,
        layout      : 'center',
        theme       : 'relax',
        timeout		: 3000
    });
}

/*介绍*/
$(function(){
    function show(index) {
        $(".case-list dl").eq(index).children("dd").hover(function () {
            $(".case-js dl").eq(index).children("dd").eq($(this).index() -1).show().siblings().hide();
        },function () {
            $(".case-js dl").children("dd").hide();
        });
    }
    show(0);
    show(1);
    show(2);
    show(3);
});

function toPage(page) {
	$("#startId").val(page);
	document.getElementById("searchForm").reset();
	$("#searchForm").submit();
}

/*用户申请下拉框*/
$(function(){
    $("#select_option").click(function () {
        var index = $("#select_option option:selected").index();
        $(".select_li li").eq(index).addClass("active").siblings().removeClass("active");
    });
});


/*新的导航*/
var maxHeight = 400;

$(function(){
    $('.dropdown li').click(function () {
        $(this).addClass('nav_cur').siblings().removeClass('nav_cur')
    })

    $(".dropdown > li").hover(function() {

        var $container = $(this),
            $list = $container.find("ul"),
            $anchor = $container.find("a"),
            height = $list.height() * 1.1,
            multiplier = height / maxHeight;

        $container.data("origHeight", $container.height());

        $anchor.addClass("hover");

        $list
            .show()
            .css({
                paddingTop: $container.data("origHeight")
            });

        if (multiplier > 1) {
            $container
                .css({
                    height: maxHeight,
                    overflow: "hidden"
                })
                .mousemove(function(e) {
                    var offset = $container.offset();
                    var relativeY = ((e.pageY - offset.top) * multiplier) - ($container.data("origHeight") * multiplier);
                    if (relativeY > $container.data("origHeight")) {
                        $list.css("top", -relativeY + $container.data("origHeight"));
                    };
                });
        }

    }, function() {

        var $el = $(this);
        $el
            .height($(this).data("origHeight"))
            .find("ul")
            .css({ top: 0 })
            .hide()
            .end()
            .find("a")
            .removeClass("hover");

    });

});

