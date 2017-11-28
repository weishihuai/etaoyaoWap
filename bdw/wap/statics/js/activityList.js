var countDown;
$(function () {

    // 加载分页
    var readedpage = 1;//当前滚动到的页数
    $("#activity-panel").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".activity-list" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据',
            finished: function() {
                $("#infscr-loading").remove();
            }
        },
        extraScrollPx: 50
    }, function(newElements) {
        if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#activity-panel").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
        readedpage++;
    });

    listFresh();

    countDown = setInterval(function(){
        listFresh();
    },1000);
});

function listFresh(){
    var RemainTime = $("#countDown").attr("listPageTime");
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        clearInterval(countDown);
        $("#countDown").html("<span>活动已结束</span>");
    }else{
        d=parseInt(leftsecond/3600/24);
        h=parseInt((leftsecond/3600)%24);
        m=parseInt((leftsecond/60)%60);
        s=parseInt(leftsecond%60);
        $("#countDown").html("<span>"+d+"</span>天<span>"+h+"</span>时<span>"+m+"</span>分<span>"+s+"</span>秒后结束");
    }

    function toTwo(n){
        return n < 10 && n > -1 ? '0' + n : '' + n;
    }

}
