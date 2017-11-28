/**
 * 支付时间倒计时器
 * entTime 结束时间
 * type 类型
 * systemTime  系统时间
 * orderId 订单ID
 * @author lhw
 * @version 0.1
 * @date 2016-08-25
 */
(function($){
    $.fn.imallCountdown = function(entTime,type,systemTime, orderId){
        var showCoutdown = $(this);
        var sh;
        var endtimeStr = entTime.replace(/-/g,"/");
        var endTime=new Date(endtimeStr);
        var nowtime = new Date(systemTime);
        var leftsecond=parseInt((endTime.getTime()-nowtime.getTime())/1000);
        sh=setInterval(function(){
            fresh(entTime,sh,showCoutdown,type,leftsecond, orderId);
            leftsecond -= 1;
        },1000);
    };

    function fresh(endDate,sh,showCoutdown,type,leftsecond, orderId){
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
            case "payEndTime":
                showCoutdown.html("<span>支付还剩：</span><b class='timeColor'>" + h + "</b> 时<b class='timeColor'>" + m + "</b> 分 <b class='timeColor'>" + s + "</b> 秒");
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftsecond <= 0){
            //取消订单
            $.ajax({
                url: webPath.webRoot + "/member/cancelOrderAfterPayEndTime.json",
                data: {orderId: orderId},
                dataType: "json",
                success: function (data) {
                    if (data.success == "true") {
                        window.location.reload();
                    }
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
            //showCoutdown.html("<b>时间已结束</b>");
            clearInterval(sh);
        }
    }
})(jQuery);
