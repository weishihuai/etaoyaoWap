/**
 * Created by IntelliJ IDEA.
 * User: feng_lh
 * Date: 12-6-4
 * Time: 下午6:45
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $(".blue").parent().find("ul").addClass("od");
    if(parseInt(pageData.page)-1==0){
        $("#pageUp").css("background","url("+pageData.webRoot +"/template/dressv2/statics/images/savePrice_bg.png) no-repeat 0 -82px");
    }
    if(parseInt(pageData.page)+1>parseInt(pageData.lastPageNumber)){
        $("#pageDown").css("background","url("+pageData.webRoot +"/template/dressv2/statics/images/002.gif) no-repeat");
        $("#pageDown").css("color","#C2C2C2");
    }

    $("#pageUp").click(function(){
        if(parseInt(pageData.page)-1==0){
            alert("当前已是第一页");
            return;
        }
        pageData.page=parseInt(pageData.page)-1;
        setTimeout(function(){
            window.location.href= pageData.webRoot + "/panicList.ac?page="+ pageData.page;
        },1);
    });

    $("#pageDown").click(function(){
        if(parseInt(pageData.page)+1>parseInt(pageData.lastPageNumber)){
            alert("当前已是最后一页");
            return;
        }
        pageData.page=parseInt(pageData.page)+1;
        setTimeout(function(){
            window.location.href= pageData.webRoot + "/panicList.ac?page="+ pageData.page;
        },1);
    });
    /*刷新团购时间开始*/
    $("input[name=time]").each(function() {
        $(this).next("[name=endTime]").imallCountdown($(this).val(),'span',pageData.nowTime);
    });
    /*刷新团购时间结束*/
});
/*
function fresh(t) {
    var RemainTime = t.val();
    var SystemTime = pageData.nowTime;
    var endtimeStr = RemainTime.replace(/-/g, "/");
    var systemTimeStr = SystemTime.replace(/-/g, "/");
    var endtime = new Date(endtimeStr);
    var nowtime = new Date(systemTimeStr);
    var leftsecond = parseInt((endtime.getTime() - nowtime.getTime()) / 1000);
    d = parseInt(leftsecond / 3600 / 24);
    h = parseInt((leftsecond / 3600) % 24);
    m = parseInt((leftsecond / 60) % 60);
    s = parseInt(leftsecond % 60);

    t.parent().find("[name=endTime]").html("<span>剩余</span><b>" + d + "</b> 天<b>" + h + "</b> 时<b>" + m + "</b> 分 <b>" + s + "</b> 秒");
    if (leftsecond <= 0) {
        t.parents().find("[name=endTime]").html("<b>抢购已结束</b>");
        clearInterval(sh);
        window.location.reload();
    }
};
var sh;
sh = setInterval(function() {
    $("input[name=time]").each(function() {
        fresh($(this));
    });
}, 1000);*/
