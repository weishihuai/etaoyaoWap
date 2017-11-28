
$(document).ready(function () {
    var selectItemNum = 0;
    $(".updateSelect").each(function(){
        if($(this).attr("data-checked") =="true"){
            selectItemNum += 1;
        }
    });
    if($(".updateSelect").length == selectItemNum){
        $(".selectAll").attr("data-checked","true");
    }


    $(".checkPro").each(function(){
        var oldSelect = "true";
        $(this).parents(".order").find(".updateSelect").each(function () {
            var select = $(this).attr("data-checked");
            if(select == "false"){
                oldSelect = "false";
            }
        });
        $(this).attr("data-checked",oldSelect);
    });




    /* 去结算 悬浮状态切换 */
    var box = $(".sc-clearing-box");
    var box_top = box.offset().top;
    var window_h = $(window).height() - box.height();

    if ($(document).scrollTop() + window_h < box_top ) {
        box.addClass("sc-clearing-fixed");
    }

    $(window).scroll(function(){
        var TOP = $(document).scrollTop() + window_h;

        if (TOP >= box_top) {
            box.removeClass("sc-clearing-fixed");
        }
        else {
            box.addClass("sc-clearing-fixed");
        }
    });


    //关注商品
    $(".oneCollect").click(function () {
        var $Arr = [];
        var handler = $(this).attr("handler");
        var itemKey = $(this).attr("itemKey");
        var handlerAndItemKey = handler+"_"+itemKey;
        $Arr[0] = handlerAndItemKey;

        addCollectionAll($Arr);
    });

    //批量关注商品
    $(".allCollect").click(function () {
        var $Arr = [];
        var selectItemNum = 0;
        $(".updateSelect").each(function(){
            if($(this).attr("data-checked") =="true"){
                var handler = $(this).attr("handler");
                var itemKey = $(this).attr("itemKey");
                var handlerAndItemKey = handler+"_"+itemKey;
                $Arr[selectItemNum] = handlerAndItemKey;
                selectItemNum += 1;
            }
        });
        addCollectionAll($Arr);
    });

    /*店铺全选*/
    $(".checkPro").click(function () {
        checkPro(this);
    });

    $(".addNum").click(function () {
        addNum(this);
    });

    $(".cartNum").change(function () {
        cartNum(this);
    });

    $(".updateSelect").click(function () {
        updateSelect(this);
    });

    $(".subNum").click(function () {
        subNum(this);
    });

    $(".delItem").click(function () {
        delItem(this);

    });


    //批量删除
    $(".delSelectedCart").click(function () {

        var selectNum = 0;
        var selectList = $(".updateSelect");
        selectList.each(function () {
            if ($(this).attr("data-checked") =="true") {
                selectNum += 1;
            }
        });
        var carttype = $(".delSelectedCart").attr("carttype");
        //判断是否有商品被选中
        if (selectNum > 0) {
            var dialog = jDialog.confirm("确定要删选中的宝贝吗?", {
                type: 'highlight',
                text: "删除",
                handler: function (button, dialog) {
                    $.ajax({
                        url: webPath.webRoot + "/cart/delSelectedItem.json",
                        data: {type: carttype},
                        dataType: "json",
                        success: function (data) {
                            if (data.success != 'false') {
                                dialog.close();
                                cart();
                            } else {
                                return false;
                            }
                        },
                        error: function (XMLHttpRequest, textStatus) {
                            if (XMLHttpRequest.status == 500) {
                                var result = eval("(" + XMLHttpRequest.responseText + ")");
                                alertDialog(result.errorObject.errorText);
                            }
                        }
                    });
                }
            }, {
                type: 'normal',
                text: '取消',
                handler: function (button, dialog) {
                    dialog.close();
                }
            });
        } else {
            var dialog = jDialog.alert('请先选择商品!', {
                type: 'highlight',
                text: '确定',
                handler: function (button, dialog) {
                    dialog.close();
                }
            });
        }
    });


    /*全选*/
    $(".selectAll").click(function () {
        selectAll(this);
    });

    //结算时，商品有效性判断
    $("#addCartResult").click(function () {
        addCartResultClick(this);
    });

    $(".qq-service").on("mouseenter",function(){
        $(this).siblings(".service-box").css("display","block");
    });
    $(".qq-service-area").on("mouseleave",function(){
        $(this).children(".service-box").css("display","none");
    });

});

var updateSelectCartItems = function (itemKeys, carttype, isSelected) {//多个商品keys
    if (itemKeys == undefined) {
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
                alertDialog(result.errorObject.errorText);
            }
        }
    })
};

//加入购物车
function addCartResultClick(object){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function () {
        if ($(this).attr("data-checked") =="true") {
            selectNum += 1;
        }
    });

    if (selectNum == 0) {
        jDialog.alert("请选择商品");
        return false;
    }
    if(webPath.carttype =='drug'){
        window.location.href = webPath.webRoot+"/shoppingcart/drugOrderadd.ac?carttype=" + webPath.carttype + "&handler=" + webPath.handler + "&t="+new Date().getTime()
    }else{
        window.location.href = webPath.webRoot+"/shoppingcart/orderadd.ac?carttype=" + webPath.carttype + "&handler=" + webPath.handler + "&t="+new Date().getTime()
    }
}


//购物车全选
function selectAll(obj){
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
        url: webPath.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            cart();
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
    $(obj).parents(".order").find(".updateSelect").each(function () {
        $(this).attr("data-checked", isChecked);
        var itemKey = $(this).attr("itemKey");
        var orgid = $(this).attr("orgid");
        selectItems.push(itemKey + ':' + orgid);
    });
    updateSelectCartItems(selectItems, carttype, isChecked);
}

//收藏全部
function addCollectionAll($Arr){
    var $Arr = $Arr;
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/cart/allCollectionProduct.json",
        data:{items:$Arr.join(","),cartType:webPath.carttype},
        dataType:"json",
        success:function(data){
            if (data.success == "true") {
                cart();
            }else{
                jDialog.alert("移入关注失败,请刷新重新操作!");
            }
        }
    });
}

//加数量
function addNum(obj){
    var object = $(obj);
    var value = $(obj).prev().prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                jDialog.alert(data.cartAlertMsg);
            }
            cart()
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
    var value = $(obj).next("input").val();
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
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                jDialog.alert(data.cartAlertMsg);
            }
            cart();
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

//修改数量
function cartNum(obj){
    var obj = $(obj);
    var value = $(obj).val();
    var reg = new RegExp("^[1-9]\\d*$");
    if (!reg.test(value)) {
        cart();
        return;
    }
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    var productId = $(obj).attr("productId");
    if (0 >= value) {
        return;
    }
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                jDialog.alert(data.cartAlertMsg);
            }
            cart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                var errorMsg = result.errorObject.errorText;
                alertDialog(errorMsg);
                cart();
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
                url: webPath.webRoot + "/cart/remove.json",
                data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
                dataType: "json",
                success: function (data) {
                    delDialog.close();
                    cart();
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

var xmlhttp;
var url =webPath.webRoot + "/shoppingcart/cartMainPanel.ac";
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
                alertDialog("Problem retrieving XML data" + xmlhttp.statusText);
            }
        }
        //xmlhttp.onreadystatechange=state_Change();
    }else{
        alertDialog("Your browser does not support XMLHTTP.");
    }
}
