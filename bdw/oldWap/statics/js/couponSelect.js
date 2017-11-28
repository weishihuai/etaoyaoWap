$(document).ready(function(){
    $(".addCoupon").on("click",function(){
        window.location.href = webPath.webRoot+"/wap/shoppingcart/addCoupon.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&time="+(new Date()).getTime();
    });
    $(".couponSelect").on("click",function(){
        var addcouponChecked = $(".usecoupon:checked");
        var couponIdStr = [];
        addcouponChecked.each(function(i){
            couponIdStr.push(this.value);
        });
        if(couponIdStr.length > 0){
            $.ajax({
                url:webPath.webRoot+"/cart/addCoupons.json",
                data:({couponIds:couponIdStr.toString(),type:webPath.carttype}),
                success:function(data){
                    window.location.href = webPath.webRoot+"/wap/shoppingcart/orderadd.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&time="+(new Date()).getTime();
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }else{
            var removeCouponChecked = $(".usecoupon");
            removeCouponChecked.each(function(i){
                couponIdStr.push(this.val());
            });
            $.ajax({
                url:webPath.webRoot+"/cart/removeCoupons.json",
                data:({couponIds:couponIdStr.toString(),type:webPath.carttype}),
                success:function(data){
                    window.location.href = webPath.webRoot+"/wap/shoppingcart/orderadd.ac?carttype="+webPath.carttype+"&handler="+webPath.handler+"&time="+(new Date()).getTime();;
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }
    });

});