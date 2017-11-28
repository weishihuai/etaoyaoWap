$(function(){
    $(".edit").click(function(){
        if($(".editDiv").hasClass("hide")){
            $(".editDiv").removeClass("hide");
            $(".editDiv").addClass("show");
            $(".priceDiv").removeClass("show");
            $(".priceDiv").addClass("hide");
            $(".edit").html("取消");
        }
        else{
            $(".editDiv").removeClass("show");
            $(".editDiv").addClass("hide");
            $(".priceDiv").removeClass("hide");
            $(".priceDiv").addClass("show");
            $(".edit").html("编辑");
        }
    });

    $(".subNum").live("click",function(){
        subNum(this);
    });

    $(".addNum").live("click",function(){
        addNum(this);
    });

    $(".cartNum").live("change",function(){
       cartNum(this);
    });

    /*商品选中*/
    $(".updateSelect").live("touchend",function(){
       updateSelect(this);
    });

    /*货到付款选中*/
    $(".isCod").live("touchend",function(){
        isCod(this);
    });

    /*店铺选中*/
    $(".checkPro").live("touchend",function(){
        checkPro(this);
    });

    /*全选*/
    $(".selectAll").live("touchend",function(){
        //去掉货到付款
        $(".isCod").removeClass("cur");
        $("#wapAddCartResult").attr("isCod","N");
        var selectItems = [];
        var carttype=$(this).attr("carttype");
        if($(this).hasClass("cur")){
            //$(".selectAll").attr("checked",false);
            $(".selectAll").removeClass("cur");
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
        }else{
            //$(".selectAll").attr("checked",true);
            $(".selectAll").addClass("cur");
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

    //结算时，商品有效性判断
    $("#wapAddCartResult").live("click",function(){
        addCartResultClick(this);
    });

    $(".delete").live("click",function(){
        if($(".hasSelected").attr("hasSelected") == 0){
            xyPop("请先选择商品!", {type: "warning",title: false});
            return;
        }
        //这里显示时"确定"按钮在右边，"取消"按钮在左边，有点不习惯，可以去xyPop.js里面改，但是这个js文件已经被很多jsp调用，所以别乱改
        xyPop("确定删除选中的商品吗?", {type: "confirm",title: false,btn:["确定", "取消"],onOk: function(){
            var carttype=$(".delete").attr("carttype");
            $.ajax({
                url:webPath.webRoot+"/cart/removeSelected.json",
                data:{type:carttype},
                dataType: "json",
                async: false,   //在删除商品的时候最好别随便动页面，所以还是设成同步比较好
                success:function(data){
                    cart();
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        xyPop("服务器繁忙，请稍候再试！", {type: "error",title:false});
                    }
                }
            });
        }});
    });

    $(".collect").live("click",function(){
        if($(".hasSelected").attr("hasSelected") == 0){
            xyPop("请先选择商品!", {type: "warning",title: false});
            return;
        }
        var carttype=$(".collect").attr("carttype");
        $.ajax({
            url:webPath.webRoot+"/cart/collectSelected.json",
            data:{type:carttype},
            dataType: "json",
            async: false,
            success:function(data){
                if(data.errorCode == "errors.login.noexist")
                {
                    window.location.href = webPath.webRoot+"/wap/login.ac";

                }
                else{
                    xyPop("已将选中商品移入收藏夹！", {type: "success",title:false});
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    xyPop("服务器繁忙，请稍候再试！", {type: "error",title:false});
                }
            }
        });
    });

    $(".deleteInvalid").live("click",function(){
        var carttype=$(".deleteInvalid").attr("carttype");
        $.ajax({
            url:webPath.webRoot+"/cart/deleteInvalid.json",
            data:{type:carttype},
            dataType: "json",
            async: false,   //在删除商品的时候最好别随便动页面，所以还是设成同步比较好
            success:function(data){
                cart();
                //xyPop("成功移除失效商品！", {type: "success",title:false});
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    xyPop("服务器繁忙，请稍候再试！", {type: "error",title:false});
                }
            }
        });
    });
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
                $(".isCod").removeClass("cur");
                $("#wapAddCartResult").attr("isCod","N");
            }
            $("#allCartNum").text(data.allCartNum);
            $("#allObtainTotalIntegral").text(data.allObtainTotalIntegral);
            $("#allDiscount").text(data.allDiscount);
            $("#finalAmount").text(data.allProductTotalAmount);
            $("#allProductTotalAmount").text(data.totalPrice);
            $("#selectedCartNum").text(data.selectedCartNum);
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
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
        xyPop("您没有选择任意一件商品！",{type: "error",title: false});
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
        xyPop("您没有选择任意一件商品！",{type: "error",title: false});
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
                xyPop("您购物车中的" + data.cartItemMsg,{type: "error",title: false});
            }else{
                window.location.href = webPath.webRoot + "/wap/shoppingcart/orderadd.ac?carttype="+carttype+"&handler="+handler+"&isCod="+isCod;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
            }
        }
    });
}

