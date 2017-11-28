var addrs;//加载地区
function loadAddr() {
    return $(".addressSelect").ld({
        ajaxOptions: {"url": webPath.webRoot + "/member/addressBook.json"},
        defaultParentId: 9
    });

}
function setAddrNm() {
    $.ajax({
        type:"post",
        url:webPath.webRoot+"/member/zoneNm.json",
        data:{zoneId:114962},
        dataType:"json",
        success:function(data) {

            var defaultValue = [data.provinceNm,data.cityNm,data.countryNm,data.zoneNm];
            addrs.ld("api").selected(defaultValue);
        }
    })
}
function getZone() {
    var zone = $("#zone").val();
    $("#zoneId").val(zone);
}

$(document).ready(function () {

    //配送地区
    $("#deliveryAreaSpan").hover(function(){
        createZoneLayer();
    },function(){
        hideLayer();
        $("#zoneLimit").hover(function(){
            createZoneLayer();
        },function(){
            hideLayer();
        });
    });

    if (webPath.page != null && webPath.page != "") {
        tabChance('.desc4', '#description');
    }
    $(".addcart").attr("num", $(".prd_num").val());
    if (isShowProductInf == 'Y') {
        goToUrl(window.location.href = webPath.webRoot + '/shopError.ac');
        return;
    }
    var tuiJianWidth = 0;
    $(".tuijian").each(function () {
        tuiJianWidth = tuiJianWidth + 170;
    });
//    $(".tuiJianDaPei").css("width",tuiJianWidth+"px");

    var taocanWidth = 0;
    $(".taocan").each(function () {
        taocanWidth = taocanWidth + 170;
    });
    $(".taoCanDabei").css("width", taocanWidth + "px");

    /*var taocanZuheWidth=0;
     $(".tcZuhe").each(function(){
     taocanZuheWidth=taocanZuheWidth+170;
     });
     $(".taocanZuHe").css("width",taocanZuheWidth+"px");*/

    addrs = loadAddr();
    setAddrNm();
    var comboselect = $(".combo > h5").find("a").click(function () {
        comboselect.removeClass("cur");
        $(this).addClass("cur");
        var comboid = $(this).attr("comboid");
        $(".combobox").hide();
        $("#combos" + comboid).show();
    });

    //购买数量减少事件
    $(".prd_subNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) - 1;
        if (num == 0) {
            return;
        }
        productNum.val(num);
        $(".addcart").attr("num", num);
        $(".addGoCar").attr("num", num);
        $(".jdGoCar").attr("num", num);
        $(".jdAddCart").attr("num", num);
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
        $(".addcart").attr("num", value);
        $(".addGoCar").attr("num", value);
        $(".jdGoCar").attr("num", value);
        $(".jdAddCart").attr("num", value);
        $(".fenqi_cart").attr("num", value);
    });

    //购买数量增加事件
    $(".prd_addNum").click(function () {
        var productNum = $(".prd_num");
        var value = productNum.val();
        var num = parseInt(value) + 1;
        productNum.val(num);
        $(".addcart").attr("num", num);
        $(".addGoCar").attr("num", num);
        $(".jdGoCar").attr("num", num);
        $(".jdAddCart").attr("num", num);
        $(".fenqi_cart").attr("num", num);
    });

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

    /*    $("#mycarousel").jcarousel({
     scroll: 2,
     initCallback: mycarousel_initCallback,
     // This tells jCarousel NOT to autobuild prev/next buttons
     buttonNextHTML: null,
     buttonPrevHTML: null
     });*/
    /*function mycarousel_initCallback(carousel) {
     $('#mycarousel-next').bind('click', function() {
     carousel.next();
     return false;
     });

     $('#mycarousel-prev').bind('click', function() {
     carousel.prev();
     return false;
     });
     };*/

    var imgls = $("#mycarousel").find("a").hover(function () {
        $("#mycarousel a").removeClass("cur");
        $(this).addClass("cur");
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

        if ($(this).hasClass("cur")) {
            $(this).removeClass("cur");
        } else {
            $(this).parent().parent().find("a").removeClass("cur");
            $(this).addClass("cur");
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
            $("#dapeiMainPrdPrice").html("<i>￥</i>"+$("#priceListStr").val());
            $("#dapeiprice").html("0.0");
            $(".dapeiSelectNum").html("0");
            $("#dapei").find("input:checked").attr("checked",false);
            $("#price").html("￥<b>" + $("#priceListStr").val() + "</b>");
            $(".addcart").attr("skuid", "");//清除掉加入购物车的skuid
            $(".addGoCar").attr("skuid", "");//清除掉立即购买的skuid
            $(".fenqi_cart").attr("skuid", "");
            $(".addTobuyCar").show('');
            $(".quehuo").hide('');
            $("#specialPrice").hide();
            $(".priceNm").html($("#priceListStr").attr("priceNm") + "：")
        }
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

    var collectCount = webPath.productCollectCount;
    //收藏商品
    $("#AddTomyLikeBtn").click(function () {
        if (webPath.productId == '' || webPath.productId == undefined) {
            return;
        }
        $.get(webPath.webRoot + "/member/collectionProduct.json?productId=" + webPath.productId, function (data) {

            if (data.success == false) {
                if (data.errorCode == "errors.login.noexist") {
                    showPrdDetailUserLogin();
                    //if (confirm("您尚未登陆，请登陆!")) {
                    //    goToUrl(webPath.webRoot + "/login.ac");
                    //}

                }
               /* if (data.errorCode == "errors.collection.has") {
                    $(".AddTomyLikeLayer .showTip .succe h3").html("您已经收藏了此商品！");
                    $(".AddTomyLikeLayer").show();

                }*/
            } else if (data.success == true) {
                if (webPath.productCollectCount == '' || webPath.productCollectCount == undefined) {
                    collectCount = 1
                }
                if(data.isCancel == true){

                    $("#AddTomyLikeBtn").removeClass("focus-sel");
                    $("#AddTomyLikeBtn").addClass("unfocus");
                    collectCount = parseInt(collectCount) - 1;
                    $("#productCollectCount").html(collectCount);
                    $(".AddTomyLikeLayer .showTip .succe h3").html("商品已取消收藏！");
                    $(".AddTomyLikeLayer").show();
                } else{
                    $("#AddTomyLikeBtn").removeClass("unfocus");
                    $("#AddTomyLikeBtn").addClass("focus-sel");
                    collectCount = parseInt(collectCount) + 1;
                    $("#productCollectCount").html(collectCount);
                    $(".AddTomyLikeLayer .showTip .succe h3").html("商品已成功收藏！");
                    $(".AddTomyLikeLayer").show();
                }



            }
        });
    });

    //多规格默认选中,石药客户要求不默认选中
    //$(".specSelect").each(function () {
    //    $(this).find(".size:first a:first").each(function () {
    //        this.click();
    //    });
    //});

    var defaultSkuId = $("#addProductCart").attr("skuid");
    $(".qr"+defaultSkuId).show();

    $("#detail_btn_addBuyCar").hover(function () {
        $(".layout_BuyCar").show()
    }, function () {
        $(".layout_BuyCar").hide()
    });


    /*tab切换*/
    $(".desc").click(function () {
        $(".desc").removeClass("cur");
        $(this).addClass("cur");
        $(".r_infobox").hide();
        var rel = $(this).attr("rel");
        $(".infobox" + rel).show();
        if ("4" == rel) {
            loadPage();
        }
        if ("5" == rel) {
            loadBuyConsultPage();
        }
    });


    $(".container1").hScrollPane({
        mover: ".bigbox1",
        moverW: function () {
            return $(".container1 .nrbox1").length * 210;
        }(),
        showArrow: false,
        handleCssAlter: "draghandlealter",
        mousewheel: {moveLength: 100},
        scrollClass: "hScrollPane_dragbar",
        scrollChildClass: "hScrollPane_draghandle"
    });
    $(".container2").hScrollPane({
        mover: ".bigbox2",
        moverW: function () {
            return $(".container2 .nrbox2").length * 210;
        }(),
        showArrow: false,
        handleCssAlter: "draghandlealter",
        mousewheel: {moveLength: 100},
        scrollClass: "hScrollPane_dragbar",
        scrollChildClass: "hScrollPane_draghandle"
    });
    $(".container3").hScrollPane({
        mover: ".bigbox3",
        moverW: function () {
            return $(".container3 .nrbox3").length * 210;
        }(),
        showArrow: false,
        handleCssAlter: "draghandlealter",
        mousewheel: {moveLength: 100},
        scrollClass: "hScrollPane_dragbar",
        scrollChildClass: "hScrollPane_draghandle"
    });

    $(".proCarousel").slidelf1({
        "prev": "turnLCarousel",
        "next": "turnRCarousel",
        "vertical": true,
        "speed": 500
    });

    //商品详细页促销活动
    //更多的点击事件
    $(".more-rule").click(function(){
        $(".i_layer").css("height","auto");
        $(".hidden-rule").css("display","");
        $(".more-rule").css("display","none");
    });

    //隐藏的点击事件
    $(".hidden-rule").click(function(){
        $(".i_layer").css("height","75px");
        $(".hidden-rule").css("display","none");
        $(".more-rule").css("display","");
    });

    var productId = $("#productcookie").val();
    $.ajax({
        type:"POST",
        url: webPath.webRoot + "/member/saveOrUpdateCount.json",
        data: {productId: productId},
        dataType: "json",
        success: function (data) {

        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });


    /*--------------------------------地图操作start--------------------------*/

    //选择门店
    $("#selectStoreBtn").click(function(){
        $("#selectMap").show();
        initPrdDetailMap();
    });

    $("#closeMap").click(function () {
        $("#selectMap").hide();
        $("#keyword").val("");
    });

    $("#closeAddrLayer").click(function(){
        $("#addressLayer").hide();
    });

    //选择配送地址
    $("#selectAddr").click(function(){
        //判断用户是否登录，没有
        if(undefined == webPath.userId || null == webPath.userId || webPath.userId == ''){
            showPrdDetailUserLogin();
        }else{
            $("#addressLayer").show();
        }
    });




    /*--------------------------------地图操作end--------------------------*/

});

function init(carousel) {
    $('#mycarousel2-next').bind('click', function () {
        carousel.next();
        return false;
    });
    $('#mycarousel2-prev').bind('click', function () {
        carousel.prev();
        return false;
    });
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
            //$("#mycarousel ul").animate({left:-((num-5)*124)});
            /*$("#bigsrc").attr("src",$(this).attr("sImg"));
             $("#zoom1").attr("href",$(this).attr("lImg"));*/
        }
    });
}

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

