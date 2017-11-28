$(document).ready(function(){

    //下拉加载更多数据
    var currentPage = 1; //当前滚动到的页数
    $("#integralList").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".item" ,  //选择的是你要加载的那一个块（每次载入的数据放的地方）
        animate: true,
        loading: {
            finishedMsg: '无更多数据',
            finished: function() {
                $("#infscr-loading").remove();
            }
        },
        extraScrollPx: 50
    }, function(newElements) {
        if(currentPage > dataValue.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#integralList").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
        currentPage++;
    });

});