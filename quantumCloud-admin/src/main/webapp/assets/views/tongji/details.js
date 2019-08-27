
//分页新款
(function($) {
        var ms = {
            init: function(obj, args ) {
                return (function() {
                    ms.fillHtml(obj, args);
                    ms.bindEvent(obj, args);
                })();
            },
            fillHtml: function(obj, args ) {
                return (function() {
                        obj.empty();
                        if (args.current > 1) {
                            obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.current-2)+')">&lt;上一页</a></li>');
                        } else {
//                                        obj.remove('.prevPage');
//                                        obj.append('<li class="disabled"><a tabindex="0">&lt;上一页</a></li>');
                        }
                        if (args.current != 1 && args.current >= 4 && args.pageCount != 4) {
                            obj.append('<li class="page-item"><a tabindex="3" onclick="toLocation(0)">'+1+'</a></li>');
                        }
                        if (args.current - 2 > 2 && args.current <= args.pageCount && args.pageCount > 5) {
                            obj.append('<li class="page-item"><span>...</span></li>');
                        }
                        if(args.distinguish==1){
                            var start = args.current - 1
                                , end = args.current + 1;
                        }else {
                            var start = args.current - 2
                                , end = args.current + 2;
                        }

                        if ((start > 1 && args.current < 4) || args.current == 1) {end++;}
                        if (args.current > args.pageCount - 4 && args.current >= args.pageCount) {start--;}
                        for (; start <= end; start++) {
                            if (start <= args.pageCount && start >= 1) {
                                if (start != args.current) {
                                    obj.append('<li class="page-item"><a tabindex="3" onclick="toLocation('+(start-1)+')">'+start+'</a></li>');
                                } else {
                                    obj.append('<li class="page-item active"><a tabindex="3" onclick="toLocation('+(start-1)+')">'+start+'</a></li>');
                                }
                            }
                        }
                        if(args.distinguish!=1){
                            if (args.current + 2 < args.pageCount - 1 && args.current >= 1 && args.pageCount > 5) {
                                obj.append('<li class="page-item"><span>...</span></li>');
                            }
                        }

//                                    if (args.current != args.pageCount && args.current < args.pageCount - 2 && args.pageCount != 4) {
//                                        obj.append('<a href="javascript:;" class="tcdNumber">' + args.pageCount + '</a>');
//                                    }
                        if (args.current < args.pageCount) {
                            obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.result.nextPage-1)+')">下一页&gt;</a></li>');
                        } else {
//                                        obj.remove('.nextPage');
//                                        obj.append('<li class="disabled"><a tabindex="0" onclick="toLocation('+(args.result.nextPage-1)+')">下一页&gt;</a></li>');
                        }

                        if(args.result.length==0){
                            obj.append('<li class="disabled"><a tabindex="0" >暂无数据</a></li>');
                        }
//                                    obj.append('<span class="pagecount">共' + args.pageCount + '页</span>');
//                                    if (args.turndown == 'true') {
//                                        obj.append('<span class="countYe">到第<input type="text" maxlength=' + args.pageCount.toString().length + '>页<a href="javascript:;" class="turndown">确定</a><span>');
//                                    }
                    }
                )();
            },
            bindEvent: function(obj, args) {
                return (function() {
                        obj.on("click", "a.tcdNumber", function() {
                            var current = parseInt($(this).text());
                            ms.fillHtml(obj, {
                                "current": current,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current);
                            }
                        });
                        obj.on("click", "a.prevPage", function() {
                            var current = parseInt(obj.children("span.current").text());
                            ms.fillHtml(obj, {
                                "current": current - 1,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current - 1);
                            }
                        });
                        obj.on("click", "a.nextPage", function() {
                            var current = parseInt(obj.children("span.current").text());
                            ms.fillHtml(obj, {
                                "current": current + 1,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                            if (typeof (args.backFn) == "function") {
                                args.backFn(current + 1);
                            }
                        });
                        obj.on("click", "a.turndown", function() {
                            var page = $("span.countYe input").val();
                            if (page > args.pageCount) {
                                alert("您的输入有误，请重新输入！");
                            }
                            ms.fillHtml(obj, {
                                rusult:args.result,
                                "current": page,
                                "pageCount": args.pageCount,
                                "turndown": args.turndown
                            });
                        });
                    }
                )();
            }
        }
        $.fn.createPage = function(options) {
            var args = $.extend({
                result:'',
                pageCount: 10,
                current: 1,
                distinguish: 0,
                turndown: true,
                backFn: function() {}
            }, options);
            ms.init(this, args);
        }
    }
)(jQuery);

