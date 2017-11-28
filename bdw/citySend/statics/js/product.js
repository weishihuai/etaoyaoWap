var addrs;//加载地区
function loadAddr() {
    return $(".addressSelect").ld({
        ajaxOptions: {"url": webPath.webRoot + "/member/addressBook.json"},
        defaultParentId: 9,
    });


}

function getZone() {
    var zone = $("#zone").val();
    $("#zoneId").val(zone);
}

$(function(){
    $(".proCarousel").slidelf1({
        "prev": "turnLCarousel",
        "next": "turnRCarousel",
        "vertical": true,
        "speed": 500
    });
    // 图片的宽高都会加上"100%",所以需要特殊处理
    $(".detail-img").find("img").css({"width":"auto","height":"auto"});

    var swiper0 = new Swiper('.dapeiSwiper', {
        slidesPerView: 4,
        loop : false,
        scrollbar:'.swiper-scrollbar',
        scrollbarHide:false,
        scrollbarDraggabl:true
    });

    var swiper1 = new Swiper('.comboSwiper', {
        slidesPerView: 4,
        loop : false,
        scrollbar:'.swiper-scrollbar',
        scrollbarHide:false,
        scrollbarDraggable:true
    });

    var swiper2 = new Swiper('.zipPicSwiper', {
        slidesPerView: 5,
        loop : false,
        scrollbar:'.swiper-scrollbar',
        scrollbarHide:false,
        scrollbarDraggable:true
    });

    addrs = loadAddr();

    //以下两句为了解决display：none造成的swiper的样式不匹配问题
    $(".comboDl").css("display","none");
    $("#comboDl1").css("display","block");

    $(".comboLi").click(function(){
        var seq = $(this).attr("seq");
        $(".comboLi").removeClass("cur");
        $(this).addClass("cur");
        $(".comboDl").css("display","none");
        $("#comboDl" + seq).css("display","block");
    });

    //切换tag
    $(".desc").click(function () {
        $(".sel").removeClass("active");
        $(this).parent().addClass("active");
        $(".minute-cont").hide();

        var rel = $(this).attr("rel");
        $(".infobox" + rel).show();
        if ("5" == rel) {
            loadPage();
        }
        if ("6" == rel) {
            loadBuyConsultPage();
        }
    });

    //购买数量减少事件
    $(".prd_subNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        if(num==1){
            $(this).addClass("disabled");
        }
        productNum.val(num);
        $(".addcart").attr("num", num);
        $(".addGoCar").attr("num", num);
        $(".fenqi_cart").attr("num", num);
    });

    //购买数量输入框
    $(".prd_num").change(function () {
        var value = $(this).val();
        var reg = new RegExp("^[1-9]\\d*$");
        if (!reg.test(value)) {
            $(this).val(1);
            return;
        }
        if(parseInt(value)==1){
            $(".prd_subNum").addClass("disabled");
        }else{
            $(".prd_subNum").removeClass("disabled");
        }
        $(".addcart").attr("num", value);
        $(".addGoCar").attr("num", value);
        $(".fenqi_cart").attr("num", value);
    });

    //购买数量添加事件
    $(".prd_addNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) + 1;
        productNum.val(num);
        if(num>1){
            $(".prd_subNum").removeClass("disabled");
        }
        $(".addcart").attr("num", num);
        $(".addGoCar").attr("num", num);
        $(".fenqi_cart").attr("num", num);
    });

    var defaultSkuId = $("#addProductCart").attr("skuid");
    $(".qr"+defaultSkuId).show();


    var imgls = $("#mycarousel").find("a").hover(function () {
        $("#mycarousel a").parent().removeClass("active");
        $(this).parent().addClass("active");
        $("#bigsrc").attr("src", $(this).attr("midsrc"));
        $(".jqzoom").attr("href", $(this).attr("bigsrc"));
        $(this).click();
    }, function () {
    });

    $('.jqzoom').jqzoom({
        zoomType: 'standard',
        lens: true,
        preloadImages: true,
        alwaysOn: false
    });

    var selectSpecValues =  [];
    var allSpecValueIds =  [];
    var userSpecValueData =  [];

    if (userSpecData != null) {
        buildData();
    }
    $(".specSelect").find("a").click(function () {
    if ($(this).hasClass("lock")) {
        return;
    }
    if ($(this).children().hasClass("active")) {
        $(this).children().removeClass("active");
    } else {
        $(this).parent().parent().find("a").children().removeClass("active");
        $(this).children().addClass("active");
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
    displaySelectSpecValue(selectSpecArray);
    $(".lock").removeClass("lock");
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
        $(".specSelect").find("a").each(function () {
            var data_value = $(this).attr("data-value");
            var specValueId = parseInt(data_value.split(":")[1]);
            if (unSelectSpecValue[s] == specValueId) {
                $(this).addClass("lock");
            }
        });
    }

    if (skuDatas.length == 1 && $(".specSelect").size() == selectSpecValues.length) {
        selectSku(skuDatas[0]);
    } else {
        $("#dapei_skuId").val("");
        $("#dapei_skuprice").val("");
        //var price = $("#priceListStr").val().subString(0,6);
        $("#dapeiprice").html($("#priceListStr").val());
        //$("#dapeiprice").html(price);
        $("#price").html( $("#priceListStr").val() );
        $(".addcart").attr("skuid", "");//清除掉加入购物车的skuid
        $(".addGoCar").attr("skuid", "");//清除掉立即购买的skuid
        //$(".fenqi_cart").attr("skuid", "");
        $(".addTobuyCar").show('');
        $(".quehuo").hide('');
        $("#specialPrice").hide();
        $(".priceNm").html($("#priceListStr").attr("priceNm") + "：")
    }
});

    //规格默认选中
    $(".specSelect").each(function () {
        $(this).find(".values:first a:first").each(function () {
            this.click();
        });
    });


    function selectSku(skuData) {
    var sku = skuData.sku;
    var price = skuData.price;
    var remainStock = sku.currentNum - sku.safetyStock;

    //显示价格
    var priceReg = /^\d+[.]\d+$/;
    var priceTemp = price.unitPrice;
    if (priceReg.test(priceTemp)) {
        $("#price").html( priceTemp + "");
    } else {
        $("#price").html( priceTemp + ".00");
    }
    if (sku.currentNum == 0 || sku.currentNum <= sku.safetyStock) {
        $(".addTobuyCar").hide('');
        $("#addProductCart").attr("remainStock", 0);
        $(".quehuo").show('');
        $(".quehuobtn").attr("skuid", sku.skuId);
        $("#stock").html("(库存" + 0 + "  件");
        $("#remainStock").val(0);
        return;
    }
    if(sku.marketPrice !=null && sku.marketPrice != '0' && sku.marketPrice!='0.0'){
        $("#marketPrice").html(sku.marketPrice);
    }
    $("#dapeiprice").html(price.unitPrice);
    $("#dapei_skuId").val(sku.skuId);
    if (remainStock != null) {
        if (remainStock > 0) {
            $("#stock").html( price.remainStock );
            $("#addProductCart").attr("remainStock", price.remainStock);
            $("#remainStock").val(price.remainStock)
        }
    }
    $("#dapei_skuprice").val(price.unitPrice);
    $(".addGoCar").attr("skuid", sku.skuId);
    $(".addcart").attr("skuid", sku.skuId);
    $(".fenqi_cart").attr("skuid", sku.skuId);

    //组合套餐
    if (price.isSpecialPrice) {
        $("#specialPrice").show();
        $("#lesTime").imallCountdown(price.endTimeStr, "li", webPath.systemTime);
        $(".priceNm").html(price.amountNm + "：")
    } else {
        $("#specialPrice").hide();
        $(".priceNm").html(price.amountNm + "：")
    }

    //显示选择sku后展示的二维码,其他规格的隐藏
    $(".qr" + sku.skuId).show();
    $(".qr" + sku.skuId).siblings().hide();

}

    //根据规格ID取出规格值
    function getUseSpecValue(specValueId) {
        for (var i = 0; i < userSpecValueData.length; i++) {
            if (userSpecValueData[i].specValueId == specValueId) {
                return userSpecValueData[i];
            }
        }
    }


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
        if (isAdd) {
            if (addIndex < 0) {
                selectSpecValues.push(specObject);
            } else {
                selectSpecValues[addIndex] = specObject;
            }
            //显示规格相关图片
            var useSpecValue = getUseSpecValue(specObject.specValueId);
            if (useSpecValue.relPicId != undefined && $.trim(useSpecValue.relPicId).length > 0) {
                displaySpecRefPic(useSpecValue.relPicId)
            }
        }
        //删除
        else {
            //
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
        var canSelects =  [];
        var filterSpecValueIds =  [];
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
            if(filterDatas[i].price.remainStock >0){
                var specValueIds = filterDatas[i].specValueIds;
                if ($.inArray(selectSpecValueId, specValueIds) >=0) {
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
                var relPicId = productUserSpec[usp].relPictId;
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




    //显示规格关联图片
    function displaySpecRefPic(pic) {
        $("#mycarousel").find("a").each(function () {
            /*        var rel = eval("(" + $.trim("{"+$(this).attr('rel')+"}") + ")");*/
            if (pic == $(this).attr("picId")) {
                /*      $("#bigsrc").attr("src",rel.smallimage);
                 $(".cloud-zoom").attr("href",rel.largeimage);*/

                $(this).click();
                $(this).addClass("zoomThumbActive");
                $("#mycarousel li").removeClass("cur");
                $("#mycarousel li").find("a").removeClass("cur");

                $(this).parents("li").addClass("cur");
                $(this).parents("li").find("a").addClass("cur");
                var num = $("#mycarousel a").index($(this));
                //$("#mycarousel ul").animate({left:-500});
                //$("#mycarousel ul").animate({left:-((num-5)*124)});
                /*$("#bigsrc").attr("src",$(this).attr("sImg"));
                 $("#zoom1").attr("href",$(this).attr("lImg"));*/
            }
        });
    }


    /*------------------------购物车操作-start-----------------------*/
    //添加组合套餐
    $(".combo_addcart").click(function () {
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    ajaxReloadProductHideCart();
                    breadProductAlertJDialog("购物车添加成功!",1200,"10px",true);

                } else {
                    showProductLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadProductAlertJDialog(result.errorObject.errorText,1200,"10px",true);
                }
            }
        });

    });

    //添加搭配商品到购物车
    $(".batch_addcart").click(function () {
        var batch_addcart = $(this);
        if ($("#dapei_skuprice").val() == "") {
            alert("请选择商品规格");
            return;
        }
        if (!isCanBuy) {
            alert("该产品已缺货");
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

                    /*var cartLayer = $(".addTobuyCarLayer");
                    cartLayer.find(".cartnum").html(data.allCartNum);
                    $("#top_myCart_cartNum").html(data.allCartNum);
                    cartLayer.find(".cartprice").html(data.allProductTotalAmount);
                    $("#cartTotalPrice").html(shoppingcart.productDiscountAmount);
                    openCartMessageDialog();*/
                    ajaxReloadProductHideCart();
                    breadProductAlertJDialog("购物车添加成功!",1200,"10px",true);
                } else {
                    showProductLoginLayer()

                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    ajaxReloadProductHideCart();
                    breadProductAlertJDialog("购物车添加成功!",1200,"10px",true);
                }else{
                    showProductLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadProductAlertJDialog(result.errorObject.errorText,1200,"10px",true);
                }
            }
        });

    });

    //正常商品加入购物车
    $(".addcart").click(function () {
        var skuId = $(this).attr("skuid");
        var num = $(this).attr("num");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var remainStock = $(this).attr("remainStock");
        if (remainStock == 0) {
            alert("购买的商品库存不足，请重新选择数量");
            return;
        }

        if (remainStock == '' || remainStock == undefined) {
            //单规格商品的时候
            var remainStockValue = $("#remainStock").val();
            if (parseInt(num) > parseInt(remainStockValue)) {
                alert("购买的商品库存不足，请重新选择数量");
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
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    ajaxReloadProductHideCart();
                    breadProductAlertJDialog("购物车添加成功!",1200,"10px",true);
                }else{
                    showProductLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadProductAlertJDialog(result.errorObject.errorText,1200,"10px",true);
                }
            }
        });

    });


    /*------------------------购物车操作-end-----------------------*/

    //收藏商品

    var collectCount = webPath.productCollectCount;

    $("#AddTomyLikeBtn").click(function () {

        if (webPath.productId == '' || webPath.productId == undefined) {
            return;
        }
        $.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + webPath.productId, function (data) {
            if (data.success == false) {
                if (data.errorCode == "errors.login.noexist") {
                    if (confirm("您尚未登陆，请登陆!")) {
                        goToUrl(webPath.webRoot + "/login.ac");
                    }
                    return;
                }
                if (data.errorCode == "errors.collection.has") {
                    $(".AddTomyLikeLayer .showTip .succe h3").html("您已经收藏了此商品！");
                    //$(".AddTomyLikeLayer").show();
                    createCollectProductLayer();
                }
            } else if (data.success == true) {
                $(".isCollect").html("已收藏");
                if (webPath.productCollectCount == '' || webPath.productCollectCount == undefined) {
                    collectCount = 1
                }
                if(data.isCancel == true){
                    $("#AddTomyLikeBtn").children().first().removeClass("icon-collect-active");
                    $("#AddTomyLikeBtn").children().first().addClass("icon-collect");
                    collectCount = parseInt(collectCount) - 1;
                    $("#collects").html(collectCount);
                    $("#productCollectCount").html(collectCount);
                    $(".AddTomyLikeLayer .showTip .succe h3").html("商品已取消收藏！");
                    //$(".AddTomyLikeLayer").show();
                    createCollectProductLayer();
                } else{

                    $("#AddTomyLikeBtn").children().first().removeClass("icon-collect");
                    $("#AddTomyLikeBtn").children().first().addClass("icon-collect-active");
                    collectCount =  parseInt(collectCount) + 1;
                    $("#collects").html(collectCount);
                    $("#productCollectCount").html(collectCount);
                    $(".AddTomyLikeLayer .showTip .succe h3").html("商品已成功收藏！");
                    //$(".AddTomyLikeLayer").show();
                    createCollectProductLayer();
                }

            }
        });
    });

    //搭配购买
    $("#dapei").find("input").click(function () {
        if ($("#dapei_skuprice").val() == "") {
            alert("请选择商品规格");
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
        /*    alert("<fmt:format"+ n.toUpperCase()+"umber value="+p+ " type='number' pattern='#0.00#'/>");*/
        $("#dapeiprice").html(p.toFixed(2));
        $("#selectNum").html(num);
    });

});
//显示已选择的规格值
function displaySelectSpecValue(nameArray) {
    $("#selecSpec").html("已选择:");
    $("#specValue").html("");
    for (var i = 0; i < nameArray.length; i++) {
        if (i != 0) {
            $("#selecSpec").append("、");
            $("#specValue").append("、");
        }
        $("#selecSpec").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
        $("#specValue").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
    }
}

