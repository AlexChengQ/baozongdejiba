var currentType,currentX,currentY,scrollTop;
var fixedHeight = 50;//当量子比特线条数量小于6 即默认可视化界面多于生成的线条图案实际高度  使用线条上圆点高度重新划分可视化区域
var oQi = -1;
var oQs = -1;
var svgDivLeft,svgDivWidth,svgDivRight,svgDivTop,svgDivHeight,svgDivBottom;
var oldDqI;
var oldDqS;
var isSelfDrag=false;
//初始化加载
window.onload = function() {
    if(fromAdmin!=undefined && fromAdmin=="1"){return false;}
    svgDivLeft = $(".modRight_center").offset().left;//svg可视div区域距离浏览器左边距离
    svgDivWidth = $(".modRight_center").width();//svg可视div区域宽度
    svgDivRight = parseInt(svgDivLeft) + parseInt(svgDivWidth);//svg div最大可视化区域宽度
    svgDivTop = $(".NewModule").offset().top;//svg可视div区域距离浏览器顶部距离
    svgDivHeight = $(".NewModule").height();//svg可视div区域高度
    svgDivBottom = parseInt(svgDivTop) + parseInt(svgDivHeight);//svg div最大可视化区域高度   默认可视化区域高度
    initDragObj();
};

//监听浏览器滚动条的变化
window.onscroll = function(){
    scrollTop = $(window).scrollTop();
    //$("#currentZ span").text(scrollTop);
};

//监听浏览器窗口的变化
$(window).resize(function(){
    if(fromAdmin!=undefined && fromAdmin=="1"){
        return false;
    }
    initDragObj();
});

function initDragObj() {
    dragObj("dragH");
    dragObj("dragNOT");
    dragObj("dragZPi");
    dragObj("dragXPi2");
    dragObj("dragYPi2");
    dragObj("dragZPi2");
    dragObj("dragCNOT");
    dragObj("dragiSWAP");
    dragObj("dragToffoli");
    dragObj("dragMeasure");
    dragObj("dragRX");
    dragObj("dragRY");
    dragObj("dragRZ");
    dragObj("dragCR");
    dragObj("GHZ2");
    dragObj("GHZ3");
    dragObj("GHZ6");
    dragObj("QFT3");
    dragObj("QFT4");
    dragObj("CZ");
    dragObj("z-CNOT");
    dragObj("SWAP");
    dragObj("H6");
    // dragObj("div1");
    dragObjAll("LayerContent","LayerMove");
}

