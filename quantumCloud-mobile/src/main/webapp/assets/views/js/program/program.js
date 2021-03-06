var xmlns = "http://www.w3.org/2000/svg";

//------------------------------------------------------------------------------//
//-----------------------  GuoJun-20180117   -----------------------------------//
//------------------------------------------------------------------------------//
/**
 * 经典比特
 * @param lineIndex 量子bit索引
 * @param stepIndex 经典量子索引
 * @param x 经典比特在svg画布中心点x坐标
 * @param y 经典比特在svg画布中心点y坐标
 * @param eventBook 事件记录器
 */
//codeArray 比特门代码数组
function ClassicsBit(lineIndex, stepIndex, x, y, eventBook) {
    this.lineIndex = lineIndex;
    this.stepIndex = stepIndex;
    this.x = x;
    this.y = y;
    this.eventBook = eventBook;
    //1 = "click";2 = "doubleClick"
    this.detail = 0;
    this.quantumDoor = null;
}

ClassicsBit.prototype.init = function() {
    this.bitDoor = new VoidDoor(this);
}

//删除比特门
ClassicsBit.prototype.delQuantumDoor = function(svgBoard) {
    this.bitDoor.svgElement.parentNode.parentNode.removeChild(this.quantumDoor.svgElement);
    svgBoard.removeClassicsBit(this);
    this.quantumDoor = null;
}

//激活
ClassicsBit.prototype.activate = function(svgBoard) {
    console.log("before click:");
    console.log(this.eventBook);

    //之前有点击事件
    if (this.eventBook.currentEntity) {
        //之前点的是空点
        if (this.eventBook.currentEntity.quantumDoor == null) {
            this.eventBook.currentEntity.bitDoor.inactivation();
            this.bitDoor.activate();
            //弹出
            var elAside = $('#aside');
            elAside.addClass('active');
            $.smartScroll(elAside, '.scrollable');
            $('html').addClass('noscroll');
        } else if (this.eventBook.currentEntity.quantumDoor instanceof SingleDoor
            || this.eventBook.currentEntity.quantumDoor instanceof MeasureDoor) {
            this.eventBook.currentEntity.quantumDoor.inactivation();
            this.bitDoor.activate();
            //弹出
            var elAside = $('#aside');
            elAside.addClass('active');
            $.smartScroll(elAside, '.scrollable');
            $('html').addClass('noscroll');
        }
        //点击的是多比特门
        else if (this.eventBook.currentEntity.quantumDoor instanceof MultiDoor) {
            if (this.eventBook.currentEntity.quantumDoor.otherBitArray.length < this.eventBook.currentEntity.quantumDoor.doorNum - 1) {
                if (this.eventBook.currentEntity.stepIndex != this.stepIndex) {
                    error(messages.second_points_must_be_on_vertical_line);
                    return false;
                } else if (this.eventBook.currentEntity.lineIndex != this.lineIndex) {
                    if (this.hasCode()) {
                        error(messages.already_exists_on_vertical_line);
                        return false;
                    }
                    if (!svgBoard.quantumCheckout(this)) {
                        return false;
                    }
                    console.log(this.eventBook.currentEntity.quantumDoor);
                    this.quantumDoor = this.eventBook.currentEntity.quantumDoor;
                    this.eventBook.currentEntity.quantumDoor.addOtherBit(this);
                    this.eventBook.currentEntity.quantumDoor.drawLine();
                }
            } else {
                this.eventBook.currentEntity.inactivation();
                this.bitDoor.activate();
                //弹出
                var elAside = $('#aside');
                elAside.addClass('active');
                $.smartScroll(elAside, '.scrollable');
                $('html').addClass('noscroll');
            }
        }
    } else {
        this.bitDoor.activate();
        //弹出
        var elAside = $('#aside');
        elAside.addClass('active');
        $.smartScroll(elAside, '.scrollable');
        $('html').addClass('noscroll');
    }
    if (this.eventBook.currentEntity) {
        if (!this.equals(this.eventBook.currentEntity)) {
            var previousEntity = this.eventBook.currentEntity;
            this.eventBook.previousEntity = previousEntity;
        }
    }
    this.eventBook.currentEntity = this;
    console.log("after click:");
    console.log(this.eventBook);
}

ClassicsBit.prototype.inactivation = function() {
    if (this.quantumDoor && this.quantumDoor.inactivation) {
        this.quantumDoor.inactivation();
    }

    this.bitDoor.inactivation();

}

ClassicsBit.prototype.equals = function(other) {
    if (other instanceof ClassicsBit) {
        return (this.lineIndex == other.lineIndex && this.stepIndex == other.stepIndex);
    }
    return false;
}

//检查代码
ClassicsBit.prototype.hasCode = function () {
    var has = false;
    if (this.eventBook.currentEntity.quantumDoor instanceof MultiDoor) {
        var that = this;
        var multiFirst = this.eventBook.currentEntity.quantumDoor.firstClassicsBit;
        $.each(this.codeArray, function(index, code) {
            if (that.stepIndex == multiFirst.stepIndex) {
                if ((that.lineIndex < code.lineIndex && code.lineIndex < multiFirst.lineIndex)
                    || (multiFirst.lineIndex < code.lineIndex && code.lineIndex < that.lineIndex)) {
                    has = true;
                    return false;
                }
            }
        });
    }
    return has;
}

/**
 * 量子比特
 * @param x1 量子比特在svg画布中起点x坐标
 * @param y1 量子比特在svg画布中起点x坐标
 * @param x2 量子比特在svg画布中结束点x坐标
 * @param y2 量子比特在svg画布中结束点x坐标
 * @param stepNum 经典量子数
 * @param stepWidth 经典量子间的距离
 * @param strokeWidth 线的宽度
 * @param lineIndex 量子比特的索引
 */
//codeArray 比特门代码数组
function QuantumBit(x1, y1, x2, y2, stepNum, stepWidth, strokeWidth, lineIndex) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.stepNum = stepNum;
    this.stepWidth = stepWidth;
    this.strokeWidth = strokeWidth;
    this.lineIndex = lineIndex;
    
    this.svgLine = document.createElementNS(xmlns, "line");
    this.svgLine.setAttribute("x1", x1);
    this.svgLine.setAttribute("y1", y1);
    this.svgLine.setAttribute("x2", x2);
    this.svgLine.setAttribute("y2", y2);
    this.svgLine.setAttribute("style", "stroke:#707070;stroke-width:" + strokeWidth);
    this.classicsArray = new Array(stepNum);
}

QuantumBit.prototype.init = function () {
    this.lineG = document.createElementNS(xmlns, "g");
    this.lineG.appendChild (this.svgLine);
    for (var i = 0; i < this.stepNum; i++) {
        var classicsBit = new ClassicsBit(this.lineIndex, i, (i + 1) * this.stepWidth + this.x1, this.y1 - this.strokeWidth / 2);
        classicsBit.eventBook = this.eventBook;
        classicsBit.codeArray = this.codeArray;
        classicsBit.init();
        this.lineG.appendChild(classicsBit.bitDoor.svgElement);
        this.classicsArray[i] = classicsBit;
    }
}

