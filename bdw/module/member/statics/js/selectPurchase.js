$(document).ready(function(){
    $(".returnItem").find("input").click(function(){
        var comPrdId = $(this).attr("combinedProductId");
        if(null != comPrdId && undefined != comPrdId){
            var isChecked = $(this).attr("checked");
            $(".returnItem").find("input").each(function(){
                if($(this).attr("combinedProductId") == comPrdId){
                    if(null == isChecked || undefined == isChecked){
                        $(this).removeAttr("checked");
                    }else {
                        $(this).attr("checked", isChecked);
                    }
                }
            });
        }
    });
});

var selectPurchase = function(id,orderNum,isReturn){
    var input_checkBoxs = $("input:[name="+id+"]:checked");
    if($("input:[name="+id+"]").length <= 0){
        alert("订单编号为"+orderNum+"的商品已申请退换货");
        return false;
    }
    if(input_checkBoxs.length <= 0){
        alert("请勾选订单编号为"+orderNum+"的商品进行退换货");
        return false;
    }else{
        var $Arr = new Array();
        input_checkBoxs.each(function(i){
            $Arr.push($(this).val());
        });
        goToUrl(webPath.webRoot+"/module/member/applyPurchase.ac?orderId="+id+"&orderItems="+$Arr+"&isReturn="+isReturn);
//        window.location.href = webPath.webRoot+"/module/member/applyPurchase.ac?orderId="+id+"&orderItems="+$Arr;
    }
};