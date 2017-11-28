
$(function () {

    $(".time").each(function() {
        fresh($(this));
    });

    countDown();
});

function  countDown() {
    setInterval(function(){
        $(".time").each(function() {
            fresh($(this));
        });
    },1000);
}


function fresh(t){
    var RemainTime = t.attr("listPageTime");
    var marketingActivityId = t.attr("marketingActivityId");
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        clearInterval(countDown());
        window.location.reload();
    }else{
        d=parseInt(leftsecond/3600/24);
        h=parseInt((leftsecond/3600)%24);
        m=parseInt((leftsecond/60)%60);
        s=parseInt(leftsecond%60);
        if(d >= 1){
            $("#marketingActivityId"+marketingActivityId).html("仅剩"+d+"天");
        }else if(d < 1 && h >= 1){
            $("#marketingActivityId"+marketingActivityId).html("仅剩"+h+"小时");
        }else if(d < 1 && h < 1 && m >= 1){
            $("#marketingActivityId"+marketingActivityId).html("仅剩"+m+"分钟");
        }else if(d < 1 && h < 1 && m < 1 && s >= 1 ){
            $("#marketingActivityId"+marketingActivityId).html("仅剩"+h+"秒");
        }

    }
    function toTwo(n){
        return n < 10 && n > -1 ? '0' + n : '' + n;
    }
}