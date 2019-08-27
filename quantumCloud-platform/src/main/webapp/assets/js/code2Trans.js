var xmlns = "http://www.w3.org/2000/svg";

/*
矩形 <rect>
圆形 <circle>
椭圆 <ellipse>
线 <line>
折线 <polyline>
多边形 <polygon>
路径 <path>
*/
//申明对象
var qubitNum='';
var totalRows = qubitNum;//图形最多 多少行
var totalCols = 100;//图形最多 多少列
var yx = "";
var xIndex = 0;//行索引 第几行 对应qi
var yIndex = 1;//列索引 第几列 对应qs
var hash = {};
var currentQi;
var currentQs;
var codeArr2=[]
var clearQubitTime=null
var regNotes = /^%.*$/;
//代码转图形
function code2Trans(code) {
    clearTimeout(clearQubitTime)
    var content = "";
    hash = {};
    if (code != undefined && code != "") {
        content = code;
    } else {
        if (codeMirror == null || codeMirror == undefined) {
            return undefined;
        }
        //获取文本
        content = codeMirror.getValue();
    }
    //非空判断
    if (content == "") {
        initTemplate();
        // return false;
    }

    //处理多行代码
    var result = true;

    var codeArr = content.split("\n");
    codeArr2 = content.split("\n");
    //初始化模板
    initTemplate(codeArr.length);



    $.each(codeArr, function(index, c) {
        if(yIndex>=18){return false;}
        codeArr2.shift()
        if (c) {
            if (regNotes.test(c)) {
                return true;
            }
            result = checkCodeItems(c, index + 1);
            if (typeof result != "undefined" && result != true) {
                result = false;
                return false;
            }
        }
    });
    clearQubitTime=setTimeout(function () {lastArray();},400);
    if(codeArr.length>100){
        var qubitHtml=''
        for(var i=1;i<=codeArr.length;i++){
            qubitHtml +='<li>'+i+'</li>'
        }
        $(".modRight_top ul").html(qubitHtml)
    }
    return result;
}
function lastArray() {
    var result='';
    $.each(codeArr2, function(index, c) {
        if (c) {
            if (regNotes.test(c)) {
                return true;
            }
            result = checkCodeItems(c, index + 1);
            if (typeof result != "undefined" && result != true) {
                result = false;
                return false;
            }
        }
    });
    codeArr2=[];

    return result;
}

//处理单行代码
function checkCodeItems(content,line) {
    //检查代码格式
    var code = checkCode(content);
    if (code != "" && code != -1) {
        //获取坐标
        var locations = getCoordinates(content, code);
        //判断坐标是否含有重复值
        var result = checkRepeat(locations,line);
        if (!result) {
            return false;
        }
        //转化图形
        var commandType = "";//图标类型
        switch (code) {
            case 10:
                return createRect(locations,"H",content,line);
                break;
            case 20:
                return createRect(locations,"NOT",content,line);
                break;
            case 21:
                return createRect(locations,"XPi2",content,line);
                break;
            case 22:
                return createRect(locations,"RX",content,line);
                break;
            case 30:
                return createRect(locations,"ZPi",content,line);
                break;
            case 31:
                return createRect(locations,"ZPi2",content,line);
                break;
            case 32:
                return createRect(locations,"RZ",content,line);
                break;
            case 40:
                return createRect(locations,"YPi2",content,line);
                break;
            case 41:
                return createRect(locations,"RY",content,line);
                break;
            case 50:
                return createRect(locations,"CNOT",content,line);
                break;
            case 60:
                return createRect(locations,"iSWAP",content,line);
                break;
            case 70:
                return createRect(locations,"Toffoli",content,line);
                break;
            case 80:
                if(parseInt(analogType) == 0){//模拟类型为：Monte-Carlo
                    return createRect(locations,"Measure",content,line);
                } else {
                    var result = true;
                    var measureArr = new Array();
                    for(var i =0;i<locations.length;i++){
                        if(parseInt(locations[i]) >= parseInt(totalRows)){
                            prompt(messages.beyond_the_number_of_qubits+line);
                            return false;
                        }
                        measureArr[0] = locations[i];
                        result = createRect(measureArr,"Measure",content,line);
                        if(result == false){
                            return false;
                        }
                    }
                }
                break;
            case 90:
                return createRect(locations,"CR",content,line);
                break;
        }
    } else {
        prompt(messages.compile_error + line);
        return false;
    }
}

