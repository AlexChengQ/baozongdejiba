var xmlns = "http://www.w3.org/2000/svg";
var lineHigh = 50;//行高
var columnHigh = 50;//列宽
var lineNum = 0;//列宽
var stepNum = 0;//列宽
var classicName = "$";
var classicNum = 0;
var codeMirror;

var flag = 0;
var evt;

var QinitStr = "";//code2Trans.js使用
var isDrag = false;

$(document).ready(function() {
    command();
    codeCollection();
    // 初始化时，图标添加拖拽事件
    $('#svgBoard').find('rect[index="1"]').each(function() {
        if($(this).attr("id").indexOf("n2")>-1){

        }else {
            dragObj($(this).attr("id"));
        }
    });

    $("#saveProperty").click(function(event) {
        if (fromAdmin != undefined && fromAdmin == "1") {
            prompt(messages.unauthorized_operation);
            return false;
        }
        event.stopPropagation();
        /*if (!login) {
            prompt(messages.visitor_no_right);
            return;
        }*/
        if (!isCase()) {
            return;
        }
        if (!isSemi()) {
            return;
        }
        if ($("rect[focus=true][index='1']").attr("type") == "iSWAP") {
            var expression = $("#property").val().trim();
            // 修改版本
            expression = expression.replace(/\s*/g, "").replace(/\n/g, "").replace(/\r/g, "");
            $("#property").val(expression);
            if (expression.length > 32) {
                prompt(messages.expression_32);
                return false;
            }

            if (expression == '' || !expressionRegexp(expression)) {
                prompt(messages.expression_is_not_legal);
                return false;
            }
            // 原版本
            $("rect[focus=true][index='1']").attr("operation", expression);
        } else if ($("rect[focus=true][index='1']").attr("type") == "Measure") {
            $("rect[focus=true][index='1']").attr("register", $("#classicName").val());
        } else {
            var expression = $("#property").val().trim();
            expression = expression.replace(/\s*/g, "").replace(/\n/g, "").replace(/\r/g, "");
            $("#property").val(expression);
            if (expression.length > 32) {
                prompt(messages.expression_32);
                return false;
            }

            if (expression == '' || !expressionRegexp(expression)) {
                prompt(messages.expression_is_not_legal);
                return false;
            }

            $("rect[focus=true][index='1']").attr("expression", expression);
        }
        // 重置样式
        $(".LayerSetting").hide()
        //property
        $(".LaySetLine1").hide();

        //iswap
        $(".LaySetLine3").hide();
        $("#commandTip").hide();

        //classicName
        $(".LaySetLine2").hide();

        //操作按钮
        $(".LayConfirm").hide();

        //新手引导
        if ($("#svgBoard rect[type='Measure']").length == 1) {
            if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
                $(".guideId19").attr("style","");
                $(".LayerSetting").attr("style","");
                CloudCLD.guideLocation(30,60, 0,0, 0,0, 13 ,-48,20,'.pointTag8');
            }
            // return false;
        }else if ($("#svgBoard rect[type='Measure']").length == 2){
            if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
                $(".guideId22").attr("style","");
                $(".LayerSetting").attr("style","");
                CloudCLD.guideLocation(70,50, "auto","auto",-60,-88, 13 ,-48,23 ,'.New_edit');
            }
        }
        prompt(messages.settings_successful, "success");
    });
    //关闭参数设置
    $("#savePropertyClear").on("click",function () {
        // 重置样式
        $(".LayerSetting").hide()
        //property
        $(".LaySetLine1").hide();

        //iswap
        $(".LaySetLine3").hide();
        $("#commandTip").hide();

        //classicName
        $(".LaySetLine2").hide();

        //操作按钮
        $(".LayConfirm").hide();

        //新手引导
        if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
            if ($("#svgBoard rect[type='Measure']").length == 1) {
                $(".guideId19").attr("style","");
                $(".LayerSetting").attr("style","");
                CloudCLD.guideLocation(30,60, 0,0, 0,0, 13 ,-48,20,'.pointTag8');
                // return false;
            }else if ($("#svgBoard rect[type='Measure']").length == 2){
                $(".guideId22").attr("style","");
                $(".LayerSetting").attr("style","");
                CloudCLD.guideLocation(70,50, "auto","auto",-60,-88, 13 ,-48,23 ,'.New_edit');
            }
        }

    })
});

//生成模板图形
var appendRectSvg='';
function appendRect(id,x,y,qi,qs,cx,cy) {
    var circle = document.createElementNS(xmlns, "rect");
    circle.setAttribute("id", id);
    if(cx!=''||cy!=''){
        circle.setAttribute("cx", cx);
        circle.setAttribute("cy", cy);
    }

    circle.setAttribute("x", x);
    circle.setAttribute("y", y);
    circle.setAttribute("width", 18);
    circle.setAttribute("height", 18);
    circle.setAttribute("rx", 9);
    circle.setAttribute("ry", 9);
    circle.setAttribute("index", '1');
    circle.setAttribute("r", "9");
    circle.setAttribute("qi", qi);
    circle.setAttribute("qs", qs);
    circle.setAttribute("fill", "#B3DE7B");
    return circle
}

//重置rect
function resetRect() {
    $("#svgBoard rect[index='1']").attr("stroke", "none");
    $("#svgBoard rect[index='0']").attr("stroke", "none");
    $("rect[focus=true][index='0']").attr("fill", "#fff");
    $("rect[focus=true][index='0']").attr("fill-opacity", "0");
    $("rect[focus=true][index='0']").attr("r", "3");
    $("rect[focus=true][index='0']").attr("stroke", "none");
    $("rect[focus=true][index='0']").removeAttr("focus");
}

// 重置高亮
function resetHL() {
    //高亮重置
    $("rect[width='14'][index='0']").each(function (t) {
        $(this).attr({
            "fill":"#fff",
            "x":parseInt($(this).attr('x'))-22,
            "y":parseInt($(this).attr('y'))-12,
            "width":"60",
            "height":"40",
            "rx":"0",
            "ry":"0",
            "stroke":"none",
            "stroke-width":"none",
            "fill-opacity":"0"
        })
    })
}
//重置参数设置
function resetView() {
    // 重置样式
    $(".LayerSetting").hide()
    //property
    $(".LaySetLine1").hide();
    //iswap
    $(".LaySetLine3").hide();
    $("#commandTip").hide();
    //classicName
    $(".LaySetLine2").hide();
    //操作按钮
    $(".LayConfirm").hide();

}
/**
 * 图标点击生成事件
 */
function command() {
    if (fromAdmin != undefined && fromAdmin == "1") {
        return false;
    }
    //为选择图标绑定事件
    $(".Layer_Con .Layer_sort_con li").click(function(event) {
        // $(".commandList dd.current").removeClass("current");
        // $(".dmhj dd.current").removeClass("current");

        if (!checkGrammar()) {
            return false;
        }
        if ($("rect[focus=true][index='1']").length != 0 || $("rect[focus=true][index='0']").length == 0) {
            $(this).addClass("current");
            resetRect()
            $("rect[focus=true][index='1']").removeAttr("focus");
            isDrag=false;
            return false;
        }
        var currentQi = $("rect[focus=true][index='0']").attr("qi");
        var currentQs = $("rect[focus=true][index='0']").attr("qs");
        var commandType = $(this).attr("type");
        //新手引导添加
        if (getCookie('isNext') == 1 || getCookie("isCookie") == 1) {
            if($(this).attr("type")=="H"){
                $(".guideId11").attr("style","");
                CloudCLD.guideLocation(30,60, 0,0, 0,0, 13 ,-48,12 ,'.pointTag3');
            }else if($(this).attr("type")=="CNOT"){
                $(".guideId14").attr("style","");
                CloudCLD.guideLocation(30,60, 0,0, 0,0, 13 ,-48,15 ,'.pointTag5');
            }else if($(this).attr("type")=="Measure"){
                if ($("#svgBoard rect[type='Measure']").length == 0) {
                    $(".guideId18").attr("style","");
                    setTimeout(function () {
                        CloudCLD.guideLocation(45,50,-60,-30,"auto","auto", 13 ,-48 ,19 ,'.LayerSetting');
                    },100)

                    // return false;
                }else if ($("#svgBoard rect[type='Measure']").length == 1){
                    $(".guideId21").attr("style","");
                    setTimeout(function () {
                        CloudCLD.guideLocation(45,50,-60,-30,"auto","auto", 13 ,-48 ,22 ,'.LayerSetting');
                    },100)
                }
            }
        }
        //非点击事件弹层隐藏
        if(!isDrag){
            $(".LayerContent").hide();
        }
        //判断测量比特后面是否存在其他比特
        if (commandType == "Measure") {//测量比特
            //找出当前行上的所有圆点
            var maxQs = -1;
            var rectId = "";
            var isHas = false;
            var measureCount = 1;
            $("rect[qi=" + currentQi + "][index='0']").each(function() {
                var circleQs = $(this).attr("qs");
                //根据圆点id查找rect元素 存在则说明该圆点被占用
                rectId = currentQi + "-" + circleQs;
                if ($("#" + rectId).length > 0) {
                    if(parseInt($("#" + rectId).attr("qi")) == parseInt(oQi) && parseInt($("#" + rectId).attr("qs")) == parseInt(oQs)){} else {
                        maxQs = circleQs;
                    }
                    if ($("#" + rectId).attr("type") == "Measure") {
                        if (isDrag) {//拖拽
                            if(parseInt($("#" + rectId).attr("qi")) == parseInt(oQi) && parseInt($("#" + rectId).attr("qs")) == parseInt(oQs)){
                                return;
                            }else{measureCount = measureCount + 1;}
                        }else{
                            measureCount = measureCount + 1;
                        }
                        if (isHas) {
                            return;
                        } else {
                            isHas = true;
                            return;
                        }
                    }
                }
            });
            //判断某线条上的最大的占用点的qs是否大于当前选择圆点的qs 是：当前点不允许放置测量比特，否：允许放置
            if (parseInt(currentQs) <= parseInt(maxQs)) {
                prompt(messages.measure_is_end);
                checkCircle();
                return false;
            } else {
                if (isHas && !isDrag) {
                    prompt(messages.measure_is_only);
                    checkCircle();
                    return false;
                }
                if (isDrag) {
                    isHas = false;
                }
            }
            if (parseInt(measureCount) > 1) {
                prompt(messages.measure_is_only);
                checkCircle();
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
                            sourceStr = buildIdentification(sourceStr, currentQi + "-" + circleQs);
                            if(getIdentification(sourceStr,currentQi+"-"+circleQs)){
                                isHas = true;
                                return false;
                            }
                        }
                    }
                }
            });
            if(isHas){
                prompt(messages.measure_not_more_qubit);
                checkCircle();
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
                prompt(messages.measure_is_end);
                checkCircle();
                return false;
            }else {
                if(commandType == 'CNOT' || commandType == 'iSWAP' || commandType == 'CR' || commandType == 'Toffoli'){//点击操作可选择控制门的时候高亮图标
                    AttBuit();
                    $(".LayerContent").hide();
                }
            }
        }

        var columnPoint=parseFloat(currentQs) * parseFloat(columnHigh);//第几列
        var linePoint=parseFloat(currentQi) * parseFloat(lineHigh);//第几行

        //判断当前位置是否存在图片 若存在 不添加
        /*var imgId=currentQi+"-"+currentQs;
        if($("#"+imgId).length>0){
            prompt(messages.point_already_exists);
            checkCircle();
            return false;
        }*/
        $("rect[qs=" + currentQs + "][index='1']").each(function() {
            var success = true;
            if ($(this).attr("qi") == currentQi) {
                success = false;
            } else if ($(this).attr("n2") && $("#" + $(this).attr("n2")).attr("qi") == currentQi) {
                success = false;
            } else if ($(this).attr("n3") && $("#" + $(this).attr("n3")).attr("qi") == currentQi) {
                success = false;
            }
            if (!success) {
                prompt(messages.point_already_exists);
                checkCircle();
                return success;
            }

        });
        //循环处理竖向连接线
        var isFlag = true;
        $("line[name='verticalLine']").each(function(index,obj) {
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
        if (!isFlag) {
            prompt(messages.icons_not_allowed);
            checkCircle();
            return false;
        }

        var rectG = $("#svg_"+commandType+" g").clone();//document.createElementNS (xmlns, "g");

        if($("rect[focus=true][index='0']").length==0){
            isDrag=false;
            return;
        }
        rectG.attr('transform',"translate(" + (+$("rect[focus=true][index='0']").attr("x") +5) + "," + (+$("rect[focus=true][index='0']").attr("y") - 5) + ")");
        $(rectG).find("rect").attr('stroke', 'black');
        $(rectG).find("rect").attr('stroke-width', '1');

        $(rectG).find("rect").attr("qi", currentQi);
        $(rectG).find("rect").attr("qs", currentQs);
        $(rectG).find("rect").attr('refcx', $("rect[focus=true][index='0']").attr("x"));
        $(rectG).find("rect").attr('refcy', $("rect[focus=true][index='0']").attr("y"));
        $(rectG).find("rect").attr('id', currentQi+"-"+currentQs);
        $(rectG).find("rect").attr('type', commandType);
        $(rectG).find("rect").attr( 'focus', 'true');
        //绑定单击事件
        $(rectG).attr("onclick", "clickImage(evt)");

        if (commandType == "RZ" || commandType == "RX" || commandType == "RY" || commandType == "CR") {
            $(rectG).find("rect").attr( 'expression', 'pi/4');
        } else if (commandType == "Measure") {
            if(parseInt(analogType) == 0) {//模拟类型为：Monte-Carlo
                $(rectG).find("rect").attr( 'register', classicName + "" + currentQi);
            } else {
                $(rectG).find("rect").attr( 'register', currentQi);
            }
        } else if (commandType == "iSWAP") {
            $(rectG).find("rect").attr( 'operation', "pi");
        }
        $("rect[focus=true][index='0']").parent().append(rectG);
        isDrag = false;//原处598
        propertyBoard(currentQi + "-" + currentQs);
        dragObj(currentQi + "-" + currentQs);//为已生成的图形绑定拖拽事件
        return false;
    });
}
var setIntTime = null;
var setClickTime = null;
function resetFlag() {
    clearTimeout(setIntTime)
    clearTimeout(setClickTime)
    flag = 0;
}
function clickImage(evt1) {
    setIntTime=setTimeout("resetFlag()", 850);
    evt = evt1;
    flag++;
    if (flag != 0) {
        setClickTime=setTimeout("clickImage2();", 200);
    }
    evt1.stopPropagation();
}

