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
    $.fn.imallCountdownNew = function(entTime,type,systemTime){
        var showCoutdown = $(this);
        var sh;
        var endtimeStr = entTime.replace(/-/g,"/");
        var endTime=new Date(endtimeStr);
        var nowtime = new Date(systemTime);
        switch(type){
            case "millis"://要展示毫秒
            case "productMillis":
                var leftmsecond=parseInt(endTime.getTime()-nowtime.getTime());
                sh=setInterval(function(){
                    fresh(entTime,sh,showCoutdown,type,leftmsecond);
                    leftmsecond -= 100;
                },100);
                break;
            default :
                var leftmsecond=parseInt((endTime.getTime()-nowtime.getTime()));
                setInterval(function(){
                    alert(222);
                    /*fresh(entTime,sh,showCoutdown,type,leftmsecond);
                    leftmsecond -= 1000;*/
                },1000);
                break;
        }

    };
    function fresh(endDate,sh,showCoutdown,type,leftsecond){
           alert(1);
//        var nowtime = new Date();
//        var leftsecond=parseInt((endTime.getTime()-nowtime.getTime())/1000);
        var d = parseInt(leftsecond/1000/3600/24);
        var h = parseInt((leftsecond/1000/3600)%24);
        var m = parseInt((leftsecond/1000/60)%60);
        var s = parseInt(leftsecond/1000%60);
        var ms = leftsecond%1000;
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
            case "span2":
                showCoutdown.html("剩余时间：<span>"+d+"</span>天<span>"+h+"</span>小时<span>"+m+"</span>分<span>"+s+"</span>秒");
                break;
            case "span3":
                showCoutdown.html(" 剩余时间&nbsp;&nbsp;&nbsp;&nbsp;<em>"+d+"</em>天<em>"+h+"</em>小时<em>"+m+"</em>分<em>"+s+"</em>秒");
                break;
            case "span4":
                showCoutdown.html(" <span>剩余时间</span><em>"+d+"</em>天<em>"+h+"</em>小时<em>"+m+"</em>分<em>"+s+"</em>秒");
                break;
            case "em":
                showCoutdown.html("<em>"+d+"</em><span>天</span><em>"+h+"</em><span>小时</span><em>"+m+"</em><span>分</span><em>"+s+"</em><span>秒</span>");
                break;
            case "no":
                showCoutdown.html(d+"天"+h+"小时"+m+"分"+s+"秒");
                break;
            case "indexList":
                showCoutdown.html(d+"天"+h+"小时"+m+"分"+s+"秒");
                break;
            case "groupList":
                showCoutdown.html("<em>"+d+"天"+h+"时"+m+"分"+s+"秒</em>");
                break;
            case "groupDetail":
                showCoutdown.html(" <em>"+d+"</em>天<em>"+h+"</em>时<em>"+m+"</em>分<em>"+s+"</em>秒 ");
                break;
            case "groupDetail2":
                showCoutdown.html("<em>"+d+"天"+h+"时"+m+"分"+s+"秒</em>");
                break;
            case "order":
                showCoutdown.html("<p>请您在提交订单后<span><em>" + d + "</em>天<i>" + h + "</i>时<i>" + m + "</i>分 <i>" + s+"</i>秒</span>内完成支付，否则订单会自动取消！</p>");
                break;
            case "panicBuy":
                if(d >= 5){
                    showCoutdown.html("<em>距优惠结束&nbsp;&nbsp;大于&nbsp;5&nbsp;天</em>");
                }else{
                    showCoutdown.html("距优惠结束&nbsp;&nbsp; <span>0</span><span>"+d+"</span><i>&nbsp;天</i><span>"+h1+"</span><span>"+h2+"</span><i>&nbsp;小时&nbsp;</i><span>"+m1+"</span><span>"+m2+"</span><i>&nbsp;分&nbsp;</i><span>"+s1+"</span><span>"+s2+"</span>&nbsp;秒");
                }
                //showCoutdown.html("优惠结束&nbsp;" + d + "&nbsp;天&nbsp;" + h + "&nbsp;小时&nbsp;" + m + "&nbsp;分&nbsp;" + s + "&nbsp;秒");
                break;
            case "millis"://展示毫秒
                if(d>=100){
                    showCoutdown.html("<span>"+parseInt(d/100%10)+"</span><span>"+parseInt(d/10%10)+"</span><span>"+d%10+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span><i>:</i><span>"+ms1+"</span>");
                }else{
                    showCoutdown.html("<span>"+parseInt(d/10%10)+"</span><span>"+d%10+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span><i>:</i><span>"+ms1+"</span>");
                }
                break;
            case "productMillis":
                showCoutdown.html("<span>"+d+"</span>天<span>"+h1+h2+"</span>时<span>"+m1+m2+"</span>分<span>"+s1+s2+"</span>秒<span>"+ms1+"</span>");
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftsecond <= 0){
            switch (type) {
                case "previewdefault":
                    var nm = showCoutdown.attr("itemNm");
                    showCoutdown.html("<b>时间已结束</b>");
                    $("."+nm).remove();
                    break;
                case "order":
                    showCoutdown.html("支付超时，该订单已自动取消！");
                    break;
                case "indexorder":
                    showCoutdown.html("<p>支付超时</p>");
                    showCoutdown.parent().find(".payNow").hide();
                    showCoutdown.parent().find(".cancelBtn").hide();
                    break;
                case "groupList":
                    showCoutdown.html("支付超时，该订单已自动取消！");
                    var nextBtn = showCoutdown.next();
                    nextBtn.remove();
                    break;
                case "groupDetail":
                    showCoutdown.parent().html("支付超时，该订单将自动取消！");
                    break;
                case "groupDetail2":
                    showCoutdown.html("支付超时，该订单已自动取消！");
                    break;
                case "indexList":
                    var isDepositPay = showCoutdown.attr("isDepositPay");
                    var orderId = showCoutdown.attr("orderId");
                    if(isDepositPay !="Y"){
                        $(".cancalBtn"+orderId).hide();
                        showCoutdown.html("支付超时，该订单已自动取消！");
                        showCoutdown.show();
                    }
                    break;
                case "panicBuy":
                    showCoutdown.html("该直降活动已结束");
                    break;
                case "":
                    showCoutdown.html("尾款支付超时！");
                    showCoutdown.show();
                    break;
                default :
                    showCoutdown.html("<b>时间已结束</b>");
                    break;
            }
            clearInterval(sh);
        }
    }
})(jQuery);