//选择多种规格后得到SKU
function selectSku(skuData) {
    var sku = skuData.sku;
    var price = skuData.price;
    var remainStock = sku.currentNum - sku.safetyStock;

    //显示价格
    var priceReg = /^\d+[.]\d+$/;
    var priceTemp = price.unitPrice;
    if (priceReg.test(priceTemp)) {
        $("#price").html("<span>￥</span>" + priceTemp + "");
    } else {
        $("#price").html("<span>￥</span>" + priceTemp + ".00");
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

    var dapeiAmount = 0.0;
    $("#dapei").find("input:checked").each(function () {
        dapeiAmount = dapeiAmount + parseFloat($(this).val());
    });
    dapeiAmount = dapeiAmount + price.unitPrice;
    $("#dapeiprice").html(dapeiAmount.toFixed(2));
    $("#dapei_skuId").val(sku.skuId);
    if (remainStock != null) {
        if (remainStock > 0) {
            $("#stock").html("(库存" + price.remainStock + "  件");
            $("#addProductCart").attr("remainStock", price.remainStock);
            $("#remainStock").val(price.remainStock)
        }
    }
    $("#dapei_skuprice").val(price.unitPrice);
    $("#dapeiMainPrdPrice").html("<i>￥</i>"+price.unitPrice);
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

//清空商品的cookie
var clearHistoryProductsCookie = function () {
    $.get(webPath.webRoot + "/member/clearProductsCookie.json", function (data) {
        setTimeout(function () {
            window.location.reload();
        }, 2)
    });
};

//var mytooltop, pltop;

$(function () {
    /*$(document).ready(function(){
     mytooltop=$("#productMenu").offset().top;
     var pScrolltop;
     var cloned=false;
     if(window.screen.width<1200){
     $("#productMenu").clone(true).insertAfter("#floatMenu").css({"width":"749px","_width":"760px","float":"right"});
     }else{
     //$("#productMenu").clone(true).insertAfter("#floatMenu").css({"width":"989px","_width":"1000px","float":"right"});
     $("#productMenu").clone(true).insertAfter("#floatMenu").css({"width":"970px","_width":"1000px","float":"right"});
     }
     $(".toolabsolute").hide();
     jQuery(window).scroll(function(){
     //            scrolltop=$(document).scrollTop();
     pScrolltop = document.documentElement.scrollTop || window.pageYOffset || document.body.scrollTop;
     if(pScrolltop>=mytooltop && cloned==false){
     $(".toolabsolute").show();
     cloned=true;
     }
     if(!(pScrolltop>=mytooltop) && cloned==true){
     $(".toolabsolute").hide();
     cloned=false;
     }
     });
     $("#monthHotSales li").hover(function(){
     $("#monthHotSales li .detaiF").hide();
     $("#monthHotSales li .tit").show();
     $(this).find(".tit").hide();
     $(this).find(".detaiF").show();
     });
     $(".ico").click(function(){
     var rel=$(this).find("img").attr("rel");
     if(rel=="N"){
     $(this).find("img").attr("src",webPath.webRoot+"/template/bdw/statics/images/list_eIco.gif");
     $(this).parent().next().hide();
     $(this).find("img").attr("rel","Y");
     }else{
     $(this).find("img").attr("src",webPath.webRoot+"/template/bdw/statics/images/list_mIco.gif");
     $(this).parent().next().show();
     $(this).find("img").attr("rel","N");
     }
     });
     //商品列表页跳转去到评论层
     if(webPath.goBox == 'commentBox'){
     tabChance('.desc4','#commentBox');
     }
     });*/
});

/*var tabChance = function (clickObj, showObj) {
 $("#productMenu a").parent().removeClass("cur");
 if(clickObj == ".desc1"||clickObj == ".desc2"||clickObj == ".desc3") {
 $(clickObj).parent().addClass("cur");
 $(".menuBox").hide();
 $(showObj).show();
 $('body,html').animate({scrollTop:mytooltop}, 1000);
 } else if(clickObj == ".desc5") {
 $(".menuBox").hide();
 $(".desc5").parent().addClass("cur");
 $(showObj).show();
 pltop = $("#buyConsultBox").offset().top -35;
 $('body,html').animate({scrollTop:pltop}, 1000);
 } else {
 $(".menuBox").hide();
 $(".desc4").parent().addClass("cur");
 $(showObj).show();
 pltop = $("#commentBox").offset().top - 35;
 $('body,html').animate({scrollTop:pltop}, 1000);
 }
 };*/

var onTabSelect = function (comboId, obj) {
    $(".zuhe_menu").find("i").removeClass("cur");
    $(obj).addClass("cur");
    $(".zuhe_List").hide();
    $(".combos" + comboId).show();
};

var toPageTop = function () {
    $("#toTop").attr("src", webPath.webRoot + "/template/bdw/statics/images/to_top1.jpg");
};
var toPageTopOut = function () {
    $("#toTop").attr("src", webPath.webRoot + "/template/bdw/statics/images/to_top.jpg");
};


/*function Collect(obj) {
 if (document.all) {
 window.external.addFavorite($(obj).attr("href"), $(obj).attr("title"));
 }
 else if (window.sidebar) {
 try {
 window.sidebar.addPanel($(obj).attr("title"), $(obj).attr("href"), "");
 } catch (e) {

 }
 }
 else {
 alert("收藏失败！请使用Ctrl+D进行收藏");
 }
 }*/
/*收藏店铺*/
var collectCount1 = webPath.shopCollectCount;

function CollectShop(obj){


    if (obj == '' || obj == undefined) {
        return;
    }
    $.get(webPath.webRoot + "/member/collectionShop.json?shopId=" + obj, function (data) {
        if (data.success == false) {
            if (data.errorCode == "errors.login.noexist") {
                showPrdDetailUserLogin();

            }
            //if (data.errorCode == "errors.collection.has") {
            //    $(".AddShopTomyLikeLayer .showTip .succe h3").html("您已经收藏了此店铺！");
            //    $(".AddShopTomyLikeLayer").show();
            //
            //}
        } else if (data.success == true) {
            if (webPath.shopCollectCount == '' || webPath.shopCollectCount == undefined) {
                collectCount1 = 1
            } else {
                if(data.isCancel == true){
                    $("#shopCollect").removeClass("cur");
                    collectCount1 = parseInt(collectCount1) - 1;
                    $("#shopCollectCount").html(collectCount1);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已取消收藏！");
                    $(".AddShopTomyLikeLayer").show();
                } else{
                    $("#shopCollect").addClass("cur");
                    collectCount1 = parseInt(collectCount1) + 1;
                    $("#shopCollectCount").html(collectCount1);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已成功收藏！");
                    $(".AddShopTomyLikeLayer").show();
                    //collectCount = parseInt(webPath.shopCollectCount) + 1
                }
            }
        }
    });
}




function loadPage() {
    $("#commentBox").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {id: productId}, function () {

    });
}

//异步分页
function syncPage(page, productId) {
    $("#commentBox").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}
function loadBuyConsultPage() {
    $("#buyConsultBox").load(webPath.webRoot + "/template/bdw/module/common/includeProductBuyConsult.jsp", {id: productId}, function () {

    });
}

//异步分页
function syncBuyConsultPage(page, productId) {
    $("#buyConsultBox").load(webPath.webRoot + "/template/bdw/module/common/includeProductBuyConsult.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}
/*
 function showCommentBox() {

 $(".desc").removeClass("cur");
 $(".desc4").addClass("cur");
 $(".r_infobox").hide();
 $(".infobox4").show();
 loadPage();
 var pltop = $("#commentInfoBox").offset().top - 35;
 $('body,html').animate({scrollTop:pltop}, 0);
 }*/

//配送区域
var zoneLimitLayer;
function createZoneLayer(){
    zoneLimitLayer = $.layer({
        type: 1,
        fadeIn: 400,
        area: ['auto', 'auto'],
        title: false,
        //move: '.e-tit',
        move: false,
        shade:0,
        fix: true,
        border: [1, 0.3, '#000'],
        page: {dom: '#zoneLimit'},
        bgcolor: "#fff"
    });
}
//关闭所有弹出层
function hideLayer() {
    layer.closeAll();
}

function showBigORCode(skuId){
    $(".code"+skuId).show();
}

function hideBigORCode(skuId){
    $(".code"+skuId).hide();
}

function show(){
    $("#bigQrCode").show();
}

function hide(){
    $("#bigQrCode").hide();
}


/*------------------------初始化地图------------------------------------*/


function initPrdDetailMap(){
    var cityLocation,geocoder,map,searchService = null,prev = "", marker = null;
    var markerBuffer = [];
    var cityLat,cityLng;

    geocoder = new qq.maps.Geocoder({
        complete:function(result){
            var detail = result.detail;
            var nearPois = detail.nearPois;
            var address = detail.address;
            var lat = detail.location.lat;
            var lng = detail.location.lng;
            var city = detail.addressComponents.city.replace("市", "");
            for(var i=0; i<zoneData.length; i++){
                if(zoneData[i].name == city){
                    $("#city-toggle").data("zoneId", zoneData[i].zoneId);
                }
            }
            $("#city-toggle").html(city);
            $(".g-city").html(city);
            getOrg(webPath.orgId);
        }
    });

    var center = new qq.maps.LatLng(39.916527,116.397128);
    map = new qq.maps.Map(document.getElementById('productDetailMap'),{
        center: center,
        zoom: 12
    });

    var infoWin = new qq.maps.InfoWindow({
        map: map,
        zIndex:11
    });

    cityLocation = new qq.maps.CityService({
        complete : function(result){

            $("#cityToggle").blur();
            $("#cityToggle").val("");
            $(".city-dropdown").hide();
            $(".shop-dropdown").hide();
            $("#keyword").val("");
            map.setCenter(result.detail.latLng);
            cityLat = map.getCenter().getLat();
            cityLng = map.getCenter().getLng();
            var city = result.detail.name.replace("市", "");
            var zoneId;
            for(var i=0; i<zoneData.length; i++){
                if(zoneData[i].name == city){
                    zoneId = zoneData[i].zoneId;
                    $("#city-toggle").data("zoneId", zoneId);
                    break;
                }
            }
            $("#city-toggle").html(city);
            $(".g-city").html(city);
            init(zoneId, result.detail.latLng.lat, result.detail.latLng.lng, map);
        }
    });
    if(webPath.orgId && webPath.lat && webPath.lng){
        var latLng = new qq.maps.LatLng(webPath.lat, webPath.lng);
        geocoder.getAddress(latLng);
    }else{
        cityLocation.searchLocalCity();
    }


    searchService = new qq.maps.SearchService({
        pageCapacity: 10,
        autoExtend: false,
        complete: function(result){
            var pois = result.detail.pois;
            $("#search-result li").remove();
            for(var i=0;i<pois.length;i++){
                var p = pois[i];
                var name = p.name;
                var addr = p.address;
                var latlng = p.latLng;
                //拼接通过输入地址获取的地址列表
                $("#search-result").append("<li><a class='re' addr='"+addr+"-"+name+"' lat='"+latlng.lat+"' lng='"+latlng.lng+"' href='javascript:;' style='cursor:pointer;'>" + name + "</a></li>");
            }
        },
        error: function(){
            $("#search-result li").remove();
        }
    });

    /*qq.maps.event.addListener(map, 'click', function(event) {
     var latLng = event.latLng;
     geocoder.getAddress(latLng);
     });*/

    $("#keyword").focus(function(){
        $(".city-dropdown").slideUp();
    });

    $('#keyword').bind("propertychange input",function(event){
        var kw = $(this).val();
        $('#cityBox').show();
        if($.trim(kw) == ""){
            $("#cityBox").hide();
            return;
        }
        if(webPath.mapkey.trim().length==0||webPath.mapkey==null){
            search(kw);
        }else{
            apisMapQQSearch(kw);
        }

    });


    $("#addressList .btn-org").live("click",function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var addr = $(this).attr("addr");
        //var latLng = new qq.maps.LatLng(lat, lng);
        //geocoder.getAddress(latLng);
        $("#addressLayer").hide();
        $(".shop-dropdown").hide();
        $("#keyword").val("");
        searchOrg(lat, lng, {lat:lat, lng:lng, addr:addr});
        $("#storeList").load(webPath.webRoot+"/template/bdw/loadDetailCityWide.jsp",{lat:lat, lng: lng, keyword: "",productId:webPath.productId},function(){});
    });

    function apisMapQQSearch(keyword){
        var cm = $("#city-toggle").text();
        $.ajax({
            type: "GET",
            url: "http://apis.map.qq.com/ws/place/v1/search?boundary=region("+cm+",0)&keyword="+keyword+"&key="+webPath.mapkey+"&output=jsonp",
            dataType: "jsonp",
            jsonp:"callback",
            jsonpCallback:"QQmap",
            success: function(json){
                $("#search-result a").remove();
                $.each(json.data, function(i, item) {
                    $("#search-result").append("<li><a class='re' addr='"+item.address+"-"+item.title+"' lat='"+item.location.lat+"' lng='"+item.location.lng+"' href='javascript:;'>" + item.title + "</a></li>");
                });
            }
        });
    }

    $("#keyword").keydown(function(e){
        if(e.keyCode == 38){//向上
            if($("#search-result a.cur").length == 0){
                var last = $("#search-result a:last");
                last.addClass("cur");
                $("#keyword").val(last.text());
                $("#search-result")[0].scrollTop = $("#search-result")[0].scrollHeight;
            }else{
                var obj = $("#search-result a.cur");
                if(obj.index() > 4){
                    $("#search-result")[0].scrollTop =  $("#search-result")[0].scrollTop - $("#search-result a").outerHeight(true);
                }
                obj.removeClass("cur");
                if(obj.prev("li").length != 0){
                    obj.prev().addClass("cur");
                    $("#keyword").val(obj.prev().text());
                }else{
                    var last = $("#search-result a:last");
                    last.addClass("cur");
                    $("#keyword").val(last.text());
                    $("#search-result")[0].scrollTop = $("#search-result")[0].scrollHeight;
                }
                return false;
            }
        }else if(e.keyCode == 40){
            if($("#search-result a.cur").length == 0){
                var first = $("#search-result a:first");
                first.addClass("cur");
                $("#keyword").val(first.text());
            }else{
                var obj = $("#search-result a.cur");
                if(obj.index() >= 4){
                    $("#search-result")[0].scrollTop =  $("#search-result")[0].scrollTop + $("#search-result a").outerHeight(true);
                }
                obj.removeClass("cur");
                if(obj.next("a").length != 0){
                    obj.next("a").addClass("cur");
                    $("#keyword").val(obj.next().text());
                }else{
                    var first = $("#search-result a:first");
                    first.addClass("cur");
                    $("#keyword").val(first.text());
                    $("#search-result")[0].scrollTop = 0;
                }
            }
        }else if(e.keyCode == 13){
            enterPress();
        }
        e.stopPropagation();
    });

    $("#cityToggle").autocomplete({
        source: zoneData,
        focus: function( event, ui ) {
            $( "#cityToggle" ).val( ui.item.name );
            return false;
        },
        select: function( event, ui ) {
            $( "#cityToggle" ).val( ui.item.name );
            cityLocation.searchCityByName(ui.item.name + "市");
            return false;
        }
    }).data( "autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
            .data( "item.autocomplete", item )
            .append( "<a>" + item.name +"</a>" )
            .appendTo( ul );
    };

    $("#cityToggle").bind("keydown", function(e){
        if(e.keyCode == 13 && $(".ui-autocomplete").css("display") == "block"){
            var obj = $(".ui-autocomplete .ui-corner-all:first");
            var city = obj.text();
            cityLocation.searchCityByName(city + "市");
        }
    });

    $("#se").click(function(){
        var obj = $(".ui-autocomplete .ui-corner-all:first");
        if($(".ui-autocomplete").css("display") == "block" && obj){
            cityLocation.searchCityByName(obj.text() + "市");
        }
    });

    $("#search-result li").live("click", function(){
        $(this).addClass("cur");
        enterPress();
        $("#keyword").val($(this).text());
    });

    $(".bot-ct .city-item").live("click", function(){
        var city = $(this).attr("cm");
        cityLocation.searchCityByName(city + "市");
        var zoneId = $(this).attr("zoneid");
        $("#city-toggle").data("zoneId", zoneId);
    });


    $("#search").click(function(){
        var kw = $("#keyword").val();
        if(!kw ||kw.trim().length == 0){
            return false;
        }
        if(undefined ==  webPath.mapkey || webPath.mapkey.trim().length==0||webPath.mapkey==null){
            search(kw);
        }else{
            apisMapQQSearch(kw);
        }
        enterPress();
    });

    $(".shop-dropdown .shops-w").live("click", function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var orgId = $(this).attr("orgId");
        var isSupport =  $(this).attr("isSupport");
        $("#isSupport"+orgId).attr("isSupport",isSupport);
        //设置属性
        $(".marker_"+orgId).trigger("click");
        $(".shop-dropdown").hide();
    });

    $(".info-window a").live("click", function(){
        var lat = $(this).attr("lat");
        var lng = $(this).attr("lng");
        var zoneId = $("#city-toggle").data("zoneId");
        var addr = $(this).attr("addr");
        if(lat && lng){
            window.open(webPath.webRoot + "/citySend/storeList.ac?lat="+lat +"&lng="+lng);
        }
    });


    $(document).bind("click", function(e){
        if(!$(e.target).is("#keyword")){
            $("#search-result").hide();
        }
    });

    $("#city-toggle").click(function(){
        $(".city-dropdown").slideToggle();
    });

    $(".btn-addr").click(function(){
        $(".locate-dropdown").show();
        $(".city-dropdown").slideUp();
    });

    $(".layer .close").click(function(){
        $(this).parents(".layer").hide();
    });

    $(".hover").hover(function(){
        $(this).addClass("cur");
    }, function(){
        $(this).removeClass("cur");
    });

    function enterPress(){
        var obj = $("#search-result a.cur");
        if($("#search-result a").length == 0){
            return false;
        }
        if(obj.length == 0){
            obj = $("#search-result a:first");
        }
        $("#cityBox").hide();
        var lat = obj.attr("lat");
        var lng = obj.attr("lng");
        var name = obj.text();
        var addr = obj.attr("addr");
        load($("#city-toggle").data("zoneId"), lat, lng, addr);
        searchOrg(lat, lng, {lat:lat, lng:lng, addr:addr});
        //showInfoWin(lat, lng, name, addr);
    }

    function search(kw){
        var cm = $("#city-toggle").text();
        searchService.setLocation(cm);
        searchService.search(kw);
    }

    function load(zoneId, lat, lng, keyword){
        $("#storeList").load(webPath.webRoot+"/template/bdw/loadDetailCityWide.jsp",{zoneId:zoneId, lat:lat, lng: lng, keyword: keyword,productId:webPath.productId},function(){});
    }

    function showInfoWin(lat, lng, name, addr){
        var center = new qq.maps.LatLng(lat, lng);
        map.setCenter(center);
        var infoWin = new qq.maps.InfoWindow({
            map: map
        });
        if(marker){
            marker.setMap(null);
        }
        var zoneId = $("#city-toggle").data("zoneId");
        count(zoneId, lat, lng, function(count){
            marker = infoWin;
            infoWin.open();
            var content = "";
            if(count > 0){
                content = "<div class='info-window'><h3>"+name+"</h3><p>"+addr+"</p><span>附近门店<em>"+count+"</em></span><a addr='"+encodeURI(addr)+"' lat='"+lat+"' lng='"+lng+"' zoneId='" + zoneId + "' title='附近门店' href='javascript:;'>附近门店</a></div>"
            }else{
                content = "<div class='info-window'><h3>"+name+"</h3><p>"+addr+"</p><span>附近门店<em>"+count+"</em></span></div>"
            }
            infoWin.setContent(content);
            infoWin.setPosition(center);
            $("#cityBox").hide();
        });
    }

    function count(zoneId, lat, lng, callback){
        $.ajax({
            data: {zoneId:zoneId, lat:lat, lng: lng, keyword: ''},
            url: webPath.webRoot + "/citySend/count.json",
            async: false,
            success:function(data) {
                if(data.success == "true"){
                    callback(data.result);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    //地图初始化时显示当前定位市区的门店
    function init(zoneId, lat, lng, map){
        var searchWord = $.trim($("#keyword").val());
        if(!zoneId || !map)return;
        $.ajax({
            data:{zoneId: zoneId, lat: lat, lng: lng, relProductId:webPath.productId, keyword:searchWord},
            url: webPath.webRoot + "/citySend/loadInProductDetail.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    for(var i in data.result){
                        addMarker(data.result[i], i, true);
                    }
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function searchOrg(lat, lng, obj){
        if(!lat || !lng)return;
        $.ajax({
            data:{lat: lat, lng: lng,relProductId:webPath.productId},
            url: webPath.webRoot + "/citySend/searchByRelProductId.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    var position = new qq.maps.LatLng(lat, lng);
                    map.setCenter(position);
                    for(var i in data.result){
                        addMarker(data.result[i], i, false, obj);
                    }
                    init($("#city-toggle").data("zoneId"), lat, lng, position);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function getOrg(orgId){
        $.ajax({
            data:{id: orgId},
            url: webPath.webRoot + "/citySend/detail.json",
            success:function(data) {
                if(data.success == "true"){
                    clearMarker();
                    addMarker(data.result, 0, true);
                    setTimeout(function(){
                        $(".marker_"+orgId).trigger("click");
                    }, 100);
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    }

    function addMarker(data, i, init, param){
        var position = new qq.maps.LatLng(data.outletLatStr || data.outletLat , data.outletLngStr || data.outletLng);
        var marker = new MyOverlay("marker_"+data.sysOrgId, position, parseInt(i)+1, data.shopNm,function(obj){
            infoWin.open();
            var content = "";
            var pic = data.shopPicUrl;
            if(undefined == pic || null == pic || ""== pic){
                pic = webPath.webRoot + "/template/bdw/statics/images/noPic_100X100.jpg";
            }else{
                pic = webPath.webRoot + "/upload/"+pic;
            }
            var href;
            if(param){
                var lng = param.lng;
                var lat = param.lat;
                href = webPath.webRoot+"/citySend/storeDetail.ac?orgId="+data.sysOrgId+"&lng="+lng+"&lat="+lat;
            }else{
                href = webPath.webRoot+"/citySend/storeDetail.ac?orgId="+data.sysOrgId;
            }
            var contactWay = data.tel;
            if(null == contactWay || "" == contactWay){
                contactWay = data.mobile;
            }
            if(null == contactWay || "" == contactWay){
                contactWay = "暂无联系方式";
            }
            var orgId = data.sysOrgId;
            content = "<div class='site'><div class='site-box'><div class='title elli'>"+data.shopNm+"</div><div class='pic'><img  width='100' height='100' src='"+pic+"'></div><a href='javascript:void(0);' class='ck-btn' isSupport ='"+data.isSupportBuy+"' orgName='"+data.shopNm+"' orgLink='"+href+"' id='isSupport"+orgId+"'>门店详情</a><div class='pa-rt'><div class='pa-add'><span>地址：</span>"+data.outStoreAddress+"</div> <div class='pa-call'><span>电话：</span>"+contactWay+"</div></div></div></div>";
            //}
            infoWin.setContent(content);
            infoWin.setPosition(obj.position);
            map.setCenter(obj.position);
        });
        marker.setMap(map);
        markerBuffer.push(marker);
        return marker;
    }


    //验证门店是否支持购买，若不支持购买则不能进入门店
    $(".ck-btn").live("click",function(){
        var isSupport = $(this).attr("isSupport");
        var orgName = $(this).attr("orgName");
        var orgLink = $(this).attr("orgLink");
        if(undefined != isSupport && null != isSupport && isSupport!=""){
            if(isSupport == 'N'){
                breadJDialog(orgName+"暂不支持购买,请选择其他门店!",1000,"10px",true);
                return;
            }
        }
        window.location.href = orgLink;


    });

    function clearMarker(){
        if(infoWin){
            infoWin.close();
        }
        for(var i=0;i<markerBuffer.length;i++){
            markerBuffer[i].setMap(null);
        }
        markerBuffer.length = 0;
    }

    function MyOverlay(classNm, position, content, title, clickFun){
        this.classNm = classNm;
        this.position = position;
        this.content = content;
        this.title = title;
        this.clickFun = clickFun;
    }

    MyOverlay.prototype = new qq.maps.Overlay();
    MyOverlay.prototype.construct = function(){
        var div = this.div = document.createElement("div");
        var style = this.div.style;
        style.position = "absolute";
        style.width = "26px";
        style.height = "33px";
        style.background = "url('/template/bdw/citySend/statics/images/addr-icon3.png') no-repeat";
        style.textAlign = "center";
        style.lineHeight = "26px";
        style.paddingTop = "2px",
            style.fontSize = "14px",
            style.right = "300px",
            style.color = "#fff",
            style.border = "none";
        style.cursor = "pointer";
        this.div.title = this.title;
        this.div.className = this.classNm;
        this.div.innerHTML = this.content;

        var panes = this.getPanes();
        panes.overlayMouseTarget.appendChild(div);
        var _this = this;
        this.div.onclick = function(){
            _this.clickFun(_this);
        }
    };
    MyOverlay.prototype.draw = function(){
        var projection = this.getProjection();
        var pixel = projection.fromLatLngToDivPixel(this.position);
        var style = this.div.style;
        style.left = pixel.x - 13.5 + "px";
        style.top = pixel.y - 16 + "px";
    };
    MyOverlay.prototype.destroy = function(){
        this.div.onclick = null;
        this.div.parentNode.removeChild(this.div);
        this.div = null;
    };
}

//登录提示框
function showPrdDetailUserLogin(){
    var dialog = jDialog.confirm('您还没有登录',{
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

/*缺货通知*/
function clean(){
    //在窗口关闭的时候清除上一个到货通知选择的数据
    tempObject = "";
    console.log(typeof tempObject);
}

var tempObject ;
function quehuoDetailbtn(object){
    //先判断用户是否登录
    if(undefined == webPath.userId || null == webPath.userId || "" == webPath.userId){
        showPrdDetailUserLogin();
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