// 页面线条上的图标点击事件
function clickImage2() {
    if (!(fromAdmin != undefined && fromAdmin == "1")) {
        /*if (!login) {
            prompt(messages.visitor_no_right);
            return;
        }*/
    }
    if (!isCase()) {return;}
    if (!isSemi()) {return;}
    $(".commandList dd.current").removeClass("current");
    $(".dmhj dd.current").removeClass("current");
    isDrag=false;
    if (flag == 2) {// evt.detail==2表示双击 evt.detail==1表示单击\
        if (fromAdmin != undefined && fromAdmin == "1") {
            return false;
        }
        // ISWAP图形
        if ($(evt.target).attr("refid")) {
            var id = $(evt.target).attr("refid");
            if ($(evt.target).attr("type") == "iSWAP") {
                $("#" + $("#" + id).attr("n2")).parent().remove();
            }
            $("line[n2='" + $("#" + id).attr("n2") + "']").remove();
            $("#" + $("#" + id).attr("n2")).remove();
            $("line[n3='" + $("#" + id).attr("n3") + "']").remove();
            $("#" + $("#" + id).attr("n3")).remove();
            $("rect[refid='" + id + "'][index='1']").remove();
            $("#" + id).parent().remove();
            resetView();

            var rectType = $(evt.target).attr("type");
            if (rectType == 'CNOT' || rectType == 'iSWAP' || rectType == 'CR' || rectType == 'Toffoli') {
                var n2 = $(evt.target).attr("n2");
                if (n2 == undefined) {
                    AttBuit(1)
                    return false;
                }

                if (rectType == 'Toffoli' && n2 && $(evt.target).attr("n3") == undefined) {
                    AttBuit(1)
                    return false;
                }
            }
        } else {
            if ($("line[n2='" + $(evt.target).attr("n2") + "']").length > 0) {
                $("line[n2='" + $(evt.target).attr("n2") + "']").remove();
                if ($(evt.target).attr("type") == "iSWAP")
                    $("#" + $(evt.target).attr("n2")).parent().remove();
                $("#" + $(evt.target).attr("n2")).remove();
                $("line[n3='" + $(evt.target).attr("n3") + "']").remove();
                $("#" + $(evt.target).attr("n3")).remove();
                $(evt.target).parent().remove();
                resetView();
            } else {// 双击到rect元素内的path元素时 处理
                $("line[n2='" + $(evt.target).parent().find("rect[index='1']").attr("n2") + "']").remove();
                if ($(evt.target).parent().find("rect[index='1']").attr("type") == "iSWAP")
                    $("#" + $(evt.target).parent().find("rect[index='1']").attr("n2")).parent().remove();
                $("#" + $(evt.target).parent().find("rect[index='1']").attr("n2")).remove();
                $("line[n3='" + $(evt.target).parent().find("rect[index='1']").attr("n3") + "']").remove();
                $("#" + $(evt.target).parent().find("rect[index='1']").attr("n3")).remove();
                $(evt.target).parent().remove();
                resetView();
            }
            var rectCommands = $("rect[focus=true][index='1']");
            rectCommand = rectCommands[0];
            var rectType = $(rectCommand).attr("type");
            if (rectType == 'CNOT' || rectType == 'iSWAP' || rectType == 'CR' || rectType == 'Toffoli') {
                var n2 = $(rectCommand).attr("n2");
                if (n2 == undefined) {
                    AttBuit(1)
                    return false;
                }

                if (rectType == 'Toffoli' && n2 && $(rectCommand).attr("n3") == undefined) {
                    AttBuit(1)
                    return false;
                }
            }

        }
        resetHL();

    } else if (flag == 1) {
        var currentCommands = $("rect[focus=true][index='1']");
        if (currentCommands.length == 1 && ($(currentCommands).attr("qi") != $(evt.target).attr("qi")
            || $(currentCommands).attr("qs") != $(evt.target).attr("qs"))) {
            currentCommand = currentCommands[0];
            var commandType = $(currentCommand).attr("type");
            if (commandType == "RZ" || commandType == "RX" || commandType == "RY") {
                var expression = $(currentCommand).attr("expression");
                if (expression.length > 32) {
                    prompt(messages.expression_32);
                    return false;
                }

                if (expression == '' || !expressionRegexp(expression)) {
                    prompt(messages.expression_is_not_legal);
                    return false;
                }
            }
            if (commandType == "CR" && $(currentCommand).attr("n2") != undefined) {
                var expression = $(currentCommand).attr("expression");
                if (expression.length > 32) {
                    prompt(messages.expression_32);
                    return false;
                }

                if (expression == '' || !expressionRegexp(expression)) {
                    prompt(messages.expression_is_not_legal);
                    return false;
                }
            }

            if (commandType == 'CNOT' || commandType == 'iSWAP' || commandType == 'CR' || commandType == 'Toffoli') {
                var n2 = $(currentCommand).attr("n2");
                if (n2 == undefined) {
                    prompt(messages.second_points_must_be_set);
                    return false;
                }

                if (commandType == 'Toffoli' && n2 && $(currentCommand).attr("n3") == undefined) {
                    prompt(messages.Second_points_must_be_set);
                    return false;
                }
            }
        }


        $("#svgBoard rect[index='1'][width='40']").attr("stroke", "none");
        $("#svgBoard rect[index='0'][width='60']").attr("stroke", "none");
        $("rect[focus=true][index='0'][width='60']").attr("fill", "#fff");
        $("rect[focus=true][index='0'][width='60']").attr("fill-opacity", "0");
        $("rect[focus=true][index='0'][width='60']").attr("r", "3");
        $("rect[focus=true][index='0'][width='60']").attr("stroke", "none");
        $("rect[focus=true][index='1'][width='40']").removeAttr("focus");
        // $("rect[focus=true][index='0'][width='60']").removeAttr("focus");
        if ($(evt.target).attr("refid")) {
            var id = $(evt.target).attr("refid");
            // $("#" + id).parent().find("rect,circle").attr("stroke", "black");
            $("#" + id).attr("stroke", "black");
            $("#" + id).attr("focus", "true");
            propertyBoard(id);
        } else {
            if($(evt.target).attr("qi")==undefined){
                $(evt.target).siblings("rect").attr("stroke", "black");
                $(evt.target).siblings("rect").attr("focus", "true");
                if(flagM==0){
                    flagM=1;
                    propertyBoard($(evt.target).siblings("rect").attr("id"),1);
                }else {
                    propertyBoard($(evt.target).siblings("rect").attr("id"));
                }
            }else {
                $(evt.target).attr("stroke", "black");
                $(evt.target).attr("focus", "true");
                if(flagM==0){
                    flagM=1;
                    propertyBoard($(evt.target).attr("id"),1);
                }else {
                    propertyBoard($(evt.target).attr("id"));
                }
            }


        }
    }
    return false;
}

// 点击圆点操作
/*function clickCircle(evt1) {
    if (fromAdmin != undefined && fromAdmin == "1") {
        return false;
    }
    isDrag = false;
    setTimeout("resetFlag()", 250);
    evt = evt1;
    flag++;
    if (flag != 0) {
        setTimeout("clickCircle2();", 200);
    }
    evt1.stopPropagation();
}*/
var timer;
var goFor,LineFor;
var flagClick;
function clickDotCircle(evt1) {

    var temporary=[]
    var xL=parseInt($(evt1.currentTarget).attr('x'))+30
    var xLIs=parseInt($(evt1.currentTarget).attr('x'))
    var yLIs=parseInt($(evt1.currentTarget).attr('y'))
    $('line[x1="'+xL+'"]').each(function (value,i) {
        temporary.push({y1:$(this).attr("y1"),y2:$(this).attr("y2")})
    })
    commandTypeClick=$("rect[index='1'][refcx='"+xLIs+"'][refcy='"+yLIs+"']").attr("type");
    if (commandTypeClick != undefined) {
        var n2 = $($("rect[focus=true][index='1']")).attr("n2");
        if (n2 == undefined) {
            prompt(messages.second_points_must_be_set);
            return false;
        }

        if ($($("rect[focus=true][index='1']")).attr("type") == 'Toffoli' && n2 && $($("rect[focus=true][index='1']")).attr("n3") == undefined) {
            prompt(messages.second_points_must_be_set);
            return false;
        }
    }
        if(temporary==''){
            clickDotCircleNext(evt1)
        }else {
            flagClick=0;
            var isHas =0
            for(var i=0;i<temporary.length;i++){
                if (parseInt($(evt1.currentTarget).attr('y')) > parseInt(temporary[i].y1) && parseInt($(evt1.currentTarget).attr('y')) <parseInt(temporary[i].y2)) {
                    isHas=1
                    evt1.stopPropagation();
                    break;
                } else {}
            }

            if(isHas==0){
                if(flagClick==0) {
                    flagClick++
                    clickDotCircleNext(evt1);
                }
                evt1.stopPropagation();
            }
        }
    evt1.stopPropagation();
}
function clickDotCircleNext(evt1) {
    if (timer) {
        clearTimeout(timer);
    }
    if (fromAdmin != undefined && fromAdmin == "1") {return false;}
    //if (!login) {prompt(messages.visitor_no_right);return;}
    if (!isCase()) {return;}
    if (!isSemi()) {return;}
    // if(!isSelfDrag){}

    timer = setTimeout(function() {resetFlag()}, 250);
    evt = evt1;
    goFor=$(evt.currentTarget).attr("qs")||$(evt.target).attr("qs");
    LineFor=$(evt.currentTarget).attr("qi")||$(evt.target).attr("qi");
    _clickCircle();

    flag++;
    if (flag == 2) {
        flag = 0;
        clearTimeout(timer);
        // dblclickCircle();
    }
    evt1.stopPropagation();
}
function mouseoverDotDotCircle(e) {
   // if ($(e).attr("fill") == "#060606"||$(e).attr("fill") == "#fff"&&$(e).attr("stroke-width")=="4" &&$(e).attr("stroke")=="#b3de7b") {return false}
}
function mouseoutDotCircle(e) {
   // if ($(e).attr("r") == 7&&$(e).attr("focus")!="true"&&$(e).attr("stroke")!="#b3de7b") {}
}

function clickCircle(evt1) {
    if (timer) {
        clearTimeout(timer);
    }
    if (fromAdmin != undefined && fromAdmin == "1") {return false;}
    //if (!login) {prompt(messages.visitor_no_right);return;}
    if (!isCase()) {return;}
    if (!isSemi()) {return;}

    isDrag = false;
    timer = setTimeout(function() {resetFlag()}, 250);
    evt = evt1;
    goFor=$(evt.currentTarget).attr("qs");
    LineFor=$(evt.currentTarget).attr("qi");
    _clickCircle();

    flag++;
    if (flag == 2) {
        flag = 0;
        clearTimeout(timer);
        // dblclickCircle();
    }
    evt1.stopPropagation();
}

