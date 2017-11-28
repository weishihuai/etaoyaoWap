
$(document).ready(function(){
    var swipper_slider = $(".health-information-main .swiper-wrapper .swiper-slide");
    var dd_inner = $(".health-information-main .dd .dd-inner");

    swipper_slider.find("a").click(function () {
        $(this).addClass("cur");
        $(this).parent().siblings().find("a").removeClass("cur");

        var rel = $(this).attr("rel");
        dd_inner.find("li").each(function () {
            if ($(this).attr("rel") == rel) {
                $(this).addClass("cur").siblings().removeClass("cur");
            }
        });
        reLoadNewsList(rel);
    });

    dd_inner.find("li").click(function () {
        var toggleMenu = $("#iconXiaLa");
        $(this).addClass("cur").siblings().removeClass("cur");
        toggleMenu.parent().find(".dd").css("display", "none");
        $(".m-top").css("display","block");
        toggleMenu.removeClass("icon-xiala-s");
        reLoadNewsList($(this).attr("rel"));
    });

    $("#newsList").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".item",
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50,
        maxPage: webPath.lastPageNumber
    });

    moveToActivate(webPath.categoryId)
});

//移动到选中的菜单
function moveToActivate(categoryId){
    var swipper_slider = $(".health-information-main .swiper-wrapper .swiper-slide");
    var index = 0;

    swipper_slider.find("a").each(function (ind) {
        if ($(this).attr("rel") == categoryId){
            index = ind
        }
    });
    swipper_slider.find("a").each(function () {
        var swipperWrapper = $(".swiper-wrapper");
        if ($(this).attr("rel") == categoryId) {
            var margin_r = parseInt(swipperWrapper.find("li").eq(0).css("marginRight"));
            var arr_w = 0;
            swipperWrapper.find("li").eq(index);
            for (var i = 0; i < index; i++) {
                arr_w += (swipperWrapper.find("li").eq(i).width() + margin_r);
            }
            if (arr_w > $(window).width() - margin_r){
                arr_w = arr_w - $(window).width() + margin_r * 3;
                swipperWrapper.css("transform", "translate3d(-"+arr_w + "px, 0px, 0px)");
            } else {
                swipperWrapper.css("transform", "translate3d(0px, 0px, 0px)");
            }
            $(this).addClass("cur");
            $(this).parent().siblings().find("a").removeClass("cur");
        }
    });
}
function xiala() {
    var s = $("#iconXiaLa").hasClass("icon-xiala-s");
    if (s == false) {
        $(".m-top").css("display","none");
        $("#iconXiaLa").addClass("icon-xiala-s");
        $("#iconXiaLa").parent().find(".dd").css("display", "block");
        $("#iconXiaLa").parent().find(".dd").find(".dd-inner").css("padding", "1.46875rem 0 0.15625rem 0.46875rem");
    } else {
        $(".m-top").css("display","block");
        $("#iconXiaLa").removeClass("icon-xiala-s");
        $("#iconXiaLa").parent().find(".dd").css("display", "none");
        $("#iconXiaLa").parent().find(".dd").find(".dd-inner").css("padding", "0.46875rem 0 0.15625rem 0.46875rem");
    }
}

/**
 * 重新加载列表
 * @param categoryId 分类ID
 */
function reLoadNewsList(categoryId) {
    window.location.href = webPath.webRoot + "/wap/newsList.ac?mainCategoryId="+webPath.mainCategoryId+"&title="+webPath.title+"&categoryId="+categoryId;
}