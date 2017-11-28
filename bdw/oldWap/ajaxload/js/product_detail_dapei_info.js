$(function(){
    //商品搭配
    $("#dapei").find("input").click(function(){
        if ($("#dapei_skuprice").val() == "") {
            alert("请选择商品规格");
            $(this).attr("checked", false);
            return;
        }
        var dapei_skuprice = parseFloat($("#dapei_skuprice").val());

        var price = 0.0;
        var num = 0;
        $("#dapei").find("input:checked").each(function () {
            price = price + parseFloat($(this).val());
            num++;
        });
        var p = price + dapei_skuprice;
        var n = 'n';
        $("#dapeiprice").html("￥" + p.toFixed(2));
        $("#selectNum").html(num);
    });

    //搭配购买商品
    $(".batch_addcart").click(function(){
        var batch_addcart=$(this);
        if($("#dapei_skuprice").val()==""){
            alert("请选择商品规格");
            return;
        }
        if(!isCanBuy){
            alert("该产品已缺货");
            return;
        }
        var skuIds=[];
        $("#dapei").find("input:checked").each(function(){
            skuIds.push(parseInt($(this).attr("skuid")))
        });
        var skuId=$("#dapei_skuId").val();
        skuIds.push(skuId);
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/addBatch.json",
            data:{type:carttype,objectIds:skuIds.join(","),quantity:1,handler:handler},
            dataType: "json",
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
                    popover("dapeiCart","top","温馨提示","您已经成功添加商品到购物车");
                }else{
                    /*confirm('您还没有登录，请先登录!',{onSuccess:function(){
                     window.location.href = webPath.webRoot + "/wap/login.ac";
                     }});*/
                    window.location.href = webPath.webRoot + "/wap/login.ac";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    });
});