function layerContent() {
    var e = event || window.event;
    var scrollX = document.documentElement.scrollLeft || document.body.scrollLeft;
    var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
    var x = e.pageX || e.clientX + scrollX;
    var y = e.pageY || e.clientY + scrollY;
    //非点击事件弹层不跟随
    if(!isDrag){
        if(!(goFor==$('rect[index="1"][qi="'+LineFor+'"][qs="'+goFor+'"]').attr("qs"))){
            $(".LayerContent").css({"top":y+30,left:x-$(".LayerContent").width()/2})
            $(".LayerContent").show();
        }
    }
}
//点击圆点
function _clickCircle() {
    var currentCommands = $("rect[focus=true][index='1']");
    if ($(currentCommands[0]).attr("type") == "CNOT" || $(currentCommands[0]).attr("type") == "iSWAP" || $(currentCommands[0]).attr("type") == "Toffoli" || $(currentCommands[0]).attr("type") == "CR"){
        if(goFor!=$("rect[focus=true][index='1']").attr("qs")&&$("rect[focus=true][index='1']").attr("n2")==undefined&&isSelfDrag){
            return false;
        }
    }

    if (currentCommands.length == 1) {
        currentCommand = currentCommands[0];
        var circleQi = parseInt($(evt.target).attr("qi"));
        var circleQs = parseInt($(evt.target).attr("qs"));
        var currentQi = parseInt($(currentCommand).attr("qi"));
        var currentQs = parseInt($(currentCommand).attr("qs"));
        var commandType = $(currentCommand).attr("type");

        if (commandType == "CNOT" || commandType == "iSWAP" || commandType == "Toffoli" || commandType == "CR") {
            if ((commandType != "Toffoli" && $(currentCommand).attr("n2") == undefined)
                || (commandType == "Toffoli" && $(currentCommand).attr("n3") == undefined)) {
                // 仅需处理circleQi与circleQs 不允许存在于测量门后面 可以存在于前面
                var isHas = false;
                $("rect[qi=" + circleQi + "][index='0']").each(function() {
                    var qs = $(this).attr("qs");
                    // 根据圆点id查找rect元素 存在则说明该圆点被占用
                    if (parseInt(qs) < parseInt(circleQs)) {
                        var rectId = circleQi + "-" + qs;
                        if ($("#" + rectId).length > 0) {
                            if ($("#" + rectId).attr("type") == "Measure") {
                                isHas = true;
                                return false;
                            }
                        }
                    }
                });
                if (isHas) {
                    prompt(messages.measure_is_end);
                    return false;
                }
            }
        }

        if (commandType == "RZ" || commandType == "RX" || commandType == "RY"||commandType == "CR" && $(currentCommand).attr("n2") != undefined) {
            var expression = $(currentCommand).attr("expression");
            if (expression.length > 32) {
                prompt(messages.expression_32);
                return false;
            }

            if (expression == '' || !expressionRegexp(expression)) {
                prompt(messages.expression_is_not_legal);
                return false;
            }
        }

        // if (commandType == "CR" && $(currentCommand).attr("n2") != undefined) {
        //     var expression = $(currentCommand).attr("expression");
        //     if (expression.length > 32) {
        //         prompt(messages.expression_32);
        //         return false;
        //     }
        //
        //     if (expression == '' || !expressionRegexp(expression)) {
        //         prompt(messages.expression_is_not_legal);
        //         return false;
        //     }
        // }

        if (commandType == 'CNOT' || commandType == 'iSWAP' || commandType == 'CR' || commandType == 'Toffoli') {
            //待定
            if ($(currentCommand).attr("qs") == $(evt.target).attr("qs")&&$(currentCommand).attr("qi") == $(evt.target).attr("qi")) {
                return false;
            }
            var n2 = $(currentCommand).attr("n2");
            if (n2) {
                if (commandType != 'Toffoli') {
                    resetRect()
                    $(currentCommand).removeAttr("focus");
                    resetView();

                    evt.target.setAttribute("fill", "#fff");
                    evt.target.setAttribute("fill-opacity", "0");
                    evt.target.setAttribute("r", "7");
                    evt.target.setAttribute("stroke", "none");
                    evt.target.setAttribute("focus", "true");
                    // return false;
                }
            } else {
                if ($(currentCommand).attr("qs") != $(evt.target).attr("qs")) {
                    if(!isSelfDrag){
                        prompt(messages.second_points_must_be_on_vertical_line);
                        return false;
                    }else{
                        resetRect()
                        $(currentCommand).removeAttr("focus");
                        resetView();
                        evt.target.setAttribute("fill", "#333");
                        evt.target.setAttribute("r", "7");
                        evt.target.setAttribute("stroke", "#333");
                        evt.target.setAttribute("focus", "true");
                    }
                } else {
                    var line = document.createElementNS(xmlns, "line");
                    line.setAttribute("n2", "n2-" + circleQi + "-" + currentQs);
                    line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill", "#a6ce38");
                    // if($(evt.target).attr("width")=="60")

                    var isGlobalNumberX=0;
                    var isGlobalNumberY=0;
                    if($(evt.target).attr("width")=="60"){
                        isGlobalNumberX=22;
                        isGlobalNumberY=12;
                    }else {
                        isGlobalNumber=0
                    }
                    if (circleQi < currentQi) {
                        for (var qi = circleQi + 1; qi < currentQi; qi++) {
                            if ($("#" + qi + "-" + currentQs).length != 0) {
                                prompt(messages.already_exists_on_vertical_line);
                                return false;
                            }
                        }

                        line.setAttribute("x1", parseInt($(evt.target).attr("x"))+8+isGlobalNumberX);
                        // line.setAttribute("x1", parseInt($(currentCommand).attr("refcx"))+30);
                        line.setAttribute("x2", parseInt($(currentCommand).attr("refcx"))+30);
                        line.setAttribute("y1", parseInt($(evt.target).attr("y")) + 28+isGlobalNumberY);
                        line.setAttribute("y2", parseInt($(currentCommand).attr("refcy")) - 10);
                        if (commandType == 'Toffoli') {
                            line.setAttribute("y1", parseInt($(evt.target).attr("y")) + 8+isGlobalNumberY);
                            line.setAttribute("y2", parseInt($(currentCommand).attr("refcy")) + 10);
                        }else if (commandType == 'iSWAP') {
                            line.setAttribute("y1", parseInt($(evt.target).attr("y"))+28+isGlobalNumberY);
                            line.setAttribute("y2", parseInt($(currentCommand).attr("refcy")));
                        }else {
                            line.setAttribute("y1", parseInt($(evt.target).attr("y"))+6+isGlobalNumberY);
                            line.setAttribute("y2", parseInt($(currentCommand).attr("refcy")));
                        }
                        $(currentCommand).parent().parent().append(line);
                    } else if (circleQi > currentQi) {
                        for (var qi = currentQi + 1; qi < circleQi; qi++) {
                            if ($("#" + qi + "-" + currentQs).length != 0) {
                                prompt(messages.already_exists_on_vertical_line);
                                return false;
                            }
                        }
                        line.setAttribute("x1", parseInt($(currentCommand).attr("refcx"))+30);
                        line.setAttribute("y1", parseInt($(currentCommand).attr("refcy")) + 37);
                        line.setAttribute("x2", parseInt($(evt.target).attr("x"))+8+isGlobalNumberX);
                        line.setAttribute("y2", parseInt($(evt.target).attr("y"))+8+isGlobalNumberY);
                        $(evt.target).parent().append(line);
                    }

                    if (commandType == 'iSWAP') {
                        var rectG = $("#svg_iSWAP g").clone();// document.createElementNS
                        // (xmlns, "g");
                        rectG.attr('transform', "translate(" + (parseInt($(evt.target).attr("x")) -17+isGlobalNumberX) + ","+ (parseInt($(evt.target).attr("y"))-17+isGlobalNumberY) + ")");

                        $(rectG).find("rect").attr("qi", circleQi);
                        $(rectG).find("rect").attr("qs", circleQs);
                        $(rectG).find("rect").attr('refcx', $("rect[focus=true][index='0']").attr("x")-22);
                        $(rectG).find("rect").attr('refcy', $("rect[focus=true][index='0']").attr("y")-12);
                        $(rectG).find("rect").attr('id', "n2-" + circleQi + "-" + circleQs);
                        $(rectG).find("rect").attr('type', commandType);
                        $(rectG).find("rect").attr('refid', currentQi + "-" + currentQs);
                        $(rectG).find("rect").attr("onclick", "clickImage(evt)");

                        $(evt.target).parent().append(rectG);
                    } else {

                        appendRectSvg=appendRect(
                            "n2-" + circleQi + "-" + currentQs,
                            parseInt($(evt.target).attr("x"))-1+isGlobalNumberX,
                            parseInt($(evt.target).attr("y"))-2+isGlobalNumberY,
                            circleQi,
                            circleQs,
                            $(evt.target).attr("x")-22+isGlobalNumberX,
                            $(evt.target).attr("y")-12+isGlobalNumberY
                        )

                        $(evt.target).parent().append(appendRectSvg);
                    }
                    if(commandType!="Toffoli"){
                        // $(currentCommand).removeAttr("focus");
                        $(currentCommand).attr("stroke", "none");
                        isSelfDrag=false;
                        resetHL();
                    }
                    $(".LayerContent").hide();
                    $(currentCommand).attr("n2", "n2-" + circleQi + "-" + currentQs);
                }
            }
            if (commandType == 'Toffoli' && n2) {
                var n3 = $(currentCommand).attr("n3");
                if (n3) {
                    resetRect()
                    $(currentCommand).removeAttr("focus");
                    evt.target.setAttribute("fill", "#fff");
                    evt.target.setAttribute("fill-opacity", "0");
                    evt.target.setAttribute("r", "7");
                    evt.target.setAttribute("stroke", "none");
                    evt.target.setAttribute("focus", "true");
                    layerContent()
                    return;
                }
                if ($(currentCommand).attr("qs") != $(evt.target).attr("qs")) {
                    if(!isSelfDrag){
                        prompt(messages.third_points_must_be_on_vertical_line);
                        return false;
                    }else{
                        resetRect();
                        $(currentCommand).removeAttr("focus");
                        evt.target.setAttribute("fill", "#ff");
                        evt.target.setAttribute("fill-opacity", "0");
                        evt.target.setAttribute("r", "7");
                        evt.target.setAttribute("stroke", "none");
                        evt.target.setAttribute("focus", "true");
                        return;
                    }

                } else {
                    var line = document.createElementNS(xmlns, "line");
                    line.setAttribute("n3", "n3-" + currentQi + "-" + currentQs);
                    line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill", "#B3DE7B");
                    var isGlobalNumberX=0;
                    var isGlobalNumberY=0;
                    if($(evt.target).attr("width")=="60"){
                        isGlobalNumberX=22;
                        isGlobalNumberY=12;
                    }else {
                        isGlobalNumber=0
                    }
                    if (circleQi < currentQi) {
                        for (var qi = circleQi + 1; qi < currentQi; qi++) {
                            if ($("#" + qi + "-" + currentQs).length != 0) {
                                prompt(messages.already_exists_on_vertical_line);
                                return false;
                            }
                        }
                        line.setAttribute("x2", parseInt($(evt.target).attr("x"))+8+isGlobalNumberX);
                        line.setAttribute("y2", parseInt($(evt.target).attr("y"))-2+isGlobalNumberY);

                        line.setAttribute("x1", parseInt($(currentCommand).attr("refcx"))+30);
                        line.setAttribute("y1", parseInt($(currentCommand).attr("refcy")));
                        $(currentCommand).parent().parent().append(line);
                    } else if (circleQi > currentQi) {
                        for (var qi = currentQi + 1; qi < circleQi; qi++) {
                            if ($("#" + qi + "-" + currentQs).length != 0) {
                                prompt(messages.already_exists_on_vertical_line);
                                return false;
                            }
                        }

                        line.setAttribute("x1", parseInt($(currentCommand).attr("refcx"))+30);
                        line.setAttribute("y1", parseInt($(currentCommand).attr("refcy")) + 40);
                        line.setAttribute("x2", parseInt($(evt.target).attr("x"))+8+isGlobalNumberX);
                        line.setAttribute("y2", parseInt($(evt.target).attr("y"))-2+isGlobalNumberY);
                        $(evt.target).parent().append(line);
                    }

                    appendRectSvg=appendRect(
                        "n3-" + currentQi + "-" + currentQs,
                        parseInt($(evt.target).attr("x"))-1+isGlobalNumberX,
                        parseInt($(evt.target).attr("y"))-2+isGlobalNumberY,
                        circleQi,
                        circleQs,
                        '',
                        ''
                    )
                    // circle.setAttribute("onclick","clickN3(evt)");
                    $(evt.target).parent().append(appendRectSvg);
                    $(currentCommand).removeAttr("focus");
                    $(currentCommand).attr("stroke", "none");
                    resetHL()
                    $(".LayerContent").hide();
                    isSelfDrag=false;
                    $(currentCommand).attr("n3", "n3-" + currentQi + "-" + currentQs);
                }
            }
        } else {
            resetRect();
            $(currentCommand).removeAttr("focus");
            evt.target.setAttribute("fill", "#fff");
            evt.target.setAttribute("fill-opacity", "0");
            evt.target.setAttribute("r", "7");
            evt.target.setAttribute("stroke", "none");
            evt.target.setAttribute("focus", "true");
            resetView();
        }
    } else {
        resetRect()
        $("image[focus=true]").removeAttr("focus");
        evt.target.setAttribute("fill", "#fff");
        evt.target.setAttribute("fill-opacity", "0");
        evt.target.setAttribute("r", "7");
        evt.target.setAttribute("stroke", "none");
        evt.target.setAttribute("focus", "true");
        resetView();
        // if ($(".commandList dd.current").length != 0) {
        //     $(".commandList dd.current").click();
        // } else if ($(".dmhj dd.current").length != 0) {
        //     $(".dmhj dd.current").click();
        // }
    }
    layerContent()

    //高亮重置(特殊)
    $("rect[width=14][index='0']").each(function (t) {
        if(parseInt($(this).attr("x")-22)!=parseInt($("rect[focus=true][index='1']").attr("refcx"))) {
            $(this).attr({
                "fill":"#fff",
                // "style":"" + "x:"+(parseInt(bt.attr('x'))+22)+'px'+";" + "y:"+(parseInt(bt.attr('y'))+12)+'px'+";" ,
                "x":parseInt($(this).attr('x'))-22,
                "y":parseInt($(this).attr('y'))-12,
                "width":"60",
                "height":"40",
                "rx":"0",
                "ry":"0",
                "stroke":"none",
                "stroke-width":"none",
                "fill-opacity":"0"
            })
        }
    })

}

