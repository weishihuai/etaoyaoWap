

$(document).ready(function () {
    //下单数量
    var num =  $("#prd_num").val()
    var integralProductNum = $(this).attr("integralProductNum");

    //选中数量验证
    $(".add").click(function () {
        var value = $(".prd_num").val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        $(".prd_num").val(num);
        $("#integralSubmit").attr("num", num);



    });
    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);

        }
        $("#integralSubmit").attr("num", value);
    });
    $(".subtract").click(function () {
        var value = $(".prd_num").val();
        var num = parseInt(value) + 1;
        $(".prd_num").val(num);
        $("#integralSubmit").attr("num", num);
    });



    //点击收货地址跳转
    $(".site-box").click(function () {
        window.location.href = webPath.webRoot + "/wap/shoppingcart/addrSelect.ac?isIntegral=Y&cartType=normal&integralProductId="+ webPath.integralProductId+ "&handler=" + webPath.handler + "&isCod=" + webPath.isCod + "&time=" + new Date().getTime();

    });
    //
    //提交订单
    $("#integralSubmit").click(function () {
        var receiveAddrId = $("#receiveAddrId").attr("receiveAddrId");
        if (receiveAddrId == ""||receiveAddrId == undefined) {
            alert("请选择收货地址");
            return false;
        }
        //积分尚品ID
        var integralProductId = $(this).attr("integralProductId");
        //下单数量
        var num =  $("#prd_num").val();

        //积分
        var productIntegral = $(this).attr("productIntegral");
        var userIntegral = $(this).attr("userIntegral");
        if (userIntegral < productIntegral * num) {
            alert("积分不足!");
            return
        }
        var integralProductNum = $(this).attr("integralProductNum");
        //验证传入数量是否为整数字
        if (isNaN(num) || integralProductNum < num) {
            alert("库存不足!");
            return
        }
        //保存用户积分商品订单
        $.ajax({
            type: "post",
            url: webPath.webRoot + "/integralOrder/addIntegralOrder.json",
            data: {
                integralProductId: integralProductId,
                receiveAddrId: receiveAddrId,
                num: num,
                paymentConvertTypeCode: "0"
            },
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                        alert("订单提交成功");
                        window.location.href = webPath.webRoot + "/wap/module/member/myIntegralOrders.ac";
                } else if (data - success == "false") {
                    alert("订单提交失败");
                }
            }
            ,
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });


});
