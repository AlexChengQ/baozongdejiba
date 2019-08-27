<#-----author:liuxiantao------->
<#-----date:2017-04-07------->
<@main.header title="视频数据概览">

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
                        .videoDataTabs{
                            font-size: 20px;
                            padding-top: 20px;
                            padding-bottom: 30px;

                        }

                        .videoDataTabs ul li{
                            color: #333333;
                            height: 30px;
                            line-height: 28px;
                            margin: 0 15px;
                            list-style: none;
                            outline: none;
                            float: left;
                            border-bottom: 2px solid #fff;
                        }
                        .videoDataTabs ul li.active{
                            color: #88b549;
                            height: 30px;
                            line-height: 28px;
                            border-bottom: 2px solid #88b549;
                        }
                        .tjBox{
                            padding-left: 55px;
                            padding-right: 55px;
                        }
                        .dataTips{
                            color: #333333;
                            font-size: 14px;
                            padding-bottom: 20px;

                        }
                        .dataTj{
                            border: 1px solid #c0c0c0;
                            -moz-box-shadow:2px 2px 5px #c0c0c0; -webkit-box-shadow:2px 2px 5px #c0c0c0; box-shadow:2px 2px 5px #c0c0c0;
                            margin-bottom: 25px;
                        }
                        .dataFlex{
                            display: flex;
                            flex: 1;
                            text-align: center;
                        }
                        .dTitle{
                            line-height: 30px;
                            color: #333;
                            font-size: 18px;
                            padding-left: 10px;
                            margin: 15px 0;
                        }
                        .dataFlexCon{
                            flex: 1;
                            color: #333333;
                            padding-bottom: 25px;
                            font-size: 14px;
                        }
                        .dataFlexCon .num{
                            font-size: 26px;
                            line-height: 30px;
                        }
                        li{
                            list-style: none;
                        }
                        .vdbList ul li{
                            height: 36px;

                            margin-bottom: 16px;
                        }
                        .vdbList li .vdbLeft,.vdbList li .vdbRight{
                            float: left;
                        }
                        .vdbLeft{
                            width: 96px;
                            line-height: 36px;
                            color: #797979;
                        }
                        .vdbRight{
                            line-height: 36px;
                        }
                        .vdbTab li{

                        }
                        .vdbTabSecond{
                            border: 1px solid #cccccc;
                            overflow: hidden;
                            padding: 0;
                        }
                        .vdbTabSecond li{
                            float: left;
                            line-height: 34px;
                            padding: 0 15px;
                            margin: 0!important;
                           border-right: 1px solid #cccccc;
                        }
                        .vdbTabSecond li:last-child{
                            border: none;
                        }
                        .vdbTabSecond li.active{
                            background: #44b549;
                            color: #fff;
                        }
                        .tabsList{
                            display: none;
                        }
                    </style>
                    <div class="box ">
                        <div class="videoDataTabs">
                            <ul>
                                <li class="active"><span>全部视频</span></li>
                                <li><span>单个视频</span></li>
                                <div style="clear: both;"></div>
                            </ul>
                        </div>
                        <div class="tabsContent">
                            <div class="tabsList" style="display:block;">
                                <div class="tjBox">
                                    <div class="dataTips">
                                        <#--统计包含近三个月的视频数据-->
                                    </div>
                                    <div class="dataTj">
                                        <div class="dTitle">昨天关键数据</div>
                                        <div class="dataFlex">
                                            <div class="dataFlexCon">
                                                <div>总播放（次）</div>
                                                <div class="num">${videoDetail.totalView}</div>
                                            </div>
                                            <div class="dataFlexCon">
                                                <div>总分享（次）</div>
                                                <div class="num">${videoDetail.totalShare}</div>
                                            </div>
                                            <div class="dataFlexCon">
                                                <div>总评论（次）</div>
                                                <div class="num">${videoDetail.totalReply}</div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="dataTj">
                                        <div class="dTitle">视频数据明细</div>
                                        <div class="videoDataBox">
                                            <div class="vdbList">
                                                <ul>
                                                    <li>
                                                        <div class="vdbLeft">数据指标</div>
                                                        <div class="vdbRight">
                                                            <ul class="vdbTabSecond">
                                                                <li class="active"><span>视频播放</span></li>
                                                                <li><span>视频分享</span></li>
                                                                <li><span>视频评论</span></li>
                                                            </ul>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="vdbLeft">数据指标</div>
                                                        <div class="vdbRight">
                                                            <div class="" id="date-select-bar" style="margin-top: 7px">

                                                                    <span class="" id="custom-date-select"  onchange="getStartDate()">
                                        <div class="input-group data-time-input date datetimepicker-day" data-date=""
                                             data-date-format="yyyymmdd">
                                            <input style="width: 160px" class="" id="startTime" name="publishTime" type="text" value="" placeholder="请选择开始时间"
                                                   readonly>
                                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
                                            <span class="input-group-addon" style= ""><span class="glyphicon glyphicon-th"></span></span>
                                        </div>

                                    </span>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li style="height: 100%;overflow: hidden;">
                                                        <div class="vdbLeft">数据趋势</div>
                                                        <div class="vdbRight" style="width: 100%;float:none;;">
                                                            <div id="tubiao" style="width: 60%;height: 300px;float: left;min-width: 510px">

                                                            </div>
                                                        </div>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>

                                    </div>
                                    <div style="height: 50px"> </div>
                                </div>
                            </div>
                            <div class="tabsList">
                                <div class="tjBox">
                                    <div class="" style="overflow: hidden">
                                        <div class="vdbLeft" style="float: left;">数据指标</div>
                                        <div class="vdbRight" style="float:left;">
                                            <div class="" id="date-select-bar" style="margin-top: 7px">

                                                                    <span class="" id="custom-date-select" >
                                        <div class="input-group data-time-input date datetimepicker-day2" data-date=""
                                             data-date-format="yyyymmdd">
                                            <input style="width: 160px" class="" id="OnlyTime" name="publishTimeOnly" type="text" value="" placeholder="请选择开始时间"
                                                   readonly>
                                        <#--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>-->
                                            <span class="input-group-addon" style= ""><span class="glyphicon glyphicon-th"></span></span>
                                        </div>

                                    </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div style="height: 20px"></div>
                                <form method="post" id="searchForm" action="${base}/videoDetail/getListVide.html" autocomplete="off">
                                    <div class="pageBox"></div>
                                </form>
                                <div style="height: 50px"></div>
                            </div>
                        </div>

                    </div>
        </div>
        </div>
    </section>

    </#escape>
