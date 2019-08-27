<@main.header title="编程">
<#escape x as x?html>
 </#escape> 
</@main.header>
<@main.body>
	<#include 'program.ftl'/>
</@main.body>
<@main.footer>
<script>
//编程弹出
$(function() {
	App.setNavMenu("${base}/assets/images/liangziTop.png",[{name:"半导体量子计算机",callBack:"App.openNew('${base}/Mine/semiQuantumComputer.html')"},{name:"超导量子计算机",callBack:"App.openNew('${base}/Mine/superQuantumComputer.html')"}]);
    App.setTopMenu([{name:"新增",icon:"${base}/assets/images/add.png",callback:"addProject()"},{name:"保存",icon:"${base}/assets/images/save.png",callback:"save()"}]);
    var footer = new Array();
    footer[0] = {
        name:"编程",
        url:"${base}/Qcode/program.html",
        defaultIcon:"${base}/assets/images/img_01.png",
        activeIcon:"${base}/assets/images/img_01a.png",
        active:true
    };
    footer[1] = {
        name:"教程",
        defaultIcon:"${base}/assets/images/img_02.png",
        activeIcon:"${base}/assets/images/img_02a.png",
        url:"${base}/Course/library.html",
    };
    footer[2] = {
        name:"视频",
        defaultIcon:"${base}/assets/images/img_09.png",
        activeIcon:"${base}/assets/images/img_09a.png",
        url:"${base}/Course/videoLibrary.html",
    };
    footer[3] = {
        name:"小游戏",
        defaultIcon:"${base}/assets/images/img_04.png",
        activeIcon:"${base}/assets/images/img_04a.png",
        url:"${base}/game/game.html",
    };
    footer[4] = {
        name:"我的",
        defaultIcon:"${base}/assets/images/img_05.png",
        activeIcon:"${base}/assets/images/img_05a.png",
        url:"${base}/Mine/mine.html",
    };
    App.setFootMenu(footer);
});

</script>
</@main.footer>