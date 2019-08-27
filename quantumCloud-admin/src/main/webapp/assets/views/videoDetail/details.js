/**
 * Created by Gao.Ning on 2018/8/24.
 */
var startDate = $('#startDate').val();
var endDate = $('#startDate').val();
var gran = "day";
var oneday = 1000 * 60 * 60 * 24;
//指标选择器
if (!startDate) {
    var date = new Date();
    startDate = timeTody(new Date(date-oneday));
    endDate = startDate;
}
var timeChangeEnd=null;
var timeChangeStart=null;
var onlyChangeEnd=null;
var onlyChangeStart=null;
var timeFlag=0
$(function () {
    var yesTime=nowTime(new Date(new Date() - oneday))
    console.log()
    $('.datetimepicker-day').datetimepicker({
        format: 'yyyymmdd',
        weekStart: 1,
        autoclose: false,
        value:yesTime,
        endDate: yesTime,
        startView: 2,
        minView: 2,
        initialDate:yesTime,
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

    
    $('.datetimepicker-day2').datetimepicker({
        format: 'yyyymmdd',
        weekStart: 1,
        autoclose: false,
        value:yesTime,
        endDate: yesTime,
        startView: 2,
        minView: 2,
        initialDate:yesTime,
        forceParse: false,
        language: 'zh-CN',
    }).on('changeDate', function (ev) {
        timeFlag++;
        if(timeFlag==2){

            onlyChangeEnd=$("#OnlyTime").val()
            $(this).datetimepicker('hide');
            getList(1);
            timeFlag=0;
        }else if(timeFlag==1){
            onlyChangeStart=$("#OnlyTime").val()
        }

    });
    init();
})

var init = function (isChange) {
    if(!isChange){
        var date = new Date();
        var endDate1 = timeTody(date);
        var startDate1;
        gran = 'day';
        endDate1 = timeTody(new Date(date - oneday));
        startDate1 =  timeTody(new Date(date - oneday*7));
        startDate=startDate1
        endDate=endDate1
        $('#startTime').val(startDate1+"-"+endDate1);
    }else {
        startDate=timeChangeStart;
        endDate=timeChangeEnd;
        $('#startTime').val(startDate+"-"+endDate);
    }

    var method = 'trend/time/a';
    var metrics = 'visitor_count,new_visitor_count,old_visitor_count';
    /* var startDate = '20180813';
     var endDate = '20180823';*/
    trenda(startDate, endDate,'1');
    // timeChangeEnd=null;
    // timeChangeStart=null;
}

//列表
function trenda(startDate, endDate,type) {
    $.post(ctx + 'videoDetail/getVideoSingle.json', {
                startDate: startDate, endDate: endDate,
                type:type,
            },
            function (data) {
                var arr1 = [];
                var arr2 = [];
                var dateList = data.obj.dateList;
                var frequencyDataNum = data.obj.frequencyData;
                var peopleDataNum = data.obj.peopleData;

                var myChart = echarts.init(document.getElementById('tubiao'));

                option = {
                    title: {
                        text: '视频数据详细'
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['播放次数','播放人数']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    toolbox: {
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: dateList
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            name:'播放次数',
                            type:'line',
                            stack: '总量',
                            data:frequencyDataNum
                        },
                        {
                            name:'播放人数',
                            type:'line',
                            stack: '总量',
                            data:peopleDataNum
                        }
                    ]
                };
                myChart.setOption(option);
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
function trendf(siteId, method, startDate, endDate, metrics, gran,start_index) {
    $.post(ctx + 'EduStatics/trend.json', {
                siteId: siteId, method: method,
                startDate: startDate, endDate: endDate,
                metrics: metrics,
                gran: gran,
                // start_index:start_index,
                max_results:0

            },
            function (data) {
                var datlist = data.body.data[0].result.items;
                var eduStatistics = data.eduStatisticsVoList;
                var html = "";
                $.each(datlist[1], function (i1, v1) {
                    html += '<tr><td>'+datlist[0][i1]+'</td><td>'+v1[0]+'</td>';
                    if(typeof (eduStatistics[i1]) != 'undefined') {
                        html += '<td>'+eduStatistics[i1].registCount+'</td>' +
                            '<td>'+eduStatistics[i1].viewVideoCount+'</td>' +
                            '<td>'+eduStatistics[i1].publishForumCount+'</td>' +
                            '<td>'+eduStatistics[i1].signInCount+'</td>' +
                            '<td>'+eduStatistics[i1].appDownLoadCount+'</td></tr>';
                    }else {
                        html += '<td>0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr>';
                    }
                })

                $("#tableData").html(html);

            })
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
        startDate1 = endDate1;
        $('#startTime').val('');
    } else if (type == 'time_week') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 6));
        endDate1 = timeTody(new Date(date - oneday));
        metricsName1 = "近7日新老访客分布比例图"
        $('#startTime').val(startDate1);
    } else if (type == 'time_half_month') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 14));
        endDate1 = timeTody(new Date(date - oneday));
        $('#startTime').val(startDate1);
        metricsName1 = "近15日新老访客分布比例图"
    } else if (type == 'time_month') {
        gran = 'day';
        $('#time-span').find('span').removeClass('red');
        $('#by-day').addClass('red');
        startDate1 = timeTody(new Date(date - oneday * 29));
        endDate1 = timeTody(new Date(date - oneday));
        $('#startTime').val(startDate1);
        metricsName1 = "近30日新老访客分布比例图"
    }
    $('#startDate').val(startDate1);
    $('#endDate').val(endDate1);
    startDate = startDate1;
    endDate = endDate1;
    init();
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