/**
 * @param parentId 父窗口id
 * @param lineNum 量子比特数
 * @param stepNum 经典比特数
 * @param stepWidth 经典比特间距离
 * @param lineStartX 比特线开始x坐标
 * @param lineStartY 比特线开始y坐标
 * @param lineDistance 两条比特线（量子比特）距离
 */
//codeArray 代码数组
//measureArray 测量数组
//analogType 模拟类型
function SvgBoard(parentId, lineNum, stepNum, stepWidth, lineStartX, lineStartY, lineDistance) {
    this.parentId = parentId;
    this.lineNum = lineNum;
    this.stepNum = stepNum;
    this.stepWidth = stepWidth;
    this.lineStartX = lineStartX;
    this.lineStartY = lineStartY;
    this.lineDistance = lineDistance;
    this.boxWidth = (stepNum + 2) * stepWidth + lineStartX;
    this.boxHeight = (lineNum + 1) * lineDistance;//svg高度
    if (this.boxHeight < 300) {
        this.boxHeight = 300;
    }

    this.svgElement = document.createElementNS(xmlns, "svg");
    this.svgElement.setAttributeNS (null, "width", this.boxWidth);
    this.svgElement.setAttributeNS (null, "height", this.boxHeight);
    this.svgElement.setAttributeNS (null, "version", "1.1");
    this.svgElement.setAttributeNS (null, "id", "svgBoard");
    this.quantumArray = new Array(lineNum);
    this.codeArray = [];
    this.measureArray = [];
    this.codeRegexpArray = [];
    this.analogType = 0;
}

SvgBoard.prototype.init = function () {
    this.eventBook = new EventBook();
    for(var i = 0; i < this.lineNum; i++) {
        var quantumBit = new QuantumBit(this.lineStartX, i * this.lineDistance + this.lineStartY, this.boxWidth,
            i * this.lineDistance + this.lineStartY, this.stepNum, this.stepWidth, 2, i);
        quantumBit.eventBook = this.eventBook;
        quantumBit.codeArray = this.codeArray;
        quantumBit.init();
        this.svgElement.appendChild(quantumBit.lineG);
        this.quantumArray[i] = quantumBit;
    }
    //生成
    document.getElementById(this.parentId).style.width = this.boxWidth;
    document.getElementById(this.parentId).appendChild(this.svgElement);
    
    this.paramRegexp = "-?(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d+))\\s*(?:(?:(?:[+*-]\\s*(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d+)))|(?:\\/\\s*(?:pi|PI|(?:[1-9]\\d*(?:\\.\\d+)?)|(?:0\\.\\d*[1-9])))|(?:\\^\\d+))\\s*)*";

    this.oneRegexp = "^\\s*(H)\\s+(0|[1-9][0-9]*)\\s*$";
    this.twoRegexp = "^\\s*(RX|RZ|RY|CNOT)\\s+(0|[1-9][0-9]*)\\s*,\\s*((?:\"" + this.paramRegexp + "\")|(?:0|[1-9][0-9]*))\s*$";
    this.threeRegexp = "^\\s*(ISWAP|CR|TOFFOLI)\\s+((?:0|[1-9][0-9]*))\\s*,\\s*(0|[1-9][0-9]*)\\s*,\\s*((?:\"" + this.paramRegexp + "\")|(?:0|[1-9][0-9]*))\s*$";
    this.codeRegexpArray.push(this.oneRegexp);
    this.codeRegexpArray.push(this.twoRegexp);
    this.codeRegexpArray.push(this.threeRegexp);
    //设置模式
    if (this.analogType == 1) {
        this.pmeasureRegexp = "^\\s*(PMEASURE)\\s+((?:(?:0|[1-9][0-9]*)\\s*,\\s*)*(?:0|[1-9][0-9]*))\\s*$";
    } else if (this.analogType == 0) {
        this.pmeasureRegexp = "^\\s*(MEASURE)\\s+(0|[1-9][0-9]*)\\s*,\\s*(\\$(?:0|[1-9][0-9]*))\\s*$";
    }
}

SvgBoard.prototype.cleanCodeAndMeasure = function () {
    var that = this;
    $.each(this.codeArray, function(index, classicsBit) {
        that.svgElement.removeChild(classicsBit.quantumDoor.svgElement);
        classicsBit.quantumDoor = null;
        classicsBit.inactivation();
    });
    this.codeArray.splice(0, this.codeArray.length);
    console.log(this.measureArray);
    $.each(this.measureArray, function(index, measureBit) {
        if (measureBit.quantumDoor) {
            that.svgElement.removeChild(measureBit.quantumDoor.svgElement);
            measureBit.quantumDoor = null;
            measureBit.inactivation();
        }
    });
    this.measureArray.splice(0, this.measureArray.length);
}

//量子图形化转成代码
SvgBoard.prototype.quantum2Code = function () {
    this.codeArray.sort(ascClassics);
    console.log("quantum2Code");
    console.log(this.codeArray);
    var code = "";
    $.each(this.codeArray, function (index, door) {
        code += door.quantumDoor.toCode();
    });
    if (this.analogType == 1) {
        code += this.measure2Code();
    }
    console.log("quantum2Code:" + code);
    return code;
}

//量子测量图形转成代码
SvgBoard.prototype.measure2Code = function () {
    var code = "";
    if (this.measureArray.length > 0) {
        this.measureArray.sort(ascMeasure);
        console.log("measure2Code");
        console.log(this.measureArray);
        if (this.analogType == 1) {
            code += "PMEASURE ";
            $.each(this.measureArray, function (index, measure) {
                code += measure.lineIndex + ",";
            });
            code = code.substring(0, code.length - 1);
            code += "\n";
            console.log("measure2Code:" + code);
        } /*else if (this.analogType == 0) {
            $.each(this.measureArray, function (index, measure) {
                code += "MEASURE " + measure.lineIndex + "," + measure.quantumDoor.parameter;
                code += "\n";
            });
        }*/
    }
    return code;
}

