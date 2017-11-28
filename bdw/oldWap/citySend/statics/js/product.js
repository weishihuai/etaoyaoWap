/**
 * Created by Administrator on 2017/1/5.
 */
$(function(){
    $(".promotion").click(function(){
        if($(".promotion-content1").css("display") == 'block'){
            $(".promotion-content1").css("display","none");
            $(".promotion-content").removeClass("ruleUp");
            $(".promotion-content").addClass("ruleDown");
        }else{
            $(".promotion-content1").css("display","block");
            $(".promotion-content").removeClass("ruleDown");
            $(".promotion-content").addClass("ruleUp");
        }
    });
    // 将详情图片的高度设为自动高
    $(".detail-box img").css("width", "100%").css("height", "auto");

    //购买数量减少事件
    $(".cartReduce").click(function () {
        var productNum = $(".cartInp");
        var value = productNum.val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        if (num == 1) {
            $(this).addClass("disabled");
        }
        productNum.val(num);
        $(".addStoreCart").attr("num", num);
    });

    //购买数量输入框
    $(".cartInp").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);
            return;
        }
        if (parseInt(value) == 1) {
            $(".cartReduce").addClass("disabled");
        } else {
            $(".cartReduce").removeClass("disabled");
        }
        $(".addStoreCart").attr("num", value);
    });

    //购买数量添加事件
    $(".cartAdd").click(function () {
        var productNum = $(".cartInp");
        var value = productNum.val();
        var num = parseInt(value) + 1;
        productNum.val(num);
        if (num > 1) {
            $(".cartReduce").removeClass("disabled");
        }
        $(".addStoreCart").attr("num", num);
    });

    //窗口关闭
    $(".close").click(function() {
        $("#ajaxCartSeletor").hide();
        $("#cart").show();
    });

    //商品搭配
    $("#dapei").find("input").click(function(){
        if ($("#dapei_skuprice").val() == "") {
            xyPop.msg('请先选择商品规格!',{type:'warning',time:2});
            $(this).attr("checked", false);
            return;
        }
        var dapei_skuprice = parseFloat($("#dapei_skuprice").val());

        var price = 0.0;
        var num = 0;
        $("#dapei").find("input:checked").each(function () {
            price = price + parseFloat($(this).val());
            num++;
        });
        var p = price + dapei_skuprice;
        var n = 'n';
        $("#dapeiprice").html("￥" + p.toFixed(2));
        $("#selectNum").html(num);
    });

    //----------------------规格选择-----------------------
    var selectSpecValues = [];
    var allSpecValueIds = [];
    var userSpecValueData = [];
    if(userSpecData!=null){
        buildData();
    }

    //搭配购买时选择规格
    $(".specSelect2").find(".gg_btn").click(function () {

        if ($(this).hasClass("lock")) {
            return;
        }

        if ($(this).hasClass("g_cur")) {
            $(this).removeClass("g_cur");
            $(this).className='gg_btn';
        } else {
            $(this).siblings(".gg_btn").removeClass("g_cur");
            $(this).addClass("g_cur");
        }

        var data_values = $(this).attr("data-value");
        var data_value = data_values.split(":");
        var specObject = {specId:parseInt(data_value[0]), specValueId:parseInt(data_value[1])};

        //加入或移除
        pushSelected(specObject);

        var skuDatas = skuData;
        var selectSpecArray = [];
        for (var i = 0; i < selectSpecValues.length; i++) {
            //过滤没有包含选择规格值ID的规格组合
            skuDatas = filterSkuDatas(selectSpecValues[i].specValueId, skuDatas);
            //记录选择规格
            for (var spd = 0; spd < userSpecValueData.length; spd++) {
                if (selectSpecValues[i].specValueId == userSpecValueData[spd].specValueId) {
                    selectSpecArray.push(userSpecValueData[spd].specValueNm);
                    break;
                }
            }
        }

        $(".lock").removeClass("lock");
        var unSelectSpecValue = [];

        var filterSpecValueIds = [];
        var filterSkuData = skuData;

        for (var i = 0; i < selectSpecValues.length; i++) {
            filterSkuData = filterSkuDatas(selectSpecValues[i].specValueId, filterSkuData);
            var selectSpecIDs = [];
            for(var spd=0;spd<=i;spd++){
                selectSpecIDs[spd]=selectSpecValues[spd].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs,unSelectSpecValue,filterSkuData,selectSpecValues[i].specValueId);
        }
        var selectSpecValues1 =  selectSpecValues.reverse();
        var filterSkuData1 = skuData;
        for (var i1 = 0; i1 < selectSpecValues1.length; i1++) {
            filterSkuData1 = filterSkuDatas(selectSpecValues1[i1].specValueId, filterSkuData1);
            var selectSpecIDs1 = [];
            for(var spd1=0;spd1<=i1;spd1++){
                selectSpecIDs1[spd1]=selectSpecValues1[spd1].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs1,unSelectSpecValue,filterSkuData1,selectSpecValues1[i1].specValueId);
        }

        for (var s = 0; s < unSelectSpecValue.length; s++) {
            $(".specSelect2").find(".gg_btn").each(function () {
                var data_value = $(this).attr("data-value");
                var specValueId = parseInt(data_value.split(":")[1]);
                if (unSelectSpecValue[s] == specValueId) {
                    $(this).addClass("lock");
                }
            });
        }

        if (skuDatas.length == 1 && $(".mp2-item").size() == selectSpecValues.length) {
            selectSku(skuDatas[0]);
        }else{
            $("#dapei_skuId").val("");
            $("#dapei_skuprice").val("");
            $("#dapeiprice").html("￥0.0");

            //搭配商品那里也要跟着规格变化而变化价格
            $("#packagePrice").html("￥"+$("#priceListStr").val());
        }
    });

    //如果是多规格，默认选中第一个
    $(".mp2-item").each(function (inx) {//inx是索引index
        $(this).find(".gg_btn:first").each(function () {
            this.click();
        });
    });

    $(".specSelect").find(".item").click(function () {

        if ($(this).hasClass("disabled")) {
            return;
        }

        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
        } else {
            $(this).parent().find("span").removeClass("active");
            $(this).addClass("active");
        }

        var data_values = $(this).attr("data-value");
        var data_value = data_values.split(":");
        var specObject = {specId: parseInt(data_value[0]), specValueId: parseInt(data_value[1])};

        //加入或移除
        pushSelected(specObject);

        var skuDatas = skuData;


        var selectSpecArray =  [];
        for (var i = 0; i < selectSpecValues.length; i++) {
            //过滤没有包含选择规格值ID的规格组合
            skuDatas = filterSkuDatas(selectSpecValues[i].specValueId, skuDatas);
            //记录选择规格
            for (var spd = 0; spd < userSpecValueData.length; spd++) {
                if (selectSpecValues[i].specValueId == userSpecValueData[spd].specValueId) {
                    selectSpecArray.push(userSpecValueData[spd].specValueNm);
                    break;
                }
            }
        }

        //展示选择的规格
        //displaySelectSpecValue(selectSpecArray);

        $(".disabled").removeClass("disabled");
        var unSelectSpecValue =  [];

        var filterSpecValueIds =  [];
        var filterSkuData = skuData;

        for (var i = 0; i < selectSpecValues.length; i++) {
            filterSkuData = filterSkuDatas(selectSpecValues[i].specValueId, filterSkuData);
            var selectSpecIDs =  [];
            for (var spd = 0; spd <= i; spd++) {
                selectSpecIDs[spd] = selectSpecValues[spd].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs, unSelectSpecValue, filterSkuData, selectSpecValues[i].specValueId);
        }
        var selectSpecValues1 = selectSpecValues.reverse();
        var filterSkuData1 = skuData;
        for (var i1 = 0; i1 < selectSpecValues1.length; i1++) {
            filterSkuData1 = filterSkuDatas(selectSpecValues1[i1].specValueId, filterSkuData1);
            var selectSpecIDs1 =  [];
            for (var spd1 = 0; spd1 <= i1; spd1++) {
                selectSpecIDs1[spd1] = selectSpecValues1[spd1].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs1, unSelectSpecValue, filterSkuData1, selectSpecValues1[i1].specValueId);
        }
        for (var s = 0; s < unSelectSpecValue.length; s++) {
            $(".specSelect").find("span").each(function () {
                var data_value = $(this).attr("data-value");
                var specValueId = parseInt(data_value.split(":")[1]);
                if (unSelectSpecValue[s] == specValueId) {
                    $(this).addClass("disabled");
                }
            });
        }

        if (skuDatas.length == 1 && $(".specSelect").size() == selectSpecValues.length) {
            selectSku(skuDatas[0]);
        } else {
            $("#price").html("<small>&yen;&nbsp;</small>" + $("#priceListStr").val());
            $(".addCart").attr("skuid", "");//清除掉加入购物车的skuid
            $(".priceNm").html($("#priceListStr").attr("priceNm") + "：");

            $("#dapei_skuId").val("");
            $("#dapei_skuprice").val("");
            $("#dapeiprice").html("￥0.0");

            //搭配商品那里也要跟着规格变化而变化价格
            $("#packagePrice").html("￥"+$("#priceListStr").val());

        }
    });

    //如果是多规格，默认选中第一个
    $(".specSelect").each(function (inx) {//inx是索引index
        $(this).find(".item:first").each(function () {
            this.click();
        });
    });

    function buildData() {
        if (userSpecData == null) {
            return;
        }
        for (var spd = 0; spd < userSpecData.length; spd++) {
            var productUserSpec = userSpecData[spd].specValueProxyList;
            for (var usp = 0; usp < productUserSpec.length; usp++) {
                var specValueId = productUserSpec[usp].specValueId;
                var userDefinedName = productUserSpec[usp].userDefinedName;
                var name = productUserSpec[usp].name;
                var relPicId = productUserSpec[usp].relPictId;//Cannot read property 'relPicId' of undefinedpushSelected
                var specId = userSpecData[spd].specId;

                allSpecValueIds.push(specValueId);
                userSpecValueData.push({
                    specId: specId,
                    specValueId: specValueId,
                    specValueNm: (userDefinedName != undefined && $.trim(userDefinedName).length > 0) ? userDefinedName : name,
                    relPicId: relPicId
                });
            }
        }
    }

    //根据规格ID取出规格值
    function getUseSpecValue(specValueId) {
        for (var i = 0; i < userSpecValueData.length; i++) {
            if (userSpecValueData[i].specValueId == specValueId) {
                return userSpecValueData[i];
            }
        }
    }

    //增加或删除规格
    function pushSelected(specObject) {
        //不是增加 就是 删除
        var isAdd = true;
        var addIndex = -1;
        for (var i = 0; i < selectSpecValues.length; i++) {
            var specValueId = selectSpecValues[i].specValueId;
            var specId = selectSpecValues[i].specId;

            if (specId == specObject.specId) {
                addIndex = i;
                if (specObject.specValueId == specValueId) {
                    isAdd = false;//删除
                    break;
                }
            }
        }
        //增加
        if (isAdd) {
            if (addIndex < 0) {
                selectSpecValues.push(specObject);
            } else {
                selectSpecValues[addIndex] = specObject;
            }
            //显示规格相关图片
            var useSpecValue = getUseSpecValue(specObject.specValueId);
            if (useSpecValue.relPicId != undefined && $.trim(useSpecValue.relPicId).length > 0) {
                //displaySpecRefPic(useSpecValue.relPicId)
            }
        }
        //删除
        else {
            selectSpecValues.splice(addIndex, 1);
        }
    }

    //sku过滤器
    function filterSkuDatas(specValueId, skuDatas) {
        var result =  [];
        for (var i = 0; i < skuDatas.length; i++) {
            if(skuDatas[i].price.remainStock >0){
                if ($.inArray(specValueId, skuDatas[i].specValueIds) >= 0) {
                    result.push(skuDatas[i]);
                }
            }
        }
        return result;
    }

    //选择过滤器
    function filterUnSelectSpecValueIds(selectSpecIds, unSelectSpecValue, filterDatas, selectSpecValueId) {
        var canSelects = [];
        var filterSpecValueIds = [];
        if (selectSpecValueId == undefined) {
            return unSelectSpecValue;
        }

        for (var us = 0; us < userSpecValueData.length; us++) {
            var isSelectSpecId = false;
            for (var spId = 0; spId < selectSpecIds.length; spId++) {
                if (selectSpecIds[spId] == userSpecValueData[us].specId) {
                    isSelectSpecId = true;
                }

            }
            if (!isSelectSpecId) {
                filterSpecValueIds.push(userSpecValueData[us].specValueId);
            }
        }

        for (var i = 0; i < filterDatas.length; i++) {
            if (filterDatas[i].price.remainStock > 0) {
                var specValueIds = filterDatas[i].specValueIds;
                if ($.inArray(selectSpecValueId, specValueIds) >= 0) {
                    for (var a = 0; a < specValueIds.length; a++) {
                        canSelects.push(specValueIds[a]);
                    }
                }
            }
        }

        for (var f = 0; f < filterSpecValueIds.length; f++) {
            if ($.inArray(filterSpecValueIds[f], canSelects) < 0) {
                unSelectSpecValue.push(filterSpecValueIds[f]);
            }
        }
        return unSelectSpecValue;
    }

    //选择多种规格后得到SKU
    function selectSku(skuData) {
        var sku = skuData.sku;
        var price = skuData.price;
        var remainStock = sku.currentNum - sku.safetyStock;
        //显示价格
        var priceReg = /^\d+[.]\d+$/;
        var priceTemp = price.unitPrice;
        if (priceReg.test(priceTemp)) {
            $("#price").html("<small>&yen;&nbsp;</small>" + priceTemp + "");
        } else {
            $("#price").html("<small>&yen;&nbsp;</small>" + priceTemp + ".00");
        }
        if (sku.currentNum == 0 || sku.currentNum <= sku.safetyStock) {
            $(".quehuobtn").attr("skuid", sku.skuId);
            $("#stock").html(0);
            $("#remainStock").val(0);
            return;
        }
        if (remainStock != null) {
            if (remainStock > 0) {
                $("#stock").html(price.remainStock);
                $("#remainStock").val(price.remainStock)
            }
        }

        //市场价也要随着规格变化
        //if(sku.marketPrice !=null && sku.marketPrice != '0' && sku.marketPrice!='0.0'){
        //    $("#marketPrice").html("¥" + sku.marketPrice);
        //}

        //搭配商品那里也要跟着规格变化而变化价格
        $("#packagePrice").html("￥"+price.unitPrice);

        $("#dapeiprice").html("￥<b>" + price.unitPrice + "</b>") ;

        //因为如果搭配商品那里已经有商品被选中再选中其他规格，显示价格会不一致，所以选取其他规格的时候把所有搭配商品的checkbox取消
        $("[name='packageItem']").removeAttr("checked");
        $("#selectNum").html(0);

        $(".addStoreCart").attr("skuid", sku.skuId);
        $(".add-to-cart").attr("skuid", sku.skuId);

        $("#dapei_skuId").val(sku.skuId);
        $("#dapei_skuprice").val(price.unitPrice);

    }

    // 确认加入购物车
    $(".addStoreCart").live('click',function () {
        var addbtn = $(this);
        var skuId = addbtn.attr("skuid");
        var num = addbtn.attr("num");
        var carttype = addbtn.attr("carttype");
        var handler =addbtn.attr("handler");
        var orgid = addbtn.attr("orgid");
        if(skuId==""){
            showError("请选择商品规格");
            return;
        }
        if(num==""){
            showError("请填写购买数量");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    $("#ajaxCartSeletor").hide();
                    //重新加载当前门店的购物车
                    reloadHideCart(orgid);
                }else{
                    showLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
            }
        });
    });

    //------------套餐、搭配购买商品加入购物车-------------
    $(".batch_addcart").click(function(){
        if($(this).hasClass("disable")){
            return;
        }

        if($("input[type=checkbox]:checked").length < 1){
            showError("请勾选搭配商品!");
            return;
        }

        if($("#dapei_skuprice").val()==""){
            showError('请先选择商品规格!');
            return;
        }
        if(!isCanBuy){
            showError('该产品已缺货!');
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
        var orgid = $(this).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/addBatch.json",
            data:{type:carttype,objectIds:skuIds.join(","),quantity:1,handler:handler},
            dataType: "json",
            success:function(data) {
                if(data.success == "true"){
                    //var shoppingcart=data.shoppingCartVo;
                    //var cartNum=0;
                    //for(var i=0;i<shoppingcart.items.length;i++){
                    //    cartNum=cartNum+shoppingcart.items[i].quantity;
                    //}
                    //
                    //var cartLayer=$(".addTobuyCarLayer");
                    //cartLayer.find(".cartnum").html(cartNum);
                    //$("#top_myCart_cartNum").html(cartNum);
                    //cartLayer.find(".cartprice").html(shoppingcart.productDiscountAmount);
                    //$("#top_myCart_cartNum2").html(cartNum);
                    //$("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    showSuccess("您已经成功添加商品到购物车!");
                    reloadHideCart(orgid);
                }else{
                    window.location.href = webPath.webRoot + "/wap/login.ac";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
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
        var orgid = $(this).attr("orgid");

        if(skuId==""){
            showError("请选择商品规格!");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/add.json",
            data:{type:carttype,objectId:skuId,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                if(data.success == "true"){
                    showSuccess("您已经成功添加商品到购物车!");
                    reloadHideCart(orgid);
                }else{
                    window.location.href = webPath.webRoot + "/wap/login.ac";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
            }
        });
    });
});

//去结算
function goToAddOrder(obj){
    var addOrderObj = $(obj);
    var orgId = addOrderObj.attr("orgid");
    var carttype = addOrderObj.attr("carttype");
    if(undefined == orgId || null == orgId || orgId==""){
        showError("数据异常");
        return;
    }
    if(undefined == carttype || null == carttype || carttype==""){
        showError("数据异常");
        return;
    }
    $.ajax({
        url: webPath.webRoot + "/cart/checkWapCityShopOrder.json",
        data: {type: carttype, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                window.location.href = webPath.webRoot+"cityCheckout.ac?orgId="+orgId;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);

            }
        }
    });
}