var collectCount2=webPath.shopCollectCount;
function CollectShop(obj){
    if (obj == '' || obj == undefined) {
        return;
    }
    $.get(webPath.webRoot + "/member/coll" +
        "ectionShop.json?shopId=" + obj, function (data) {
        if (data.success == false) {
            if (data.errorCode == "errors.login.noexist") {
                if (confirm("您尚未登陆，请登陆!")) {
                    goToUrl(webPath.webRoot + "/login.ac");
                }

            }
            //if (data.errorCode == "errors.collection.has") {
            //    $(".AddShopTomyLikeLayer .showTip .succe h3").html("您已经收藏了此店铺！");
            //    //$(".AddShopTomyLikeLayer").show();
            //    createCollectShopLayer();
            //
            //}
        } else if (data.success == true) {
            if (webPath.shopCollectCount == '' || webPath.shopCollectCount == undefined) {
                collectCount2 = 1
            } else {
                if(data.isCancel == true){
                    collectCount2 = parseInt(collectCount2)- 1 ;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已取消收藏！");
                    createCollectShopLayer();
                } else{
                    collectCount2 = parseInt(collectCount2)+ 1;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已成功收藏！");
                    createCollectShopLayer();
                }
            }
        }
    });
}




/*缺货通知*/
function clean(){
    //在窗口关闭的时候清除上一个到货通知选择的数据
    tempObject = "";
    console.log(typeof tempObject);
}