//代码转成量子图形化
SvgBoard.prototype.code2quantum = function (code) {
    console.log("code2quantum -------------:----------------");
    console.log(this.codeArray);
    var that = this;
    if (this.quantum2Code() != code) {
        this.cleanCodeAndMeasure();
        var codeArr = code.split("\n");
        var xIndex = 0, yIndex = 0;
        
        $.each(codeArr, function(index, code) {
            console.log(index + "---:" + code);
            if (code) {
                var partsArray = that.explanationCode(code);
                if (partsArray.length == 0) {
                    error(messages.compile_error + (index + 1));
                    return false;
                }
                var lastParam = partsArray.pop();
                var instructions = partsArray.shift();
                var completeInstructions = instructions;
                var tempParam;
                if (lastParam.indexOf("\"") == 0) {
                    tempParam = lastParam.replace(/(^"\s*|\s*"$)|\s*/g, "");
                    if (tempParam.length > 32) {
                        error(messages.expression_32);
                        return false;
                    }
                    completeInstructions += tempParam;
                }
                console.log("instructions :" + instructions + ",completeInstructions : " + completeInstructions);

                var door = that.cloneDoor(completeInstructions, tempParam);
                if (!door) {
                    door = that.cloneDoor(instructions, tempParam);
                }
                if (!door) {
                    error(messages.compile_error + (index + 1));
                    return false;
                }
                
                if (door instanceof SingleDoor) {
                    if (door.isVoid) {
                        if (+lastParam < xIndex) {
                            yIndex ++;
                        }
                        xIndex = +lastParam;
                    } else {
                        var firstParam = partsArray.shift();
                        if (+firstParam < xIndex) {
                            yIndex++;
                        }
                        xIndex = +firstParam;
                    }
                    var classicsBit = that.getClassicsBit(xIndex, yIndex);
                    if (classicsBit == undefined) {
                        error(messages.task_status_syntactic_error);
                        return;
                    }
                    door.setClassicsBit(classicsBit);
                    door.inactivation();
                    svgBoard.codeArray.push(classicsBit);
                } else if (door instanceof MultiDoor) {

                    var firstParam = lastParam;
                    if (firstParam.indexOf("\"") == 0) {
                        firstParam = partsArray.pop();
                    }
                    if (+firstParam < xIndex) {
                        yIndex++;
                    } else {
                        $.each(partsArray, function (i, other) {
                            if (other < xIndex) {
                                yIndex++;
                                return;
                            }
                        });
                    }
                    xIndex = +firstParam;
                    var classicsBit = that.getClassicsBit(xIndex, yIndex);
                    if (classicsBit == undefined) {
                        error(messages.task_status_syntactic_error);
                        return;
                    }
                    door.setFirstClassicsBit(classicsBit);
                    svgBoard.codeArray.push(classicsBit);
                    $.each(partsArray, function (i, otherLine) {
                        var otherBit = that.getClassicsBit(otherLine, yIndex);
                        if (otherBit == undefined) {
                            error(messages.task_status_syntactic_error);
                            return;
                        }
                        classicsBit.quantumDoor.addOtherBit(otherBit);
                        classicsBit.quantumDoor.drawLine();
                        classicsBit.quantumDoor.inactivation();
                        if (xIndex < otherLine) {
                            xIndex = otherLine;
                        }
                    });
                } else if (door instanceof MeasureDoor) {
                    console.log("MeasureDoor partsArray" + partsArray);
                    if (that.analogType == 1) {
                        $.each(partsArray, function (index, liIndex) {
                            if (xIndex > liIndex) {
                                yIndex ++;
                            }
                            xIndex = liIndex;
                            var cb = that.getClassicsBit(xIndex, yIndex);
                            if (cb == undefined) {
                                error(messages.task_status_syntactic_error);
                                return;
                            }
                            var measureDoor = new MeasureDoor(door.code, door.svgId, door.width, door.height);
                            measureDoor.setClassicsBit(cb);
                            measureDoor.inactivation();
                            that.measureArray.push(cb);
                        });

                        if (xIndex > (+lastParam)) {
                            yIndex++;
                        }
                        xIndex = +lastParam;
                        var bit = that.getClassicsBit(xIndex, yIndex);
                        if (bit == undefined) {
                            error(messages.task_status_syntactic_error);
                            return;
                        }
                        door.setClassicsBit(bit);
                        door.inactivation();
                        that.measureArray.push(bit);
                    } else if (that.analogType == 0) {
                        door.parameter = lastParam;
                        var firstParam = partsArray.pop();
                        if (firstParam < xIndex) {
                            yIndex++;
                        }
                        xIndex = firstParam;
                        var bit = that.getClassicsBit(xIndex, yIndex);
                        if (bit == undefined) {
                            error(messages.task_status_syntactic_error);
                            return;
                        }
                        door.setClassicsBit(bit);
                        door.inactivation();
                        that.measureArray.push(bit);
                        that.codeArray.push(bit);
                    }
                }
                xIndex ++;
                if (xIndex == this.lineNum) {
                    xIndex = 0;
                    yIndex ++;
                }
            }
        });
    }
}

//去除比特门
SvgBoard.prototype.removeClassicsBit = function (classicsBit) {

    var that = this;
    var success = false;
    $.each(this.measureArray, function (index, bit) {
        if (bit.equals(classicsBit)) {
            that.measureArray.splice(index, 1);
            success = true;
            return false;
        }
    });
    if (!success || this.analogType == 0) {
        $.each(this.codeArray, function (index, bit) {
            if (bit.equals(classicsBit)) {
                that.codeArray.splice(index, 1);
                return false;
            }
        });
    }

}

//测量门校验
SvgBoard.prototype.measureCheckout = function (classicsBit) {

    var that = this;
    var success = true;
    
    $.each(this.measureArray, function (index, bit) {
        if (bit.lineIndex == classicsBit.lineIndex) {
            error(messages.measure_is_only);
            success = false;
            return false;
        }
    });
    
    if (success) {
        $.each(this.codeArray, function (index, bit) {
            if (bit.lineIndex == classicsBit.lineIndex && classicsBit.stepIndex < bit.stepIndex) {
                error(messages.measure_is_end);
                success = false;
                return false;
            }
            if (bit.quantumDoor instanceof MultiDoor) {
                $.each(bit.quantumDoor.otherBitArray, function (i, o) {
                    if (o.lineIndex == classicsBit.lineIndex && classicsBit.stepIndex < o.stepIndex) {
                        error(messages.measure_is_end);
                        success = false;
                        return false;
                    }
                });
            }
        });
    }
    return success;
}

//量子门校验
SvgBoard.prototype.quantumCheckout = function (classicsBit) {

    var that = this;
    var success = true;
    
    $.each(this.measureArray, function (index, bit) {
        if (bit.lineIndex == classicsBit.lineIndex && classicsBit.stepIndex > bit.stepIndex) {
            error(messages.measure_is_end);
            success = false;
            return false;
        }
    });

    return success;
}


//解释代码
SvgBoard.prototype.explanationCode = function (code) {

    var commaPatt = /,/g;
    var paramLength = 0;
    var matchArray = code.match(commaPatt);
    
    if (matchArray && matchArray.length) {
        paramLength = matchArray.length;
    }
    var pattStr = this.codeRegexpArray[paramLength];
    var patt = new RegExp(pattStr);
    var execArray = patt.exec(code);

    var partsArray = [];
    var testArray = [];
    if (pattStr != undefined &&       execArray) {
        console.log("explanationCode:------------------");
        for (var i = 0; i < execArray.length; i++) {
            console.log(execArray[i]);
        }
        for (i = 1; i < execArray.length; i++) {
            var line = execArray[i];
            if (testArray[line] != undefined) {
                testArray = [];
                break;
            } else {
                testArray[line] = line;
            }
            partsArray.push(line);
        }
    } else {
        patt = new RegExp(this.pmeasureRegexp);
        console.log(patt);
        execArray = patt.exec(code);
        
        if (execArray) {
            console.log("MEASURE OR PMEASURE-------:" + execArray);
            for (var i = 0; i < execArray.length; i++) {
                console.log(execArray[i]);
            }
            if (this.analogType == 1) {
                console.log("PMEASURE-------:" + execArray);
                partsArray.push(execArray[1]);
                
                var lineArray = execArray[2].split(",");

                for (var i = 0; i < lineArray.length; i++) {
                    var line = lineArray[i].replace("\s*", "");
                    
                    console.log(line);
                    if (testArray[line] != undefined) {
                        testArray = [];
                        break;
                    } else {
                        testArray[line] = line;
                    }
                    partsArray.push(line);
                }
            } else if (this.analogType == 0) {
                
                partsArray.push(execArray[1]);
                for (i = 1; i < execArray.length; i++) {
                    var line = execArray[i];
                    if (testArray[line] != undefined) {
                        testArray = [];
                        break;
                    } else {
                        testArray[line] = line;
                    }
                    partsArray.push(line);
                }
            }
        }
    }
    if (testArray.length == 0) {
        return [];
    }
    console.log("partsArray:" + partsArray);
    return partsArray;
}

