$(document).ready(function(){


    /*刷新倒计时开始*/
    $("input[name=time]").each(function() {
        fresh($(this));
    });
    var sh;
    sh=setInterval(function(){
        $("input[name=time]").each(function() {
            fresh($(this));
        });
    },1000);
    /*刷新倒计时结束*/

    /*列表时间倒计时 开始*/
    $("input[name=listPageTime]").each(function() {
        listFresh($(this));
    });
    var sh;
    sh=setInterval(function(){
        $("input[name=listPageTime]").each(function() {
            listFresh($(this));
        });
    },1000);
    /*列表时间倒计时 结束*/
});


function listFresh(t){
    var RemainTime = t.val();
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    d=parseInt(leftsecond/3600/24);
    h=parseInt((leftsecond/3600)%24);
    m=parseInt((leftsecond/60)%60);
    s=parseInt(leftsecond%60);

    t.parent().find(".listPageTime").html("<em>距活动结束还有</em><span>"+d+"</span>天<span>"+h+"</span>小时<span>"+m+"</span>分<span>"+s+"</span>秒");
    if(leftsecond<=0){
        t.parent().find(".llistPageTime").html("<b>已结束</b>");
        clearInterval(sh);
        window.location.reload();
    }
}

function fresh(t){
    var RemainTime = t.val();
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    d=parseInt(leftsecond/3600/24);
    h=parseInt((leftsecond/3600)%24);
    m=parseInt((leftsecond/60)%60);
    s=parseInt(leftsecond%60);

    t.parent().find(".lastTime").html("<i>"+Math.floor(h/10)+"</i><i>"+h%10+"</i><em>:</em><i>"+Math.floor(m/10)+"</i><i>"+m%10+"</i><em>:</em><i>"+Math.floor(s/10)+"</i><i>"+s%10+"</i>");

    if(leftsecond<=0){
        t.parent().find(".lastTime").html("<b>已结束</b>");
        clearInterval(sh);
        window.location.reload();
    }
}