var tempObject ;


function quehuoCityDetailbtn(object){
    //先判断用户是否登录
    if(undefined == webPath.userId || null == webPath.userId || "" == webPath.userId){
        showProductLoginLayer();
        return;
    }
    showWindow('#productDiv', 'auto', 'auto', '请选择通知方式');
    tempObject = object;
    return false;
}


function showWindow(dome, width, height, title) {
    $.layer({
        type: 1,
        shade: [0.2, '#000'],
        area: [width, height],
        title: title,
        border: [0],
        closeBtn: [0, true],
        //shadeClose: true,
        page: {dom : dome},
        end:clean
    });
}
/*缺货通知事件*/
function quehuobtn(object){
    var skuId = $(object).attr("skuid");
    var userInformWay = "";

    if($("#checkEmail").attr("checked") == "checked" && $("#checkMobile").attr("checked") == "checked"){
        userInformWay = 2;
    }else if($("#checkEmail").attr("checked") == "checked"){
        userInformWay = 0;
    }else if($("#checkMobile").attr("checked") == "checked"){
        userInformWay = 1;
    }else{
        alert("请选择通知方式");
        return;
    }
    if (skuId == "") {
        //如果是多规格的，默认第一个
        var skuDatas = skuData;
        skuId = skuDatas[0].sku.skuId;
        //alert("请选择商品规格");
        //return;
    }
    $.ajax({
        url: webPath.webRoot + "/member/saveProductArrivalNotice.json",
        data: {skuId: skuId,userInformWay:userInformWay},
        dataType: "json",
        success: function (data) {
            var result = data.result;
            if (result == "nologin") {
                showPrdDetailUserLogin();
                return;

            }
            if (result) {
                alert("登记成功，请耐心等候我们的通知");
                location.reload();
            } else {
                alert("你已登记成功，无须再次登记，请耐心等候我们的通知");
                location.reload();
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

//重新加载购物车
function ajaxReloadProductHideCart(){
    $("#oldCart").load(webPath.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam},function(){
        $("#cartLayer").css("right", "0px");
        $("#allStoreCart").css("display","none");
        $("#cartContent").css("right","-1260px");
    });
}

function loadPage() {
    $("#comment-list").load(webPath.webRoot + "/template/bdw/citySend/common/productComment.jsp", {id: productId}, function () {

    });
}

//异步分页
function syncPage(page, productId) {
    $("#comment-list").load(webPath.webRoot + "/template/bdw/citySend/common/productComment.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}
//异步分页

function loadBuyConsultPage() {

    $("#ask-list").load(webPath.webRoot + "/template/bdw/citySend/common/productConsult.jsp", {id: productId}, function () {

    });
}

function syncBuyConsultPage(page, productId) {
    $("#ask-list").load(webPath.webRoot + "/template/bdw/citySend/common/productConsult.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}


/*商品收藏弹层*/
var productCollectLayer;
function createCollectProductLayer(){
    productCollectLayer = $.layer({
        type: 1,
        fadeIn: 400,
        offset: ['', ''],
        area: ["400px", 'auto'],
        title: false,
        move: false,
        shade: [0],
        fix: true,
        border: [1, 0.3, '#000'],
        page: {dom: '#addTomyLikeLayer'},
        bgcolor: "#fff",
        zIndex: 19891014,
        closeBtn: [0, true]
    });
}


/*店铺收藏弹层*/
var shopCollectLayer;
function createCollectShopLayer(){
    shopCollectLayer = $.layer({
        type: 1,
        fadeIn: 400,
        offset: ['', ''],
        area: ["400px", 'auto'],
        title: false,
        move: false,
        shade: [0],
        fix: false,
        border: [1, 0.3, '#fff'],
        page: {dom: '#addShopTomyLikeLayer'},
        bgcolor: "#fff",
        zIndex: 19891014,
        closeBtn: [0, true]
    });

}

var onTabSelect = function (comboId, obj) {
    $(".combo-fitting .mt").find("li").removeClass("active");
    $(obj).addClass("active");
    $(".cbItem").hide();
    $(".combos" + comboId).show();
};


//登录提示框
function showProductLoginLayer(){
    var dialog = jDialog.confirm('<span style="margin-left: 10px">您还没有登录!</span>',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = webPath.webRoot + "/login.ac";
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

//没有标题和按钮的提示框
function breadProductAlertJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}