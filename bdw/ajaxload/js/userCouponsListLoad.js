$(function () {

    /*使用购物劵*/
    $(".couponIds").change(function(){

        var isNotUseCoupon = false;

        var couponIds = $(this).val();
        if(couponIds==null || couponIds.isArray && couponIds.length==0){
            return;
        }

        if(couponIds.length==1 && couponIds[0] == -1){
            return;
        }

        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");

        //不使用购物券
        if(couponIds[0] == '0'){
            $(".cp1" + orgId).trigger('click');
            isNotUseCoupon = true;
            //return;
        }

        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/couponFront/useCoupons.json",
            traditional:true,
            data:{couponIds:eval(couponIds),orgId:orgId,type:carttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){
                    $(".orderTotalAmout"+orgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+orgId).html(data.freightAmount);
                    $(".integral"+orgId).html(data.integral);
                    $(".discountAmount"+orgId).html(data.discountAmount);
                    $(".shopDiscountMsg"+orgId).html('<a style="text-decoration: none;"><span>店铺优惠：</span>'+data.allDiscountName+'</a>');

                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);
                    $("#allOrderTotalDiscount").html(data.allOrderTotalDiscount);
                    $("#allOrderTotalIntegral").html(data.allOrderTotalIntegral);
                    $("#orderTotalAmount").val(data.allOrderTotalAmount);

                    $("#useCoupons"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/useCouponsLoad.jsp",{orgId: orgId,carttype:carttype},function(){});
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});

                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                        }

                    });
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
    /*使用购物劵*/

});