//双击击圆点操作
function dblclickCircle() {
    if(!checkGrammar()){return false;}
    evt.target.setAttribute("fill", "#fff");
    evt.target.setAttribute("fill-opacity", "0");
    evt.target.removeAttribute("focus");
    evt.target.setAttribute("r", "3");
    evt.target.setAttribute("stroke", "none");
    resetView();
    return false;
}

function canRun() {
    if ($("#svgBoard rect[type='Measure']").length == 0) {
        prompt(messages.must_be_included_measurement);
        return false;
    }
    return checkGrammar("","");
}
function checkGrammar(isSelfDrag,dragFocus) {
    // isDrag=false;
    var currentCommand = $("rect[focus=true][index='1']");
    if(currentCommand.length==0){
        currentCommand = $(dragFocus);
    }
    var objC=dragFocus?dragFocus:currentCommand;
    var commandType =$(objC).attr("type");
    if(commandType != 'CNOT' && commandType != 'iSWAP' &&commandType != 'CR' && commandType!= 'Toffoli'){
        if($(currentCommand).attr("type") == 'CNOT' || $(currentCommand).attr("type") == 'iSWAP' ||$(currentCommand).attr("type") == 'CR' || $(currentCommand).attr("type")== 'Toffoli'){
            if ($(currentCommand).attr("n2") ==undefined&&commandType!=undefined) {
                prompt(messages.select_another_operation_point);
                return false
            }else if($(currentCommand).attr("n3") ==undefined&&commandType!=undefined&&$(currentCommand).attr("type")== 'Toffoli'){
                prompt(messages.select_second_operation_point);
                return false
            }
        }
    }

    if (commandType == 'CNOT' || commandType == 'iSWAP' || commandType == 'CR' || commandType == 'Toffoli') {

        if(!isSelfDrag){
            if ($(currentCommand).attr("stroke")!="#333"&&$(currentCommand).attr("n2") == undefined){
                prompt(messages.select_another_operation_point);
                return false;
            }
            if (commandType == 'Toffoli' && $(currentCommand).attr("n3") == undefined) {
                prompt(messages.select_second_operation_point);
                return false;
            }
        }else{
            //当前拖拽
            if($(currentCommand).attr("n2")==undefined&&$(objC).attr("n2") != undefined&&currentCommand.attr("type")!=undefined){
                if(currentCommand.attr("type") == 'CNOT' || currentCommand.attr("type") == 'iSWAP' || currentCommand.attr("type") == 'CR' || currentCommand.attr("type") == 'Toffoli'){
                    prompt(messages.select_another_operation_point);
                    return false;
                }
            }
            // else if($(currentCommand).attr("type")==undefined&&$(currentCommand).attr("n2")==undefined&&$(objC).attr("n2") != undefined&&commandType != 'Toffoli'){
            //     // prompt(messages.select_another_operation_point);
            //     return true;
            // }else if($(currentCommand).attr("type")!=undefined&&$(currentCommand).attr("n2")==undefined&&$(objC).attr("n2") != undefined&&currentCommand != 'Toffoli'&&currentCommand != 'CNOT'&&currentCommand != 'iSWAP'&&currentCommand != 'CR'){
            //     // prompt(messages.select_another_operation_point);
            //     return true;
            // }
            else if($(currentCommand).attr("n2")==undefined&&$(objC).attr("n2") != undefined&&commandType != 'Toffoli'){
                prompt(messages.select_another_operation_point);
                return false;
            }else if($(objC).attr("qs")!=currentCommand.attr("qs")&&$(objC).attr("n2") == undefined&&commandType != 'Toffoli'){
                prompt(messages.select_another_operation_point);
                return false;
            }else if($(objC).attr("qs")!=currentCommand.attr("qs")&&currentCommand.attr("qs")==undefined&&$(currentCommand).attr("n2") == undefined&&commandType == 'Toffoli'){

                return true;
            }else if($(objC).attr("qs")!=currentCommand.attr("qs")&&$(currentCommand).attr("n2") == undefined&&commandType == 'Toffoli'){
                prompt(messages.select_another_operation_point);
                return false;
            }
            else if($(objC).attr("qs")!=currentCommand.attr("qs")&&$(currentCommand).attr("n3") == undefined&&$(currentCommand).attr("type") == 'Toffoli'){
                prompt(messages.select_second_operation_point);
                return false;
            }
            // else if($(objC).attr("qs")!=currentCommand.attr("qs")&&$(currentCommand).attr("n3") == undefined&&commandType == 'Toffoli'){
            //     prompt(messages.select_second_operation_point);
            //     return false;
            // }
            else if($(objC).attr("qs")==currentCommand.attr("qs")&&$(currentCommand).attr("n2") == undefined){
                deleteIcon($(objC))
                resetView()
                checkCircle();
            }else {
                return true
            }
        }

    } else if (commandType == "RZ" || commandType == "RX" || commandType == "RY" || commandType == "CR") {
        if(isSelfDrag==''&&dragFocus==''){
            return true
        }
        $(currentCommand).attr("expression", $("#property").val());
        var expression = $(currentCommand).attr("expression")== undefined ? '' : $(currentCommand).attr("expression").trim();;

        if (expression == '' || !expressionRegexp(expression)) {
            prompt(messages.expression_is_not_legal);
            return false;
        }
    } else if (commandType == "Measure") {
        if (parseInt(analogType) == 0) {// 模拟类型为：Monte-Carlo
            if(isSelfDrag!=''&&dragFocus!=''){
                $(currentCommand).attr("register", $("#classicName").val());
            }
            // isSelfDrag=true
        } else {
            // 新版本 取消$
        }
    }
    return true;
}

function expressionRegexp(expression){
    var regexp = /^\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*$/;
    return regexp.exec(expression);
    /*if (regexp.exec(expression))
        return true;
    return false;*/
}

function trans2Code() {   //图形转换成量子程序
    if(!checkGrammar("","")){
        return false;
    }
    trans2CodeStatus = 0;
    // var content="%Version 1.0\n";
    // var content = "QINIT "+lineNum;
    var content = "";     //量子程序容器初始化
    var pmeasurePoint = "";
    var pmeasure = "PMEASURE ";
    // QinitStr= "QINIT "+lineNum;
    /*
     * for(var i=0;i<lineNum;i++) { content +='0'; QinitStr += '0'; }
     */
    // content+= "\n";
    /* QinitStr+="'"; */
    // content+= "CREG "+classicNum+"\n";
    for (var qs = 1; qs <= stepNum; qs++) {        //每行的节点数   如节点数50，则为1->50
        for (var qi = 0; qi < lineNum; qi++) {     //行数
            if ($("#" + qi + "-" + qs).length != 0) {    //判断该节点上是否有图标   $("#行号-列号").length
                var command = $("#" + qi + "-" + qs);
                var type = $(command).attr("type");      //获取其类型type
                if (type == "H") {                       // H --> H 行号
                    content += "H " + qi + "\n";
                } else if (type == "NOT") {              // NOT  --> RX 行号,pi
                    content += "RX " + qi + ",\"pi\"\n";
                } else if (type == "ZPi") {              // ZPi  --> 	RZ 行号,pi
                    content += "RZ " + qi + ",\"pi\"\n";
                } else if (type == "XPi2") {             // XPi2  -->  RX 行号,pi/2
                    content += "RX " + qi + ",\"pi/2\"\n";
                } else if (type == "YPi2") {             // YPi2  -->  RY 行号,pi/2
                    content += "RY " + qi + ",\"pi/2\"\n";
                } else if (type == "ZPi2") {             // ZPi2  -->  RZ 行号,pi/2
                    content += "RZ " + qi + ",\"pi/2\"\n";
                } else if (type == "CNOT") {             // CNOT  -->  CNOT 第二个点行号,第一个点行号
                    var n2 = $("#" + $(command).attr("n2")).attr("qi");
                    content += "CNOT " + n2 + "," + qi + "\n";
                } else if (type == "iSWAP") {            // ISWAP -->  ISWAP 第二个点行号,第一个点行号,oper（为pi）
                    var n2 = $("#" + $(command).attr("n2")).attr("qi");
                    // 原版本
                    /*
                     * if($(command).attr("operation") == "iSWAP") { content +=
                     * "ISWAP " +n2+","+qi+"\n"; } else { content += "SQISWAP "
                     * +n2+","+qi+"\n"; }
                     */
                    // 修改版本 添加“pi”
                    var oper = $(command).attr("operation");
                    content += "ISWAP " + n2 + "," + qi + ",\"" + oper + "\"\n";
                } else if (type == "Toffoli") {           // Toffoli  -->  TOFFOLI 第二个点行号,第三个点行号,第一个点行号
                    var n2 = $("#" + $(command).attr("n2")).attr("qi");
                    var n3 = $("#" + $(command).attr("n3")).attr("qi");
                    content += "TOFFOLI " + n2 + "," + n3 + "," + qi + "\n";
                } else if (type == "Measure")// 原版本注释
                {
                    if (parseInt(analogType) == 0) {//模型为 Monte-Carlo, Measure --> MEASURE 行号,（经典寄存器号）
                        var register = $(command).attr("register");
                        content += "MEASURE " + qi + "," + register + "\n";
                    } else if (parseInt(analogType) == 1){//模型为概率模型, Measure --> PMEASURE 寄存器行号1,寄存器行号2...
                        if (pmeasurePoint == "") {
                            pmeasurePoint = qi + "";
                        } else {
                            pmeasurePoint = pmeasurePoint + "," + qi;
                        }
                    }else if(parseInt(analogType) == 2){
                        var register = $(command).attr("register");
                        content += "MEASURE " + qi + "," +'$' +register + "\n";
                    }
                } else if (type == "RZ") {              // RZ -->  RZ 行号,（expression）
                    var expression = $(command).attr("expression");
                    content += "RZ " + qi + ",\"" + expression + "\"\n";
                } else if (type == "RX") {              // RX -->  RX 行号,（expression）
                    var expression = $(command).attr("expression");
                    content += "RX " + qi + ",\"" + expression + "\"\n";
                } else if (type == "RY") {              // RY -->  RY 行号,（expression）
                    var expression = $(command).attr("expression");
                    content += "RY " + qi + ",\"" + expression + "\"\n";
                } else if (type == "CR") {              // CR --> CR 第二个点行号,第一个点行号,（expression）
                    var n2 = $("#" + $(command).attr("n2")).attr("qi");
                    var expression = $(command).attr("expression");
                    content += "CR " + n2 + "," + qi + ",\"" + expression + "\"\n";
                }
            }
        }
    }
    if (pmeasurePoint != "") {           //模型为概率模型时，对content进行组装
        pmeasure = pmeasure + pmeasurePoint + "\n";
        content = content + pmeasure;
    }

    $("#qcodeTextarea").text("");
    if (fromAdmin != undefined && fromAdmin == "1") {
        codeMirror = CodeMirror(document.getElementById("qcodeTextarea"), {
            value : content,
            lineNumbers : true,
            mode : "javascript",
            keyMap : "sublime",
            autoCloseBrackets : true,
            matchBrackets : true,
            showCursorWhenSelecting : true,
            theme : "monokai",
            readOnly : true,
            tabSize : 2
        });
    } else {
        codeMirror = CodeMirror(document.getElementById("qcodeTextarea"), {
            value : content,
            lineNumbers : true,
            mode : "javascript",
            keyMap : "sublime",
            autoCloseBrackets : true,
            matchBrackets : true,
            showCursorWhenSelecting : true,
            theme : "monokai",
            readOnly : false,
            tabSize : 2
        });
    }
    trans2CodeStatus = 1;
    return codeMirror.getValue();
};

function getSvgXml() {
    return document.getElementById("svgBoard").parentNode.innerHTML;
}

// function mouseoverCircle(circle) {
//     if ($(circle).attr("fill") == "#8d5fef") {
//         return false
//     }
//     if ($(circle).attr("r") == 5) {
//         $(circle).attr("fill", "green");
//     }
// }
//
// function mouseoutCircle(circle) {
//     if ($(circle).attr("fill") == "green") {
//         $(circle).attr("fill", "black");
//     }
// }

