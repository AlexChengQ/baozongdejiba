<#-----author:JT------->
<#-----date:2017-08-02------->
<@main.header>
    <#escape x as x?html>
    </#escape>
</@main.header>
<@main.body>
<style>
    .vidContent {
        width: 100%;
        min-height: 620px;
        background: #4d6980;
        /*background: #f7f7f7;*/
    }

    .vidList .title {
        font-size: 24px;
        color: #fff;
        padding-top: 60px;
        line-height: 24px;
        text-align: center;
    }

    .vidList .tip {
        color: #fff;
        text-align: center;
        font-size: 16px;
        padding-bottom: 20px;
        line-height: 48px;
    }
    /*2010129class start*/
    .vidListTab{
        width: 100%;
        border-top: 1px solid #e6e6e6;
        line-height: 50px;
        font-size: 16px;
    }
    .vidClassName{
        float: left;
        padding-right: 25px;
        color: #999;
    }
    .vidClassList{
        color: #fff;
        /*color: #333;*/
        display: inline-block;
        /*width: 100%;*/
    }
    .vidClassList ul li{
        cursor: pointer;
        float: left;
        padding: 0 25px;
    }
    .vidClassList ul li span{

        position: relative;
    }
    .vidClassList ul li.active span{
        color: #178cec;
    }
    .vidClassList ul li.active span i{
        width: 100%;
        height: 2px;
        position: absolute;
        bottom: -4px;
        background: #178cec;
    }
    /*2010129class end*/

    .vidList {
        width: 100%;
        margin: 0 auto;
    }
    a {
        color: #333333;
        text-decoration: none;
    }

    .vidlisUser {
        padding: 0px 10px 0px;

    }

    .vidlisUser li {
        width: 280px;
        /*height: 195px;*/
        background: #178cec;
        float: left;
        margin: 2%;
        /*margin-right: 20px;*/
        /*margin-bottom: 20px;*/
        position: relative;
    }
    .vidlisUser li:nth-child(4n){
        /*margin: 0;*/
    }
    .vid_js span{
        font-size: 12px;
    }
    .vid_js span:nth-child(2){
        display: none;
    }

    /*video*/
    #videoplayer_overlay video {
        outline: none;
    }

    #videoplayer_overlay {
        position: fixed;
        top: 0px;
        bottom: 0px;
        left: 0px;
        right: 0px;
        background-color: #4c4c4c;
        background-color: rgba(0, 0, 0, .7);
        z-index: 3000;
    }

    #videoplayer_outer_container {
        position: fixed;
        top: 50%;
        left: 50%;
        width: 95%;
        max-width: 854px;
        transform: translate(-50%, -50%);
        -webkit-transform: translate(-50%, -50%);
    }

    #videoplayer_container {
        position: relative;
        width: 95%;
        max-width: 854px;
        margin: 0 auto;
        color: #4d4d4d;
        background: #fff;
        box-shadow: 0 0 20px #222;
        z-index: 3001;
    }

    #videoplayer_container:before {
        content: "";
        display: block;
        padding-top: 56.25%;
    }

    #videoplayer {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
    }
    .video-js {
        background-color: #000;
        position: relative;
        padding: 0;
        /* Start with 10px for base font size so other dimensions can be em based and
           easily calculable. */

        font-size: 10px;
        /* Allow poster to be vertically aligned. */

        vertical-align: middle;
        /*  display: table-cell; */
        /*This works in Safari but not Firefox.*/

        /* Provide some basic defaults for fonts */

        font-weight: normal;
        font-style: normal;
        /* Avoiding helvetica: issue #376 */

        font-family: Arial, sans-serif;
        /* Turn off user selection (text highlighting) by default.
           The majority of player components will not be text blocks.
           Text areas will need to turn user selection back on. */

        /* user-select */
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    /* Playback technology elements expand to the width/height of the containing div
        <video> or <object> */
    .video-js .vjs-tech {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
    /* Fix for Firefox 9 fullscreen (only if it is enabled). Not needed when
       checking fullScreenEnabled. */
    .video-js:-moz-full-screen {
        position: absolute;
    }
    #box-close {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 50px;
        height: 50px;
        opacity: .35;
        cursor: pointer;

        color: #77987c;
        font-weight: 700;

        font-size: 20px;

        display: block;
        position: absolute;
        right: 00px;
        top: -50px;
        color: #fff;
        opacity:1;
        font-family: "Source Han Sans";
        font-size: 80px;
        line-height: 36px;
        font-weight: 100;
        cursor: pointer;
    }

    #box-close:hover {
        opacity: 1;
    }
    .vid_screenshot{
        /*height: 155px;*/
        width: 100%;
    }
    .vid_screenshot img{
        width: 100%;
    }
    .vid_js{
        line-height: 20px;
        color: #fff;
        text-align: left;
        padding: 10px 16px;

    }
    .vid_js .right{
        float: right;
    }
    .vidHover,.vidHoverImg{
        position: absolute;
        width: 100%;
        height: 100%;
        background: #000;
        opacity: 0.3;
        top:0;
        display: none;
    }
    .vidHoverImg{
        width: 52px;
        height: 52px;
        top:50%;
        left:50%;
        display: none;
        margin-left: -26px;
        margin-top: -26px;

        background: url(${base}/assets/images/autoPlay.png);
        z-index: 2;
        opacity:1;
    }
    .vidlisUser li.active .vidHover,.vidlisUser li.active .vidHoverImg{
        display: block;
    }
    .lis_case{
        width: auto;
        /*margin: 0 auto;*/
        text-align: center;
        float: left;
    }
    .caseUser{
        /*width: 1200px;*/
        padding-bottom: 20px;
        margin: 0 auto;
    }
    .lis_case .case_details{
        width: 294px;
        height: 200px;
        border: 1px solid #e8ebef;
        margin: 0 auto;
    }
    .case_title{
        background: #e8ebef;
        line-height: 56px;

    }
    .case_name{
        padding: 35px 10px;
        font-size: 16px;
        color: #666;
    }
    .case_href{
        width: 122px;
        height: 33px;
        line-height: 33px;
        text-align: center;
        border-radius: 8px;
        color: #fff;
        background: #0f6ab5;
        display: inline-block;
    }
    .libraries-title{
        position: absolute;bottom: 22%;  color: #fff;  text-align: center; width: 100%;font-size: 16px;
    }
    .libraries-title p.name{
        font-size: 34px
    }
    .libShuffling {
        position: relative;
        width: 1200px;
        padding: 0 132px;
        margin: 0 auto;
        overflow: hidden;
    }
    .libShuffling ul{
        width: 1740px;
    }
    .libContainer{
        width: 100%;
        overflow: hidden;
    }
    .swiperBtn a{
        width: 29px;
        height: 52px;
        position: absolute;
        left: 50px;
        top: 60px;
        background: url(../images/libJt.png) center no-repeat;
    }
    .swiperBtn a.LibNext{
        right: 50px;
        left: auto;
        background-image: url(../images/libJtr.png);
    }

    #videoplayer_overlay video {
        outline: none;
    }

    #videoplayer_overlay {
        position: fixed;
        top: 0px;
        bottom: 0px;
        left: 0px;
        right: 0px;
        background-color: #4c4c4c;
        background-color: rgba(0, 0, 0, .7);
        z-index: 3000;
    }

    #videoplayer_outer_container {
        position: fixed;
        top: 50%;
        left: 50%;
        width: 100%;
        max-width: 854px;
        transform: translate(-50%, -50%);
        -webkit-transform: translate(-50%, -50%);
    }

    #videoplayer_container {
        position: relative;
        width: 100%;
        max-width: 854px;
        margin: 0 auto;
        color: #4d4d4d;
        background: #fff;
        box-shadow: 0 0 20px #222;
        z-index: 3001;
    }

    #videoplayer_container:before {
        content: "";
        display: block;
        padding-top: 56.25%;
    }

    #videoplayer {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
    }

    /*#box-close {*/
    /*position: absolute;*/
    /*top: 10px;*/
    /*right: 10px;*/
    /*width: 30px;*/
    /*height: 30px;*/
    /*!*opacity: .35;*!*/
    /*cursor: pointer;*/
    /*}*/

    /*#box-close:hover {*/
    /*opacity: .75;*/
    /*}*/

    .vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing #box-close {
        opacity: 0.8;
        -webkit-transition: opacity 1s cubic-bezier(.455,.03,.515,.955);
        -moz-transition: opacity 1s cubic-bezier(.455,.03,.515,.955);
        transition: opacity 1s cubic-bezier(.455,.03,.515,.955);
    }


    /* sublime skin */

    .vjs-sublime-skin{color:#fff}.vjs-sublime-skin .vjs-poster:focus,.vjs-sublime-skin .vjs-control:focus{outline:none}.vjs-sublime-skin .vjs-big-play-button{line-height:50px;margin:-25px;opacity:1;position:absolute;top:50%;left:50%;height:50px;width:50px;-webkit-transition:opacity 100ms cubic-bezier(.455,.03,.515,.955);-moz-transition:opacity 100ms cubic-bezier(.455,.03,.515,.955);transition:opacity 100ms cubic-bezier(.455,.03,.515,.955);z-index:2}.vjs-sublime-skin .vjs-big-play-button:before{border-color:transparent transparent transparent #fff;border-style:solid;border-width:25px 0 25px 50px;content:"";display:block}.vjs-sublime-skin.vjs-controls-disabled .vjs-big-play-button,.vjs-sublime-skin.vjs-has-started .vjs-big-play-button,.vjs-sublime-skin.vjs-using-native-controls .vjs-big-play-button{opacity:0;pointer-events:none}.vjs-sublime-skin .vjs-control-bar{height:50px;opacity:0;pointer-events:none;position:absolute;right:0;bottom:0;left:0;z-index:2}.vjs-sublime-skin.vjs-has-started .vjs-control-bar{opacity:1;pointer-events:auto;-webkit-transition:opacity 100ms cubic-bezier(.455,.03,.515,.955);-moz-transition:opacity 100ms cubic-bezier(.455,.03,.515,.955);transition:opacity 100ms cubic-bezier(.455,.03,.515,.955)}.vjs-sublime-skin.vjs-has-started.vjs-user-inactive.vjs-playing .vjs-control-bar{opacity:0;-webkit-transition:opacity 1s cubic-bezier(.455,.03,.515,.955);-moz-transition:opacity 1s cubic-bezier(.455,.03,.515,.955);transition:opacity 1s cubic-bezier(.455,.03,.515,.955)}.vjs-sublime-skin.vjs-has-started .vjs-poster,.vjs-sublime-skin.vjs-using-native-controls .vjs-control-bar,.vjs-sublime-skin.vjs-controls-disabled .vjs-control-bar{display:none}.vjs-sublime-skin .vjs-progress-control{position:absolute;top:0;right:95px;bottom:0;left:50px}.vjs-sublime-skin .vjs-progress-control .vjs-progress-holder{cursor:pointer;height:20px;margin-top:-10px;position:absolute;top:50%;right:0;left:0}.vjs-sublime-skin .vjs-progress-control .vjs-progress-holder:after{background-color:rgba(255,255,255,.3);border-radius:2px;content:"";display:block;height:4px;margin-top:-2px;position:absolute;top:50%;right:0;left:0}.vjs-sublime-skin .vjs-progress-control .vjs-play-progress{background-color:rgba(255,255,255,.7);border-radius:2px;height:4px;margin-top:-2px;position:absolute;top:50%;right:0;left:0}.vjs-sublime-skin .vjs-play-control{cursor:pointer;margin-top:-8px;position:absolute;top:50%;left:20px;height:16px;width:15px}.vjs-sublime-skin .vjs-play-control:before{border-color:transparent transparent transparent #fff;border-style:solid;border-width:8px 0 8px 15px;content:"";display:block}.vjs-sublime-skin.vjs-playing .vjs-play-control:before,.vjs-sublime-skin.vjs-playing .vjs-play-control:after{background-color:#fff;border:none;content:"";display:block;height:100%;position:absolute;top:0;bottom:0;left:0;width:6px}.vjs-sublime-skin.vjs-playing .vjs-play-control:after{left:auto;right:0}.vjs-sublime-skin .vjs-fullscreen-control{border:3px solid #fff;box-sizing:border-box;cursor:pointer;margin-top:-7px;position:absolute;top:50%;right:20px;height:14px;width:22px}.vjs-sublime-skin.vjs-fullscreen .vjs-fullscreen-control{background:#fff}.vjs-sublime-skin.vjs-fullscreen .vjs-fullscreen-control:after{background:#000;content:"";display:block;position:absolute;bottom:0;left:0;height:5px;width:5px}.vjs-sublime-skin .vjs-volume-control{cursor:pointer;margin-top:-7px;position:absolute;top:50%;right:55px;height:14px;width:22px}.vjs-sublime-skin .vjs-volume-bar{background:url("../img/vjs-volume-bar.png");background-size:22px 14px;height:100%;width:100%}.vjs-sublime-skin .vjs-volume-level{background:url("../img/vjs-volume-level.png");background-size:22px 14px;height:100%}.vjs-sublime-skin .vjs-current-time,.vjs-sublime-skin .vjs-time-divider,.vjs-sublime-skin .vjs-duration,.vjs-sublime-skin .vjs-remaining-time,.vjs-sublime-skin .vjs-load-progress,.vjs-sublime-skin .vjs-play-progress .vjs-control-text,.vjs-sublime-skin .vjs-play-control .vjs-control-content,.vjs-sublime-skin .vjs-fullscreen-control .vjs-control-text,.vjs-sublime-skin .vjs-slider-handle,.vjs-sublime-skin .vjs-volume-handle,.vjs-sublime-skin .vjs-live-controls,.vjs-sublime-skin .vjs-playback-rate,.vjs-sublime-skin .vjs-subtitles-button,.vjs-sublime-skin .vjs-captions-button,.vjs-sublime-skin .vjs-mute-control,.vjs-sublime-skin .vjs-hidden{display:none}.video-js{background-color:#000;padding:0;position:relative;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;vertical-align:middle}.video-js .vjs-tech{position:absolute;top:0;left:0;height:100%;width:100%}.video-js:-moz-full-screen{position:absolute}.video-js.vjs-fullscreen{position:fixed;overflow:hidden;z-index:1000;left:0;top:0;bottom:0;right:0;width:100%!important;height:100%!important}.video-js:-webkit-full-screen{width:100%!important;height:100%!important}.video-js.vjs-fullscreen.vjs-user-inactive{cursor:none}body.vjs-full-window{height:100%;margin:0;overflow-y:auto;padding:0}.vjs-poster{background-repeat:no-repeat;background-position:50% 50%;background-size:contain;cursor:pointer;height:100%;margin:0;padding:0;position:relative;width:100%}.vjs-poster img{display:block;margin:0 auto;max-height:100%;padding:0;width:100%}.video-js.vjs-using-native-controls .vjs-poster{display:none}
    .vjs-sublime-skin .vjs-progress-control .vjs-progress-holder{
        outline: none;
    }

    /* Video.js adjustments */

    /* add a gradient to the video controls */
    .vjs-control-bar:before {
        content: "";
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        background: -moz-linear-gradient(top, rgba(76,76,76,0) 0%, rgba(19,19,19,0.5) 100%); /* FF3.6-15 */
        background: -webkit-linear-gradient(top, rgba(76,76,76,0) 0%,rgba(19,19,19,0.5) 100%); /* Chrome10-25,Safari5.1-6 */
        background: linear-gradient(to bottom, rgba(76,76,76,0) 0%,rgba(19,19,19,0.5) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#004c4c4c', endColorstr='#80131313',GradientType=0 ); /* IE6-9 */
    }

    /* hide error icon */
    .vjs-error .vjs-error-display::before {
        content: "" !important;
    }


    /* Internet Explorer */

    .lte9 #videoplayer_outer_container {
        top: 1%;
        left: 0;
        right: 0;
        margin: 0 auto;
        transform: none;
    }

    .ie9 .video-js {
        width: 100% !important;
        height: 100% !important;
    }


    /**分割线!*/
    .vjs-default-skin {
        color: #cccccc;
    }
    /* Custom Icon Font
    --------------------------------------------------------------------------------
    The control icons are from a custom font. Each icon corresponds to a character
    (e.g. "\e001"). Font icons allow for easy scaling and coloring of icons.
    */
    @font-face {
        font-family: 'VideoJS';
        src: url('font/vjs.eot');
        src: url('font/vjs.eot?#iefix') format('embedded-opentype'), url('font/vjs.woff') format('woff'), url('font/vjs.ttf') format('truetype'), url('font/vjs.svg#icomoon') format('svg');
        font-weight: normal;
        font-style: normal;
    }
    /* Base UI Component Classes
    --------------------------------------------------------------------------------
    */
    /* Slider - used for Volume bar and Seek bar */
    .vjs-default-skin .vjs-slider {
        /* Replace browser focus highlight with handle highlight */
        outline: 0;
        position: relative;
        cursor: pointer;
        padding: 0;
        /* background-color-with-alpha */
        background-color: #333333;
        background-color: rgba(51, 51, 51, 0.9);
    }
    .vjs-default-skin .vjs-slider:focus {
        /* box-shadow */
        -webkit-box-shadow: 0 0 2em #ffffff;
        -moz-box-shadow: 0 0 2em #ffffff;
        box-shadow: 0 0 2em #ffffff;
    }
    .vjs-default-skin .vjs-slider-handle {
        position: absolute;
        /* Needed for IE6 */
        left: 0;
        top: 0;
    }
    .vjs-default-skin .vjs-slider-handle:before {
        content: "\e009";
        font-family: VideoJS;
        font-size: 1em;
        line-height: 1;
        text-align: center;
        text-shadow: 0em 0em 1em #fff;
        position: absolute;
        top: 0;
        left: 0;
        /* Rotate the square icon to make a diamond */
        /* transform */
        -webkit-transform: rotate(-45deg);
        -moz-transform: rotate(-45deg);
        -ms-transform: rotate(-45deg);
        -o-transform: rotate(-45deg);
        transform: rotate(-45deg);
    }
    /* Control Bar
    --------------------------------------------------------------------------------
    The default control bar that is a container for most of the controls.
    */
    .vjs-default-skin .vjs-control-bar {
        /* Start hidden */
        display: none;
        position: absolute;
        /* Place control bar at the bottom of the player box/video.
           If you want more margin below the control bar, add more height. */
        bottom: 0;
        /* Use left/right to stretch to 100% width of player div */
        left: 0;
        right: 0;
        /* Height includes any margin you want above or below control items */
        height: 3.0em;
        /* background-color-with-alpha */
        background-color: #07141e;
        background-color: rgba(7, 20, 30, 0.7);
    }
    /* Show the control bar only once the video has started playing */
    .vjs-default-skin.vjs-has-started .vjs-control-bar {
        display: block;
        /* Visibility needed to make sure things hide in older browsers too. */

        visibility: visible;
        opacity: 1;
        /* transition */
        -webkit-transition: visibility 0.1s, opacity 0.1s;
        -moz-transition: visibility 0.1s, opacity 0.1s;
        -o-transition: visibility 0.1s, opacity 0.1s;
        transition: visibility 0.1s, opacity 0.1s;
    }
    /* Hide the control bar when the video is playing and the user is inactive  */
    .vjs-default-skin.vjs-has-started.vjs-user-inactive.vjs-playing .vjs-control-bar {
        display: block;
        visibility: hidden;
        opacity: 0;
        /* transition */
        -webkit-transition: visibility 1s, opacity 1s;
        -moz-transition: visibility 1s, opacity 1s;
        -o-transition: visibility 1s, opacity 1s;
        transition: visibility 1s, opacity 1s;
    }
    .vjs-default-skin.vjs-controls-disabled .vjs-control-bar {
        display: none;
    }
    .vjs-default-skin.vjs-using-native-controls .vjs-control-bar {
        display: none;
    }
    /* The control bar shouldn't show after an error */
    .vjs-default-skin.vjs-error .vjs-control-bar {
        display: none;
    }
    /* Don't hide the control bar if it's audio */
    .vjs-audio.vjs-default-skin.vjs-has-started.vjs-user-inactive.vjs-playing .vjs-control-bar {
        opacity: 1;
        visibility: visible;
    }
    /* IE8 is flakey with fonts, and you have to change the actual content to force
    fonts to show/hide properly.
      - "\9" IE8 hack didn't work for this
      - Found in XP IE8 from http://modern.ie. Does not show up in "IE8 mode" in IE9
    */
    @media \0screen {
        .vjs-default-skin.vjs-user-inactive.vjs-playing .vjs-control-bar :before {
            content: "";
        }
    }
    /* General styles for individual controls. */
    .vjs-default-skin .vjs-control {
        outline: none;
        position: relative;
        float: left;
        text-align: center;
        margin: 0;
        padding: 0;
        height: 3.0em;
        width: 4em;
    }
    /* Font button icons */
    .vjs-default-skin .vjs-control:before {
        font-family: VideoJS;
        font-size: 1.5em;
        line-height: 2;
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        text-align: center;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);
    }
    /* Replacement for focus outline */
    .vjs-default-skin .vjs-control:focus:before,
    .vjs-default-skin .vjs-control:hover:before {
        text-shadow: 0em 0em 1em #ffffff;
    }
    .vjs-default-skin .vjs-control:focus {
        /*  outline: 0; */
        /* keyboard-only users cannot see the focus on several of the UI elements when
        this is set to 0 */

    }
    /* Hide control text visually, but have it available for screenreaders */
    .vjs-default-skin .vjs-control-text {
        /* hide-visually */
        border: 0;
        clip: rect(0 0 0 0);
        height: 1px;
        margin: -1px;
        overflow: hidden;
        padding: 0;
        position: absolute;
        width: 1px;
    }
    /* Play/Pause
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-play-control {
        width: 5em;
        cursor: pointer;
    }
    .vjs-default-skin .vjs-play-control:before {
        content: "\e001";
    }
    .vjs-default-skin.vjs-playing .vjs-play-control:before {
        content: "\e002";
    }
    /* Playback toggle
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-playback-rate .vjs-playback-rate-value {
        font-size: 1.5em;
        line-height: 2;
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        text-align: center;
        text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);
    }
    .vjs-default-skin .vjs-playback-rate.vjs-menu-button .vjs-menu .vjs-menu-content {
        width: 4em;
        left: -2em;
        list-style: none;
    }
    /* Volume/Mute
    -------------------------------------------------------------------------------- */
    .vjs-default-skin .vjs-mute-control,
    .vjs-default-skin .vjs-volume-menu-button {
        cursor: pointer;
        float: right;
    }
    .vjs-default-skin .vjs-mute-control:before,
    .vjs-default-skin .vjs-volume-menu-button:before {
        content: "\e006";
    }
    .vjs-default-skin .vjs-mute-control.vjs-vol-0:before,
    .vjs-default-skin .vjs-volume-menu-button.vjs-vol-0:before {
        content: "\e003";
    }
    .vjs-default-skin .vjs-mute-control.vjs-vol-1:before,
    .vjs-default-skin .vjs-volume-menu-button.vjs-vol-1:before {
        content: "\e004";
    }
    .vjs-default-skin .vjs-mute-control.vjs-vol-2:before,
    .vjs-default-skin .vjs-volume-menu-button.vjs-vol-2:before {
        content: "\e005";
    }
    .vjs-default-skin .vjs-volume-control {
        width: 5em;
        float: right;
    }
    .vjs-default-skin .vjs-volume-bar {
        width: 5em;
        height: 0.6em;
        margin: 1.1em auto 0;
    }
    .vjs-default-skin .vjs-volume-level {
        position: absolute;
        top: 0;
        left: 0;
        height: 0.5em;
        /* assuming volume starts at 1.0 */

        width: 100%;
        background: #66a8cc url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGCAYAAADgzO9IAAAAP0lEQVQIHWWMAQoAIAgDR/QJ/Ub//04+w7ZICBwcOg5FZi5iBB82AGzixEglJrd4TVK5XUJpskSTEvpdFzX9AB2pGziSQcvAAAAAAElFTkSuQmCC) -50% 0 repeat;
    }
    .vjs-default-skin .vjs-volume-bar .vjs-volume-handle {
        width: 0.5em;
        height: 0.5em;
        /* Assumes volume starts at 1.0. If you change the size of the
           handle relative to the volume bar, you'll need to update this value
           too. */

        left: 4.5em;
    }
    .vjs-default-skin .vjs-volume-handle:before {
        font-size: 0.9em;
        top: -0.2em;
        left: -0.2em;
        width: 1em;
        height: 1em;
    }
    /* The volume menu button is like menu buttons (captions/subtitles) but works
        a little differently. It needs to be possible to tab to the volume slider
        without hitting space bar on the menu button. To do this we're not using
        display:none to hide the slider menu by default, and instead setting the
        width and height to zero. */
    .vjs-default-skin .vjs-volume-menu-button .vjs-menu {
        display: block;
        width: 0;
        height: 0;
        border-top-color: transparent;
    }
    .vjs-default-skin .vjs-volume-menu-button .vjs-menu .vjs-menu-content {
        height: 0;
        width: 0;
    }
    .vjs-default-skin .vjs-volume-menu-button:hover .vjs-menu,
    .vjs-default-skin .vjs-volume-menu-button .vjs-menu.vjs-lock-showing {
        border-top-color: rgba(7, 40, 50, 0.5);
        /* Same as ul background */

    }
    .vjs-default-skin .vjs-volume-menu-button:hover .vjs-menu .vjs-menu-content,
    .vjs-default-skin .vjs-volume-menu-button .vjs-menu.vjs-lock-showing .vjs-menu-content {
        height: 2.9em;
        width: 10em;
    }
    /* Progress
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-progress-control {
        position: absolute;
        left: 0;
        right: 0;
        width: auto;
        font-size: 0.3em;
        height: 1em;
        /* Set above the rest of the controls. */
        top: -1em;
        /* Shrink the bar slower than it grows. */
        /* transition */
        -webkit-transition: all 0.4s;
        -moz-transition: all 0.4s;
        -o-transition: all 0.4s;
        transition: all 0.4s;
    }
    /* On hover, make the progress bar grow to something that's more clickable.
        This simply changes the overall font for the progress bar, and this
        updates both the em-based widths and heights, as wells as the icon font */
    .vjs-default-skin:hover .vjs-progress-control {
        font-size: .9em;
        /* Even though we're not changing the top/height, we need to include them in
            the transition so they're handled correctly. */

        /* transition */
        -webkit-transition: all 0.2s;
        -moz-transition: all 0.2s;
        -o-transition: all 0.2s;
        transition: all 0.2s;
    }
    /* Box containing play and load progresses. Also acts as seek scrubber. */
    .vjs-default-skin .vjs-progress-holder {
        height: 100%;
    }
    /* Progress Bars */
    .vjs-default-skin .vjs-progress-holder .vjs-play-progress,
    .vjs-default-skin .vjs-progress-holder .vjs-load-progress,
    .vjs-default-skin .vjs-progress-holder .vjs-load-progress div {
        position: absolute;
        display: block;
        height: 100%;
        margin: 0;
        padding: 0;
        /* updated by javascript during playback */

        width: 0;
        /* Needed for IE6 */
        left: 0;
        top: 0;
    }
    .vjs-default-skin .vjs-play-progress {
        /*
          Using a data URI to create the white diagonal lines with a transparent
            background. Surprisingly works in IE8.
            Created using http://www.patternify.com
          Changing the first color value will change the bar color.
          Also using a paralax effect to make the lines move backwards.
            The -50% left position makes that happen.
        */

        background: #66a8cc url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGCAYAAADgzO9IAAAAP0lEQVQIHWWMAQoAIAgDR/QJ/Ub//04+w7ZICBwcOg5FZi5iBB82AGzixEglJrd4TVK5XUJpskSTEvpdFzX9AB2pGziSQcvAAAAAAElFTkSuQmCC) -50% 0 repeat;
    }
    .vjs-default-skin .vjs-load-progress {
        background: #646464 /* IE8- Fallback */;
        background: rgba(255, 255, 255, 0.2);
    }
    /* there are child elements of the load progress bar that represent the
       specific time ranges that have been buffered */
    .vjs-default-skin .vjs-load-progress div {
        background: #787878 /* IE8- Fallback */;
        background: rgba(255, 255, 255, 0.1);
    }
    .vjs-default-skin .vjs-seek-handle {
        width: 1.5em;
        height: 100%;
    }
    .vjs-default-skin .vjs-seek-handle:before {
        padding-top: 0.1em /* Minor adjustment */;
    }
    /* Live Mode
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin.vjs-live .vjs-time-controls,
    .vjs-default-skin.vjs-live .vjs-time-divider,
    .vjs-default-skin.vjs-live .vjs-progress-control {
        display: none;
    }
    .vjs-default-skin.vjs-live .vjs-live-display {
        display: block;
    }
    /* Live Display
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-live-display {
        display: none;
        font-size: 1em;
        line-height: 3em;
    }
    /* Time Display
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-time-controls {
        font-size: 1em;
        /* Align vertically by making the line height the same as the control bar */
        line-height: 3em;
    }
    .vjs-default-skin .vjs-current-time {
        float: left;
    }
    .vjs-default-skin .vjs-duration {
        float: left;
    }
    /* Remaining time is in the HTML, but not included in default design */
    .vjs-default-skin .vjs-remaining-time {
        display: none;
        float: left;
    }
    .vjs-time-divider {
        float: left;
        line-height: 3em;
    }
    /* Fullscreen
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-fullscreen-control {
        width: 3.8em;
        cursor: pointer;
        float: right;
    }
    .vjs-default-skin .vjs-fullscreen-control:before {
        content: "\e000";
    }
    /* Switch to the exit icon when the player is in fullscreen */
    .vjs-default-skin.vjs-fullscreen .vjs-fullscreen-control:before {
        content: "\e00b";
    }
    /* Big Play Button (play button at start)
    --------------------------------------------------------------------------------
    Positioning of the play button in the center or other corners can be done more
    easily in the skin designer. http://designer.videojs.com/
    */
    .vjs-default-skin .vjs-big-play-button {
        left: 0.5em;
        top: 0.5em;
        font-size: 3em;
        display: block;
        z-index: 2;
        position: absolute;
        width: 4em;
        height: 2.6em;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        opacity: 1;
        /* Need a slightly gray bg so it can be seen on black backgrounds */
        /* background-color-with-alpha */
        background-color: #07141e;
        background-color: rgba(7, 20, 30, 0.7);
        border: 0.1em solid #3b4249;
        /* border-radius */
        -webkit-border-radius: 0.8em;
        -moz-border-radius: 0.8em;
        border-radius: 0.8em;
        /* box-shadow */
        -webkit-box-shadow: 0px 0px 1em rgba(255, 255, 255, 0.25);
        -moz-box-shadow: 0px 0px 1em rgba(255, 255, 255, 0.25);
        box-shadow: 0px 0px 1em rgba(255, 255, 255, 0.25);
        /* transition */
        -webkit-transition: all 0.4s;
        -moz-transition: all 0.4s;
        -o-transition: all 0.4s;
        transition: all 0.4s;
    }
    /* Optionally center */
    .vjs-default-skin.vjs-big-play-centered .vjs-big-play-button {
        /* Center it horizontally */
        left: 50%;
        margin-left: -2.1em;
        /* Center it vertically */
        top: 50%;
        margin-top: -1.4000000000000001em;
    }
    /* Hide if controls are disabled */
    .vjs-default-skin.vjs-controls-disabled .vjs-big-play-button {
        display: none;
    }
    /* Hide when video starts playing */
    .vjs-default-skin.vjs-has-started .vjs-big-play-button {
        display: none;
    }
    /* Hide on mobile devices. Remove when we stop using native controls
        by default on mobile  */
    .vjs-default-skin.vjs-using-native-controls .vjs-big-play-button {
        display: none;
    }
    .vjs-default-skin:hover .vjs-big-play-button,
    .vjs-default-skin .vjs-big-play-button:focus {
        outline: 0;
        border-color: #fff;
        /* IE8 needs a non-glow hover state */
        background-color: #505050;
        background-color: rgba(50, 50, 50, 0.75);
        /* box-shadow */
        -webkit-box-shadow: 0 0 3em #ffffff;
        -moz-box-shadow: 0 0 3em #ffffff;
        box-shadow: 0 0 3em #ffffff;
        /* transition */
        -webkit-transition: all 0s;
        -moz-transition: all 0s;
        -o-transition: all 0s;
        transition: all 0s;
    }
    .vjs-default-skin .vjs-big-play-button:before {
        content: "\e001";
        font-family: VideoJS;
        /* In order to center the play icon vertically we need to set the line height
           to the same as the button height */

        line-height: 2.6em;
        text-shadow: 0.05em 0.05em 0.1em #000;
        text-align: center /* Needed for IE8 */;
        position: absolute;
        left: 0;
        width: 100%;
        height: 100%;
    }
    .vjs-error .vjs-big-play-button {
        display: none;
    }
    /* Error Display
    --------------------------------------------------------------------------------
    */
    .vjs-error-display {
        display: none;
    }
    .vjs-error .vjs-error-display {
        display: block;
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
    }
    .vjs-error .vjs-error-display:before {
        content: 'X';
        font-family: Arial;
        font-size: 4em;
        color: #666666;
        /* In order to center the play icon vertically we need to set the line height
           to the same as the button height */

        line-height: 1;
        text-shadow: 0.05em 0.05em 0.1em #000;
        text-align: center /* Needed for IE8 */;
        vertical-align: middle;
        position: absolute;
        left: 0;
        top: 50%;
        margin-top: -0.5em;
        width: 100%;
    }
    .vjs-error-display div {
        position: absolute;
        bottom: 1em;
        right: 0;
        left: 0;
        font-size: 1.4em;
        text-align: center;
        padding: 3px;
        background: #000000;
        background: rgba(0, 0, 0, 0.5);
    }
    .vjs-error-display a,
    .vjs-error-display a:visited {
        color: #F4A460;
    }
    /* Loading Spinner
    --------------------------------------------------------------------------------
    */
    .vjs-loading-spinner {
        /* Should be hidden by default */
        display: none;
        position: absolute;
        top: 50%;
        left: 50%;
        font-size: 4em;
        line-height: 1;
        width: 1em;
        height: 1em;
        margin-left: -0.5em;
        margin-top: -0.5em;
        opacity: 0.75;
    }
    /* Show the spinner when waiting for data and seeking to a new time */
    .vjs-waiting .vjs-loading-spinner,
    .vjs-seeking .vjs-loading-spinner {
        display: block;
        /* only animate when showing because it can be processor heavy */
        /* animation */
        -webkit-animation: spin 1.5s infinite linear;
        -moz-animation: spin 1.5s infinite linear;
        -o-animation: spin 1.5s infinite linear;
        animation: spin 1.5s infinite linear;
    }
    /* Errors are unrecoverable without user interaction so hide the spinner */
    .vjs-error .vjs-loading-spinner {
        display: none;
        /* ensure animation doesn't continue while hidden */
        /* animation */
        -webkit-animation: none;
        -moz-animation: none;
        -o-animation: none;
        animation: none;
    }
    .vjs-default-skin .vjs-loading-spinner:before {
        content: "\e01e";
        font-family: VideoJS;
        position: absolute;
        top: 0;
        left: 0;
        width: 1em;
        height: 1em;
        text-align: center;
        text-shadow: 0em 0em 0.1em #000;
    }
    @-moz-keyframes spin {
        0% {
            -moz-transform: rotate(0deg);
        }
        100% {
            -moz-transform: rotate(359deg);
        }
    }
    @-webkit-keyframes spin {
        0% {
            -webkit-transform: rotate(0deg);
        }
        100% {
            -webkit-transform: rotate(359deg);
        }
    }
    @-o-keyframes spin {
        0% {
            -o-transform: rotate(0deg);
        }
        100% {
            -o-transform: rotate(359deg);
        }
    }
    @keyframes spin {
        0% {
            transform: rotate(0deg);
        }
        100% {
            transform: rotate(359deg);
        }
    }
    /* Menu Buttons (Captions/Subtitles/etc.)
    --------------------------------------------------------------------------------
    */
    .vjs-default-skin .vjs-menu-button {
        float: right;
        cursor: pointer;
    }
    .vjs-default-skin .vjs-menu {
        display: none;
        position: absolute;
        bottom: 0;
        left: 0em;
        /* (Width of vjs-menu - width of button) / 2 */

        width: 0em;
        height: 0em;
        margin-bottom: 3em;
        border-left: 2em solid transparent;
        border-right: 2em solid transparent;
        border-top: 1.55em solid #000000;
        /* Same width top as ul bottom */

        border-top-color: rgba(7, 40, 50, 0.5);
        /* Same as ul background */

    }
    /* Button Pop-up Menu */
    .vjs-default-skin .vjs-menu-button .vjs-menu .vjs-menu-content {
        display: block;
        padding: 0;
        margin: 0;
        position: absolute;
        width: 10em;
        bottom: 1.5em;
        /* Same bottom as vjs-menu border-top */

        max-height: 15em;
        overflow: auto;
        left: -5em;
        /* Width of menu - width of button / 2 */

        /* background-color-with-alpha */
        background-color: #07141e;
        background-color: rgba(7, 20, 30, 0.7);
        /* box-shadow */
        -webkit-box-shadow: -0.2em -0.2em 0.3em rgba(255, 255, 255, 0.2);
        -moz-box-shadow: -0.2em -0.2em 0.3em rgba(255, 255, 255, 0.2);
        box-shadow: -0.2em -0.2em 0.3em rgba(255, 255, 255, 0.2);
    }
    .vjs-default-skin .vjs-menu-button:hover .vjs-control-content .vjs-menu,
    .vjs-default-skin .vjs-control-content .vjs-menu.vjs-lock-showing {
        display: block;
    }
    /* prevent menus from opening while scrubbing (FF, IE) */
    .vjs-default-skin.vjs-scrubbing .vjs-menu-button:hover .vjs-control-content .vjs-menu {
        display: none;
    }
    .vjs-default-skin .vjs-menu-button ul li {
        list-style: none;
        margin: 0;
        padding: 0.3em 0 0.3em 0;
        line-height: 1.4em;
        font-size: 1.2em;
        text-align: center;
        text-transform: lowercase;
    }
    .vjs-default-skin .vjs-menu-button ul li.vjs-selected {
        background-color: #000;
    }
    .vjs-default-skin .vjs-menu-button ul li:focus,
    .vjs-default-skin .vjs-menu-button ul li:hover,
    .vjs-default-skin .vjs-menu-button ul li.vjs-selected:focus,
    .vjs-default-skin .vjs-menu-button ul li.vjs-selected:hover {
        outline: 0;
        color: #111;
        /* background-color-with-alpha */
        background-color: #ffffff;
        background-color: rgba(255, 255, 255, 0.75);
        /* box-shadow */
        -webkit-box-shadow: 0 0 1em #ffffff;
        -moz-box-shadow: 0 0 1em #ffffff;
        box-shadow: 0 0 1em #ffffff;
    }
    .vjs-default-skin .vjs-menu-button ul li.vjs-menu-title {
        text-align: center;
        text-transform: uppercase;
        font-size: 1em;
        line-height: 2em;
        padding: 0;
        margin: 0 0 0.3em 0;
        font-weight: bold;
        cursor: default;
    }
    /* Subtitles Button */
    .vjs-default-skin .vjs-subtitles-button:before {
        content: "\e00c";
    }
    /* Captions Button */
    .vjs-default-skin .vjs-captions-button:before {
        content: "\e008";
    }
    /* Chapters Button */
    .vjs-default-skin .vjs-chapters-button:before {
        content: "\e00c";
    }
    .vjs-default-skin .vjs-chapters-button.vjs-menu-button .vjs-menu .vjs-menu-content {
        width: 24em;
        left: -12em;
    }
    /* Replacement for focus outline */
    .vjs-default-skin .vjs-captions-button:focus .vjs-control-content:before,
    .vjs-default-skin .vjs-captions-button:hover .vjs-control-content:before {
        /* box-shadow */
        -webkit-box-shadow: 0 0 1em #ffffff;
        -moz-box-shadow: 0 0 1em #ffffff;
        box-shadow: 0 0 1em #ffffff;
    }
    /*
    REQUIRED STYLES (be careful overriding)
    ================================================================================
    When loading the player, the video tag is replaced with a DIV,
    that will hold the video tag or object tag for other playback methods.
    The div contains the video playback element (Flash or HTML5) and controls,
    and sets the width and height of the video.

    ** If you want to add some kind of border/padding (e.g. a frame), or special
    positioning, use another containing element. Otherwise you risk messing up
    control positioning and full window mode. **
    */
    .video-js {
        background-color: #000;
        position: relative;
        padding: 0;
        /* Start with 10px for base font size so other dimensions can be em based and
           easily calculable. */

        font-size: 10px;
        /* Allow poster to be vertically aligned. */

        vertical-align: middle;
        /*  display: table-cell; */
        /*This works in Safari but not Firefox.*/

        /* Provide some basic defaults for fonts */

        font-weight: normal;
        font-style: normal;
        /* Avoiding helvetica: issue #376 */

        font-family: Arial, sans-serif;
        /* Turn off user selection (text highlighting) by default.
           The majority of player components will not be text blocks.
           Text areas will need to turn user selection back on. */

        /* user-select */
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    /* Playback technology elements expand to the width/height of the containing div
        <video> or <object> */
    .video-js .vjs-tech {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
    /* Fix for Firefox 9 fullscreen (only if it is enabled). Not needed when
       checking fullScreenEnabled. */
    .video-js:-moz-full-screen {
        position: absolute;
    }
    /* Fullscreen Styles */
    body.vjs-full-window {
        padding: 0;
        margin: 0;
        height: 100%;
        /* Fix for IE6 full-window. http://www.cssplay.co.uk/layouts/fixed.html */
        overflow-y: auto;
    }
    .video-js.vjs-fullscreen {
        position: fixed;
        overflow: hidden;
        z-index: 1000;
        left: 0;
        top: 0;
        bottom: 0;
        right: 0;
        width: 100% !important;
        height: 100% !important;
        /* IE6 full-window (underscore hack) */
        _position: absolute;
    }
    .video-js:-webkit-full-screen {
        width: 100% !important;
        height: 100% !important;
    }
    .video-js.vjs-fullscreen.vjs-user-inactive {
        cursor: none;
    }
    /* Poster Styles */
    .vjs-poster {
        background-repeat: no-repeat;
        background-position: 50% 50%;
        background-size: contain;
        background-color: #000000;
        cursor: pointer;
        margin: 0;
        padding: 0;
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
    }
    .vjs-poster img {
        display: block;
        margin: 0 auto;
        max-height: 100%;
        padding: 0;
        width: 100%;
    }
    /* Hide the poster after the video has started playing */
    .video-js.vjs-has-started .vjs-poster {
        display: none;
    }
    /* Don't hide the poster if we're playing audio */
    .video-js.vjs-audio.vjs-has-started .vjs-poster {
        display: block;
    }
    /* Hide the poster when controls are disabled because it's clickable
        and the native poster can take over */
    .video-js.vjs-controls-disabled .vjs-poster {
        display: none;
    }
    /* Hide the poster when native controls are used otherwise it covers them */
    .video-js.vjs-using-native-controls .vjs-poster {
        display: none;
    }
    /* Text Track Styles */
    /* Overall track holder for both captions and subtitles */
    .video-js .vjs-text-track-display {
        position: absolute;
        top: 0;
        left: 0;
        bottom: 3em;
        right: 0;
        pointer-events: none;
    }
    /* Captions Settings Dialog */
    .vjs-caption-settings {
        position: relative;
        top: 1em;
        background-color: #000;
        opacity: 0.75;
        color: #FFF;
        margin: 0 auto;
        padding: 0.5em;
        height: 15em;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 12px;
        width: 40em;
    }
    .vjs-caption-settings .vjs-tracksettings {
        top: 0;
        bottom: 2em;
        left: 0;
        right: 0;
        position: absolute;
        overflow: auto;
    }
    .vjs-caption-settings .vjs-tracksettings-colors,
    .vjs-caption-settings .vjs-tracksettings-font {
        float: left;
    }
    .vjs-caption-settings .vjs-tracksettings-colors:after,
    .vjs-caption-settings .vjs-tracksettings-font:after,
    .vjs-caption-settings .vjs-tracksettings-controls:after {
        clear: both;
    }
    .vjs-caption-settings .vjs-tracksettings-controls {
        position: absolute;
        bottom: 1em;
        right: 1em;
    }
    .vjs-caption-settings .vjs-tracksetting {
        margin: 5px;
        padding: 3px;
        min-height: 40px;
    }
    .vjs-caption-settings .vjs-tracksetting label {
        display: block;
        width: 100px;
        margin-bottom: 5px;
    }
    .vjs-caption-settings .vjs-tracksetting span {
        display: inline;
        margin-left: 5px;
    }
    .vjs-caption-settings .vjs-tracksetting > div {
        margin-bottom: 5px;
        min-height: 20px;
    }
    .vjs-caption-settings .vjs-tracksetting > div:last-child {
        margin-bottom: 0;
        padding-bottom: 0;
        min-height: 0;
    }
    .vjs-caption-settings label > input {
        margin-right: 10px;
    }
    .vjs-caption-settings input[type="button"] {
        width: 40px;
        height: 40px;
    }
    /* Hide disabled or unsupported controls */
    .vjs-hidden {
        display: none !important;
    }
    .vjs-lock-showing {
        display: block !important;
        opacity: 1;
        visibility: visible;
    }
    /*  In IE8 w/ no JavaScript (no HTML5 shim), the video tag doesn't register.
        The .video-js classname on the video tag also isn't considered.
        This optional paragraph inside the video tag can provide a message to users
        about what's required to play video. */
    .vjs-no-js {
        padding: 2em;
        color: #ccc;
        background-color: #333;
        font-size: 1.8em;
        font-family: Arial, sans-serif;
        text-align: center;
        width: 30em;
        height: 15em;
        margin: 0 auto;
    }
    .vjs-no-js a,
    .vjs-no-js a:visited {
        color: #F4A460;
    }


    /*教程子页面*/

    .algContent{
        width: 1200px;
        margin: 50px auto 0;
        position: relative;
    }
    .algLeft{
        width: 210px;
        position: absolute;
        top:0;
        left:0;

    }
    .algLeftContent{
        padding-top: 86px;
        margin-left: 20px;
        width: 190px;
        /*background: #ecf0f4;*/
    }
    .algLeftContent .title{
        padding-left: 15px;
        line-height: 24px;
        padding-bottom: 20px;
        border-bottom: 1px solid #ccc;
        text-align: left;
        font-size: 24px;color: #1a1a1a;
    }
    .algListBox li{
        border-bottom: 1px solid #ccc;
        line-height: 62px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }
    .algListBox li a{
        padding-left: 15px;
        font-size: 18px;
        color: #333;

    }
    .algListBox li a.active{
        color: #178cec;
    }
    .algListBox li.active a{
        color: #178cec;
    }
    .algCenter{
        width: auto;
        padding: 0 24px;
        margin-left: 210px;
        margin-right: 105px;
        background: #fff;
    }
    .indexes_con{
        padding-top: 5px;
        border-bottom: 1px solid #ccc;
    }
    .indexes_box{
        line-height: 42px;
    }
    .indexes_box a{
        font-size: 14px;
        color: #178cec;
    }
    .indexes_box span{
        color: #333;
        margin: 0 5px;
    }
    .algRight_con{
        padding-top: 134px;
        position: fixed;
    }
    .algRight_box{
        width: 100%;
        border-left: 2px solid #e6e6e6;
        padding-bottom: 80px;
    }
    .jcTitle{
        line-height: 28px;
        font-size: 14px;
        text-align: left;
        margin-left: 13px;
        color: #333;
        margin-bottom: 12px;
    }
    .algRight{
        float: right;
        min-width: 105px;
        /*position: absolute;*/
        top:0;
        right:0;
        z-index: 56;
    }
    .jcIndexList{
        margin-left: -2px;
    }
    .jcIndexList ul li{
        line-height: 14px;
        font-size: 14px;
        border-left: 2px solid #e6e6e6;

        padding: 8px 0;
        margin-bottom: 12px;
    }
    .jcIndexList ul li a{
        color: #999;
        padding-left: 13px;
    }
    .jcIndexList ul li.active{
        border-color: #178cec;
    }
    .jcIndexList ul li.active a{
        color: #178cec;
    }


    /*  <#--教程案例量子算法中间内容-->*/





    .algCollCode{
        min-height: 750px;
        display: none;
    }
    .algCollCode.active{
        display: block;
    }
    .altContentTitle{
        font-size: 32px;
        color: #333;
        line-height: 90px;

    }
    .alt_n_title{
        line-height: 30px;
        font-weight: 700;
        font-size: 20px;
        color: #333;
    }
    .alt_n_info{
        color: #666;
        padding: 15px 0;
        text-indent: 26px;
        font-size: 14px;
        line-height: 18px;
    }
    .alt_n2_title{
        font-size: 14px;
        color: #333;
        line-height: 30px;
    }
    .alt_n2_info p{
        font-size: 14px;
        color: #666;
        line-height: 18px;
        text-indent: 26px;
        margin: 0;
    }

    .alt_n2_img{
        padding: 25px 0 0 0;
        text-align: center;
    }
    .alt_n2_img img{
        width: 55%;

    }
    .alt_n2{
        /*padding-bottom: 25px;*/
    }
    .alt_n{
        padding-bottom: 35px;
    }
    .alt_n_img{
        text-align: center;
        padding: 20px 0;
    }
    .alt_n_img img{
        width: 80%;
    }
    .alt_n_code{
        height: 750px;
        overflow-y: auto;
    }
    .alt_n_con{
        padding-bottom: 40px;
    }
    .altContentSketch{
        font-size: 14px;
        line-height: 20px;
        color: #808080;
        text-indent: 26px;
        padding: 25px 0;
    }
    .alt_n2_border{
        width: 100%;
        height: auto;
        padding: 15px 0;
        margin: 0 26px;
        border: 1px solid #808080;
    }
    .alt_n2_border p{
        margin: 0;
        color: #000;
    }
    .alt-n2-flex{
        display: flex;
        text-align: center;
    }
    .alt-ne-f1{
        flex: 1;
        margin-right: 50px;
        text-align: center;
    }
    .alt-ne-f1 table,.alt-ne-f1 th,.alt-ne-f1 td{
        border: 2px solid #178cec;
    }
    .alt-ne-f1 th{

        padding: 10px 50px;
    }
    .alt-ne-f1 td{
        padding: 5px 0;
    }
    .alt-ne-f1>div{
        padding: 8px 0;
    }


    /*20180810添加*/
    body{
        background: #fff;
    }
    .navbar{
        position: absolute;
    }
    .content{
        padding-top: 0!important;
    }
    .navbar,.collapse.in{
        background: url(../images/jcTopBg.png) repeat-x bottom;
        background-color: transparent;
        -webkit-background-size: 100% 100%;
        background-size: 100% 100%;
    }
    @media (max-width: 1100px) {
        .collapse.in{
            background: url(../images/jcTopBg.png) repeat bottom;
            -webkit-background-size: 100% 100%;
            background-size: 100% 100%;
        }
    }

    .toolsContent{
        padding-top: 15px;
        width: 100%;
        padding: 0;
    }
    .toolsBox{
        height: 580px;
    }
    .toolCollont{
        width: 100%;
        background: #4d6980;
        height: 413px;
        margin-top: 63px;
    }
    .toolsAll{
        width: 1200px;
        margin: 0 auto;
        height: 100%;
    }
    .toolsAll li{
        width: 240px;
        height: 413px;
        float: left;
        position: relative;
        cursor: pointer;
    }
    .toolsAll li .bgImg1,.toolsAll li .bgImg2{
        position: absolute;
        top:0;
        right: 0;
        width: 100%;
        height: 100%;
        z-index: 1;
    }
    .toolsAll li .bgImg2{
        display: none;
    }
    .toolsAll li .toolsBg1{
        background: url(../images/toolsBg1.png) repeat;
        width: 100%;
        height: 100%;
        position: absolute;
        top:0;
        z-index: 2;
    }
    .toolWang{
        position: absolute;
        top:0;
        width: 100%;
        height: 100%;
        text-align: center;
        z-index:3;
    }
    .toolWang .toolsImgMin{
        height: 100px;
        vertical-align: middle;
        line-height: 100px;
        margin-top: 66px;
    }
    .toolWang .toolsImgMin img{
        max-width: 26%;
    }
    .toolsBorder{
        height: 5px;
        width: 43px;
        background: #fff;
        margin: 0 auto 20px;

    }
    .toolsName {
        padding-top: 35px;
        font-size: 24px;
        color: #fff;

    }
    .toolsJs {
        margin-top: 35px;
        padding:0 23px;
        font-size: 18px;
        color: #fff;
        display: none;
        line-height: 24px;
        text-align: left;
    }
    .toolsHref {
        display: none;
        width: 165px;
        height: 52px;
        border:1px solid #fff;
        line-height: 50px;
        text-align: center;
        color: #fff;font-size: 18px;
        /*margin-top: 18px;*/
        margin: 18px auto 0;
    }
    .toolsAll li .jcTouY{
        z-index: 0;
        display: none;
        width: 354px;
        height: 543px;
        position: absolute;
        left: -6px;
        background: url(../images/jcTouying.png) no-repeat;
        top: -8px;
        background-size: 100% 100%;
    }
    .toolsAll li.active{
        width: 340px;
        left: -50px;
        height: 526px;
        margin-top: -63px;
        z-index: 30;

    }

    .toolsAll li.active .bgImg1{
        display: none;
    }
    .toolsAll li.active .bgImg2{
        display: block;
    }
    .toolsAll li.active .toolsBg1{
        background-image: url(../images/toolsBgBlue.png);
    }
    .toolsAll li.active .jcTouY{
        display: block;
    }
    .toolsAll li.active .toolsImgMin{
        margin-top: 70px;
    }
    .toolsAll li.active .toolsImgMin img{
        width: auto;
        max-width: auto;
    }
    .toolsAll li.active .toolsBorder{
        display: none;
    }
    .toolsAll li.active .toolsJs{
        display: block;
    }
    .toolsAll li.active .toolsHref{
        display: block;
    }
    .developBox .quotes{
        text-indent: 54px;
        line-height: 20px;
        color: #333;
        font-size: 18px;
        text-align: center;
    }
    .developBox{
        width: 1200px;
        margin: 0 auto;
    }
    .devLinkBox{
        padding-top: 40px;
    }
    .devLinkBox .link{
        text-align: left;
        width: 50%;
        float: left;
        line-height: 21px;
    }
    .devLinkBox .link a{
        font-size: 14px;
        color: #178cec;
        line-height: 21px;
        text-decoration: none;
        text-decoration-style:#178cec ;

    .            }
    .developCon{
        width: 48%;
        float: left;
        padding: 23px 20px 23px 32px;
        border: 1px solid #e6e6e6;
    }
    .developCon:first-child{
        margin-right: 2%;
    }
    .developCon  .title{
        line-height: 54px;
        margin: 0!important;
        text-align: left!important;
        font-size: 18px;
        color: #333;
    }
    .devConTips{
        font-size: 14px;
        color: #333;
        line-height: 26px;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        height: 52px;
        overflow: hidden;
    }

    #Flash1{
        -webkit-transform: rotate(90deg);
        -moz-transform: rotate(90deg);
        -ms-transform: rotate(90deg);
        -o-transform: rotate(90deg);
        transform: rotate(90deg);
    }

</style>
    <#escape x as x?html>

    <div class="content  clearfix" style="overflow: hidden">
        <!--top-->

        <!--top end-->
        <!--box-->
        <style>
            .vidHeadPath {padding-top:15px;max-width:1200px;margin:0 auto;line-height:50px;border-bottom:1px solid #d9d9d9;}
            .vidHeadPath a {color:#1a1a1a;font-size:14px;}
            .vidHeadPath span {font-size:14px;color:#4c4c4c;}
            .vidHeadPath span.gont {font-family:"宋体","Source Han Sans","Helvetica Neue",Helvetica,Arial,sans-serif;}
            .vidOptions {padding:30px 0;margin-bottom:15px;border-bottom:1px solid #cdcccd;-moz-box-shadow:0px 6px 6px #E2E2E2;-webkit-box-shadow:0px 6px 6px #E2E2E2;box-shadow:0px 6px 6px #E2E2E2;    overflow: scroll;
                overflow-x: scroll;
                overflow-y: scroll;}
            .vidOptions .OptionName {font-size:14px;float:left;color:#4c4c4c;line-height:34px;margin-right:20px;}
            .vidOptions .OptionList {float:left;}
            .vidOptions .OptionList1 {float:left;}
            .vidOptions .OptionList a {display:inline-block;padding:0 15px;height:34px;line-height:34px;margin-right:12px;border:1px solid #d9d9d9;margin-bottom: 15px}
            .vidOptions .OptionList1 a {display:inline-block;padding:0 15px;height:34px;line-height:34px;margin-right:12px;border:1px solid #d9d9d9;margin-bottom: 15px}
            .vidOptions .OptionList a.active {background:#178cec;color:#fff;border-color:#178cec;}
            .vidOptions .OptionList1 a.active {background:#178cec;color:#fff;border-color:#178cec;}
            .vidOptions .margin1200 {margin:0 auto;width:100%;overflow-x: auto;    padding-left: 20px;}
            .vidAll {background:#f5f5f5;width:100%;margin-top:-7px;/*height:100%;*/}
            .filtrateBox {max-width:1200px;margin:0 auto;padding:15px 0 30px 0;}
            .filtrateBox a {display:inline-block;padding:0 25px;color:#4c4c4c;height:34px;line-height:34px;background:#fff;float:left;border-right:2px solid #d9d9d9;}
            .filtrateBox a:last-child {border:none;}
            .filtrateBox a.active {background:#178cec;border-color:#178cec;color:#fff;}
            .vidAll .vidlisUser {padding:0;}
            .vidAll .vidlisUser li {width:46%;
                }
            .vidAll .vidlisUser li:nth-child(odd){
                clear: both;
            }
        </style>
        <div class="vidHeadPath" style="display:none;">
            <a href="${base}/QCode/library.html">教程</a><span class="gont"> > </span> <span>视频教程</span>
        </div>
        <div class="vidOptions">
            <div class="clearfix margin1200">
                <div class="OptionName">课程类型：</div>
                <div class="OptionList"><a href="javascript:void (0)" class="active">全部</a></div>
            </div>
            <div class="clearfix margin1200">
                <div class="OptionName">清晰度：</div>
                <div class="OptionList1">
                	<a href="javascript:void (0)" class="active" data-classify="0">流畅</a>
                	<a href="javascript:void (0)" class="" data-classify="1">高清</a>
                </div>
            </div>
        </div>
        <div class="vidAll">
            <div class="vidContent">
                <div class="filtrateBox clearfix" style="display: none;"><a href="" class="active">默认排序</a><a href="">按热门</a><a href="">按最新</a></div>
                <div class="vidList">
                    <ul class="vidlisUser clearfix" style="padding-top: 20px">

                        <li>
                            <div class="vid_screenshot" data-value="32qubit.mp4">
                                <img src="${base}/assets/images/yunpingtvideo.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>32位量子虚拟机演示视频</span> <span class="right">04:55</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="app.mp4">
                                <img src="${base}/assets/images/appvideo.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>APP操作指南</span> <span class="right">05:03</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="apply.mp4">
                                <img src="${base}/assets/images/yunpingtvideo.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>虚拟机申请视频</span> <span class="right">01:42</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="cloudshow.mp4">
                                <img src="${base}/assets/images/yunpingtvideo2.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>云平台展示视频</span> <span class="right">10:17</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>


                        <li>
                            <div class="vid_screenshot" data-value="qubit1.mp4">
                                <img src="${base}/assets/images/video1.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>量子云平台</span> <span class="right">02:39</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="qubit2.mp4">
                                <img src="${base}/assets/images/video2.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>魅力的量子计算</span> <span class="right">05:12</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="qubit3.mp4">
                                <img src="${base}/assets/images/video3.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>计算与量子云框架</span> <span class="right">06:13</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="qubit4.mp4">
                                <img src="${base}/assets/images/video4.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>量子云构架</span> <span class="right">11:55</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>

                        <li>
                            <div class="vid_screenshot" data-value="base_singlequbit.mp4">
                                <img src="${base}/assets/images/video/base_1.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>基础应用（一）——量子逻辑门</span> <span class="right">9:30</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>                                                                       
                        <li>
                            <div class="vid_screenshot" data-value="base_entanglement.mp4">
                                <img src="${base}/assets/images/video/base2.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>基础应用（二）——量子纠缠态</span> <span class="right">8:08</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>
                        </li>                        
                        <li>
                            <div class="vid_screenshot" data-value="QRunes.mp4">
                                <img src="${base}/assets/images/video/QRunes.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>OriginIR</span> <span class="right">6:36</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>                        

                        </li>
                        <li>
                            <div class="vid_screenshot" data-value="D-JAlgorithm.mp4">
                                <img src="${base}/assets/images/video/DJAlgorithm.png" alt="">
                            </div>
                            <div class="vid_js">
                                <span>Deutsch-Jozsa算法</span> <span class="right">6:06</span>
                            </div>
                            <div class="vidHover"></div>
                            <div class="vidHoverImg"><img src="" alt=""></div>                        

                        </li>
                        <div class="videoBox"></div>
                    </ul>
                </div>
            </div>
        </div>
        <style>
            .vjs-user-inactive .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -18px;}
           .vjs-user-active .vjs-volume-handle{display: block;top: -15px;width: 55px;position: relative;left: -18px;}
            .vidContent{background: transparent;padding-bottom: 100px;overflow: hidden;}
        </style>
    </div>
    </#escape>
<script type='text/javascript' src="${base}/assets/js/md5.js"></script>
<script>

    $(function() {
        App.setTitle("量子云计算视频教程");
        App.dragRefresh();
    });
    //视频全屏显示
    (function ($) {
        // Adding a new test to the jQuery support object
        $.support.fullscreen = supportFullScreen();
        // Creating the plugin
        $.fn.fullScreen = function (props) {
            if (!$.support.fullscreen || this.length != 1) {
                // The plugin can be called only
                // on one element at a time
                return this;
            }
            if (fullScreenStatus()) {
                $("#box-close").css({"right":"0"})
                $("#my_video_1").removeClass("vjs-fullscreen");
                $("#my_video_1").removeClass("vjs-ended");
                $("#my_video_1").removeClass("vjs-paused");
                // if we are already in fullscreen, exit
                cancelFullScreen();

                return this;
            }else {
                $("#my_video_1").addClass("vjs-fullscreen");
                $("#my_video_1").addClass("vjs-ended");
                $("#my_video_1").addClass("vjs-paused");
                $("#box-close").css({"right":"0px"})
            }
            // You can potentially pas two arguments a color
            // for the background and a callback function
            var options = $.extend({
                'background': '#111',
                'callback': function () {}
            }, props);

            // This temporary div is the element that is
            // actually going to be enlarged in full screen

            var fs = $('<div>', {
                'css': {
                    'overflow-y': 'auto',
                    'background': options.background,
                    'width': '100%',
                    'height': '100%'
                }
            });

            var elem = this;

            // You can use the .fullScreen class to
            // apply styling to your element
            elem.addClass('fullScreen');

            // Inserting our element in the temporary
            // div, after which we zoom it in fullscreen
            fs.insertBefore(elem);
            fs.append(elem);
            requestFullScreen(fs.get(0));

            fs.click(function (e) {
                if (e.target == this) {
                    // If the black bar was clicked
                    cancelFullScreen();
                }
            });
            elem.cancel = function () {
                cancelFullScreen();
                return elem;
            };
            onFullScreenEvent(function (fullScreen) {
                if (!fullScreen) {
                    // We have exited full screen.
                    // Remove the class and destroy
                    // the temporary div
                    elem.removeClass('fullScreen').insertBefore(fs);
                    fs.remove();
                }
                // Calling the user supplied callback
                options.callback(fullScreen);
            });
            return elem;
        };


        // These helper functions available only to our plugin scope.


        function supportFullScreen() {
            var doc = document.documentElement;
            return ('requestFullscreen' in doc) ||
                    ('mozRequestFullScreen' in doc && document.mozFullScreenEnabled) ||
                    ('webkitRequestFullScreen' in doc);
        }

        function requestFullScreen(elem) {
            if (elem.requestFullscreen) {
                elem.requestFullscreen();
            } else if (elem.mozRequestFullScreen) {
                elem.mozRequestFullScreen();
            } else if (elem.webkitRequestFullScreen) {
                elem.webkitRequestFullScreen();
            }
        }

        function fullScreenStatus() {
            return document.fullscreen ||
                    document.mozFullScreen ||
                    document.webkitIsFullScreen;
        }

        function cancelFullScreen() {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.webkitCancelFullScreen) {
                document.webkitCancelFullScreen();
            }


        }

        function onFullScreenEvent(callback) {
            $(document).on("fullscreenchange mozfullscreenchange webkitfullscreenchange", function () {
                // The full screen status is automatically
                // passed to our callback as an argument.
                callback(fullScreenStatus());
            });
        }

    })(jQuery);
    // JavaScript Document
    var flagTime=0;
    //var path='http://vali.cp31.ott.cibntv.net/youku/6977E940E713A7171FEB62FCC/03000801005B2C9A85D5AE003E880348BAB34E-F210-65BC-FB34-6E283F6913F6.mp4?sid=053145202822012201600_00_Ac0998505fc404d43f6a9f9ee4c22bb7d&sign=db88667bf078d680b45b69121afbca59&ctype=50&hd=1'
    function appHmtl(link) {
        var _html=' <div id="videoplayer_overlay" style="">' +
                '<div id="videoplayer_outer_container"><div id="videoplayer_container"><div id="videoplayer">' +
                '<div data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" poster="" preload="auto" class="video-js vjs-sublime-skin vjs-controls-enabled vjs-has-started vjs-playing vjs-user-inactive" id="my_video_1" style="width: 100%; height: 100%;">' +
                '<video  id="my_video_1_html5_api" class="vjs-tech" preload="auto"  preload="" controls="" poster="" data-setup="{&quot;techOrder&quot;: [&quot;html5&quot;]}" src="'+link+'">' +
                '<source type="video/mp4" src="'+link+'"></video><div></div>' +
                '<div class="vjs-loading-spinner"></div><div class="vjs-text-track-display vjs-hidden"></div><div class="vjs-big-play-button" role="button" aria-live="polite" tabindex="0" aria-label="play video"><span aria-hidden="true"></span></div><div style="display:none;" class="vjs-control-bar"><div class="vjs-play-control vjs-control  vjs-playing" role="button" aria-live="polite" tabindex="0"><div class="vjs-control-content"><span class="vjs-control-text">Pause</span></div></div><div class="vjs-current-time vjs-time-controls vjs-control"><div class="vjs-current-time-display" aria-live="off"><span class="vjs-control-text">Current Time</span> 2:02</div></div><div class="vjs-time-divider"><div><span>/</span></div></div><div class="vjs-duration vjs-time-controls vjs-control"><div class="vjs-duration-display" aria-live="off"><span class="vjs-control-text">Duration Time</span> 4:55</div></div><div class="vjs-remaining-time vjs-time-controls vjs-control"><div class="vjs-remaining-time-display" aria-live="off"><span class="vjs-control-text">Remaining Time</span> -2:53</div></div><div class="vjs-live-controls vjs-control"><div class="vjs-live-display" aria-live="off"><span class="vjs-control-text">Stream Type</span>LIVE</div></div>' +
                '<div class="vjs-progress-control vjs-control">' +
                '<div role="slider" aria-valuenow="60.21" aria-valuemin="0" aria-valuemax="100" tabindex="0" class="vjs-progress-holder vjs-slider" aria-label="video progress bar" aria-valuetext="3:02">' +
                '<div class="vjs-load-progress" style="width: 100%;">' +
                '<span class="vjs-control-text" style="left: 0%; width: 9.93072%;">' +
                '<span>Loaded</span>: 0%</span><div style="left: 14.3375%; width: 85.6625%;">' +
                '</div></div><div class="vjs-play-progress" style="width: 0%;"><' +
                'span class="vjs-control-text"><span>Progress</span>: 0%</span>' +
                '</div>' +
                '<div class="vjs-seek-handle vjs-slider-handle" aria-live="off" style="left: 60.21%;"><span class="vjs-control-text">3:02</span></div></div></div>'+
                '<div class="vjs-fullscreen-control vjs-control " role="button" aria-live="polite" tabindex="0"><div class="vjs-control-content"><span class="vjs-control-text">Fullscreen</span></div></div><div class="vjs-volume-control vjs-control"><div role="slider" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" tabindex="0" class="vjs-volume-bar vjs-slider" aria-label="volume level" aria-valuetext="100%"><div class="vjs-volume-level"><span class="vjs-control-text"></span></div><div class="vjs-volume-handle vjs-slider-handle"><span class="vjs-control-text"  id="timesID">00:00</span></div></div></div><div class="vjs-mute-control vjs-control" role="button" aria-live="polite" tabindex="0"><div><span class="vjs-control-text">Mute</span></div></div><div class="vjs-playback-rate vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true"><div class="vjs-control-content"><span class="vjs-control-text">Playback Rate</span><div class="vjs-menu"><ul class="vjs-menu-content"></ul></div></div><div class="vjs-playback-rate-value">1</div></div><div class="vjs-subtitles-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Subtitles Menu"><div class="vjs-control-content"><span class="vjs-control-text">Subtitles</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">subtitles off</li></ul></div></div></div><div class="vjs-captions-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Captions Menu"><div class="vjs-control-content"><span class="vjs-control-text">Captions</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-item vjs-selected" role="button" aria-live="polite" tabindex="0" aria-selected="true">captions off</li></ul></div></div></div><div class="vjs-chapters-button vjs-menu-button vjs-control  vjs-hidden" role="button" aria-live="polite" tabindex="0" aria-haspopup="true" aria-label="Chapters Menu"><div class="vjs-control-content"><span class="vjs-control-text">Chapters</span><div class="vjs-menu"><ul class="vjs-menu-content"><li class="vjs-menu-title">Chapters</li></ul></div></div></div></div><div class="vjs-error-display"><div></div></div><div class="vjs-caption-settings vjs-modal-overlay vjs-hidden"><div class="vjs-tracksettings"><div class="vjs-tracksettings-colors"><div class="vjs-fg-color vjs-tracksetting"><label class="vjs-label">Foreground</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-text-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Opaque</option></select></span></div><div class="vjs-bg-color vjs-tracksetting"><label class="vjs-label">Background</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-bg-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div><div class="window-color vjs-tracksetting"><label class="vjs-label">Window</label><select><option value="">---</option><option value="#FFF">White</option><option value="#000">Black</option><option value="#F00">Red</option><option value="#0F0">Green</option><option value="#00F">Blue</option><option value="#FF0">Yellow</option><option value="#F0F">Magenta</option><option value="#0FF">Cyan</option></select><span class="vjs-window-opacity vjs-opacity"><select><option value="">---</option><option value="1">Opaque</option><option value="0.5">Semi-Transparent</option><option value="0">Transparent</option></select></span></div></div><div class="vjs-tracksettings-font"><div class="vjs-font-percent vjs-tracksetting"><label class="vjs-label">Font Size</label><select><option value="0.50">50%</option><option value="0.75">75%</option><option value="1.00" selected="">100%</option><option value="1.25">125%</option><option value="1.50">150%</option><option value="1.75">175%</option><option value="2.00">200%</option><option value="3.00">300%</option><option value="4.00">400%</option></select></div><div class="vjs-edge-style vjs-tracksetting"><label class="vjs-label">Text Edge Style</label><select><option value="none">None</option><option value="raised">Raised</option><option value="depressed">Depressed</option><option value="uniform">Uniform</option><option value="dropshadow">Dropshadow</option></select></div><div class="vjs-font-family vjs-tracksetting"><label class="vjs-label">Font Family</label><select><option value="">Default</option><option value="monospaceSerif">Monospace Serif</option><option value="proportionalSerif">Proportional Serif</option><option value="monospaceSansSerif">Monospace Sans-Serif</option><option value="proportionalSansSerif">Proportional Sans-Serif</option><option value="casual">Casual</option><option value="script">Script</option><option value="small-caps">Small Caps</option></select></div></div></div><div class="vjs-tracksettings-controls"><button class="vjs-default-button">Defaults</button><button class="vjs-done-button">Done</button></div></div><a class="icon-view-close" id="box-close" href="javascript:;">&times;</a></div></div></div></div></div>';
        return _html;
        // $(".video").attr("autoplay",true)
    }
    function getTools() {
        $("body").find("#my_video_1_html5_api").get(0).play();
        $("body").find(".video-js").hover(function () {
            $(".video-js").addClass("vjs-user-active");
            $(".video-js").removeClass("vjs-user-inactive");
        },function () {
            $(".video-js").removeClass("vjs-user-active");
            $(".video-js").addClass("vjs-user-inactive");
        })
        $(".vjs-fullscreen-control").on("click",function (event) {
            $(this).parent().parent().fullScreen()
            $(".vjs-play-control").addClass("vjs-playing");
            var w=null;
            clearTimeout(w)
            if(!flagTime){
                w=setTimeout(function () {
                    $("body").find("#my_video_1_html5_api").get(0).play()
                },300)
            }
            event.stopPropagation();
        })

        $("body").find(".vjs-play-control").on("click",function (e) {
            if($(this).hasClass("vjs-playing")){
                flagTime=1;
                $(this).removeClass("vjs-playing")
                $("body").find(".video-js").removeClass("vjs-playing")
                $(this).addClass("vjs-paused");
                $("body").find("#my_video_1_html5_api").paused = true;
                $("body").find("#my_video_1_html5_api").get(0).pause()
                e.stopPropagation();
            }else {
                flagTime=0
                $(this).addClass("vjs-playing")
                $("body").find(".video-js").addClass("vjs-playing")
                $(this).removeClass("vjs-paused")
                $("body").find("#my_video_1_html5_api").paused = false;
                $("body").find("#my_video_1_html5_api").get(0).play();
                e.stopPropagation();
            }
        })

        $("body").find("#box-close").on("click",function () {
            $("#videoplayer_overlay").remove()
        })
        $("body").find(".video-js").on("click",function (s) {
            // if($(this).hasClass("vjs-playing")){
            //     flagTime=1;
            //     $(this).removeClass("vjs-playing")
            //     $("body").find(".video-js").removeClass("vjs-playing")
            //     $(this).addClass("vjs-paused");
            //     $("body").find("#my_video_1_html5_api").paused = true;
            //     $("body").find("#my_video_1_html5_api").get(0).pause();
            //     s.stopPropagation();
            // }else {
            //     flagTime=0;
            //     $(this).addClass("vjs-playing")
            //     $("body").find(".video-js").addClass("vjs-playing")
            //     $(this).removeClass("vjs-paused")
            //     $("body").find("#my_video_1_html5_api").paused = false;
            //     $("body").find("#my_video_1_html5_api").get(0).play();
            //     s.stopPropagation();
            // }
        })
        var l=null;
        l=setTimeout(function () {
            clearTimeout(l)
            //获取视频时间
            $(document).ready(function(){
                $("body").find("#my_video_1_html5_api").on(
                        "timeupdate", function(event){
                            onTrackedVideoFrame(this.currentTime, this.duration);
                        });
            });
            function onTrackedVideoFrame(currentTime, duration){
                $("#current").text(currentTime);
                $("#duration").text(duration);
                var a=currentTime/duration;
                var b=(a*100)+"%";
                document.getElementsByClassName('vjs-play-progress')[0].style.width=b;
                $("#hy").text(b);
                if(currentTime==duration){
                    $("#pro").text("(已完成)");
                }
            }


        },100)
    }

    $("body").on("click",'.vidlisUser li',function () {
        var host=window.location.hostname;
        var path='';
        var dataValue=$(this).find(".vid_screenshot").attr("data-value");
        //流畅版本
        if(quality=="0"||quality==""){
	        var d = new Date();      
	        var date=new Date(d.getFullYear()
	            , d.getMonth()
	            , d.getDate()
	            , d.getHours()
	            , d.getMinutes()
	            , d.getSeconds())
	            date.toUTCString();
	        date=Math.floor(date.getTime()/ 1000);
	        //加密后缀,将originquantum+文件路径+utc时间用md5加密
	        var encode=$.md5("originquantum/360p/"+dataValue+date)+"&qubit="+date;
	        path="http://fast.qpanda.cn/360p/"+dataValue+"?video="+encode;        	
        }else{
            path="http://video.qpanda.cn:65520/"+$(this).find(".vid_screenshot").attr("data-value")
        }

        $("body").append(appHmtl(path));
        getTools()
    })




    var videoData=[
        {name:"全部",link:"",classify:"0"},
        {name:"基础板块",link:"",classify:"1"},
        {name:"工具板块",link:"",classify:"2"},
        {name:"编程部分",link:"",classify:"3"},
        // {name:"应用部分",link:"",classify:"4"},
        {name:"硬件介绍",link:"",classify:"4"},
        {name:"科大教程",link:"",classify:"5"}

    ]
    var vidDetails=[
        [
            //{link:"",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
            {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
            {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
            {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
            {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
            {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
            {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
            {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
            {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
            {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
            {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
            {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
            {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
            //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
            //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源QRunes编程",time:""},
            {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.4 本源QPanda 2介绍",time:"06:01"},
            {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.4 本源QPanda的安装与配置",time:"06:58"},
            {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.5 本源QPanda 2的编程教学1",time:"09:17"},
            {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.6 本源QPanda 2的编程教学2",time:"06:08"},
            {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
            {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
            {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
            {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
            {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"},
            {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
            {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
            {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
            {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
            {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
            {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
            {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
            {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
            {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"}

        ],
        [
            //{link:"",img:"${base}/assets/images/video/QuantumWorld.png",name:"1.1 量子世界",time:""},
            {link:"Basic/QuantumConcept.mp4",img:"${base}/assets/images/video/QuantumConcept.png",name:"1.2 量子计算介绍",time:"05:06"},
            {link:"Basic/TenQuestion1.mp4",img:"${base}/assets/images/video/TenQuestion1.png",name:"1.3 量子十问（上）",time:"03:38"},
            {link:"Basic/TenQuestion2.mp4",img:"${base}/assets/images/video/TenQuestion2.png",name:"1.4 量子十问（下）",time:"04:16"},
            {link:"Basic/OriginQuantumBasicMathematics.mp4",img:"${base}/assets/images/video/OriginQuantumBasicMathematics.png",name:"1.5 本源量子基础数学",time:"19:10"},
        ],
        [
            {link:"Tool/IntroductionQuantumCloudPlatform.mp4",img:"${base}/assets/images/video/IntroductionQuantumCloudPlatform.png",name:"2.1 量子云平台介绍",time:"02:35"},
            {link:"Tool/ComputingQuantumCloudFramework.mp4",img:"${base}/assets/images/video/ComputingQuantumCloudFramework.png",name:"2.2 计算与量子云框架",time:"06:07"},
            {link:"Tool/QuantumCloudPlatformUsageTutorial.mp4",img:"${base}/assets/images/video/QuantumCloudPlatformUsageTutorial.png",name:"2.3 量子云平台的使用教程",time:"11:51"},
            {link:"Tool/SinglequbitGateApplication.mp4",img:"${base}/assets/images/video/SinglequbitGateApplication.png",name:"2.4 单量子比特及其应用",time:"09:28"},
            {link:"Tool/MultipleqbitGatesApplications.mp4",img:"${base}/assets/images/video/MultipleqbitGatesApplications.png",name:"2.5 多量子比特及其应用",time:"07:59"},
            {link:"Tool/QRunes.mp4",img:"${base}/assets/images/video/QRunesNew.png",name:"2.6 OriginIR概念介绍",time:"06:35"},
            {link:"Tool/D-JAlgorithmTestonCloudPlatform.mp4",img:"${base}/assets/images/video/D-JAlgorithmTestonCloudPlatform.png",name:"2.7 D-J 算法在云平台上的测试",time:"06:03"},
        ],
        [
            {link:"Programming/IntroductionToQuantumProgramming.mp4",img:"${base}/assets/images/video/IntroductionToQuantumProgramming.png",name:"3.1 量子编程介绍",time:"07:57"},
            //{link:"",img:"${base}/assets/images/video/QuantumProgrammingLanguage.png",name:"3.2 量子编程语言",time:""},
            //{link:"",img:"${base}/assets/images/video/QRunesProgramming.png",name:"3.3 本源QRunes编程",time:""},
            {link:"Programming/IntroductionToOriginalQPanda2.mp4",img:"${base}/assets/images/video/IntroductionToOriginalQPanda2.png",name:"3.4 本源QPanda 2介绍",time:"06:01"},
            {link:"Programming/InstallationAndConfigurationOfQPanda2..mp4",img:"${base}/assets/images/video/InstallationAndConfigurationOfQPanda2.png",name:"3.4 本源QPanda的安装与配置",time:"06:58"},
            {link:"Programming/QPanda2ProgrammingTeaching1.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching1.png",name:"3.5 本源QPanda 2的编程教学1",time:"09:17"},
            {link:"Programming/QPanda2ProgrammingTeaching2.mp4",img:"${base}/assets/images/video/QPanda2ProgrammingTeaching.png",name:"3.6 本源QPanda 2的编程教学2",time:"06:08"}
        ],
        [
            {link:"Hardware/CopperPowderFilter.mp4",img:"${base}/assets/images/video/CopperPowderFilter.png",name:"5.1 铜粉滤波器",time:"01:48"},
            {link:"Hardware/Bias-TeeCoupler.mp4",img:"${base}/assets/images/video/Bias-TeeCoupler.png",name:"5.2 集成有源Bias-Tee耦合器",time:"02:14"},
            {link:"Hardware/ResistanceSplitter.mp4",img:"${base}/assets/images/video/ResistanceSplitter.png",name:"5.3 电阻功分器",time:"01:50"},
            {link:"Hardware/AIO.mp4",img:"${base}/assets/images/video/AIO.png",name:"5.4 量子测控一体机",time:"03:16"},
            {link:"Hardware/QuantumChip.mp4",img:"${base}/assets/images/video/QuantumChip.png",name:"5.5 量子芯片介绍",time:"02:48"}
        ],
        [

            {link:"USTC/2.BasicQuantumGates.mp4",img:"${base}/assets/images/video/basicQuantumGates.png",name:"1. basic quantum gates(基本量子逻辑门)",time:"04:34"},
            {link:"USTC/3.Deutsch-JoszaAlgorithm.mp4",img:"${base}/assets/images/video/Deutsch-JoszaAlgorithm.png",name:"2. Deutsch-Josza algorithm(Deutsch-Josza算法)",time:"04:44"},
            {link:"USTC/6.GroverSearchAlgorithm+Gexercise.mp4",img:"${base}/assets/images/video/GroverSearch AlgorithmGexercise.png",name:"3. Grover search algorithm+G.exercise(Grover 搜索算法)",time:"03:34"},
            {link:"USTC/9.SimonAlgorithm.mp4",img:"${base}/assets/images/video/SimonAlgorithm.png",name:"4. Simon algorithm(Simon算法)",time:"03:44"},
            {link:"USTC/7.QFTAlgorithm.mp4",img:"${base}/assets/images/video/QFTAlgorithm.png",name:"5. QFT algorithm (QFT算法)",time:"03:32"},
            {link:"USTC/5.FindingThePeriod.mp4",img:"${base}/assets/images/video/FindingThePeriod.png",name:"6. finding the period(寻找周期)",time:"03:34"},
            {link:"USTC/4.Factoring.mp4",img:"${base}/assets/images/video/Factoring.png",name:"7. factoring(分解算法)",time:"04:44"},
            {link:"USTC/1.AdiabaticTheorem.mp4",img:"${base}/assets/images/video/adiabaticTheorem.png",name:"8. adiabatic theorem(绝热定理)",time:"03:42"},
            {link:"USTC/8.SatisfiabilityProblem.mp4",img:"${base}/assets/images/video/satisfiabilityProblem.png",name:"9. satisfiability problem(可满足问题)",time:"03:32"}

        ]
    ]

    var vidHtml =''
    videoData.forEach(function (value,i) {
        if(i==0){
            vidHtml +=' <a href="javascript:void (0)" class="active" data-classify='+i+'>'+value.name+'</a>'
        }else {
            vidHtml +=' <a href="javascript:void (0)" data-classify='+i+'>'+value.name+'</a>'
        }
    })
    function vidHtmls(link,img,name,time) {
        return '<li><div class="vid_screenshot" data-value='+link+'><img src="'+img+'" alt=""></div><div class="vid_js"><span>'+name+'</span>' +
                '<span class="right">'+time+'</span></div><div class="vidHover"></div><div class="vidHoverImg"><img src="" alt=""></div></li>'
    }
    $(".OptionList").html(vidHtml)
    var vidDetailsHtml =''
    $("body").on("click",'.OptionList a',function () {
        vidDetailsHtml ='';
        $(this).addClass("active").siblings().removeClass("active");
        vidDetails[$(this).attr("data-classify")].forEach(function (value) {
            vidDetailsHtml +=vidHtmls(value.link,value.img,value.name,value.time)
        })
        $(".vidlisUser").html(vidDetailsHtml)
    })
    $(".OptionList a").eq(0).click()


    var quality="";

    $("body").on("click",'.OptionList1 a',function () {
        $(this).addClass("active").siblings().removeClass("active");
        quality=$(this).attr("data-classify");
    })
    
    
    var i
    $(".toolsAll li").each(function () {
        if($(this).hasClass("active")){
//                console.log($(this).index());
            i=$(this).index()
        }
        if($(this).index()==0){
            $(this).css({"left":"0"})
        }else if($(this).index()==4){
            $(this).css({"left":"-100px"})
        }else if($(this).index()>i){
            $(this).css({"left":"-100px"})
        }
    })

    $(".toolsAll li").on("click",function () {
        $(".toolsAll li").attr("style","")
        i=$(this).index()
        // console.log(i)
        if($(this).index()==0){
            $(this).css({"left":"0"})
        }
        if($(this).index()==4){
            $(this).css({"left":"-100px"})
        }
        $(this).addClass("active").siblings().removeClass("active");

        $(".toolsAll li").each(function () {
            if($(this).index()>i){
                $(this).css({"left":"-100px"})
            }
        })
    });

    $(".toolsAll li").hover(function () {
        $(".toolsAll li").attr("style","")
        i=$(this).index()
        // console.log(i)
        if($(this).index()==0){
            $(this).css({"left":"0"})
        }
        if($(this).index()==4){
            $(this).css({"left":"-100px"})
        }
        $(this).addClass("active").siblings().removeClass("active");

        $(".toolsAll li").each(function () {
            if($(this).index()>i){
                $(this).css({"left":"-100px"})
            }
        })
    });

</script>
</@main.body>
<@main.footer>

</@main.footer>
