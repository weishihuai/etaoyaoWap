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
//        var nowtime = new Date();
//        var leftsecond=parseInt((endTime.getTime()-nowtime.getTime())/1000);
        var d = parseInt(leftsecond/3600/24);
        var h = parseInt((leftsecond/3600)%24);
        var m = parseInt((leftsecond/60)%60);
        var s = parseInt(leftsecond%60);
        switch (type){
            case "li" :
                showCoutdown.html("<ul><li class='fist'>还剩</li><li>"+d+"天</li><li>"+h+"时</li><li>"+m+"分</li><li>"+s+"秒</li>");
                break;
            case "span":
                showCoutdown.html("<span>剩余</span><b>" + d + "</b> 天<b>" + h + "</b> 时<b>" + m + "</b> 分 <b>" + s + "</b> 秒");
                break;
            case "none":
                showCoutdown.html("剩余时间："+d+" 天"+h+" 时"+m+" 分 "+s+" 秒");
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftsecond <= 0){
            showCoutdown.html("<b>时间已结束</b>");
            clearInterval(sh);
        }
    }
})(jQuery);