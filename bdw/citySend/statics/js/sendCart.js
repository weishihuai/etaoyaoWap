$(function () {

    /*------------所有门店的购物车操作-----------------start*/

    //cartItem勾选
    $(".updateSelect").live("click",function () {
        updateSelect(this);
    });

    //数量增加
    $(".addNum").live("click",function () {
        addNum(this);
    });

    //填写数量
    $(".cartNum").live("change",function () {
        cartNum(this);
    });

    //填写减少
    $(".subNum").live("click",function () {
        subNum(this);
    });

    //多门店购物车的结算事件
    $(".addCartResult").live("click",function(){
        var orgid = $(this).attr('orgid');
        addCartResultClick("0", this, orgid);
    });


    /*------------所有门店的购物车操作-----------------end*/

    /*------------单门店的购物车操作-----------------start*/

    //$("#storeCartLayer").live("click",function () {
    //    var userId = Top_Path.userId;
    //    var orgid = $(this).attr("orgid");
    //    if(undefined == userId || null == userId || "" == userId) {
    //        loadStoreHideCart(orgid);
    //        showUserLogin();
    //    }
    //});

    //全选
    $("#allSelect").live("click",function(){
        var selectItems = [];
        var carttype = $(this).attr("carttype");
        var sysOrgId = $(this).attr("orgid");
        if($(this).hasClass("active")){//去掉全选
            $(".supdateSelect").each(function () {
                var itemKey = $(this).attr("itemKey");
                var orgid = $(this).attr("orgid");
                if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                    selectItems.push(itemKey + ':' + orgid);
                }

            });
            if(selectItems.length<=0){
                return;
            }
            updateSingleStoreSelectCartItems(selectItems, carttype, false, sysOrgId);
        }else{
            //全选
            $(".supdateSelect").each(function () {
                var itemKey = $(this).attr("itemKey");
                var orgid = $(this).attr("orgid");
                if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                    selectItems.push(itemKey + ':' + orgid);
                }
            });
            if(selectItems.length<=0){
                return;
            }
            updateSingleStoreSelectCartItems(selectItems, carttype, true,sysOrgId);
        }

    });

    //cartItem勾选
    $(".supdateSelect").live("click",function () {
        updateStoreSelect(this);
    });

    //数量增加
    $(".saddNum").live("click",function () {
        addStoreNum(this);
    });

    //填写数量
    $(".scartNum").live("change",function () {
        cartStoreNum(this);
    });

    //数量减少
    $(".ssubNum").live("click",function () {
        subStoreNum(this);
    });


    //单门店购物车中的结算事件
    $(".addStoreCartResult").live("click",function(){
        var orgid = $(this).attr('orgid');
        addCartResultClick("1", this, orgid);
    });

    /*------------单门店的购物车操作-----------------end*/
});


/*------------所有门店的购物车操作-----------------start*/
//店铺全选
function selectAll(obj,orgid){
    var selectItems = [];
    var carttype = $(obj).attr("carttype");
    if($(obj).hasClass("active")){//去掉全选
        $(".sitem"+orgid).each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                selectItems.push(itemKey + ':' + orgid);
            }
        });
        if(selectItems.length <=0){
            return;
        }
        updateSelectCartItems(selectItems, carttype, false);
    }else{
        //全选
        $(".sitem"+orgid).each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                selectItems.push(itemKey + ':' + orgid);
            }
        });
        if(selectItems.length <=0){
            return;
        }
        updateSelectCartItems(selectItems, carttype, true);
    }
}

function updateSelect(obj){
    var isSelected = true;
    var updateSelectList = $(obj).parents(".shop").find(".updateSelect");
    if (!$(obj).hasClass("active")) {
        isSelected = true;
    } else {
        isSelected = false;
        var updateSelectNum = 0;
        updateSelectList.each(function () {
            if ($(this).hasClass("active")) {
                updateSelectNum += 1;
            }
        });
    }

    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            loadShowCart();
            //暂时没有货到付款
            //if (!data.isCod) {
            //    $(".isCod").attr("checked", false)
            //}
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);

            }
        }
    })
}


function updateStoreSelect(obj){
    var isSelected = true;
    var updateSelectList = $(obj).parents(".shop").find(".supdateSelect");
    if (!$(obj).hasClass("active")) {
        isSelected = true;
    } else {
        isSelected = false;
        var updateSelectNum = 0;
        updateSelectList.each(function () {
            if ($(this).hasClass("active")) {
                updateSelectNum += 1;
            }
        });
    }

    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
            //暂时没有货到付款
            //if (!data.isCod) {
            //    $(".isCod").attr("checked", false)
            //}
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText,2000);

            }
        }
    })
}


/*购物车数量操作*/

/*多个门店的购物车-数量增加*/
function addNum(obj){
    var object = $(obj);
    var value = object.prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "true"){
                //object.prev("input").val(num);
            }else{
                oneConformBtnDialog(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
            }
            loadShowCart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                oneConformBtnDialog(errorMsg);
            }
        }
    })
}

