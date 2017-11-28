$(function () {
    $(".login_btn").click(function () {
        var OrderNumVerify = $("#OrderNumVerify").val();
        var myDelivery = $("#myDelivery").val();

        if ($.trim(OrderNumVerify) == '') {
            $("#error").css("display", "block");
            $("#error").parent().children("input").css("border", "1px solid #ff0000");
            return;
        }
        if ($.trim(myDelivery) == '') {
            $("#error").css("display", "block");
            $("#error").parent().children("input").css("border", "1px solid #ff0000");
            return;
        }
        $.ajax({
            type: "GET",
            url: webPath.webRoot + "/pickedup/verify.json",
            data: {orderNum: OrderNumVerify, deliveryCode: myDelivery},
            dataType: "json",
            success: function (data) {
                if (data.result == true) {
                    location.href = webPath.webRoot + "/pickedUp/verifySuccess.ac?orderNum=" + OrderNumVerify;
                } else {
                    $("#error").css("display", "block");
                    $("#error").html(data.msg);
                    $("#error").parent().children("input").css("border", "1px solid #ff0000");
                }
            }
        });
    });
})
