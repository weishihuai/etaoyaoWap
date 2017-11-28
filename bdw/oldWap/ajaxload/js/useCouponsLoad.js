$(function () {

    /*使用购物劵*/
    $(".coupon").change(function(){

        var isNotUseCoupon = false;

        var wapCouponIds = $(this).val();
        if(wapCouponIds==null || wapCouponIds.isArray && wapCouponIds.length==0){
            return;
        }

        if(wapCouponIds.length==1 && wapCouponIds[0] == -1){
            return;
        }

        if(wapCouponIds[0] == '0'){
            wapCouponIds[0] == '0';
            isNotUseCoupon = true;
        }

        var wapOrgId =$(this).attr("orgId");
        var wapCarttype=$(this).attr("carttype");


        $.ajax({
            type:"POST",
            url:webPath.webRoot+"/cart/useCoupon.json",
            data:{couponIds:eval(wapCouponIds),orgId:wapOrgId,type:wapCarttype},
            dataType: "json",
            success:function(data) {
                if(data.success=="true"){

                    $(".orderTotalAmout"+wapOrgId).html(data.orderTotalAmoutStr);
                    $(".freightAmount"+wapOrgId).html(data.freightAmount);
                    $(".discountAmount"+wapOrgId).html(data.discountAmount);
                    $("#allOrderTotalAmount").html(data.allOrderTotalAmount);

                    $("#useCoupons"+wapOrgId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/useCouponsLoad.jsp",{orgId: wapOrgId,carttype:wapCarttype},function(){});
                    $("#userPlatformCoupon"+wapOrgId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/userPlatformCouponsListLoad.jsp",{orgId: wapOrgId,carttype:wapCarttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
                    var platformCoupon = $(".userPlatformCoupon");
                    platformCoupon.each(function () {
                        var oId = $(this).attr("orgId");
                        if(oId != wapOrgId && $(this).css("display") != 'none'){
                            $("#userPlatformCoupon"+oId).load(webPath.webRoot+"/template/bdw/wap/ajaxload/platformCanUseCouponsLoad.jsp",{orgId: oId,carttype:wapCarttype},function(){if(isNotUseCoupon){$(".coupon").val(0)}});
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
});