function showAllComment(obj) {
    var productId = $(obj).attr("productId");
    window.location.href = webPath.webRoot + "/wap/citySend/allComment.ac?productId=" + productId;
}
function addCart(productId){
    $("#ajaxCartSeletor").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartSelector.jsp",{productId:productId},$("#ajaxCartSeletor").show());
}
//购物车列表展开与收起
$("#storeCartLayer").live('click',function() {
    var orgId = $(this).attr("orgid");
    if("none"==$("#ajaxLoadShoppingCart").css("display")) {
        var userId = webPath.userId;
        if (isEmpty(userId)) {
            showLoginLayer();
            return;
        }
        loadStoreShowCart(orgId);
    } else {
        $("#ajaxLoadShoppingCart").css("display","none");
    }
});

/*------------购物车页面--------------*/
//数量增加
$(".op-add").live("click",function () {
    addStoreNum(this);
});

//填写数量
$(".val").live("change",function () {
    cartStoreNum(this);
});

//数量减少
$(".op-reduce").live("click",function () {
    subStoreNum(this);
});

//复选框-----------------
//cartItem勾选
$(".updateSelect").live("click",function () {
    updateStoreSelect(this);
});

//全选
$("#allSelect").live("click",function(){
    var selectItems = [];
    var carttype = $(this).attr("carttype");
    var sysOrgId = $(this).attr("orgid");
    if($(this).hasClass("active")){//去掉全选
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        if(selectItems.length<=0){
            return;
        }
        updateSingleStoreSelectCartItems(selectItems, carttype, false, sysOrgId);
    }else{
        //全选
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            selectItems.push(itemKey + ':' + orgid);
        });
        if(selectItems.length<=0){
            return;
        }
        updateSingleStoreSelectCartItems(selectItems, carttype, true,sysOrgId);
    }
});