function dragObj(id){
    if(fromAdmin!=undefined && fromAdmin=="1"){
        return false;
    }
    var obj = document.getElementById(id);
    if(obj==null || obj==undefined) return false;
    // var x = 0;
    // var y = 0;
    //全屏拖动方法开始
    var oParent=document.getElementsByClassName('content')[0];
    var sent={l:0,r:oParent.offsetWidth-obj.offsetWidth,t:0,b:oParent.offsetHeight-obj.offsetHeight,n:10}
    var dmW=document.documentElement.clientWidth||document.body.clientWidth;
    var dmH=document.documentElement.clientHeight||document.body.clientHeight;
    var sent=sent||{};
    var l=sent.l||0;
    var r=sent.r||dmW-obj.offsetWidth;
    var t=sent.t||0;
    var b=sent.b||dmH-obj.offsetHeight;
    var n=sent.n||10;
    //全屏拖动方法结束

    //可视化div
    obj.onmousedown = function(ev) {
        // obj.style.cursor="move";
        /**是否是已生成的图形 进行拖拽*/
        var isExist = false;
        var oEvent = ev || event;
        var dragFocus='';

        //全屏拖动方法开始
        var sentX=oEvent.clientX-obj.offsetLeft;
        var sentY=oEvent.clientY-obj.offsetTop;
        //全屏拖动方法结束
        var ops=null;

        var opq=0;
        document.onmousemove = function(ev) {
            opq++;
            if(opq>10){
                resetHL()
                $(".LayerSetting").hide()
                $(".pic-blue").removeClass("current");
                // $("rect[index='1']").attr("focus",false)
                // $(obj).attr("focus",true)
                svgDivTop = $(".modRight_center").offset().top;//svg可视div区域距离浏览器顶部距离
                svgDivHeight = $(".modRight_center").height();//svg可视div区域高度
                svgDivBottom = parseInt(svgDivTop) + parseInt(svgDivHeight);//svg div最大可视化区域高度
                isDrag = true;
                oQi = $(obj).attr("qi");//原坐标qi
                oQs = $(obj).attr("qs");//原坐标qs
                if(oQi!=undefined&&oQs!=undefined){
                    isSelfDrag=true;
                    dragFocus=obj;
                }
                //量子比特线条数量最大高度 小于默认可视化界面高度
                if(parseInt(qubitNum) < parseInt(6)){
                    var $c = $("rect[qi="+parseInt(qubitNum-1)+"][qs=1][index='0']");
                    var lastLineCircleTop = $c.offset().top;
                    svgDivBottom = parseInt(lastLineCircleTop) + parseInt(fixedHeight);
                }

                var oEvent = ev || event;
                var left = oEvent.clientX;// - x;
                var right = oEvent.clientY;// - y;
                // 判断左边是否过界
                if (left < 0) {
                    left = 0;
                }
                // 判断右边是否过界
                else if (left > document.documentElement.clientWidth - obj.offsetWidth) {
                    left = document.documentElement.clientWidth - obj.offsetWidth;
                }
                // 判断上边是否过界
                if (right < 0) {
                    right = 0;
                }
                // 判断下边是否过界
                else if (right > document.clientHeight) {
                    right = document.clientHeight - obj.offsetHeight;
                }
                currentType = $(obj).attr("type");
                currentX = left;
                currentY = right;
                // $("#currentX span").text(currentX);
                // $("#currentY span").text(currentY);

                if(parseInt(scrollTop) > 0){
                    svgDivTop = parseInt(svgDivTop)-parseInt(scrollTop);
                    svgDivBottom = parseInt(svgDivBottom)-parseInt(scrollTop);
                }
                //$("#svgDivTop span").text(svgDivTop);
                //$("#svgDivBottom span").text(svgDivBottom);

                //鼠标只能在可视选择区域能显示为可用
                if(parseInt(currentX) > parseInt(svgDivLeft) && parseInt(currentX) < parseInt(svgDivRight) && parseInt(currentY) > parseInt(svgDivTop) && parseInt(currentY) < parseInt(svgDivBottom)){
                    var imgName = "";
                    if ($(obj).attr("imgName") != undefined && $(obj).attr("imgName").length > 0) {
                        imgName = $(obj).attr("imgName");
                    } else {
                        if ($(obj).attr("n2") != undefined && $(obj).attr("n2").length > 0) {
                            var n2 = $(obj).attr("n2");
                            $("line[n2="+n2+"]").hide();
                            $("#"+n2).hide();
                        }
                        if($(obj).attr("n3")!=undefined && $(obj).attr("n3").length>0){
                            var n3 = $(obj).attr("n3");
                            $("line[n3="+n3+"]").hide();
                            $("#"+n3).hide();
                        }
                        $(obj).parent().hide();
                        imgName = getImgName(currentType);
                        isExist = true;
                    }

                    var oEvent=ev||event;
                    var slideLeft=oEvent.clientX-40;
                    var slideTop=oEvent.clientY-20+$(window).scrollTop();
                    if(slideLeft<=l){slideLeft=l;}
                    if(slideLeft>=r){slideLeft=r;}
                    if(slideTop<=t){slideTop=t;}
                    if(slideTop>=b){slideTop=b;}
                    $("#dragImgBox").css({"left":slideLeft+'px',"top":slideTop+'px'})
                    $("#dragImgBox img").attr("src",base+"/assets/images/"+imgName);
                    $("#dragImgBox").show()
                }else{
                    $('body').css({
                        "cursor":"not-allowed"
                    });
                }
            }else {
                return false
            }
        };
        document.onmouseup = function() { // 清空document的事件
            if (currentX == undefined || currentY == undefined) {
                document.onmousemove = null;
                document.onmouseup = null;
            } else {
                $('body').css({
                    "cursor":"default"
                });
                document.onmousemove = null;
                document.onmouseup = null;

                var dQi = -1;//qi坐标，qs坐标
                var dQs = -1;
                var absoluteValue = -1;//宽差与高差的绝对值的和
                var tempValue = 0;//临时变量

                //判断当前移动坐标是否大于svg div距离浏览器左边距离 并小于svg div最大可视化距离
                if(parseInt(currentX) > parseInt(svgDivLeft) && parseInt(currentX) < parseInt(svgDivRight) && parseInt(currentY) > parseInt(svgDivTop) && parseInt(currentY) < parseInt(svgDivBottom)){
                    $("svg rect[index='0']").each(function(index,obj){
                        var circleLeft = $(obj).offset().left;//圆点距离浏览器左边距离
                        var circleTop = $(obj).offset().top;//圆点距离浏览器左边距离
                        if(parseInt(scrollTop) > 0){
                            circleTop = parseInt(circleTop) - parseInt(scrollTop);
                        }

                        //当前圆点距离浏览器左边距离需要大于svg div距离浏览器左边距离 并小于svg div最大可视化距离
                        if(parseInt(circleLeft) > parseInt(svgDivLeft) && parseInt(circleLeft) < parseInt(svgDivRight) && parseInt(circleTop) > parseInt(svgDivTop) && parseInt(circleTop) < parseInt(svgDivBottom)){
                            //当前圆点X、Y坐标分别于移动时选择的坐标相差30以内 即选择该点
                            if(parseFloat(circleLeft) > parseFloat(currentX)){//circleLeft > currentX
                                if(parseFloat(circleLeft) - parseFloat(currentX) <30){
                                    if(parseFloat(circleTop) > parseFloat(currentY)){
                                        if(parseFloat(circleTop) - parseFloat(currentY) <30){
                                            if(absoluteValue==-1){//初始值
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                absoluteValue = tempValue;
                                                dQi = $(this).attr("qi");
                                                dQs = $(this).attr("qs");
                                            }else{
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                if(parseFloat(absoluteValue)<parseFloat(tempValue)){//取最小值
                                                    return;
                                                }else{
                                                    absoluteValue = tempValue;
                                                    dQi = $(this).attr("qi");
                                                    dQs = $(this).attr("qs");
                                                }
                                            }
                                        }else{
                                            return;
                                        }
                                    }else{
                                        if(parseFloat(currentY) - parseFloat(circleTop) <30){
                                            if(absoluteValue==-1){//初始值
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                absoluteValue = tempValue;
                                                dQi = $(this).attr("qi");
                                                dQs = $(this).attr("qs");
                                            }else{
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                if(parseFloat(absoluteValue)<parseFloat(tempValue)){//取最小值
                                                    return;
                                                }else{
                                                    absoluteValue = tempValue;
                                                    dQi = $(this).attr("qi");
                                                    dQs = $(this).attr("qs");
                                                }
                                            }
                                        }else{
                                            return;
                                        }
                                    }
                                }else{
                                    return;
                                }
                            }else{
                                if(parseFloat(currentX) - parseFloat(circleLeft) <30){
                                    if(parseFloat(circleTop) > parseFloat(currentY)){
                                        if(parseFloat(circleTop) - parseFloat(currentY) <30){
                                            if(absoluteValue==-1){//初始值
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                absoluteValue = tempValue;
                                                dQi = $(this).attr("qi");
                                                dQs = $(this).attr("qs");
                                            }else{
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                if(parseFloat(absoluteValue)<parseFloat(tempValue)){//取最小值
                                                    return;
                                                }else{
                                                    absoluteValue = tempValue;
                                                    dQi = $(this).attr("qi");
                                                    dQs = $(this).attr("qs");
                                                }
                                            }
                                        }else{
                                            return;
                                        }
                                    }else{
                                        if(parseFloat(currentY) - parseFloat(circleTop) <30){
                                            if(absoluteValue==-1){//初始值
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                absoluteValue = tempValue;
                                                dQi = $(this).attr("qi");
                                                dQs = $(this).attr("qs");
                                            }else{
                                                tempValue = Math.abs(parseFloat(circleLeft) - parseFloat(currentX)) + Math.abs(parseFloat(circleTop) > parseFloat(currentY));
                                                if(parseFloat(absoluteValue)<parseFloat(tempValue)){//取最小值
                                                    return;
                                                }else{
                                                    absoluteValue = tempValue;
                                                    dQi = $(this).attr("qi");
                                                    dQs = $(this).attr("qs");
                                                }
                                            }
                                        }else{
                                            return;
                                        }
                                    }
                                }else{
                                    return;
                                }
                            }
                        }
                    });

                    if(dQi!=-1 && dQs!=-1){
                        if(dQi==oQi&&dQs==oQs){
                            showIcon(obj);
                            $("#dragImgBox").hide();
                            return false;
                        }
                        if(checkGrammar(isSelfDrag,dragFocus ,dQi ,dQs,isExist)){
                            checkCircle();
                            var jResult = multiBitGateJudgment(dQi,dQs);
                            var temporary=[]
                            var evts=$("svg rect[qi="+dQi+"][qs="+dQs+"][index='0']");
                            $('line[x1="'+(parseInt(evts.attr("x"))+30)+'"]').each(function () {temporary.push({y1:$(this).attr("y1"),y2:$(this).attr("y2")})})
                            if(temporary!='') {
                                var isHas =0;
                                for(var i=0;i<temporary.length;i++){
                                    if (parseInt(evts.attr('y')) > parseInt(temporary[i].y1) && parseInt(evts.attr('y')) <parseInt(temporary[i].y2)) {isHas=1;break;}
                                }
                                if(isHas==1){
                                    prompt(messages.point_already_exists);
                                    showIcon(obj);

                                    isDrag=false;
                                    dQi = -1;
                                    dQs = -1;
                                    currentX = 0;
                                    currentY = 0;
                                    isSelfDrag=false
                                    return false;}
                            }
                            if(!jResult){
                                showIcon(obj);
                            }else{
                                $("svg rect[qi="+dQi+"][qs="+dQs+"][index='0']").click();
                                setTimeout(function(){
                                    isDrag = true;
                                    var checkResult = checkCoordinates(currentType);
                                    clickTrans(currentType);
                                    dQi = -1;
                                    dQs = -1;
                                    currentX = 0;
                                    currentY = 0;
                                    isSelfDrag=false
                                    if(isExist && checkResult){//符合拖拽条件的 删除原图形
                                        var id = $("#projectId").val();
                                        if (id == 257 || id == 258 || id==259 || id==260) {
                                            $(obj).parent().show();
                                            $("#dragImgBox").hide();
                                            return false;
                                        } else {
                                            deleteIcon(obj);
                                        }
                                    }else{
                                        showIcon(obj);
                                    }
                                    $("#dragImgBox").hide();
                                },200);
                            }
                        }else{//不符合拖拽条件的 显示原图形
                            if(isExist){
                                showIcon(obj);
                            }
                            dQi = -1;
                            dQs = -1;
                            currentX = 0;
                            currentY = 0;
                        }
                    }else{//不符合拖拽条件的 显示原图形
                        if(isExist){
                            showIcon(obj);
                        }
                    }
                }else{//不符合拖拽条件的 显示原图形
                    if(isExist){
                        showIcon(obj);
                    }
                }
                $(".cloneEle").remove();
            }


        }; // 解决低版本火狐bug，干掉系统默认
        return false;
    };
}

