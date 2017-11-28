$(function () {
    $("#searchInput").bind("keyup", function (e) {
        if(e.keyCode == 13){
            window.location.href = webPath.webRoot+"/wap/outlettemplate/default/nearByProductList.ac?keyword="+$(this).val();
        }
    });

    var POSITION_COOKIE = "POSITION_COOKIE";
    var cookiePosition = eval("("+ unescape($.cookie(POSITION_COOKIE)) +")");
    if (cookiePosition){
        $(".list-head-m .addr").html("送至：" + cookiePosition.addr);
        $("#shopList").load(webPath.webRoot + "/wap/outlettemplate/default/loadShopList.ac?lat=" + cookiePosition.lat + "&lng=" + cookiePosition.lng);
    } else {
        var geolocation = new qq.maps.Geolocation("IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL", "imall");
        geolocation.getLocation(function (position) {
            $(".list-head-m .addr").html("送至：" + position.addr);
            $.cookie(POSITION_COOKIE, escape(JSON.stringify({lat: position.lat, lng: position.lng, addr: position.addr})));
            $("#shopList").load(webPath.webRoot + "/wap/outlettemplate/default/loadShopList.ac?lat=" + position.lat + "&lng=" + position.lng);
        }, function () {
            alert("获取当前位置失败，请检查是否开启定位");
        }, {timeout: 5000, failTipFlag: true});
    }
    
    $("ul.sp-sort li").click(function () {
        $("ul.sp-sort li.cur").removeClass("cur");
        $(this).addClass("cur");
        var position = eval("("+ unescape($.cookie(POSITION_COOKIE) +")"));
        var orderBy = $(this).attr("data-order-by");
        $("#shopList").load(webPath.webRoot + "/wap/outlettemplate/default/loadShopList.ac?lat=" + position.lat + "&lng=" + position.lng + "&orderBy=" + orderBy);
    });

    $(".discount a").live("click", function () {
        if($(this).hasClass("open")){
            $(this).removeClass("open");
            $(this).addClass("close");
        }else {
            $(this).removeClass("close");
            $(this).addClass("open");
        }
        $(".discount dl dd:gt(2)").toggle();
    });
});