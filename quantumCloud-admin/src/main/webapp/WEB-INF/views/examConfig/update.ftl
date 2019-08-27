<#-----author:liuxiantao------->
<#-----date:2017-12-26------->
<@main.header title="版块管理">
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/examConfig/index.html">视频管理</a></li>
            <li class="active">增加</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                <form id="myFormId" method="post" class="form-horizontal" role="form" >
                    <input type="hidden" id="content" name="content"/>
                    <input type="hidden" id="questionid" name="questionid" value="${entity.questionid}">
                    <div class="box box-primary">
                        <div class="box-body">
                            <@main.warning/>
                            <div class="form-group">
                                <label for="resolutiontype" class="col-md-3 control-label no-padding-right"> 选择模式 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="resolutiontype" id="resolutiontype" onchange="changeModel(this)">
                                        <option value="0">普通模式</option>
                                        <option value="1">半公式模式</option>
                                        <option value="2">解析公式模式</option>
                                        <option value="3">公式模式</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-mode"></font><span id="errormsg-mode" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="blockid" class="col-md-3 control-label no-padding-right"> 选择版块 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="blockid" id="blockid" onchange="getVideo()">

                                        <option value="0">请选择</option>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-blockid"></font><span id="errormsg-blockid" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="vid" class="col-md-3 control-label no-padding-right"> 选择视频 </label>
                                <div class="col-md-6">
                                    <select class="form-control" name="vid" id="vid">
                                        <option value="0">请选择</option>
                                        <#if (videoList)?exists && ((videoList)?size != 0)>
                                            <#list videoList as videoList>
                                                <option value="${videoList.vid}">${videoList.title}</option>
                                            </#list>
                                        </#if>
                                    </select>
                                </div>
                                <div class="col-md-3"><font id="require-vid"></font><span id="errormsg-vid" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="content" class="col-md-3 control-label no-padding-right"> 题目</label>
                                <div class="col-md-6">
                                    <textarea id="subject" name="subject" ref="content" class="form-control">${(entity.content)!}</textarea>
                                    <span class="jx" style="display: none">${(entity.content)!}</span>
                                </div>
                                <button type="button" class="btn btn-default " onclick="addO(formulaTm)" id="formula" style="display: none">添加公式</button>
                                <div class="col-md-3"><font id="require-subject" ></font><span id="errormsg-subject" class="error"></span></div>
                            </div>

                            <div class="form-group file">
                                <label for="url" class="col-md-3 control-label no-padding-right"> 题目中包含的图片 </label>
                                <div class="col-md-6">
                                    <input type="hidden" id="pic" name="pic" value="${(entity.pic)!}">
                                    <img style="max-width: 152px;" src="${entity.pic}" alt="" onclick="$('#prewImg').click()" id="prewImg">
                                    <input type="file" id="examUrl" name="examUrl" ref="file" onchange="uploadpic(this)" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-url" ></font><span id="errormsg-url" class="error"></span></div>
                            </div>

                            <div class="btn-group btn-group-sm">
                                <button type="button" class="btn btn-default" onclick="addOption(this)">添加选项</button>
                                <div class="col-md-3"><font id="require-toplevel"></font><span id="errormsg-toplevel" class="error"></span></div>
                            </div>
                            <#assign opt={'0':'A','1':'B','2':'C','3':'D','4':'E','5':'F','6':'G','7':'H','8':'I'}>
                            <#if (answerList)?exists && ((answerList)?size != 0)>
                                <#list answerList as answerList>
                                    <div class="form-group">
                                        <label for="opt" class="col-md-3 control-label no-padding-right">${(opt[''+answerList_index])!}</label>
                                        <div class="col-md-6">
                                           <input type="text" id="answer_${(opt[''+answerList_index])!}" name="answer_${(opt[''+answerList_index])!}" value="${(answerList)!}" class="form-control"/>
                                           <span class="jx">${(answerList)!}</span>
                                        </div>
                                        <button type="button" class="btn btn-default answer" onclick="addO(assignment,this)" style="display: none">添加公式</button>
                                    </div>
                                </#list>
                            </#if>
                            <div class="form-group">
                                <label for="answer" class="col-md-3 control-label no-padding-right"> 添加正确答案 </label>
                                <div class="col-md-6">
                                    <input type="text" id="answer" name="answer" value="${(entity.answer)!}" class="form-control"/>
                                </div>
                                <div class="col-md-3"><font id="require-answer" ></font><span id="errormsg-answer" class="error"></span></div>
                            </div>

                            <div class="form-group">
                                <label for="answerdetail" class="col-md-3 control-label no-padding-right"> 答案解析</label>
                                <div class="col-md-6">
                                    <textarea id="answerdetail" name="answerdetail" ref="brief" class="form-control">${(entity.answerdetail)!}</textarea>
                                    <span class="jx" style="display: none">${(entity.answerdetail)!}</span>
                                </div>
                                <button type="button" class="btn btn-default" onclick="addO(analysisFormulaDet,'')" style="display: none" id="analysisFormula">添加公式</button>
                                <div class="col-md-3"><font id="require-answerdetail" ></font><span id="errormsg-answerdetail" class="error"></span></div>
                            </div>
                            <div class="form-group">
                                <div class="form-group">
                                    <div class="col-sm-5 col-xs-offset-3">
                                        <#--<div onclick="aaa()">转换</div>-->
                                        <button type="button" class="btn btn-sm btn-primary btn-save">确定</button>
                                        <a class="btn btn-sm btn-primary" href="${base }/examConfig/index.html">返回</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>


    </section>
    <!-- 模态框（Modal） -->
    <link rel="stylesheet" href="${base}/assets/mathjax/latex/images/style.min.css" type="text/css"/>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-show="true" data-backdrop="false" aria-hidden="true" >
        <div class="modal-content" style="width: 1000px;margin: 10px auto 0">
            <div id='contentRight' style="margin: 0">
                <h2 class='title' style="margin-top: 30px">
                    <a href='http://latex.91maths.com' target='_self'>\(\rm La\TeX\)</a>
                    ：在线数学公式编辑器
                </h2>
                <div class="center">
                    <div class="top" style="height: 180px;">
                        <div class="topLeft" style="margin: 0 auto;float:none;">
                            <div class="toolbar_wrapper">
                                <div class="toolbar" style="z-index:23">
                                    <div class="panel">
                                        <select title="公式颜色" onchange="EqEditor.insert(this.value, this.value.length-1); this.selectedIndex=0">
                                            <option value="">颜色...</option>
                                            <option value="{\color{Red} }" style="color:Red">红</option>
                                            <option value="{\color{Green} }" style="color:Green">绿</option>
                                            <option value="{\color{Blue} }" style="color:Blue">蓝</option>
                                            <option value="{\color{Yellow} }" style="color:Yellow">黄色</option>
                                            <option value="{\color{Cyan} }" style="color:Cyan">青色</option>
                                            <option value="{\color{Magenta} }" style="color:Magenta">品红色</option>
                                            <option value="{\color{Teal} }" style="color:Teal">蓝绿色</option>
                                            <option value="{\color{Purple} }" style="color:Purple">紫色</option>
                                            <option value="{\color{DarkBlue} }" style="color:DarkBlue">深蓝色</option>
                                            <option value="{\color{DarkRed} }" style="color:DarkRed">深红色</option>
                                            <option value="{\color{Orange} }" style="color:Orange">橙色</option>
                                            <option value="{\color{DarkOrange} }" style="color:DarkOrange">深橙色</option>
                                            <option value="{\color{Golden} }" style="color:Golden">金色</option>
                                            <option value="{\color{Pink} }" style="color:Pink">粉红色</option>
                                            <option value="{\color{DarkGreen} }" style="color:DarkGreen">深绿色</option>
                                            <option value="{\color{Orchid} }" style="color:Orchid">淡紫色</option>
                                            <option value="{\color{Emerald} }" style="color:Emerald">翡翠绿</option>
                                        </select>
                                    </div>
                                    <div class="panel">
                                        <select title="算子" onchange="EqEditor.insert(this.value); this.selectedIndex=0;">
                                            <option selected="selected" value="" style="color:#8080ff">算子&hellip;</option>
                                            <option value="\displaystyle">display style</option>
                                            <optgroup label="Operators">
                                                <option value="\arg">arg</option>
                                                <option value="\det">det</option>
                                                <option value="\dim">dim</option>
                                                <option value="\gcd">gcd</option>
                                                <option value="\hom">hom</option>
                                                <option value="\ker">ker</option>
                                                <option value="\Pr">Pr</option>
                                                <option value="\sup">sup</option>
                                            </optgroup>
                                        </select>
                                    </div>
                                    <div class="panel">
                                        <select title="三角函数" onchange="EqEditor.insert(this.value); this.selectedIndex=0;">
                                            <option selected="selected" value="" style="color:#8080ff">三角函数&hellip;</option>
                                            <option value="\sin">sin</option>
                                            <option value="\cos">cos</option>
                                            <option value="\tan">tan</option>
                                            <option value="\csc">csc</option>
                                            <option value="\sec">sec</option>
                                            <option value="\cot">cot</option>
                                            <option value="\sinh">sinh</option>
                                            <option value="\cosh">cosh</option>
                                            <option value="\tanh">tanh</option>
                                            <option value="\coth">coth</option>
                                        </select>
                                    </div>
                                    <div class="panel">
                                        <select title="反三角函数" onchange="EqEditor.insert(this.value); this.selectedIndex=0;">
                                            <option selected="selected" value="" style="color:#8080ff">反三角函数&hellip;</option>
                                            <option value="\arcsin">arcsin</option>
                                            <option value="\arccos">arccos</option>
                                            <option value="\arctan">arctan</option>
                                            <option value="\sin^{-1}">sin-1</option>
                                            <option value="\cos^{-1}">cos-1</option>
                                            <option value="\tan^{-1}">tan-1</option>
                                            <option value="\sinh^{-1}">sinh-1</option>
                                            <option value="\cosh^{-1}">cosh-1</option>
                                            <option value="\tanh^{-1}">tanh-1</option>
                                        </select>
                                    </div>
                                    <div class="panel">
                                        <select title="对数函数" onchange="EqEditor.insert(this.value); this.selectedIndex=0;">
                                            <option selected="selected" value="" style="color:#8080ff">对数函数&hellip;</option>
                                            <option value="\exp">exp</option>
                                            <option value="\lg">lg</option>
                                            <option value="\ln">ln</option>
                                            <option value="\log">log</option>
                                            <option value="\log_{e}">log e</option>
                                            <option value="\log_{10}">log 10</option>
                                        </select>
                                    </div>
                                    <div class="panel">
                                        <select title="极限表达" onchange="EqEditor.insert(this.value); this.selectedIndex=0;">
                                            <option selected="selected" value="" style="color:#8080ff">极限&hellip;</option>
                                            <option value="\lim">limit</option>
                                            <option value="\liminf">liminf</option>
                                            <option value="\limsup">limsup</option>
                                            <option value="\max">maximum</option>
                                            <option value="\min">minimum</option>
                                            <option value="\infty">infinite</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="toolbar_wrapper">
                                <div class="toolbar" style="z-index:22">
                                    <div class="panel" id="panel14" style="height:23px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/style.gif" width="106" height="184" border="0" title="公式风格" alt="Style Panel" usemap="#style_map"/>
                                        <map name="style_map" id="style_map">
                                            <area shape="rect" alt="\boldsymbol{\alpha\beta\gamma123}" title="Math 加粗 Greek" coords="0,0,50,20" onclick="EqEditor.insert('\\boldsymbol{}')"/>
                                            <area shape="rect" alt="\mathbf{Abc123}" title="Math 加粗" coords="0,23,50,43" onclick="EqEditor.insert('\\mathbf{}')"/>
                                            <area shape="rect" alt="\mathit{Abc123}" title="Math 斜体" coords="0,46,50,66" onclick="EqEditor.insert('\\mathit{}')"/>
                                            <area shape="rect" alt="\mathrm{Abc123}" title="Math Roman" coords="0,69,50,89" onclick="EqEditor.insert('\\mathrm{}')"/>
                                            <area shape="rect" alt="\mathfrak{Abc123}" title="Math Fraktur" coords="0,92,50,112" onclick="EqEditor.insert('\\mathfrak{}')"/>
                                            <area shape="rect" alt="\mathbb{Abc123}" title="Math Blackboard" coords="0,115,50,135" onclick="EqEditor.insert('\\mathbb{}')"/>
                                            <area shape="rect" alt="\textup{Abc 123}" title="Text Upright" coords="53,0,103,20" onclick="EqEditor.insert('\\textup{}')"/>
                                            <area shape="rect" alt="\textbf{Abc 123}" title="Text 加粗" coords="53,23,103,43" onclick="EqEditor.insert('\\textbf{}')"/>
                                            <area shape="rect" alt="\textit{Abc 123}" title="Text 斜体" coords="53,46,103,66" onclick="EqEditor.insert('\\textit{}')"/>
                                            <area shape="rect" alt="\textrm{Abc 123}" title="Text Roman" coords="53,69,103,89" onclick="EqEditor.insert('\\textrm{}')"/>
                                            <area shape="rect" alt="\textsl{Abc 123}" title="Text Slanted" coords="53,92,103,112" onclick="EqEditor.insert('\\textsl{}')"/>
                                            <area shape="rect" alt="\texttt{Abc 123}" title="Text Typewriter" coords="53,115,103,135" onclick="EqEditor.insert('\\texttt{}')"/>
                                            <area shape="rect" alt="\textsc{Abc 123}" title="Text Small Caps" coords="53,138,103,158" onclick="EqEditor.insert('\\textsc{}')"/>
                                            <area shape="rect" alt="\emph{Abc 123}" title="Text Emphasis" coords="53,161,103,181" onclick="EqEditor.insert('\\emph{}')"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel13" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/spaces.gif" width="31" height="68" border="0" title="间隔" alt="Spaces Panel" usemap="#spaces_map"/>
                                        <map name="spaces_map" id="spaces_map">
                                            <area shape="rect" alt="\square\underline{\,}\square" title="thin space" coords="0,0,28,14" onclick="EqEditor.insert('\\,')"/>
                                            <area shape="rect" alt="\square\underline{\:}\square" title="medium space" coords="0,17,28,31" onclick="EqEditor.insert('\\:')"/>
                                            <area shape="rect" alt="\square\underline{\;}\square" title="thick space" coords="0,34,28,48" onclick="EqEditor.insert('\\;')"/>
                                            <area shape="rect" alt="\square\!\square" title="negative space" coords="0,51,28,65" onclick="EqEditor.insert('\\!')"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel4" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/binary.gif" width="68" height="238" border="0" title="Binary" alt="Binary Panel" usemap="#binary_map"/>
                                        <map name="binary_map" id="binary_map">
                                            <area shape="rect" alt="\pm" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\mp" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\times" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\ast" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\div" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\setminus" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\dotplus" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\amalg" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\dagger" coords="0,136,14,150"/>
                                            <area shape="rect" alt="\ddagger" coords="0,153,14,167"/>
                                            <area shape="rect" alt="\wr" coords="0,170,14,184"/>
                                            <area shape="rect" alt="\diamond" coords="0,187,14,201"/>
                                            <area shape="rect" alt="\circledcirc" coords="0,204,14,218"/>
                                            <area shape="rect" alt="\circledast" coords="0,221,14,235"/>
                                            <area shape="rect" alt="\cap" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\Cap" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\sqcap" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\wedge" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\barwedge" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\triangleleft" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\lozenge" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\circ" coords="17,119,31,133"/>
                                            <area shape="rect" alt="\square" coords="17,136,31,150"/>
                                            <area shape="rect" alt="\triangle" coords="17,153,31,167"/>
                                            <area shape="rect" alt="\triangledown" coords="17,170,31,184"/>
                                            <area shape="rect" alt="\ominus" coords="17,187,31,201"/>
                                            <area shape="rect" alt="\oslash" coords="17,204,31,218"/>
                                            <area shape="rect" alt="\circleddash" coords="17,221,31,235"/>
                                            <area shape="rect" alt="\cup" coords="34,0,48,14"/>
                                            <area shape="rect" alt="\Cup" coords="34,17,48,31"/>
                                            <area shape="rect" alt="\sqcup" coords="34,34,48,48"/>
                                            <area shape="rect" alt="\vee" coords="34,51,48,65"/>
                                            <area shape="rect" alt="\veebar" coords="34,68,48,82"/>
                                            <area shape="rect" alt="\triangleright" coords="34,85,48,99"/>
                                            <area shape="rect" alt="\blacklozenge" coords="34,102,48,116"/>
                                            <area shape="rect" alt="\bullet" coords="34,119,48,133"/>
                                            <area shape="rect" alt="\blacksquare" coords="34,136,48,150"/>
                                            <area shape="rect" alt="\blacktriangle" coords="34,153,48,167"/>
                                            <area shape="rect" alt="\blacktriangledown" coords="34,170,48,184"/>
                                            <area shape="rect" alt="\oplus" coords="34,187,48,201"/>
                                            <area shape="rect" alt="\otimes" coords="34,204,48,218"/>
                                            <area shape="rect" alt="\odot" coords="34,221,48,235"/>
                                            <area shape="rect" alt="\cdot" coords="51,0,65,14"/>
                                            <area shape="rect" alt="\uplus" coords="51,17,65,31"/>
                                            <area shape="rect" alt="\bigsqcup" coords="51,34,65,48"/>
                                            <area shape="rect" alt="\bigtriangleup" coords="51,51,65,65"/>
                                            <area shape="rect" alt="\bigtriangledown" coords="51,68,65,82"/>
                                            <area shape="rect" alt="\star" coords="51,85,65,99"/>
                                            <area shape="rect" alt="\bigstar" coords="51,102,65,116"/>
                                            <area shape="rect" alt="\bigcirc" coords="51,119,65,133"/>
                                            <area shape="rect" alt="\bigoplus" coords="51,136,65,150"/>
                                            <area shape="rect" alt="\bigotimes" coords="51,153,65,167"/>
                                            <area shape="rect" alt="\bigodot" coords="51,170,65,184"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel16" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/symbols.gif" width="68" height="136" border="0" title="Symbols" alt="Symbols Panel" usemap="#symbols_map"/>
                                        <map name="symbols_map" id="symbols_map">
                                            <area shape="rect" alt="\therefore" title="所以" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\because" title="因为" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\cdots" title="horizontal dots" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\ddots" title="diagonal dots" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\vdots" title="vertical dots" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\S" title="section" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\P" title="paragraph" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\copyright" title="copyright" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\partial" title="partial" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\imath" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\jmath" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\Re" title="real" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\Im" title="imaginary" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\forall" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\exists" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\top" coords="17,119,31,133"/>
                                            <area shape="rect" alt="\mathbb{P}" title="prime" coords="34,0,48,14"/>
                                            <area shape="rect" alt="\mathbb{N}" title="natural" coords="34,17,48,31"/>
                                            <area shape="rect" alt="\mathbb{Z}" title="integers" coords="34,34,48,48"/>
                                            <area shape="rect" alt="\mathbb{I}" title="irrational" coords="34,51,48,65"/>
                                            <area shape="rect" alt="\mathbb{Q}" title="rational" coords="34,68,48,82"/>
                                            <area shape="rect" alt="\mathbb{R}" title="real" coords="34,85,48,99"/>
                                            <area shape="rect" alt="\mathbb{C}" title="complex" coords="34,102,48,116"/>
                                            <area shape="rect" alt="\angle" coords="51,0,65,14"/>
                                            <area shape="rect" alt="\measuredangle" coords="51,17,65,31"/>
                                            <area shape="rect" alt="\sphericalangle" coords="51,34,65,48"/>
                                            <area shape="rect" alt="\varnothing" coords="51,51,65,65"/>
                                            <area shape="rect" alt="\infty" coords="51,68,65,82"/>
                                            <area shape="rect" alt="\mho" coords="51,85,65,99"/>
                                            <area shape="rect" alt="\wp" coords="51,102,65,116"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel6" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/foreign.gif" width="34" height="136" border="0" title="Foreign" alt="Foreign Panel" usemap="#foreign_map"/>
                                        <map name="foreign_map" id="foreign_map">
                                            <area shape="rect" alt="\aa" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\ae" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\l" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\o" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\oe" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\ss" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\$" title="Dollar" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\cent" title="Cent" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\AA" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\AE" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\L" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\O" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\OE" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\SS" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\pounds" title="Pound" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\euro" title="Euro" coords="17,119,31,133"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel15" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/subsupset.gif" width="34" height="153" border="0" title="Subsupset" alt="Subsupset Panel" usemap="#subsupset_map"/>
                                        <map name="subsupset_map" id="subsupset_map">
                                            <area shape="rect" alt="\sqsubset" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\sqsubseteq" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\subset" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\subseteq" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\nsubseteq" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\subseteqq" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\nsubseteq" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\in" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\notin" coords="0,136,14,150"/>
                                            <area shape="rect" alt="\sqsupset" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\sqsupseteq" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\supset" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\supseteq" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\nsupseteq" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\supseteqq" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\nsupseteqq" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\ni" coords="17,119,31,133"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel1" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/accents.gif" width="34" height="119" border="0" title="Accents" alt="Accents Panel" usemap="#accents_map"/>
                                        <map name="accents_map" id="accents_map">
                                            <area shape="rect" alt="a'" coords="0,0,14,14" onclick="EqEditor.insert('{}\'')"/>
                                            <area shape="rect" alt="\dot{a}" coords="0,17,14,31" onclick="EqEditor.insert('\\dot{}')"/>
                                            <area shape="rect" alt="\hat{a}" coords="0,34,14,48" onclick="EqEditor.insert('\\hat{}')"/>
                                            <area shape="rect" alt="\grave{a}" coords="0,51,14,65" onclick="EqEditor.insert('\\grave{}')"/>
                                            <area shape="rect" alt="\tilde{a}" coords="0,68,14,82" onclick="EqEditor.insert('\\tilde{}')"/>
                                            <area shape="rect" alt="\bar{a}" coords="0,85,14,99" onclick="EqEditor.insert('\\bar{}')"/>
                                            <area shape="rect" alt="\not{a}" coords="0,102,14,116"/>
                                            <area shape="rect" alt="a''" coords="17,0,31,14" onclick="EqEditor.insert('{}\'\'')"/>
                                            <area shape="rect" alt="\ddot{a}" coords="17,17,31,31" onclick="EqEditor.insert('\\ddot{}')"/>
                                            <area shape="rect" alt="\check{a}" coords="17,34,31,48" onclick="EqEditor.insert('\\check{}')"/>
                                            <area shape="rect" alt="\acute{a}" coords="17,51,31,65" onclick="EqEditor.insert('\\acute{}')"/>
                                            <area shape="rect" alt="\breve{a}" coords="17,68,31,82" onclick="EqEditor.insert('\\breve{}')"/>
                                            <area shape="rect" alt="\vec{a}" coords="17,85,31,99" onclick="EqEditor.insert('\\vec{}')"/>
                                            <area shape="rect" alt="a^{\circ}" title="degrees" coords="17,102,31,116" onclick="EqEditor.insert('^{\\circ}',0)"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel2" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/accents_ext.gif" width="25" height="170" border="0" title="Accents_ext" alt="Accents_ext Panel" usemap="#accents_ext_map"/>
                                        <map name="accents_ext_map" id="accents_ext_map">
                                            <area shape="rect" alt="\widetilde{abc}" coords="0,0,22,14" onclick="EqEditor.insert('\\widetilde{}',11)"/>
                                            <area shape="rect" alt="\widehat{abc}" coords="0,17,22,31" onclick="EqEditor.insert('\\widehat{}',9)"/>
                                            <area shape="rect" alt="\overleftarrow{abc}" coords="0,34,22,48" onclick="EqEditor.insert('\\overleftarrow{}',15)"/>
                                            <area shape="rect" alt="\overrightarrow{abc}" coords="0,51,22,65" onclick="EqEditor.insert('\\overrightarrow{}',16)"/>
                                            <area shape="rect" alt="\overline{abc}" coords="0,68,22,82" onclick="EqEditor.insert('\\overline{}',10)"/>
                                            <area shape="rect" alt="\underline{abc}" coords="0,85,22,99" onclick="EqEditor.insert('\\underline{}',11)"/>
                                            <area shape="rect" alt="\overbrace{abc}" coords="0,102,22,116" onclick="EqEditor.insert('\\overbrace{}',11)"/>
                                            <area shape="rect" alt="\underbrace{abc}" coords="0,119,22,133" onclick="EqEditor.insert('\\underbrace{}',12)"/>
                                            <area shape="rect" alt="\overset{a}{abc}" coords="0,136,22,150" onclick="EqEditor.insert('\\overset{}{}',9,11)"/>
                                            <area shape="rect" alt="\underset{a}{abc}" coords="0,153,22,167" onclick="EqEditor.insert('\\underset{}{}',10,12)"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel3" style="height:34px;margin-left:10px;">
                                        <img src="${base}/assets/mathjax/latex/images/panels/arrows.gif" width="56" height="170" border="0" title="Arrows" alt="Arrows Panel" usemap="#arrows_map"/>
                                        <map name="arrows_map" id="arrows_map">
                                            <area shape="rect" alt="x \mapsto x^2" title="\mapsto" coords="0,0,25,14"/>
                                            <area shape="rect" alt="\leftarrow" coords="0,17,25,31"/>
                                            <area shape="rect" alt="\Leftarrow" coords="0,34,25,48"/>
                                            <area shape="rect" alt="\leftrightarrow" coords="0,51,25,65"/>
                                            <area shape="rect" alt="\leftharpoonup" coords="0,68,25,82"/>
                                            <area shape="rect" alt="\leftharpoondown" coords="0,85,25,99"/>
                                            <area shape="rect" alt="\leftrightharpoons" coords="0,102,25,116"/>
                                            <area shape="rect" alt="\xleftarrow[text]{long}" coords="0,119,25,133" onclick="EqEditor.insert('\\xleftarrow[]{}',12)"/>
                                            <area shape="rect" alt="\overset{a}{\leftarrow}" coords="0,136,25,150" onclick="EqEditor.insert('\\overset{}{\\leftarrow}',9)"/>
                                            <area shape="rect" alt="\underset{a}{\leftarrow}" coords="0,153,25,167" onclick="EqEditor.insert('\\underset{}{\\leftarrow}',10)"/>
                                            <area shape="rect" alt="n \to" coords="28,0,53,14"/>
                                            <area shape="rect" alt="\rightarrow" coords="28,17,53,31"/>
                                            <area shape="rect" alt="\Rightarrow" coords="28,34,53,48"/>
                                            <area shape="rect" alt="\Leftrightarrow" coords="28,51,53,65"/>
                                            <area shape="rect" alt="\rightharpoonup" coords="28,68,53,82"/>
                                            <area shape="rect" alt="\rightharpoondown" coords="28,85,53,99"/>
                                            <area shape="rect" alt="\rightleftharpoons" coords="28,102,53,116"/>
                                            <area shape="rect" alt="\xrightarrow[text]{long}" coords="28,119,53,133" onclick="EqEditor.insert('\\xrightarrow[]{}',13)"/>
                                            <area shape="rect" alt="\overset{a}{\rightarrow}" coords="28,136,53,150" onclick="EqEditor.insert('\\overset{}{\\rightarrow}',9)"/>
                                            <area shape="rect" alt="\underset{a}{\rightarrow}" coords="28,153,53,167" onclick="EqEditor.insert('\\underset{}{\\rightarrow}',10)"/>
                                        </map>
                                    </div>
                                </div>
                            </div>
                            <div class="toolbar_wrapper">
                                <div class="toolbar" style="z-index:21">
                                    <div class="panel" id="panel11" style="height:28px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/operators.gif" width="168" height="140" border="0" title="Operators" alt="Operators Panel" usemap="#operators_map"/>
                                        <map name="operators_map" id="operators_map">
                                            <area shape="rect" alt="x^a" title="superscript" coords="0,0,25,25" onclick="EqEditor.insert('^{}',2,0)"/>
                                            <area shape="rect" alt="x_a" title="subscript" coords="0,28,25,53" onclick="EqEditor.insert('_{}',2,0)"/>
                                            <area shape="rect" alt="x_a^b" coords="0,56,25,81" onclick="EqEditor.insert('_{}^{}',2,0)"/>
                                            <area shape="rect" alt="{x_a}^b" coords="0,84,25,109" onclick="EqEditor.insert('{_{}}^{}',1)"/>
                                            <area shape="rect" alt="_a^{b}\textrm{C}" title="_{a}^{b}\textrm{C}" coords="0,112,25,137" onclick="EqEditor.insert('_{}^{}\\textrm{}',2,14)"/>
                                            <area shape="rect" alt="\frac{a}{b}" title="fraction" coords="28,0,53,25" onclick="EqEditor.insert('\\frac{}{}',6)"/>
                                            <area shape="rect" alt="x\tfrac{a}{b}" title="tiny fraction" coords="28,28,53,53" onclick="EqEditor.insert('\\tfrac{}{}',7)"/>
                                            <area shape="rect" alt="\frac{\partial }{\partial x}" coords="28,56,53,81" onclick="EqEditor.insert('\\frac{\\partial }{\\partial x}',15)"/>
                                            <area shape="rect" alt="\frac{\partial^2 }{\partial x^2}" coords="28,84,53,109" onclick="EqEditor.insert('\\frac{\\partial^2 }{\\partial x^2}',17)"/>
                                            <area shape="rect" alt="\frac{\mathrm{d} }{\mathrm{d} x}" coords="28,112,53,137" onclick="EqEditor.insert('\\frac{\\mathrm{d} }{\\mathrm{d} x}',17)"/>
                                            <area shape="rect" alt="\int" coords="56,0,81,25"/>
                                            <area shape="rect" alt="\int_a^b" title="\int_{}^{}" coords="56,28,81,53" onclick="EqEditor.insert('\\int_{}^{}',6,1000)"/>
                                            <area shape="rect" alt="\oint" coords="56,56,81,81" onclick="EqEditor.insert('\\oint')"/>
                                            <area shape="rect" alt="\oint_a^b" title="\oint_{}^{}" coords="56,84,81,109" onclick="EqEditor.insert('\\oint_{}^{}',7,1000)"/>
                                            <area shape="rect" alt="\iint_a^b" title="\iint_{}^{}" coords="56,112,81,137" onclick="EqEditor.insert('\\iint_{}^{}',7,1000)"/>
                                            <area shape="rect" alt="\bigcap" coords="84,0,109,25"/>
                                            <area shape="rect" alt="\bigcap_a^b" title="\bigcap_{}^{}" coords="84,28,109,53" onclick="EqEditor.insert('\\bigcap_{}^{}',9,1000)"/>
                                            <area shape="rect" alt="\bigcup" coords="84,56,109,81" onclick="EqEditor.insert('\\bigcup')"/>
                                            <area shape="rect" alt="\bigcup_a^b" title="\bigcup_{}^{}" coords="84,84,109,109" onclick="EqEditor.insert('\\bigcup_{}^{}',9,1000)"/>
                                            <area shape="rect" alt="\displaystyle \lim_{x \to 0}" title="\lim_{x \to 0}" coords="84,112,109,137" onclick="EqEditor.insert('\\lim_{}')"/>
                                            <area shape="rect" alt="\sum" coords="112,0,137,25"/>
                                            <area shape="rect" alt="\sum_a^b" title="\sum_{}^{}" coords="112,28,137,53" onclick="EqEditor.insert('\\sum_{}^{}',6)"/>
                                            <area shape="rect" alt="\sqrt{x}" title="\sqrt{}" coords="112,56,137,81" onclick="EqEditor.insert('\\sqrt{}',6,6)"/>
                                            <area shape="rect" alt="\sqrt[n]{x}" title="\sqrt[]{}" coords="112,84,137,109" onclick="EqEditor.insert('\\sqrt[]{}',6,8)"/>
                                            <area shape="rect" alt="\prod" coords="140,0,165,25"/>
                                            <area shape="rect" alt="\prod_a^b" title="\prod_{}^{}" coords="140,28,165,53" onclick="EqEditor.insert('\\prod_{}^{}',7,1000)"/>
                                            <area shape="rect" alt="\coprod" coords="140,56,165,81"/>
                                            <area shape="rect" alt="\coprod_a^b" title="\coprod_{}^{}" coords="140,84,165,109" onclick="EqEditor.insert('\\coprod_{}^{}',9,1000)"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel5" style="height:28px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/brackets.gif" width="56" height="140" border="0" title="Brackets" alt="Brackets Panel" usemap="#brackets_map"/>
                                        <map name="brackets_map" id="brackets_map">
                                            <area shape="rect" alt="\left (\: \right )" title="\left ( \right )" coords="0,0,25,25" onclick="EqEditor.insert('\\left (  \\right )',8)"/>
                                            <area shape="rect" alt="\left [\: \right ]" title="\left ( \right )" coords="0,28,25,53" onclick="EqEditor.insert('\\left [  \\right ]',8)"/>
                                            <area shape="rect" alt="\left\{\: \right\}" title="\left\{ \right\}" coords="0,56,25,81" onclick="EqEditor.insert('\\left \\{  \\right \\}',9)"/>
                                            <area shape="rect" alt="\left |\: \right |" title="\left | \right |" coords="0,84,25,109" onclick="EqEditor.insert('\\left |  \\right |',8)"/>
                                            <area shape="rect" alt="\left \{ \cdots \right." title="\left \{ \right." coords="0,112,25,137" onclick="EqEditor.insert('\\left \\{  \\right.',9)"/>
                                            <area shape="rect" alt="\left \|\: \right \|" title="\left \| \right \|" coords="28,0,53,25" onclick="EqEditor.insert('\\left \\|  \\right \\|',9)"/>
                                            <area shape="rect" alt="\left \langle \: \right \rangle" title="\left \langle \right \rangle" coords="28,28,53,53" onclick="EqEditor.insert('\\left \\langle  \\right \\rangle',14)"/>
                                            <area shape="rect" alt="\left \lfloor \: \right \rfloor" title="\left \lfloor \right \rfloor" coords="28,56,53,81" onclick="EqEditor.insert('\\left \\lfloor  \\right \\rfloor',14)"/>
                                            <area shape="rect" alt="\left \lceil \: \right \rceil" title="\left \lceil \right \rceil" coords="28,84,53,109" onclick="EqEditor.insert('\\left \\lceil  \\right \\rceil',13)"/>
                                            <area shape="rect" alt="\left. \cdots \right \}" title="\left. \right \}" coords="28,112,53,137" onclick="EqEditor.insert('\\left.  \\right \\}',7)"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel8" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/greeklower.gif" width="68" height="136" border="0" title="Greeklower" alt="Greeklower Panel" usemap="#greeklower_map"/>
                                        <map name="greeklower_map" id="greeklower_map">
                                            <area shape="rect" alt="\alpha" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\epsilon" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\theta" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\lambda" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\pi" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\sigma" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\phi" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\omega" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\beta" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\varepsilon" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\vartheta" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\mu" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\varpi" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\varsigma" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\varphi" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\gamma" coords="34,0,48,14"/>
                                            <area shape="rect" alt="\zeta" coords="34,17,48,31"/>
                                            <area shape="rect" alt="\iota" coords="34,34,48,48"/>
                                            <area shape="rect" alt="\nu" coords="34,51,48,65"/>
                                            <area shape="rect" alt="\rho" coords="34,68,48,82"/>
                                            <area shape="rect" alt="\tau" coords="34,85,48,99"/>
                                            <area shape="rect" alt="\chi" coords="34,102,48,116"/>
                                            <area shape="rect" alt="\delta" coords="51,0,65,14"/>
                                            <area shape="rect" alt="\eta" coords="51,17,65,31"/>
                                            <area shape="rect" alt="\kappa" coords="51,34,65,48"/>
                                            <area shape="rect" alt="\xi" coords="51,51,65,65"/>
                                            <area shape="rect" alt="\varrho" coords="51,68,65,82"/>
                                            <area shape="rect" alt="\upsilon" coords="51,85,65,99"/>
                                            <area shape="rect" alt="\psi" coords="51,102,65,116"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel9" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/greekupper.gif" width="34" height="102" border="0" title="Greekupper" alt="Greekupper Panel" usemap="#greekupper_map"/>
                                        <map name="greekupper_map" id="greekupper_map">
                                            <area shape="rect" alt="\Gamma" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\Theta" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\Xi" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\Sigma" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\Phi" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\Omega" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\Delta" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\Lambda" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\Pi" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\Upsilon" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\Psi" coords="17,68,31,82"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel12" style="height:34px">
                                        <img src="${base}/assets/mathjax/latex/images/panels/relations.gif" width="51" height="221" border="0" title="Relations" alt="Relations Panel" usemap="#relations_map"/>
                                        <map name="relations_map" id="relations_map">
                                            <area shape="rect" alt="&lt;" coords="0,0,14,14"/>
                                            <area shape="rect" alt="\leq" coords="0,17,14,31"/>
                                            <area shape="rect" alt="\leqslant" coords="0,34,14,48"/>
                                            <area shape="rect" alt="\nless" coords="0,51,14,65"/>
                                            <area shape="rect" alt="\nleqslant" coords="0,68,14,82"/>
                                            <area shape="rect" alt="\prec" coords="0,85,14,99"/>
                                            <area shape="rect" alt="\preceq" coords="0,102,14,116"/>
                                            <area shape="rect" alt="\ll" coords="0,119,14,133"/>
                                            <area shape="rect" alt="\vdash" coords="0,136,14,150"/>
                                            <area shape="rect" alt="\smile" title="smile" coords="0,153,14,167"/>
                                            <area shape="rect" alt="\models" coords="0,170,14,184"/>
                                            <area shape="rect" alt="\mid" coords="0,187,14,201"/>
                                            <area shape="rect" alt="\bowtie" coords="0,204,14,218"/>
                                            <area shape="rect" alt="&gt;" coords="17,0,31,14"/>
                                            <area shape="rect" alt="\geq" coords="17,17,31,31"/>
                                            <area shape="rect" alt="\geqslant" coords="17,34,31,48"/>
                                            <area shape="rect" alt="\ngtr" coords="17,51,31,65"/>
                                            <area shape="rect" alt="\ngeqslant" coords="17,68,31,82"/>
                                            <area shape="rect" alt="\succ" coords="17,85,31,99"/>
                                            <area shape="rect" alt="\succeq" coords="17,102,31,116"/>
                                            <area shape="rect" alt="\gg" coords="17,119,31,133"/>
                                            <area shape="rect" alt="\dashv" coords="17,136,31,150"/>
                                            <area shape="rect" alt="\frown" title="frown" coords="17,153,31,167"/>
                                            <area shape="rect" alt="\perp" coords="17,170,31,184"/>
                                            <area shape="rect" alt="\parallel" title="parallel" coords="17,187,31,201"/>
                                            <area shape="rect" alt="\Join" coords="17,204,31,218"/>
                                            <area shape="rect" alt="=" coords="34,0,48,14"/>
                                            <area shape="rect" alt="\doteq" coords="34,17,48,31"/>
                                            <area shape="rect" alt="\equiv" title="equivalent" coords="34,34,48,48"/>
                                            <area shape="rect" alt="\neq" coords="34,51,48,65"/>
                                            <area shape="rect" alt="\not\equiv" title="not equivalent" coords="34,68,48,82"/>
                                            <area shape="rect" alt="\overset{\underset{\mathrm{def}}{}}{=}" title="define" coords="34,85,48,99"/>
                                            <area shape="rect" alt="\sim" coords="34,102,48,116"/>
                                            <area shape="rect" alt="\approx" coords="34,119,48,133"/>
                                            <area shape="rect" alt="\simeq" coords="34,136,48,150"/>
                                            <area shape="rect" alt="\cong" coords="34,153,48,167"/>
                                            <area shape="rect" alt="\asymp" coords="34,170,48,184"/>
                                            <area shape="rect" alt="\propto" title="proportional to" coords="34,187,48,201"/>
                                        </map>
                                    </div>
                                    <div class="panel" id="panel10" style="height:34px;margin-left:7px;">
                                        <img src="${base}/assets/mathjax/latex/images/panels/matrix.gif" width="102" height="170" border="0" title="Matrix" alt="Matrix Panel" usemap="#matrix_map"/>
                                        <map name="matrix_map" id="matrix_map">
                                            <area shape="rect" alt="\begin{matrix} \cdots \\ \cdots \\ \end{matrix}" title="\begin{matrix} ... \end{matrix}" coords="0,0,31,31" onclick="EqEditor.makeArrayMatrix('','','')"/>
                                            <area shape="rect" alt="\begin{pmatrix} \cdots \\ \cdots \end{pmatrix}" title="\begin{pmatrix} ... \end{pmatrix}" coords="0,34,31,65" onclick="EqEditor.makeArrayMatrix('p','','')"/>
                                            <area shape="rect" alt="\begin{vmatrix} \cdots \\ \cdots \end{vmatrix}" title="\begin{vmatrix} ... \end{vmatrix}" coords="0,68,31,99" onclick="EqEditor.makeArrayMatrix('v','','')"/>
                                            <area shape="rect" alt="\begin{Vmatrix} \cdots \\  \cdots \end{Vmatrix}" title="\begin{Vmatrix} ... \end{Vmatrix}" coords="0,102,31,133" onclick="EqEditor.makeArrayMatrix('V','','')"/>
                                            <area shape="rect" alt="\left.\begin{matrix} \cdots \\ \cdots \end{matrix}\right|" title="\left.\begin{matrix}... \end{matrix}\right|" coords="0,136,31,167" onclick="EqEditor.makeArrayMatrix('','\\left.','\\right|')"/>
                                            <area shape="rect" alt="\begin{bmatrix} \cdots \\ \cdots \end{bmatrix}" title="\being{bmatrix} ... \end{bmatrix}" coords="34,0,65,31" onclick="EqEditor.makeArrayMatrix('b','','')"/>
                                            <area shape="rect" alt="\bigl(\begin{smallmatrix} \cdots \\ \cdots \end{smallmatrix}\bigr)" title="\bigl(\begin{smallmatrix} ... \end{smallmatrix}\bigr)" coords="34,34,65,65" onclick="EqEditor.makeArrayMatrix('small','\\bigl(','\\bigr)')"/>
                                            <area shape="rect" alt="\begin{Bmatrix} \cdots \\ \cdots \end{Bmatrix}" title="\begin{Bmatrix} ... \end{Bmatrix}" coords="34,68,65,99" onclick="EqEditor.makeArrayMatrix('B','','')"/>
                                            <area shape="rect" alt="\left\{\begin{matrix} \cdots \\ \cdots \end{matrix}\right." title="\begin{Bmatrix} ... \end{matrix}" coords="34,102,65,133" onclick="EqEditor.makeArrayMatrix('','\\left\\{','\\right.')"/>
                                            <area shape="rect" alt="\left.\begin{matrix} \cdots \\ \cdots \end{matrix}\right\}" title="\begin{matrix} ... \end{Bmatrix}" coords="34,136,65,167" onclick="EqEditor.makeArrayMatrix('','\\left.','\\right\\}')"/>
                                            <area shape="rect" alt=" \binom{n}{r}" coords="68,0,99,31" onclick="EqEditor.insert('\\binom{}{}')"/>
                                            <area shape="rect" alt="\begin{cases}..,x= \\..,x=\end{cases}" title="\begin{cases} ... \end{cases}" coords="68,34,99,65" onclick="EqEditor.makeEquationsMatrix('cases', true, true)"/>
                                            <area shape="rect" alt="\begin{align*} y&amp;=\cdots \\ &amp;+\cdots \end{align*}" title="\begin{align} ... \end{align}" coords="68,68,99,99" onclick="EqEditor.makeEquationsMatrix('align', false)"/>
                                        </map>
                                    </div>
                                </div>
                            </div>
                            <div class="toolbar_wrapper">
                                <div class="toolbar" style="z-index:20">
                                    <div class="panel">
                                        <img id="undobutton" src="${base}/assets/mathjax/latex/images/buttons/undo-x.gif" alt="undo" title="撤销"/>
                                        <img id="redobutton" src="${base}/assets/mathjax/latex/images/buttons/redo-x.gif" alt="redo" title="恢复"/>
                                        <input type="button" class="lightbluebutton" onclick="EqEditor.clearText()" value="清除" title="清除编辑器窗口"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id='topRight' style="display:none;">
                            <ul>
                                <li>示例：</li>
                                <li>
                                    <div class='taobao'>代数</div>
                                    <div class='latexUrl' style='left:-302px;'>
                                        <a href="http://latex.91maths.com/mb/?\left(x-1\right)\left(x+3\right)" target='_self'>$$ \left(x-1\right)\left(x+3\right) $$</a>
                                        <a href="http://latex.91maths.com/mb/?\sqrt{a^2+b^2}" target='_self'>$$ \sqrt{a^2+b^2} $$</a>
                                        <a href='http://latex.91maths.com/mb/?x = a_0 + \frac{1}{a_1 + \frac{1}{a_2 + \frac{1}{a_3 + a_4}}}' target='_self'>$$ x=a_0+\frac{1}{a_1+\frac{1}{a_2+\frac{1}{a_3+a_4}}} $$</a>
                                        <a href='http://latex.91maths.com/mb/?x = a_0 + \frac{1}{\displaystyle a_1 + \frac{1}{\displaystyle a_2 + \frac{1}{\displaystyle a_3 + a_4}}}' target='_self'>$$ x=a_0+\frac{1}{\displaystyle a_1+\frac{1}{\displaystyle a_2+\frac{1}{\displaystyle a_3+a_4}}} $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>几何</div>
                                    <div class='latexUrl' style='left:-361px;'>
                                        <a href='http://latex.91maths.com/mb/?\overrightarrow{AB}' target='_self'>$$ \overrightarrow{AB} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\overleftrightarrow{AB}' target='_self'>$$ \overleftrightarrow{AB} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\widehat{AB}' target='_self'>$$ \widehat{AB} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\Delta A B C' target='_self'>$$ \Delta A B C $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>集合</div>
                                    <div class='latexUrl' style='left:-422px;'>
                                        <a href='http://latex.91maths.com/mb/?\bigcup_{i=1}^{n}{X_i}' target='_self'>$$ \bigcup_{i=1}^{n}{X_i} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\bigcup_{i=1}^{n}{X_i}' target='_self'>$$ \bigcap_{i=1}^{n}{X_i} $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>微积分</div>
                                    <div class='latexUrl' style='left:-482px;'>
                                        <a href="http://latex.91maths.com/mb/?\frac{\partial y}{\partial x}" target='_self'>$$ \frac{\partial y}{\partial x} $$</a>
                                        <a href="http://latex.91maths.com/mb/?\frac{d}{dx}c^n=nx^{n-1}" target='_self'>$$\frac{d}{dx}c^n=nx^{n-1} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\frac{d}{dx}e^{ax}=a\,e^{ax}' target='_self'>$$ \frac{d}{dx}e^{ax}=a\,e^{ax} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\frac{d}{dx}\ln(x)=\frac{1}{x}' target='_self'>$$ \frac{d}{dx}\ln(x)=\frac{1}{x} $$</a>
                                        <a href="http://latex.91maths.com/mb/?\frac{d}{dx}\sin x=\cos x" target='_self'>$$ \frac{d}{dx}\sin x=\cos x $$</a>
                                        <a href="http://latex.91maths.com/mb/?\frac{d}{dx}\cos x=-\sin x" target='_self'>$$ \frac{d}{dx}\cos x=-\sin x $$</a>
                                        <a href='http://latex.91maths.com/mb/?\frac{d}{dx}\tan x=\sec^2 x' target='_self'>$$ \frac{d}{dx}\tan x=\sec^2 x $$</a>
                                        <a href='http://latex.91maths.com/mb/?\frac{d}{dx}\cot x=-\csc^2 x' target='_self'>$$ \frac{d}{dx}\cot x=-\csc^2 x $$</a>
                                        <a href='http://latex.91maths.com/mb/?\int u \frac{dv}{dx}\,dx=uv-\int \frac{du}{dx}v\,dx' target='_self'>$$ \int u \frac{dv}{dx}\,dx=uv-\int \frac{du}{dx}v\,dx $$</a>
                                </li>
                                <li>
                                    <div class='taobao'>矩阵</div>
                                    <div class='latexUrl' style='left:-242px;'>
                                        <a href="http://latex.91maths.com/mb/?\begin{pmatrix}%0da_{11}%20&%20a_{12}%20\\%0da_{21}%20&%20a_{22}%0d\end{pmatrix}" target='_self'>$$ \begin{pmatrix}a_{11}&a_ {12}\\a_{21}&a_ {22}\end{pmatrix} $$</a>
                                        <a href="http://latex.91maths.com/mb/?\begin{pmatrix}%0da_{11}%20&%20a_{12}%20&%20a_{13}\\%0da_{21}%20&%20a_{22}%20&%20a_{23}\\%0da_{31}%20&%20a_{32}%20&%20a_{33}%0d\end{pmatrix}" target='_self'>$$ \begin{pmatrix}a_{11}&a_ {12}&a_ {13}\\a_{21}&a_ {22}&a_ {23}\\a_{31}&a_ {32}&a_ {33}\end{pmatrix} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\begin{pmatrix}%0da_{11}%20&%20\cdots%20&%20a_{1n}\\%0d\vdots%20&%20\ddots%20&%20\vdots\\%0da_{m1}%20&%20\cdots%20&%20a_{mn}%0d\end{pmatrix}' target='_self'>$$ \begin{pmatrix}a_{11}&\cdots &a_ {1n}\\\vdots&\ddots&\vdots\\a_{m1}&\cdots &a_ {mn}\end{pmatrix} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\begin{pmatrix}%0d1%20&%200%20\\%0d0%20&%201%0d\end{pmatrix}' target='_self'>$$ \begin{pmatrix}1 &0 \\0 &1 \end{pmatrix} $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>统计学</div>
                                    <div class='latexUrl' style='left:-301px;'>
                                        <a href="http://latex.91maths.com/mb/?{^n}C_r" target='_self'>$$ {^n}C_r $$</a>
                                        <a href="http://latex.91maths.com/mb/?\frac{n!}{r!(n-r)!}" target='_self'>$$ \frac{n!}{r!(n-r)!} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\sum_{i=1}^{n}{X_i}' target='_self'>$$ \sum_{i=1}^{n}{X_i} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\sum_{i=1}^{n}{X_i^2}' target='_self'>$$ \sum_{i=1}^{n}{X_i^2} $$</a>
                                        <a href="http://latex.91maths.com/mb/?\sum_{i=1}^{n}{(X_i - \overline{X})^2}" target='_self'>$$ \sum_{i=1}^{n}{(X_i - \overline{X})^2} $$</a>
                                        <a href="http://latex.91maths.com/mb/?X_1, \cdots,X_n" target='_self'>$$ X_1, \cdots,X_n $$</a>
                                        <a href='http://latex.91maths.com/mb/?\frac{x-\mu}{\sigma}' target='_self'>$$ \frac{x-\mu}{\sigma} $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>三角</div>
                                    <div class='latexUrl' style='left:-361px;'>
                                        <a href="http://latex.91maths.com/mb/?\cos^{-1}\theta" target='_self'>$$ \cos^{-1}\theta $$</a>
                                        <a href="http://latex.91maths.com/mb/?\sin^{-1}\theta" target='_self'>$$ \sin^{-1}\theta $$</a>
                                        <a href='http://latex.91maths.com/mb/?e^{i \theta}' target='_self'>$$ e^{i \theta} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\left(\frac{\pi}{2}-\theta \right )' target='_self'>$$ \left(\frac{\pi}{2}-\theta \right ) $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>化学</div>
                                    <div class='latexUrl' style='left:-421px;'>
                                        <a href="http://latex.91maths.com/mb/?_{10}^{5}C^{16}" target='_self'>$$ _{10}^{5}C^{16} $$</a>
                                        <a href="http://latex.91maths.com/mb/?2H_2 + O_2 \xrightarrow{n,m}2H_2O" target='_self'>$$ 2H_2 + O_2 \xrightarrow{n,m}2H_2O $$</a>
                                        <a href='http://latex.91maths.com/mb/?A\underset{b}{\overset{a}{\longleftrightarrow}}B' target='_self'>$$ A\underset{b}{\overset{a}{\longleftrightarrow}}B $$</a>
                                        <a href='http://latex.91maths.com/mb/?A\underset{0}{\overset{a}{\rightleftarrows}}B' target='_self'>$$ A\underset{0}{\overset{a}{\rightleftarrows}}B $$</a>
                                        <a href="http://latex.91maths.com/mb/?A\underset{0^{\circ}C }{\overset{100^{\circ}C}{\rightleftarrows}}B" target='_self'>$$ A\underset{0^{\circ}C }{\overset{100^{\circ}C}{\rightleftarrows}}B $$</a>
                                    </div>
                                </li>
                                <li>
                                    <div class='taobao'>物理</div>
                                    <div class='latexUrl' style='left:-482px;'>
                                        <a href="http://latex.91maths.com/mb/?\vec{F}=m\vec{a}" target='_self'>$$ \vec{F}=m\vec{a} $$</a>
                                        <a href="http://latex.91maths.com/mb/?e=m c^2" target='_self'>$$ e=m c^2 $$</a>
                                        <a href='http://latex.91maths.com/mb/?\vec{F}=m \frac{d \vec{v}}{dt} + \vec{v}\frac{dm}{dt}' target='_self'>$$ \vec{F}=m \frac{d \vec{v}}{dt} + \vec{v}\frac{dm}{dt} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\oint \vec{F} \cdot d\vec{s}=0' target='_self'>$$ \oint \vec{F} \cdot d\vec{s}=0 $$</a>
                                        <a href="http://latex.91maths.com/mb/?\vec{F}_g=-F\frac{m_1 m_2}{r^2} \vec{e}_r" target='_self'>$$ \vec{F}_g=-F\frac{m_1 m_2}{r^2} \vec{e}_r $$</a>
                                        <a href="http://latex.91maths.com/mb/?\vec{R}=\frac{m_1 \vec{r}_1 + m_2 \vec{r}_2}{m_1+m_2}" target='_self'>$$ \vec{R}=\frac{m_1 \vec{r}_1 + m_2 \vec{r}_2}{m_1+m_2} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\psi (t)=\hat{\psi}e^{i(\omega t\, \pm\, \theta)}' target='_self'>$$ \psi (t)=\hat{\psi}e^{i(\omega t\, \pm\, \theta)} $$</a>
                                        <a href='http://latex.91maths.com/mb/?\sum_i \hat{\psi_i} cos(\alpha_i \pm \omega t)' target='_self'>$$ \sum_i \hat{\psi_i} cos(\alpha_i \pm \omega t) $$</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div id="input">
                        <textarea name="latex_formula" id="latex_formula" rows="8" spellcheck="false" onchange="UpdateMath(this.value)" oninput="UpdateMath(this.value)" onpropertychange="UpdateMath(this.value)" onkeydown="UpdateMath(this.value)" style="position: relative;z-index: 9999;"></textarea>
                    </div>
                    <div class="msg">
                        实时预览\(\rm\TeX\) 数学公式：
                        <div class="help-tip">
                            <p>选择数学符号或手动输入后，请敲击键盘Enter键输入完成数学公式表达式</p>
                        </div>
                    </div>
                    <div class="box" id="box" style="visibility:hidden">
                        <div id="MathOutput" class="output">$$ {}$$</div>
                    </div>
                    <div class="msg" style="display: none">
                        URL：<span id="URLOutput" class='url'></span>
                        <!--<div class="help-tip">-->
                        <!--<p>本数学公式URL链接，复制/粘帖即可获得本公式。</p>-->
                        <!--</div>-->
                    </div>
                </div>

            </div>
            <div id='leftColumn'>

                <div class='advertContent'>
                    <script type="text/javascript">
                        (function() {
                                    var s = "_" + Math.random().toString(36).slice(2);
                                    document.write('<div id="' + s + '"></div>');
                                    (window.slotbydup = window.slotbydup || []).push({
                                        id: '6203683',
                                        container: s,
                                        size: '160,600',
                                        display: 'inlay-fix'
                                    });
                                }
                        )();
                        (function() {
                                    var s = "_" + Math.random().toString(36).slice(2);
                                    document.write('<div id="' + s + '"></div>');
                                    (window.slotbydup = window.slotbydup || []).push({
                                        id: '6211923',
                                        container: s,
                                        size: '160,600',
                                        display: 'inlay-fix'
                                    });
                                }
                        )();
                    </script>
                </div>
            </div>
            <div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> <button type="button" class="btn btn-primary"  id="subFuc">确定</button> </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script src="https://cdn.bootcss.com/mathjax/2.7.4/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript" src="${base}/assets/mathjax/latex/js/latex.min.js"></script>
