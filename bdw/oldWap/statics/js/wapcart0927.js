$(document).ready(function(){

    $(".addNum").click(function(){
       addNum(this);
    });

    $(".subNum").click(function(){
        subNum(this);
    });

    $(".cartNum").change(function(){
       cartNum(this);

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
                    if(result.errorObject.errorText !=null){
                        alert(result.errorObject.errorText);
                    }
                }
            }
        });

    });
    $(".clearcart").click(function(){
        clearcart(this);
    });


    $(".updateSelect").click(function(){
       updateSelect(this);
    });

    function getUrlParamValue(param){
        var url = location.href;
        var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
        var paraObj = {};
        for (var i=0; i < paraString.length; i++){
            j=paraString[i];
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

    $(".clearShop").click(function(){
        clearShop(this);
    });

    $(".delItem").click(function(){
        delItem(this);


    });

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
                    if(result.errorObject.errorText !=null){
                        alert(result.errorObject.errorText);
                    }
                }
            }
        });
    });

    $(".isCod").click(function(){
        isCod(this);
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
                setTimeout(function(){
                    window.location.reload();
                },1);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    if(result.errorObject.errorText !=null){
                        alert(result.errorObject.errorText);
                    }
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
                setTimeout(function(){
                    window.location.reload();
                },1);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    if(result.errorObject.errorText !=null){
                        alert(result.errorObject.errorText);
                    }
                }
            }
        });
    }

    /*全选*/
    $(".selectAll").click(function(){
        //去掉货到付款
        $(".isCod").attr("checked",false);
        var selectItems = [];
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
        checkPro(this);
    });
    /*去掉全选*/

    //结算时，商品有效性判断
    $("#wapAddCartResult").click(function () {
        addCartResultClick(this);
    });


});

var updateSelectCartItems = function(itemKeys,carttype,isSelected){//多个商品keys
    if(itemKeys == undefined){
        return false;
    }

    if(itemKeys.length <= 0){
        cart();
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
            $("#allProductTotalAmount").text("￥"+data.allProductTotalAmount);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    })
};

var goToOrderAdd = function (){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function(){
        if(!$(this).hasClass("cur")){
            selectNum += 1;
        }
    });
    if(selectList.length == selectNum){
        alert("您没有选择任意一件商品");
        return false;
    }
    //goToUrl(url);
};

var goToUrl = function(url){
    setTimeout(function(){window.location.href=url},1)
};