function dragObjAll(id,childId) {
    var objHandle=document.getElementById(childId);;
    var dragAll=document.getElementById(id);

    var oParent=document.getElementsByClassName('content')[0];
    var sent={l:0,r:oParent.offsetWidth-dragAll.offsetWidth,t:0,b:oParent.offsetHeight-dragAll.offsetHeight,n:10}
    var dmW=document.documentElement.clientWidth||document.body.clientWidth;
    var dmH=document.documentElement.clientHeight||document.body.clientHeight;
    var sent=sent||{};
    var l=sent.l||0;
    var r=sent.r||dmW-dragAll.offsetWidth;
    var t=sent.t||0;
    var b=sent.b||dmH-dragAll.offsetHeight;
    var n=sent.n||10;
    objHandle.onmousedown=function(ev){
        objHandle.style.cursor='move';
        var oEvent=ev||event;
        var sentX=oEvent.clientX-dragAll.offsetLeft;

        var sentY=oEvent.clientY-dragAll.offsetTop;
        document.onmousemove=function(ev){

            var oEvent=ev||event;
            var slideLeft=oEvent.clientX-sentX;
            var slideTop=oEvent.clientY-sentY;
            if(slideLeft<=l){slideLeft=l;}
            if(slideLeft>=r){slideLeft=r;}
            if(slideTop<=t){slideTop=t;}
            if(slideTop>=b){slideTop=b;}
            dragAll.style.left=slideLeft+'px';dragAll.style.top=slideTop+'px';

        }

        document.onmouseup=function(){
            objHandle.style.cursor="default";
            document.onmousemove=null;document.onmouseup=null;
        }
        return false;
    }
}
/**
 * 图标元素的点击事件
 */
