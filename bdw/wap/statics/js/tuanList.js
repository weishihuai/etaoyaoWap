var readedpage = 1;//当前滚动到的页数

$(document).ready(function(){
    moveToActivate(webPath.categoryId);

    $("#commentDiv").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".item",
        animate: true,
        loading: {
            //finished: function(){
            //
            //},
            finishedMsg: '无更多数据',
        },
        extraScrollPx: 50
    }, function (newElements) {
        readedpage++;
        if (readedpage > webPath.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#commentDiv").infinitescroll({state: {isDone: true}, extraScrollPx: 20});
        }
    });
});

function countdownTime(groupBuyId, timeString) {
    $("#countdownTime_" + groupBuyId).imallCountdown('timeString','default',webPath.systemTime);
}

//移动到选中的菜单
function moveToActivate(categoryId){
    var swipper_slider = $(".group-promotions-main .swiper-wrapper .swiper-slide");
    var index = 0;

    swipper_slider.find("a").each(function (ind) {
        if ($(this).attr("rel") == categoryId){
            index = ind
        }
    });
    swipper_slider.find("a").each(function () {
        var swipperWrapper = $(".swiper-wrapper");
        if ($(this).attr("rel") == categoryId) {
            var margin_r = parseInt(swipperWrapper.find("li").eq(0).css("marginLeft"));
            var arr_w = 0;
            swipperWrapper.find("li").eq(index);
            for (var i = 0; i < index; i++) {
                arr_w += (swipperWrapper.find("li").eq(i).width() + margin_r);
            }
            if (arr_w > $(window).width() - margin_r){
                arr_w = arr_w - $(window).width() + margin_r * 5.5;
                swipperWrapper.css("transform", "translate3d(-"+arr_w + "px, 0px, 0px)");
            } else {
                swipperWrapper.css("transform", "translate3d(0px, 0px, 0px)");
            }
        }
    });
}

