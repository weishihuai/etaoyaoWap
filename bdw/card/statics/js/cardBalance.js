$(function () {

    $(".payWay").click(function(){
        var payWayId = $(this).attr("payWayId");
        $(".payWayUl").children().removeClass("cur");
        $(this).addClass("cur");
        $(".goToPay").attr("payWayId",payWayId);
        $("#payWayId").val(payWayId);
    });

    $(".goToPay").click(function(){
        if($("#payWayId").val() == null || $("#payWayId").val() == undefined || $("#payWayId").val().trim() == ""){
            alert("请选择支付方式！");
            return;
        }
        $("#goBankOfCard").submit();
    });

});