function clickTrans(type) {
    if (type == "H") {
        $("#dragH").click();
    } else if (type == "NOT") {
        $("#dragNOT").click();
    } else if (type == "ZPi") {
        $("#dragZPi").click();
    } else if (type == "XPi2") {
        $("#dragXPi2").click();
    } else if (type == "YPi2") {
        $("#dragYPi2").click();
    } else if (type == "ZPi2") {
        $("#dragZPi2").click();
    } else if (type == "CNOT") {
        $("#dragCNOT").click();
    } else if (type == "iSWAP") {
        $("#dragiSWAP").click();
    } else if (type == "Toffoli") {
        $("#dragToffoli").click();
    } else if (type == "Measure") {
        $("#dragMeasure").click();
    } else if (type == "RZ") {
        $("#dragRZ").click();
    } else if (type == "RX") {
        $("#dragRX").click();
    } else if (type == "RY") {
        $("#dragRY").click();
    } else if (type == "CR") {
        $("#dragCR").click();
    } else if (type == "GHZ2") {
        $("#GHZ2").click();
    } else if (type == "GHZ3") {
        $("#GHZ3").click();
    } else if (type == "GHZ6") {
        $("#GHZ6").click();
    } else if (type == "QFT3") {
        $("#QFT3").click();
    } else if (type == "QFT4") {
        $("#QFT4").click();
    } else if (type == "CZ") {
        $("#CZ").click();
    } else if (type == "z-CNOT") {
        $("#z-CNOT").click();
    } else if (type == "SWAP") {
        $("#SWAP").click();
    } else if (type == "H6") {
        $("#H6").click();
    }
}