/**
 * Created by Gao.Ning on 2018/8/24.
 */
var siteId = '13422016';
var startDate = $('#startDate').val();
var endDate = $('#startDate').val();
var gran = "day";
var oneday = 1000 * 60 * 60 * 24;
//指标选择器
var metricsName = "";
var metricsName1 = "昨日新老访客分布比例图";
if (!startDate) {
    var date = new Date();
    startDate = timeTody(new Date(date-oneday));
    endDate = startDate;
}
var timeChangeEnd=null;
var timeChangeStart=null;
var timeFlag=0
$(function () {
    $('.datetimepicker-day').datetimepicker({
        format: 'yyyymmdd',
        weekStart: 1,
        autoclose: false,
        value:nowTime(new Date(new Date() - oneday)),
        endDate: nowTime(new Date(new Date() - oneday)),
        startView: 2,
        minView: 2,
        initialDate:nowTime(new Date(new Date() - oneday)),
        forceParse: false,
        language: 'zh-CN',
    }).on('changeDate', function (ev) {

        timeFlag++;
        if(timeFlag==2){

            timeChangeEnd=$("#startTime").val()
            $(this).datetimepicker('hide');
            init(1)
            timeFlag=0;
        }else if(timeFlag==1){
            timeChangeStart=$("#startTime").val()
        }

    });
    metricsName = "访客数";
    init();
})

var metrics = 'visitor_count,new_visitor_count,old_visitor_count';
var method = 'trend/time/a';
var start_index=0
var max_results=5
var init = function (isChange) {
    if(!isChange){
        var date = new Date();
        var endDate1 = timeTody(date);
        var startDate1;
        gran = 'day';
        endDate1 = timeTody(new Date(date));
        startDate1 = endDate1;
        startDate=startDate1
        endDate=startDate1
        $('#startTime').val(startDate1+"-"+endDate1);
    }else {
        if(isChange!==2){
            startDate=timeChangeStart;
            endDate=timeChangeEnd;
            $('#startTime').val(startDate+"-"+endDate);
        }else {
            $('#startTime').val(startDate+"-"+endDate);
        }

    }

    var type = $("#type").val();
    /* var startDate = '20180813';
     var endDate = '20180823';*/
    trenda(siteId, method, startDate, endDate, metrics, 'day',type);
    trendf(start_index,max_results);
    timeChangeEnd=null;
    timeChangeStart=null;
}

//列表
function trenda(siteId, method, startDate, endDate, metrics, gran,type) {
    if(typeof(type) == 'undefined' || type == '' || type == null) {
        type = '1';
        metricsName = "访客数";
    }

    $("#type").val(type);

    $.post(ctx + 'EduStatics/trend.json', {
                siteId: siteId, method: method,
                startDate: startDate, endDate: endDate,
                metrics: metrics,
                gran: gran,
                type:type,
                max_results:0
            },
            function (data) {
                html = '';
                var eduStatistics = data.eduStatisticsVoList;
                var dateList = data.dateList;
                var sumList = data.body.data[0].result.sum;
                var customerCount = 0;
                var registCount = 0;
                var viewVideoCount = 0;
                var publishForumCount = 0;
                var signInCount = 0;
                var appDownLoadCount = 0;
                $.each(eduStatistics, function (i2, val2) {
                    customerCount += val2.customerCount;
                    registCount += val2.registCount;
                    viewVideoCount += val2.viewVideoCount;
                    publishForumCount += val2.publishForumCount;
                    signInCount += val2.signInCount;
                    appDownLoadCount += val2.appDownLoadCount;
                })

                html += '<td>' + customerCount + '</td>';
                html += '<td>' + registCount + '</td>';
                html += '<td>' + viewVideoCount + '</td>';
                html += '<td>' + publishForumCount + '</td>';
                html += '<td>' + signInCount + '</td>';
                html += '<td>' + appDownLoadCount + '</td>';

                html += '</tr>';
                $("#tableList").html(html);

                var arr = [];

                var myChart = echarts.init(document.getElementById('tubiao'));
                var myChart1 = echarts.init(document.getElementById('tubiao1'));
                var sumList = data.body.data[0].result.sum;

                $.each(eduStatistics, function (i1, v1) {
                    arr[i1] = v1.statisticsCount;
                })

                option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: [metricsName]
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: dateList
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        name: metricsName,
                        type: 'line',
                        stack: '总量',
                        data: arr
                    },]
                };

                option1 = {
                    title : {
                        text: metricsName1,
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: ['新访客','老访客']
                    },
                    series : [
                        {
                            name: '访问来源',
                            type: 'pie',
                            radius : '55%',
                            center: ['50%', '60%'],
                            data:[
                                {value:sumList[0][1], name:'新访客'},
                                {value:sumList[0][0]-sumList[0][1], name:'老访客'},
                            ],
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };

                myChart.setOption(option);
                myChart1.setOption(option1);
            })
}