//移除商品
function delStoreIndexCartItem(obj){
    var _this = $(obj);
    showConfirm("确定删除商品吗?",function(){
        layer.load();
        var itemKey = _this.attr("itemKey");
        var carttype = _this.attr("carttype");
        var handler = _this.attr("handler");
        var orgId = _this.attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/remove.json",
            data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
            dataType: "json",
            success:function(data){
                loadStoreShowCart(orgId);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
                layer.closeAll();
            }
        });
    });
}

//清空购物车
function delStoreAllCartItem(obj){
    if ($("#ajaxLoadShoppingCart").find("li").length <= 0) {
        return;
    }
    showConfirm("确定清空购物车吗?", function(){
        layer.load();
        var carttype = $(obj).attr("carttype");
        var handler = $(obj).attr("handler");
        var orgId = $(obj).attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/removeAll.json",
            data: {type: carttype, handler: handler, orgId: orgId},
            dataType: "json",
            success:function(data){
                loadStoreShowCart(orgId);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
                layer.closeAll();
            }
        });
    });
}

function addStoreNum(obj){
    layer.load();
    var object = $(obj);
    var value = object.prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                object.prev("input").val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

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
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                obj.val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

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
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == false){
                object.next("input").val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

function updateStoreSelect(obj){
    layer.load();
    var isSelected = true;
    var updateSelectList = $(obj).parents(".modal-body").find(".updateSelect");
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
        url: webPath.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

var updateSingleStoreSelectCartItems = function (itemKeys, carttype, isSelected,orgId) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
};

function loadStoreShowCart(orgId){
    $("#ajaxLoadShoppingCart").load(webPath.webRoot + "/template/bdw/wap/citySend/ajaxload/ajaxLoadShoppingCart.jsp", {
        carttype: "store",
        orgId: orgId
    }, function(){
        $("#ajaxLoadShoppingCart").show();
        reloadHideCart(orgId);
    });
}

function reloadHideCart(orgId){
    $("#cart").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartBottom.jsp",{carttype:"store",orgId:orgId},function(){
        layer.closeAll();
    });
}

// 继续购物
function closeAjaxLoadShoppingCart(){
    $("#ajaxLoadShoppingCart").hide();
}

// 弹出登录提示框
function showLoginLayer(){
    showConfirm("请先登录", function(){
        window.location.href = webPath.webRoot + "/wap/login.ac";
    });
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}