function cart(){
    $.ajax({
        url:webPath.webRoot+'/wap/shoppingcart/cartMain.ac?time=' + new Date().getTime(),
        success:function(data){
            /*$(".m-cart").html(data);*/
            if($(".editDiv").hasClass("show")){
                $(".m-cart").html(data);
                $(".editDiv").removeClass("hide");
                $(".editDiv").addClass("show");
                $(".priceDiv").removeClass("show");
                $(".priceDiv").addClass("hide");
                //$(".edit").html("取消");
            }
            else{
                $(".m-cart").html(data);
                $(".editDiv").removeClass("show");
                $(".editDiv").addClass("hide");
                $(".priceDiv").removeClass("hide");
                $(".priceDiv").addClass("show");
                //$(".edit").html("编辑");
            }
        },
        error:function() {
            window.location.href = webPath.webRoot + "wap/shoppingcart/cart.ac?time=" + new Date().getTime();
        }
    });
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
            cart();
            if(!data.isCod){
                $(".isCod").attr("checked",false)
            }

        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
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
                xyPop(data.cartAlertMsg,{type: "error",title: false});
                obj.val(data.currentNum);
                return;
            }
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    xyPop(errorMsg,{type: "error",title: false});
                }
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
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
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
    $(obj).parent().find("input").val(num);
    $.ajax({
        url:webPath.webRoot+"/cart/update.json",
        data:{quantity:num,itemKey:itemKey,type:carttype,handler:handler,orgId:orgId,productId:productId},
        dataType: "json",
        success:function(data) {
            if(data.success == false){
                xyPop(data.cartAlertMsg,{type: "error",title: false});
                object.prev().prev("input").val(data.currentNum);
            }
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    xyPop(errorMsg,{type: "error",title: false});
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
                xyPop(data.cartAlertMsg,{type: "error",title: false});
                object.prev("input").val(data.currentNum);
            }
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    xyPop(errorMsg,{type: "error",title: false});
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
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
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
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
                }
            }
        }
    });
}

//使用货到付款
function isCod(obj){
    var object = $(obj);
    if(object.attr("enable") == "N"){
        $(".isCod").removeClass("cur");
        xyPop("请先选择商品再选择货到付款!", {type: "warning",title: false});
        return;
    }

    var oldIsChecked = object.hasClass("cur");
    if(oldIsChecked == false){
        object.addClass("cur");
        var isSelected = object.hasClass("cur");
        var carttype=object.attr("carttype");
        var handler=object.attr("handler");
        $.ajax({
            url:webPath.webRoot+"/cart/checkIsCodItems.json",
            data:{type:carttype,isSelected:isSelected},
            dataType: "json",
            success:function(data) {
                if(isSelected){
                    if(data.success == "false"){
                        $(".isCod").removeClass("cur");
                        $("#wapAddCartResult").attr("isCod","N");
                        xyPop("您选中的商品项有部分不支持货到付款", {type: "error",title: false});
                    }else{
                        //window.location.href = webPath.webRoot + "/wap/shoppingcart/cart.ac?isCod=Y&carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                        $(".isCod").addClass("cur");
                        $("#wapAddCartResult").attr("isCod","Y");
                    }
                }else{
                    window.location.href = webPath.webRoot + "/wap/shoppingcart/cart.ac?carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                }

            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    if(result.errorObject.errorText !=null){
                        xyPop("服务器繁忙，请稍候再试！",{type: "error",title: false});
                    }
                }
            }
        });
    }else{
        object.removeClass("cur");
        $(".isCod").removeClass("cur");
        $("#wapAddCartResult").attr("isCod","N");
    }
}