
$(document).ready(function () {


    $(".checkPro").each(function(){
        var oldSelect = "true";
        $(this).parent().parent().parent().find(".updateSelect").each(function () {
            var select = $(this).attr("data-checked");
            if(select == "false"){
                oldSelect = "false";
            }
        });
        $(this).attr("data-checked",oldSelect);
    });


    $(".subNum").click(function () {
        subNum(this);
    });

});

var updateSelectCartItems = function (itemKeys, carttype, isSelected) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            cart(carttype);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alertDialog(result.errorObject.errorText);
            }
        }
    })
};

//加入购物车
function addCartResultClick(object){
    var selectNum = 0;

    var selectList = $(object).parent().parent().find(".updateSelect");
    selectList.each(function () {
        if ($(this).attr("data-checked") =="true") {
            selectNum += 1;
        }
    });

    if (selectNum == 0) {
        jDialog.alert("请选择商品");
        return false;
    }
    if( $(object).attr("carttype") =='drug'){
        window.location.href = Top_Path.webRoot+"/shoppingcart/drugOrderadd.ac?carttype=drug&handler=drug&t="+new Date().getTime()
    }else{
        window.location.href = Top_Path.webRoot+"/shoppingcart/orderadd.ac?carttype=normal&handler=sku&t="+new Date().getTime()
    }
}


//购物车全选
function selectAllCart(obj){
    var selectItems = [];
    var carttype = $(obj).attr("carttype");
    if ($(obj).attr("data-checked") == "false") {//去掉全选
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        updateSelectCartItems(selectItems, carttype, true);
    } else {                                     //全选商品
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        updateSelectCartItems(selectItems, carttype, false);
    }
}



//购物车单选
function updateSelect(obj){
    var isSelected = true;
    if ($(obj).attr("data-checked") == "true") {
        isSelected = false;
    } else {
        isSelected = true;
    }
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            cart(carttype);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alertDialog(result.errorObject.errorText);
            }
        }
    })
}


//店铺全选
function checkPro(obj){
    var isChecked = $(obj).attr("data-checked") == "true"?"false":"true";
    //把勾选的商品updateSelectCartItems
    var selectItems = [];
    var carttype = $(obj).attr("carttype");
    $(obj).parent().parent().parent().find(".updateSelect").each(function () {
        $(this).attr("data-checked", isChecked);
        var itemKey = $(this).attr("itemKey");
        var orgid = $(this).attr("orgid");
        selectItems.push(itemKey + ':' + orgid);
    });
    updateSelectCartItems(selectItems, carttype, isChecked);


/*    var selectItemNum = 0;
    $(obj).parents().find(".updateSelect").each(function(){
        if($(this).attr("data-checked") =="true"){
            selectItemNum += 1;
        }
    });
    if($(".updateSelect").length == selectItemNum){
        $(obj).parents().find(".selectAll").attr("data-checked","true");
    }*/

}

//收藏全部
function addCollectionAll($Arr){
    var $Arr = $Arr;
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:Top_Path.webRoot+"/cart/allCollectionProduct.json",
        data:{items:$Arr.join(","),cartType:webPath.carttype},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                cart(carttype);
            }else{
                jDialog.alert("移入关注失败,请刷新重新操作!");
            }
        }
    });
}

//加数量
function addNum(obj){
    var object = $(obj);
    var value = $(obj).parent().find("span").html();
    var num = parseInt(value) + 1;
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                jDialog.alert(data.cartAlertMsg);
            }
            cart(carttype)
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                alertDialog(errorMsg);
            }
        }
    })
}

//减数量
function subNum(obj){
    var object = $(obj);
    var value = $(obj).parent().find("span").html();
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    var num = parseInt(value) - 1;
    if (num == 0) {
        return;
    }
    //object.prev().prev("input").val(num);
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                jDialog.alert(data.cartAlertMsg);
            }
            cart(carttype);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                alertDialog(errorMsg);
            }
        }
    })
}


//删除商品
function delItem(obj){
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    var delDialog = jDialog.confirm("确定要删选中的宝贝吗?",{
        type : 'highlight',
        text : "删除",
        handler : function(button,delDialog) {
            $.ajax({
                url: Top_Path.webRoot + "/cart/remove.json",
                data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
                dataType: "json",
                success: function (data) {
                    delDialog.close();
                    cart(carttype);
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alertDialog(result.errorObject.errorText);
                    }
                }
            });
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            delDialog.close();
        }
    });
}




//===============购物车重构===================

function cart(carttype){
    if(carttype == "normal"){
        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
            $("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function(){cartBarReadyFn("#normalSidebar")})
        });
    }else {
        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
            loadRightCartSideBar();
        });
    }
    /*$("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac");*/
   /* if(carttype == "normal"){
        $("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function () {
            cartBarReadyFn("#normalSidebar");
        });
    }else {
        $("#drugSidebar").load(Top_Path.webRoot+"/ajaxload/drugCartSideBar.ac",function () {
            cartBarReadyFn("#drugSidebar");
        });
    }*/
   /* console.log($("#buycart-main").length)
    $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function(){
        var sidebar_dd_cart = $("#buycart-main").find(".dd");
        var sidebar_icon_lx_cart = $("#buycart-main").find(".icon-lx");
        sidebar_dd_cart.show();
        sidebar_icon_lx_cart.show();
        // $("#buycart-main").show();
    });*/

}


function setSidebarH(o) {
    var _h = 0;
  /*  alert($("#normalCartP").attr("class") );*/
    if($("#normalCartP").attr("class") == "active"){
        _h = o.scrollTop
        if(_h!=0){
            SetCookie("normalSidebar", _h)
        }
    }else{
        _h = o.scrollTop
        if(_h!=0){
            SetCookie("drugSidebar", _h)
        }
    }


}

function SetCookie(sName, sValue) {
    document.cookie = sName + "=" + escape(sValue) + "; ";
}
function GetCookie(sName) {

    var aCookie = document.cookie.split("; ");
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0])
            return unescape(aCrumb[1]);
    }
    return 0;
}