/**
 * $.imallShowTip
 * @extends jquery-1.6.1.min.js
 * @fileOverview 创建文字提示框
 * @author xws
 * @version 0.1
 * @date 2012-04-12
 * @example
 *
 */
(function($){
    $.fn.imallCountdown = function(entTime,type,systemTime){
        var showCoutdown = $(this);
        var sh;
        var endtimeStr = entTime.replace(/-/g,"/");
        var endTime=new Date(endtimeStr);
        var nowtime = new Date(systemTime);
        var leftsecond=parseInt((endTime.getTime()-nowtime.getTime())/1000);
        sh=setInterval(function(){
            fresh(entTime,sh,showCoutdown,type,leftsecond);
            leftsecond -= 1;
        },1000);
    };

    function fresh(endDate,sh,showCoutdown,type,leftsecond){
        var d = parseInt(leftsecond/3600/24);
        var h = parseInt((leftsecond/3600)%24);
        var m = parseInt((leftsecond/60)%60);
        var s = parseInt(leftsecond%60);
        if(d<10){
            d = "0" + d;
        }
        if(h<10){
            h = "0" + h;
        }
        if(m<10){
            m = "0" + m;
        }
        if(s<10){
            s = "0" + s;
        }
        switch (type){
            case "li" :
                showCoutdown.html("<ul><li class='fist'>还剩</li><li>"+d+"天</li><li>"+h+"时</li><li>"+m+"分</li><li>"+s+"秒</li>");
                break;
            case "span":
                showCoutdown.html("<span>剩余</span><b>" + d + "</b> 天<b>" + h + "</b> 时<b>" + m + "</b> 分 <b>" + s + "</b> 秒");
                break;
            case "tuanSpan":
                showCoutdown.html("<span>"+d+"</span>天<span>"+h+"</span>时<span>"+m+"</span>分<span>"+s+"</span>秒</p>");
                break;
            case "values":
                showCoutdown.html(d+"天"+h+"时"+m+"分"+s+"秒");
                break;
            case "wapPromotion":
                showCoutdown.html("<i class='day'>"+d+"</i>天<i class='hour'>"+h+"</i>时<i class='mini'>"+m+"</i>分<i class='sec'>"+s+"</i>秒");
                break;
            case "tuanStart" :
                showCoutdown.html("<span>距开始剩余</span>" + "<p><i>" + d + "</i> 天 <i>" + h + "</i>：<i> " + m + "</i>：<i>" + s + "</i></p>");
                break;
            case "tuanEnd":
                showCoutdown.html("<span>距结束剩余</span>" + "<p><i>" + d + "</i> 天 <i>" + h + "</i>：<i> " + m + "</i>：<i>" + s + "</i></p>");
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftsecond <= 0){
            window.location.reload();
            //showCoutdown.html("<b>时间已结束</b>");
            clearInterval(sh);
        }
    }
})(jQuery);
