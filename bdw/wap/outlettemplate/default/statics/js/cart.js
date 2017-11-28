$(function () {

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


    $(".collect").live("click",function(){
        if($(".hasSelected").attr("hasSelected") == 0){
            showMessage("请先选择商品!");
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
                    showMessage("已将选中商品移入收藏夹！");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    showMessage("服务器繁忙，请稍候再试！");
                }
            }
        });
    });


    $(".delete").live("click",function(){
        if($(".hasSelected").attr("hasSelected") == 0){
            showMessage("请先选择商品!");
            return;
        }
        $(".del-product-layer").show();
        $(".del-product-box .content").html('确定删除选中的'+$(".hasSelected").attr("hasSelected")+'件商品');
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

    $(".del-cancel").live("click",function(){
        $(".del-product-layer").hide();
    });

    $(".message-btn").live("click",function(){
        $(".message-product-layer").hide();
    });

    $(".del-product").live("click",function(){
        delProduct();
    });

    showCurrentShopNmDiv();
});

function delProduct(){
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
                showMessage("服务器繁忙，请稍候再试！");
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
                showMessage("服务器繁忙，请稍候再试！");
                object.prev().prev("input").val(data.currentNum);
            }
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    showMessage(errorMsg);
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
                showMessage(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
            }
            cart();
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    showMessage(errorMsg);
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
                showMessage(data.cartAlertMsg);
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
                    showMessage(errorMsg);
                }
                cart();
            }
        }
    })

}



//购物车单选
function updateSelect(obj){
    var oldIsChecked = $(obj).hasClass("checkbox-active");
    if(oldIsChecked == false){
        $(obj).addClass("checkbox-active");
    }else{
        $(obj).removeClass("checkbox-active");
    }
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    var isSelected = $(obj).hasClass("checkbox-active");
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            cart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if(result.errorObject.errorText !=null){
                    showMessage("服务器繁忙，请稍候再试！");
                }
            }
        }
    })
}


//全选
function selectAllPro(obj){
    var selectItems = [];
    var carttype=$(obj).attr("carttype");
    if($(obj).hasClass("checkbox-active")){
        $(".selectAll").removeClass("checkbox-active");
        $(".checkPro").each(function(){
            $(obj).attr("checked",false);
        });
        $(".updateSelect").each(function(){
            $(this).attr("checked",false);
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':'+orgid);
        });
        updateSelectCartItems(selectItems,carttype,false);
    }else{
        $(".selectAll").addClass("checkbox-active");
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


//店铺全选
function checkPro(obj){
    var oldIsChecked = $(obj).hasClass("checkbox-active");
    if(oldIsChecked == false){
        $(obj).addClass("checkbox-active");
    }else{
        $(obj).removeClass("checkbox-active");
    }
    var isChecked = $(obj).hasClass("checkbox-active");
    //把勾选的商品updateSelectCartItems
    var selectItems = [];
    var carttype=$(obj).attr("carttype");
    $(obj).parents(".order").find(".updateSelect").each(function(){
        if(oldIsChecked == false){
            $(this).addClass("checkbox-active");
        }else{
            $(this).removeClass("checkbox-active");
        }
        var itemKey = $(this).attr("itemKey");
        var orgid = $(this).attr("orgid");
        selectItems.push(itemKey + ':'+orgid);
    });
    updateSelectCartItems(selectItems,carttype,isChecked);
}



var updateSelectCartItems = function (itemKeys, carttype, isSelected) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    if(itemKeys.length <= 0){
        cart();
        return false;
    }
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            cart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                if(errorMsg !=null){
                    showMessage(errorMsg);
                }
            }
        }
    })
};


//加入购物车
/*function addCartResultClick(object){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function(){
        if(!$(this).hasClass("checkbox-active")){
            selectNum += 1;
        }
    });
    if(selectList.length == selectNum){
        showMessage("您没有选择任意一件商品！");
        return;
    }

    $.ajax({
        url: webPath.webRoot + "/cart/checkToAddOrder.json",
        data: {type: webPath.carttype},
        dataType: "json",
        success: function (data) {
            if(data.success == 'false'){
                showMessage("您购物车中的"+data.cartItemMsg);
            }else{
                window.location.href = webPath.webRoot + "/wap/shoppingcart/orderadd.ac?carttype="+ webPath.carttype+"&handler="+ webPath.handler;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showMessage("服务器繁忙，请稍候再试！");
            }
        }
    });
}*/

function cart(){
    $.ajax({
        url:webPath.webRoot+'/wap/outlettemplate/default/shoppingcart/cartMainPanel.ac?handler=' + webPath.handler + '&carttype=' + webPath.carttype + '&timeStamp=' + new Date().getTime(),
        success:function(data){
            if($(".editDiv").hasClass("show")){
                $(".cart-main").html(data);
                $(".editDiv").removeClass("hide");
                $(".editDiv").addClass("show");
                $(".priceDiv").removeClass("show");
                $(".priceDiv").addClass("hide");
            }
            else{
                $(".cart-main").html(data);
                $(".editDiv").removeClass("show");
                $(".editDiv").addClass("hide");
                $(".priceDiv").removeClass("hide");
                $(".priceDiv").addClass("show");
            }
            showCurrentShopNmDiv();
        },
        error:function() {
            window.location.href = webPath.webRoot + "wap/outlettemplate/default/shoppingcart/cart.ac?time=" + new Date().getTime();
        }
    });
}

$(window).scroll(showCurrentShopNmDiv);

//页面滑动 固定显示店铺名称
function showCurrentShopNmDiv(){
    var sTop = $(window).scrollTop();
    var scInner = $(".cart").find(".dt-inner");
    for (var i = 0; i < scInner.length; i++) {
        // var dtInner = scInner[i];
        if(sTop+$(".m-top").height() >= $(scInner[i]).offset().top){
            $(".cart").find(".dt-inner").removeClass("dt-inner-fixed");
            $(scInner[i]).addClass("dt-inner-fixed");
        }
    }
}

//显示消息窗口
function showMessage(obj){
    $(".message-product-layer").show();
    $(".message-product-layer .title").text(obj);
}