SvgBoard.prototype.getClassicsBit = function (lineIndex, stepIndex) {
    if (lineIndex < this.lineNum && stepIndex < this.stepNum) {
        var quantumBit = this.quantumArray[lineIndex];
        console.log(quantumBit);
        return quantumBit.classicsArray[stepIndex];
    }
}

SvgBoard.prototype.cloneDoor = function (key, param) {
    var temp = this.doorMap[key];
    var door;
    if (temp) {
        if (temp instanceof SingleDoor) {
            door = new SingleDoor(temp.code, temp.svgId, temp.isVoid, temp.width, temp.height);
        } else if (temp instanceof MultiDoor) {
            door = new MultiDoor(temp.code, temp.svgId, temp.doorNum, temp.isVoid, temp.width, temp.height, temp.lineColour, temp.bothEnds);
        } else if (temp instanceof MeasureDoor) {
            door = new MeasureDoor(temp.code, temp.svgId, temp.width, temp.height);
        }
        if (!door.isVoid) {
            door.parameter = temp.parameter;
            if (!door.parameter) {
                door.parameter = param;
            }
        }
    }
    return door;
}

SvgBoard.prototype.getSvgXml = function () {
    return document.getElementById(this.parentId).innerHTML;
}

SvgBoard.prototype.canRun = function () {
    if (this.measureArray.length == 0) {
        error(messages.must_be_included_measurement);
        return false;
    }
    return true;
}

SvgBoard.prototype.getMeasures = function () {
    var values = "";
    $.each(this.measureArray, function (index, measure) {
        values += measure.lineIndex + ",";
    });
    if (values.length > 0) {
        values = values.substring(0, values.length - 1);
    }
    return values;
}
/**
 * 空比特门（既为经典比特位）
 * @param classicsBit 经典比特
 */
function VoidDoor(classicsBit) {
    this.svgElement = document.createElementNS(xmlns, "circle");
    this.svgElement.setAttribute("cx", classicsBit.x);
    this.svgElement.setAttribute("cy", classicsBit.y);
    this.svgElement.setAttribute("r", 10);
    this.svgElement.setAttribute("fill", "black");
    this.svgElement.setAttribute("stroke","none");
    this.svgElement.setAttribute("stroke-width","2");
    this.svgElement.setAttribute("onclick", "clickClassics(this)");
    $(this.svgElement).data("classicsBit", classicsBit);
}

VoidDoor.prototype.getSvgElement = function () {
    return this.svgElement;
}

//激活既被点击或获得焦点
VoidDoor.prototype.activate = function () {
    this.svgElement.setAttribute("fill", "#00BFF2");
    this.svgElement.setAttribute("r", "16");
    this.svgElement.setAttribute("stroke", "black");
}

//失活既失去焦点
VoidDoor.prototype.inactivation = function () {
    this.svgElement.setAttribute("fill", "black");
    this.svgElement.setAttribute("r", "10");
    this.svgElement.setAttribute("stroke", "none");
}

/**
 * 单比特门
 * @param code 代码
 * @param svgId svg图形Id
 * @param isVoid 是否为空
 * @param width 宽度
 * @param height 高度
 */
//parameter 参数
//classicsBit 所在的经典比特
function SingleDoor(code, svgId, isVoid, width, height) {
    this.code = code;
    this.svgId = svgId;
    this.isVoid = isVoid;
    this.width = width;
    this.height = height;
    this.quantumCode = "";
}

//设置经典比特点
SingleDoor.prototype.setClassicsBit = function (classicsBit) {
    if (classicsBit instanceof ClassicsBit) {
        this.classicsBit = classicsBit;
        
        this.svgElement = document.getElementById(this.svgId).cloneNode(true);
        this.svgElement.removeAttribute("id");
        this.svgElement.setAttribute('transform', "translate(" + (classicsBit.x - this.width / 2)
            + "," + (classicsBit.y - this.height / 2) + ")");
        this.svgElement.setAttribute("onclick", "dblclickDoor(this)");

        classicsBit.bitDoor.svgElement.parentNode.parentNode.appendChild(this.svgElement);
        this.activate();
        classicsBit.quantumDoor = this;
        $(this.svgElement).data("classicsBit", classicsBit);
    }
}

//激活既被点击或获得焦点
SingleDoor.prototype.activate = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:black;stroke-width:2");
}

//失活既失去焦点
SingleDoor.prototype.inactivation = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:none;");
}

//转成代码
SingleDoor.prototype.toCode = function () {
    if (!this.quantumCode) {
        this.quantumCode = this.code + " " + this.classicsBit.lineIndex;
        if (!this.isVoid) {
            this.quantumCode += ",\"" + this.parameter + "\"";
        }
        this.quantumCode += "\n";
    }
    return this.quantumCode;
}

/**
 * 多比特门
 * @param code 代码
 * @param svgId svg图形Id
 * @param doorNum 门数
 * @param isVoid 是否为空
 * @param width 宽度
 * @param height 高度
 * @param lineColour 多门之间线的颜色
 * @param bothEnds 两头
 */
//parameter 参数
//classicsBit 所在的经典比特
//otherOffset 其他点相对顶点的偏移
function MultiDoor(code, svgId, doorNum, isVoid, width, height, lineColour, bothEnds) {
    this.code = code;
    this.svgId = svgId;
    this.doorNum = doorNum;
    this.isVoid = isVoid;
    this.width = width;
    this.height = height;
    this.lineColour = lineColour;
    this.otherBitArray = [];
    this.bothEnds = bothEnds;
    this.quantumCode = "";
}

MultiDoor.prototype.setFirstClassicsBit = function (classicsBit) {
    if (classicsBit instanceof ClassicsBit) {
        this.firstClassicsBit = classicsBit;
        
        this.svgElement = document.getElementById(this.svgId).cloneNode(true);
        this.svgElement.removeAttribute("id");
        this.svgElement.setAttribute('transform', "translate(" + (classicsBit.x - this.width / 2)
            + "," + (classicsBit.y - this.height / 2) + ")");

        this.svgElement.setAttribute("onclick", "dblclickDoor(this)");
        
        classicsBit.bitDoor.svgElement.parentNode.parentNode.appendChild(this.svgElement);
        this.activate();

        classicsBit.quantumDoor = this;
        $(this.svgElement).data("classicsBit", classicsBit);
    }
}