//检查包含了那个图形代码
function checkCode(codeStr) {
    if (codeStr.indexOf("H") == 0) {
        if (/^H+\s((?!0)\d{1,3}|0)$/.test(codeStr)) {
            return 10; //H
        } else {
            return -1;
        }
    } else if(codeStr.indexOf("RX") == 0) {//
        if (/^RX+\s((?!0)\d{1,3}|0),\"(pi|PI)\"$/.test(codeStr)) {
            return 20; //NOT
        } else if (/^RX+\s((?!0)\d{1,3}|0),\"(pi|PI)[\/\/]2\"$/.test(codeStr)) {
            return 21; //XPi2
        } else if (/^RX+\s((?!0)\d{1,3}|0),\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/.test(codeStr)) {
            var pointStr = codeStr.substring(codeStr.length-2,codeStr.length-1);
            if (pointStr == ".") {
                return -1;
            }
            return 22; //RX
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("RZ") == 0) {
        if (/^RZ+\s((?!0)\d{1,3}|0),\"(pi|PI)\"$/.test(codeStr)) {
            return 30; //ZPi
        } else if (/^RZ+\s((?!0)\d{1,3}|0),\"(pi|PI)[\/\/]2\"$/.test(codeStr)) {
            return 31; //ZPi2
        } else if (/^RZ+\s((?!0)\d{1,3}|0),\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/.test(codeStr)) {
            var pointStr = codeStr.substring(codeStr.length-2,codeStr.length-1);
            if (pointStr == ".") {
                return -1;
            }
            return 32; //RZ
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("RY") == 0) {
        if (/^RY+\s((?!0)\d{1,3}|0),\"(pi|PI)[\/\/]2\"$/.test(codeStr)) {
            return 40; //YPi2
        } else if(/^RY+\s((?!0)\d{1,3}|0),\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/.test(codeStr)){
            var pointStr = codeStr.substring(codeStr.length-2,codeStr.length-1);
            if (pointStr == ".") {
                return -1;
            }
            return 41; //RY
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("CNOT") == 0) {
        if (/^CNOT+\s((?!0)\d{1,3}|0),((?!0)\d{1,3}|0)$/.test(codeStr)) {
            return 50; //CNOT
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("ISWAP")==0 || codeStr.indexOf("SQISWAP") == 0) {
        if(/^ISWAP+\s((?!0)\d{1,3}|0),((?!0)\d{1,3}|0),\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/.test(codeStr)){
            return 60; //iSWAP
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("TOFFOLI") == 0) {
        if (/^TOFFOLI+\s((?!0)\d{1,3}|0),((?!0)\d{1,3}|0),((?!0)\d{1,3}|0)$/.test(codeStr)) {
            return 70; //Toffoli
        } else {
            return -1;
        }
    } else if (codeStr.indexOf("MEASURE") == 0 || codeStr.indexOf("PMEASURE") == 0) {
        if (parseInt(analogType) == 0||parseInt(analogType) == 2) {//模拟类型为：Monte-Carlo
            if (/^MEASURE+\s((?!0)\d{1,3}|0),\$[\d]{1,3}$/.test(codeStr)) {
                return 80; //Measure
            } else {
                return -1;
            }
        } else {
            if (/^PMEASURE\s[\d\,]{0,}\d+$/.test(codeStr)) {
                return 80; //Measure
            } else {
                return -1;
            }
        }
    } else if (codeStr.indexOf("CR") == 0) {
        if (/^CR+\s((?!0)\d{1,3}|0),((?!0)\d{1,3}|0),\"([(\d\.\-)]{1,200}|[(\-)(pi|PI)]{3}|[(pi|PI)]{2})[\+\-\*\/\^]*[\d+(\.\d+)]{1,200}\"$/.test(codeStr)) {
            var pointStr = codeStr.substring(codeStr.length-2,codeStr.length-1);
            if (pointStr == ".") {
                return -1;
            }
            return 90; //CR
        } else {
            return -1;
        }
    } else {
        return -1;
    }
}

//通过代码表达式 获取点位 content:内容，code:checkCode()获取的代码
function getCoordinates(content, code) {
    try {
        //处理特殊代码
        if (code == 21 || code == 31 || code == 40) {
            var reg1 = /\"(pi|PI)[\/]2\"$/;
            content = content.replace(reg1,"");
        } else if (code == 22 || code == 32 || code == 41 || code == 90) {
            var reg2 = /\"((\+|\-)?((\d+(\.\d*)?)?|(pi|PI){1}))([\+\-\*\/\^]{1}((\+|\-)?((\d+(\.\d*)?)?|(pi|PI){1})))*\"$/;
            content = content.replace(reg2,"");
        } else if (code == 80) {
            var reg3 = /\$[\d]$/;
            content = content.replace(reg3,"");
        } else if (code == 60) {
            var reg4 = /\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/;
            content = content.replace(reg4,"");
        }
        var reg = /[^0-9$]/ig;
        var numStr = content.replace(reg,",");
        var nums = numStr.split(",");
        var getnums = new Array();
        for (var i = 0; i < nums.length; i++) {
            if (nums[i] + "" != "") {
                getnums[getnums.length] = nums[i];
            }
        }
        return getnums;
    } catch (e) {
        prompt(e);
    }
}

//生成图形
var isInit = true;//是否是第一次加载
function createRect(location, commandType, content, lineNums) {
    //不能超出比特量子范围
    if (parseInt(yIndex) > parseInt(totalCols)) {//代码转图形 已达到量子比特最大承受数  不提示 直接转为图形
        return undefined;
    }
    for(var l=0;l<location.length;l++){
        if(parseInt(location[l])>=parseInt(qubitNum)){
            prompt(messages.expression_is_not_legal);
            return false;
        }
    }


    var rectG = $("#svg_" + commandType + " g").clone();

    if (commandType == "CNOT" || commandType == "CR" || commandType == "iSWAP" || commandType == "Toffoli") { // 多点图标
        //第一个图标加载
        if (xIndex == 0 && yIndex == 1 && isInit == true) {

            if (parseInt(location[location.length - 1]) >= parseInt(totalRows)) {
                prompt(messages.beyond_the_number_of_qubits+lineNums);
                return false;
            }

            //判断当前位置是否已被占用
            yx = location[location.length - 1] + "-" + yIndex;
            if ($("#" + yx).length <= 0) {
                $("rect[index='0']").attr("focus","false");
                checkCircle();
                var circle = $("rect[qs=" + yIndex + "][index='0'][qi=" + location[location.length - 1] + "]");
                $(circle).attr("focus","true");
                $(circle).attr("r","9");
                $(circle).attr("stroke","none");
                $(circle).attr("fill","#fff");
                $(circle).attr("fill-opacity","0");
                xIndex = location[location.length-1];
            } else {
                prompt(messages.bit_gate_already_existed+lineNums);
                return false;
            }
            $("rect[focus=true][index='1']").attr("focus","false").attr("stroke","none");
            rectG.attr('transform',"translate("+( parseInt($("rect[focus=true][index='0']").attr("x")) +5)+","+($("rect[focus=true][index='0']").attr("y")-5)+")");

            $(rectG).find("rect").attr('stroke', 'black');
            $(rectG).find("rect").attr('stroke-width', '1');
            $(rectG).find("rect").attr("qi",xIndex);
            $(rectG).find("rect").attr("qs",yIndex);
            $(rectG).find("rect").attr('refcx',$("rect[focus=true][index='0']").attr("x"));
            $(rectG).find("rect").attr('refcy',$("rect[focus=true][index='0']").attr("y"));
            $(rectG).find("rect").attr('id',xIndex+"-"+yIndex);
            $(rectG).find("rect").attr('type',commandType);
            $(rectG).find("rect").attr( 'focus', 'true');
            $("rect[focus=true][index='0']").parent().append(rectG);

            //处理剩下点坐标
            if(commandType == "iSWAP"){
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");
                    //连线
                    var line = document.createElementNS (xmlns, "line");
                    line.setAttribute("n2", "n2-"+location[i]+"-"+yIndex);
                    line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                    }else{
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y")));
                    }
                    line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                    line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                    line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill","#B3DE7B");
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(line);
                        xIndex = location[i];
                    }else{
                        $(rectG).parent().append(line);
                        xIndex = location[location.length-1];
                    }

                    var rectG2 = $("#svg_iSWAP g").clone();
                    rectG2.attr('transform',"translate("+(parseInt(fixedCircle.attr("x")) + 5)+","+(parseInt(fixedCircle.attr("y")) - 5)+")");
                    $(rectG2).find("rect").attr("qi",location[i]);
                    $(rectG2).find("rect").attr("qs",yIndex);
                    $(rectG2).find("rect").attr('refcx',$("rect[focus=true][index='0']").attr("x"));
                    $(rectG2).find("rect").attr('refcy',$("rect[focus=true][index='0']").attr("y"));
                    $(rectG2).find("rect").attr('id',"n2-"+location[i]+"-"+yIndex);
                    $(rectG2).find("rect").attr('type',commandType);
                    $(rectG2).find("rect").attr( 'refid', location[i]+"-"+yIndex);
                    //$(rectG2).find("rect").attr("onclick","clickImage(evt)");
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(rectG2);
                    }else{
                        $(rectG).parent().append(rectG2);
                    }

                    //关联
                    $(rectG).find("rect[focus=true][index='1']").attr("n2","n2-"+location[i]+"-"+yIndex);
                }
            }else if(commandType == "Toffoli"){
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");

                    //创建新的圆点
                    if(parseInt(i+1) < parseInt(location.length-1)){
                        var circle = document.createElementNS (xmlns, "rect");
                        circle.setAttribute("id", "n2-"+location[i]+"-"+yIndex);
                        circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                        circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                        circle.setAttribute("width",18);
                        circle.setAttribute("height",18);
                        circle.setAttribute("rx",9);
                        circle.setAttribute("ry",9);
                        circle.setAttribute("index", '1');
                        circle.setAttribute("r","9");
                        circle.setAttribute("qi",location[i]);
                        circle.setAttribute("qs",yIndex);
                        circle.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(circle);
                        //连线
                        var line = document.createElementNS (xmlns, "line");
                        line.setAttribute("n2", "n2-"+location[i]+"-"+yIndex);
                        line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                        if(parseInt(location[i]) >= parseInt(location[location.length-1])){
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                        }else{
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))-0);
                        }
                        line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                        line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                        line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                        line.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(line);
                        //关联
                        $(rectG).find("rect[focus=true]").attr("n2","n2-"+location[i]+"-"+yIndex);
                    }else if(parseInt(i+1) == parseInt(location.length-1)){
                        var circle = document.createElementNS (xmlns, "rect");
                        circle.setAttribute("id", "n3-"+xIndex+"-"+yIndex);
                        circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                        circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                        circle.setAttribute("width",18);
                        circle.setAttribute("height",18);
                        circle.setAttribute("rx",9);
                        circle.setAttribute("ry",9);
                        circle.setAttribute("index", '1');
                        circle.setAttribute("r","9");
                        circle.setAttribute("qi",location[i]);
                        circle.setAttribute("qs",yIndex);
                        circle.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(circle);
                        //连线
                        var line = document.createElementNS (xmlns, "line");
                        line.setAttribute("n3", "n3-"+xIndex+"-"+yIndex);
                        line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                        if(parseInt(location[i]) >= parseInt(location[location.length-1])){
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                        }else{
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))-0);
                        }
                        line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                        line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                        line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                        line.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(line);
                        //关联
                        $(rectG).find("rect[focus=true]").attr("n3","n3-"+xIndex+"-"+yIndex);
                    }
                }
                xIndex = Math.max.apply(null, location);
            }else{
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");
                    //创建新的圆点
                    var circle = document.createElementNS (xmlns, "rect");
                    circle.setAttribute("id", "n2-"+location[i]+"-"+yIndex);
                    circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                    circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                    circle.setAttribute("width",18);
                    circle.setAttribute("height",18);
                    circle.setAttribute("rx",9);
                    circle.setAttribute("ry",9);
                    circle.setAttribute("index", '1');
                    circle.setAttribute("r","9");
                    circle.setAttribute("qi",location[i]);
                    circle.setAttribute("qs",yIndex);
                    circle.setAttribute("fill","#B3DE7B");
                    $(fixedCircle).parent().append(circle);
                    //连线
                    var line = document.createElementNS (xmlns, "line");
                    line.setAttribute("n2", "n2-"+location[i]+"-"+yIndex);
                    line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                    }else{
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y")));
                    }
                    line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                    line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                    line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill","#B3DE7B");
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(line);
                        xIndex = location[i];
                    }else{
                        $(rectG).parent().append(line);
                        xIndex = location[location.length-1];
                    }
                    //关联
                    $(rectG).find("rect[focus=true][index='1']").attr("n2","n2-"+location[i]+"-"+yIndex);
                }
            }
            isInit=false;
        }else{//第二个图形开始加载
            if(parseInt(location[location.length-1]) >= parseInt(totalRows)){
                prompt(messages.beyond_the_number_of_qubits+lineNums);
                return false;
            }
            //当后面的坐标竖向位置小于当前点row_index 从后面一列开始计算 即：location数组中的最小值 是否小于xIndex 是则从yIndex+1列开始
            if(parseInt(Math.min.apply(null, location)) <= parseInt(xIndex) && parseInt(yIndex) <= parseInt(totalCols)){// && xIndex <= totalRows
                yIndex++;
            }
            //qi坐标
            xIndex = location[location.length-1];

            //判断当前位置是否已被占用
            yx=location[location.length-1]+"-"+yIndex;
            if($("#"+yx).length<=0){
                $("rect[index='0']").attr("focus","false");
                checkCircle();
                var circle = $("rect[qs="+yIndex+"][index='0'][qi="+location[location.length-1]+"]");
                $(circle).attr("focus","true");
                $(circle).attr("r","9");
                $(circle).attr("stroke","none");
                $(circle).attr("fill","#fff");
                $(circle).attr("fill-opacity","0");
                //xIndex = location[location.length-1];
            }else{
                prompt(messages.bit_gate_already_existed+lineNums);
                return false;
            }
            currentQi = xIndex;
            currentQs = yIndex;

            //多比特门第一个点 检测是否存在
            if(!checkMeasureLocation(currentQi,currentQs,lineNums)){
                return false;
            }

            $("rect[focus=true][index='1']").attr("focus","false").attr("stroke","none");
            rectG.attr('transform',"translate("+(parseInt($("rect[focus=true][index='0']").attr("x")) + 5)+","+($("rect[focus=true][index='0']").attr("y")-5)+")");

            $(rectG).find("rect").attr('stroke', 'none');
            $(rectG).find("rect").attr('stroke-width', '1');
            $(rectG).find("rect").attr("qi",xIndex);
            $(rectG).find("rect").attr("qs",yIndex);
            $(rectG).find("rect").attr('refcx',$("rect[focus=true][index='0']").attr("x"));
            $(rectG).find("rect").attr('refcy',$("rect[focus=true][index='0']").attr("y"));
            $(rectG).find("rect").attr('id',xIndex+"-"+yIndex);
            $(rectG).find("rect").attr('type',commandType);
            $(rectG).find("rect").attr( 'focus', 'true');
            $("rect[focus=true][index='0']").parent().append(rectG);

            //处理剩下点坐标
            if(commandType == "iSWAP"){
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    if(!checkMeasureLocation(location[i],yIndex,lineNums)){
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");

                    //连线
                    var line = document.createElementNS (xmlns, "line");
                    line.setAttribute("n2", "n2-"+location[i]+"-"+yIndex);
                    line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                    }else{
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))-0);
                    }
                    line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                    line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                    line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill","#B3DE7B");

                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(line);
                        xIndex = location[i];
                    }else{
                        $(rectG).parent().append(line);
                        xIndex = location[location.length-1];
                    }

                    var rectG2 = $("#svg_iSWAP g").clone();
                    rectG2.attr('transform',"translate("+(parseInt(fixedCircle.attr("x")) + 5)+","+(fixedCircle.attr("y") - 5)+")");
                    $(rectG2).find("rect").attr("qi",location[i]);
                    $(rectG2).find("rect").attr("qs",yIndex);
                    $(rectG2).find("rect").attr('refcx',$("rect[focus=true][index='0']").attr("x"));
                    $(rectG2).find("rect").attr('refcy',$("rect[focus=true][index='0']").attr("y"));
                    $(rectG2).find("rect").attr('id',"n2-"+location[i]+"-"+yIndex);
                    $(rectG2).find("rect").attr('type',commandType);
                    $(rectG2).find("rect").attr( 'refid', location[i]+"-"+yIndex);
                    //$(rectG2).find("rect").attr("onclick","clickImage(evt)");
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(rectG2);
                    }else{
                        $(rectG).parent().append(rectG2);
                    }

                    //关联
                    $(rectG).find("rect[focus=true][index='1']").attr("n2","n2-"+location[i]+"-"+yIndex);
                }
            }else if(commandType == "Toffoli"){
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    if(!checkMeasureLocation(location[i],yIndex,lineNums)){
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");
                    //创建新的圆点
                    if(parseInt(i+1) < parseInt(location.length-1)){
                        var circle = document.createElementNS (xmlns, "rect");
                        circle.setAttribute("id", "n2-"+location[i]+"-"+yIndex);
                        circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                        circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                        circle.setAttribute("width",18);
                        circle.setAttribute("height",18);
                        circle.setAttribute("rx",9);
                        circle.setAttribute("ry",9);
                        circle.setAttribute("index", '1');
                        circle.setAttribute("r",9);
                        circle.setAttribute("qi",location[i]);
                        circle.setAttribute("qs",yIndex);
                        circle.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(circle);
                        //连线
                        var line = document.createElementNS (xmlns, "line");
                        line.setAttribute("n2", "n2-"+location[i]+"-"+yIndex);
                        line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                        if(parseInt(location[i]) >= parseInt(location[location.length-1])){
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                        }else{
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))-0);
                        }
                        line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                        line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                        line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                        line.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(line);
                        //关联
                        $(rectG).find("rect[focus=true][index='1']").attr("n2","n2-"+location[i]+"-"+yIndex);
                    }else if(parseInt(i+1) == parseInt(location.length-1)){
                        var circle = document.createElementNS (xmlns, "rect");
                        circle.setAttribute("id", "n3-"+xIndex+"-"+yIndex);
                        circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                        circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                        circle.setAttribute("width",18);
                        circle.setAttribute("height",18);
                        circle.setAttribute("rx",9);
                        circle.setAttribute("ry",9);
                        circle.setAttribute("index", '1');
                        circle.setAttribute("r",9);
                        circle.setAttribute("qi",location[i]);
                        circle.setAttribute("qs",yIndex);
                        circle.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(circle);
                        //连线
                        var line = document.createElementNS (xmlns, "line");
                        line.setAttribute("n3", "n3-"+xIndex+"-"+yIndex);
                        line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                        if(parseInt(location[i]) >= parseInt(location[location.length-1])){
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                        }else{
                            line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))-0);
                        }
                        line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                        line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                        line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                        line.setAttribute("fill","#B3DE7B");
                        $("rect[focus=true][index='0']").parent().parent().append(line);
                        //关联
                        $(rectG).find("rect[focus=true][index='1']").attr("n3","n3-"+xIndex+"-"+yIndex);
                    }
                }
                xIndex = Math.max.apply(null, location);
            }else{
                for(var i=0;i<location.length-1;i++){
                    if(parseInt(location[i]) >= parseInt(totalRows)){
                        prompt(messages.beyond_the_number_of_qubits+lineNums);
                        return false;
                    }
                    if(!checkMeasureLocation(location[i],yIndex,lineNums)){
                        return false;
                    }
                    //获取固定坐标圆点
                    var fixedCircle = $("rect[qi="+location[i]+"][index='0'][qs="+yIndex+"]");
                    //创建新的圆点
                    var circle = document.createElementNS (xmlns, "rect");
                    circle.setAttribute("id","n2-"+location[i]+"-"+yIndex);
                    circle.setAttribute("x",parseInt(fixedCircle.attr("x"))+21);
                    circle.setAttribute("y",parseInt(fixedCircle.attr("y"))+10);
                    circle.setAttribute("width",18);
                    circle.setAttribute("height",18);
                    circle.setAttribute("rx",9);
                    circle.setAttribute("ry",9);
                    circle.setAttribute("index", '1');
                    circle.setAttribute("r",9);
                    circle.setAttribute("qi",fixedCircle.attr("qi"));
                    circle.setAttribute("qs",fixedCircle.attr("qs"));
                    circle.setAttribute("fill","#B3DE7B");
                    $(fixedCircle).parent().append(circle);
                    //连线
                    var line = document.createElementNS (xmlns, "line");
                    line.setAttribute("n2","n2-"+location[i]+"-"+yIndex);
                    line.setAttribute("x1",parseInt($("rect[focus=true][index='0']").attr("x"))+30);
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+37);
                    }else{
                        line.setAttribute("y1",parseInt($("rect[focus=true][index='0']").attr("y"))+0);
                    }
                    line.setAttribute("x2",parseInt(fixedCircle.attr("x"))+30);
                    line.setAttribute("y2",parseInt(fixedCircle.attr("y"))+20);
                    line.setAttribute("style","stroke:#B3DE7B;stroke-width:6");
                    line.setAttribute("fill","#B3DE7B");
                    if(parseInt(location[i])>parseInt(location[location.length-1])){
                        $(fixedCircle).parent().append(line);
                        xIndex = location[i];
                    }else{
                        $(rectG).parent().append(line);
                        xIndex = location[location.length-1];
                    }
                    //关联
                    $(rectG).find("rect[focus=true][index='1']").attr("n2","n2-"+location[i]+"-"+yIndex);
                }
            }
        }//多比特门 第二个图形加载结束
    }else{ // 单点图标
        if(parseInt(location[0]) >= parseInt(totalRows)){
            prompt(messages.beyond_the_number_of_qubits+lineNums);
            return false;
        }
        if(xIndex==0 && yIndex==1 && isInit==true){//第一个图标加载
            //判断当前位置是否已被占用
            yx=yIndex+"-"+location[0];
            if($("#"+yx).length<=0){
                $("rect[index='0']").attr("focus","false");
                checkCircle();

                var circle = $("rect[qs="+yIndex+"][index='0'][qi="+location[0]+"]");
                $(circle).attr("focus","true");
                $(circle).attr("r","7");
                $(circle).attr("stroke","none");
                $(circle).attr("fill","#fff");
                $(circle).attr("fill-opacity","0");
                xIndex = location[0];
            }
            isInit=false;
        }else{//第二个图形开始加载
            //当后面的坐标竖向位置小于当前点row_index 从后面一列开始计算
            if(parseInt(location[0]) <= parseInt(xIndex) && parseInt(yIndex) <= parseInt(totalCols)){//&& xIndex <= totalRows
                yIndex++;
            }
            xIndex = location[0];
            //判断当前位置是否已被占用
            yx=xIndex+"-"+yIndex;
            if($("#"+yx).length<=0){
                $("rect[index='0']").attr("focus","false");
                checkCircle();
                var circle = $("rect[qs="+yIndex+"][index='0'][qi="+location[0]+"]");
                $(circle).attr("focus","true");
                $(circle).attr("r","7");
                $(circle).attr("stroke","none");
                $(circle).attr("fill","#fff");
                $(circle).attr("fill-opacity","0");
                xIndex = location[0];
            }
        }
        if($("#"+yx).length>0){
            prompt(messages.bit_gate_already_existed+lineNums);
            return false;
        }

        //判断测量比特后面是否存在其他比特
        if(commandType == "Measure"){//测量比特
            currentQi = xIndex;
            currentQs = yIndex;
            //找出当前行上的所有圆点
            var maxQs = -1;
            var rectId = "";
            var isHas = false;
            $("rect[qi="+currentQi+"][index='0']").each(function(){
                var circleQs = $(this).attr("qs");
                //根据圆点id查找rect元素 存在则说明该圆点被占用
                rectId = currentQi + "-" + circleQs;
                if($("#"+rectId).length>0){
                    maxQs = circleQs;
                    if($("#"+rectId).attr("type") == "Measure"){
                        if(isHas){
                            return;
                        }else{
                            isHas = true;
                            return false;
                        }
                    }
                }
            });
            //判断某线条上的最大的占用点的qs是否大于当前选择圆点的qs 是：当前点不允许放置测量比特，否：允许放置
            if(parseInt(currentQs) <= parseInt(maxQs)){
                prompt(messages.measure_is_end_in_line+lineNums);
                return false;
            }else{
                if(isHas){
                    prompt(messages.measure_is_only_in_line+lineNums);
                    return false;
                }
            }
        }else{//非测量比特
            currentQi = xIndex;
            currentQs = yIndex;
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
                prompt(messages.measure_is_end_in_line+lineNums);
                return false;
            }
        }

        $("rect[focus=true][index='1']").attr("focus","false").attr("stroke","none");
        rectG.attr('transform',"translate("+(parseInt($("rect[focus=true][index='0']").attr("x"))+5)+","+($("rect[focus=true][index='0']").attr("y")-5)+")");

        $(rectG).find("rect").attr('stroke', 'black');
        $(rectG).find("rect").attr('stroke-width', '1');

        $(rectG).find("rect").attr("qi",xIndex);
        $(rectG).find("rect").attr("qs",yIndex);
        $(rectG).find("rect").attr('refcx',$("rect[focus=true][index='0']").attr("x"));
        $(rectG).find("rect").attr('refcy',$("rect[focus=true][index='0']").attr("y"));
        $(rectG).find("rect").attr('id',xIndex+"-"+yIndex);
        $(rectG).find("rect").attr('type',commandType);
        $(rectG).find("rect").attr( 'focus', 'true');

        $("rect[focus=true][index='0']").parent().append(rectG);
    }

    //绑定单击事件
    $(rectG).attr("onclick","clickImage(evt)");

    //处理表达式
    if (commandType == "RZ" || commandType == "RX" || commandType == "RY" || commandType == "CR")
    {
        //var reg = new RegExp(/\"([(\d\.\-)]{1,200}|[(pi|PI)]{2})[\+\-\*\/\^]*[\d+(\.\d+)]*\"$/);
        //var reg = new RegExp(/\"([(\d\.\-)]{1,200}|[(pi|PI)]{2})[\+\-\*\/\^]*([\d+(\.\d+)]|[pi|PI])*\"$/);
        var reg = new RegExp(/\"((\+|\-)?((\d+(\.\d*)?)?|(pi|PI){1}))([\+\-\*\/\^]{1}((\+|\-)?((\d+(\.\d*)?)?|(pi|PI){1})))*\"$/);
        var exp = content.match(reg);
        $(rectG).find("rect").attr( 'expression', exp[0].replace(/\"/g,""));
    } else if (commandType == "Measure")
    {
        if(parseInt(analogType) == 0){//模拟类型为：Monte-Carlo
            $(rectG).find("rect").attr( 'register', content.split(',')[1]);
        }else{
            $(rectG).find("rect").attr( 'register', xIndex);
        }
    } else if (commandType == "iSWAP")
    {
        //原版本
        /*if(/^SQISWAP+\s\d{1,3},\d{1,3}$/.test(content)){
            $(rectG).find("rect").attr( 'operation', "sqiSWAP");
        }else{
            $(rectG).find("rect").attr( 'operation', "iSWAP");
        }*/
        //新版本
        var reg = new RegExp(/\"\-*((pi|PI)|\d+(\.\d+)?)(([+*-]((pi|PI)|\d+(\.\d*)?))|(\/((pi|PI)|[1-9]\d*(\.\d+)?|\d+\.[0-9]*[1-9][0-9]*))|(\^)(\d+|(pi|PI)))*\"$/);
        var oper = content.match(reg);
        $(rectG).find("rect").attr( 'operation', oper[0].replace(/\"/g,""));
    }
    //$("circle[focus=true]").parent().append(rectG);

    propertyBoard($("rect[focus=true][index='0']").attr("qi")+"-"+$("rect[focus=true][index='0']").attr("qs"),1);
    dragObj($("rect[focus=true][index='0']").attr("qi")+"-"+$("rect[focus=true][index='0']").attr("qs"));//为已生成的图形绑定拖拽事件
}

//去除圆点样式
function checkCircle(){
    $("rect[index='0']").each(function(){
        if ($(this).attr("id") != undefined && $(this).attr("id").length > 0) {
            var id = $(this).attr("id");
            if(id.indexOf("n2")>=0 || id.indexOf("n3")>=0){
                return;
            } else {
                $(this).attr("focus","false").attr("r","3").attr("stroke","none").attr("fill","#fff");//2018/4/27修改
                $(this).attr("focus","false").attr("r","3").attr("stroke","none").attr("fill-opacity","0");//2018/4/27修改
            }
        } else {
            $(this).attr("focus","false").attr("r","3").attr("stroke","none").attr("fill","#fff");//2018/4/27修改
            $(this).attr("focus","false").attr("r","3").attr("stroke","none").attr("fill-opacity","0");//2018/4/27修改
        }
    });
}

//初始化
function initTemplate(numLength) {
    $("#modRight_center").html("");//清除模板
    if(numLength>100){
        svgBoard(qubitNum, numLength, classicalbitNum,'$');//重新生成
    }else {
        svgBoard(qubitNum, 100, classicalbitNum,'$');//重新生成
    }
    xIndex = 0;
    yIndex = 1;
    isInit = true;
}

/**
 * 检测当前坐标前是否存在 测量门 存在则不继续执行
 * @param circleQi X轴
 * @param circleQs Y轴
 * @returns {Boolean}
 */
function checkMeasureLocation(circleQi,circleQs,lineNums){
    var isHas = false;
    $("rect[qi="+circleQi+"][index='0']").each(function(){
        var qs = $(this).attr("qs");
        //根据圆点id查找rect元素 存在则说明该圆点被占用
        if(parseInt(qs) < parseInt(circleQs)){
            var rectId = circleQi + "-" + qs;
            if($("#"+rectId).length>0){
                if($("#"+rectId).attr("type") == "Measure"){
                    isHas = true;
                    return false;
                }
            }
        }
    });
    if(isHas){
        prompt(messages.measure_not_more_qubit_in_line+lineNums);
        return false;
    }else{
        return true;
    }
}

/**
 * 判断是否存在重复的坐标
 * @param arr 坐标集合
 * @returns {Boolean}
 */

function checkRepeat(arr,lineNums){
    var result = true;
    hash = {};
    for(var i in arr) {
        if(hash[arr[i]])
        {
            prompt(messages.contain_repeating_coordinates+lineNums);
            result = false;
            return false;
        }
        // 不存在该元素，则赋值为true，可以赋任意值，相应的修改if判断条件即可
        hash[arr[i]] = true;
    }
    return result;
}