/**
 * 根据原始类型获取图标名称
 */
function getImgName(type){
    var imgName = "";
    switch(type){
        case "H":
            imgName = "New_H.png";
            break;
        case "NOT":
            imgName = "New_Not.png";
            break;
        case "ZPi":
            imgName = "New_Zπ.png";
            break;
        case "XPi2":
            imgName = "New_Xpi2.png";
            break;
        case "YPi2":
            imgName = "New_Ypi2.png";
            break;
        case "ZPi2":
            imgName = "New_Zpi2.png";
            break;
        case "CNOT":
            imgName = "New_Cont.png";
            break;
        case "iSWAP":
            imgName = "New_Iswp.png";
            break;
        case "Toffoli":
            imgName = "New_Toff.png";
            break;
        case "RX":
            imgName = "New_Xpi.png";
            break;
        case "RY":
            imgName = "New_Ypi.png";
            break;
        case "RZ":
            imgName = "New_Zpi.png";
            break;
        case "CR":
            imgName = "New_CR.png";
            break;
        case "Measure":
            imgName = "New_Measure.png";
            break;
    }
    return imgName;
}

/**
 * 删除图标
 */
function deleteIcon(obj){
    if ($(obj).attr("refid"))//ISWAP图形
    {
        var id = $(obj).attr("refid");

        if($(obj).attr("type") == "iSWAP")
            $("#"+$("#"+id).attr("n2")).parent().remove();

        $("line[n2='"+$("#"+id).attr("n2")+"']").remove();
        $("#"+$("#"+id).attr("n2")).remove();
        $("line[n3='"+$("#"+id).attr("n3")+"']").remove();
        $("#"+$("#"+id).attr("n3")).remove();
        $("rect[refid='"+id+"']").remove();
        $("#"+id).parent().remove();
    } else {
        if($("line[n2='"+$(obj).attr("n2")+"']").length>0||$("line[n2='"+$(obj).attr("n2")+"']").length==0){
            $("line[n2='"+$(obj).attr("n2")+"']").remove();
            if($(obj).attr("type") == "iSWAP")
                $("#"+$(obj).attr("n2")).parent().remove();
            $("#"+$(obj).attr("n2")).remove();
            $("line[n3='"+$(obj).attr("n3")+"']").remove();
            $("#"+$(obj).attr("n3")).remove();
            $(obj).parent().remove();
        }else{//双击到rect元素内的path元素时 处理
            $("line[n2='"+$(obj).parent().find("rect").attr("n2")+"']").remove();
            if($(obj).parent().find("rect").attr("type") == "iSWAP")
                $("#"+$(obj).parent().find("rect").attr("n2")).parent().remove();
            $("#"+$(obj).parent().find("rect").attr("n2")).remove();
            $("line[n3='"+$(obj).parent().find("rect").attr("n3")+"']").remove();
            $("#"+$(obj).parent().find("rect").attr("n3")).remove();
            $(obj).parent().remove();
        }
    }
}