function svgBoard(ln, sn, cn, register) {
    var lineHigh=62;
    var columnHigh=60;
    lineNum = ln;
    stepNum = sn;
    classicNum = cn;
    classicName = register;
//            $("svg").click(function() {
//                if (checkGrammar()) {
//                    $("#svgBoard rect,circle").attr("stroke", "none");
//                    $("circle[focus=true]").attr("fill", "black");
//                    $("circle[focus=true]").attr("r", "3");
//                    $("circle[focus=true]").attr("stroke", "none");
//                    $("rect[focus=true]").removeAttr("focus");
//                    $("circle[focus=true]").removeAttr("focus");
//                    resetView();
//                }
//            });
    if ($("#svgBoard").length != 0) {
        $("#svgBoard text").remove();
        $("#svgBoard rect[index='0']").each(function() {
            if (parseInt("" + $(this).attr("r")) < 10)
                $(this).attr("r", "5");
        });

        $("#svgBoard").attr("version", "1.1");
       //$("#svgBoard rect[index='0']").attr("onmouseover", "mouseoverCircle(this)");
       //$("#svgBoard rect[index='0']").attr("onmouseout", "mouseoutCircle(this)");

        lineNum = 0;
        $("#svgBoard line").each(function() {
            if ($(this).attr("y1") == $(this).attr("y2")) {
                stepNum = $(this).parent().find("rect").length;
                $(this).attr("x1", "50");
                lineNum++;
            }
        });
        if ($("rect[focus=true][index='1']").length != 0) {
            var commandType = $("rect[focus=true][index='1']").attr("type");
            if (commandType == "RZ" || commandType == "RX" || commandType == "RY" || commandType == "CR") {
                $("#property").val($("rect[focus=true][index='1']").attr("expression"));
                propertyBoard($("rect[focus=true][index='1']").attr("id"));
            }
        }
        $("#svgBoard").attr("width", stepNum * 50 + 150);
        if (lineNum * 50 < 300)
            $("#svgBoard").attr("height", 5 * 50 + 50);
        else
            $("#svgBoard").attr("height", lineNum * 50 + 50);
        return;
    }
    var boxWidth = stepNum * 60+100;// svg宽度
    var boxHeight = lineNum * 62;// svg高度
    if (boxHeight < 300) {
        boxHeight = 300;
    }

    // 生成svg
    var svgElem = document.createElementNS(xmlns, "svg");
    svgElem.setAttributeNS(null, "width", boxWidth);
    svgElem.setAttributeNS(null, "height", boxHeight);
    svgElem.setAttributeNS(null, "version", "1.1");
    svgElem.setAttributeNS(null, "id", "svgBoard");

    var lineStartPoint = 0;// 横线起始位置
    var lineStartHeight = 33;// 横线起始高度
    var txtStartPoint = 10;
    var shift = 5;// 文本位移度数
    for (var i = 0; i < lineNum; i++) {
        // 添加元素
        var lineG = document.createElementNS(xmlns, "g");
        svgElem.appendChild(lineG);
        // 添加文字描述

        // 添加线条
        var line = document.createElementNS(xmlns, "line");
        line.setAttribute("x1", lineStartPoint);
        line.setAttribute("y1", lineStartHeight);
        line.setAttribute("x2", boxWidth);
        line.setAttribute("y2", lineStartHeight);
        line.setAttribute("data-dis", "2");
        line.setAttribute("stroke", "#333");
        line.setAttribute("style", "stroke-width:2");
        lineG.appendChild(line);

        // 添加圆点
        var circleStartPoint = 25;
        for (var j = 1; j <= stepNum; j++) {
            var rect = document.createElementNS(xmlns, "rect");
            rect.setAttribute("qi", i);
            rect.setAttribute("qs", j);
            rect.setAttribute("x", circleStartPoint);
            rect.setAttribute("y", lineStartHeight-20);
            rect.setAttribute("width", "60");
            rect.setAttribute("height", "40");
            rect.setAttribute("index", "0");
            // rect.setAttribute("r", "3");//2018/4/27修改
            rect.setAttribute("stroke", "none");
            // rect.setAttribute("stroke-width", "1");
            rect.setAttribute("fill", "#fff");
            rect.setAttribute("fill-opacity", "0");
            lineG.appendChild(rect);

            circleStartPoint = circleStartPoint + columnHigh;
            // 绑定事件
            rect.setAttribute("onclick", "clickDotCircle(evt)");
           // rect.setAttribute("onmouseover", "mouseoverDotDotCircle(this)");
           // rect.setAttribute("onmouseout", "mouseoutDotCircle(this)");
        }
        lineStartHeight = lineStartHeight + lineHigh;
    }

    // 生成
    var svgContainerBox = document.getElementById("modRight_center");
    svgContainerBox.appendChild(svgElem);
}

//提示框
function prompt(msg, type) {
    var defaultType = "error";
    if (type) {
        defaultType = type;
    }
    noty({
        text : msg,
        type : defaultType,
        dismissQueue : true,
        layout : 'topCenter',
        theme : 'relax',
        timeout : 1500
    });

}
Array.prototype.remove = function(val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};
function judgeSign(num) {
    var reg = new RegExp("^-?[0-9]*.?[0-9]*$");
    if (reg.test(num)) {
        var absVal = Math.abs(num);
        return num == absVal ? 1 : 0;
    }
}

function AttBuit(qb) {
    //页面点击高亮可操作坐标点
    //重置数组
    var circleArray=[];
    var circleArray2=[];
    // resetHL()
    //获取Measure测量的坐标

    //获取当前点x轴做标
    // var cxs=$("rect[focus=true][index='0']").attr("x").toString();
    var cxQi=0;
    var cxQs=0;
    if(qb==1){
        try {
            cxs=  $("rect[focus=true][index='1']").attr("refcx").toString();
            cxQi= $("rect[focus=true][index='1']").attr("qi").toString();
            cxQs= $("rect[focus=true][index='1']").attr("qs").toString();
        }catch (e) {
            return false
        }

    }else {
        cxs=$("rect[focus=true][index='0']").attr("x").toString();
        cxQi= $("rect[focus=true][index='0']").attr("qi").toString();
        cxQs= $("rect[focus=true][index='0']").attr("qs").toString();
    }

    //QS不变，QI变
    //测量需要判断qs的大小
    $("#svgBoard rect[type='Measure'][index='1']").each(function(){
        if(parseInt($(this).attr("qs"))<=parseInt(cxQs)){
            circleArray2.push($(this).attr("qi"));
        }
    });
    $("rect[id][qs='"+cxQs+"']").each(function (value) {
        var rectQi=$(this).attr("id").split("-");
        if($(this).attr("focus")==undefined||$(this).attr("focus")=="false"){
            if(rectQi.length==2){
                if($(this).parent().css("display")!="none"&&$(this).css("display")!="none"){
                    circleArray.push(rectQi[0]);
                }
            }else if($(this).attr("id").split("-").length==3){
                //if(!isSelfDrag&&!isDrag){
                if($(this).parent().css("display")!="none"&&$(this).css("display")!="none"){
                    circleArray.push(rectQi[1]);
                }
                //}

            }
        }

    })
// 添加qi
    var ArrClick=[];
    var LsArray=[];
    for(var i=0;i<lineTS;i++){
        if(i!=cxQi) {
            LsArray.push(i);
            ArrClick.push(i);
        }
    }
    //测量右侧坐标移除，不高亮
    for(var c=0;c<circleArray2.length;c++){
        ArrClick.remove(parseInt(circleArray2[c]));
    }
    var  maxNum=0;minNum=0;
    for(var y=0;y<circleArray.length;y++){
        if(parseInt(circleArray[y])>parseInt(cxQi)){
           // 去最小值
            if(minNum==0){
                minNum=Number(circleArray[y]);
            }
            if(circleArray[y]<minNum){
                minNum=Number(circleArray[y]);
            }
        }else {
            //取最大值
            if(circleArray[y]>=maxNum){
                maxNum=Number(circleArray[y])
            }
        }
    }

    for(var h=0;h<LsArray.length;h++){
        if(maxNum==''&&minNum!=''){
            if(LsArray[h]>=minNum){
                ArrClick.remove(parseInt(LsArray[h]))
            }
        }else if(maxNum!=''&&minNum==''){
            if(LsArray[h]<=maxNum){
                ArrClick.remove(parseInt(LsArray[h]))
            }
        }else if(maxNum!=''&&minNum!=''){

            if(LsArray[h]<=maxNum||LsArray[h]>=minNum){
                ArrClick.remove(parseInt(LsArray[h]));
            }
        }
    }
    $(ArrClick).each(function (i) {
        var bt=$("rect[qs=" + cxQs + "][qi=" + ArrClick[i] + "][index='0']");
        if(!($(bt).attr("width")=="14")){
            $("rect[qs=" + cxQs + "][qi=" + ArrClick[i] + "][index='0']").attr({
                "fill":"#fff",
                // "style":"" + "x:"+(parseInt(bt.attr('x'))+22)+'px'+";" + "y:"+(parseInt(bt.attr('y'))+12)+'px'+";" ,
                "x":parseInt(bt.attr('x'))+22,
                "y":parseInt(bt.attr('y'))+12,
                "width":"14",
                "height":"14",
                "rx":"9",
                "ry":"9",
                "stroke":"#B3DE7B",
                "stroke-width":"3",
                "fill-opacity":"1"
            })
        }

        //$("rect[qs=" + cxQs + "][qi=" + ArrClick[i] + "][index='0']").attr("style","" + "x:"+(parseInt(bt.attr('x'))+22)+'px'+";" + "y:"+(parseInt(bt.attr('y'))+12)+'px'+";" );
    })
}

//点击圆点上的图标
function propertyBoard(id,typeNumber) {
    if(typeNumber){
        return false;
    }
    var Board=null;
    var type = $("#" + id).attr("type");
    if(type=="iSWAP"||type=="Measure"||type=="RZ"||type=="RX"||type=="RY"||type=="CR"){
        isDrag=false;
        $(".LayerContent").hide();
        // Board=setTimeout(function () {
        $(".LayerSetting").css({"top":$("#" + id).offset().top+50,left:$("#" + id).offset().left-$(".LayerSetting").width()/2})
        // },200);
    }

    // 重置样式
    $(".LayerSetting").hide()
    //property
    $(".LaySetLine1").hide();
    //iswap
    $(".LaySetLine3").hide();
    $("#commandTip").hide();
    //classicName
    $(".LaySetLine2").hide();
    //操作按钮
    $(".LayConfirm").hide();

    if (type == "H") {
        //$(".case-bottom-right").hide()
    } else if (type == "NOT") {
        //$(".case-bottom-right").hide()
    } else if (type == "ZPi") {
        // $(".case-bottom-right").hide()
    } else if (type == "XPi2") {
        // $(".case-bottom-right").hide()
    } else if (type == "YPi2") {
        //$(".case-bottom-right").hide()
    } else if (type == "ZPi2") {
        //$(".case-bottom-right").hide()
    } else if (type == "CNOT") {
        // $(".case-bottom-right").hide()
    } else if (type == "iSWAP") {
        $(".LaySetLine3").show();
        // $("#commandTip").text(messages.commandtip_0);
        $("#commandTip").text(messages.commandtip_2);
        if(analogType==2){
            if($("#" + id).attr("operation")=="pi/4"||$("#" + id).attr("operation")=="pi/2"||$("#" + id).attr("operation")=="3*pi/4"){
                $("#property").find("option:contains("+$("#" + id).attr("operation")+")").attr("selected",true);
            }else {
                $("#property").find("option:contains("+$("#" + id).attr("pi/4")+")").attr("selected",true);
            }
        }else {
            $("#property").val($("#" + id).attr("operation"));
        }

        $("#commandTip").show();
        // $("#iswap").val($("#"+id).attr("operation")).trigger("change");
        $(".LaySetLine1").show();
        $(".LayConfirm").show();
        $(".LayerSetting").show()
    } else if (type == "Toffoli") {

    } else if (type == "Measure") {
        if (parseInt(analogType) == 0) {
            $("#commandTip").text(messages.commandtip_1);
            $("#classicName").val($("#" + id).attr("register")).trigger("change");
            $("#commandTip").show();
            $(".LaySetLine2").show();
            $(".LayConfirm").show();
            $(".LayerSetting").show()
        } else {
            // 概率方法类型 不显示选择项
        }
    } else if (type == "RZ") {

        $("#commandTip").text(messages.commandtip_2);
        $("#property").val($("#" + id).attr("expression"));
        $("#commandTip").show();
        $(".LaySetLine1").show();
        $(".LayConfirm").show();
        $(".LayerSetting").show()
    } else if (type == "RX") {

        $("#commandTip").text(messages.commandtip_2);
        $("#property").val($("#" + id).attr("expression"));
        $("#commandTip").show();
        $(".LaySetLine1").show();
        $(".LayConfirm").show();
        $(".LayerSetting").show()
    } else if (type == "RY") {

        $("#commandTip").text(messages.commandtip_2);
        $("#property").val($("#" + id).attr("expression"));
        $("#commandTip").show();
        $(".LaySetLine1").show();
        $(".LayConfirm").show();
        $(".LayerSetting").show()

    } else if (type == "CR") {
        $("#commandTip").text(messages.commandtip_2);
        $("#property").val($("#" + id).attr("expression"));
        $("#commandTip").show();
        $(".LaySetLine1").show();
        $(".LayConfirm").show();
        $(".LayerSetting").show()
    }
}

/**
 * 组装字符串
 *
 * @param resultStr
 * @param str
 *            目标字符串
 */
function buildIdentification(resultStr, str) {
    if (str != undefined && str != "")// 组装格式
        str = "<" + str + ">";
    if (resultStr == undefined || resultStr == "") {
        resultStr = str;
    } else {
        resultStr = resultStr + ";" + str;
    }
    return resultStr;
}

