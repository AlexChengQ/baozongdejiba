<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf8">
    <style>
        p {
            line-height: 1;
        }
    </style>
</head>
<body>
<p>主题：量子虚拟机的申请</p>
<p style="margin-top:30px;">账户名：${qcodeApply.userName}</p>
<p style="margin-top:30px;">账户邮箱：${qcodeApply.userEmail}</p>
<p style="margin-top:30px;">姓名：${qcodeApply.name}</p>
<p style="margin-top:30px;">电话：${qcodeApply.phone}</p>
<p style="margin-top:30px;">邮箱：${qcodeApply.email}</p>
<#if qcodeApply.vmType == '1'>
<p style="margin-top:30px;">虚拟机： 56位</p>
</#if>
<#if qcodeApply.vmType == '2'>
<p style="margin-top:30px;">虚拟机：64位</p>
</#if>
<#if qcodeApply.vmType == '3'>
<p style="margin-top:30px;">虚拟机：42位</p>
</#if>
<p style="margin-top:30px;">目的： ${qcodeApply.purpose}</p>
</body>
</html>