/**
 * 检查坐标
 */
function checkCoordinates(commandType){
    var currentQi = $("rect[focus=true][index='0']").attr("qi");
    var currentQs = $("rect[focus=true][index='0']").attr("qs");

    //判断测量比特后面是否存在其他比特
    if(commandType == "Measure"){//测量比特
        //找出当前行上的所有圆点
        var maxQs = -1;
        var rectId = "";
        var isHas = false;
        var measureCount = 1;
        $("rect[qi="+currentQi+"][index='0']").each(function(){
            var circleQs = $(this).attr("qs");
            //根据圆点id查找rect元素 存在则说明该圆点被占用
            rectId = currentQi + "-" + circleQs;
            if($("#"+rectId).length>0){
                if(parseInt(+$("#"+rectId).attr("qi")) == parseInt(oQi) && parseInt(+$("#"+rectId).attr("qs")) == parseInt(oQs)){

                }else{
                    maxQs = circleQs;
                }
                if($("#"+rectId).attr("type") == "Measure"){
                    if(isDrag){//拖拽
                        if(parseInt(+$("#"+rectId).attr("qi")) == parseInt(oQi) && parseInt(+$("#"+rectId).attr("qs")) == parseInt(oQs)){
                            return;
                        }else{
                            measureCount = measureCount + 1;
                        }
                    }else{
                        measureCount = measureCount + 1;
                    }
                    if(isHas){
                        return;
                    }else{
                        isHas = true;
                    }
                }
            }
        });
        //判断某线条上的最大的占用点的qs是否大于当前选择圆点的qs 是：当前点不允许放置测量比特，否：允许放置
        if(parseInt(currentQs) <= parseInt(maxQs)){
            return false;
        }else{
            if(isHas && !isDrag){
                return false;
            }
            if(isDrag)
                isHas = false;
        }
        if(parseInt(measureCount) > 1){
            return false;
        }

        var sourceStr ="";
        $("rect[qi="+currentQi+"][index='0']").each(function(){
            var circleQs = $(this).attr("qs");
            if(parseInt(circleQs)>parseInt(currentQs)){
                if($("rect[qi="+currentQi+"][qs="+circleQs+"][index='0']").length>0 || $("rect[qi="+currentQi+"][qs="+circleQs+"][index='1']").length>0){
                    if($("rect[qi="+currentQi+"][qs="+circleQs+"][index='1']").length>0){
                        var $obj = $("rect[qi="+currentQi+"][qs="+circleQs+"][index='1']");
                        if($obj.attr("id").indexOf("n2")>=0 || $obj.attr("id").indexOf("n3")>=0){
                            isHas = true;
                            return false;
                        }else{
                            sourceStr = buildIdentification(sourceStr,currentQi+"-"+circleQs);
                            if(getIdentification(sourceStr,currentQi+"-"+circleQs)){
                                isHas = true;
                                return false;
                            }
                        }
                    }else{
                        sourceStr = buildIdentification(sourceStr,currentQi+"-"+circleQs);
                        if(getIdentification(sourceStr,currentQi+"-"+circleQs)){
                            isHas = true;
                            return false;
                        }
                    }
                }
            }
        });
        if(isHas){
            return false;
        }
    }else{//非测量比特
        //找出当前行上的所有圆点
        var maxQs = -1;
        var rectId = "";
        var isHas = false;
        $("rect[qi="+currentQi+"][index='0']").each(function(){
            var circleQs = $(this).attr("qs");
            //根据圆点id查找rect元素 存在则说明该圆点被占用
            rectId = currentQi + "-" + circleQs;
            if($("#"+rectId).length>0){
                if($("#"+rectId).attr("type") == "Measure"){
                    maxQs = circleQs;
                }
            }
        });
        if(parseInt(maxQs) != -1 && parseInt(maxQs)<=parseInt(currentQs)){
            return false;
        }
    }

    //判断当前位置是否存在图片 若存在 不添加
    var imgId=currentQi+"-"+currentQs;
    if($("#"+imgId).length>0){
        return false;
    }

    //循环处理竖向连接线
    var isFlag=true;
    $("line[name='verticalLine']").each(function(index,obj){
        var startCx=$(obj).attr("x1");//竖向连接线 x轴开始坐标
        var startCy=$(obj).attr("y1");//竖向连接线 y轴开始坐标
        var endCx=$(obj).attr("x2");//竖向连接线 x轴结束坐标
        var endCy=$(obj).attr("y2");//竖向连接线 y轴结束坐标
        //首先判断当前选择坐标 y轴坐标是否相同 即：currentQs*columnHigh是否等于startCx
        if((currentQs*columnHigh)==startCx){
            //判断x轴坐标是否相同
            var StartLineNum=startCy/lineHigh;
            var endLineNum=endCy/lineHigh;
            if(currentQi>StartLineNum && currentQi<endLineNum){
                isFlag=false;
                return false;
            }
        }
    });
    if(!isFlag){
        return false;
    }
    return true;
}

