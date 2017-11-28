$(function () {
    /*删除购物劵*/
    $(".cancelUseCoupon").click(function(){

        var couponId = $(this).attr("couponId");

        var orgId =$(this).attr("orgId");
        var carttype=$(this).attr("carttype");
        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/member/couponFront/cancelUseCoupon.json",
            traditional:true,
            data:{couponId:couponId,orgId:orgId,type:carttype},
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
                    $("#userPlatformCoupon"+orgId).load(webPath.webRoot+"/template/bdw/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: orgId,carttype:carttype},function(){});

                    //选择平台购物券的同时需要load其他店铺下平台的购物券列表，因为已经选择的购物券不能出现在其他的店铺里,避免重复选择
                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != orgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:carttype},function(){});
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
    /*删除购物劵*/

});