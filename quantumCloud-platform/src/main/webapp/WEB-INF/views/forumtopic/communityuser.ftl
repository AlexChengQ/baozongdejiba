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
        <#--<@main.top3>-->
            <#--<#escape x as x?html>-->
            <#--</#escape>-->
        <#--</@main.top3>-->
        <!--top end-->



    <#--顶部导航栏-->
        <@main.forumTopLevel>
            <#escape x as x?html>
            </#escape>
        </@main.forumTopLevel>


        <style>
            .loca_add{
                position: relative;
            }
        </style>
        <style>

        </style>
    <#--帖子/简介栏-->
        <div class="topicContent" style="margin-top: 20px">
            <div class="topicLeft">
                <div class="userLeft">
                    <div class="user-tab">
                        <div class="ueseTabBox">
                            <ul>
                                <li class="active" style="border-left: 0"><a href="javascript:;" class="Article">帖子</a></li>
                                <li><a href="javascript:;" class="follow">关注</a></li>
                                <li><a href="javascript:;" class="Collection">收藏</a></li>
                                <li style="border-right: 0"><a href="javascript:;" class="Setup">设置</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="user-controller">
                        <div class="userControCase">
                            <div class="userTitle">
                                <img src="${base}/assets/forImg/daohang.png" alt=""><span>资料设置</span>
                            </div>
                            <div class="userCon">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="topicRight">

            </div>
            <div style="clear:both;"></div>
        </div>
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>
        <!--box end-->
    </div>
    </#escape>
</@main.body>
<@main.footer>
<script>
    ;(function ($) {

        // Constructor
        function FT(elem) {
            this.$textarea = $(elem);

            this._init();
        }

        FT.prototype = {
            _init: function () {
                var _this = this;

                // Insert wrapper elem & pre/span for textarea mirroring
                this.$textarea.wrap('<div class="flex-text-wrap" style="min-height: 80px;height: 80px" />').before('<pre class="pre"><span /><br /></pre>');

                this.$span = this.$textarea.prev().find('span');

                // Add input event listeners
                // * input for modern browsers
                // * propertychange for IE 7 & 8
                // * keyup for IE >= 9: catches keyboard-triggered undos/cuts/deletes
                // * change for IE >= 9: catches mouse-triggered undos/cuts/deletions (when textarea loses focus)
                this.$textarea.on('input propertychange keyup change', function () {
                    _this._mirror();
                });

                // jQuery val() strips carriage return chars by default (see http://api.jquery.com/val/)
                // This causes issues in IE7, but a valHook can be used to preserve these chars
                $.valHooks.textarea = {
                    get: function (elem) {
                        return elem.value.replace(/\r?\n/g, "\r\n");
                    }
                };

                // Mirror contents once on init
                this._mirror();
            }

            // Mirror pre/span & textarea contents
            , _mirror: function () {
                this.$span.text(this.$textarea.val());
            }
        };

        // jQuery plugin wrapper
        $.fn.flexText = function () {
            return this.each(function () {
                // Check if already instantiated on this elem
                if (!$.data(this, 'flexText')) {
                    // Instantiate & store elem + string
                    $.data(this, 'flexText', new FT(this));
                }
            });
        };

    })(jQuery);

    $(".ueseTabBox ul li").on("click",function (index) {
        console.log($(this).index())
        $(this).addClass("active").siblings().removeClass("active")

    })
</script>
<!--textarea高度自适应-->
<script type="text/javascript">
    <#--$(".communityDetail_Box").html('${forumTopicVo.content}')-->
    //    console.log()
    $(function () {
        $('#contentbox').flexText();
    });
</script>
<!--textarea限制字数-->
<script type="text/javascript">
    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }
</script>