MultiDoor.prototype.addOtherBit = function (classicsBit) {
    if (this.otherBitArray.length < this.doorNum - 1) {
        this.otherBitArray.push(classicsBit);
    }
}

//激活既被点击或获得焦点
MultiDoor.prototype.activate = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:black;stroke-width:2");
    $(this.svgElement).find("circle").attr("style", "stroke:black;stroke-width:2");
}

//失活既失去焦点
MultiDoor.prototype.inactivation = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:none;");
    $(this.svgElement).find("circle").attr("style", "stroke:none;");
}

//连线
MultiDoor.prototype.drawLine = function () {
    var that = this;
    console.log("drawLine otherBitArray:");
    console.log(this.otherBitArray);
    $.each(this.otherBitArray, function(index, classicsBit) {
        if (that.firstClassicsBit.stepIndex != classicsBit.stepIndex) {
            that.otherBitArray.splice(index, 1);
        } else {
            if (that.bothEnds) {
                var svgElement = document.getElementById(that.svgId).cloneNode(true);
                svgElement.removeAttribute("id");
                svgElement.setAttribute('transform', "translate(" + 0
                    + "," + (this.y - that.firstClassicsBit.y) + ")");

                that.svgElement.appendChild(svgElement);
            } else {
                var circle = document.createElementNS (xmlns, "circle");
                circle.setAttribute("cx", this.x - that.firstClassicsBit.x + parseInt(that.width / 2));
                circle.setAttribute("cy", this.y - that.firstClassicsBit.y + parseInt(that.height / 2));
                circle.setAttribute("r", 16);
                circle.setAttribute("fill", that.lineColour);
                that.svgElement.appendChild(circle);
            }
            var line = document.createElementNS(xmlns, "line");
            line.setAttribute("style", "stroke:" + that.lineColour + ";stroke-width:20");
            line.setAttribute("fill", that.lineColour);
            

            line.setAttribute("x1", parseInt(that.width / 2));
            var y1 = parseInt(that.height / 4);
            if (that.firstClassicsBit.lineIndex < this.lineIndex) {
                y1 = that.height - y1;
            }
            line.setAttribute("y1", y1);
            line.setAttribute("x2", parseInt(that.width / 2));
            var y2 = this.y - that.firstClassicsBit.y + that.height - parseInt(that.height / 4);
            if (that.firstClassicsBit.lineIndex < this.lineIndex) {
                y2 -= parseInt(that.height / 2);
            }
            line.setAttribute("y2", y2);
            that.svgElement.appendChild(line);
        }
    });
    this.activate();
}

//转成代码
MultiDoor.prototype.toCode = function () {
    if (!this.quantumCode) {

        if (this.otherBitArray.length == (this.doorNum - 1)) {
            this.quantumCode += this.code + " ";
            for (var i = 0; i < this.otherBitArray.length; i++) {
                this.quantumCode += this.otherBitArray[i].lineIndex + ",";
            }
            this.quantumCode += this.firstClassicsBit.lineIndex;
            if (!this.isVoid) {
                this.quantumCode += ",\"" + this.parameter + "\"";
            }
            this.quantumCode += "\n";
        }
    }
    return this.quantumCode;
}

/**
 * 测量门
 * @param code 代码
 * @param svgId svg图形Id
 * @param width 宽度
 * @param height 高度
 */
//classicsBit 所在的经典比特
//parameter 参数
function MeasureDoor(code, svgId, width, height) {
    this.code = code;
    this.svgId = svgId;
    this.width = width;
    this.height = height;
}


//设置经典比特点
MeasureDoor.prototype.setClassicsBit = function (classicsBit) {
    if (classicsBit instanceof ClassicsBit) {
        this.classicsBit = classicsBit;
        
        this.svgElement = document.getElementById(this.svgId).cloneNode(true);

        this.svgElement.removeAttribute("id");
        this.svgElement.setAttribute('transform', "translate(" + (classicsBit.x - this.width / 2)
            + "," + (classicsBit.y - this.height / 2) + ")");

        this.svgElement.setAttribute("onclick", "dblclickDoor(this)");

        classicsBit.bitDoor.svgElement.parentNode.parentNode.appendChild(this.svgElement);
        this.activate();
        classicsBit.quantumDoor = this;
        $(this.svgElement).data("classicsBit", classicsBit);
    }
}

//激活既被点击或获得焦点
MeasureDoor.prototype.activate = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:black;stroke-width:2");
}

//失活既失去焦点
MeasureDoor.prototype.inactivation = function () {
    $(this.svgElement).find("rect").attr("style", "stroke:none;");
}

//模拟类型为Monte-Carlo
MeasureDoor.prototype.toCode = function () {
    var quantumCode = "MEASURE " + this.classicsBit.lineIndex + "," + this.parameter;
    quantumCode += "\n";
    return quantumCode;
}

/**
 * 
 * 组合门
 * @param name 名称
 * @param xNum x方向个数
 * @param yNum y方向个数
 * @param doorArray 比特门数组
 */
function CombinationDoor(name, xNum, yNum, doorArray) {
    this.name = name;
    this.xNum = xNum;
    this.yNum = yNum;
    this.doorArray = doorArray;
}

//设置顶点坐标
CombinationDoor.prototype.addAllDoor = function (classicsBit, svgBoard) {
    if (classicsBit instanceof ClassicsBit) {
        
        $.each(this.doorArray, function (index, tempDoor) {
            var xIndex = classicsBit.stepIndex, yIndex = classicsBit.lineIndex;
            var offset = tempDoor.offset;
            xIndex += offset.x;
            yIndex += offset.y;
            var bit = svgBoard.getClassicsBit(yIndex, xIndex);
            if (bit == undefined) {
                error(messages.task_status_syntactic_error);
                return;
            }
            if (tempDoor instanceof SingleDoor) {
                var door = new SingleDoor(tempDoor.code, tempDoor.svgId, tempDoor.isVoid, tempDoor.width, tempDoor.height);
                if (!door.isVoid) {
                    door.parameter = tempDoor.parameter;
                }
                door.setClassicsBit(bit);
                door.inactivation();
                svgBoard.codeArray.push(bit);
            } else if (tempDoor instanceof MultiDoor) {
                var door = new MultiDoor(tempDoor.code, tempDoor.svgId, tempDoor.doorNum, tempDoor.isVoid, tempDoor.width,
                    tempDoor.height, tempDoor.lineColour, tempDoor.bothEnds);
                if (!door.isVoid) {
                    door.parameter = tempDoor.parameter;
                }
                door.setFirstClassicsBit(bit);
                svgBoard.codeArray.push(bit);
                $.each(tempDoor.otherOffset, function (i, other) {
                    xIndex += other.x;
                    yIndex += other.y;
                    var tempBit = svgBoard.getClassicsBit(yIndex, xIndex);
                    if (tempBit == undefined) {
                        error(messages.task_status_syntactic_error);
                        return;
                    }
                    door.addOtherBit(tempBit);
                    door.drawLine();
                    door.inactivation();
                });
            } else if (tempDoor instanceof MeasureDoor) {
                var door = new MeasureDoor(tempDoor.code, tempDoor.svgId, tempDoor.width, tempDoor.height);
                if (svgBoard.analogType == 1) {
                    door.setClassicsBit(bit);
                    door.inactivation();
                    svgBoard.measureArray.push(bit);
                } else if (svgBoard.analogType == 0) {
                    door.parameter = tempDoor.parameter;
                    door.setClassicsBit(bit);
                    door.inactivation();
                    svgBoard.measureArray.push(bit);
                    svgBoard.codeArray.push(bit);
                }
            }
        });
    }
}