/**
 * 显示图标
 */
function showIcon(obj){
    $(obj).parent().show();
    if($(obj).attr("n2")!=undefined && $(obj).attr("n2").length>0){
        var n2 = $(obj).attr("n2");
        $("line[n2="+n2+"]").show();
        $("#"+n2).show();
    }
    if($(obj).attr("n3")!=undefined && $(obj).attr("n3").length>0){
        var n3 = $(obj).attr("n3");
        $("line[n3="+n3+"]").show();
        $("#"+n3).show();
    }
    $("#dragImgBox").hide();

    if($("rect[focus=true][index='0']").length>0){
        if ($(obj).attr("type") == "CNOT" || $(obj).attr("type") == "iSWAP" || $(obj).attr("type") == "Toffoli" || $(obj).attr("type") == "CR"){
            if($(obj).attr("n2")==undefined ||$(obj).attr("n3")==undefined ){
                AttBuit(2)
            }
        }
    }
    isDrag=false;
}

/**
 * 判断元素是否拖拽至多比特门内
 */
function multiBitGateJudgment(dQi,dQs){
    //判断当前坐标是否是包含在多比特门之间
    var cQis = new Array();
    var isContain = true;
    $("svg rect[qs="+dQs+"][index='0']").each(function(){
        var cQi = $(this).attr("qi");
        var cQs = $(this).attr("qs");
        var circleId = cQi + "-" + cQs;
        if($("#"+circleId).length>0){
            var type = $("#"+circleId).attr("type");
            if(type=="Toffoli" || type=="CNOT" || type=="iSWAP" || type=="CR"){
                cQis[cQis.length] = $(this).attr("qi");
                var n2 = $("#"+circleId).attr("n2");
                cQis[cQis.length] = $("#"+n2).attr("qi");
                if($("#"+circleId).attr("n3")!=undefined && $("#"+circleId).attr("n3").length>0){
                    var n3 = $("#"+circleId).attr("n3");
                    cQis[cQis.length] = $("#"+n3).attr("qi");
                }
            }
        }
        cQis.sort();
        if(cQis.length>0 && parseInt(cQis[0])< parseInt(dQi) && parseInt(dQi) < parseInt(cQis[cQis.length-1])){
            isContain = false;
            return false;
        }
    });
    if(!isContain){
        currentX = undefined;
        currentY = undefined;
        prompt(messages.already_exists_on_vertical_line);
        return false;
    }
    return true;
}
