/**
 * Created with IntelliJ IDEA.
 * User: lxd
 * Date: 13-11-28
 * Time: 下午4:43
 * To change this template use File | Settings | File Templates.
 */

var goToUrl = function (url) {
    setTimeout(function () {
        window.location.href = url
    }, 50000);
};
var collapse = true;
var isNeedInvoice =false;
$(document).ready(function(){
    var radio = $("input[name='needInvoice']:checked").val();
    if(radio=="N"){
        $(".title-text").hide();
        isNeedInvoice = false;
    }else{
        $(".title-text").show();
        isNeedInvoice = true;
    }
    /*使用购物劵*/
    $(".coupon").change(function(){
        var couponId = $(this).val();
        if(couponId=='请选择购物券...'){
            return;
        }
        if(couponId=='不使用购物劵'){
            couponId='';
        }
        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/xkyCouponFront/useCoupon.json",
            data:{couponId:couponId,orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    /*           $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                     $(".freightAmount"+orgId).html(data.freightAmount);
                     $("#allOrderTotalAmount").html(data.allOrderTotalAmount);*/
                    window.location.reload();
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    executeError(result.errorObject.errorText);
                }
            }
        });
    });

    $(".selectAddr").click(function(){
        window.location.href=webPath.webRoot+"/wap/shoppingcart/integralAddrSelect.ac?integralProductId="+webPath.integralProductId+"&num="+webPath.num+"&integralExchangeType="+webPath.integralExchangeType+"&time="+(new Date()).getTime();
    });

    /*选择收货地址*/
    $(".addrRow").click(function(){
        $(".slectItem").removeClass("glyphicon-ok");
        var receiveAddrId=$(this).attr("receiveAddrId");
        selectAddressFun(receiveAddrId);
    });

    $(".clear-msg").click(function(){
        if($(this).val()=='备注内容'){
            $(this).val('');
            $(this).attr("style", "color:#000;");
        }
    });

    $(".invoice-radio").change(function(){
        var radioVal = $("input[name='needInvoice']:checked").val();
        if(radioVal=="N"){
            $(".title-text").hide();
            $("#isNeedInvoice").val("N");
            isNeedInvoice = false;
        }else{
            isNeedInvoice = true;
            $("#isNeedInvoice").val("Y");
            $(".title-text").show();
        }
    });

    $("#invoice-title").click(function(){
        if($(this).val()=='发票台头'){
            $(this).val('');
            $(this).attr('style', 'color:#000;');
        }
    });

    $(".clear-msg").blur(function(){
        var remark=  $(this).val();
        var orgId=$(this).attr("orgid");
        var type=$(this).attr("carttype");
        if($(this).val()=='备注内容'||$(this).val()=='')
            return;
        $.ajax({
            url:webPath.webRoot+"/cart/saveRemark.json",
            data:({remark:remark,orgId:orgId,type:type}),
            success:function(data){

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    //var error = eval("(" + result + ")");
                    alert(result.errorObject.errorText);

                }
            }
        })
    });

    //保存配送方式
    $(".saveDelivery").change(function(){
        var deliveryId=$(this).val();
        if(deliveryId==undefined || deliveryId==0){
            alert("配送方式未选择");
            return;
        }
        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/saveDeliveryRuleId.json",
            data:{type:carttype,deliveryRuleId:deliveryId,orgId:orgId},
            dataType: "json",
            success:function(data) {
                $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                $(".freightAmount"+orgId).html(data.freightAmount);
                $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
        $('input:radio[name="payway"]:checked').each(function(){
            var tmp = $(this)[0];
            tmp.checked = false;
            tmp = null;
        });
    });

    /*提交订单*/
    $(".submitOrder").click(function(){
        var isReceiver = $("#isReceiver").val();
        if(isReceiver == "false"){
            alert("请检查您的收货地址!");
            return false;
        }

        var isIntegral = $("#isIntegral").val();
        if(isIntegral == "false"){
            alert("您的积分不足!");
            return false;
        }
        //获取积分商品ID ，商品数量，选中地址的ID
        var integralProductId = $(this).attr("integralProductId");
        //数量
        var num = $(this).attr("num");
        //支付类型
        var integralExchangeType = $(this).attr("integralExchangeType");
        //商品库存
        var integralProductNum = $(this).attr("integralProductNum");
        //验证传入数量是否为整数字
        if (isNaN(num) || integralProductNum < num) {
            alert("库存不足!");
            goToUrl(webPath.webRoot + "/shoppingcart/integralDetails.ac?integralProductId=" + integralProductId + "&pitchOnRow=18");
        }
        //var convertTotalAmount=num*exchangeAmount;
        //收货地址
        var receiveAddrId = $("#receiveAddrId").val();

        //保存用户积分商品订单
        $.ajax({
            type: "post",
            url: webPath.webRoot + "/integralOrder/addIntegralOrder.json",
            data: {
                integralProductId: integralProductId,
                receiveAddrId: receiveAddrId,
                num: num,
                paymentConvertTypeCode: integralExchangeType
            },
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    if (integralExchangeType == 0) {
                        alert("订单提交成功");
                        $("#myModal").find(".btn").click(function(){
                            window.location.href = webPath.webRoot + "/wap/module/member/myIntegralOrders.ac";
                        });
                    } else if (integralExchangeType == 1) {
                        alert("订单提交成功,点击确定后将跳到收银台进行金额支付");
                        $("#myModal").find(".btn").click(function(){
                        window.location.href = webPath.webRoot + "/wap/shoppingcart/integralOrderSuccess.ac?integralOrderId=" + data.integralOrderId;
                        });
                    }
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

    function collapse(thatCollapse){
        if(!thatCollapse.find(".glyphicon-chevron-down").is(":hidden")){
            thatCollapse.find(".glyphicon-chevron-down").hide();
            thatCollapse.find(".glyphicon-chevron-up").show();
        }else{
            thatCollapse.find(".glyphicon-chevron-down").show();
            thatCollapse.find(".glyphicon-chevron-up").hide();
        }
    }

    $(".shops").click(function(){
        var shop =  $(this).parent().find(".shop");
        if(shop.hasClass("collapse")){
            shop.collapse('show');
        }else{
            shop.collapse('hide');
        }
        collapse($(this));
    });

});

var selectAddressFun = function(receiveAddrId){
    $.ajax({
        url:webPath.webRoot+"/cart/updateReceiver.json",
        data:({type:webPath.carttype,receiveAddrId:receiveAddrId,isCod:orderData.isCod}),
        success:function(data){
            if(data.success == "true"){
                window.location.reload();
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
};

/*验证选择配送方式*/
//var validatorDelivery = function(){
//    var returnBool = true;
//    $(".saveDelivery").each(function(){
//        if($(this).find("option:selected").val()-0 <= 0){
//            returnBool = false;
//        }
//    });
//    return returnBool;
//};