//校验代码
CombinationDoor.prototype.checkCode = function (classicsBit, svgBoard) {
    var success = true;
    
    var yMax = classicsBit.lineIndex + this.yNum - 1;
    var xMax = classicsBit.stepIndex + this.xNum - 1;
    if (xMax >= svgBoard.stepNum || yMax >= svgBoard.lineNum) {
        error(messages.overflow_qubits);
        return false;
    }
    $.each(svgBoard.measureArray, function (index, bit) {
        
        if (classicsBit.lineIndex <= bit.lineIndex && bit.lineIndex <= yMax
            && classicsBit.stepIndex <= bit.stepIndex && bit.stepIndex <= xMax) {
            error(messages.point_already_exists);
            success = false;
            return false;
        } else if (classicsBit.stepIndex > bit.stepIndex && classicsBit.lineIndex <= bit.lineIndex && bit.lineIndex <= yMax) {
            error(messages.measure_is_end);
            success = false;
            return false;
        }
    });
    
    if (success) {
        $.each(svgBoard.codeArray, function (index, bit) {
            if (classicsBit.lineIndex <= bit.lineIndex && bit.lineIndex <= yMax
                && classicsBit.stepIndex <= bit.stepIndex && bit.stepIndex <= xMax) {
                error(messages.point_already_exists);
                success = false;
                return false;
            }
            if (bit.quantumDoor instanceof MultiDoor) {
                var firstBit = bit.quantumDoor.firstClassicsBit;
                var lastBit = bit.quantumDoor.otherBitArray[bit.quantumDoor.otherBitArray.length - 1];
                
                if (isOverlap(classicsBit.stepIndex, classicsBit.lineIndex, xMax, yMax,
                    firstBit.stepIndex, firstBit.lineIndex, lastBit.stepIndex, lastBit.lineIndex)) {
                    error(messages.point_already_exists);
                    success = false;
                    return false;
                }
            }
        });
    }
    return success;
}

//设置经典比特点
CombinationDoor.prototype.setClassicsBit = function (classicsBit) {
    if (classicsBit instanceof ClassicsBit) {
        this.classicsBit = classicsBit;
        
        this.svgElement = document.getElementById(this.svgId).cloneNode(true);

        this.svgElement.removeAttribute("id");
        this.svgElement.setAttribute('transform', "translate(" + (classicsBit.x - this.width / 2)
            + "," + (classicsBit.y - this.height / 2) + ")");

        this.svgElement.setAttribute("onclick", "dblclickDoor(this)");

        classicsBit.bitDoor.svgElement.parentNode.parentNode.appendChild(this.svgElement);
        this.activate();
        classicsBit.quantumDoor = this;
        $(this.svgElement).data("classicsBit", classicsBit);
    }
}
/**
 * 事件记录
 */
//previousEntity 上一次点击的对象
//currentEntity 当前点击的对象
function EventBook() {
    this.previousEntity = null
    this.currentEntity = null;
}

/**
 * 组合门中偏移点
 */
function ComDoorOffset(x, y) {
    this.x = x;
    this.y = y;
}
//------------------------------------------------------------------------------//
//-----------------------   global method   ------------------------------------//
//------------------------------------------------------------------------------//

function print(msg, type) {
    var defultType = "error";
    if (type) {
        defultType = type;
    }
    noty({
        text        : msg,
        type        : defultType,
        dismissQueue: true,
        layout      : 'topCenter',
        theme       : 'relax',
        timeout     : 1500
    });
}
//显示错误信息
function error(msg) {
    if (App && App.prompt) {
        App.prompt(msg);
    } else {
        print(msg);
    }
}
//显示成功信息
function success(msg) {
    print(msg, "success");
}
//显示一般信息
function information(msg) {
    print(msg, "information");
}

//点击经典比特事件
function clickClassics(classics) {
    var classicsBit = $(classics).data("classicsBit");
    classicsBit.activate(svgBoard);
}

//点击经典比特事件
function dblclickDoor(classics) {
    var classicsBit = $(classics).data("classicsBit");
    if (classicsBit && classicsBit.timer) {
        clearTimeout(classicsBit.timer);
    }
    if (classicsBit.eventBook.currentEntity) {
        if (classicsBit.eventBook.currentEntity.quantumDoor != null
            && classicsBit.eventBook.currentEntity.quantumDoor instanceof MultiDoor
            && !classicsBit.eventBook.currentEntity.equals(classicsBit) ) {
            if (classicsBit.eventBook.currentEntity.quantumDoor.otherBitArray.length < classicsBit.eventBook.currentEntity.quantumDoor.doorNum - 1
                        && classicsBit.eventBook.currentEntity.quantumDoor != classicsBit.quantumDoor) {
                error(messages.select_another_operation_point);
                return;
            }
        }
    }
    classicsBit.detail ++;
    if (classicsBit.eventBook.currentEntity) {
        var previousEntity = classicsBit.eventBook.currentEntity;
        previousEntity.inactivation();
        classicsBit.eventBook.previousEntity = previousEntity;
    }
    classicsBit.eventBook.currentEntity = classicsBit;
    classicsBit.quantumDoor.activate();
    classicsBit.timer = setTimeout(function() {
        classicsBit.detail = 0;
    }, 1000);
    if (classicsBit.detail == 2) {
        clearTimeout(classicsBit.timer);
        console.log("dblclickDoor happen to x:" + classicsBit.x + ",y:" + classicsBit.y + ",lineIndex:"
                        + classicsBit.lineIndex + ",stepIndex:" + classicsBit.stepIndex);
        classicsBit.delQuantumDoor(svgBoard);
        classicsBit.detail = 0;
        classicsBit.eventBook.currentEntity = null;
        console.log(classicsBit.eventBook);
    }
}


/**
 * 初始化命令MAP
 * @returns 
 */
