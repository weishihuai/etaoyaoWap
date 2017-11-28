$(function(){
    //购买按钮事件
    $("#buyBtn").click(function () {
        window.location.href = webPath.webRoot + "/otoo/otooorderadd.ac?otooProductId=" + webPath.productId + "&otooQuantity=1";
    });
});