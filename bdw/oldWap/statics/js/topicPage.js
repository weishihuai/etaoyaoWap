/**
 * Created by liuming-PC on 2017/6/14.
 */
$(function() {
    $(".buy-btn").click(function() {
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        if(skuId==""){
            popover("addcart2","top","温馨提示","请选择商品规格");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            async:false,
            success:function(data) {
                if(data.success == "true"){
                    var shoppingcart=data.shoppingCartVo;
                    var cartNum=0;
                    for(var i=0;i<shoppingcart.items.length;i++){
                        cartNum=cartNum+shoppingcart.items[i].quantity;
                    }
                    var cartLayer=$(".addTobuyCarLayer");
                    cartLayer.find(".cartnum").html(cartNum);
                    $("#top_myCart_cartNum").html(cartNum);
                    cartLayer.find(".cartprice").html(shoppingcart.productDiscountAmount);
                    $("#top_myCart_cartNum2").html(cartNum);
                    $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    window.location.href = webPath.webRoot+ "/wap/shoppingcart/cart.ac";
                }else{
                    window.location.href = webPath.webRoot + "/wap/login.ac";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });
    })
});