function indicator(type,evt) {
    $(evt).addClass("cur").siblings().removeClass("cur")
    var method = 'trend/time/a';
    var metrics = "visitor_count,new_visitor_count,old_visitor_count";
    if(type == '1') {
        metricsName = "访客数";
    } else if(type == '2') {
        metricsName = "用户注册数";
    } else if(type == '3') {
        metricsName = "视频观看数";
    } else if(type == '4') {
        metricsName = "帖子发布数";
    } else if(type == '5') {
        metricsName = "签到数";
    } else if(type == '6') {
        metricsName = "APP下载数";
    }

    trenda(siteId, method, startDate, endDate, metrics, gran,type);

}

//指标列表
function trendf(start_index,max_results) {
    if(typeof (start_index) == 'undefined' || start_index == '' || start_index == null) {
        start_index = 0;
    }

    if(typeof (max_results) == 'undefined' || max_results == '' || max_results == null) {
        max_results = 0;
    }

    $.post(ctx + 'EduStatics/trend.json', {
                siteId: siteId, method: method,
                startDate: startDate, endDate: endDate,
                metrics: metrics,
                gran: gran,
                start_index:start_index,
                max_results:max_results

            },
            function (data) {
                var eduStatistics = data.eduStatisticsVoList;
                var html = "";
                $.each(eduStatistics, function (i1, v1) {
                    html += '<tr><td>' + v1.addTime + '</td>';
                    html += '<td>' + v1.customerCount + '</td>';
                    html += '<td>' + v1.registCount + '</td>';
                    html += '<td>' + v1.viewVideoCount + '</td>';
                    html += '<td>' + v1.publishForumCount + '</td>';
                    html += '<td>' + v1.signInCount + '</td>';
                    html += '<td>' + v1.appDownLoadCount + '</td></tr>';
                })

                $("#tableData").html(html);
                $(".paginationNew ul").createPage({
                    result:data.eduStatisticsVoList,
                    pageCount:data.pagerSum,//总页数
                    current:start_index/max_results+1,//当前页
                    turndown:'false',//是否显示跳转框，显示为true，不现实为false,一定记得加上引号...
                    backFn:function(p){
                    }
                })
            })
}
function limitCount() {
    max_results=$("#limit").val()
    trendf(start_index,max_results);
}
function toLocation(index) {
    start_index=index*max_results
    trendf(start_index,max_results);
}
function exportList() {
    window.open(ctx + 'EduStatics/exportData.json?siteId='+siteId+'&method='+method+'&startDate='+startDate+'&endDate='+endDate+'&metrics='+metrics+'&gran='+gran+'&max_results=0');
}