/*单个门店的购物车-数量增加*/
function addStoreNum(obj){
    var object = $(obj);
    var value = object.prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "true"){
                //object.prev("input").val(num);
            }else{
                oneConformBtnDialog(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                oneConformBtnDialog(errorMsg);
            }
        }
    })
}

/*多个门店的购物车-数量减少*/
function subNum(obj){
    var object = $(obj);
    var value = object.next("input").val();
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    var productId = object.attr("productId");
    var num = parseInt(value) - 1;
    if (num == 0) {
        return;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == false){
                oneConformBtnDialog(data.cartAlertMsg);
                object.next("input").val(data.currentNum);
            }
            loadShowCart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);
            }
        }
    })
}

/*单个门店的购物车-数量减少*/
function subStoreNum(obj){
    var object = $(obj);
    var value = object.next("input").val();
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    var productId = object.attr("productId");
    var num = parseInt(value) - 1;
    if (num == 0) {
        return;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == false){
                oneConformBtnDialog(data.cartAlertMsg);
                object.next("input").val(data.currentNum);
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);
            }
        }
    })
}

/*多个门店的购物车-数量改变*/
function cartNum(obj){
    var obj = $(obj);
    var value = obj.val();
    var reg = new RegExp("^[1-9]\\d*$");
    if (!reg.test(value)) {
        loadShowCart();
        return;
    }
    var itemKey = obj.attr("itemKey");
    var carttype = obj.attr("carttype");
    var handler = obj.attr("handler");
    var orgId = obj.attr("orgid");
    var productId = obj.attr("productId");
    if (0 >= value) {
        return;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                oneConformBtnDialog(data.cartAlertMsg);
                obj.val(data.currentNum);
                //return;
            }
            loadShowCart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                oneConformBtnDialog(errorMsg);
                loadShowCart();
            }
        }
    })
}


/*单个门店的购物车-数量改变*/
function cartStoreNum(obj){
    var obj = $(obj);
    var itemKey = obj.attr("itemKey");
    var carttype = obj.attr("carttype");
    var handler = obj.attr("handler");
    var orgId = obj.attr("orgid");
    var productId = obj.attr("productId");
    var value = obj.val();
    var reg = new RegExp("^[1-9]\\d*$");
    if (!reg.test(value)) {
        loadStoreShowCart(orgId);
        return;
    }
    if (0 >= value) {
        return;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                breadAlertJDialog(data.cartAlertMsg,2000,"20px",true);
                obj.val(data.currentNum);
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                oneConformBtnDialog(errorMsg);
                loadStoreShowCart(orgId);
            }
        }
    })
}

//删除商品
function delItem(obj){
    var listDialog = jDialog.confirm("确定要删除该宝贝吗?",{
        type : 'highlight',
        text : "删除",
        handler : function(button,listDialog) {
            var itemKey = $(obj).attr("itemKey");
            var carttype = $(obj).attr("carttype");
            var handler = $(obj).attr("handler");
            var orgId = $(obj).attr("orgid");
            $.ajax({
                url: Top_Path.webRoot + "/cart/remove.json",
                data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
                dataType: "json",
                success: function (data) {
                    listDialog.close();
                    loadShowCart();
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        oneConformBtnDialog(result.errorObject.errorText);
                    }
                }
            });

        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });

}

/*门店首页中的购物车删除操作*/
function delStoreIndexCartItem(obj){
    var storeDialog = jDialog.confirm("确定要删除该宝贝吗?",{
        type : 'highlight',
        text : "删除",
        handler : function(button,storeDialog) {
            var itemKey = $(obj).attr("itemKey");
            var carttype = $(obj).attr("carttype");
            var handler = $(obj).attr("handler");
            var orgId = $(obj).attr("orgid");
            $.ajax({
                url: Top_Path.webRoot + "/cart/remove.json",
                data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
                dataType: "json",
                success: function (data) {
                    storeDialog.close();
                    loadStoreShowCart(orgId);
                    //breadAlertJDialog("删除成功",1000,"10px",true);
                },
                error: function (XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        oneConformBtnDialog(result.errorObject.errorText);
                    }
                }
            });

        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });

}

//删除选中的订单项
function delSelectedItem(obj) {
    var carttype = $(obj).attr("carttype");
    var orgIdAttr = $(obj).attr("orgid");
    var itemList = $(".item" + orgIdAttr);
    var hasSelected = 0;
    itemList.each(function(){
        if($(this).hasClass("active")){
            hasSelected+=1;
        }
    });
    //判断是否有商品被选中
    if(hasSelected > 0){
        var dialog = jDialog.confirm("确定要删选中的宝贝吗?",{
            type : 'highlight',
            text : "删除",
            handler : function(button,dialog) {
                $.ajax({
                    url: Top_Path.webRoot + "/cart/dropSelectedItem.json",
                    data: {type: carttype,orgId:orgIdAttr},
                    dataType: "json",
                    success: function (data) {
                        if(data.success != 'false'){
                            dialog.close();
                           loadShowCart();
                        }else{
                            return false;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            oneConformBtnDialog(result.errorObject.errorText);
                        }
                    }
                });
            }
        },{
            type : 'normal',
            text : '取消',
            handler : function(button,dialog) {
                dialog.close();
            }
        });
    }else{
        var dialog = jDialog.alert('请先选择商品!',{
            type : 'highlight',
            text : '确定',
            handler : function(button,dialog) {
                dialog.close();
            }
        });
    }

}

