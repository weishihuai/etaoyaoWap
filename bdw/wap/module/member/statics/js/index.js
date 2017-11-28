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
    showTips("联系我们暂未开放使用");
}