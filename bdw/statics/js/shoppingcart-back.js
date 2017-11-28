


$(document).ready(function(){


    $(".rulebtn").click(function(){
        $(this).parent().next().toggle();
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
        var skuIds=new Array();
        $("#dapei").find("input:checked").each(function(){
            skuIds.push(parseInt($(this).attr("skuid")))
        })
        var skuId=$("#dapei_skuId").val();
        skuIds.push(skuId);
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/addBatch.json",
            data:{type:carttype,objectIds:skuIds.join(","),quantity:1,handler:handler},
            dataType: "json",
            success:function(data) {
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
                    "top":batch_addcart.offset().top+"px",
                    "margin-top":"0px"

                })
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    });


    $(".combo_addcart").click(function(){
        if(!isCanBuy){
            alert("该产品已缺货");
            return;
        }
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
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

                })
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    })
    $(".addcart").click(function(){
        //判断是否选择了地域
        /*if(isZoneLimit){
            if($(".selectCity li a.cur").length <= 0){
                alert("请选择区域查看是否支持销售");
                return false;
            }
            if($(".selectCity li a.cur").attr("support")=='N'){
                alert("此区域不销售，请查看其他区域选择");
                return false;
            }
        }*/
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");

        if(skuId==""){
            alert("请选择商品规格")
            return;
        }
        if(num==""){
            alert("请填写购买数量");
            return;
        }
        var numCheck=/^[0-9]*$/;
        if(!numCheck.test(num)){
            alert("请填写数字");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                var shoppingcart=data.shoppingCartVo;
                var cartNum=0;
                for(var i=0;i<shoppingcart.items.length;i++){
                    cartNum=cartNum+shoppingcart.items[i].quantity;
                }

                var cartLayer=$(".addTobuyCarLayer");
                cartLayer.find(".cartnum").html(cartNum);
                $("#top_myCart_cartNum").html(parseInt($("#top_myCart_cartNum").html())+parseInt(num));
                cartLayer.find(".cartprice").html(shoppingcart.productDiscountAmount);
                $("#top_myCart_cartNum2").html(cartNum);
                $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                $("#tuanbox").hide();
                $(".addTobuyCarLayer").show().css({
                    "top":addbtn.offset().top+"px",
                    "margin-top":"0px"
                })
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    });
    $(".addGoCar").click(function(){
        var addbtn=$(this);
        var skuId=$(this).attr("skuid");
        var num=$(this).attr("num");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");

        if(skuId==""){
            alert("请选择商品规格")
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
                    alert(result.errorObject.errorText);
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
            alert("请选择商品规格")
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                window.location.href=webPath.webRoot+"/shoppingcart/cart.ac?handler="+handler+"&carttype="+carttype+"&rd="+Math.random()
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    })

    $(".addNum").click(function(){
        var object=$(this);
        var value=   $(this).prev("input").val();
        var num=parseInt(value)+1;
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId},
            dataType: "json",
            success:function(data) {
                object.prev("input").val(num);
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
        var orgId=$(this).attr("orgid");
        if(value==0){
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:value,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId},
            dataType: "json",
            success:function(data) {
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
    $(".dele").click(function(){
        var carttype=$(this).attr("carttype");
        var itemKey=$(this).attr("itemKey");
        $.ajax({
            url:webPath.webRoot+"/cart/removePresent.json",
            data:{type:carttype,itemKey:itemKey},
            dataType: "json",
            success:function(data) {
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
        });

    })
    $(".clearcart").click(function(){
        var carttype=$(this).attr("carttype");

        $.ajax({
            url:webPath.webRoot+"/cart/clear.json",
            data:{type:carttype},
            dataType: "json",
            success:function(data) {
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


    $(".updateSelect").click(function(){
        var updateSelectList = $(this).parents(".order").find(".updateSelect");
        var checkPro = $(this).parents(".order").find(".checkPro");
        var isSelected=true;
        if($(this).attr("checked")){
            isSelected=true;
            checkPro.attr("checked",true);//勾选店铺
        } else{
            isSelected=false;
            $(".selectAll").attr("checked",false);//去掉全选
            var updateSelectNum = 0;
            updateSelectList.each(function(){
                if($(this).attr("checked") == undefined){
                    updateSelectNum += 1;
                }
            });
            if(updateSelectList.length == updateSelectNum){
                checkPro.attr("checked",false);//勾选店铺
            }
        }

        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/updateSelectItem.json",
            data:{itemKey:itemKey,type:carttype,isSelected:isSelected,orgId:orgId},
            dataType: "json",
            success:function(data) {
                setTimeout(function(){
                    var isCod = getUrlParamValue("isCod");
                    var carttype = getUrlParamValue("carttype");
                    var handler = getUrlParamValue("handler");
                    var url = webPath.webRoot+"/shoppingcart/cart.ac?";
                    if(isCod == ""){
                        url = url+"isCod="+isCod;
                    }
                    if(carttype == ""){
                        url = url+"&carttype="+carttype;
                    }
                    if(handler == ""){
                        url = url+"&handler="+handler;
                    }
                    window.location.href=url+"&rd="+Math.random();
                },1);
                if(!data.isCod){
                    $(".isCod").attr("checked",false)
                }

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })

    })

    function getUrlParamValue(param){
        var url = location.href;
        var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
        var paraObj = {};
        for (var i=0; i < paraString.length; i++){
           var j=paraString[i];
            if(j.substring(0,j.indexOf("=")).toLowerCase() == param.toLowerCase()){
                paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
            }
        }
        var returnValue = paraObj[param.toLowerCase()];
        if(typeof(returnValue)=="undefined"){
            return "";
        }else{
            return returnValue;
        }
    }

    $(".subNum").click(function(){
        var object=$(this)
        var value=   $(this).prev().prev("input").val();
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var orgId=$(this).attr("orgid");
        var num=parseInt(value)-1;
        if(num==0){
            return;
        }
        $(this).prev().prev("input").val(num);
        $.ajax({
            url:webPath.webRoot+"/cart/update.json",
            data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId},
            dataType: "json",
            success:function(data) {
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

    $(".delItem").click(function(){
        var itemKey=$(this).attr("itemKey");
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var orgId=$(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/remove.json",
            data:{type:carttype,itemKey:itemKey,handler:handler,orgId:orgId},
            dataType: "json",
            success:function(data) {
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
        });


    })

    $(".clearAllCart").click(function(){
        var carttype=$(this).attr("carttype");
        $.ajax({
            url:webPath.webRoot+"/cart/clear.json",
            data:{type:carttype},
            dataType: "json",
            success:function(data) {
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
        });
    });

    $(".isCod").click(function(){
        var isSelected=false;
        if($(this).attr("checked")){
            isSelected=true;
        }
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/checkIsCodItems.json",
            data:{type:carttype,isSelected:isSelected},
            dataType: "json",
            success:function(data) {
                if(isSelected){
                    window.location.href=webPath.webRoot+"/shoppingcart/cart.ac?isCod=Y&carttype="+carttype+"&handler="+handler+"&rd="+Math.random();
                } else{
                    window.location.href=webPath.webRoot+"/shoppingcart/cart.ac?carttype="+carttype+"&handler="+handler+"&rd="+Math.random();
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

    })

    $(".addPresent").click(function(){
        var ruleId=$(this).attr("ruleId");
        var presentId=$(this).attr("presentId");
        var carttype=$(this).attr("carttype");

        $.ajax({
            url:webPath.webRoot+"/cart/addPresent.json",
            data:{type:carttype,presentId:presentId,ruleId:ruleId},
            dataType: "json",
            success:function(data) {
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
        });

    })


    $(".addRedemption").click(function(){
        var ruleId=$(this).attr("ruleId");
        var presentId=$(this).attr("presentId");
        var carttype=$(this).attr("carttype");

        addRedemption(ruleId,presentId,carttype);
    })

    function addRedemption(ruleId,presentId,carttype){
        $.ajax({
            url:webPath.webRoot+"/cart/addRedemption.json",
            data:{type:carttype,presentId:presentId,ruleId:ruleId},
            dataType: "json",
            success:function(data) {
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
        });
    }

    /*全选*/
    $(".selectAll").click(function(){
        //去掉货到付款
        $(".isCod").attr("checked",false);
        var selectItems = new Array();
        var carttype=$(this).attr("carttype");
        if($(this).attr("checked") == undefined){//去掉全选
            $(".selectAll").attr("checked",false);
            $(".checkPro").each(function(){
                $(this).attr("checked",false);
            });
            $(".updateSelect").each(function(){
                $(this).attr("checked",false);
                var itemKey = $(this).attr("itemKey");
                var orgid = $(this).attr("orgid");
                selectItems.push(itemKey + ':'+orgid);
            });
            updateSelectCartItems(selectItems,carttype,false);
        }else{//全选商品
            $(".selectAll").attr("checked",true);
            $(".checkPro").each(function(){
                $(this).attr("checked",true);
            });
            $(".updateSelect").each(function(){
                $(this).attr("checked",true);
                var itemKey = $(this).attr("itemKey");
                var orgid = $(this).attr("orgid");
                selectItems.push(itemKey + ':'+orgid);
            });
            updateSelectCartItems(selectItems,carttype,true);
        }
    });
    /*店铺全选*/
    $(".checkPro").click(function(){
        var isChecked = $(this).attr("checked") == undefined ? false : true;
        //把勾选的商品updateSelectCartItems
        var selectItems = new Array();
        var carttype=$(this).attr("carttype");
        $(this).parents(".order").find(".updateSelect").each(function(){
            $(this).attr("checked",isChecked);
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':'+orgid);
        })
        updateSelectCartItems(selectItems,carttype,isChecked);
    });
    /*去掉全选*/

});

var goToOrderAdd = function (url){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function(){
        if($(this).attr("checked") == undefined){
            selectNum += 1;
        }
    });
    if(selectList.length == selectNum){
        alert("您没有选择任意一件商品");
        return false;
    }
    goToUrl(url);
};

var updateSelectCartItems = function(itemKeys,carttype,isSelected){//多个商品keys
    if(itemKeys == undefined){
        return false;
    }
    $.ajax({
        url:webPath.webRoot+"/cart/updateSelectItems.json",
        data:{itemKeys:itemKeys.join(","),type:carttype,isSelected:isSelected},
        dataType: "json",
        success:function(data) {
            if(!data.isCod){
                $(".isCod").attr("checked",false);
            }
            $("#allCartNum").text(data.allCartNum);
            $("#allObtainTotalIntegral").text(data.allObtainTotalIntegral);
            $("#allDiscount").text(data.allDiscount);
            $("#allProductTotalAmount").text(data.allProductTotalAmount);
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    })
};