// 单个购物车删除选中的订单项
function deleSelectedItemInOneMerchant(obj){
    var carttype = $(obj).attr("carttype");
    var orgIdAttr = $(obj).attr("orgid");
    var itemList = $(".sitem" + orgIdAttr);
    var hasSelected = 0;
    itemList.each(function(){
        if($(this).hasClass("active")){
            hasSelected += 1;
        }
    });
    //判断是否有商品被选中
    if(hasSelected > 0){
        var dialog = jDialog.confirm("确定要删选中的宝贝吗?",{
            type : 'highlight',
            text : "删除",
            handler : function(button,dialog) {
                $.ajax({
                    url: Top_Path.webRoot + "/cart/dropSelectedItem.json",
                    data: {type: carttype,orgId:orgIdAttr},
                    dataType: "json",
                    success: function (data) {
                        if(data.success != 'false'){
                            dialog.close();
                            loadStoreShowCart(orgIdAttr);
                        }else{
                            return false;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            oneConformBtnDialog(result.errorObject.errorText);
                        }
                    }
                });
            }
        },{
            type : 'normal',
            text : '取消',
            handler : function(button,dialog) {
                dialog.close();
            }
        });
    }else{
        var dialog = jDialog.alert('请先选择商品!',{
            type : 'highlight',
            text : '确定',
            handler : function(button,dialog) {
                dialog.close();
            }
        });
    }
}

function loadShowCart(){
    $("#oldCart").load(Top_Path.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam},function(){
        $("#cartLayer").css("right", "1260px");
        $("#allStoreCart").css("display","block");
        $("#cartContent").css("right", "0");
    });
}

function loadStoreShowCart(orgId){
    $("#storeCart").load(Top_Path.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam,orgId:orgId},function(){
        $("#storeCartLayer").css("right", "290px");
        $("#singleStoreCart").css("display","block");
    });
}

function loadHideCart(){
    $("#oldCart").load(Top_Path.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam},function(){
        $("#cartLayer").css("right", "0px");
        $("#allStoreCart").css("display","none");
        $("#cartContent").css("right","-1260px");
    });
}

function loadStoreHideCart(orgId) {
    $("#storeCart").load(Top_Path.webRoot + "/template/bdw/citySend/ajaxload/mainCartLoad.jsp", {carttype: "store", p: Top_Path.topParam, orgId: orgId}, function () {
        $("#storeCartLayer").css("right", "50px");
        $("#singleStoreCart").css("display", "none");
    });
}

var updateSelectCartItems = function (itemKeys, carttype, isSelected) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            loadShowCart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);
            }
        }
    })
};


var updateSingleStoreSelectCartItems = function (itemKeys, carttype, isSelected,orgId) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    $.ajax({
        url: Top_Path.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);
            }
        }
    })
};

//加入购物车的结算判断,type表示是单门店的还是多门店的结算事件
function addCartResultClick(ctpye, object, orgid){
    var selectNum = 0;
    var selectList;
    var carttype='store';//一定是门店类型的商品
    var isCod='N';//2016-11-24 目前默认是不支持货到付款的

    if("0"==ctpye){
        selectList = $(".updateSelect");
    }

    if("1"==ctpye){
        selectList = $(".supdateSelect");
    }

    selectList.each(function () {
        if (!$(this).hasClass("active")) {
            selectNum += 1;
        }
    });

    if (selectList.length == selectNum) {
        breadAlertJDialog("请选择商品",1200,"10px",true);
        return;
    }

    if(undefined == isCod || '' == isCod){
        isCod = 'N';
    }

    $.ajax({
        url: Top_Path.webRoot + "/cart/checkShopOrder.json",
        data: {type: carttype,orgId:orgid},
        dataType: "json",
        success: function (data) {
            if(data.success == 'false'){
                breadAlertJDialog("您选择的商品有错误，请重新选择!",1200,"10px",true);
                if("0"==ctpye){
                   loadShowCart();
                }
                if("1"==ctpye){
                    loadStoreShowCart(orgid);
                }
                return false;
            }else{
                window.location.href = Top_Path.webRoot + "/citySend/addOrder.ac?carttype=store&orgId="+orgid+"&isCod="+isCod;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                oneConformBtnDialog(result.errorObject.errorText);
            }
        }
    });
}




//没有标题和按钮的提示框
function breadAlertJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}


//登录提示框
function showUserLogin(){
    var dialog = jDialog.confirm('您还没有登录',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = Top_Path.webRoot + "/login.ac";
        }
    },{
        type : 'normal',
        text : '取消',
        handler : function(button,dialog) {
            dialog.close();
        }
    });
    return dialog;
}

//最普通最常用的alert对话框，默认携带一个确认按钮
var oneConformBtnDialog = function(dialogTxt){
    var dialog = jDialog.alert(dialogTxt);
};