<script>
    <#--点赞-->
    $(".praise").on("click", function () {
        if ($('.trample').is('.red')){
            return false;
        }
        var praiseIs;
        var praiseCount = $(this).find('.praiseCount').html();
        if ($(this).is('.red')) {
            //return false;
            praiseCount--;
            praiseIs = -1;
            $(this).removeClass("red");
        } else {
            praiseCount++;
            praiseIs = 1;
            $(this).addClass("red");
        }
        $(this).find('.praiseCount').html(praiseCount)
        $.post('${base}/qcode/forumtopic/updForumTopicLike.json', {
            id:${forumTopicVo.id!},
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: 0,
            approvalCount: praiseIs,
            noApprovalCount: ''
        }, function () {
        })

    })
    //    踩
    $(".trample").on("click", function () {
        if ($('.praise').is('.red')){
            return false;
        }
        var trample;
        var trampleCount = $(this).find('.trampleCount').html();
        if ($(this).is('.red')) {
            //return false;
            trampleCount--;
            trample = -1;
            $(this).removeClass("red");
        } else {
            trampleCount++;
            trample = 1;
            $(this).addClass("red");
        }
        $(this).find('.trampleCount').html(trampleCount)
        $.post('${base}/qcode/forumtopic/updForumTopicLike.json', {
            id:${forumTopicVo.id!},
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: 0,
            approvalCount: '',
            noApprovalCount: trample
        }, function () {
        })

    })
</script>
<!--点击评论创建评论条-->
<script type="text/javascript">
    $('.commentAll').on('click', '.plBtn', function () {
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oSize = $(this).siblings('.flex-text-wrap').find('.comment-input').val();
        console.log(oSize);
        //动态创建评论模块
        $.post("${base}/qcode/forumtopic/addForumReply.json", {
            forumTopicId:${forumTopicVo.id},
            parentId: 0,
            content: oSize
        }, function (result) {
            window.location.reload()
        })
        oHtml = '<div class="comment-show-con clearfix"><div class="comment-show-con-list pull-left clearfix" style="clear:none"><div class="pl-text clearfix"> <a href="#" class="comment-size-name">${USER_INFO.name!} : </a> <span class="my-pl-con">&nbsp;' + oSize + '</span> </div> <div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> <div class="date-dz-right pull-right comment-pl-block">' +
                //                '<a href="javascript:;" class="removeBlock">删除</a> ' +
                //                '<a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> ' +
                //                '<span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">666</i>)</a>' +
                ' </div> </div><div class="hf-list-con"></div></div> </div>';
        if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {
            $(this).parents('.reviewArea ').siblings('.comment-show').prepend(oHtml);
            $(this).siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');
        }
    });
</script>
<!--点击回复动态创建回复块-->
<script type="text/javascript">
    $('.comment-show').on('click', '.pl-hf', function () {
        //获取回复人的名字
        var fhName = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        //回复@
        var fhN = '回复@' + fhName;
        //var oInput = $(this).parents('.date-dz-right').parents('.date-dz').siblings('.hf-con');
        var fhHtml = '<div class="hf-con pull-left"> <textarea class="content comment-input hf-input"  style="min-height: 49px;height: 49px;" placeholder="' + fhN + '" onkeyup="keyUP(this)"></textarea>  <a href="javascript:;" class="hf-pl">评论</a> <a href="javascript:;" class="hf-pl-close">取消</a></div>';
        //显示回复
        if ($(this).is('.hf-con-block')) {
            $(this).parents('.date-dz-right').parents('.date-dz').append(fhHtml);
            $(this).removeClass('hf-con-block');
            $('#contentbox').flexText();
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.pre').css('padding', '6px 15px');
            //console.log($(this).parents('.date-dz-right').siblings('.hf-con').find('.pre'))
            //input框自动聚焦
            $(this).parents('.date-dz-right').siblings('.hf-con').find('.hf-input').val('').focus();
        } else {
            $(this).addClass('hf-con-block');
            $(this).parents('.date-dz-right').siblings('.hf-con').remove();
        }
    });
    $(".comment-show").on("click",".hf-pl-close",function () {
        $(this).parent().siblings('.date-dz-right').children(".pl-hf").addClass('hf-con-block');
        $(this).parent().remove();
    })