function formatSeconds(value) {
    var secondTime = parseInt(value);// 秒
    var minuteTime = 0;// 分
    var hourTime = 0;// 小时
    if (secondTime > 60) {//如果秒数大于60，将秒数转换成整数
        //获取分钟，除以60取整数，得到整数分钟
        minuteTime = parseInt(secondTime / 60);
        //获取秒数，秒数取佘，得到整数秒数
        secondTime = parseInt(secondTime % 60);
        //如果分钟大于60，将分钟转换成小时
        if (minuteTime > 60) {
            //获取小时，获取分钟除以60，得到整数小时
            hourTime = parseInt(minuteTime / 60);
            //获取小时后取佘的分，获取分钟除以60取佘的分
            minuteTime = parseInt(minuteTime % 60);
        }
    }
    var result = "";
    if (secondTime >= 10) {
        result = "" + parseInt(secondTime);
    } else if (minuteTime > 0) {
        result = "0" + parseInt(secondTime);
    } else {
        result = "00" + parseInt(secondTime);
    }
    if (minuteTime >= 10) {
        result = "" + parseInt(minuteTime) + ":" + result;
    } else if (minuteTime > 0) {
        result = "0" + parseInt(minuteTime) + ":" + result;
    } else {
        result = "00" + ":" + result;
    }

    if (hourTime >= 10) {
        result = "" + parseInt(hourTime) + ":" + result;
    } else if (hourTime > 0) {
        result = "0" + parseInt(hourTime) + ":" + result;
    } else {
        result = "00" + ":" + result;
    }
    return result;
}

//获取时间段
function getDate(obj, type) {//time_tody time_yest time_week time_month
    $(obj).addClass("cur").siblings().removeClass("cur")
    $('#date-select-bar').find('span').removeClass('red');
    $('#time-span').find('span').removeClass('cur');
    $(obj).addClass('red');
    var date = new Date();
    var oneday = 1000 * 60 * 60 * 24;
    var endDate1 = timeTody(date);
    var startDate1;
    if (type == 'time_yest') {
        $('#time-span').find('span').removeClass('red');
        $('#by-hour').addClass('red');
        metricsName1 = "昨日新老访客分布比例图"
        endDate1 = timeTody(new Date(date - oneday));
        startDate1 = endDate1;
        $('#startTime').val(startDate1);
    } else if(type == 'time_tody') {
        $('#time-span').find('span').removeClass('red');
        $('#by-hour').addClass('red');
        endDate1 = timeTody(new Date(date));
        startDate1 = endDate1;
        $('#startTime').val('');
    } else if (type == 'time_week') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 7));
        endDate1 = timeTody(new Date(date - oneday));
        metricsName1 = "近7日新老访客分布比例图"
        $('#startTime').val(startDate1);
    } else if (type == 'time_half_month') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 15));
        endDate1 = timeTody(new Date(date - oneday));
        $('#startTime').val(startDate1);
        metricsName1 = "近15日新老访客分布比例图"
    } else if (type == 'time_month') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 30));
        endDate1 = timeTody(new Date(date - oneday));
        $('#startTime').val(startDate1);
        metricsName1 = "近30日新老访客分布比例图"
    }
    $('#startDate').val(startDate1);
    $('#endDate').val(endDate1);
    startDate = startDate1;
    endDate = endDate1;
    init(2);
}

//获取今天时间yyyymmdd
function timeTody(date) {
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }
    return year + '' + month + '' + day
}

//获取今天时间yyyy-mm-dd
function nowTime(date) {
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }
    console.log(year + '-' + month + '-' + day)
    return year + '-' + month + '-' + day
}
//获取gran
function getGran(obj, gran1) {//hour  day week
    $(obj).addClass("cur").siblings().removeClass("cur")
    $('#time-span').find('span').removeClass('red');
    $('.data-time-select').find('span').removeClass('cur');
    $(obj).addClass('red');
    $('#gran').val(gran1);
    gran = gran1;
    init();
}

//选择时间
function getStartDate() {
    // timeFlag++;
    // if(timeFlag==1){
    //     startDate = $('#startTime').val();
    //     $(".datetimepicker-day").click()
    //     $(".input-group-addon").click()
    // }
    // gran = 'day';
    // $('#date-select-bar').find('span').removeClass('red');
    // $('#time-span').find('span').removeClass('red');
    // $('#by-day').addClass('red');
    // $('#startDate').val($('#startTime').val());

    // init();
}

function toPage(page) {
    var method = 'trend/time/a';
    var metrics = "visitor_count,new_visitor_count,old_visitor_count";
    trendf(siteId, method, startDate, endDate, metrics, gran, page);
}