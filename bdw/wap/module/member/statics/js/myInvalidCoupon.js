
jQuery(function($) {
    $(document).ready(function () {

        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#couponList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".item",
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function (newElements) {
            if (readedpage > dataValue.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#couponList").infinitescroll({state: {isDone: true}, extraScrollPx: 50});
            }
            readedpage++
        });
    });
});