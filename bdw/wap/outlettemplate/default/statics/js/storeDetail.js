$(function () {

    /*收藏店铺*/
    $("#collectStore").click(function () {
        var shopId = dataValue.shopId;
        if (undefined == shopId || "" == shopId || null == shopId) {
            return;
        }
        var collectByUserNumSpan = $("#collectByUserNumSpan");
        var obj = $(this);
        if (obj.attr("isCollect") == 'false') {
            $.get(dataValue.webRoot + "/member/collectionShop.json?shopId=" + shopId, function (data) {
                if (data.success == "false") {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = dataValue.webRoot + "/wap/login.ac";
                    }
                } else if (data.success == true) {
                    obj.attr("isCollect", "true");
                    $("#collectStore").removeClass("selected");
                    var num = parseInt(collectByUserNumSpan.attr("num")) + 1;
                    collectByUserNumSpan.attr("num", num).html(num + "人");
                    showTips('店铺收藏成功');
                }
            });
        } else {
            $.ajax({
                type: "POST", url: dataValue.webRoot + "/member/delUserShopCollect.json",
                data: {items: shopId},
                dataType: "json",
                success: function (data) {
                    if (data.success == "true") {
                        obj.attr("isCollect", "false");
                        $("#collectStore").addClass("selected");
                        var num = parseInt(collectByUserNumSpan.attr("num")) - 1;
                        collectByUserNumSpan.attr("num", parseInt(num) < 0 ? 0 : num).html(num + "人");
                        showTips('取消店铺收藏成功');
                    } else {
                        showTips('系统错误,请刷新重新操作');
                    }
                }
            });
        }
    });
});

/**
 * 提示对话框
 * @param tips 对话框显示的内容
 */
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}


function noCustomService() {
    showTips("在线咨询暂未开放使用");
}