<#--javascript include here-->
<script type="text/javascript" src="${validateJS}/videoExamConfig.js"></script>
<script type="text/x-mathjax-config">
        //Mathjax相关配置
        MathJax.Hub.Config({
            showProcessingMessages: false,  //关闭js加载过程信息
            messageStyle: "none",  //不显示信息
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath:  [ ["$", "$"] ],   //行内公式选择$
                displayMath: [ ["$$","$$"] ],  //段内公式选择$$
                skipTags: ['script', 'noscript', 'style', 'pre','code','a'],  //避开某些标签
                ignoreClass:"comment-content"  //避开含该Class的标签
            },
            "HTML-CSS": {
                availableFonts: ["STIX","TeX"],   //可选字体
                imageFont: null   //去除图片加载
            }
        });

    </script>

<script type="text/javascript">

    var content = "";
    var count = 0;

    var answerMap = new Map();
    answerMap.put(0,"A");
    answerMap.put(1,"B");
    answerMap.put(2,"C");
    answerMap.put(3,"D");
    answerMap.put(4,"E");
    answerMap.put(5,"F");
    answerMap.put(6,"G");
    answerMap.put(7,"H");
    answerMap.put(8,"I");

    function addOption(obj) {
        count = $("input[id^='answer_']").length;
        var html = ' <div class=\"form-group\">' +
                '               <label for="opt" class="col-md-3 control-label no-padding-right">'+answerMap.get(count)+' </label>' +
                '              <div class="col-md-6">' +
                '                   <input type="text" id="answer_'+answerMap.get(count)+'" name="answer_'+answerMap.get(count)+'" value="'+answerMap.get(count)+'." class="form-control"/>' +
                '                </div>';
        if($("#resolutiontype").val() == 1 || $("#resolutiontype").val() == "3" ) {
            html += '<button type="button" class="btn btn-default" onclick="addO('+"assignment"+')">添加公式</button>'
        }
        html += '</div>';

        $(obj).parent().after(html);
        count ++;
    }

    var currentInputId;

    function addO(type,obj) {
        currentInputId = $(obj).prev().find("input").attr("id");
        $("#subFuc").bind("click",type);
        $("#myModal").modal("show");
    }

    function assignment() {
        if($("#latex_formula").val() != null && $("#latex_formula").val() != '') {
//            var elInput = $("#"+currentInputId);
//            var startPos = elInput.selectionStart;
//            var endPos = elInput.selectionEnd;
//            if (startPos === undefined || endPos === undefined) return
//            var txt = elInput.value;
//            var result = txt.substring(0, startPos) + " $" +$("#latex_formula").val()+"$" + " " + txt.substring(endPos)
//            elInput.value = result;
//            elInput.focus();
//            elInput.selectionStart = startPos + insertTxt.length;
//            elInput.selectionEnd = startPos + insertTxt.length;
            $("#"+currentInputId).val($("#"+currentInputId).val()+ " $" +$("#latex_formula").val()+"$" + " ")
            $("#"+currentInputId).next().append(" " +$("#latex_formula").val()+"$" + " ");
        }else {
            $("#"+currentInputId).val( $("#"+currentInputId).val());
        }

        $("#myModal").modal("hide");
        $("#subFuc").unbind("click")
    }


    function analysisFormulaDet() {
        if($("#latex_formula").val() != null && $("#latex_formula").val() != '') {
            $("#answerdetail").val($("#answerdetail").val()+ "$"+$("#latex_formula").val() +"$"+" ");
            $("#myModal").modal("hide");
        }
    }




    jQuery(function($) {
        $(".select2").select2();
        $("#myFormId").validate(saveVideoExamConfig);
        $(".btn-save").click(function(){
            handleAnswer();
            if($("#myFormId").validateForm(saveVideoExamConfig)) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'${base}/examConfig/updExam.json',
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
                                            window.location.href = '${base }/examConfig/index.html'
                                        }
                                    }
                                });
                                break;
                            default:
                                if (data.success){
                                    var n = noty({
                                        text        : data.message,
                                        type        : 'success',
                                        dismissQueue: true,
                                        layout      : 'topCenter',
                                        theme       : 'relax',
                                        timeout		: 1500,
                                        callback: {     // 设置回调函数
                                            afterClose: function() {
                                                window.location.href = '${base }/examConfig/index.html'
                                            }
                                        }
                                    });
                                }else{
                                    var n = noty({
                                        text        : data.message,
                                        type        : 'error',
                                        dismissQueue: true,
                                        layout      : 'topCenter',
                                        theme       : 'relax',
                                        timeout		: 1500
                                    });
                                }
                        }
                    },
                    error:function(data){
                        alert('ajax错误');
                    }
                });
            }
        });
    });


    function formulaTm() {
        if($("#latex_formula").val() != "" && $("#latex_formula").val() != null) {
            $("#subject").val($("#subject").val() + "$" +$("#latex_formula").val()+"$" + " ");
        }
        $("#myModal").modal("hide");
        $("#subFuc").unbind("click");
    }

    function changeModel(obj) {
        if($(obj).val() == "1") {
            $("#formula").show();
            $(".answer").show()
            $("#analysisFormula").hide();

        }else if($(obj).val() == "2") {
            $("#formula").hide();
            $(".answer_").hide()
            $("#analysisFormula").show()
        }else if($(obj).val() == "0") {
            $("#analysisFormula").hide();
            $("#formula").hide();
            $(".answer_").hide()
        }else {
            $("#formula").show();
            $("#analysisFormula").show()
            $(".answer").show()
        }
    }

    function handleAnswer() {
        content = "";
        content += $("#subject").val();

        var answerArray = new Array();
        $("input[id^='answer_']").each(function() {
            answerArray.push($(this).val());
        })

        answerArray.sort();

        if($("#resolutiontype").val() == 1) {
            content += "**";
            for(var i = 0;i <= answerArray.length-1;i++ ) {
                content += answerArray[i];
                if(i != 0) {
                    content += "##";
                }
            }

            content += "**";
        }else {
            content += "|";
            for(var i = 0;i <= answerArray.length-1;i++) {
                content += answerArray[i]+"|";
            }
        }

        $("#content").val(content);
    }

    $(function() {
        $.post("${base}/examConfig/getBlock.json",function (result) {
            if(result) {
                $.each(result,function(i,v){
                    $("#blockid").append("<option value='"+v.blockId+"'>"+v.name+"</option>");
                })
            }
        })
    })

    function getVideo() {
        var blockId = $("#blockid").val();
        $("#vid").empty();
        $.post("${base}/examConfig/getVideoByBlock.json",{"blockId":blockId},function (result) {
            if(result) {
                $.each(result,function(i,v){
                    $("#vid").append("<option value='"+v.vid+"'>"+v.title+"</option>");
                })
            }
        })
    }



    window.onload=function(){
        $("#resolutiontype").val(${entity.resolutiontype});
        $("#blockid").val(${entity.blockid});
        var vid = "${entity.blockid}"+"${entity.examid}";
        $("#vid").val(vid);
        if("${entity.resolutiontype}" == "1") {
            $("#formula").show();
            $(".answer").show();
        }else if("${entity.resolutiontype}" == "3") {
            $("#formula").show();
            $("#analysisFormula").show()
            $(".answer").show();
        }

    };

//    function aaa() {
//        MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
//    }
</script>
</@main.footer>
