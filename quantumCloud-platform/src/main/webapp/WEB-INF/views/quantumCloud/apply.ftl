<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>

<script>

    function telcheck(){
        var input=$("#phone").val();
        input=input.replace(/[^\d]/g,'');
        $("#phone").val(input);
    }
    window.onload = function () {
        var login=<#if USER_INFO??>1<#else>0</#if>;
        <#if USER_INFO??>
            var text='<div style="margin: 0 auto; padding-top:200px;text-align: center;padding-bottom:250px;">'+
                    '<img src="${base}/assets/images/loading.gif" style="width:210px;" height="210" />'+
                    '<p style="color:#333;font-size: 28px;padding-top: 20px;">您已成功申请,请耐心等待回复</p>'+
                    '</div>'

            <#if (isApply == '1')>
                document.getElementById("context").innerHTML=text;
            </#if>
        <#else>
//            viewLoginMin();
        </#if>
    }
</script>
</@main.header>
<@main.body>
    <#escape x as x?html>
    <div class="content" style="min-height:500px; min-width:1336px;">
        <!--top-->
        <@main.top5>
            <#escape x as x?html>
            </#escape>
        </@main.top5>
        <!--top end-->
        <div class="pic">
        <#--<img src="${base}/assets/images/pic_5.jpg" width="100%"/>-->
        </div>

        <div id="context" class="company-title m-b-30"  style="margin:0px auto 0px auto; width:500px;" min-height="600px">
            <!--#if (isApply == '1')>
            <div style="margin: 0 auto; padding-top:200px;text-align: center;padding-bottom:250px;">
                <img src="${base}/assets/images/loading.gif" style="width:210px;" height="210" />
                <p style="color:#333;font-size: 28px;padding-top: 20px;">您已成功申请，请耐心等待回复</p>
            </div-->
            <!--#else -->
            <div class="map" style="text-align: left;width:500px;padding-bottom:0px;">
                <div class="msg">
                    <form>
                        <h3 style="text-align: center;padding-bottom: 20px;"><@spring.message code="apply_message" /></h3>
                        <div class="form-group">
                            <label for="name"><@spring.message code="apply_name" /></label>
                            <input type="text" class="form-control" id="name"
                                   placeholder="<@spring.message code='placeholder_apply_name' />" maxlength="20" onfocus="this.placeholder=''"
                                   onblur="this.placeholder='<@spring.message code='placeholder_apply_name' />'">
                        </div>

                        <div class="form-group">
                            <label for="phone"><@spring.message code="apply_phone" /></label>
                            <input type="text" class="form-control" id="phone"
                                   placeholder="<@spring.message code='placeholder_apply_phone' />" maxlength="11" onfocus="this.placeholder=''"
                                   onblur="this.placeholder='<@spring.message code='placeholder_apply_phone' />'" oninput="telcheck()">
                        </div>

                        <div class="form-group">
                            <label for="email"><@spring.message code="apply_email" /></label>
                            <input type="text" class="form-control" id="email"
                                   placeholder="<@spring.message code='placeholder_apply_email' />" maxlength="50" onfocus="this.placeholder=''"
                                   onblur="this.placeholder='<@spring.message code='placeholder_apply_email' />'">
                        </div>

                        <div class="form-group">
                            <label for="vmType"><@spring.message code="apply_vmType" /></label>
                        <#--<input type="text" class="form-control" id="vmType"-->
                        <#--placeholder="<@spring.message code='placeholder_apply_vmType' />" maxlength="50" onfocus="this.placeholder=''"-->
                        <#--onblur="this.placeholder='<@spring.message code='placeholder_apply_vmType' />'">-->
                            <select class="form-control" id="vmType">
                                <option value="0"><@spring.message code='placeholder_apply_vmType' /></option>
                                <option value="3">42位</option>
                                <option value="1">56位</option>
                                <option value="2">64位</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="purpose"><@spring.message code="apply_purpose" /></label>
                            <textarea id="purpose" class="form-control" rows="3"
                                      placeholder="<@spring.message code='placeholder_apply_purpose' />" maxlength="500" onfocus="this.placeholder=''"
                                      onblur="this.placeholder='<@spring.message code='placeholder_apply_purpose' />'"
                                      style="resize:none;"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="code"><@spring.message code="verification_code" /></label></br>
                            <input type="text" id="captcha" name="captcha" class="form-control"
                                   placeholder="<@spring.message code='placeholder_captcha' />" maxlength="10" onfocus="this.placeholder=''"
                                   onblur="this.placeholder='<@spring.message code='placeholder_captcha' />'"
                                   style="width:70%;display:inline;">
                            <img id="captchaImage" src="${base}/assets/vcode_image.jsp"/>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" id="iAgree"> <span><@spring.message code='app_agree' /></span><a href="http://userapplyprotocol.qubitonline.cn/" target="_blank" style="color:#30a5ff" data-i18n="Register.agreement">《<@spring.message code='app_Service' />》</a>
                                        <!-- 按钮触发模态框 -->
                                    <#--</br>-->
                                    <#--<a class="" data-toggle="modal" data-target="#myModal">-->
                                    <#--阅读并遵守协议规章制度-->
                                    <#--</a>-->
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div style="text-align: center">
                            <button type="button" class="btn btn-primary"
                                    onclick="subimitUserApply();"><@spring.message code="apply_submit" /></button>
                        </div>
                    </form>
                </div>
            </div>
            <!--/#if-->
        </div>

    </div>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-show="true" data-backdrop="false" aria-hidden="true" >
        <div class="modal-content" style="width: 1000px;margin: 50px auto 0">
            <div class="modal-header">
            <#--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">-->
            <#--&times;-->
            <#--</button>-->
                <h4 class="modal-title" id="myModalLabel">
                    本源量子计算云平台服务协议
                </h4>
            </div>
            <div class="modal-body" style="height: 400px;overflow-y: auto">
                <style>
                    .AgreementBox{
                        padding: 40px;text-align: left
                    }
                    .Agreement{
                        padding-left: 30px
                    }
                    .Agreement_header{
                        font-weight:700;font-size: 20px
                    }
                    .Agreement_content{
                        padding-left: 30px;
                    }
                    .Agreement_content p{
                        color: #000;
                    }
                    .Agreement_list1{
                        padding: 5px 0;
                    }
                    .Agreement_bold,.Agreement_bold_list{
                        font-weight: 700;
                    }
                    .Agreement_bold span{
                        font-weight: 400;
                    }
                    .Agreement_list1 span{
                        font-weight: 700;
                    }
                    .padd_list_left{
                        padding-left: 20px;
                    }
                </style>
                <div class="company-title m-b-30"  style="margin:0px auto 0px auto; width:100%;">
                    <div class="header">
                        <h1>本源量子计算云平台服务协议</h1>
                    </div>
                    <div class="AgreementBox">
                        <div class="Agreement">
                            <div class="Agreement_header" >【首部及导言】</div>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">欢迎您使用本源量子计算云平台的服务！</p>
                                <p class="Agreement_bold">为使用本源量子计算云平台的服务，您应当阅读并遵守《本源量子计算云平台服务协议》（以下简称“本协议”）。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款、管辖与法律适用条款，以及开通或使用某项服务的单独协议。限制、免责条款可能以黑体加粗或加下划线的形式提示您重点注意。除非您已阅读并接受本协议所有条款，否则您无权使用本源量子计算云平台量子计算云平台提供的服务。您使用本源量子计算云平台的服务即视为您已阅读并同意上述协议的约束。</p>
                                <p class="Agreement_bold">如果您未满14周岁，请在法定监护人的陪同下阅读本协议，并特别注意未成年人使用条款。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >一、【协议的范围】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">1.1本协议是您与本源量子之间关于用户使用本源量子计算云平台相关服务所订立的协议。“本源量子计算云平台”是指本源量子计算公司及其相关服务可能存在的运营关联单位。“用户”是指使用本源量子计算云平台相关服务的使用人，在本协议中更多地称为“您”。！</p>
                                <p class="Agreement_list1">1.2本协议项下的服务是指本源量子计算云平台向用户提供的包括：在一定范围内自由选择执行的量子线路；获取全部数据的权利归用户所有等服务（以下简称“本服务”）。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >二、【帐号与密码安全】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">2.1您在使用本源量子计算云平台的服务时可能需要注册一个帐号，该账号可与微信账号进行绑定使用。</p>
                                <p class="Agreement_bold">2.2本源量子计算云平台特别提醒您应妥善保管您的帐号和密码。当您使用完毕后，应安全退出。因您保管不善可能导致遭受盗号或密码失窃，责任由您自行承担。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >三、【用户个人信息保护】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">3.1保护用户个人信息是本源量子计算云平台的一项基本原则。本源量子计算云平台将按照规定收集、使用、储存和分享您的个人信息。</p>
                                <p class="Agreement_list1">3.2您在注册帐号或使用本服务的过程中，可能需要填写一些必要的信息。若国家法律法规有特殊规定的，您需要填写真实的身份信息。若您填写的信息不完整，则无法使用本服务或在使用过程中受到限制。</p>
                                <p class="Agreement_list1">3.3一般情况下，您可随时浏览、修改自己提交的程序，但出于安全性的考虑，您可能无法修改注册时提供的初始注册信息及其他验证信息。</p>
                                <p class="Agreement_list1">3.4本源量子计算云平台将运用各种安全技术和程序建立完善的管理制度来保护您的个人信息，以免遭受未经授权的访问、使用或披露。</p>
                                <p class="Agreement_bold">
                                    3.5本源量子计算云平台不会将您的个人信息转移或披露给任何非关联的第三方，除非：
                                <p class="Agreement_bold_list">（1）相关法律法规或法院、政府机关要求；</p>
                                <p class="Agreement_bold_list">（2）为完成合并、分立、收购或资产转让而转移；</p>
                                <p class="Agreement_bold_list">（3）为提供您要求的服务所必需。</p>
                                </p>
                                <p class="Agreement_list1">3.6本源量子计算云平台非常重视对未成年人个人信息的保护。若您是14周岁以下的未成年人，在使用本源量子计算云平台的服务前，应事先取得您家长或法定监护人（以下简称"监护人"）的书面同意。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >四、【使用本服务的方式】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">4.1除非您与本源量子计算云平台另有约定，<span style="font-weight: 700">您同意本服务仅为您个人非商业性质的使用</span>。</p>
                                <p class="Agreement_list1">
                                    4.2您应当通过本源量子计算云平台提供或认可的方式使用本服务。您依本协议条款所取得的权利不可转让。使用方式及流程如下：
                                <p class="Agreement_bold padd_list_left">1.在线填写申请表，确定需要进行的任务种类：42位/56位/64位量子虚拟机，申请使用的目的，填写联系方式。</p>
                                <p class="Agreement_bold padd_list_left">2.您同意本源量子计算云平台本协议下提供的服务即可联系本源量子oqc@originqc.com，确定要运行的任务，并签订合同订购机时。</p>
                                <p class="Agreement_bold padd_list_left">3.您了解并同意等待机时空闲时开始计算，计算完成后返回结果，您可通过邮寄移动硬盘的方式获取原始数据。</p>
                                </p>
                                <p class="Agreement_list1">4.3您不得使用未经本源量子计算云平台授权的插件、外挂或第三方工具对本协议项下的服务进行干扰、破坏、修改或施加其他影响。</p>

                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >五、【按现状提供服务】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">
                                    您理解并同意，
                                    <span>本源量子计算云平台的服务是按照现有技术和条件所能达到的现状提供的。本源量子计算云平台会尽最大努力向您提供服务</span>
                                    ，并保证在计算结束后7天内（超过7天不提供保存服务），保证您的数据安全，
                                    <span>确保服务的连贯性和安全性；</span>
                                    但本源量子计算云平台不能随时预见和防范法律、技术以及其他风险，包括但不限于不可抗力、病毒、木马、黑客攻击、系统不稳定、第三方服务瑕疵、政府行为等原因可能导致的服务中断、数据丢失以及其他的损失和风险，且不能因质疑其结果的正确性，而要求免费重新体验本协议下所规定服务。
                                </p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header" >六、【服务收费说明】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">6.1如您使用收费服务，请遵守本条协议。
                                <p class="Agreement_list1 padd_list_left">
                                    本源量子计算云平台的 <span>64位量子虚拟机</span>服务是以收费方式提供的，64位量子虚拟机运算的基本费用为
                                    <span>3000元人民币</span>
                                    ，此外
                                    <span>64位模拟量子计算</span>
                                    的使用以计时收取费用，使用费用为
                                    <span>50000元人民币/天</span>。
                                </p>
                                <p class="Agreement_list1 padd_list_left">
                                    本源量子计算云平台的
                                    <span>56位量子虚拟机</span>
                                    服务是以收费方式提供的，56位量子虚拟机运算的基本费用为
                                    <span>200元人民币</span>
                                    ，此外
                                    <span>56位模拟量子计算</span>
                                    的使用以计时收取费用，其中日使用费用为
                                    <span>200元人民币/小时</span>
                                    。
                                </p>
                                <p class="Agreement_list1 padd_list_left">本源量子计算云平台的
                                    <span>42位量子虚拟机</span>
                                    服务是以收费方式提供的，42位量子虚拟机运算
                                    的基本费用为
                                    <span>100元人民币</span>
                                    ，此外
                                    <span>42位模拟量子计算</span>
                                    的使用以计时收取费用，其中日使用费用为
                                    <span>100元人民币/小时</span>
                                    。
                                </p>
                                </p>

                                <p class="Agreement_list1"><span class="red">6.2本源量子计算云平台可能根据实际需要对收费服务的收费标准、方式进行修改和变更，本源量子计算云平台也可能会对部分免费服务开始收费。前述修改、变更或开始收费前，本源量子计算云平台将在相应服务页面进行通知或公告。以上费用仅供参考，具体费用须根据您申请的计算要求来进行测算。</span>如果您不同意上述修改、变更或付费内容，则应停止使用该服务。</p>

                            </div>
                        </div>

                        <div class="Agreement">
                            <h1 class="Agreement_header" >七、【使用本服务须遵守的约定】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">除非本源量子计算云平台书面许可，您不得从事下列任一行为：</p>
                                <p class="Agreement_list1 padd_list_left">（1）删除本源量子计算云平台<span class="">及其副本上关于著作权的信息；</span></p>
                                <p class="Agreement_list1 padd_list_left">（2）对本源量子计算云服务平台进行反向工程、反向汇编、反向编译，或者以其他方式尝试发现该平台的源代码； </p>
                                <p class="Agreement_list1 padd_list_left">（3）对本源量子计算云平台拥有知识产权的内容进行使用、出租、出借、复制、修改、链接、转载、汇编、发表、出版、建立镜像站点等。</p>
                            </div>
                        </div>

                        <div class="Agreement">
                            <h1 class="Agreement_header" >八、【知识产权声明】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">8.1本源量子计算公司在本服务中提供的内容（包括但不限于网页、文字、图片、音频、视频、图表等）的知识产权归本源量子计算公司所有，用户在使用本服务中所产生的内容的知识产权归用户或相关权利人所有。</p>
                                <p class="Agreement_list1">8.2除另有特别声明外，本源量子计算云平台提供本服务时所依托软件的著作权、专利权及其他知识产权均归本源量子计算云平台所有。</p>
                                <p class="Agreement_list1">8.3本源量子计算云平台在本服务中所使用的“Origin Q”、“本源量子计算云平台”、“本源”及LOGO等商业标识，其著作权或商标权归本源量子计算公司所有。</p>
                                <p class="Agreement_list1">8.4上述及其他任何本服务包含的内容的知识产权均受到法律保护，未经本源量子计算云平台、用户或相关权利人书面许可，任何人不得以任何形式进行使用或创造相关衍生作品。</p>

                            </div>
                        </div>

                        <div class="Agreement">
                            <h1 class="Agreement_header" >九、【用户违法行为】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">9.1您在使用本服务时须遵守法律法规，不得利用本服务从事违法违规行为，包括但不限于：
                                <p class="Agreement_list1 padd_list_left">（1）发布、传送、传播、储存危害国家安全统一、破坏社会稳定、违反公序良俗、侮辱、诽谤、淫秽、暴力以及任何违反国家法律法规的内容；</p>
                                <p class="Agreement_list1 padd_list_left">（2）发布、传送、传播、储存侵害他人知识产权、商业秘密等合法权利的内容；</p>
                                <p class="Agreement_list1 padd_list_left">（3）其他法律法规禁止的行为。</p>
                                </p>
                                <p class="Agreement_list1">9.2如果您违反了本条约定，相关国家机关或机构可能会对您提起诉讼、罚款或采取其他制裁措施，并要求本源量子计算云平台给予协助。
                                    <span>造成损害的，您应依法予以赔偿，本源量子计算云平台不承担任何责任。</span>
                                </p>
                                <p class="Agreement_list1">9.3如果本源量子计算云平台发现或收到他人举报您使用该服务时违反该条协议，本源量子计算云平台有权进行独立判断并采取技术手段予以删除、屏蔽或断开链接。同时，本源量子计算云平台有权视用户的行为性质，采取包括但不限于暂停或终止服务，限制、冻结或终止本源量子计算云平台账号使用，追究法律责任等措施。</p>
                                <p class="Agreement_bold">9.4您违反本条约定，导致任何第三方损害的，您应当独立承担责任；本源量子计算云平台因此遭受损失的，您也应当一并赔偿。</p>
                            </div>
                        </div>

                        <div class="Agreement">
                            <h1 class="Agreement_header">十、【遵守当地法律监管】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">10.1您在使用本服务过程中应当遵守当地相关的法律法规，并尊重当地的道德和风俗习惯。
                                    <span>如果您的行为违反了当地法律法规或道德风俗，您应当为此独立承担责任。</span>
                                </p>
                                <p class="Agreement_list1">10.2您应避免因使用本服务而使本源量子计算云平台卷入政治和公共事件，否则本源量子计算云平台有权暂停或终止对您的服务。</p>
                            </div>
                        </div>

                        <div class="Agreement">
                            <h1 class="Agreement_header">十一、【不可抗力及其他免责事由】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">11.1您理解并同意，在使用本服务的过程中，可能会遇到不可抗力等风险因素，使本服务发生中断。不可抗力是指不能预见、不能克服并不能避免且对一方或双方造成重大影响的客观事件，包括但不限于自然灾害如洪水、地震、瘟疫流行和风暴等以及社会事件如战争、动乱、政府行为等。出现上述情况时，本源量子计算云平台将努力在第一时间与相关单位配合，及时进行修复，但是由此给您造成的损失本源量子计算云平台在法律允许的范围内免责。</p>
                                <p class="Agreement_bold">11.2在法律允许的范围内，本源量子计算云平台对以下情形导致的服务中断或受阻不承担责任：
                                <p class="Agreement_bold padd_list_left">（1）受到计算机病毒、木马或其他恶意程序、黑客攻击的破坏；</p>
                                <p class="Agreement_bold padd_list_left">（2）用户或本源量子计算云平台的电脑软件、系统、硬件和通信线路出现故障；</p>
                                <p class="Agreement_bold padd_list_left">（3）用户操作不当；</p>
                                <p class="Agreement_bold padd_list_left">（4）用户通过非本源量子计算云平台授权的方式使用本服务；</p>
                                <p class="Agreement_bold padd_list_left">（5）其他本源量子计算云平台无法控制或合理预见的情形包括但不限于模拟计算其结果的准确性等。</p>
                                </p>
                                <p class="Agreement_bold">
                                    11.3您理解并同意，在使用本服务的过程中，可能会遇到网络信息或其他用户行为带来的风险，本源量子计算云平台不对任何信息的真实性、适用性、合法性承担责任，也不对因侵权行为给您造成的损害负责。这些风险包括但不限于：
                                <p class="Agreement_bold padd_list_left">（1）来自他人匿名或冒名的含有威胁、诽谤、令人反感或非法内容的信息；</p>
                                <p class="Agreement_bold padd_list_left">（2）因使用本协议项下的服务，遭受他人误导、欺骗或其他导致或可能导致的任何心理、生理上的伤害以及经济上的损失；</p>
                                <p class="Agreement_bold padd_list_left">（3）其他因网络信息或用户行为引起的风险。</p>
                                </p>
                                <p class="Agreement_bold">11.4您理解并同意，本服务并非为某些特定目的而设计，包括但不限于核设施、军事用途、医疗设施、交通通讯等重要领域。如果因为软件或服务的原因导致上述操作失败而带来的人员伤亡、财产损失和环境破坏等，本源量子计算云平台不承担法律责任。</p>
                                <p class="Agreement_bold">11.5本源量子计算云平台依据本协议约定获得处理违法违规内容的权利，该权利不构成本源量子计算云平台的义务或承诺，本源量子计算云平台不能保证及时发现违法行为或进行相应处理。</p>
                                <p class="Agreement_bold">11.6在任何情况下，您不应轻信借款、索要密码或其他涉及财产的网络信息。涉及财产操作的，请一定先核实对方身份，并请经常留意本源量子计算云平台有关防范诈骗犯罪的提示。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header">十二、【协议的生效与变更】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">12.1您使用本源量子计算云平台的服务即视为您已阅读本协议并接受本协议的约束。</p>
                                <p class="Agreement_list1">12.2本源量子计算云平台有权在必要时修改本协议条款。您可以在相关服务页面查阅最新版本的协议条款。</p>
                                <p class="Agreement_list1">12.3本协议条款变更后，如果您继续使用本源量子计算云平台提供的软件或服务，即视为您已接受修改后的协议。如果您不接受修改后的协议，应当停止使用本源量子计算云平台提供的软件或服务。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header">十三、【服务的变更、中断、终止】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">13.1本源量子计算云平台可能会对服务内容进行变更，也可能会中断、中止或终止服务。</p>
                                <p class="Agreement_bold">13.2您理解并同意，本源量子计算云平台有权自主决定经营策略。在本源量子计算云平台发生合并、分立、收购、资产转让时，本源量子计算云平台可向第三方转让本服务下相关资产；本源量子计算云平台也可在单方通知您后，将本协议下部分或全部服务转交由第三方运营或履行。具体受让主体以本源量子计算云平台通知的为准。</p>
                                <p class="Agreement_bold">13.3如发生下列任何一种情形，本源量子计算云平台有权不经通知而中断或终止向您提供的服务：
                                <p class="Agreement_bold padd_list_left">（1）根据法律规定您应提交真实信息，而您提供的个人资料不真实、或与注册时信息不一致又未能提供合理证明；</p>
                                <p class="Agreement_bold padd_list_left">（2）您违反相关法律法规或本协议的约定；</p>
                                <p class="Agreement_bold padd_list_left">（3）按照法律规定或主管部门的要求；</p>
                                <p class="Agreement_bold padd_list_left">（4）出于安全的原因或其他必要的情形。</p>
                                </p>
                                <p class="Agreement_list1">13.4本源量子计算云平台有权按本协议8.2条的约定进行收费。若您未按时足额付费，本源量子计算云平台有权中断、中止或终止提供服务。</p>
                                <p class="Agreement_bold">13.5您有责任在7天内自行备份存储在本服务中的数据。如果您的服务被终止，本源量子计算云平台可以从服务器上永久地删除您的数据,但法律法规另有规定的除外。服务终止后，本源量子计算云平台没有义务向您返还数据。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header">十四、【管辖与法律适用】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_bold">14.1本协议的成立、生效、履行、解释及纠纷解决，适用中华人民共和国大陆地区法律（不包括冲突法）。</p>
                                <p class="Agreement_bold" style="text-decoration: underline">14.2本协议签订地为中华人民共和国安徽省合肥市高新区。</p>
                                <p class="Agreement_bold" style="text-decoration: underline">14.3若您和本源量子计算云平台之间发生任何纠纷或争议，首先应友好协商解决；协商不成的，您同意将纠纷或争议提交本协议签订地（即中国安徽省合肥市高新区）有管辖权的人民法院管辖。</p>
                                <p class="Agreement_list1">14.4本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。</p>
                                <p class="Agreement_list1">14.5本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header">十五、【未成年人使用条款】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">15.1若用户未满14周岁，则为未成年人，应在监护人监护、指导下阅读本协议和使用本服务。</p>
                                <p class="Agreement_list1">15.2监护人、学校均应对未成年人使用本服务时多做引导。特别是家长应关心子女的成长，注意与子女的沟通，指导子女上网应该注意的安全问题，防患于未然。</p>
                            </div>
                        </div>
                        <div class="Agreement">
                            <h1 class="Agreement_header">十六、【其他】</h1>
                            <div class="Agreement_content">
                                <p class="Agreement_list1">如果您对本协议或本服务有意见或建议，可与本源量子计算云平台客户服务部门联系（oqc@originqc.com），我们会给予您必要的帮助。（正文完）</p>
                                <p class="Agreement_list1"></p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">我已阅读并同意进行下一步</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>
    <!--box end-->
    </div>
    </#escape>
