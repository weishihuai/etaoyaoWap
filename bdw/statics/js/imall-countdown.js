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
        var endtimeStr = entTime.replace(/-/g,"/");
        var endDate=new Date(endtimeStr);
        var nowtime = new Date(systemTime);
        var leftmsecond=parseInt(endDate.getTime()-nowtime.getTime());
        var sh = setInterval(function(){
            fresh(endDate,sh,showCoutdown,type,leftmsecond);
            leftmsecond -= 1000;
        },1000);
    };
    function fresh(endDate,sh,showCoutdown,type,leftmsecond){
        var d = parseInt(leftmsecond/1000/3600/24);
        var h = parseInt((leftmsecond/1000/3600)%24);
        var m = parseInt((leftmsecond/1000/60)%60);
        var s = parseInt(leftmsecond/1000%60);
        var ms = leftmsecond%1000;
        var h1 = h>=10 ? parseInt(h/10) : 0;
        var h2 = h>=10 ? h%10 : h;
        var m1 = m>=10 ? parseInt(m/10) : 0;
        var m2 = m>=10 ? m%10 : m;
        var s1 = s>=10 ? parseInt(s/10) : 0;
        var s2 = s>=10 ? s%10 : s;
        var ms1 = ms>=100 ? parseInt(ms/100) : 0;
        var ms2 = ms>=10 ? parseInt(ms/10%10) : 0;
        switch (type){
            case "default"://b2b2b新模板首页倒计时
                if(d >= 5){
                    showCoutdown.html("<em> 大于5天</em>");
                }else{
                    showCoutdown.html("<span>0</span><span>"+d+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span>");
                }
                break;
            case "previewdefault"://团购预告
                if(d >= 5){
                    showCoutdown.html("<em> 大于5天</em>");
                }else{
                    showCoutdown.html("<span>0</span><span>"+d+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span>");
                }
                break;
            case "indexorder":
                if(d > 0 ){
                    showCoutdown.html("<p>还剩"+d+"天"+h+"时</p>");
                }else{
                    if(h> 0){
                        showCoutdown.html("<p>还剩"+h+"时"+m+"分</p>");
                    }else{
                        showCoutdown.html("<p>还剩"+m+"分"+ s +"秒</p>");
                    }
                }
                break;
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
            case "tryOut":
                showCoutdown.html("剩余时间<span>" + d + "</span>天<span>" + h + "</span>时<span> " + m + " </span>分<span> " + s + "</span>秒");
                break;
            case "tryList":
                showCoutdown.html("<i>剩余时间</i><span>" + d + "</span>天<span>" + h + "</span>时<span> " + m + " </span>分<span> " + s + "</span>秒");
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftmsecond <= 0){
            showCoutdown.html("<b>时间已结束</b>");
            clearInterval(sh);
        }
    }
})(jQuery);
