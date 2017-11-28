/**
 * Created by xjl on 2016/8/11.
 */
$(function(){
    //组合套餐按钮
    var comboselect=$(".combo > h5").find("a").click(function(){
        comboselect.removeClass("cur");
        $(this).addClass("cur");
        var comboid=$(this).attr("comboid");
        $(".combobox").hide();
        $("#combos"+comboid).show();
    });

    $(".combo_addcart").click(function(){
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var count=$(this).attr("count");

        if(skuId==""){
            popover("comboAddCart"+count,"top","温馨提示","请选择商品规格");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                if(data.success == "true"){
                    var cartNum = $(".cart-label").text();
                    if(cartNum){
                        cartNum = IsNum(cartNum)?parseInt(cartNum):0;
                        num = cartNum+(IsNum(num)?parseInt(num):0);
                    }
                    num = num===NaN?1:num;
                    $(".cart-label").html( num ) ;
                    popover("comboAddCart"+count,"top","温馨提示","您已经成功添加商品到购物车");
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

})