/**
 * 判断某个字符串是否已存在
 * @param resultStr
 * @param str 目标字符串
 */
function getIdentification(resultStr, str) {
    if (str != undefined && str != "")// 组装格式
        str = "<" + str + ">";
    var resultStrs = resultStr.split(";");
    var count = 0;
    for (var i = 0; i < resultStrs.length; i++) {
        if (resultStrs[i] == str) {
            count = count + 1;
        }
    }
    if (count > 1) {
        return true;
    } else {
        return false;
    }
}

//---------------------------------------------------------------------------//
//------------------------ create code collection ---------------------------//
//---------------------------------------------------------------------------//
function codeCollection() {
    $(".Layer_Con .Layer_sort_con").eq(2).find("li").click(function(event) {
        var $obj = $(this);
        var id = $obj.attr("id");
        // if ($(".dmhj dd.current").attr("id") != id) {
        if ($(this).attr("id") != id) {
            $(".dmhj dd.current").removeClass("current");
            $(".commandList dd.current").removeClass("current");
            $obj.addClass("current");
        } else {
            $obj.removeClass("current");
        }
        if ($("rect[focus=true][index='1']").length > 0) {
            if (!checkGrammar()) {
                return false;
            }

            $(this).addClass("current");
            $("#svgBoard rect[index='1']").attr("stroke", "none");
            $("#svgBoard rect[index='0']").attr("stroke", "none");
            $("rect[focus=true][index='1']").removeAttr("focus");
            return false;

        } else if ($("rect[focus=true][index='0']").length > 0) {
            $obj.removeClass("current");
            var qi = $("rect[focus=true][index='0']").attr("qi");
            var qs = $("rect[focus=true][index='0']").attr("qs");
            xNum = $obj.attr("xNum");
            yNum = $obj.attr("yNum");
            if (!isVoid(qi, qs, xNum, yNum)) {
                return false;
            }
            $("rect[focus=true][index='0']").attr("fill", "#fff");
            $("rect[focus=true][index='0']").attr("fill-opacity", "0");
            $("rect[focus=true][index='0']").attr("r", "3");
            $("rect[focus=true][index='0']").attr("stroke", "none");
            $("rect[focus=true][index='0']").removeAttr("focus");
            if (id == "GHZ2") {
                createGHZ2(qi, qs);
            } else if (id == "GHZ3") {
                createGHZ3(qi, qs);
            } else if (id == "GHZ6") {
                createGHZ6(qi, qs);
            } else if (id == "QFT3") {
                createQFT3(qi, qs);
            } else if (id == "QFT4") {
                createQFT4(qi, qs);
            } else if (id == "CZ") {
                createCZ(qi, qs);
            } else if (id == "z-CNOT") {
                createz_CNOT(qi, qs);
            } else if (id == "SWAP") {
                createSWAP(qi, qs);
            } else if (id == "H6") {
                createH6(qi, qs);
            }
        }
    });
}


function createGHZ2(circleQi, circleQs) {
    var targetH = $("rect[qi=" + circleQi + "][qs=" + circleQs + "][index='0']");
    var rectG0 = $("#svg_H g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetH.attr("x")) +5) + "," + (targetH.attr("y") - 5) + ")");

    rectG0.find("rect").attr("qi", circleQi);
    rectG0.find("rect").attr("qs", circleQs);
    rectG0.find("rect").attr('refcx', targetH.attr("x"));
    rectG0.find("rect").attr('refcy', targetH.attr("y"));
    rectG0.find("rect").attr('id', circleQi + "-" + circleQs);
    rectG0.find("rect").attr('type', "H");
    rectG0.find("rect").attr("onclick", "clickImage(evt)");

    targetH.parent().append(rectG0);
    dragObj(circleQi + "-" + circleQs);

    var targetCONT = $("rect[qi=" + (+circleQi + 1 ) + "][qs=" + (+circleQs + 1) + "][index='0']");
    var targetN2 = $("rect[qi=" + circleQi + "][qs=" + (+circleQs + 1) + "][index='0']");

    var rectG1 = $("#svg_CNOT g").clone();
    rectG1.attr('transform', "translate(" + (parseInt(targetCONT.attr("x")) +5) + "," + (targetCONT.attr("y") - 5) + ")");

    rectG1.find("rect").attr("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    rectG1.find("rect").attr("qi", (+circleQi + 1));
    rectG1.find("rect").attr("qs", (+circleQs + 1));
    rectG1.find("rect").attr('refcx', targetN2.attr("x"));
    rectG1.find("rect").attr('refcy', targetN2.attr("y"));
    rectG1.find("rect").attr('id', (+circleQi + 1) + "-" + (+circleQs + 1));
    rectG1.find("rect").attr('type', "CNOT");
    rectG1.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT).parent().append(rectG1);

    var line = document.createElementNS(xmlns, "line");
    line.setAttribute("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line.setAttribute("fill", "#B3DE7B");
    line.setAttribute("x1", parseInt(targetCONT.attr("x"))+30);
    line.setAttribute("y1", parseInt(targetCONT.attr("y")));
    line.setAttribute("x2", parseInt($(rectG1).find("rect").attr("refcx"))+30);
    line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 15);
    targetCONT.parent().append(line);

    appendRectSvg=appendRect(
        "n2-" + circleQi + "-" + (+circleQs + 1),
        parseInt(targetN2.attr("x")) + 21,
        parseInt(targetN2.attr("y")) + 10,
        circleQi,
        circleQs,
        '',
        ''
    )

    targetN2.parent().append(appendRectSvg);

    dragObj((+circleQi + 1) + "-" + (+circleQs + 1));
}

