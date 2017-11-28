$(function () {

    //分享链接
    $("#shareUrl").text(location.href.split('#')[0]);

    $("#searchInput").click(function () {
        setTimeout(function () {
            window.location.href = dataValue.webRoot + "/wap/newSearch.ac?shopId="+dataValue.shopId +"&time=" + new Date().getTime();
        }, 1);
    });

     $(".m-top .store-more .more").live("click", function () {
        $(this).siblings("div").toggle();
        if (!$(".csf-box").is(":hidden")) {
            $(".csf-box").hide();
        }
    });

    $(".classify").live("click", function () {
        if (!$(".more-box").is(":hidden")) {
            $(".more-box").hide();
        }
        $(this).siblings("div").toggle();
    });

    /*店铺收藏*/
    $("#collectStore").click(function () {
        $(".more-box").hide();
        var shopId = dataValue.shopId;
        if (undefined == shopId || "" == shopId || null == shopId) {
            return;
        }
        var collectByUserNumSpan = $("#collectByUserNumSpan");
        var obj = $(this);
        if (obj.attr("isCollect") == 'false') {
            obj.removeClass("collect").addClass("collect-active");
            $.get(dataValue.webRoot + "/member/collectionShop.json?shopId=" + shopId, function (data) {
                if (data.success == "false") {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = dataValue.webRoot + "/wap/login.ac";
                    }
                } else if (data.success == true) {
                    obj.attr("isCollect", "true");
                    var num = parseInt(collectByUserNumSpan.attr("num")) + 1;
                    collectByUserNumSpan.attr("num", num).html(num + "人");
                    showTips('店铺收藏成功');
                }
            });
        } else {
            obj.addClass("collect").removeClass("collect-active");
            $.ajax({
                type: "POST", url: dataValue.webRoot + "/member/delUserShopCollect.json",
                data: {items: shopId},
                dataType: "json",
                success: function (data) {
                    if (data.success == "true") {
                        obj.attr("isCollect", "false");
                        showTips('取消店铺收藏成功');
                        var num = parseInt(collectByUserNumSpan.attr("num")) - 1;
                        collectByUserNumSpan.attr("num", parseInt(num) < 0 ? 0 : num).html(num + "人");
                    } else {
                        showTips('系统错误,请刷新重新操作');
                    }
                }
            });
        }
    });
});

/**
 * 滚动轮播图加倒计时
 * @param obj 当前滚动所在对象
 * @param intDiff 倒计时总秒数
 */
function timer(obj, intDiff) {
    window.setInterval(function () {
        var day = 0,
            hour = 0,
            minute = 0,
            second = 0;//时间默认值
        if (intDiff > 0) {
            day = Math.floor(intDiff / (60 * 60 * 24));
            hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
            minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
            second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
        } else {
            return;
        }
        var h1 = hour >= 10 ? parseInt(hour / 10) : 0;
        var h2 = hour >= 10 ? hour % 10 : hour;
        var m1 = minute >= 10 ? parseInt(minute / 10) : 0;
        var m2 = minute >= 10 ? minute % 10 : minute;
        var s1 = second >= 10 ? parseInt(second / 10) : 0;
        var s2 = second >= 10 ? second % 10 : second;
        $(obj).html("仅剩<span>" + day + "</span>天<i><span>" + h1 + "</span><span>" + h2 + "</span>:</i><span>" + m1 + "</span><span>" + m2 + "</span><i>:</i><span>" + s1 + "</span><span>" + s2 + "</span>");
        intDiff--;
    }, 1000);
}

/*店铺分享*/
function showOrHideShare() {
    $(".more-box").hide();
    var obj = dataValue.isWeixin == 'Y' ? $("#share") : $("#sysMsg");
    $(obj).toggle();
}

/*自定义弹出框*/
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}

function scrollToTop(){
    $('body,html').animate({scrollTop:0},1000);
}

$(window).scroll(showTopSearch);
function showTopSearch(){
    var sTop = $(window).scrollTop();
    var scBox2 = $(".sc-box2");
    var scBox1 = $(".sc-box1");
    if(sTop < scBox1.height()){
        scBox2.slideUp("1000");
    }
    if(sTop >= scBox1.height()){
        scBox2.slideDown("1000");
    }
    showBackTopBtn();
}

function showBackTopBtn(){
    var centerAdv = $("#centerAdv");
    var backTop = $(".back-top");
    if($(window).scrollTop() >= centerAdv.offset().top){
        backTop.css("display","block");
    }
    if($(window).scrollTop() < centerAdv.offset().top){
        backTop.css("display","none");
    }
}