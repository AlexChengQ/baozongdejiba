<@main.header title="推送管理">
<style>
    p {
        line-height: 1;
    }
</style>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <section class="content">
        <ol class="breadcrumb">
            <li></li>
            <li><a href="${base }/QcodePush/index.html">推送管理</a></li>
            <li class="active">预览</li>
        </ol>
        <div class="mailMainArea"
             style="font-size: 14px; font-family: Verdana, 宋体, Helvetica, sans-serif; line-height: 1.66; padding: 8px 10px; margin: 0px; width: auto;">
            <table width="650" bgcolor="#ffffff" align="center" cellpadding="0" cellspacing="0" border="0">
                <tbody>
                <tr>
                    <td width="30"></td>
                    <td width="590">
                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tbody>
                            <tr>
                                <td>
                                    <div style="border-bottom: 1px solid #f3f3f3;padding-bottom: 7px;height: 90px">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                            <tbody>
                                            <tr>
                                                <td align="left" valign="middle" class=""
                                                    style="width: 100%;text-align: center;"><a target="_self" href="#"
                                                                                               _act="check_domail">
                                                    <img src="${base}/assets/images/logo_ben.png" alt="本源量子" border="0"
                                                         style="width: 260px"> </a>
                                                </td>
                                                <td width="218" height="69" bgcolor="#FFFFFF" align="right"><a
                                                        target="_blank" href="" _act="check_domail"> <img src=""
                                                                                                          border="0"
                                                                                                          style=" color:#005aa0; font-size:16px; font-weight:bold;">
                                                </a></td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td height="8"></td>
                            </tr>
                            <tr>
                                <td>
                                    <table align="left" cellpadding="0" cellspacing="0" border="0">
                                        <tbody>
                                        <tr>
                                            <td>主题：${qcodePushVo.title} </td>
                                            <td width="15"></td>

                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="20"></td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                    <td width="30"></td>
                </tr>
                </tbody>
            </table>
            <table class="" width="650" align="center" bgcolor="##002b56" cellpadding="0" cellspacing="0" border="0"
                   style="font-family: Arial, sans-serif;border-collapse: collapse;">
                <tbody>
                <tr>
                    <td  bgcolor="#002b56">
                        <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
                            <tbody>
                            <tr>
                                <td height="31"></td>
                            </tr>
                            <tr>
                                <td  bgcolor="#002b56">
                                    <table width="574" align="center" cellpadding="0" cellspacing="0" border="0"
                                           style="margin: 0 auto;">
                                        <tbody>
                                        <tr>

                                        </tr>
                                        <tr>
                                            <td width="14"></td>
                                            <td bgcolor="#ffffff" style="border-radius: 7px;padding-bottom: 70px;">
                                                <table cellspacing="0" cellpadding="0" border="0" width="505"
                                                       align="center" style="border-bottom: 1px dashed #c9c8c8;">
                                                    <tbody>
                                                    <tr>
                                                        <td  style="padding-left: 25px;"><font
                                                                style="font-size: 24px;line-height: 40px;"
                                                                color=";"> ${qcodePushVo.content} </font></td>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                    <tr>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            <td width="13"  bgcolor="#002b56"></td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="#002b56" height="21" colspan="3"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                </tr>
                </tbody>
            </table>
        </div>
    </section>
    </#escape>
</@main.body>
<@main.footer>
</@main.footer>
