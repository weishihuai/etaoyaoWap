$(function () {
    //商品加减按钮
    $(".prd_subNum").click(function(){
        var value=   $(this).next("input").val();
        var num=parseInt(value)-1;
        if(num==0){
            return;
        }
        $(this).next("input").val(num);
        $(".addcart").attr("num",num);
        $(".addcart2").attr("num",num);
        $(".fenqi_cart").attr("num",num);
    });
    $(".prd_num").change(function(){
        var value= $(this).val();
        var reg=new RegExp("^[1-9]\\d*$");
        if(!reg.test(value)){
            $(this).val(1);return;
        }
        $(".addcart").attr("num",value);
        $(".addcart2").attr("num",value);
        $(".fenqi_cart").attr("num",value);
    });
    $(".prd_addNum").click(function(){
        var value=   $(this).prev("input").val();
        var num=parseInt(value)+1;
        $(this).prev("input").val(num);
        $(".addcart").attr("num",num);
        $(".addcart2").attr("num",num);
        $(".fenqi_cart").attr("num",num);
    });

    var selectSpecValues = [];
    var allSpecValueIds = [];
    var userSpecValueData = [];
    if(userSpecData!=null){
        buildData();
    }
    $(".specSelect").find(".gg_btn").click(function () {

        if ($(this).hasClass("lock")) {

            //$(this).removeClass("g_cur");
            //$(this).removeClass("lock")
            return;
        }

        if ($(this).hasClass("g_cur")) {
            $(this).removeClass("g_cur");
            $(this).className='gg_btn';
        } else {
            $(this).siblings(".gg_btn").removeClass("g_cur");
//            $(this).parent().parent().find(".gg_btn").removeClass("lock");
            $(this).addClass("g_cur");
//            $(this).addClass("lock")
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

        //展示选择的规格
        //displaySelectSpecValue(selectSpecArray);

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
            $(".specSelect").find(".gg_btn").each(function () {
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
            $("#price").html("￥"+$("#priceListStr").val());

            //搭配商品那里也要跟着规格变化而变化价格
            $("#packagePrice").html("￥"+$("#priceListStr").val());

            $(".addcart").attr("skuid","");
            $(".addcart2").attr("skuid","");
            $(".fenqi_cart").attr("skuid","");
            $(".addTobuyCar").show('');
            $(".addcart2").show('');
            $(".quehuo").hide('');
            $("#specialPrice").hide();
            $(".priceNm").html($("#priceListStr").attr("priceNm")+"：")
        }
    });

    function buildData(){
        if(userSpecData == null){
            return;
        }
        for (var spd = 0; spd < userSpecData.length; spd++) {
            var productUserSpec =  userSpecData[spd].specValueProxyList;
            for(var usp=0;usp<productUserSpec.length;usp++){
                var specValueId= productUserSpec[usp].specValueId;
                var userDefinedName= productUserSpec[usp].userDefinedName;
                var name= productUserSpec[usp].name;
                var relPicId= productUserSpec[usp].relPictId;
                var specId= userSpecData[spd].specId;

                allSpecValueIds.push(specValueId);
                userSpecValueData.push({
                    specId:specId,
                    specValueId:specValueId,
                    specValueNm:(userDefinedName!=undefined&&$.trim(userDefinedName).length>0)?userDefinedName:name,
                    relPicId:relPicId
                });
            }
        }
    }

    //根据规格ID取出规格值
    function getUseSpecValue(specValueId){
        for(var i=0;i<userSpecValueData.length;i++){
            if(userSpecValueData[i].specValueId==specValueId){
                return userSpecValueData[i];
            }
        }
    }

    //显示已选择的规格值
    //function displaySelectSpecValue(nameArray) {
    //    $("#selecSpec").html("已选择:");
    //    $("#specValue").html("");
    //    for (var i = 0; i < nameArray.length; i++) {
    //        if (i != 0) {
    //            $("#selecSpec").append("、");
    //            $("#specValue").append("、");
    //        }
    //        $("#selecSpec").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
    //        $("#specValue").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
    //    }
    //}

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
            if(useSpecValue.relPicId!=undefined&&$.trim(useSpecValue.relPicId).length>0){
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
        var result = [];
        for (var i = 0; i < skuDatas.length; i++) {
            if ($.inArray(specValueId, skuDatas[i].specValueIds) >= 0) {
                result.push(skuDatas[i]);
            }
        }
        return result;
    }

    //选择过滤器
    function filterUnSelectSpecValueIds(selectSpecIds,unSelectSpecValue,filterDatas,selectSpecValueId) {
        var canSelects = [];
        var filterSpecValueIds = [];
        if (selectSpecValueId == undefined) {
            return  unSelectSpecValue;
        }

        for(var us = 0; us < userSpecValueData.length; us++){
            var isSelectSpecId=false;
            for(var spId=0;spId<selectSpecIds.length;spId++){
                if(selectSpecIds[spId]==userSpecValueData[us].specId){
                    isSelectSpecId =true;
                }

            }
            if(!isSelectSpecId){
                filterSpecValueIds.push(userSpecValueData[us].specValueId);
            }
        }


        for (var i = 0; i < filterDatas.length; i++) {
            var specValueIds = filterDatas[i].specValueIds;
            if ($.inArray(selectSpecValueId, specValueIds) >= 0) {
                for(var a=0;a<specValueIds.length;a++){
                    canSelects.push(specValueIds[a]);
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
});

//显示规格关联图片(PC端才需要，wap端注释)
function displaySpecRefPic(pic){
    $("#mycarousel").find("a").each(function(){
        var rel = eval("(" + $.trim($(this).attr('rel')) + ")");
        if(pic==$(this).attr("picId")){
            $("#bigsrc").attr("src",rel.smallimage);
            $(".jqzoom").attr("href",rel.largeimage);
        }
    });
}

//显示已选择的规格值（新版商品页不显示，注释掉）
/*function displaySelectSpecValue(nameArray){
 $("#selecSpec").html("选择规格:");
 $("#specValue").html("");
 for(var i=0;i<nameArray.length;i++){
 if (i != 0) {
 $("#specValue").append("、");
 }
 $("#specValue").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
 }
 }*/

//选择多种规格后得到SKU
function selectSku(skuData) {
    var sku = skuData.sku;
    var price = skuData.price;
    if(sku.currentNum==0 || sku.currentNum<=sku.safetyStock ){
        $(".addTobuyCar").hide('');
        $(".addcart2").hide('');
        $(".quehuo").show('');
        $(".quehuobtn").attr("skuid",sku.skuId);
        return;
    }else{
        $(".addTobuyCar").show('');
        $(".addcart2").show('');
        $(".quehuo").hide('');
    }

    //显示价格
    $("#price").html("￥"+price.unitPrice);

    //搭配商品那里也要跟着规格变化而变化价格
    $("#packagePrice").html("￥"+price.unitPrice);

    $("#dapeiprice").html("￥<b>" + price.unitPrice + "</b>") ;

    //因为如果搭配商品那里已经有商品被选中再选中其他规格，显示价格会不一致，所以选取其他规格的时候把所有搭配商品的checkbox取消
    $("[name='packageItem']").removeAttr("checked");
    $("#selectNum").html(0);

    $("#dapei_skuId").val(sku.skuId);
    $("#dapei_skuprice").val(price.unitPrice);
    $(".addcart").attr("skuid",sku.skuId);
    $(".addcart2").attr("skuid",sku.skuId);
    $(".fenqi_cart").attr("skuid",sku.skuId);

    //组合套餐
    if(price.isSpecialPrice){
        $("#specialPrice").show();
        $("#lesTime").imallCountdown(price.endTimeStr,"none",webPath.systemTime);
        $(".priceNm").html(price.amountNm+"：")
    }else{
        $("#specialPrice").hide();
        $(".priceNm").html(price.amountNm+"：")
    }

}