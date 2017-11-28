$(document).ready(function () {


    $(".rulebtn").click(function () {
        $(this).parent().next().toggle();
    });

    //搭配购买商品
    $(".batch_addcart").click(function () {
        var batch_addcart = $(this);
        if ($("#dapei_skuprice").val() == "") {
            alertDialog("请选择商品规格");
            return;
        }
        if (!isCanBuy) {
            alertDialog("该产品已缺货");
            return;
        }
        var skuIds = [];
        $("#dapei").find("input:checked").each(function () {
            skuIds.push(parseInt($(this).attr("skuid")))
        });
        var skuId = $("#dapei_skuId").val();
        skuIds.push(skuId);
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        $.ajax({
            url: webPath.webRoot + "/cart/addBatch.json",
            data: {type: carttype, objectIds: skuIds.join(","), quantity: 1, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    var shoppingcart = data.shoppingCartVo;
                    var cartNum = 0;
                    for (var i = 0; i < shoppingcart.items.length; i++) {
                        cartNum = cartNum + shoppingcart.items[i].quantity;
                    }
                    var cartLayer = $(".addTobuyCarLayer");
                    cartLayer.find(".cartnum").html(data.allCartNum);
                    $("#top_myCart_cartNum").html(data.allCartNum);
                    cartLayer.find(".cartprice").html(data.allProductTotalAmount);
                    $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    openCartMessageDialog();
                } else {
                    showPrdDetailUserLogin();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });

    //商品详细页显示一个购物车统计信息弹出层
    var openCartMessageDialog = function (){
        easyDialog.open({
            container: 'addToBuyCarLayer',//这个是要被弹出来的div标签的ID值
            fixed: true

        });
        //去购物车结算
        $("#goToAccounts").click(function(){
            easyDialog.close();
            window.location.href = webPath.webRoot + "/shoppingcart/cart.ac";
        });

        //再逛逛
        $("#continueGoShopping").click(function(){
            easyDialog.close();
        });

        //关闭按钮
        $("#closeBtn").click(function(){
            easyDialog.close();
        });
    };

    //商品详细页显示一个需求单统计信息弹出层
    var openListMessageDialog = function (){
        easyDialog.open({
            container: 'addToBuyListLayer',//这个是要被弹出来的div标签的ID值
            fixed: true

        });
        //去购物车结算
        $("#goToAccounts").click(function(){
            easyDialog.close();
            window.location.href = webPath.webRoot + "/shoppingcart/cart.ac";
        });

        //再逛逛
        $("#continueGoShopping").click(function(){
            easyDialog.close();
        });

        //关闭按钮
        $("#closeBtn").click(function(){
            easyDialog.close();
        });
    };

    $(".combo_addcart").click(function () {
        if (!isCanBuy) {
            alertDialog("该产品已缺货");
            return;
        }
        //var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        if (skuId == "") {
            alertDialog("请选择商品规格");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    var shoppingcart = data.shoppingCartVo;
                    var allCartNum = data.allCartNum;
                    var cartNum = allCartNum;
                    var allProductAmount = data.allProductTotalAmount;
                    var cartLayer = $("#addToBuyCarLayer");
                    cartLayer.find(".cartnum").html(allCartNum);
                    $("#top_myCart_cartNum").html(allCartNum);
                    cartLayer.find(".cartprice").html(allProductAmount);
                    $("#top_myCart_cartNum2").html(cartNum);
                    $("#cartTotalPrice").html(allProductAmount);
                    openCartMessageDialog();
                } else {
                    showNetUserLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });
    $(".addcart").click(function () {
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
        //var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var remainStock = $(this).attr("remainStock");
        var zoneId = $("#zoneId").val();
        var isNormal = $(this).attr("isNormal");
        if (remainStock == 0) {
            alertDialog("购买的商品库存不足，请重新选择数量");
            return;
        }

        if (remainStock == '' || remainStock == undefined) {
            //单规格商品的时候
            var remainStockValue = $("#remainStock").val();
            if (parseInt(num) > parseInt(remainStockValue)) {
                alertDialog("购买的商品库存不足，请重新选择数量");
                return;
            }
        } else {
            //多规格商品的时候
            if (parseInt(num) > parseInt(remainStock)) {

                alert("购买的商品库存不足，请重新选择数量");
                return;
            }
        }

        if (skuId == "") {
            alert("请选择商品规格");
            return;
        }
        if (num == "") {
            alert("请填写购买数量");
            return;
        }
        var numCheck = /^[0-9]*$/;
        if (!numCheck.test(num)) {
            alert("请填写数字");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler,zoneId:zoneId},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    var shoppingcart = data.shoppingCartVo;
                    var cartNum = 0;
                    for (var i = 0; i < shoppingcart.items.length; i++) {
                        cartNum = cartNum + shoppingcart.items[i].quantity;
                    }

                    var cartLayer;
                    if(isNormal == "Y"){
                        cartLayer = $("#addToBuyListLayer");
                    }else {
                        cartLayer = $("#addToBuyCarLayer");
                    }

                    cartLayer.find(".cartnum").html(data.allCartNum);
                    $("#top_myCart_cartNum").html(data.allCartNum);
                    cartLayer.find(".cartprice").html(data.allProductTotalAmount);
                    $("#top_myCart_cartNum2").html(cartNum);
                    $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    $("#tuanbox").hide();
                    /*if(isNormal == "Y"){
                        openListMessageDialog();
                    }else {
                        openCartMessageDialog();
                    }*/
                    var srcUrl = $(this).attr("srcUrl");
                    moveBoxToCart(".sku"+skuId ,srcUrl);
                   /* loadCartSideBar();*/
                    if(carttype == "normal"){
                        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
                            $("#normalSidebar").load(Top_Path.webRoot+"/ajaxload/normalcartSideBar.ac",function(){cartBarReadyFn("#normalSidebar")})
                        });
                    }else {
                        $("#buycart-main").load(Top_Path.webRoot+"/ajaxload/cartSideBar.ac",function () {
                            loadRightCartSideBar();
                        });
                    }

                }else{
                    showNetUserLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });
    $(".addGoCar").click(function () {
        //var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var remainStockValue = $("#remainStock").val();
        var zoneId = $("#zoneId").val();
        var isNormal = $(this).attr("isNormal");

        if (skuId == "") {
            alertDialog("请选择商品规格");
            return;
        }

        if (parseInt(num) > parseInt(remainStockValue)) {
            alertDialog("购买的商品库存不足，请重新选择数量");
            return;
        }

        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler,zoneId:zoneId},
            dataType: "json",
            success: function (data) {
                if (data.success == "false") {
                    showNetUserLoginLayer();
                    return;
                }
                if(isNormal == "Y"){
                    window.location.href = webPath.webRoot + "/shoppingcart/drugOrderadd.ac?handler=" + handler + "&carttype=" + carttype
                }else {
                    window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?handler=" + handler + "&carttype=" + carttype
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });

    /*------------------------------------  京东商品购买开始 ------------------------------------*/
    $(".jdGoCar").click(function(){
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");

        var zoneId = $("#zoneId").val();
        if (skuId == "") {
            alertDialog("请选择商品规格");
            return;
        }
        if(zoneId.trim() == ""){
            alertDialog("请先选择配送地区");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler, zoneId:zoneId},
            dataType: "json",
            success: function (data) {
                if (data.success == "false") {
                    showNetUserLoginLayer();
                    return;
                }
                window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?handler=" + handler + "&carttype=" + carttype
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });
    });

    $(".jdAddCart").click(function () {
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var remainStock = $(this).attr("remainStock");
        var zoneId = $("#zoneId").val();
        if (zoneId.trim() == "") {
            alertDialog("请先选择配送地区");
            return;
        }
        if (skuId == "") {
            alertDialog("请选择商品规格");
            return;
        }
        if (num == "") {
            alertDialog("请填写购买数量");
            return;
        }
        var numCheck = /^[0-9]*$/;
        if (!numCheck.test(num)) {
            alertDialog("请填写数字");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler,zoneId:zoneId},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    var shoppingcart = data.shoppingCartVo;
                    var cartNum = 0;
                    for (var i = 0; i < shoppingcart.items.length; i++) {
                        cartNum = cartNum + shoppingcart.items[i].quantity;
                    }

                    var cartLayer = $(".addTobuyCarLayer");
                    cartLayer.find(".cartnum").html(data.allCartNum);
                    $("#top_myCart_cartNum").html(data.allCartNum);
                    cartLayer.find(".cartprice").html(data.allProductTotalAmount);
                    $("#top_myCart_cartNum2").html(cartNum);
                    $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    $("#tuanbox").hide();
                    openCartMessageDialog();
                }else{
                    showNetUserLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });

    /*------------------------------------  京东商品购买结束 ------------------------------------*/
    $(".fenqi_cart").click(function () {
        //var addbtn = $(this);
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");

        if (skuId == "") {
            alertDialog("请选择商品规格");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?handler=" + handler + "&carttype=" + carttype + "&rd=" + Math.random()
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });

    $(".addNum").click(function () {
      addNum(this);
    });

    $(".cartNum").change(function () {
       cartNum(this);
    });

    $(".addNum2").click(function () {
       addNum2(this);
    });

    $(".cartNum2").change(function () {
       cartNum2(this);
    });

    $(".dele").click(function () {
        var carttype = $(this).attr("carttype");
        var itemKey = $(this).attr("itemKey");
        $.ajax({
            url: webPath.webRoot + "/cart/removePresent.json",
            data: {type: carttype, itemKey: itemKey},
            dataType: "json",
            success: function (data) {
                setTimeout(function () {
                    window.location.reload();
                }, 1);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });
    $(".clearcart").click(function () {
        var carttype = $(this).attr("carttype");

        $.ajax({
            url: webPath.webRoot + "/cart/clear.json",
            data: {type: carttype},
            dataType: "json",
            success: function (data) {
                setTimeout(function () {
                    window.location.reload();
                }, 1);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        })
    });


    $(".updateSelect").click(function () {
       updateSelect(this);
    });

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

    $(".subNum").click(function () {
        subNum(this);
    });

    $(".delItem").click(function () {
        delItem(this);

    });

    $(".clearAllCart").click(function () {
        var carttype = $(this).attr("carttype");
        $.ajax({
            url: webPath.webRoot + "/cart/clear.json",
            data: {type: carttype},
            dataType: "json",
            success: function (data) {
                setTimeout(function () {
                    window.location.reload();
                }, 1);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });
    });

    //批量删除
    $(".delSelectedCart").live('click',function () {

        var selectNum = 0;
        var selectList = $(".updateSelect");
        selectList.each(function () {
            if ($(this).prop("checked")) {
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
                        url: Top_Path.webRoot + "/cart/delSelectedItem.json",
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

    //货到付款
    $(".isCod").click(function () {
        var object = $(this);
        var isSelected = false;
        if (object.prop("checked")) {
            isSelected = true;
        }
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        $.ajax({
            url: webPath.webRoot + "/cart/checkIsCodItems.json",
            data: {type: carttype, isSelected: isSelected},
            dataType: "json",
            success: function (data) {
                if(isSelected){
                    if(data.success == "false"){
                        object.prop("checked", false);
                        alertDialog("您选中的商品项有部分不支持货到付款");
                    }else{
                        window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?isCod=Y&carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                    }
                }else{
                    window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });


    });

    $(".addRedemptionNum").click(function () {
        var addRuleId = $(this).attr("ruleId");
        var addPresentId = $(this).attr("presentId");
        var addCarttype = $(this).attr("carttype");

        $(".dat").find(".addRedemption").each(function () {
            var ruleId = $(this).attr("ruleId");
            var presentId = $(this).attr("presentId");
            var carttype = $(this).attr("carttype");
            var presentQuantity = $(this).attr("presentQuantity");
            if (addRuleId == ruleId && addPresentId == presentId && addCarttype == carttype && parseInt(presentQuantity) > 0) {
                addRedemption(ruleId, presentId, carttype);
            }
        })

    });

    $(".addPresent").click(function () {
        var ruleId = $(this).attr("ruleId");
        var presentId = $(this).attr("presentId");
        var carttype = $(this).attr("carttype");

        $.ajax({
            url: webPath.webRoot + "/cart/addPresent.json",
            data: {type: carttype, presentId: presentId, ruleId: ruleId},
            dataType: "json",
            success: function (data) {
                setTimeout(function () {
                    window.location.reload();
                }, 1);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });

    });


    $(".addRedemption").click(function () {
        var ruleId = $(this).attr("ruleId");
        var presentId = $(this).attr("presentId");
        var carttype = $(this).attr("carttype");
        addRedemption(ruleId, presentId, carttype);
    });

    function addRedemption(ruleId, presentId, carttype) {
        $.ajax({
            url: webPath.webRoot + "/cart/addRedemption.json",
            data: {type: carttype, presentId: presentId, ruleId: ruleId},
            dataType: "json",
            success: function (data) {
                setTimeout(function () {
                    window.location.reload();
                }, 1);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alertDialog(result.errorObject.errorText);
                }
            }
        });
    }

    /*全选*/
    $(".selectAll").click(function () {
        //去掉货到付款
        selectAll(this);
    });
    /*店铺全选*/
    $(".checkPro").click(function () {
        checkPro(this);
    });
    /*去掉全选*/

    //结算时，商品有效性判断
    $("#addCartResult").click(function () {
        addCartResultClick(this);
    });

});

var goToOrderAdd = function () {
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function () {
        if ($(this).attr("checked") == undefined) {
            selectNum += 1;
        }
    });
    if (selectList.length == selectNum) {
        alertDialog("您没有选择任意一件商品");
        return false;
    }
//    goToUrl(url);

};

var updateSelectCartItems = function (itemKeys, carttype, isSelected) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            if (!data.isCod) {
                $(".isCod").attr("checked", false);
            }
            $("#allCartNum").text(data.allCartNum);
            $("#allObtainTotalIntegral").text(data.allObtainTotalIntegral);
            $("#allDiscount").text(data.allDiscount);
            $("#allProductTotalAmount").text(data.allProductTotalAmount);
            //window.location.reload();//解决全选checkbox状态不正常
            cart();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    })
};

//加入购物车
function addCartResultClick(object){
    var selectNum = 0;
    var selectList = $(".updateSelect");
    selectList.each(function () {
        if (!$(this).prop("checked")) {
            selectNum += 1;
        }
    });

    if (selectList.length == selectNum) {
        alertDialog("请选择商品");
        return;
    }

    var carttype = $("#addCartResult").attr("carttype");
    var handler = $("#addCartResult").attr("handler");
    var isCod = $("#addCartResult").attr("isCod");

    if(undefined == isCod || '' == isCod){
        isCod = 'N';
    }

    $.ajax({
        url: webPath.webRoot + "/cart/checkToAddOrder.json",
        data: {type: carttype},
        dataType: "json",
        success: function (data) {
            if(data.success == 'false'){
                alertDialog("您购物车中的" + data.cartItemMsg + "，请选择正确的商品进行结算");
                return false;
            }else{
                window.location.href = webPath.webRoot + "/shoppingcart/orderadd.ac?carttype="+carttype+"&handler="+handler+"&isCod="+isCod;
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

function show(shopInfId){
    $("#bigQrCode"+shopInfId).show();
    $("#smallQrCode"+shopInfId).hide();
}

function hide(shopInfId){
    $("#bigQrCode"+shopInfId).hide();
    $("#smallQrCode"+shopInfId).show();
}

//===============购物车重构===================

var xmlhttp;
var url =webPath.webRoot + "/shoppingcart/cartMain.ac";
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

//购物车全选
function selectAll(obj){
    //去掉货到付款
    $(".isCod").attr("checked", false);
    var selectItems = [];
    var carttype = $(obj).attr("carttype");
    if ($(obj).attr("checked") == undefined) {//去掉全选
        $(".selectAll").attr("checked", false);
        $(".checkPro").each(function () {
            $(obj).attr("checked", false);
        });
        $(".updateSelect").each(function () {
            $(this).attr("checked", false);
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        updateSelectCartItems(selectItems, carttype, false);
    } else {//全选商品
        $(".selectAll").attr("checked", true);
        $(".checkPro").each(function () {
            $(this).attr("checked", true);
        });
        $(".updateSelect").each(function () {
            $(this).attr("checked", true);
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        updateSelectCartItems(selectItems, carttype, true);
    }
}

//店铺全选
function checkPro(obj){
    var isChecked = $(obj).attr("checked") != undefined;
    //把勾选的商品updateSelectCartItems
    var selectItems = [];
    var carttype = $(obj).attr("carttype");
    $(obj).parents(".order").find(".updateSelect").each(function () {
        $(this).attr("checked", isChecked);
        var itemKey = $(this).attr("itemKey");
        var orgid = $(this).attr("orgid");
        selectItems.push(itemKey + ':' + orgid);
    });
    updateSelectCartItems(selectItems, carttype, isChecked);
}

function updateSelect(obj){
    var updateSelectList = $(obj).parents(".order").find(".updateSelect");
    var checkPro = $(obj).parents(".order").find(".checkPro");
    var isSelected = true;
    if ($(obj).attr("checked")) {
        isSelected = true;
        checkPro.attr("checked", true);//勾选店铺
    } else {
        isSelected = false;
        $(".selectAll").attr("checked", false);//去掉全选
        var updateSelectNum = 0;
        updateSelectList.each(function () {
            if ($(this).attr("checked") == undefined) {
                updateSelectNum += 1;
            }
        });
        if (updateSelectList.length == updateSelectNum) {
            checkPro.attr("checked", false);//勾选店铺
        }
    }

    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            //setTimeout(function () {
            //    var isCod = getUrlParamValue("isCod");
            //    var carttype = getUrlParamValue("carttype");
            //    var handler = getUrlParamValue("handler");
            //    var url = webPath.webRoot + "/shoppingcart/cart.ac?";
            //    if (isCod == '') {
            //        url = url + "isCod=" + isCod;
            //    }
            //    if (carttype == '') {
            //        url = url + "&carttype=" + carttype;
            //    }
            //    if (handler == '') {
            //        url = url + "&handler=" + handler;
            //    }
            //    window.location.href = url + "&rd=" + Math.random();
            //}, 1);
            cart();
            if (!data.isCod) {
                $(".isCod").attr("checked", false)
            }

        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alertDialog(result.errorObject.errorText);
            }
        }
    })
}

//加数量1
function addNum(obj){
    var object = $(obj);
    var value = $(obj).prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "true"){
                object.prev("input").val(num);
            }else{
                alertDialog(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
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

//减数量1
function subNum(obj){
    var object = $(obj);
    var value = $(obj).prev().prev("input").val();
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
            if(data.success == false){
                alertDialog(data.cartAlertMsg);
                object.prev().prev("input").val(data.currentNum);
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

//加数量2
function addNum2(obj){
    var object = $(obj);
    var value = $(obj).prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "true"){
                object.prev("input").val(num);
            }else{
                alertDialog(data.cartAlertMsg);
                object.prev("input").val(data.currentNum);
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

//修改数量1
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
                alertDialog(data.cartAlertMsg);
                obj.val(data.currentNum);
                //return;
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


//修改数量2
function cartNum2(obj){
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
                alertDialog(data.cartAlertMsg);
                obj.val(data.currentNum);
                //return;
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


//货到付款
function isCod(obj){
    var object = $(obj);
    var isSelected = false;
    if (object.prop("checked")) {
        isSelected = true;
    }
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");
    $.ajax({
        url: webPath.webRoot + "/cart/checkIsCodItems.json",
        data: {type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            if(isSelected){
                if(data.success == "false"){
                    object.prop("checked", false);
                    alertDialog("您选中的商品项有部分不支持货到付款");

                }else{
                    window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?isCod=Y&carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
                }
            }else{
                window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
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