</@main.body>
<@main.footer>
    <script src="${base}/assets/js/echarts/echarts-3.5.1-all.js"></script>
    <script type="text/javascript" src="${base}/assets/views/videoDetail/details.js"></script>
<script>
    $(".videoDataTabs ul li").on("click",function () {
        $(this).addClass("active").siblings().removeClass("active")
        $(".tabsList").eq($(this).index()).show().siblings().hide()
        if($(this).index()){
            window.location.href="${base}/videoDetail/index.html"+"#1"
            getList()
        }else {
            window.location.href="${base}/videoDetail/index.html"+"#0";
            trenda(startDate, endDate,1)
        }
    })
    $(".vdbTabSecond li").on("click",function () {
        $(this).addClass("active").siblings().removeClass("active")
        trenda(startDate, endDate,$(this).index()+1)
    })

    $(function () {
        console.log(Number(window.location.hash.substring(1)))
        if(Number(window.location.hash.substring(1))){
            $(".tabsList").eq(1).show().siblings().hide()
            $(".videoDataTabs li").eq(1).click()
            getList()
        }
    })

    //查询视频
    var onlySDate=null
    var onlyEDate=null
    function getList(isChange) {
        if(isChange!=2){
            if(!isChange){
                var date = new Date();
                var onlyDate1 = timeTody(new Date(date - oneday));
                var onlyDate2 =  timeTody(new Date(date - oneday*7));
                onlySDate=onlyDate2
                onlyEDate=onlyDate1
                $('#OnlyTime').val(onlyDate2+"-"+onlyDate1);
            }else {
                onlySDate=onlyChangeStart;
                onlyEDate=onlyChangeEnd;
                $('#OnlyTime').val(onlySDate+"-"+onlyEDate);
            }
        }

        $.ajax({
            url:"${base}/videoDetail/getListVide.html",
            data:{
                startDate:onlySDate,
                endDate:onlyEDate,
                start:$("#startId").val()
            },
            dataType:"html",
            async:false,
            success:function(data) {
                if(data) {
                   // console.log(data)
                    $(".pageBox").html(data)
                }
            }
        })
    }

    function exportList() {
        window.open("${base}/videoDetail/exportData.json?startDate="+onlySDate+"&endDate="+onlyEDate);
        <#--$.post("${base}/videoDetail/exportData.json",{"startDate":onlySDate,"endDate":onlyEDate},function (result) {-->
            <#---->
        <#--})-->
    }

</script>
</@main.footer>
