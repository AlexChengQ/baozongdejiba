<#-----author:JT------->
<#-----date:2018-01-16------->

<@main.header>
<#escape x as x?html> 
</#escape>
</@main.header>
<@main.body>
<#escape x as x?html>  
<div class="weui-panel">
    <div class="weui-panel__bd">
        <div class="weui-media-box weui-media-box_small-appmsg">
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Course/welcome.html')">
                    <div class="weui-cell__bd weui-cell_primary">
                        <p>欢迎来到量子的世界</p>
                        <p class="f12 f999 p-t-4">Welcome To THE WORLD OF QUANTUM</p>
                    </div>
                    <span class="weui-cell__ft"></span>
                </a>
                <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Course/world.html')">
                    <div class="weui-cell__bd weui-cell_primary">
                        <p>量子世界</p>
                        <p class="f12 f999 p-t-4">Quantum World</p>
                    </div>
                    <span class="weui-cell__ft"></span>
                </a>
                <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Course/mechanics.html')">
                    <div class="weui-cell__bd weui-cell_primary">
                        <p>量子力学</p>
                        <p class="f12 f999 p-t-4">Quantum Mechanics</p>
                    </div>
                    <span class="weui-cell__ft"></span>
                </a>
                <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Course/theory.html')">
                    <div class="weui-cell__bd weui-cell_primary">
                        <p>量子计算原理</p>
                        <p class="f12 f999 p-t-4">Theory of Quantum Computing</p>
                    </div>
                    <span class="weui-cell__ft"></span>
                </a>
                <a class="weui-cell weui-cell_access" onclick="App.openNew('${base}/Course/algorithm.html')">
                    <div class="weui-cell__bd weui-cell_primary">
                        <p>量子算法</p>
                        <p class="f12 f999 p-t-4">Quantum Algorithm</p>
                    </div>
                    <span class="weui-cell__ft"></span>
                </a>
            </div>
        </div>
    </div>
</div></#escape>
</@main.body>
<@main.footer>
<script type="text/javascript">
$(function() {
	App.setTitle("量子云计算平台教程");
	App.dragRefresh();
});
</script>
</@main.footer>