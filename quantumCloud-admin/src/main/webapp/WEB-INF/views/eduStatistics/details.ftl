<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="百度统计">

</@main.header>
<@main.body>
<style>
    .dataList td {
        text-align: center
    }

    .dataList th {
        text-align: center
    }

    .red {
        color: red
    }

    span {
        cursor: pointer
    }
</style>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base}/tongji/index.html">百度统计</a></li>
            <li>趋势</li>
        </ol>
        <div class="row">
            <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-body">
                        </div>
                    </div>
                    <input type="hidden" id="type">
                    <style>
                        #date-select-bar span,#time-span span{

                            display: inline-block;
                            float: left;
                            height: 24px;
                            line-height: 24px;
                            padding: 0 10px;
                            color: #323437;
                            background-color: #fff;
                        }
                        .data-time-select ,#time-span {
                            float: left;
                            border-style: solid;
                            border-width: 1px;
                            border-color: #e1e3e4;
                            border-radius: 2px;
                        }
                        .input-group-addon{
                            float: left;
                        }
                        .input-group-addon:first-child{
                            display: none;
                        }
                        #control-bar{
                            padding: 20px 0;
                        }
                        #control-bar-wrapper{
                            padding: 0 20px 20px;
                        }
                        .data-title-time{
                            font-size: 16px;
                            line-height: 30px;
                            display: inline-block;
                            color: #808080;
                            margin-bottom: 10px;
                        }
                        #date-select-bar .data-time-select span.cur,#time-span span.cur{
                            position: relative;
                            bottom: -1px;
                            margin-top: -2px;
                            padding-top: 1px;
                            height: 25px;
                            background-color: #4da7fd;
                            color: #fff;
                            border-radius: 2px 0 0 2px;
                            left: -1px;
                        }
                        .data-time-input{
                            height: 25px;
                            display: inline-block;
                        }
                        .data-time-input input{
                            height: 25px;
                            padding-left: 5px;
                        }
                        #date-select-bar .data-time-input .input-group-addon{
                            padding: 0;border: 0;position: absolute;width: 0;right: 20px;top: 0;
                        }
                        #date-select-bar .data-time-input .glyphicon-th{
                            padding: 0;height: 22px;
                        }
                        #time-span{
                            margin: 0 20px;
                        }
                        .selectContent select{
                            border: 1px solid #d0dde6;
                            width: 120px;
                            padding-left: 20px;
                            text-align: center;
                            float: right;
                            height: 30px;
                            z-index: 1;
                            position: relative;
                            margin-right: 50px;
                        }
                        .selectContent select:focus{
                            box-shadow: none;
                            outline: none;
                        }
                        .selectContent select option{
                            color: #504b4b;
                            font-size: 14px;
                            line-height: 50px;
                        }
                        .secondTab span{
                            border-right: 1px solid #e1e3e4;
                        }


                        .paginationNew{
                            float: right;
                            position: relative;
                            /* left: 50%; */
                            margin: 0 auto;
                            overflow: hidden;
                            border: 1px solid #ccc;
                            margin-right: 15px;
                        }
                        .paginationNew ul{
                            position: relative;
                            margin: 0;
                            padding: 0;
                        }
                        .paginationNew li{
                            display: inline-block;
                            list-style: none;
                            line-height: 30px;
                            padding: 0 15px;
                            cursor: pointer;
                            border-right: 1px solid #ccc;
                        }
                        .paginationNew li a{
                            display: block;
                        }
                        .paginationNew li:last-child{
                            border: none;
                        }
                        .paginationNew li.active{
                            background: #ccc;
                        }
                    </style>
                    <div id="filters" class="box ">
                        <div class="" id="control-bar-wrapper">
                            <div class="" id="control-bar">
                                <span class="data-title-time">时间：</span>
                                <div class="" id="date-select-bar">
                                    <div class="data-time-select">
                                        <span class="red cur" onclick="getDate(this,'time_yest')">昨天</span>
                                        <span class="" onclick="getDate(this,'time_tody')">今天</span>
                                        <span class="seprator"></span>
                                        <span class="" onclick="getDate(this,'time_week')">最近7天</span>
                                        <span class=""></span>
                                        <span class="" onclick="getDate(this,'time_half_month')">最近15天</span>
                                        <span class=""></span>
                                        <span href="javacript:;" class="" onclick="getDate(this,'time_month')">最近30天</span>
                                    </div>

                                    <span class="" id="custom-date-select"  onchange="getStartDate()">
                                        <div class="input-group data-time-input date datetimepicker-day" data-date=""
                                             data-date-format="yyyy-mm-dd">
                                            <input style="width: 160px" class="" id="startTime" name="publishTime" type="text" value="" placeholder="请选择开始时间"
                                                   readonly>
                                            <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
                                            <span class="input-group-addon" style= ""><span class="glyphicon glyphicon-th"></span></span>
                                        </div>

                                    </span>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="box" style="border: none">
                        <div class="box-body table-responsive no-padding selectContent" style="padding-bottom: 50px!important;overflow:auto;">


                            <table class="table table-bordered table-hover dataList">
                                <thead>
                                <tr>
                                    <th>访客数</th>
                                    <th>用户注册数</th>
                                    <th>视频观看数</th>
                                    <th>帖子发布数</th>
                                    <th>签到数</th>
                                    <th>APP下载数</th>
                                </tr>
                                </thead>
                                <tbody id="tableList">
                                </tbody>

                            </table>
                            <br>

                            <div class="" id="date-select-bar" style="    width: 530px;margin: 0 auto 55px;padding: 30px 0;">

                            <div class="data-time-select  secondTab">
                                <span class="red cur" onclick="indicator('1',this)">访客数</span>
                                <span class="" onclick="indicator('2',this)">用户注册数</span>
                                <span class="" onclick="indicator('3',this)">视频观看数</span>
                                <span class="" onclick="indicator('4',this)">帖子发布数</span>
                                <span class="" onclick="indicator('5',this)">签到数</span>
                                <span class="" onclick="indicator('6',this)">APP下载数</span>
                            </div>
                            </div>

                            <div id="tubiao" style="width: 60%;height: 300px;float: left;">

                            </div>

                            <div id="tubiao1" style="width: 40%;height: 300px;float: left;">

                            </div>
                            <form method="post" id="searchForm" action="${base}/EduStatics//trend.json" autocomplete="off">
                                <a onclick="exportList()" style="    float: right;
    margin-top: 0px;
    margin-right: 19px;">导出</a>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>时间</th>
                                    <th>访客数</th>
                                    <th>用户注册数</th>
                                    <th>视频观看数</th>
                                    <th>帖子发布数</th>
                                    <th>签到数</th>
                                    <th>APP下载数</th>
                                </tr>
                                </thead>
                                <tbody id="tableData">
                                </tbody>

                            </table>
                                <div style="position: absolute;left: 30px;bottom: 45px;">
                                    每页 <input type="text" value="5" style="width: 50px;text-align: center;" id="limit" name="limit" onblur="limitCount()"> 条
                                </div>
                                <div class="paginationNew">
                                    <ul></ul>
                                </div>
                            </form>
                        </div>
            </div>
        </div>
        </div>
    </section>
    </#escape>
</@main.body>
<@main.footer>
    <script src="${base}/assets/js/echarts/echarts-3.5.1-all.js"></script>
    <script type="text/javascript" src="${base}/assets/views/tongji/details.js"></script>
</@main.footer>