</script>
<!--评论回复块创建-->
<script type="text/javascript">
    $('.comment-show').on('click', '.hf-pl', function () {
        var oThis = $(this);
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();       //获取当前小时数(0-23)
        var m = myDate.getMinutes();     //获取当前分钟数(0-59)
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oHfVal = $(this).siblings('.flex-text-wrap').find('.hf-input').val();
        console.log(oHfVal)
        var oHfName = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.comment-size-name').html();
        var oHid = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.parentId').html();
        var repdUserId = $(this).parents('.hf-con').parents('.date-dz').siblings('.pl-text').find('.repdUserId').html();
        var oAllVal = '回复@' + oHfName;
        if (oHfVal.replace(/^ +| +$/g, '') == '' || oHfVal == oAllVal) {

        }
        else {
//            $.getJSON("http://www.jq22.com/demo/jQueryWbPl201705260102/json/pl.json",function(data){
            var data = [{}];
            var oAt = '';
            var oHf = '';
            $.each(data, function (n, v) {
                delete v.hfContent;
                delete v.atName;

                var arr;
                var ohfNameArr;
                if (oHfVal.indexOf("@") == -1) {
                    data['atName'] = '';
                    data['hfContent'] = oHfVal;
                } else {
                    arr = oHfVal.split(':');
                    ohfNameArr = arr[0].split('@');
                    data['hfContent'] = arr[1];
                    data['atName'] = ohfNameArr[1];
                }

                if (data.atName == '') {
                    oAt = data.hfContent;
                } else {
                    oAt = '@<a href="#" class="atName">' + data.atName + '</a> : ' + data.hfContent;
                }
                oHf = data.hfName;
            });
            $.post("${base}/qcode/forumtopic/addForumReply.json", {
                forumTopicId:${forumTopicVo.id},
                repdUserId: repdUserId,
                parentId: oHid,
                content: oHfVal
            }, function (result) {
                window.location.reload()
            })
            var oHtml = '<div class="all-pl-con" style="width:93%"><div class="pl-text hfpl-text clearfix"><a href="#" class="comment-size-name">${USER_INFO.name!} : </a><span class="my-pl-con">' + oAt + '</span></div><div class="date-dz"> <span class="date-dz-left pull-left comment-time">' + now + '</span> <div class="date-dz-right pull-right comment-pl-block"> ' +
                    //                    '<a href="javascript:;" class="removeBlock">删除</a> ' +
                    //                    '<a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> ' +
                    //                    '<span class="pull-left date-dz-line">|</span> <a href="javascript:;" class="date-dz-z pull-left"><i class="date-dz-z-click-red"></i>赞 (<i class="z-num">666</i>)</a>' +
                    ' </div> </div></div>';
            oThis.parents('.hf-con').parents('.comment-show-con-list').find('.hf-list-con').css('display', 'block').prepend(oHtml) && oThis.parents('.hf-con').siblings('.date-dz-right').find('.pl-hf').addClass('hf-con-block') && oThis.parents('.hf-con').remove();
//            });
        }
    });
</script>

<!--点和踩-->
<script type="text/javascript">
    $('.comment-show').on('click', '.date-dz-z', function () {
        if ($(this).siblings('.date-dz-c').is('.date-dz-z-click')){
            return false;
        }

        var id = $(this).parents('.date-dz').siblings('.pl-text').find('.replyId').html();
        var zNum = $(this).find('.z-num').html();
        var count;
        if ($(this).is('.date-dz-z-click')) {
            //return false;
            zNum--;
            count = -1;
        } else {
            zNum++;
            count = 1;
        }
        $(this).toggleClass('date-dz-z-click');
        $(this).find('.z-num').html(zNum);
        $(this).find('.date-dz-z-click-red').toggleClass('red');
        $(this).find('.fa-thumbs-up').toggleClass('red');
        $.post('${base}/qcode/forumtopic/updReplyLike.json', {
            id: id,
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: id,
            approvalCount: count,
            noApprovalCount: ''
        }, function () {
        })
    })
    $('.comment-show').on('click', '.date-dz-c', function () {
        if ($(this).siblings('.date-dz-z').is('.date-dz-z-click')){
            return false;
        }
        var id = $(this).parents('.date-dz').siblings('.pl-text').find('.replyId').html();
        var zNum = $(this).find('.z-num').html();
        var count;
        if ($(this).is('.date-dz-z-click')) {
            //return false;
            zNum--;
            count = -1;
        } else {
            zNum++;
            count = 1;
        }
        $(this).toggleClass('date-dz-z-click');
        $(this).find('.z-num').html(zNum);
        $(this).find('.date-dz-z-click-red').toggleClass('red');
        $(this).find('.fa-thumbs-down').toggleClass('red');
        $.post('${base}/qcode/forumtopic/updReplyLike.json', {
            id: id,
            forumTopicId:${forumTopicVo.id!},
            forumReplyId: id,
            approvalCount: '',
            noApprovalCount: count
        }, function () {
        })
    })
</script>


<script>
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


</script>
</@main.footer>
