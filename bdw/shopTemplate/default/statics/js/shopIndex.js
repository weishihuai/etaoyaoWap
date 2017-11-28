$(document).ready(function () {

    //左边的店内搜索
    $("#shopLeftMenuSearch").click(function () {
        var reg = new RegExp("\d{1,9}(\.\d{0,2}|)");
        var minPrice = $("#left_minPrice").val();
        var maxPrice = $("#left_maxPrice").val();
        if (reg.test(minPrice)||reg.test(maxPrice)) {
            alert("请输入正确的价格!");
            return;
        }
        if ( parseFloat(minPrice)>parseFloat(maxPrice)) {
            alert("价格区间应从小到大!");
            return;
        }
        $("#searchShopFormLeft").submit();
    });

    /*轮换广告*/
    $('#roteAdv').cycle({
        fx: 'scrollLeft',
        speed: 'fast',
        timeout: 5000,
        pager: '#nav',
        before: function () {
            if (window.console) console.log(this.src);
        },
        pagerAnchorBuilder: function (index, slide) {
            var count = index + 1;
            if (index == 0) {
                return '<a href="javascript:;" id="c' + count + '" class="cur"></a>'
            } else {
                return '<a href="javascript:;" id="c' + count + '"></a>'
            }
        },
        after: function (currSlideElement, nextSlideElement, options, forwardFlag) {
            var a = $("#nav").find("a").attr("class", "");
            $("#c" + nextSlideElement.id).attr("class", "cur");
            //$(".bannerBox").css("background", $("#" + nextSlideElement.id).attr("color-data"));
        }
    });
    /*左边菜单栏 效果展示 start*/
    /*$(".stretch").click(function () {

        var ul = $(this).parent().parent().parent().find("ul");
        ul.toggle();
        if (ul.css("display") == "none") {
            $(this).addClass("cur");
            $(this).find("img").attr("src", paramData.webRoot + "/template/bdw/shopTemplate/default/statics/images/59.png");
        } else {
            $(this).find("img").attr("src", paramData.webRoot + "/template/bdw/shopTemplate/default/statics/images/58.png");
            $(this).removeClass("cur");
        }
    });*/

});

function Collect(webName, webUrl) {
    if (document.all) {
        window.external.addFavorite(webUrl, webName);
    }
    else if (window.sidebar) {
        try {
            window.sidebar.addPanel(webName, webUrl, "");
        } catch (e) {

        }
    }
    else {
        alert("收藏失败！请使用Ctrl+D进行收藏");
    }
}

function show(){
    $("#bigQrCode").show();
}

function hide(){
    $("#bigQrCode").hide();
}