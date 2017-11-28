


$(document).ready(function(){
    $(".rulebtn").click(function(){
        $(this).parent().next().toggle();
    });

    //搭配购买商品
    $(".batch_addcart").click(function(){
        if($(this).hasClass("disable")){
            return;
        }

        if($("input[type=checkbox]:checked").length < 1){
            popover("dapeiCart","top","温馨提示","请勾选搭配商品");
            return;
        }

        var batch_addcart=$(this);
        if($("#dapei_skuprice").val()==""){
            xyPop.msg('请先选择商品规格!',{type:'warning',time:2});
            return;
        }
        if(!isCanBuy){
            xyPop.msg('该产品已缺货!',{type:'warning',time:2});
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

    });

    $(".combo_addcart").click(function(){
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var count=$(this).attr("count");

        /*if($(this).hasClass("disable")){
            return;
        }*/

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

    });
    $(".addcart").click(function () {
        var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");

        if (skuId == "") {
            popover("addcartButton", "top", "温馨提示", "请选择商品规格");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    //                window.location.href=webPath.webRoot+"/wap/shoppingcart/cart.ac?carttype="+carttype+"&handler="+handler;
                    var cartNum = $(".cart-label").text();
                    if (cartNum) {
                        cartNum = IsNum(cartNum) ? parseInt(cartNum) : 0;
                        num = cartNum + (IsNum(num) ? parseInt(num) : 0);
                    }
                    num = num === NaN ? 1 : num;
                    $(".cart-label").html(num);
                    popover("addcartButton", "top", "温馨提示", "您已经成功添加商品到购物车");

                    /*var shoppingcart=data.shoppingCartVo;
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
                     //                $(".addTobuyCarLayer").show().css({
                     //                    "top":addbtn.offset().top+"px",
                     //                    "margin-top":"0px"
                     //                })
                     alert("商品已成功添加到购物车！购物车共有" + cartNum + "件商品，合计：" + shoppingcart.productDiscountAmount + "元");*/
                } else {
                    /*confirm('您还没有登录，请先登录!',{onSuccess:function(){
                     window.location.href = webPath.webRoot + "/wap/login.ac";
                     }});*/
                    window.location.href = webPath.webRoot + "/wap/login.ac";
                }

            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });

    });
    //立即购买

    $(".addcart2").click(function(){
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");

        if(skuId==""){
//            alert("请选择商品规格")
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
//                $(".addTobuyCarLayer").show().css({
//                    "top":addbtn.offset().top+"px",
//                    "margin-top":"0px"
//                })
                    window.location.href = webPath.webRoot+ "/wap/shoppingcart/cart.ac";
                }else{
                    //alert("请先登录");
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

    });
    $(".fenqi_cart").click(function(){
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");

        if(skuId==""){
            xyPop.msg('请先选择商品规格!',{type:'warning',time:2});
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                window.location.href=webPath.webRoot+"/shoppingcart/cart.ac?handler="+handler+"&carttype="+carttype

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });

    });

    $(".addNum").click(function(){
        var value=   $(this).prev("input").val();
        var num=parseInt(value)+1;
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler},
            dataType: "json",
            success:function(data) {
                $(".cartNum").val(num);
                setTimeout(function(){
                    window.location.reload();
                },1);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    });

    $(".cartNum").change(function(){
        var value= $(this).val();
        var reg=new RegExp("^[1-9]\\d*$");
        if(!reg.test(value)){
            $(this).val(1);return;
        }
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        if(value==0){
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:value,itemKey:itemKey,type:carttype,handler:handler},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        })


    });
    $(".dele").click(function(){
        var carttype=$(this).attr("carttype");
        var itemKey=$(this).attr("itemKey");
        $.ajax({
            url:webPath.webRoot+"/cart/removePresent.json",
            data:{type:carttype,itemKey:itemKey},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });

    });
    $(".clearcart").click(function(){
        var carttype=$(this).attr("carttype");

        $.ajax({
            url:webPath.webRoot+"/cart/clear.json",
            data:{type:carttype},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        })
    });

    $(".subNum").click(function(){
        var value=   $(this).next("input").val();
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var num=parseInt(value)-1;
        if(num==0){
            return;
        }
        $(this).next("input").val(num);
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        })
    });

    $(".delItem").click(function(){
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/remove.json",
            data:{type:carttype,itemKey:itemKey,handler:handler},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });


    });

    $(".addRedemptionNum").click(function(){
        var addRuleId=$(this).attr("ruleId");
        var addPresentId=$(this).attr("presentId");
        var addCarttype=$(this).attr("carttype");

        $(".dat").find(".addRedemption").each(function(){
            var ruleId=$(this).attr("ruleId");
            var presentId=$(this).attr("presentId");
            var carttype=$(this).attr("carttype");
            var presentQuantity=$(this).attr("presentQuantity");
            if(addRuleId==ruleId&&addPresentId==presentId&&addCarttype==carttype&&parseInt(presentQuantity)>0){
                addRedemption(ruleId,presentId,carttype);
            }
        })

    });

    $(".addPresent").click(function(){
        var ruleId=$(this).attr("ruleId");
        var presentId=$(this).attr("presentId");
        var carttype=$(this).attr("carttype");

        $.ajax({
            url:webPath.webRoot+"/cart/addPresent.json",
            data:{type:carttype,presentId:presentId,ruleId:ruleId},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });

    });


    $(".addRedemption").click(function(){
        var ruleId=$(this).attr("ruleId");
        var presentId=$(this).attr("presentId");
        var carttype=$(this).attr("carttype");

        addRedemption(ruleId,presentId,carttype);
    });

    function addRedemption(ruleId,presentId,carttype){
        $.ajax({
            url:webPath.webRoot+"/cart/addRedemption.json",
            data:{type:carttype,presentId:presentId,ruleId:ruleId},
            dataType: "json",
            success:function(data) {
                window.location.reload();
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop({content:result.errorObject.errorText,type:'error'});
                }
            }
        });
    }
    //判断是否为数字
    function IsNum(s)
    {
        if (s!=null && s!="")
        {
            return !isNaN(s);
        }
        return false;
    }
});

