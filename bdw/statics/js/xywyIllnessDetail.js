/**
 * Created by HGF on 2015/12/11.
 */
$(document).ready(function(){
    $(".close").click(function(){
        $("#addCartInfo").hide();
        $(".layer-bg").hide();
    });
    $(".addcart").click(function(){
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var price = $("#price").html();
        var prdNum =$("#prdNum").val();

        if(skuId==""){
            alert("请选择商品规格")
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                var shoppingcart=data.shoppingCartVo;
                if( data.success == "false"){
                    //$(".login-layer").show();
                    alert("请先登录");
                    location.href = webPath.webRoot + "/login.ac";
                }else{
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
                    $(".addTobuyCarLayer").show().css({
                        "top":addbtn.offset().top+"px",
                        "margin-top":"0px"

                    });
                    //添加成功信息提示
                    $(".product-detail").show();
                    $("#addCartInfo").show();
                    //商品总数量
                    $(".buy-car").find(".num").html(cartNum);
                    $("#addCartInfo").find("#count").html(cartNum);
                    var totalPrice = $("#addCartInfo").find("#totalPrice");
                    $(totalPrice).html(shoppingcart.productDiscountAmount);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    })

    $("#diseaseCollect").has("i[class=no]").click(function(){
        if(webPath.sysDiseaseId =='' || webPath.sysDiseaseId == undefined){
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/member/addDiseaseCollection.json",
            type:"POST",
            data:{
                sysDiseaseId:webPath.sysDiseaseId,
                collectTypeCode:'3'
            },
            dataType:"json",
            success:function(data){
                if(data.success == "noLogin"){
                    $(".login-layer").show();
                }else if(data.success == true){
                    var collectCount;
                    if(webPath.productCollectCount == '' || webPath.productCollectCount == undefined){
                        collectCount = 1
                    }else{
                        collectCount = parseInt(webPath.productCollectCount)+1
                    }
                    $("#productCollectCount").html(collectCount);
                    location.reload();
                    return;
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