function createGHZ3(circleQi, circleQs) {
    var targetH = $("rect[qi=" + circleQi + "][qs=" + circleQs + "][index='0']");
    var rectG0 = $("#svg_H g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetH.attr("x")) +5) + "," + (targetH.attr("y") - 5) + ")");

    $(rectG0).find("rect").attr("qi", circleQi);
    $(rectG0).find("rect").attr("qs", circleQs);
    $(rectG0).find("rect").attr('refcx', targetH.attr("x"));
    $(rectG0).find("rect").attr('refcy', targetH.attr("y"));
    $(rectG0).find("rect").attr('id', circleQi + "-" + circleQs);
    $(rectG0).find("rect").attr('type', "H");
    $(rectG0).find("rect").attr("onclick", "clickImage(evt)");

    targetH.parent().append(rectG0);
    dragObj(circleQi + "-" + circleQs);

    for (var i = 1; i < 3; i++) {
        var targetCONT = $("rect[qi=" + (+circleQi + i) + "][qs=" + (+circleQs + i) + "][index='0']");
        var targetN2 = $("rect[qi=" + (+circleQi + i - 1) + "][qs=" + (+circleQs + i) + "][index='0']");

        var rectG1 = $("#svg_CNOT g").clone();
        rectG1.attr('transform', "translate(" + (parseInt(targetCONT.attr("x")) + 5) + "," + (parseInt(targetCONT.attr("y")) - 5) + ")");

        $(rectG1).find("rect").attr("n2", "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + 1));
        $(rectG1).find("rect").attr("qi", (+circleQi + i));
        $(rectG1).find("rect").attr("qs", (+circleQs + i));
        $(rectG1).find("rect").attr('refcx', targetN2.attr("x"));
        $(rectG1).find("rect").attr('refcy', targetN2.attr("y"));
        $(rectG1).find("rect").attr('id', (+circleQi + i) + "-" + (+circleQs + i));
        $(rectG1).find("rect").attr('type', "CNOT");
        $(rectG1).find("rect").attr("onclick", "clickImage(evt)");
        $(targetCONT).parent().append(rectG1);

        var line = document.createElementNS(xmlns, "line");
        line.setAttribute("n2", "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + 1));
        line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
        line.setAttribute("fill", "#B3DE7B");
        // line.setAttribute("x1", targetCONT.attr("cx"));
        // line.setAttribute("y1", targetCONT.attr("cy") - 15);
        // line.setAttribute("x2", $(rectG1).find("rect").attr("refcx"));
        // line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 5);

        line.setAttribute("x1", parseInt(targetCONT.attr("x"))+30);
        line.setAttribute("y1", parseInt(targetCONT.attr("y")));
        line.setAttribute("x2", parseInt($(rectG1).find("rect").attr("refcx"))+30);
        line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 15);
        targetCONT.parent().append(line);


        appendRectSvg=appendRect(
            "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + 1),
            parseInt(targetN2.attr("x")) + 21,
            parseInt(targetN2.attr("y")) + 10,
            circleQi,
            circleQs,
            '',
            ''
        )

        targetN2.parent().append(appendRectSvg);

        dragObj((+circleQi + i) + "-" + (+circleQs + i));
    }
}

function createGHZ6(circleQi, circleQs) {
    var targetH = $("rect[qi=" + circleQi + "][qs=" + circleQs + "][index='0']");
    var rectG0 = $("#svg_H g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

    $(rectG0).find("rect").attr("qi", circleQi);
    $(rectG0).find("rect").attr("qs", circleQs);
    $(rectG0).find("rect").attr('refcx', targetH.attr("x"));
    $(rectG0).find("rect").attr('refcy', targetH.attr("y"));
    $(rectG0).find("rect").attr('id', circleQi + "-" + circleQs);
    $(rectG0).find("rect").attr('type', "H");
    $(rectG0).find("rect").attr("onclick", "clickImage(evt)");

    targetH.parent().append(rectG0);
    dragObj(circleQi + "-" + circleQs);

    for (var i = 1; i < 6; i++) {
        var targetCONT = $("rect[qi=" + (+circleQi + i) + "][index='0'][qs=" + (+circleQs + i) + "]");
        var targetN2 = $("rect[qi=" + (+circleQi + i - 1) + "][index='0'][qs=" + (+circleQs + i) + "]");

        var rectG1 = $("#svg_CNOT g").clone();
        rectG1.attr('transform', "translate(" + (parseInt(targetCONT.attr("x")) + 5) + "," + (targetCONT.attr("y") - 5) + ")");

        $(rectG1).find("rect").attr("n2", "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + i));
        $(rectG1).find("rect").attr("qi", (+circleQi + i));
        $(rectG1).find("rect").attr("qs", (+circleQs + i));
        $(rectG1).find("rect").attr('refcx', targetN2.attr("x"));
        $(rectG1).find("rect").attr('refcy', targetN2.attr("y"));
        $(rectG1).find("rect").attr('id', (+circleQi + i) + "-" + (+circleQs + i));
        $(rectG1).find("rect").attr('type', "CNOT");
        $(rectG1).find("rect").attr("onclick", "clickImage(evt)");
        $(targetCONT).parent().append(rectG1);

        var line = document.createElementNS(xmlns, "line");
        line.setAttribute("n2", "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + i));
        line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
        line.setAttribute("fill", "#B3DE7B");
        // line.setAttribute("x1", targetCONT.attr("cx"));
        // line.setAttribute("y1", targetCONT.attr("cy") - 15);
        // line.setAttribute("x2", $(rectG1).find("rect").attr("refcx"));
        // line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 5);
        line.setAttribute("x1", parseInt(targetCONT.attr("x"))+30);
        line.setAttribute("y1", parseInt(targetCONT.attr("y")));
        line.setAttribute("x2", parseInt($(rectG1).find("rect").attr("refcx"))+30);
        line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 15);
        targetCONT.parent().append(line);

        appendRectSvg=appendRect(
            "n2-" + (+circleQi + i - 1) + "-" + (+circleQs + i),
            parseInt(targetN2.attr("x")) + 21,
            parseInt(targetN2.attr("y")) + 10,
            circleQi,
            circleQs,
            '',
            ''
        )
        targetN2.parent().append(appendRectSvg);
        dragObj((+circleQi + i) + "-" + (+circleQs + i));
    }

}

function createQFT3(circleQi, circleQs) {
    var qi = 0;
    var qs = 0;
    var expression = "pi/";
    for (var i = 3; i > 0; i--) {
        var targetH = $("rect[qi=" + (+circleQi + qi) + "][qs=" + (+circleQs + qs) + "][index='0']");
        var rectG = $("#svg_H g").clone();
        rectG.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

        rectG.find("rect").attr("qi", (+circleQi + qi));
        rectG.find("rect").attr("qs", (+circleQs + qs));
        rectG.find("rect").attr('refcx', targetH.attr("x"));
        rectG.find("rect").attr('refcy', targetH.attr("y"));
        rectG.find("rect").attr('id', (+circleQi + qi) + "-" + (+circleQs + qs));
        rectG.find("rect").attr('type', "H");
        rectG.find("rect").attr("onclick", "clickImage(evt)");

        targetH.parent().append(rectG);
        dragObj((+circleQi + qi) + "-" + (+circleQs + qs));
        qs++;
        var j = 0;
        for (j; j < (i - 1); j++) {

            var targetCR = $("rect[qi=" + (+circleQi + qi) + "][index='0'][qs=" + (+circleQs + qs) + "]");
            var targetN2 = $("rect[qi=" + (+circleQi + qi + j + 1) + "][index='0'][qs=" + (+circleQs + qs) + "]");

            var rectG = $("#svg_CR g").clone();
            rectG.attr('transform', "translate(" + (parseInt(targetCR.attr("x")) + 5) + "," + (targetCR.attr("y") - 5) + ")");

            rectG.find("rect").attr("n2", "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs));
            rectG.find("rect").attr("qi", (+circleQi + qi));
            rectG.find("rect").attr("qs", (+circleQs + qs));
            rectG.find("rect").attr('refcx', targetN2.attr("x"));
            rectG.find("rect").attr('refcy', targetN2.attr("y"));
            rectG.find("rect").attr('id', (+circleQi + qi) + "-" + (+circleQs + qs));
            rectG.find("rect").attr('type', "CR");
            rectG.find("rect").attr("onclick", "clickImage(evt)");
            rectG.find("rect").attr('expression', expression + (2 << j));
            targetCR.parent().append(rectG);

            var line = document.createElementNS(xmlns, "line");
            line.setAttribute("n2", "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs));
            line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
            line.setAttribute("fill", "#B3DE7B");
            // line.setAttribute("x1", rectG.find("rect").attr("refcx"));
            // line.setAttribute("y1", (+rectG.find("rect").attr("refcy")) - 5);
            // line.setAttribute("x2", targetCR.attr("cx"));
            // line.setAttribute("y2", (+targetCR.attr("cy")) + 15);
            line.setAttribute("x1", parseInt(rectG.find("rect").attr("refcx"))+30);
            line.setAttribute("y1", parseInt(rectG.find("rect").attr("refcy"))+15);
            line.setAttribute("x2", parseInt(targetCR.attr("x"))+30);
            line.setAttribute("y2", (+targetCR.attr("y")) + 30);
            targetN2.parent().append(line);


            appendRectSvg=appendRect(
                "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs),
                parseInt(targetN2.attr("x")) + 21,
                parseInt(targetN2.attr("y")) + 10,
                (+circleQi + qi + j + 1),
                (+circleQs + qs),
                '',
                ''
            )
            targetN2.parent().append(appendRectSvg);
            dragObj((+circleQi + qi) + "-" + (+circleQs + qs));
            qs++;
        }
        qi++;
    }
}

function createQFT4(circleQi, circleQs) {
    var qi = 0;
    var qs = 0;
    var expression = "pi/";
    for (var i = 4; i > 0; i--) {
        var targetH = $("rect[qi=" + (+circleQi + qi) + "][qs=" + (+circleQs + qs) + "][index='0']");
        var rectG = $("#svg_H g").clone();
        rectG.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

        rectG.find("rect").attr("qi", (+circleQi + qi));
        rectG.find("rect").attr("qs", (+circleQs + qs));
        rectG.find("rect").attr('refcx', targetH.attr("x"));
        rectG.find("rect").attr('refcy', targetH.attr("y"));
        rectG.find("rect").attr('id', (+circleQi + qi) + "-" + (+circleQs + qs));
        rectG.find("rect").attr('type', "H");
        rectG.find("rect").attr("onclick", "clickImage(evt)");

        targetH.parent().append(rectG);
        dragObj((+circleQi + qi) + "-" + (+circleQs + qs));
        qs++;
        var j = 0;
        for (j; j < (i - 1); j++) {

            var targetCR = $("rect[qi=" + (+circleQi + qi) + "][index='0'][qs=" + (+circleQs + qs) + "]");
            var targetN2 = $("rect[qi=" + (+circleQi + qi + j + 1) + "][index='0'][qs=" + (+circleQs + qs) + "]");

            var rectG = $("#svg_CR g").clone();
            rectG.attr('transform', "translate(" + (parseInt(targetCR.attr("x")) + 5) + "," + (targetCR.attr("y") - 5) + ")");

            rectG.find("rect").attr("n2", "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs));
            rectG.find("rect").attr("qi", (+circleQi + qi));
            rectG.find("rect").attr("qs", (+circleQs + qs));
            rectG.find("rect").attr('refcx', targetN2.attr("x"));
            rectG.find("rect").attr('refcy', targetN2.attr("y"));
            rectG.find("rect").attr('id', (+circleQi + qi) + "-" + (+circleQs + qs));
            rectG.find("rect").attr('type', "CR");
            rectG.find("rect").attr("onclick", "clickImage(evt)");
            rectG.find("rect").attr('expression', expression + (2 << j));
            targetCR.parent().append(rectG);

            var line = document.createElementNS(xmlns, "line");
            line.setAttribute("n2", "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs));
            line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
            line.setAttribute("fill", "#B3DE7B");
            line.setAttribute("x1", parseInt(rectG.find("rect").attr("refcx"))+30);
            line.setAttribute("y1", parseInt(rectG.find("rect").attr("refcy"))+15);
            line.setAttribute("x2", parseInt(targetCR.attr("x"))+30);
            line.setAttribute("y2", (+targetCR.attr("y")) + 30);
            targetN2.parent().append(line);


            appendRectSvg=appendRect(
                "n2-" + (+circleQi + qi + j + 1) + "-" + (+circleQs + qs),
                parseInt(targetN2.attr("x")) + 21,
                parseInt(targetN2.attr("y")) + 10,
                (+circleQi + qi + j + 1),
                (+circleQs + qs),
                '',
                ''
            )

            targetN2.parent().append(appendRectSvg);

            dragObj((+circleQi + qi) + "-" + (+circleQs + qs));
            qs++;
        }
        qi++;
    }
}

function createCZ(circleQi, circleQs) {
    var targetH = $("rect[qi=" + (+circleQi + 1) + "][qs=" + circleQs + "][index='0']");
    var rectG0 = $("#svg_H g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

    rectG0.find("rect").attr("qi", (+circleQi + 1));
    rectG0.find("rect").attr("qs", circleQs);
    rectG0.find("rect").attr('refcx', targetH.attr("x"));
    rectG0.find("rect").attr('refcy', targetH.attr("y"));
    rectG0.find("rect").attr('id', (+circleQi + 1) + "-" + circleQs);
    rectG0.find("rect").attr('type', "H");
    rectG0.find("rect").attr("onclick", "clickImage(evt)");

    targetH.parent().append(rectG0);
    dragObj((+circleQi + 1) + "-" + circleQs);

    var targetCONT = $("rect[qi=" + (+circleQi + 1 ) + "][index='0'][qs=" + (+circleQs + 1) + "]");
    var targetN2 = $("rect[qi=" + circleQi + "][index='0'][qs=" + (+circleQs + 1) + "]");

    var rectG1 = $("#svg_CNOT g").clone();
    rectG1.attr('transform', "translate(" + (parseInt(targetCONT.attr("x")) + 5) + "," + (targetCONT.attr("y") - 5) + ")");

    rectG1.find("rect").attr("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    rectG1.find("rect").attr("qi", (+circleQi + 1));
    rectG1.find("rect").attr("qs", (+circleQs + 1));
    rectG1.find("rect").attr('refcx', targetN2.attr("x"));
    rectG1.find("rect").attr('refcy', targetN2.attr("y"));
    rectG1.find("rect").attr('id', (+circleQi + 1) + "-" + (+circleQs + 1));
    rectG1.find("rect").attr('type', "CNOT");
    rectG1.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT).parent().append(rectG1);

    var line = document.createElementNS(xmlns, "line");
    line.setAttribute("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line.setAttribute("fill", "#B3DE7B");
    line.setAttribute("x1", parseInt(targetCONT.attr("x"))+30);
    line.setAttribute("y1", parseInt(targetCONT.attr("y")));
    line.setAttribute("x2", parseInt($(rectG1).find("rect").attr("refcx"))+30);
    line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 15);
    targetCONT.parent().append(line);

    appendRectSvg=appendRect(
        "n2-" + circleQi + "-" + (+circleQs + 1),
        parseInt(targetN2.attr("x")) + 21,
        parseInt(targetN2.attr("y")) + 10,
        circleQi,
        (+circleQs + 1),
        '',
        ''
    )
    targetN2.parent().append(appendRectSvg);
    dragObj((+circleQi + 1) + "-" + (+circleQs + 1));

    var targetH1 = $("rect[qi=" + (+circleQi + 1) + "][index='0'][qs=" + (+circleQs + 2) + "]");
    var rectG2 = $("#svg_H g").clone();
    rectG2.attr('transform', "translate(" + (parseInt(targetH1.attr("x")) + 5) + "," + (targetH1.attr("y") - 5) + ")");

    rectG2.find("rect").attr("qi", (+circleQi + 1));
    rectG2.find("rect").attr("qs", (+circleQs + 2));
    rectG2.find("rect").attr('refcx', targetH1.attr("x"));
    rectG2.find("rect").attr('refcy', targetH1.attr("y"));
    rectG2.find("rect").attr('id', (+circleQi + 1) + "-" + (+circleQs + 2));
    rectG2.find("rect").attr('type', "H");
    rectG2.find("rect").attr("onclick", "clickImage(evt)");

    targetH1.parent().append(rectG2);
    dragObj((+circleQi + 1) + "-" + (+circleQs + 2));
}

function createz_CNOT(circleQi, circleQs) {
    var targetH = $("rect[qi=" + circleQi + "][qs=" + circleQs + "][index='0']");
    var rectG0 = $("#svg_NOT g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

    rectG0.find("rect").attr("qi", circleQi);
    rectG0.find("rect").attr("qs", circleQs);
    rectG0.find("rect").attr('refcx', targetH.attr("x"));
    rectG0.find("rect").attr('refcy', targetH.attr("y"));
    rectG0.find("rect").attr('id', circleQi + "-" + circleQs);
    rectG0.find("rect").attr('type', "NOT");
    rectG0.find("rect").attr("onclick", "clickImage(evt)");

    targetH.parent().append(rectG0);
    dragObj((+circleQi + 1) + "-" + circleQs);

    var targetCONT = $("rect[qi=" + (+circleQi + 1 ) + "][index='0'][qs=" + (+circleQs + 1) + "]");
    var targetN2 = $("rect[qi=" + circleQi + "][index='0'][qs=" + (+circleQs + 1) + "]");

    var rectG1 = $("#svg_CNOT g").clone();
    rectG1.attr('transform', "translate(" + (parseInt(targetCONT.attr("x")) + 5) + "," + (targetCONT.attr("y") - 5) + ")");

    rectG1.find("rect").attr("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    rectG1.find("rect").attr("qi", (+circleQi + 1));
    rectG1.find("rect").attr("qs", (+circleQs + 1));
    rectG1.find("rect").attr('refcx', targetN2.attr("x"));
    rectG1.find("rect").attr('refcy', targetN2.attr("y"));
    rectG1.find("rect").attr('id', (+circleQi + 1) + "-" + (+circleQs + 1));
    rectG1.find("rect").attr('type', "CNOT");
    rectG1.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT).parent().append(rectG1);

    var line = document.createElementNS(xmlns, "line");
    line.setAttribute("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    line.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line.setAttribute("fill", "#B3DE7B");
    line.setAttribute("x1", parseInt(targetCONT.attr("x"))+30);
    line.setAttribute("y1", parseInt(targetCONT.attr("y")));
    line.setAttribute("x2", parseInt($(rectG1).find("rect").attr("refcx"))+30);
    line.setAttribute("y2", (+$(rectG1).find("rect").attr("refcy")) + 15);
    targetCONT.parent().append(line);

    appendRectSvg=appendRect(
        "n2-" + circleQi + "-" + (+circleQs + 1),
        parseInt(targetN2.attr("x")) + 21,
        parseInt(targetN2.attr("y")) + 10,
        circleQi,
        (+circleQs + 1),
        '',
        ''
    )

    targetN2.parent().append(appendRectSvg);
    dragObj((+circleQi + 1) + "-" + (+circleQs + 1));

    var targetH1 = $("rect[qi=" + circleQi + "][index='0'][qs=" + (+circleQs + 2) + "]");
    var rectG2 = $("#svg_NOT g").clone();
    rectG2.attr('transform', "translate(" + (parseInt(targetH1.attr("x")) + 5) + "," + (targetH1.attr("y") - 5) + ")");

    rectG2.find("rect").attr("qi", circleQi);
    rectG2.find("rect").attr("qs", (+circleQs + 2));
    rectG2.find("rect").attr('refcx', targetH1.attr("x"));
    rectG2.find("rect").attr('refcy', targetH1.attr("y"));
    rectG2.find("rect").attr('id', circleQi + "-" + (+circleQs + 2));
    rectG2.find("rect").attr('type', "NOT");
    rectG2.find("rect").attr("onclick", "clickImage(evt)");

    targetH1.parent().append(rectG2);
    dragObj(circleQi + "-" + (+circleQs + 2));
}

function createSWAP(circleQi, circleQs) {
    var targetCONT0 = $("rect[qi=" + circleQi + "][qs=" + circleQs + "][index='0']");
    var targetN20 = $("rect[qi=" + (+circleQi + 1) + "][qs=" + circleQs + "][index='0']");

    var rectG0 = $("#svg_CNOT g").clone();
    rectG0.attr('transform', "translate(" + (parseInt(targetCONT0.attr("x")) + 5) + "," + (targetCONT0.attr("y") - 5) + ")");

    rectG0.find("rect").attr("n2", "n2-" + (+circleQi + 1) + "-" + circleQs);
    rectG0.find("rect").attr("qi", circleQi);
    rectG0.find("rect").attr("qs", circleQs);
    rectG0.find("rect").attr('refcx', targetN20.attr("x"));
    rectG0.find("rect").attr('refcy', targetN20.attr("y"));
    rectG0.find("rect").attr('id', circleQi + "-" + circleQs);
    rectG0.find("rect").attr('type', "CNOT");
    rectG0.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT0).parent().append(rectG0);


    var line0 = document.createElementNS(xmlns, "line");
    line0.setAttribute("n2", "n2-" + (+circleQi + 1) + "-" + circleQs);
    line0.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line0.setAttribute("fill", "#B3DE7B");
    line0.setAttribute("x1", parseInt(rectG0.find("rect").attr("refcx"))+30);
    line0.setAttribute("y1", (+parseInt(rectG0.find("rect").attr("refcy")))+15);
    line0.setAttribute("x2", parseInt(targetCONT0.attr("x"))+30);
    line0.setAttribute("y2", (+parseInt(targetCONT0.attr("y"))) + 35);
    targetN20.parent().append(line0);

    var circle0 = document.createElementNS(xmlns, "rect");

    circle0.setAttribute("id", "n2-" + (+circleQi + 1) + "-" + circleQs);
    circle0.setAttribute("x", parseInt(targetN20.attr("x")) + 21);
    circle0.setAttribute("y", parseInt(targetN20.attr("y")) + 10);
    circle0.setAttribute("width", 18);
    circle0.setAttribute("height", 18);
    circle0.setAttribute("rx", 9);
    circle0.setAttribute("ry", 9);
    circle0.setAttribute("index", '1');
    circle0.setAttribute("r", 9);
    circle0.setAttribute("qi", (+circleQi) + 1);
    circle0.setAttribute("qs", circleQs);
    circle0.setAttribute("fill", "#B3DE7B");
    targetN20.parent().append(circle0);
    dragObj((+circleQi + 1) + "-" + circleQs);

    var targetCONT1 = $("rect[qi=" + (+circleQi + 1 ) + "][index='0'][qs=" + (+circleQs + 1) + "]");
    var targetN21 = $("rect[qi=" + circleQi + "][index='0'][qs=" + (+circleQs + 1) + "]");

    var rectG1 = $("#svg_CNOT g").clone();
    rectG1.attr('transform', "translate(" + (parseInt(targetCONT1.attr("x")) + 5) + "," + (targetCONT1.attr("y") - 5) + ")");

    rectG1.find("rect").attr("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    rectG1.find("rect").attr("qi", (+circleQi + 1));
    rectG1.find("rect").attr("qs", (+circleQs + 1));
    rectG1.find("rect").attr('refcx', targetN21.attr("x"));
    rectG1.find("rect").attr('refcy', targetN21.attr("y"));
    rectG1.find("rect").attr('id', (+circleQi + 1) + "-" + (+circleQs + 1));
    rectG1.find("rect").attr('type', "CNOT");
    rectG1.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT1).parent().append(rectG1);

    var line1 = document.createElementNS(xmlns, "line");
    line1.setAttribute("n2", "n2-" + circleQi + "-" + (+circleQs + 1));
    line1.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line1.setAttribute("fill", "#B3DE7B");
    // line1.setAttribute("x1", targetCONT1.attr("x"));
    // line1.setAttribute("y1", targetCONT1.attr("y") - 15);
    // line1.setAttribute("x2", rectG1.find("rect").attr("refcx"));
    // line1.setAttribute("y2", (+rectG1.find("rect").attr("refcy")) + 5);
    line1.setAttribute("x1", parseInt(targetCONT1.attr("x"))+30);
    line1.setAttribute("y1", (+parseInt(targetCONT1.attr("y"))));
    line1.setAttribute("x2", parseInt(rectG1.find("rect").attr("refcx"))+30);
    line1.setAttribute("y2", (+parseInt(rectG1.find("rect").attr("refcy"))) + 20);
    targetCONT1.parent().append(line1);

    var circle1 = document.createElementNS(xmlns, "rect");

    circle1.setAttribute("id", "n2-" + circleQi + "-" + (+circleQs + 1));
    circle1.setAttribute("x", parseInt(targetN21.attr("x")) + 21);
    circle1.setAttribute("y", parseInt(targetN21.attr("y")) + 10);
    circle1.setAttribute("width", 18);
    circle1.setAttribute("height", 18);
    circle1.setAttribute("rx", 9);
    circle1.setAttribute("ry", 9);
    circle1.setAttribute("index", '1');
    circle1.setAttribute("r", 9);
    circle1.setAttribute("qi", circleQi);
    circle1.setAttribute("qs", (+circleQs + 1));
    circle1.setAttribute("fill", "#B3DE7B");
    targetN21.parent().append(circle1);
    dragObj((+circleQi + 1) + "-" + (+circleQs + 1));

    var targetCONT2 = $("rect[qi=" + circleQi + "][index='0'][qs=" + (+circleQs + 2) + "]");
    var targetN22 = $("rect[qi=" + (+circleQi + 1) + "][index='0'][qs=" + (+circleQs + 2) + "]");

    var rectG2 = $("#svg_CNOT g").clone();
    rectG2.attr('transform', "translate(" + (parseInt(targetCONT2.attr("x")) + 5) + "," + (targetCONT2.attr("y") - 5) + ")");

    rectG2.find("rect").attr("n2", "n2-" + (+circleQi + 1) + "-" + (+circleQs + 2));
    rectG2.find("rect").attr("qi", circleQi);
    rectG2.find("rect").attr("qs", (+circleQs + 2));
    rectG2.find("rect").attr('refcx', targetN22.attr("x"));
    rectG2.find("rect").attr('refcy', targetN22.attr("y"));
    rectG2.find("rect").attr('id', circleQi + "-" + (+circleQs + 2));
    rectG2.find("rect").attr('type', "CNOT");
    rectG2.find("rect").attr("onclick", "clickImage(evt)");
    $(targetCONT2).parent().append(rectG2);

    var line2 = document.createElementNS(xmlns, "line");
    line2.setAttribute("n2", "n2-" + (+circleQi + 1) + "-" + (+circleQs + 2));
    line2.setAttribute("style", "stroke:#B3DE7B;stroke-width:6");
    line2.setAttribute("fill", "#B3DE7B");
    // line2.setAttribute("x1", rectG2.find("rect").attr("refcx"));
    // line2.setAttribute("y1", (+rectG2.find("rect").attr("refcy")) - 5);
    // line2.setAttribute("x2", targetCONT2.attr("x"));
    // line2.setAttribute("y2", (+targetCONT2.attr("y")) + 15);

    line2.setAttribute("x1", parseInt(rectG2.find("rect").attr("refcx"))+30);
    line2.setAttribute("y1", (+parseInt(rectG2.find("rect").attr("refcy")))+15);
    line2.setAttribute("x2", parseInt(targetCONT2.attr("x"))+30);
    line2.setAttribute("y2", (+parseInt(targetCONT2.attr("y"))) + 35);
    targetN22.parent().append(line2);

    var circle2 = document.createElementNS(xmlns, "rect");

    circle2.setAttribute("id", "n2-" + (+circleQi + 1) + "-" + (+circleQs + 2));
    circle2.setAttribute("x", parseInt(targetN22.attr("x")) + 21);
    circle2.setAttribute("y", parseInt(targetN22.attr("y")) + 10);
    circle2.setAttribute("width", 18);
    circle2.setAttribute("height", 18);
    circle2.setAttribute("rx", 9);
    circle2.setAttribute("ry", 9);
    circle2.setAttribute("index", '1');
    circle2.setAttribute("r", 9);
    circle2.setAttribute("qi", (+circleQi + 1));
    circle2.setAttribute("qs", (+circleQs + 2));
    circle2.setAttribute("fill", "#B3DE7B");
    targetN22.parent().append(circle2);
    dragObj(circleQi + "-" + (+circleQs + 2));
}

function createH6(circleQi, circleQs) {
    for (var i = 0; i < 6; i++) {
        var targetH = $("rect[qi=" + (+circleQi + i) + "][qs=" + circleQs + "][index='0']");
        var $rectG = $("#svg_H g").clone();
        $rectG.attr('transform', "translate(" + (parseInt(targetH.attr("x")) + 5) + "," + (targetH.attr("y") - 5) + ")");

        $rectG.find("rect").attr("qi", (+circleQi + i));
        $rectG.find("rect").attr("qs", circleQs);
        $rectG.find("rect").attr('refcx', targetH.attr("x"));
        $rectG.find("rect").attr('refcy', targetH.attr("y"));
        $rectG.find("rect").attr('id', (+circleQi + i) + "-" + circleQs);
        $rectG.find("rect").attr('type', "H");
        $rectG.find("rect").attr("onclick", "clickImage(evt)");

        targetH.parent().append($rectG);
        dragObj((+circleQi + i) + "-" + circleQs);
    }
}

//是否有足够的空位
function isVoid(qi, qs, xNum, yNum) {
    var i = +qi;
    var s = +qs;
    var maxY = +yNum + i;
    var maxX = +xNum + s;
    if (maxY > qubitNum) {
        var msg = messages.beyond_the_number_of_qubits;
        prompt(msg.substring(0, msg.length - 2));
        return false;
    }

    for (i; i < maxY; i++) {
        //找出当前行上的所有圆点
        var maxQs = -1;
        var rectId = "";
        var isHas = false;
        $("rect[qi=" + i + "][index='0']").each(function(){
            var circleQs = $(this).attr("qs");
            //根据圆点id查找rect元素 存在则说明该圆点被占用
            var rId = i + "-" + circleQs;
            if ($("#" + rId).length > 0) {
                if ($("#" + rId).attr("type") == "Measure") {
                    maxQs = circleQs;
                }
            }
        });
        if (parseInt(maxQs) != -1 && parseInt(maxQs) <= parseInt(qs)) {
            prompt(messages.measure_is_end);
            checkCircle();
            return false;
        }

        s = +qs;
        for (s; s < maxX; s++) {
            var rectId = i + "-" + s;
            if ($("#" + rectId).length > 0) {
                prompt(messages.icons_not_allowed);
                return false;
            }
            if ($("#n2-" + rectId).length > 0) {
                prompt(messages.icons_not_allowed);
                return false;
            }
        }
    }
    return true;
}

function transCode() {   //图形转换成量子程序
    var  flag = true;
    var contents = "";     //量子程序容器初始化
    var qtype = "";
    for (var qs = 1; qs <= stepNum; qs++) {        //每行的节点数   如节点数50，则为1->50
        for (var qi = 0; qi < lineNum; qi++) {     //行数
            if ($("#" + qi + "-" + qs).length != 0) {    //判断该节点上是否有图标   $("#行号-列号").length
                var command = $("#" + qi + "-" + qs);
                var type = $(command).attr("type");      //获取其类型type
                if (type == "RX") {              // RX -->  RX 行号,（expression）
                    var expression = $(command).attr("expression");
                    if (expression == 'pi/4'){
                        qtype = "X1";
                    }else if(expression == 'pi/2'){
                        qtype = "X2";
                    }else if(expression == '3*pi/4'){
                        qtype = "X3";
                    }
                    if (flag){
                        contents += "{\"type\": \""+qtype+"\",\"qBit1\": "+qi+"}";
                        flag = false;
                    }else {
                        contents += ",{\"type\": \""+qtype+"\",\"qBit1\": "+qi+"}";
                    }

                } else if (type == "RY") {              // RY -->  RY 行号,（expression）
                    var expression = $(command).attr("expression");
                    if (expression == 'pi/4'){
                        qtype = "Y1";
                    }else if(expression == 'pi/2'){
                        qtype = "Y2";
                    }else if(expression == '3*pi/4'){
                        qtype = "Y3";
                    }
                    if (flag){
                        contents += "{\"type\": \""+qtype+"\",\"qBit1\": "+qi+"}";
                        flag = false;
                    }else {
                        contents += ",{\"type\": \""+qtype+"\",\"qBit1\": "+qi+"}";
                    }



                }else if (type == "iSWAP") {            // ISWAP -->  ISWAP 第二个点行号,第一个点行号,oper（为pi）
                    var n2 = $("#" + $(command).attr("n2")).attr("qi");
                    // 修改版本 添加“pi”
                    var oper = $(command).attr("operation");
                    if (flag){
                        contents += "{\"type\": \"iSWAP\",\"qBit1\": "+qi+",\"qBit2\": "+n2+",}";
                        flag = false;
                    }else {
                        contents += ",{\"type\": \"iSWAP\",\"qBit1\": "+qi+",\"qBit2\": "+n2+",}";
                    }

                }
            }
        }
    }

    return contents;
};


//界面闪烁设置，待完善
var LineTime = null;
var LineI=0
var LineArray = ["black","green","cyan","blue","purple "]
// LineTime=setInterval(function () {
    // LineI++;
    // if(LineI>5){
    //     LineI = 0;
    // }
    // var resultContent = trans2Code();
    // $("svg line").attr("stroke",LineArray[LineI])
    // if(resultContent!=''||trans2Code()!='\n'){
    //     clearInterval(LineTime)
    //
    // }
// },1000)
