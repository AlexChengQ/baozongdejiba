/**
 * Bootstro.js Simple way to show your user around, especially first time users
 * Http://github.com/clu3/bootstro.js
 *
 * Credit thanks to
 * Revealing Module Pattern from
 * http://enterprisejquery.com/2010/10/how-good-c-habits-can-encourage-bad-javascript-habits-part-1/
 *
 * Bootstrap popover variable width
 * http://stackoverflow.com/questions/10028218/twitter-bootstrap-popovers-multiple-widths-and-other-css-properties
 *
 */

$(document).ready(function(){
    //Self-Executing Anonymous Func: Part 2 (Public & Private)
    (function( bootstro, $, undefined ) {
        var $elements; //jquery elements to be highlighted
        var count;
        var popovers = []; //contains array of the popovers data
        var activeIndex = null; //index of active item
        var bootstrapVersion = 3;

        var defaults = {
            nextButtonText : 'Next &raquo;', //will be wrapped with button as below
            //nextButton : '<button class="btn btn-primary btn-xs bootstro-next-btn">Next &raquo;</button>',
            prevButtonText : '&laquo; Prev',
            //prevButton : '<button class="btn btn-primary btn-xs bootstro-prev-btn">&laquo; Prev</button>',
            finishButtonText : '<i class="icon-ok"></i> Ok I got it, get back to the site',
            //finishButton : '<button class="btn btn-xs btn-success bootstro-finish-btn"><i class="icon-ok"></i> Ok I got it, get back to the site</button>',
            stopOnBackdropClick : true,
            stopOnEsc : true,

            //onComplete : function(params){} //params = {idx : activeIndex}
            //onExit : function(params){} //params = {idx : activeIndex}
            //onStep : function(params){} //params = {idx : activeIndex, direction : [next|prev]}
            //url : String // ajaxed url to get show data from

            margin : 100, //if the currently shown element's margin is less than this value
            // the element should be scrolled so that i can be viewed properly. This is useful
            // for sites which have fixed top/bottom nav bar
        };
        var settings;


        //===================PRIVATE METHODS======================
        //http://stackoverflow.com/questions/487073/check-if-element-is-visible-after-scrolling
        function is_entirely_visible($elem)
        {
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();

            var elemTop = $elem.offset().top;
            var elemBottom = elemTop + $elem.height();

            return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom)
                && (elemBottom <= docViewBottom) &&  (elemTop >= docViewTop) );
        }

        //add the nav buttons to the popover content;

        function add_nav_btn(content, i)
        {
            var $el = get_element(i);
            var nextButton, prevButton,finishButton2, finishButton, defaultBtnClass;
            if (bootstrapVersion == 2)
                defaultBtnClass = "btn btn-primary btn-mini";
            else
                defaultBtnClass = "btn btn-primary btn-xs"; //default bootstrap version 3
            content = content + "<div class='bootstro-nav-wrapper'>";
            if ($el.attr('data-bootstro-nextButton'))
            {
                nextButton = $el.attr('data-bootstro-nextButton');
            }
            else if ( $el.attr('data-bootstro-nextButtonText') )
            {
                nextButton = '<div><button class="' + defaultBtnClass + ' bootstro-next-btn" style="background-color:transparent;border: transparent"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" t="1525757300000" class="icon" style="" viewBox="0 0 1024 1024" version="1.1" p-id="7723" width="25" height="25"><defs><style type="text/css"/></defs><path d="M435.23822 774.738983c-8.462742 0-17.013489-2.65241-24.289196-8.149611-17.799388-13.418614-21.358447-38.755676-7.922437-56.55404L555.850206 507.419681l-152.247496-192.171788c-13.837146-17.476023-10.889001-42.88267 6.578836-56.729026 17.48421-13.846356 42.890856-10.906397 56.729026 6.578836L638.526183 481.742882c11.429307 14.413268 11.656481 34.715663 0.592494 49.382711l-171.616636 227.542366C459.564255 769.189593 447.470823 774.738983 435.23822 774.738983L435.23822 774.738983zM435.23822 774.738983" p-id="7724" fill="#002b56"/><path d="M511.999488 958.708971c-60.288085 0-118.79664-11.813047-173.901679-35.124985-53.187363-22.49227-100.963483-54.704926-141.970432-95.710852-41.005926-41.006949-73.218582-88.784092-95.709829-141.987828C77.103564 630.79664 65.290517 572.288085 65.290517 512s11.813047-118.788453 35.126009-173.894516c22.491247-53.194526 54.703903-100.962459 95.709829-141.978618 41.006949-41.015136 88.784092-73.218582 141.970432-95.719038 55.106062-23.303752 113.613594-35.116799 173.901679-35.116799S630.778732 77.104075 685.884794 100.407827c53.203736 22.500457 100.963483 54.703903 141.986805 95.719038 41.024345 41.016159 73.219605 88.784092 95.710852 141.978618 23.312962 55.106062 35.126009 113.606431 35.126009 173.894516s-11.813047 118.79664-35.126009 173.885306c-22.491247 53.203736-54.686507 100.980879-95.710852 141.987828-41.023322 41.005926-88.783069 73.218582-141.986805 95.710852C630.778732 946.895925 572.287573 958.708971 511.999488 958.708971L511.999488 958.708971zM511.999488 146.056494c-201.786773 0-365.93532 164.156734-365.93532 365.943506s164.147524 365.952716 365.93532 365.952716 365.93532-164.165943 365.93532-365.952716S713.786261 146.056494 511.999488 146.056494L511.999488 146.056494zM511.999488 146.056494" p-id="7725" fill="#002b56"/></svg></button></div>';
            }
            else
            {
                if (typeof settings.nextButton != 'undefined' /*&& settings.nextButton != ''*/)
                    nextButton = settings.nextButton;
                else
                    nextButton = '<div><button class="' + defaultBtnClass + ' bootstro-next-btn" style="background-color:transparent;border: transparent"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" t="1525757300000" class="icon" style="" viewBox="0 0 1024 1024" version="1.1" p-id="7723" width="25" height="25"><defs><style type="text/css"/></defs><path d="M435.23822 774.738983c-8.462742 0-17.013489-2.65241-24.289196-8.149611-17.799388-13.418614-21.358447-38.755676-7.922437-56.55404L555.850206 507.419681l-152.247496-192.171788c-13.837146-17.476023-10.889001-42.88267 6.578836-56.729026 17.48421-13.846356 42.890856-10.906397 56.729026 6.578836L638.526183 481.742882c11.429307 14.413268 11.656481 34.715663 0.592494 49.382711l-171.616636 227.542366C459.564255 769.189593 447.470823 774.738983 435.23822 774.738983L435.23822 774.738983zM435.23822 774.738983" p-id="7724" fill="#002b56"/><path d="M511.999488 958.708971c-60.288085 0-118.79664-11.813047-173.901679-35.124985-53.187363-22.49227-100.963483-54.704926-141.970432-95.710852-41.005926-41.006949-73.218582-88.784092-95.709829-141.987828C77.103564 630.79664 65.290517 572.288085 65.290517 512s11.813047-118.788453 35.126009-173.894516c22.491247-53.194526 54.703903-100.962459 95.709829-141.978618 41.006949-41.015136 88.784092-73.218582 141.970432-95.719038 55.106062-23.303752 113.613594-35.116799 173.901679-35.116799S630.778732 77.104075 685.884794 100.407827c53.203736 22.500457 100.963483 54.703903 141.986805 95.719038 41.024345 41.016159 73.219605 88.784092 95.710852 141.978618 23.312962 55.106062 35.126009 113.606431 35.126009 173.894516s-11.813047 118.79664-35.126009 173.885306c-22.491247 53.203736-54.686507 100.980879-95.710852 141.987828-41.023322 41.005926-88.783069 73.218582-141.986805 95.710852C630.778732 946.895925 572.287573 958.708971 511.999488 958.708971L511.999488 958.708971zM511.999488 146.056494c-201.786773 0-365.93532 164.156734-365.93532 365.943506s164.147524 365.952716 365.93532 365.952716 365.93532-164.165943 365.93532-365.952716S713.786261 146.056494 511.999488 146.056494L511.999488 146.056494zM511.999488 146.056494" p-id="7725" fill="#002b56"/></svg></button></div>';
            }

            if ($el.attr('data-bootstro-prevButton'))
            {
                prevButton = $el.attr('data-bootstro-prevButton');
            }
            else if ( $el.attr('data-bootstro-prevButtonText') )
            {
                prevButton = '<div style="float: left"><button class="' + defaultBtnClass + ' bootstro-prev-btn" style="background-color:transparent;border: transparent"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" t="1525757406371" class="icon" style="" viewBox="0 0 1024 1024" version="1.1" p-id="8181" width="25" height="25"><defs><style type="text/css"/></defs><path d="M588.760756 774.738983c-12.232602 0-24.325012-5.54939-32.263821-16.071024L384.879276 531.125593c-11.063987-14.667048-10.836813-34.969443 0.592494-49.382711l171.616636-216.645179c13.837146-17.485233 39.244816-20.425192 56.729026-6.578836 17.466814 13.845333 20.415982 39.251979 6.578836 56.729026L468.147748 507.419681l152.824641 202.616674c13.43601 17.798365 9.875928 43.134403-7.922437 56.55404C605.774245 772.086573 597.222475 774.738983 588.760756 774.738983L588.760756 774.738983zM588.760756 774.738983" p-id="8182" fill="#002b56"/><path d="M511.999488 958.708971c-60.288085 0-118.779244-11.813047-173.885306-35.124985-53.203736-22.49227-100.963483-54.704926-141.986805-95.710852-41.024345-41.006949-73.219605-88.784092-95.710852-141.987828C77.103564 630.79664 65.290517 572.288085 65.290517 512s11.813047-118.788453 35.126009-173.894516c22.491247-53.194526 54.686507-100.962459 95.710852-141.978618 41.023322-41.015136 88.783069-73.218582 141.986805-95.719038 55.106062-23.303752 113.597221-35.116799 173.885306-35.116799s118.79664 11.813047 173.901679 35.116799c53.187363 22.500457 100.963483 54.703903 141.970432 95.719038 41.005926 41.016159 73.218582 88.784092 95.709829 141.978618 23.312962 55.106062 35.126009 113.606431 35.126009 173.894516s-11.813047 118.79664-35.126009 173.885306c-22.491247 53.203736-54.703903 100.980879-95.709829 141.987828-41.006949 41.005926-88.784092 73.218582-141.970432 95.710852C630.796128 946.895925 572.287573 958.708971 511.999488 958.708971L511.999488 958.708971zM511.999488 146.056494c-201.786773 0-365.93532 164.156734-365.93532 365.943506s164.147524 365.952716 365.93532 365.952716 365.93532-164.165943 365.93532-365.952716S713.786261 146.056494 511.999488 146.056494L511.999488 146.056494zM511.999488 146.056494" p-id="8183" fill="#002b56"/></svg></button></div>';
            }
            else
            {
                if (typeof settings.prevButton != 'undefined' /*&& settings.prevButton != ''*/)
                    prevButton = settings.prevButton;
                else
                    prevButton = '<div style="float: left"><button class="' + defaultBtnClass + ' bootstro-prev-btn" style="background-color:transparent;border: transparent"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" t="1525757406371" class="icon" style="" viewBox="0 0 1024 1024" version="1.1" p-id="8181" width="25" height="25"><defs><style type="text/css"/></defs><path d="M588.760756 774.738983c-12.232602 0-24.325012-5.54939-32.263821-16.071024L384.879276 531.125593c-11.063987-14.667048-10.836813-34.969443 0.592494-49.382711l171.616636-216.645179c13.837146-17.485233 39.244816-20.425192 56.729026-6.578836 17.466814 13.845333 20.415982 39.251979 6.578836 56.729026L468.147748 507.419681l152.824641 202.616674c13.43601 17.798365 9.875928 43.134403-7.922437 56.55404C605.774245 772.086573 597.222475 774.738983 588.760756 774.738983L588.760756 774.738983zM588.760756 774.738983" p-id="8182" fill="#002b56"/><path d="M511.999488 958.708971c-60.288085 0-118.779244-11.813047-173.885306-35.124985-53.203736-22.49227-100.963483-54.704926-141.986805-95.710852-41.024345-41.006949-73.219605-88.784092-95.710852-141.987828C77.103564 630.79664 65.290517 572.288085 65.290517 512s11.813047-118.788453 35.126009-173.894516c22.491247-53.194526 54.686507-100.962459 95.710852-141.978618 41.023322-41.015136 88.783069-73.218582 141.986805-95.719038 55.106062-23.303752 113.597221-35.116799 173.885306-35.116799s118.79664 11.813047 173.901679 35.116799c53.187363 22.500457 100.963483 54.703903 141.970432 95.719038 41.005926 41.016159 73.218582 88.784092 95.709829 141.978618 23.312962 55.106062 35.126009 113.606431 35.126009 173.894516s-11.813047 118.79664-35.126009 173.885306c-22.491247 53.203736-54.703903 100.980879-95.709829 141.987828-41.006949 41.005926-88.784092 73.218582-141.970432 95.710852C630.796128 946.895925 572.287573 958.708971 511.999488 958.708971L511.999488 958.708971zM511.999488 146.056494c-201.786773 0-365.93532 164.156734-365.93532 365.943506s164.147524 365.952716 365.93532 365.952716 365.93532-164.165943 365.93532-365.952716S713.786261 146.056494 511.999488 146.056494L511.999488 146.056494zM511.999488 146.056494" p-id="8183" fill="#002b56"/></svg></button></div>';
            }

            if ($el.attr('data-bootstro-finishButton'))
            {
                finishButton = $el.attr('data-bootstro-finishButton');
            }
            else if ( $el.attr('data-bootstro-finishButtonText') )
            {
                finishButton = '<button class="' + defaultBtnClass +' bootstro-finish-btn" style="background-color:transparent;border: transparent">' + $el.attr('data-bootstro-finishButtonText') +  '</button>';
            }
            else
            {
                if (typeof settings.finishButton != 'undefined' /*&& settings.finishButton != ''*/){
                    finishButton = settings.finishButton;
                    finishButton2= settings.finishButton2
                }

                else
                    finishButton = '<button class="' + defaultBtnClass +' bootstro-finish-btn" style="background-color:transparent;border: transparent">' + settings.finishButtonText + '</button>';
            }

            // console.log(i)
            if (count != 1)
            {

                if(getCookie('isNext')==1&&i!=3&&i!=4&&i!=7&&i!=8&&i!=10&&i!=12&&i!=13&&i!=15&&i!=16&&i!=18&&i!=19&&i!=20){
                    if (i == 0)
                        content = content + nextButton+finishButton;
                    else if (i == count -1 )
                        content = content + prevButton+finishButton;
                    else
                        content = content + nextButton+finishButton + prevButton
                }else if(getCookie('isNext')!=1){
                    if (i == 0)
                        content = content+finishButton;
                    else if (i == count -1 )
                        content = content + nextButton+finishButton;
                    else
                        content = content + nextButton+finishButton ;
                }else {
                    content = content+finishButton;
                }
                // if (i == 0)
                //     content = content + nextButton;
                // else if (i == count -1 )
                //     content = content + prevButton;
                // else
                //     content = content + nextButton + prevButton
            }
            content = content + '</div>';

            content = content;
            return content;
        }

        //prep objects from json and return selector
        process_items = function(popover)
        {
            var selectorArr = [];
            $.each(popover, function(t,e){
                //only deal with the visible element
                //build the selector
                $.each(e, function(j, attr){
                    $(e.selector).attr('data-bootstro-' + j, attr);
                });
                if ($(e.selector).is(":visible"))
                    selectorArr.push(e.selector);
            });
            return selectorArr.join(",");
        }

        //get the element to intro at stack i
        get_element = function(i)
        {
            //get the element with data-bootstro-step=i
            //or otherwise the the natural order of the set
            if ($elements.filter("[data-bootstro-step=" + i +"]").size() > 0)
                return $elements.filter("[data-bootstro-step=" + i +"]");
            else
            {
                return $elements.eq(i);
                /*
                nrOfElementsWithStep = 0;
                $elements.filter("[data-bootstro-step!='']").each(function(j,e){
                    nrOfElementsWithStep ++;
                    if (j > i)
                        return $elements.filter(":not([data-bootstro-step])").eq(i - nrOfElementsWithStep);
                })
                */
            }
        }

        get_popup = function(i)
        {
            var p = {};
            var $el = get_element(i);
            //p.selector = selector;
            var t = '';
            if (count > 1)
            {
                t = "<span class='label label-success' style='padding:.3em .6em .3em;margin-left: 0px;background:#002b56;'>" + (i +1)  + "/" + count + "</span>";
            }
            p.title = $el.attr('data-bootstro-title') || '';
            if (p.title != '' && t != '')
                p.title = t + '  ' + '<span style="width: auto;line-height:19px;">' + p.title +'</span>';
            else if (p.title == '')
                p.title = t;

            p.content = $el.attr('data-bootstro-content') || '';
            p.content = add_nav_btn(p.content, i);
            p.placement = $el.attr('data-bootstro-placement') || 'top';
            var style = '';
            if ($el.attr('data-bootstro-width'))
            {
                p.width = $el.attr('data-bootstro-width');
                style = style + 'width:' + $el.attr('data-bootstro-width') + ';'
            }
            if ($el.attr('data-bootstro-height'))
            {
                p.height = $el.attr('data-bootstro-height');
                style = style + 'height:' + $el.attr('data-bootstro-height') + ';'
            }
            p.trigger = 'manual'; //always set to manual.

            p.html = $el.attr('data-bootstro-html') || 'top';

            //resize popover if it's explicitly specified
            //note: this is ugly. Could have been best if popover supports width & height
            p.template = '<div class="popover" style="' + style + '"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title" style="padding-left: 10px;color: #161616;height: 30px;padding-top: 5px"></h3><div class="popover-content" style="padding: 9px 26px;"><p></p></div></div>' +
                '</div>';

            return p;

        }

        //===================PUBLIC METHODS======================
        //destroy popover at stack index i
        bootstro.destroy_popover = function(i)
        {
            var i = i || 0;
            if (i != 'all')
            {
                var $el = get_element(i);//$elements.eq(i);
                $el.popover('destroy').removeClass('bootstro-highlight');
            }
            /*
            else //destroy all
            {
                $elements.each(function(e){

                    $(e).popover('destroy').removeClass('bootstro-highlight');
                });
            }
            */
        };

        //destroy active popover and remove backdrop
        bootstro.stop = function()
        {
            $("#ascrail2000-hr").show();
            setCookie("isNext","0");
            setCookie("isTip","1");
            setCookie("isCookie","0");
            // if(getCookie("isTip")!=0){
            //     return false;
            // }

            $.ajax(base+'/QCode/updUser.json',{},function () {},"json");
            bootstro.destroy_popover(activeIndex);
            $("div.bootstro-backdrop").remove();
            bootstro.unbind();
            if (typeof settings.onExit == 'function')
                settings.onExit.call(this,{idx : activeIndex});
        };

        //go to the popover number idx starting from 0
        bootstro.go_to = function(idx)
        {
            //destroy current popover if any
            bootstro.destroy_popover(activeIndex);
            if (count != 0)
            {
                var p = get_popup(idx);
                var $el = get_element(idx);

                $el.popover(p).popover('show');

                //scroll if neccessary
                var docviewTop = $(window).scrollTop();
                var top = Math.min($(".popover.in").offset().top, $el.offset().top);

                //distance between docviewTop & min.
                var topDistance = top - docviewTop;

                if (topDistance < settings.margin) //the element too up above
                    $('html,body').animate({
                            scrollTop: top - settings.margin},
                        'slow');
                else if(!is_entirely_visible($(".popover.in")) || !is_entirely_visible($el))
                //the element is too down below
                    $('html,body').animate({
                            scrollTop: top - settings.margin},
                        'slow');
                // html

                $el.addClass('bootstro-highlight');
                activeIndex = idx;
            }
        };

        bootstro.next = function()
        {
            if(getCookie('isNext')!=1&&activeIndex==1){shows(1)}
            if(getCookie('isNext')!=1&&activeIndex==2){showt(2)}
            if(getCookie('isNext')!=1&&activeIndex==3){saveProject();}
            if(getCookie("isTip")!=0){
                return false;
            }
            // console.log(activeIndex)

            setCookie("isCookie","0");
            if(getCookie('isNext')!=1&&activeIndex==2){
                setTimeout(function () {
                    bootstro.go_to(activeIndex + 1);
                    if (typeof settings.onStep == 'function')
                        settings.onStep.call(this, {idx : activeIndex, direction : 'next'});//
                },100)

            }else {
                if (activeIndex + 1 == count)
                {
                    if (typeof settings.onComplete == 'function')
                        settings.onComplete.call(this, {idx : activeIndex});//
                }
                else
                {
                    bootstro.go_to(activeIndex + 1);

                    $(".mask1").remove();
                    if(getCookie("isNext")==1&&activeIndex==1){
                        $("#vectoring4").append('<div class="mask1"></div>')
                    }else if(getCookie("isNext")==1&&activeIndex==2){
                        $("#vectoring5").append('<div class="mask1"></div>')
                    }else if(getCookie("isNext")==1&&activeIndex==6){
                        $("#vectoring9").append('<div class="mask1"></div>')
                    }
                    if (typeof settings.onStep == 'function')
                        settings.onStep.call(this, {idx : activeIndex, direction : 'next'});//
                }
            }

        };

        bootstro.prev = function()
        {
            if (activeIndex == 0)
            {
                /*
                if (typeof settings.onRewind == 'function')
                    settings.onRewind.call(this, {idx : activeIndex, direction : 'prev'});//
                */
            }
            else
            {
                bootstro.go_to(activeIndex -1);
                if (typeof settings.onStep == 'function')
                    settings.onStep.call(this, {idx : activeIndex, direction : 'prev'});//
            }
        };

        bootstro._start = function(selector)
        {
            selector = selector || '.bootstro';

            $elements = $(selector);
            count  = $elements.size();
            if (count > 0 && $('div.bootstro-backdrop').length === 0)
            {
                // Prevents multiple copies
                $('<div class="bootstro-backdrop"></div>').appendTo('body');
                bootstro.bind();
                bootstro.go_to(0);
            }
        };

        bootstro.start = function(selector, options)
        {
            settings = $.extend(true, {}, defaults); //deep copy
            $.extend(settings, options || {});
            //if options specifies a URL, get the intro configuration from URL via ajax
            if (typeof settings.url != 'undefined')
            {
                //get config from ajax
                $.ajax({
                    url : settings.url,
                    success : function(data){
                        if (data.success)
                        {
                            //result is an array of {selector:'','title':'','width', ...}
                            var popover = data.result;
                            //console.log(popover);
                            selector = process_items(popover);
                            bootstro._start(selector);
                        }
                    }
                });
            }
            //if options specifies an items object use it to load the intro configuration
            //settings.items is an array of {selector:'','title':'','width', ...}
            else if (typeof settings.items != 'undefined')
            {
                bootstro._start(process_items(settings.items))
            }
            else
            {
                bootstro._start(selector);
            }
        };

        bootstro.set_bootstrap_version = function(ver)
        {
            bootstrapVersion = ver;
        }

        //bind the nav buttons click event
        bootstro.bind = function()
        {
            bootstro.unbind();

            $("html").on('click.bootstro', ".bootstro-next-btn", function(e){
                bootstro.next();
                // console.log(activeIndex)
                e.preventDefault();
                return false;
            });

            $("html").on('click.bootstro', ".bootstro-prev-btn", function(e){
                bootstro.prev();
                // console.log(activeIndex)
                e.preventDefault();
                return false;
            });

            //end of show
            $("html").on('click.bootstro', ".bootstro-finish-btn", function(e){
                setCookie("isNext","0");
                //$.ajax('https://qcode.qubitonline.cn/QCode/updUser.json',{},function () {},"json");
                e.preventDefault();
                bootstro.stop();
                window.location.reload();
            });

            if (settings.stopOnBackdropClick)
            {
                $("html").on('click.bootstro', 'div.bootstro-backdrop', function(e){
                    if ($(e.target).hasClass('bootstro-backdrop'))
                        bootstro.stop();
                });
            }

            //bind the key event
            // $(document).on('keydown.bootstro', function(e){
            //     var code = (e.keyCode ? e.keyCode : e.which);
            //     if (code == 39 || code == 40)
            //         bootstro.next();
            //     else if (code == 37 || code == 38)
            //         bootstro.prev();
            //     else if(code == 27 && settings.stopOnEsc)
            //         bootstro.stop();
            // })
        };

        bootstro.unbind = function()
        {
            $("html").unbind('click.bootstro');
            $(document).unbind('keydown.bootstro');
        }

    }( window.bootstro = window.bootstro || {}, jQuery ));
});
