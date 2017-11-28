$(function () {

    //搜索
    $("#search").click(function () {
        var orderNum = $("#myOrderNum").val();
        if (orderNum == "请输入订单编号") {
            orderNum = "";
        }
        var nameValue = $("#myOrderName").val();
        if (nameValue == "请输入姓名") {
            nameValue = "";
        }
        var mobile = $("#myOrderMobile").val();
        if (mobile == "请输入手机号码") {
            mobile = "";
        }
        orderNum = $.trim(orderNum);
        nameValue = $.trim(nameValue);
        mobile = $.trim(mobile);
        location.href = webPath.webRoot + "/template/bdw/pickedUp/pickedUpList.jsp?orderNum=" + orderNum + "&receiverName=" + nameValue + "&Mobile=" + mobile;
    });

})
