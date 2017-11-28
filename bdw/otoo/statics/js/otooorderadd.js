$(document).ready(function () {
    initData();

    //购买数量减少事件
    $(".prd_subNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        productNum.val(num);
        $(".addOrder").attr("num", num);
        orderData.otooQuantity = num;
        $(".otooQuantityInput").val(num);
        calculateOrderPrice();
    });

    //购买数量输入框
    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);
            return;
        }
        $(".addOrder").attr("num", value);
        orderData.otooQuantity = value;
        $(".otooQuantityInput").val(value);
        calculateOrderPrice();
    });

    //购买数量增加事件
    $(".prd_addNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) + 1;
        productNum.val(num);
        $(".addOrder").attr("num", num);
        orderData.otooQuantity = num;
        $(".otooQuantityInput").val(num);
        calculateOrderPrice();
    });

    //提交订单
    $(".submitOrder").click(function(){
        if(orderData.otooQuantity<1){
            alert("没有可购买的商品!");
            return false;
        }
        else if(webPath.userMobile == '' || webPath.userMobile == undefined){
            /*var noMobile = layer.alert('您尚未绑定手机号，请先绑定手机号!',3,function(){
                layer.close(noMobile);
                goToUrl(webPath.webRoot + "/module/member/myInformation.ac?pitchOnRow=1");
            });*/
            alert("您尚未绑定手机号，请先绑定手机号!");
            return false;
        }
        setTimeout($("#orderForm").submit(),10);
    });
});

var initData = function(){
    $(".addOrder").attr("num", orderData.otooQuantity);
    $(".prd_num").val(orderData.otooQuantity);
    calculateOrderPrice();
};;


var calculateOrderPrice = function () {
    $("#zoomloader").show();
    var otooQuantity = orderData.otooQuantity;
    var otooProductId = orderData.otooProductId;
    var reg = new RegExp("^[1-9]\\d*$");

    if ($.trim(otooQuantity) == "" || otooQuantity == null || !reg.test(otooQuantity)) {
        alert("请输入正确的数量!");
    }
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "POST",
        url: Top_Path.webRoot + "/otoo/orderFlow/calculateOrderPrice.json",
        data: {
            otooQuantity: otooQuantity,
            otooProductId: otooProductId
        },
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                var otooProductTotalAmount = data.otooProductTotalAmount;
                $(".otooProductTotalAmount").html("<i>&yen;</i>" + otooProductTotalAmount);
                $(".td04").html("&yen;" + otooProductTotalAmount);
                setTimeout(function(){
                    $("#zoomloader").hide();
                },500);
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};;