//加入购物车
function addCartResultClick(object){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function(){
        if(!$(this).hasClass("cur")){
            selectNum += 1;
        }
    });
    if(selectList.length == selectNum){
        alert("您没有选择任意一件商品");
        return;
    }

    var carttype = $("#wapAddCartResult").attr("carttype");
    var handler = $("#wapAddCartResult").attr("handler");
    var isCod = $("#wapAddCartResult").attr("isCod");

    if(undefined == isCod || '' == isCod){
        isCod = 'N';
    }

    $.ajax({
        url: webPath.webRoot + "/cart/checkToAddOrder.json",
        data: {type: carttype},
        dataType: "json",
        success: function (data) {
            if(data.success == 'false'){
                alert("您选择的商品有错误，请重新选择");

            }else{
                window.location.href = webPath.webRoot + "/wap/shoppingcart/orderadd.ac?carttype="+carttype+"&handler="+handler+"&isCod="+isCod;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}


var xmlhttp;
var url =webPath.webRoot + "/wap/shoppingcart/cartMain0927.ac";
function cart(){
    xmlhttp=null;
    if (window.XMLHttpRequest){// code for all new browsers
        xmlhttp=new XMLHttpRequest();
    }
    else if (window.ActiveXObject){// code for IE5 and IE6
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }

    if (xmlhttp.overrideMimeType) {
        xmlhttp.overrideMimeType("text/xml");
    }

    if (xmlhttp!=null) {
        xmlhttp.open("GET",url + "?handler=" + webPath.handler + "&carttype=" + webPath.carttype + "&timeStamp=" + new Date().getTime(),false);
        xmlhttp.send();
        if (xmlhttp.readyState==4){// 4 = "loaded"
            if (xmlhttp.status==200){// 200 = OK
                $("#cart").html(xmlhttp.responseText);
            } else {
                alert("Problem retrieving XML data" + xmlhttp.statusText);
            }
        }
        //xmlhttp.onreadystatechange=state_Change();
    }else{
        alert("Your browser does not support XMLHTTP.");
    }
}

//店铺全选
function checkPro(obj){
    var oldIsChecked = $(obj).hasClass("cur");
    if(oldIsChecked == false){
        $(obj).addClass("cur");
    }else{
        $(obj).removeClass("cur");
    }
    var isChecked = $(obj).hasClass("cur");
    //把勾选的商品updateSelectCartItems
    var selectItems = [];
    var carttype=$(obj).attr("carttype");
    $(obj).parents(".order").find(".updateSelect").each(function(){
        if(oldIsChecked == false){
            $(this).addClass("cur");
        }else{
            $(this).removeClass("cur");
        }
        /* $(this).attr("checked",isChecked);*/
        var itemKey = $(this).attr("itemKey");
        var orgid = $(this).attr("orgid");
        selectItems.push(itemKey + ':'+orgid);
    });
    updateSelectCartItems(selectItems,carttype,isChecked);
}

//单品选择
function updateSelect(obj){
    var updateSelectList = $(obj).parents(".order").find(".updateSelect");
    var checkPro = $(obj).parents(".order").find(".checkPro");
    var oldIsChecked = $(obj).hasClass("cur");
    if(oldIsChecked == false){
        $(obj).addClass("cur");
    }else{
        $(obj).removeClass("cur");
    }
    var isSelected = $(obj).hasClass("cur");
    var isCheckedNum = 0;
    //循环判断商家的商品中有已选中
    for(var i = 0; i < updateSelectList.length; i++){
        if($(updateSelectList[i]).hasClass("cur")){
            isCheckedNum += 1;
        }
    }
    if(updateSelectList.length == isCheckedNum){
        $(checkPro).addClass("cur");
    }else{
        $(checkPro).removeClass("cur");
    }

    var itemKey=$(obj).attr("itemKey");
    var carttype=$(obj).attr("carttype");
    var orgId=$(obj).attr("orgid");
    $.ajax({
        url:webPath.webRoot+"/cart/updateSelectItem.json",
        data:{itemKey:itemKey,type:carttype,isSelected:isSelected,orgId:orgId},
        dataType: "json",
        success:function(data) {
            //setTimeout(function(){
            //    var isCod = getUrlParamValue("isCod");
            //    var carttype = getUrlParamValue("carttype");
            //    var handler = getUrlParamValue("handler");
            //    var url = webPath.webRoot+"/wap/shoppingcart/cart.ac?";
                //if(isCod == ""){
                //    url = url+"isCod="+isCod;
                //}
                //if(carttype !=""){
                //    url = url+"&carttype="+carttype;
                //}
                //if(handler !=""){
                //    url = url+"&handler="+handler;
                //}
                //window.location.href=url+"&rd="+Math.random();
            //},1);
            cart();
            if(!data.isCod){
                $(".isCod").attr("checked",false)
            }

        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    })

}


//数量改变
function cartNum(obj){
    var obj = $(obj);
    var value= $(obj).val();
    var reg=new RegExp("^[1-9]\\d*$");
    if(!reg.test(value)){
        cart();
        return;
    }
    var itemKey=$(obj).attr("itemKey");
    var carttype=$(obj).attr("carttype");
    var handler=$(obj).attr("handler");
    var orgId=$(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    if(value==0){
        return;
    }
    $.ajax({
        url:webPath.webRoot+"/cart/update.json",
        data:{quantity:value,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId,productId:productId},
        dataType: "json",
        success:function(data) {
            if(data.success == "false"){
                alert(data.cartAlertMsg);
                obj.val(data.currentNum);
                return;
            }
            //setTimeout(function(){
            //    window.location.reload();
            //},1);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    alert(errorMsg);
                }
                //setTimeout(function(){
                //    window.location.reload();
                //},1);
                cart();
            }
        }
    })

}


//删除商品
function delItem(obj){
    var itemKey=$(obj).attr("itemKey");
    var carttype=$(obj).attr("carttype");
    var handler=$(obj).attr("handler");
    var orgId=$(obj).attr("orgid");
    $.ajax({
        url:webPath.webRoot+"/cart/remove.json",
        data:{type:carttype,itemKey:itemKey,handler:handler,orgId:orgId},
        dataType: "json",
        success:function(data) {
            //setTimeout(function(){
            //    window.location.reload();
            //},1);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    });

}


//减去数量
function subNum(obj){
    var object=$(obj);
    var value= $(obj).parent().find("input").val();
    var itemKey=$(obj).attr("itemKey");
    var carttype=$(obj).attr("carttype");
    var handler=$(obj).attr("handler");
    var orgId=$(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    var num=parseInt(value)-1;
    if(num==0){
        return;
    }
    //object.prev().prev("input").val(num);
    $.ajax({
        url:webPath.webRoot+"/cart/update.json",
        data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId,productId:productId},
        dataType: "json",
        success:function(data) {
            if(data.success == false){
                alert(data.cartAlertMsg);
                object.prev().prev("input").val(data.currentNum);
            }
            //setTimeout(function(){
            //    window.location.reload();
            //},1);

            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    alert(errorMsg);
                }
            }
        }
    })
}


//增加数量
function addNum(obj){
    var object=$(obj);
    var value= $(obj).parent().find("input").val();
    var num=parseInt(value)+1;
    var itemKey=$(obj).attr("itemKey");
    var carttype=$(obj).attr("carttype");
    var handler=$(obj).attr("handler");
    var orgId=$(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    $.ajax({
        url:webPath.webRoot+"/cart/update.json",
        data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId,productId:productId},
        dataType: "json",
        async: false,
        success:function(data) {
            if(data.success == "true"){
                object.prev("input").val(num);
            }else{
                alert(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
            }
            /*     object.prev("input").val(num);*/
            //setTimeout(function(){
            //    window.location.reload();
            //},1);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    alert(errorMsg);
                }
            }
        }
    })
}


//清除购物车
function clearcart(obj){
    var carttype=$(obj).attr("carttype");

    $.ajax({
        url:webPath.webRoot+"/cart/clear.json",
        data:{type:carttype},
        dataType: "json",
        success:function(data) {
            //setTimeout(function(){
            //    window.location.reload();
            //},1);

            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    })
}


//全选
function selectAll(obj){
    //去掉货到付款
    $(".isCod").attr("checked",false);
    var selectItems = [];
    var carttype=$(obj).attr("carttype");
    if($(obj).attr("checked") == undefined){//去掉全选
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
}

//清楚商家够物车
function clearShop(obj){
    var carttype=$(obj).attr("carttype");
    var handler=$(obj).attr("handler");
    var orgId=$(obj).attr("orgid");
    $.ajax({
        url:webPath.webRoot+"/cart/clearShop.json",
        data:{type:carttype,handler:handler,orgId:orgId},
        dataType: "json",
        cache: false,
        success:function(data) {
            //setTimeout(function(){
            //    window.location.reload();
            //},1);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    });
}

//使用货到付款
function isCod(obj){
    var object = $(obj);
    /*        var isSelected=false;
     if($(this).attr("checked")){
     isSelected=true;
     }*/
    var oldIsChecked = object.hasClass("cur");
    if(oldIsChecked == false){
        object.addClass("cur");
    }else{
        object.removeClass("cur");
    }
    var isSelected = object.hasClass("cur");
    var carttype=object.attr("carttype");
    var handler=object.attr("handler");
    $.ajax({
        url:webPath.webRoot+"/cart/checkIsCodItems.json",
        data:{type:carttype,isSelected:isSelected},
        dataType: "json",
        success:function(data) {
            /*if(isSelected){
             window.location.href=webPath.webRoot+"/wap/shoppingcart/cart.ac?isCod=Y&carttype="+carttype+"&handler="+handler+"&rd="+Math.random();
             } else{
             window.location.href=webPath.webRoot+"/wap/shoppingcart/cart.ac?carttype="+carttype+"&handler="+handler+"&rd="+Math.random();
             }*/
            if(isSelected){
                if(data.success == "false"){
                    $(".isCod").removeClass("cur");
                    alert("您选中的商品项有部分不支持货到付款");

                }else{
                    window.location.href = webPath.webRoot + "/wap/shoppingcart/cart.ac?isCod=Y&carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                }
            }else{
                window.location.href = webPath.webRoot + "/wap/shoppingcart/cart.ac?carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
            }

        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    alert(result.errorObject.errorText);
                }
            }
        }
    });


}