function initDoorMap(lineNumber) {
    var map = {};
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    h.regex = "^H [0-" + lineNumber + "]$";
    map["H"] = h;
    
    var not = new SingleDoor("RX", "svg_NOT", false, 40, 40);
    not.parameter = "pi";
    not.regex = "^RX [0-" + lineNumber + "],\"pi\"$";
    map["RXpi"] = not;
    
    var zpi = new SingleDoor("RZ", "svg_ZPi", false, 40, 40);
    zpi.parameter = "pi";
    zpi.regex = "^RZ [0-" + lineNumber + "],\"pi[/2]?$";
    map["RZpi"] = zpi;
    
    var xpi2 = new SingleDoor("RX", "svg_XPi2", false, 40, 40);
    xpi2.parameter = "pi/2";
    xpi2.regex = "^RX [0-" + lineNumber + "],\"pi\/2\"$";
    map["RXpi/2"] = xpi2;
    
    var ypi2 = new SingleDoor("RY", "svg_YPi2", false, 40, 40);
    ypi2.parameter = "pi/2";
    xpi2.regex = "^RY [0-" + lineNumber + "],\"pi\/2\"$";
    map["RYpi/2"] = ypi2;
    
    var zpi2 = new SingleDoor("RZ", "svg_ZPi2", false, 40, 40);
    zpi2.parameter = "pi/2";
    map["RZpi/2"] = zpi2;
    
    var cnot = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    map["CNOT"] = cnot;
    
    var iswap = new MultiDoor("ISWAP", "svg_iSWAP", 2, false, 40, 40, "#89bc55", true);
    iswap.parameter = "pi/2";
    map["ISWAP"] = iswap;
    
    var toffoli = new MultiDoor("TOFFOLI", "svg_Toffoli", 3, true, 40, 40, "#f4ba19", false);
    map["TOFFOLI"] = toffoli;
    
    var pmeasure = new MeasureDoor("PMEASURE", "svg_Measure", 40, 40);
    map["PMEASURE"] = pmeasure;
    
    var rx = new SingleDoor("RX", "svg_RX", false, 40, 40);
    map["RX"] = rx;
    
    var ry = new SingleDoor("RY", "svg_RY", false, 40, 40);
    map["RY"] = ry;
    
    var rz = new SingleDoor("RZ", "svg_RZ", false, 40, 40);
    map["RZ"] = rz;
    
    var cr = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    map["CR"] = cr;
    
    var measure = new MeasureDoor("MEASURE", "svg_Measure", 40, 40);
    map["MEASURE"] = measure;
    
    var ghz2 = createGHZ2();
    map["GHZ2"] = ghz2;
    
    var ghz3 = createGHZ3();
    map["GHZ3"] = ghz3;
    
    var ghz6 = createGHZ6();
    map["GHZ6"] = ghz6;
    
    var qft3 = createQFT3();
    map["QFT3"] = qft3;
    
    var qft4 = createQFT4();
    map["QFT4"] = qft4;
    
    var cz = createCZ();
    map["CZ"] = cz;
    
    var z_CNOT = createz_CNOT();
    map["z_CNOT"] = z_CNOT;
    
    var swap = createSWAP();
    map["SWAP"] = swap;
    
    var h6 = createH6();
    map["H6"] = h6;
    return map;
}

/**
 * 量子转代码
 */
function quantum2Code(svgBoard) {
    $("#qcodeTextarea").text("");
    var readOnly = false;

    var content = svgBoard.quantum2Code();
    codeMirror = CodeMirror(document.getElementById("qcodeTextarea"), {
        value : content,
        lineNumbers : true,
        mode : "javascript",
        autoCloseBrackets : true,
        matchBrackets : true,
        showCursorWhenSelecting : true,
        theme : "monokai",
        readOnly : false,
        tabSize : 2
    });
    

}

/**
 * 从上到下，从左到右排序
 * @param c1
 * @param c2
 * @returns {number}
 */
function ascClassics(c1, c2) {
    if (c1.lineIndex < c2.lineIndex) {
        if (c1.stepIndex <= c2.stepIndex) {
            return -1;
        }
    } else if (c1.lineIndex == c2.lineIndex) {
        if (c1.stepIndex < c2.stepIndex) {
            return -1;
        }
    }
    else {
        if (c1.stepIndex < c2.stepIndex) {
            return -1;
        }
    }
    return 1;
}

/**
 * 从上到下，从左到右排序
 * @param m1
 * @param m2
 * @returns {number}
 */
function ascMeasure(m1, m2) {
    if (m1.lineIndex < m2.lineIndex) {
        if (m1.stepIndex <= m2.stepIndex) {
            return -1;
        }
    } else {
        if (m1.stepIndex < m2.stepIndex) {
            return -1;
        }
    }
    return 1;
}

/**
 * 是否重叠
 **/
function isOverlap(x1,y1,x2,y2,x3,y3,x4,y4) {
    var zx = Math.abs(x1 + x2 - x3 - x4);
    var x = Math.abs(x1 - x2) + Math.abs(x3 - x4);
    var zy = Math.abs(y1 + y2 - y3 - y4);
    var y = Math.abs(y1 - y2) + Math.abs(y3 - y4);
    return (zx <= x && zy <= y);
}

//------------------------------------------------------------------------------//
//-----------------------   CombinationDoor config   ---------------------------//
//--------- CombinationDoor constructed(name, xNum, yNum, doorArray) -----------//
//------------------------------------------------------------------------------//
function createGHZ2() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset = new ComDoorOffset(0, 0);
    h.offset = offset;
    doorArray.push(h);
    
    var cnot = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var coffset = new ComDoorOffset(1, 1);
    cnot.offset = coffset;
    var otherOffset = [];
    var otherOff = new ComDoorOffset(0, -1);
    otherOffset.push(otherOff);
    cnot.otherOffset = otherOffset;
    doorArray.push(cnot);
    
    var ghz2 = new CombinationDoor("GHZ2", 2, 2, doorArray);
    console.log(ghz2);
    return ghz2;
}

function createGHZ3() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var ho = new ComDoorOffset(0, 0);
    h.offset = ho;
    doorArray.push(h);
    
    var o = new ComDoorOffset(0, -1);
    for (var i = 1; i < 3; i++) {
        var cnot = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
        var co = new ComDoorOffset(i, i);
        cnot.offset = co;
        var otherOffset = [];
        otherOffset.push(o);
        cnot.otherOffset = otherOffset;
        doorArray.push(cnot);
    }
    var ghz3 = new CombinationDoor("GHZ3", 3, 3, doorArray);
    console.log(ghz3);
    return ghz3;
}

function createGHZ6() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var ho = new ComDoorOffset(0, 0);
    h.offset = ho;
    doorArray.push(h);
    
    var o = new ComDoorOffset(0, -1);
    for (var i = 1; i < 6; i++) {
        var cnot = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
        var co = new ComDoorOffset(i, i);
        cnot.offset = co;
        var otherOffset = [];
        otherOffset.push(o);
        cnot.otherOffset = otherOffset;
        doorArray.push(cnot);
    }
    var ghz6 = new CombinationDoor("GHZ6", 6, 6, doorArray);
    console.log(ghz6);
    return ghz6;
}

function createQFT3() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset = new ComDoorOffset(0, 0);
    h.offset = offset;
    doorArray.push(h);
    
    var cr0 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr0.parameter = "pi/2";
    var off0 = new ComDoorOffset(1, 0);
    cr0.offset = off0;
    var otherOffset0 = [];
    var otherOff0 = new ComDoorOffset(0, 1);
    otherOffset0.push(otherOff0);
    cr0.otherOffset = otherOffset0;
    doorArray.push(cr0);
    
    var cr1 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr1.parameter = "pi/4";
    var off1 = new ComDoorOffset(2, 0);
    cr1.offset = off1;
    var otherOffset1 = [];
    var otherOff1 = new ComDoorOffset(0, 2);
    otherOffset1.push(otherOff1);
    cr1.otherOffset = otherOffset1;
    doorArray.push(cr1);
    
    var h1 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset1 = new ComDoorOffset(3, 1);
    h1.offset = offset1;
    doorArray.push(h1);
    
    var cr2 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr2.parameter = "pi/2";
    var off2 = new ComDoorOffset(4, 1);
    cr2.offset = off2;
    var otherOffset2 = [];
    var otherOff2 = new ComDoorOffset(0, 1);
    otherOffset2.push(otherOff2);
    cr2.otherOffset = otherOffset2;
    doorArray.push(cr2);
    
    var h2 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset2 = new ComDoorOffset(5, 2);
    h2.offset = offset2;
    doorArray.push(h2);
    
    var qft3 = new CombinationDoor("QFT3", 6, 3, doorArray);
    console.log(qft3);
    return qft3;
}