</@main.body>
<@main.footer>
 <script type="text/javascript" src="${base}/assets/js/noty/jquery.noty.packaged.js"></script>
<script>
    $(window).load(function () {
        //显示协议模态框
        <#if USER_INFO??>
        if(${isApply}!=1){
            $('#myModal').modal('show');
        }
        <#else>
        </#if>
    })

    var ak = 'Y5brUY2qCrIjpehmh0CEQ4THLsiyY1Ti';
    var map;
    var point;
    function onblur() {

    }

    var telRegex = /^1([35789]\d|4[57])\d{8}$/;
    var eamilRegex =  /^([\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?)+$/;
    function subimitUserApply() {
        if(!login){
            viewLoginMin();
            return;
        }
        var name = $('#name').val();
        var phone = $('#phone').val();
        var email = $('#email').val();
        var vmType = $('#vmType  option:selected').val();
        var purpose = $('#purpose').val();
        var code = $('#captcha').val();
        if(name=='') {
            errorMsg(messages.name_not_null);
            return false;
        }

        if(phone==''){
            errorMsg(messages.phone_not_null);
            return false;
        }
        if (!telRegex.test(phone)) {
            errorMsg(messages.phone_is_proper);
            return false;
        }

        if(email==''){
            errorMsg(messages.email_not_null);
            return false;
        }
        if(!eamilRegex.test(email)){
            errorMsg(messages.email_is_proper);
            return false;
        }
        if(vmType==0){
            errorMsg(messages.vmType_not_null);
            return false;
        }
        if(purpose==''){
            errorMsg(messages.purpose_not_null);
            return false;
        }
        if(code==''){
            errorMsg(messages.volidate_code_not_null);
            return false;
        }
        //   是否同意用户申请协议
        if(!$("input[type='checkbox']").is(':checked')){
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
        $('.btn').attr('disabled',true);
        $('.btn').text('请稍候......');
        //表单提交
        $.ajax({
            url: "${base}/QCode/userApply.json",
            data: param,
            cache: false,  //清除缓存，暂时测试，如果产生冲突，请优先考虑是否是这条语句
            type: 'post',
            success: function (result) {
                $('.btn').attr('disabled',false);
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


    // 更换验证码
    $('#captchaImage').click(function () {
        $('#captchaImage').attr("src", "${base}/assets/vcode_image.jsp?timestamp=" + (new Date()).valueOf());
    });
</script>
</@main.footer>
