<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
<link rel="stylesheet" href="${base}/assets/css/font-awesome.min.css">
<link rel="stylesheet" href="${base}/assets/css/community.css?1.0">
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <!--top-->
        <@main.forumTop>
            <#escape x as x?html>
            </#escape>
        </@main.forumTop>


        <#--<div class="LoginLayerContent">-->

        <#--</div>-->
    <#--置顶-->
        <div class="QpandaBanner">
            <div class="QpaContent">
                <#if isOutSearch == "0">
                    <div class="QpandaContent">
                        <div class="QpaImg" style="text-align: center; margin-top: 13px;"><img src="/${setting['files.contextpath']}${blockDesc.face}" alt="" style="width: 80%"></div>
                        <div class="QpaJs">
                            <div class="QpaTitle">${blockDesc.blockName}</div>
                            <div class="QpaTool">
                                <div class="QpaPost">帖子：<span>${pager.totalRecords!}</span></div>
                            <#--<div class="QpaHelp">求助：<span>30</span></div>-->
                                <!--div class="QpaCheck">查看版主  <i class="arrowJ">  &gt; </i></div-->
                            </div>
                            <div class="QpaText">
                            ${blockDesc.blockDesc}
                            </div>
                        </div>


                    </div>
                <#--<#if belonged=="1">-->
                    <#--<div class="QpandaContent">-->
                        <#--<div class="QpaImg" style="text-align: center; margin-top: 13px;"><img src="/${setting['files.contextpath']}${blockDesc.face}" alt="" style="width: 80%"></div>-->
                        <#--<div class="QpaJs">-->
                            <#--<div class="QpaTitle">${blockDesc.blockName}</div>-->
                            <#--<div class="QpaTool">-->
                                <#--<div class="QpaPost">帖子：<span>${pager.totalRecords!}</span></div>-->
                                <#--&lt;#&ndash;<div class="QpaHelp">求助：<span>30</span></div>&ndash;&gt;-->
                                <#--<!--div class="QpaCheck">查看版主  <i class="arrowJ">  &gt; </i></div&ndash;&gt;-->
                            <#--</div>-->
                            <#--<div class="QpaText">-->
                                <#--${blockDesc.blockDesc}-->
                            <#--</div>-->
                        <#--</div>-->


                    <#--</div>-->
                    <#--<#elseif belonged=="3">-->
                        <#--<div class="QpandaContent">-->
                            <#--<div class="QpaImg"><img src="${base}/assets/forImg/QuantumCourse.png" alt=""></div>-->
                            <#--<div class="QpaJs">-->
                                <#--<div class="QpaTitle">量子课程</div>-->
                                <#--<div class="QpaTool">-->
                                    <#--<div class="QpaPost">帖子：<span>${pager.totalRecords!}</span></div>-->
                                    <#--&lt;#&ndash;<div class="QpaHelp">求助 ：<span>30</span></div>&ndash;&gt;-->
                                    <#--<!--div class="QpaCheck">查看版主  <i class="arrowJ">  &gt; </i></div&ndash;&gt;-->
                                <#--</div>-->
                                <#--<div class="QpaText">-->
                                    <#--本源量子计算教育系列课程，包含详细的量子计 算专业基础、高级开发课程，专为渴望接触量子编程的你，打造最适合的学习方式。-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--<#elseif belonged=="2">-->
                        <#--<div class="QpandaContent">-->
                            <#--<div class="QpaImg"><img src="${base}/assets/forImg/Ltlzsfpng.png" alt=""></div>-->
                            <#--<div class="QpaJs">-->
                                <#--<div class="QpaTitle"><img src="${base}/assets/forImg/Ltlzsf.png" alt=""></div>-->
                                <#--<div class="QpaTool">-->
                                    <#--<div class="QpaPost">帖子：<span>${pager.totalRecords!}</span></div>-->
                                    <#--&lt;#&ndash;<div class="QpaHelp">求助：<span>30</span></div>&ndash;&gt;-->
                                    <#--<!--div class="QpaCheck">查看版主  <i class="arrowJ">  &gt; </i></div&ndash;&gt;-->
                                <#--</div>-->
                                <#--<div class="QpaText">-->
                                    <#--量子算法是以量子态作为输入，量子逻辑门作为操作序列的算法。该算法能为量子计算机提供指数级增长的运算能力。-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</div>-->
                <#--</#if>-->
                </#if>
            </div>
        </div>

    <#--帖子/简介栏-->
        <div class="topicContent">
            <form method="post" id="searchForm" action="${base}/qcode/forumtopic/community.html" autocomplete="off">
                <input type="hidden" name="belonged" id="belonged" value="${belonged}">
                <#if (isOutSearch??) &&  isOutSearch == "1">
                     <input type="hidden" id="content" name="content" value="${content}">
                    <input type="hidden" value="${isOutSearch}" id="isOutSearch" name="isOutSearch">
                </#if>
            <div class="topicLeft">
                <#if isOutSearch == "0">
                <div class="tlTab">
                    <div class="tlTab-left">
                        <div class="tzTab">
                            <a href="javascript:" class="tab-toggle" id="timeOrder">全部时间</a>
                            <div class="tzTab-jt"> <i class="arrowJ">&gt;</i></div>
                            <input type="hidden" id="timeOrderV" name="timeOrderV">
                            <div class="dropdown-tab">
                                <ul>
                                    <li><a href="javascript:" onclick="getForumList(this,'0')">全部时间</a></li>
                                    <li><a href="javascript:" onclick="getForumList(this,'1')">三天内</a></li>
                                    <li><a href="javascript:" onclick="getForumList(this,'2')">七天内</a></li>
                                    <li><a href="javascript:" onclick="getForumList(this,'3')">一个月内</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="tzTab">
                            <a href="javascript:" class="tab-toggle" id="repTime">不限</a>
                            <div class="tzTab-jt"> <i class="arrowJ">&gt;</i></div>
                            <input type="hidden" id="repTimeV" name="repTimeV">
                            <div class="dropdown-tab">
                                <ul>
                                    <li><a href="javascript:" onclick="getForumList(this,null,'0')">不限</a></li>
                                    <li><a href="javascript:" onclick="getForumList(this,null,'1')">发帖时间</a></li>
                                    <li><a href="javascript:" onclick="getForumList(this,null,'2')">回复时间</a></li>
                                </ul>
                            </div>
                        </div>
                        <#--<div class="tzTab">-->
                            <#--<a href="javascript:" class="tab-toggle" id="label">全部标签</a>-->
                            <#--<div class="tzTab-jt"> <i class="arrowJ">&gt;</i></div>-->
                            <#--<input type="hidden" id="labelV">-->
                            <#--<div class="dropdown-tab">-->
                                <#--<ul>-->
                                    <#--<li><a href="javascript:" onclick="getForumList(this,null,null,'10000')">全部标签</a></li>-->
                                    <#--<#if labelList??>-->
                                        <#--<#list labelList as labelList>-->
                                            <#--<li><a href="javascript:" onclick="getForumList(this,null,null,'${labelList.id}')">${labelList.label}</a></li>-->
                                        <#--</#list>-->
                                    <#--</#if>-->
                                <#--</ul>-->
                            <#--</div>-->
                        <#--</div>-->
                    </div>
                    <div class="tlTab-right">
                        <div class="tr-sr">
                            <div class="searchInp"><input type="text" placeholder="板块内搜索" id="content" name="content" value='${content}'></div>
                            <div class="searchBtn"><img src="${base}/assets/forImg/sousuo_2.png" alt=""></div>
                        </div>
                    </div>
                </div>
                </#if>
                <div class="tzContent">
                    <div class="tz_box">
                        <div class="tzDetailList">
                            <ul>
                                <#if pager?? && (pager.entityList)?size gt 0>
                                    <#list pager.entityList as project>
                                        <li class="community_detalis">
                                            <div class="community_bt">
                                            <#if (project.topicFace)?? && project.topicFace != "">
                                            <div class="community_top">
                                                    <div class="cTop_left">
                                                        <#if (project.topicFace)?? && project.topicFace != "">
                                                        <div class="cTopImg">
                                                            <img data-src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                                        </div>
                                                        </#if>
                                                    </div>
                                                    <div class="cTop_right cTop_right_special">
                                                        <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belongde=${belonged}"><div class="title">${project.title!}</div></a>
                                                            <div class="tag">
                                                                <#if (project.labelList)?size gt 0>
                                                                    <#list project.labelList as labelList>
                                                                    <span >${labelList.label!}</span>
                                                                    </#list>
                                                                </#if>
                                                            </div>
                                                        <div class="community_bottom">
                                                            <div class="comm_publish">
                                                                <div class="publ_left">
                                                            <span class="publ_photo">
                                                                <#if (project.face)?? && project.face != "">
                                                                    <img data-src="/${setting['files.contextpath']}${project.face!}" alt="">
                                                                <#else>
                                                                    <img src="${base}/assets/forImg/Head.png" alt="">
                                                                </#if>
                                                            </span>
                                                                    <span class="pulb_name">${project.userName!}</span>
                                                                    <span> 于 </span>
                                                                    <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                                                    <span>发布</span>
                                                                    <div style="clear:both;"></div>
                                                                </div>
                                                                <div class="publ_right">
                                                                    <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                                                        <#if USER_INFO.belonged == belonged>
                                                                            <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                                                        </#if>
                                                                    </#if>
                                                                    <span class="publ_look">${project.seeCount!}</span>
                                                                    <span class="leaveWord">${project.replyCount!}</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style="clear: both"></div>
                                                </div>
                                            <#else>
                                                <div class="community_top">
                                                    <div class="cTop_left">
                                                        <#if (project.topicFace)?? && project.topicFace != "">
                                                            <div class="cTopImg">
                                                                <img data-src="/${setting['files.contextpath']}${project.topicFace!}" alt="">
                                                            </div>
                                                        </#if>
                                                    </div>
                                                    <div class="cTop_right">
                                                        <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belongde=${belonged}"><div class="title">${project.title!}</div></a>
                                                        <div class="tag">
                                                            <#if (project.labelList)?size gt 0>
                                                                <#list project.labelList as labelList>
                                                                    <span >${labelList.label!}</span>
                                                                </#list>
                                                            </#if>
                                                        </div>
                                                    </div>
                                                    <div style="clear: both"></div>
                                                </div>
                                                <div class="community_bottom">
                                                    <div class="comm_publish">
                                                        <div class="publ_left">
                                                            <span class="publ_photo">
                                                                <#if (project.face)?? && project.face != "">
                                                                    <img data-src="/${setting['files.contextpath']}${project.face!}" alt="">
                                                                <#else>
                                                                    <img src="${base}/assets/forImg/Head.png" alt="">
                                                                </#if>
                                                            </span>
                                                            <span class="pulb_name">${project.userName!}</span>
                                                            <span> 于 </span>
                                                            <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                                            <span>发布</span>
                                                            <div style="clear:both;"></div>
                                                        </div>
                                                        <div class="publ_right">
                                                            <#if USER_INFO?? && USER_INFO.isModerator?? && USER_INFO.belonged??>
                                                                <#if USER_INFO.belonged == belonged>
                                                                    <span class="publ_look"><a href="javaScript:;" onclick="setTop('${project.id}')">置顶</a></span>
                                                                </#if>
                                                            </#if>
                                                            <span class="publ_look">${project.seeCount!}</span>
                                                            <span class="leaveWord">${project.replyCount!}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </#if>
                                            </div>
                                        </li>
                                    </#list>
                                </#if>

                            </ul>
                        </div>
                        <div class="fenye" style="width: 100%;">
                            <nav aria-label="Page navigation"
                                 style="margin: 100px auto">
                                <@main.pagination pager=pager/>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            </form>
            <div class="topicRight">
            <#--发布新帖-->
                <#if isOutSearch == "0">
                <div class="topDeliver">
                    <button onclick="saveForum()"></button>
                </div>
            <#--社区公告-->
                <div class="index_noticeBox">
                    <div>社区公告</div>
                    <ul>
                        <li><i>1</i><a href="https://qcode.qubitonline.cn/qcode/forumtopic/communitydetail.html?id=24&belongde="><span>本源量子互动论坛隐私政策</span><span class="notice_time">2019-05-21</span></a></li>
                    </ul>
                </div>
            <#--达人热帖-->
                <div class="topicReTie">
                    <div class="eTitle" id="hotForum">
                        <h1><img src="${base}/assets/forImg/hot.png" alt=""><span>达人热帖</span></h1>
                    </div>
                </div>
                    <div class="topicReTie"  style="padding-bottom: 50px">
                        <div class="eTitle">
                            <h1><img src="${base}/assets/forImg/Look.png" alt=""><span>最新看点</span></h1>
                        </div>
                        <div class="watchList">
                            <ul>
                                <#--<li class="watDetailsHaveImg">-->
                                    <#--<a href="https://mp.weixin.qq.com/s/db6xzhj-ic6XD_4xCjhh3w" target="_blank" class="watFont6"><i></i>合肥——青年眼中的大IP</a>-->
                                    <#--<div class="watShowImg"><img src="${base}/assets/images/wx_new1.jpg" alt=""></div>-->
                                <#--</li>-->


                                <li class="watDetails active">
                                    <a href="https://mp.weixin.qq.com/s/db6xzhj-ic6XD_4xCjhh3w" target="_blank"  class="watFont4"><i></i>合肥——青年眼中的大IP</a>
                                    <div class="watShowImg"><img src="${base}/assets/images/wx_new1.jpg" alt=""></div>
                                </li>
                                    <li class="watDetails">
                                        <a href="https://mp.weixin.qq.com/s/iJ6wi2zgwE3ayueeFvTDnw" target="_blank"  class="watFont4"><i></i>【新品】国内首款量子软件开发包QPanda 2.0 升级发布!</a>
                                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new2.jpg" alt=""></div>
                                    </li>
                                    <li class="watDetails">
                                        <a href="https://mp.weixin.qq.com/s/8IQ1y0GLBCHM9wM0Dhsn-w" target="_blank"  class="watFont4"><i></i>中共安徽省委常委、统战部部长刘莉莅临本源量子考察调研</a>
                                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new3.jpg" alt=""></div>
                                    </li>
                                    <li class="watDetails">
                                        <a href="https://mp.weixin.qq.com/s/p6NCgCp9UjGSTaUUCEfdGw" target="_blank"  class="watFont4"><i></i>安徽省人大常委会副主任谢广祥莅临本源量子考察调研</a>
                                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new4.jpg" alt=""></div>
                                    </li>
                                    <li class="watDetails">
                                        <a href="https://mp.weixin.qq.com/s/InQjr466cQ_fArqtz3uDhA" target="_blank"  class="watFont4"><i></i>本源量子致力于中国量子计算产业上下游全面发展——暨合肥市高新区管委会主任宋道军莅临我公司调研…</a>
                                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new5.jpg" alt=""></div>
                                    </li>
                                    <li class="watDetails">
                                        <a href="https://mp.weixin.qq.com/s/UqxrCfdbMlsCvZdkXlZ61w" target="_blank"  class="watFont4"><i></i>本源量子计算云平台64位量子本源量子计算云平台64位量子…</a>
                                        <div class="watShowImg"><img data-src="${base}/assets/images/wx_new6.jpg" alt=""></div>
                                    </li>

                            </ul>
                        </div>
                    </div>
                </#if>
            </div>
            <div style="clear:both;"></div>
        </div>

        <#assign lang="${Session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']?default('zh_CN')}">
        <form method="post" id="searchForm" action="${base}/qcode/forumtopic/community.html" autocomplete="off">
            <!--top end-->
            <div class="pic">
            <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
            </div>


            <div style="overflow:hidden;display: none">
                <div class="row">
                    <div class="col-md-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-ma-12">
                                    <div>
                                        <div class="row" style="padding-top: 40px; padding-bottom: 10px;">
                                        <#--仅论坛模块第一板块-->
                                            <div class="col-md-12">
                                            <#--发布按钮/搜索/选项等列-->
                                                <div class="row">
                                                    <div class="col-sm-3"></div>
                                                    <div class="col-sm-3"></div>
                                                    <div class="col-sm-3 comm_add">
                                                        <button type="button" class="btn btn-primary" id="comm_append">
                                                            发布
                                                        </button>
                                                    </div>
                                                    <div class="col-sm-3 comm_ff">
                                                        <form class="form-inline">
                                                            <button type="submit" class="btn btn-default
                                                        comm_input_style" onclick="queryList()">搜索
                                                            </button>
                                                            <div class="form-group comm_ff">

                                                                <input type="text" class="form-control"
                                                                       id="exampleInput"
                                                                       name="title" placeholder="请输入搜索关键字"
                                                                       style="border-color: #ccc; border-radius: 0;"
                                                                       value="${title!}">
                                                            </div>


                                                        </form>
                                                    </div>

                                                </div>
                                                <div class="row" style="margin-top: 30px">
                                                    <div class="comm-loading"></div>
                                                    <div class="col-md-12">
                                                        <div class="list-off">
                                                            <ul>
                                                                <#if pager?? && (pager.entityList)?size gt 0>
                                                                    <#list pager.entityList as project>
                                                                        <li class="community_list">
                                                                            <div class="community_box">
                                                                                <div class="community_name"
                                                                                     style="padding: 0 10px;line-height:normal;word-wrap:break-word;">

                                                                                    <p> ${project.username!}</p>
                                                                                </div>
                                                                                <div style="width: auto;margin-left: 100px">
                                                                                    <div style="padding-bottom: 6px">
                                                                                        <a href="${base}/qcode/forumtopic/communitydetail.html?id=${project.id!}&belonged=${belonged}" class="community_title">
                                                                                            ${project.title!}
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="community_summary">
                                                                                        <#assign comment = (project.content?replace("<([^>]*)>","","r"))?replace("&nbsp;", "")/>
                                                                                        <#noescape>${comment!}</#noescape>
                                                                                    </div>
                                                                                    <div class="community_tag">
                                                                                       <#list project.labelList as labelList>
                                                                                            <a href="#"
                                                                                               class="child1">${labelList.label!}</a>
                                                                                        </#list>
                                                                                    </div>
                                                                                    <div class="community_remarks"
                                                                                         style="">
                                                                                        <a href="javascript:void(0)">
                                                                                            <span class="fa fa-user"
                                                                                                  aria-hidden="true"></span>
                                                                                            <span>${project.userName!}</span>
                                                                                        </a>
                                                                                        <a href="javascript:void(0)">
                                                                                            <span class="fa fa-clock-o"
                                                                                                  aria-hidden="true"></span>
                                                                                            <span>${project.addTime?string("yyyy-MM-dd HH:mm:ss")!}</span>
                                                                                        </a>
                                                                                    <#--<a href="#">-->
                                                                                    <#--<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>-->
                                                                                    <#--<span>最后的评论由 <span>herrier</span>于 <span>13</span>天前发表</span>-->
                                                                                    <#--</a>-->
                                                                                        <a href="javascript:void(0)">
                                                                                            <span class="fa fa-comments"
                                                                                                  aria-hidden="true"></span>
                                                                                            <span><span
                                                                                                    style="font-weight: 400">${project.replyCount!}</span> 条评论</span>
                                                                                        </a>
                                                                                    </div>

                                                                                </div>
                                                                            </div>
                                                                        </li>
                                                                    </#list>
                                                                <#else >
                                                                    <div style="margin: 0 auto; padding-top:200px;text-align: center;padding-bottom:250px;">
                                                                        <img src="${base}/assets/images/nodata.png" alt="">
                                                                        <div style="padding-top: 10px">抱歉！没有找到符合条件的数据</div>
                                                                        <div>您可以尝试更换关键词</div>
                                                                    </div>
                                                                </#if>

                                                            </ul>
                                                        </div>
                                                        <div class="fenye">
                                                            <nav aria-label="Page navigation"
                                                                 style="margin: 100px auto">
                                                                <@main.pagination pager=pager/>
                                                            </nav>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 模态框（Modal） -->
            <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content" style="width: 700px">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">
                                发表
                            </h4>
                        </div>
                        <div class="form-group" style="margin: 30px 15px">
                        <#--<label for="exampleInputEmail1">Email address</label>-->
                            <img name="topicFace" id="topicFace" src="" width="50px">
                            <input type="file" name="file" id="file" onchange="uploadpic(this)">
                            <input type="text" class="form-control" id="title" placeholder="请输入标题">
                        </div>
                        <div class="modal-body">
                            <div id="div1" style="position: relative">

                            </div>
                            <div class="comm_Placeholder">请输入正文</div>
                        </div>
                        <div class="community_tag">
                            <a href="#"
                               class="child1">概述</a>
                            <a href="#"
                               class="child2">编码</a>
                            <a href="#"
                               class="child3">标签</a>
                        </div>
                        <div class="modal-footer">
                        <#--<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>-->
                            <button type="button" class="btn btn-primary" id="publish_btn">
                                提交
                            </button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>
            <!--box end-->
        </form>
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script src="${base}/assets/js/wangEditor.js"></script>
<script>
    $('#searchContent').keypress(function (e) {
        if(e.keyCode==13){
            $("#globalSearch").click()
        }
    })
    $(".watchList li").hover(function () {
        $(this).addClass("active").siblings().removeClass("active")
    })

    $(".community_summary").each(function (i, s) {
        $(this).on("mouseenter", function () {
            if ($(this).html().replace(/(^\s+)|(\s+$)/g, "").length > 75) {
                $(this).css({"max-height": "62px"})
            }
        });
        $(this).on("mouseleave", function () {
            if ($(this).html().replace(/(^\s+)|(\s+$)/g, "").length > 75) {
                $(this).css({"max-height": "24px"})
            }
        })
    });
    
    
    $(".tzTab").on("mouseover",function () {
        $(this).find(".dropdown-tab").show();
    });

    $(".tzTab").on("mouseout",function () {
        $(this).find(".dropdown-tab").hide();
    });

    $(document).click(function(event){
        var _con = $('.tzTab');   // 设置目标区域
        if(!_con.is(event.target) && _con.has(event.target).length === 0){ // Mark 1
            //$('#divTop').slideUp('slow');   //滑动消失
            $('.dropdown-tab').hide();          //淡出消失
        }
    });
    //显示富文本
    var E = window.wangEditor;
    var editor = new E('#div1');
    editor.customConfig.onfocus = function () {
        console.log("onfocus");
        $(".comm_Placeholder").hide();
    };
    editor.customConfig.onblur = function (html) {
        // html 即编辑器中的内容
        console.log('onblur', html)
    };
    // 自定义菜单配置
    editor.customConfig.menus = [
        'head',  // 标题
        'bold',  // 粗体
        'fontSize',  // 字号
        'fontName',  // 字体
        'italic',  // 斜体
        'underline',  // 下划线
        'strikeThrough',  // 删除线
        'foreColor',  // 文字颜色
        'backColor',  // 背景颜色
        'link',  // 插入链接
        'list',  // 列表
        'justify',  // 对齐方式
        'quote',  // 引用
        //'emoticon',  // 表情
        // 'image',  // 插入图片
        'table',  // 表格
        //'video',  // 插入视频
        'code',  // 插入代码
        'undo',  // 撤销
        'redo'  // 重复
    ];
    editor.create();


    //    弹框显示
    $("#comm_append").on("click", function () {
        $("#myModal2").modal('show');
    });
    //    发布主题
    $("#publish_btn").on("click", function () {
       //console.log($("#title").val())
       //console.log($(".w-e-text").html())
        if ($("#title").val() == '' || $("#title").val() == null) {
            errorMsg("请输入标题");
            return false;
        }
        if ($(".w-e-text").html() == '<p><br></p>') {
            errorMsg("请输入正文内容");
            return false;
        }
        $.post("${base}/qcode/forumtopic/addForumTopic.json", {
            title: $("#title").val(),
            content: $(".w-e-text").html(),
            topicFace:$("#topicFace").attr("src")
        }, function (result) {
//            console.log(result);
            window.location.reload()
        })

    });

    <#--if(${isApply}!=1){-->
    <#--$('#myModal').modal('show');-->
    <#--}-->
    var ak = 'Y5brUY2qCrIjpehmh0CEQ4THLsiyY1Ti';
    var map;
    var point;

    function onblur() {

    }


    var telRegex = /^1([35789]\d|4[57])\d{8}$/;
    var eamilRegex = /^([\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?)+$/;

    function subimitUserApply() {
        var name = $('#name').val();
        var phone = $('#phone').val();
        var email = $('#email').val();
        var vmType = $('#vmType  option:selected').val();
        var purpose = $('#purpose').val();
        var code = $('#captcha').val();
        if (name == '') {
            errorMsg(messages.name_not_null);
            return false;
        }

        if (phone == '') {
            errorMsg(messages.phone_not_null);
            return false;
        }
        if (!telRegex.test(phone)) {
            errorMsg(messages.phone_is_proper);
            return false;
        }

        if (email == '') {
            errorMsg(messages.email_not_null);
            return false;
        }
        if (!eamilRegex.test(email)) {
            errorMsg(messages.email_is_proper);
            return false;
        }
        if (vmType == 0) {
            errorMsg(messages.vmType_not_null);
            return false;
        }
        if (purpose == '') {
            errorMsg(messages.purpose_not_null);
            return false;
        }
        if (code == '') {
            errorMsg(messages.volidate_code_not_null);
            return false;
        }
        //   是否同意用户申请协议
        if (!$("input[type='checkbox']").is(':checked')) {
            errorMsg(messages.checkbox_is);
            return false;
        }
        var param = {};
        param.name = name;
        param.phone = phone;
        param.email = email;
        param.vmType = vmType;
        param.purpose = purpose;
        param.code = code;
        $('.btn').attr('disabled', true);
        $('.btn').text('请稍候......');
        //表单提交
        $.ajax({
            url: "${base}/QCode/userApply.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                $('.btn').attr('disabled', false);
                if (result.code == 401) {
                    window.location.href = result.message; //开发测试时调用的pc浏览器登录页面
                    return false;
                }
                if (result.success) {
                    var n = noty({
                        text: messages.apply_is_submit,
                        type: 'success',
                        dismissQueue: true,
                        layout: 'topCenter',
                        theme: 'relax',
                        timeout: 1500,
                        callback: {     // 设置回调函数
                            afterClose: function () {
                                window.location.reload(true);
                            }
                        }
                    });
                } else {
                    errorMsg(result.message);
                }
            },
            error: function () {
                errorMsg(messages.server_is_busy);
            }
        });

    }


    function queryList() {
        $('#searchForm').submit();
    }


    function uploadpic(obj) {
        run(obj, function (data) {
            $("#topicFace").attr("src",data);
        });
    }

    function run(input_file, get_data) {
        /*input_file：文件按钮对象*/
        /*get_data: 转换成功后执行的方法*/
        if (typeof (FileReader) === 'undefined') {
            alert("抱歉，你的浏览器不支持 FileReader，不能将图片转换为Base64，请使用现代浏览器操作！");
        } else {
            try {
                /*图片转Base64 核心代码*/
                var file = input_file.files[0];
                //这里我们判断下类型如果不是图片就返回 去掉就可以上传任意文件
                if (!/image\/\w+/.test(file.type)) {
                    alert("请确保文件为图像类型");
                    return false;
                }
                var reader = new FileReader();
                reader.onload = function () {
                    get_data(this.result);
                };
                reader.readAsDataURL(file);
            } catch (e) {
                alert('图片转Base64出错啦！' + e.toString())
            }
        }
    }

    function getForumList(obj,timeOrder,repTime,label) {
        var txt = $(obj).text();
        if(str(timeOrder)) {
            $("#timeOrder").html(txt);
            $("#timeOrderV").val(timeOrder);
        }
        if(str(repTime)) {
            $("#repTime").html(txt);
            $("#repTimeV").val(repTime);
        }
        if(str(label)) {
            $("#label").html(txt);
            $("#labelV").val(label);
        }

        $.ajax({
            url:"${base}/qcode/forumtopic/communityList.html",
            data:{
                timeOrder:$("#timeOrderV").val(),
                repTime:$("#repTimeV").val(),
                label:$("#labelV").val(),
                belonged:$("#belonged").val()
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $(".tzContent").empty();
                    $(".tzContent").html(data);
                }
            }
        })
    }

    $(".searchBtn").on("click",function(){
        $.ajax({
            url:"${base}/qcode/forumtopic/communityList.html",
            data:{
                timeOrder:$("#timeOrderV").val(),
                repTime:$("#repTimeV").val(),
                label:$("#labelV").val(),
                content:encodeURI($("#content").val()),
                belonged:'${belonged}'
            },
            dataType:"html",
            success:function(data) {
                if(data) {
                    $(".fenye").remove();
                    $(".tzContent").empty();
                    $(".tzContent").html(data);
                }
            }
        })
    });

    //板块外搜索
    $("#globalSearch").on("click",function(){
        var urldata = encodeURIComponent($("#searchContent").val());
        var url = "${base}/qcode/forumtopic/community.html?isOutSearch=1&&content="+urldata;
        window.open(url);
    });

    function hotForum() {
        $.ajax({
            url:"${base}/qcode/forumtopic/queryHot.html",
            dataType:"html",
            type:"post",
            success:function(data) {
                if(data) {
                    $("#hotForum").after(data);
                }
            }
        })
    }

    function saveForum() {
        <#if USER_INFO??>
            window.location.href = "${base}/qcode/forumtopic/communityPublish.html?belonged=${belonged}";
        <#else>
            viewLoginMin();
        </#if>

    }
    
    function str(obj) {
        var flag = false;
        if(obj != null && obj != 'undefined') {
            flag = true;
        }
        return flag;
    }

    $(function() {
        if(${isOutSearch} != "1") {
            hotForum();
        }

        if("${isOutSearch}" == "1" && '${content}' != "") {
            $("#content").val('${content}');
        }
    })

    function setTop(forumTopicId) {
        $.post("${base}/qcode/forumtopic/setTop.json",{
            "forumTopicId":forumTopicId
                },
                function (data) {
                    alert("置顶成功");
                    window.location.reload();
        })
    }


</script>
</@main.footer>