function createQFT4() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset = new ComDoorOffset(0, 0);
    h.offset = offset;
    doorArray.push(h);
    
    var cr0 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr0.parameter = "pi/2";
    var off0 = new ComDoorOffset(1, 0);
    cr0.offset = off0;
    var otherOffset0 = [];
    var otherOff0 = new ComDoorOffset(0, 1);
    otherOffset0.push(otherOff0);
    cr0.otherOffset = otherOffset0;
    doorArray.push(cr0);
    
    var cr1 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr1.parameter = "pi/4";
    var off1 = new ComDoorOffset(2, 0);
    cr1.offset = off1;
    var otherOffset1 = [];
    var otherOff1 = new ComDoorOffset(0, 2);
    otherOffset1.push(otherOff1);
    cr1.otherOffset = otherOffset1;
    doorArray.push(cr1);
    
    var cr2 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr2.parameter = "pi/8";
    var off2 = new ComDoorOffset(3, 0);
    cr2.offset = off2;
    var otherOffset2 = [];
    var otherOff2 = new ComDoorOffset(0, 3);
    otherOffset2.push(otherOff2);
    cr2.otherOffset = otherOffset2;
    doorArray.push(cr2);
    
    var h1 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset1 = new ComDoorOffset(4, 1);
    h1.offset = offset1;
    doorArray.push(h1);
    
    var cr3 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr3.parameter = "pi/2";
    var off3 = new ComDoorOffset(5, 1);
    cr3.offset = off3;
    var otherOffset3 = [];
    var otherOff3 = new ComDoorOffset(0, 1);
    otherOffset3.push(otherOff3);
    cr3.otherOffset = otherOffset3;
    doorArray.push(cr3);
    
    var cr4 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr4.parameter = "pi/4";
    var off4 = new ComDoorOffset(6, 1);
    cr4.offset = off4;
    var otherOffset4 = [];
    var otherOff4 = new ComDoorOffset(0, 2);
    otherOffset4.push(otherOff4);
    cr4.otherOffset = otherOffset4;
    doorArray.push(cr4);
    
    var h2 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset2 = new ComDoorOffset(7, 2);
    h2.offset = offset2;
    doorArray.push(h2);
    
    var cr6 = new MultiDoor("CR", "svg_CR", 2, false, 40, 40, "#89bc55", false);
    cr6.parameter = "pi/2";
    var off6 = new ComDoorOffset(8, 2);
    cr6.offset = off6;
    var otherOffset6 = [];
    var otherOff6 = new ComDoorOffset(0, 1);
    otherOffset6.push(otherOff6);
    cr6.otherOffset = otherOffset6;
    doorArray.push(cr6);
    
    var h3 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset3 = new ComDoorOffset(9, 3);
    h3.offset = offset3;
    doorArray.push(h3);
    
    var qft4 = new CombinationDoor("QFT4", 10, 4, doorArray);
    console.log(qft4);
    return qft4;
}

function createCZ() {
    var doorArray = [];
    var h = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset = new ComDoorOffset(0, 1);
    h.offset = offset;
    doorArray.push(h);
    
    var cnot = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var off0 = new ComDoorOffset(1, 1);
    cnot.offset = off0;
    var otherOffset0 = [];
    var otherOff0 = new ComDoorOffset(0, -1);
    otherOffset0.push(otherOff0);
    cnot.otherOffset = otherOffset0;
    doorArray.push(cnot);

    var h1 = new SingleDoor("H", "svg_H", true, 40, 40);
    var offset1 = new ComDoorOffset(2, 1);
    h1.offset = offset1;
    doorArray.push(h1);
    
    var cz = new CombinationDoor("CZ", 3, 2, doorArray);
    console.log(cz);
    return cz;
}

function createz_CNOT() {
    var doorArray = [];
    var not = new SingleDoor("RX", "svg_NOT", false, 40, 40);
    not.parameter = "pi";
    var offset = new ComDoorOffset(0, 0);
    not.offset = offset;
    doorArray.push(not);
    
    var cr0 = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var off0 = new ComDoorOffset(1, 1);
    cr0.offset = off0;
    var otherOffset0 = [];
    var otherOff0 = new ComDoorOffset(0, -1);
    otherOffset0.push(otherOff0);
    cr0.otherOffset = otherOffset0;
    doorArray.push(cr0);

    var not1 = new SingleDoor("RX", "svg_NOT", false, 40, 40);
    not1.parameter = "pi";
    var offset1 = new ComDoorOffset(2, 0);
    not1.offset = offset1;
    doorArray.push(not1);
    
    var z_CNOT = new CombinationDoor("z_CNOT", 3, 2, doorArray);
    console.log(z_CNOT);
    return z_CNOT;
}

function createSWAP() {
    var doorArray = [];

    var cnot0 = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var off0 = new ComDoorOffset(0, 0);
    cnot0.offset = off0;
    var otherOffset0 = [];
    var otherOff0 = new ComDoorOffset(0, 1);
    otherOffset0.push(otherOff0);
    cnot0.otherOffset = otherOffset0;
    doorArray.push(cnot0);
    
    var cnot1 = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var off1 = new ComDoorOffset(1, 1);
    cnot1.offset = off1;
    var otherOffset1 = [];
    var otherOff1 = new ComDoorOffset(0, -1);
    otherOffset1.push(otherOff1);
    cnot1.otherOffset = otherOffset1;
    doorArray.push(cnot1);
    
    var cnot2 = new MultiDoor("CNOT", "svg_CNOT", 2, true, 40, 40, "#89bc55", false);
    var off2 = new ComDoorOffset(2, 0);
    cnot2.offset = off2;
    var otherOffset2 = [];
    var otherOff2 = new ComDoorOffset(0, 1);
    otherOffset2.push(otherOff2);
    cnot2.otherOffset = otherOffset2;
    doorArray.push(cnot2);
    
    var swap = new CombinationDoor("SWAP", 3, 2, doorArray);
    console.log(swap);
    return swap;
}

function createH6() {
    var doorArray = [];

    for (var i = 0; i < 6; i++) {
        var h = new SingleDoor("H", "svg_H", true, 40, 40);
        var offset = new ComDoorOffset(0, i);
        h.offset = offset;
        doorArray.push(h);
    }
    
    var h6 = new CombinationDoor("H6", 1, 6, doorArray);
    console.log(h6);
    return h6;
}