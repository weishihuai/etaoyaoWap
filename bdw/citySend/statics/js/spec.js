$(function(){
    $(".btn-close").click(function () {
        $("#multiSpecSel").hide();
    });

    $("#circleli li").hover(function () {
        var imageIndex = $(this).attr("image-index");
        $(".ig-item").css("display","none");
        $("#ig" + imageIndex).css("display", "block");
        $("#circleli li").removeClass("active");
        $(".circle" + imageIndex).addClass("active");
    });


    var selectSpecValues = [];
    var allSpecValueIds = [];
    var userSpecValueData = [];
    if(userSpecData!=null){
        buildData();
    }


    $(".specSelect").find(".item").click(function () {

        if ($(this).hasClass("lock")) {
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
            $(".specSelect").find("span").each(function () {
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
            $("#price").html("<small>&yen;&nbsp;</small>" + $("#priceListStr").val());
            $(".addCart").attr("skuid", "");//清除掉加入购物车的skuid
            $(".priceNm").html($("#priceListStr").attr("priceNm") + "：")
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
                //displaySpecRefPic(useSpecValue.relPicId)
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
        if(sku.marketPrice !=null && sku.marketPrice != '0' && sku.marketPrice!='0.0'){
            $("#marketPrice").html("&yen;"+sku.marketPrice);
        }
        if (remainStock != null) {
            if (remainStock > 0) {
                $("#stock").html(price.remainStock);
                $("#addProductCart").attr("remainStock", price.remainStock);
                $("#remainStock").val(price.remainStock)
            }
        }
        $(".addStoreCart").attr("skuid", sku.skuId);
    }

    $(".addStoreCart").click(function () {
        var addbtn = $(this);
        var skuId = addbtn.attr("skuid");
        var num = addbtn.attr("num");
        var carttype = addbtn.attr("carttype");
        var handler =addbtn.attr("handler");
        var orgid = addbtn.attr("orgid");
        if(skuId==""){
            breadStoreJDialog("请选择商品规格",1300,"10px",true);
            return;
        }
        if(num==""){
            breadStoreJDialog("请填写购买数量",1300,"10px",true);
            return;
        }
        $.ajax({
            url: paramData.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    $("#modelDialog").hide();
                    breadStoreJDialog("加入购物车成功", 1300, "20px", true);
                    //重新加载当前门店的购物车
                    reloadHideCart(orgid);
                }else{
                    showMultiSpecLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadStoreJDialog(result.errorObject.errorText,1300,"20px",true);
                }
            }
        });

    });
});


function reloadHideCart(orgId){
    $("#storeCart").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam,orgId:orgId},function(){
        $("#storeCartLayer").css("right", "50px");
        $("#singleStoreCart").css("display","none");
    });
}

//没有标题和按钮的提示框
function breadStoreJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}


//登录提示框
function showMultiSpecLoginLayer(){
    var dialog = jDialog.confirm('<span style="margin-left: 10px">您还没有登录!</span>',{
        type : 'highlight',
        text : '登录',
        handler : function(button,dialog) {
            dialog.close();
            window.location.href = paramData.webRoot + "/login.ac";
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