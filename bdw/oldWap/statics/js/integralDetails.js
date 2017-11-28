$(document).ready(function () {
    var goToUrl = function (url) {
        setTimeout(function () {
            window.location.href = url
        }, 1)
    };

    //积分类别选择
    $(".cho-cont .integralModeBtn").click(function () {
        if (!$(this).hasClass("cur")) {
            $(".cho-cont .integralCashModeBtn").removeClass("cur");
            $(this).addClass("cur");
            $("#integralProductShow").show();
            $("#exchange").hide();
        }
    });
    $(".cho-cont .integralCashModeBtn").click(function () {
        if (!$(this).hasClass("cur")) {
            $(".cho-cont .integralModeBtn").removeClass("cur");
            $(this).addClass("cur");
            $("#integralProductShow").hide();
            $("#exchange").show();
        }
    });


    $(".sub").click(function () {
        var value = $(".number").val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        $(".number").val(num);
        $(".addcart").attr("number", num);
    });

    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);
            return;
        }
        $(".addcart").attr("num", value);
    });

    $(".add").click(function () {
        var value = $(".number").val();
        var num = parseInt(value) + 1;
        var integralProductNum = $(".addcart").attr("integralProductNum");
        if (integralProductNum < num) {
            alert("对不起,库存数不足");
            return;
        }
        $(".number").val(num);
        $(".addcart").attr("num", num);
    });

    //加入购物车
    $(".addcart").click(function () {
        var isLogin = $(this).attr("isLogin");
        if (isLogin == "true") {
            window.location.href = webPath.webRoot + "/wap/login.ac";
            return;
        }
        var userIntegral = parseFloat($(this).attr("userIntegral"));
        var exchangeIntegral = parseFloat($(this).attr("exchangeIntegral"));
        var price = parseFloat($(this).attr("price"));
        //获取交换类型
        var integralExchangeType = $(".cho-cont .cur").attr("integralExchangeType");
        //获取选择的数量
        var prd_num = parseInt($(".prd_num").val());
        //固定积分 判断 积分是否足够
        if (integralExchangeType == '0' && userIntegral < price * prd_num) {
            alert("对不起,您的积分不足,无法兑换");
            return;
        }
        //部分积分+现金 判断 积分是否足够
        if (integralExchangeType == '1' && userIntegral < exchangeIntegral * prd_num) {
            alert("对不起,您的积分不足,无法兑换");
            return;
        }
        if (userIntegral < price) {
            alert("对不起,您的积分不足,无法兑换");
            return;
        }
        var num = $(".number").val();
        var integralProductNum = $(this).attr("integralProductNum");
        if (parseInt(integralProductNum) < parseInt(num)) {
            alert("对不起,积分商品库存不足,无法兑换");
            return;
        }
        var objectid = $(this).attr("objectid");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var type = $(this).attr("type");
        if (type == "0") {
            //$.ajax({
            //    url:webPath.webRoot+"/cart/add.json",
            //    data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
            //    dataType: "json",
            //    success:function(data) {
            //        window.location.href=webPath.webRoot+"/wap/shoppingcart/cart.ac?carttype="+carttype+"&handler="+handler;
            //    },
            //    error:function(XMLHttpRequest, textStatus) {
            //        if (XMLHttpRequest.status == 500) {
            //            var result = eval("(" + XMLHttpRequest.responseText + ")");
            //            alert(result.errorObject.errorText);
            //        }
            //    }
            //});
            goToUrl(webPath.webRoot + "shoppingcart/integralOrderadd.ac?integralProductId=" + objectid + "&integralExchangeType=" + integralExchangeType + "&num=" + num);
        } else {
            confirm("您确认要兑换此购物券吗？", {
                onSuccess: function () {
                    $.ajax({
                        url: webPath.webRoot + "/cart/add.json",
                        data: {type: carttype, objectId: objectid, quantity: num, handler: handler},
                        dataType: "json",
                        success: function (data) {
                            alert("兑换成功,请到会员专区查看");
                            window.location.href = webPath.webRoot + "/wap/module/member/myCoupon.ac";
                        },
                        error: function (XMLHttpRequest, textStatus) {
                            if (XMLHttpRequest.status == 500) {
                                var result = eval("(" + XMLHttpRequest.responseText + ")");
                                alert(result.errorObject.errorText);
                            }
                        }
                    });
                }
            });
        }

    })

});

function validateNumber() {
    var number = $(".number").val();//输入数量
    var integralProductNum = $(".addcart").attr("integralProductNum");//库存数
    if (isNaN(number) || number=="" || number < 0) {
        alert("对不起，输入的数量不合法");
        $(".number").val("1");
       return;
    }
    if (parseInt(integralProductNum) < parseInt(number)) {
        alert("对不起,库存数不足");

    }

}