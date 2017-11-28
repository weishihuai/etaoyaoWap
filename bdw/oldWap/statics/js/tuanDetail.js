var skuData = eval(pageData.skuIds);
var userSpecValueData = [];
var allSpecValueIds = [];
var selectSpecValues = [];
var userSpecData = eval(pageData.specJsonData);

    if(userSpecData!=null){
        buildData();
    }
    function buildData(){
        if(userSpecData == null){
            return;
        }
        for (var spd = 0; spd < userSpecData.length; spd++) {
            var productUserSpec =  userSpecData[spd].specValueProxyList;
            for(var usp=0;usp<productUserSpec.length;usp++){
                var specValueId= productUserSpec[usp].specValueId;
                var name= productUserSpec[usp].name;
                var relPicId= productUserSpec[usp].relPictId;
                var specId= userSpecData[spd].specId;

                allSpecValueIds.push(specValueId);
                userSpecValueData.push({
                    specId:specId,
                    specValueId:specValueId,
                    specValueNm:name,
                    relPicId:relPicId
                });
            }
        }
    }
$(function(){

    // 倒计时
    $(".tuanEnd").imallCountdown(pageData.endTimeStr, 'tuanEnd', pageData.systemTime);
    $(".tuanStart").imallCountdown(pageData.endTimeStr, 'tuanStart', pageData.systemTime);


    if(skuData.length == 1){
        $(".buy-btn").attr("objectid",skuData[0].groupBuySkuId);
    }

   $(".buy-btn").click(function(){
       // 如果规格没有弹出来,则进行弹出操作,否则进行结算
       if(!$(".buy-btn").hasClass("gotoPay")){
           $(".overlay").css("display","block");
           $(".buy-btn").addClass("gotoPay");
       } else {
           // 结算
           $.ajax({
               url: webPath.webRoot + "/cart/canTuan.json",
               type: 'POST',
               success: function (data) {
                   if (data.success == "true") {
                       // 进行结算
                       settleAccount($(".buy-btn"));
                   } else {
                       location.href = webPath.webRoot + "/wap/login.ac";
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
   });

    $(".p-props").click(function(){
        if(pageData.gapTime > 0){
            $(".overlay").css("display","block");
            $(".buy-btn").addClass("gotoPay");
        }
    });

    $(".close").live('click', function(){
        $(".buy-btn").removeClass("gotoPay");
        $(".overlay").css("display","none");
    });

    // 当数值发生变化时
   $("#itxt").change(function(){
       // 清空错误日志消息
        $(".msg").html("");
       var number = $("#itxt").val();
       // 添加数量校验
       var numberReg = /^[0-9]*$/;
       if(!numberReg.test(number) || number == '0'){
           $(".msg").html("请输入正确的数值");
           $("#itxt").val(1);
           return;
       }
       var storeNumStr = $("#store").html();
       var storeNum = parseInt(storeNumStr.replace(/[^0-9]/ig,""));
       if(number > 1){
           $(".decrement").removeClass("disabled");
           $(".increment").removeClass("disabled");
       }
       if(parseInt(number) > parseInt(storeNum)){
           $("#itxt").val(storeNum);
           $(".msg").html("最多只能购买" + storeNum + "件");
           $(".increment").addClass("disabled");

       }
   });
    // 增加按钮事件
    $(".increment").click(function(){
        if($(".increment").hasClass(".disabled")){
            return;
        }
        // 清空错误日志消息
        $(".msg").html("");
        var number = $("#itxt").val();
        number = parseInt(number) + 1;
        var storeNumStr = $("#store").html();
        var storeNum = parseInt(storeNumStr.replace(/[^0-9]/ig,""));
        if(number > storeNum){
            $(".increment").addClass("disabled");
            return;
        }
        $(".itxt").val(number);
        if(number > 1){
            $(".decrement").removeClass("disabled");
        }

    });

    // 减少按钮事件
    $(".decrement").click(function(){
        if($(".decrement").hasClass(".disabled")){
            return;
        }
        // 清空错误日志消息
        $(".msg").html("");
        var number = $("#itxt").val();
        if(number <= 1){
            $(".decrement").addClass("disabled");
            return;
        }
        number = parseInt(number) - 1;
        $(".itxt").val(number);

    });

    $(".m-td").find("a").click(function(){

        if ($(this).hasClass("disable")) {
            return;
        }

        if($(this).hasClass("active")){
            $(this).removeClass("active");
        } else{
            $(this).parent().find("a").removeClass("active");
            $(this).addClass("active");
            $(this).trigger("blur");
        }

        // 取得规格值
        var data_values = $(this).attr("data-value");
        var data_value = data_values.split(":");
        var dataObject = {specId : parseInt(data_value[0]), specValueId : parseInt(data_value[1])};
        pushSelected(dataObject);

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
        displaySelectSpecValue(selectSpecArray);

        $(".disable").removeClass("disable");

        var unSelectSpecValue = [];
        var filterSpecValueIds = [];
        var filterSkuData = skuData;

        for (var i = 0; i < selectSpecValues.length; i++) {
            filterSkuData = filterSkuDatas(selectSpecValues[i].specValueId, filterSkuData);
            var selectSpecIDs = [];
            for(var spd = 0;spd <= i;spd++){
                selectSpecIDs[spd] = selectSpecValues[spd].specId;
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
            $(".m-td").find("a").each(function () {
                var data_value = $(this).attr("data-value");
                var specValueId = parseInt(data_value.split(":")[1]);
                if (unSelectSpecValue[s] == specValueId) {
                    $(this).addClass("disable");
                }
            });
        }

        if (skuDatas.length == 1 && $(".m-td").size() == selectSpecValues.length) {
            selectSku(skuDatas[0]);
        }else{
            for(var i = 0 ; i < userSpecData.length; i ++){
                if(selectSpecValues[0].specId != userSpecData[i].specId){
                    $("#tipMsg").html("请选择 " + userSpecData[i].name);
                }
            }
           // $("#tipMsg").html("没有选择完整的规格商品");
            //$("#store").html("");
            //$("#stockNum").val("");
        }
    });

    //收藏店铺按钮
    $(".shopCollect").click(function(){
        var obj = $(this);
        var shopId = obj.attr("shopId");
        if (shopId == '' || shopId == undefined) {
            return;
        }
        if(obj.attr("isCollect") == 'false'){
            $.get(webPath.webRoot + "/member/collectionShop.json?shopId=" + shopId, function (data) {
                if (data.success == false) {
                    if (data.errorCode == "errors.login.noexist") {
                        window.location.href = webPath.webRoot + "/wap/login.ac";
                    }
                } else if (data.success == true) {
                    $(obj).addClass("cur");
                    obj.attr("isCollect","true");
                    obj.html("已收藏");
                    popover('shopCollect','top','店铺收藏','店铺收藏成功!');
                }
            });
        }
        else{
            $.ajax({
                type:"POST",url:webPath.webRoot+"/member/delUserShopCollect.json",
                data:{items:shopId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        popover('shopCollect','top','店铺收藏','已取消店铺收藏!');
                        obj.removeClass("cur");
                        obj.attr("isCollect","false");
                        obj.html("收藏店铺");
                    }else{
                        xyPop({content:'系统错误,请刷新重新操作',type:'error'});
                    }
                }
            });
        }
    });

});
    // 增加或者删除规格
    function pushSelected(pushObject){
        var operationFlag = true;
        var addIndex = -1;
        for(var i = 0; i < selectSpecValues.length; i ++){
            var specId = selectSpecValues[i].specId;
            var specValueId = selectSpecValues[i].specValueId;
            // 如果相同说明点击是同一个规格,进行删除操作
            if(pushObject.specId == specId){
                addIndex = i;
                if(pushObject.specValueId == specValueId){
                    operationFlag = false;
                    break;
                }
            }
        }
        // 增加
        if(operationFlag){
            if(addIndex < 0){
                selectSpecValues.push(pushObject);
            } else{
                selectSpecValues[addIndex] = pushObject;
            }
        } else{
            selectSpecValues.splice(addIndex, 1);
        }
    }
    //sku过滤器
    function filterSkuDatas(specValueId, skuDatas) {
        var result = [];
        for (var i = 0; i < skuDatas.length; i++) {
            var specValueIds = eval(skuDatas[i].skuJsonData);
            if ($.inArray(specValueId,specValueIds) >= 0) {
                result.push(skuDatas[i]);
            }
        }
        return result;
    }
    //显示已选择的规格值
    function displaySelectSpecValue(nameArray){
        $("#tipMsg").html("");
        if(nameArray.length == 0){
            $("#tipMsg").append("请选择 ");
            for(var i = 0 ; i < userSpecData.length; i ++){
                    $("#tipMsg").append(userSpecData[i].name + ",");
            }
        } else{
            $("#tipMsg").append("已选择 ");
            for(var i = 0; i < nameArray.length; i ++){
                $("#tipMsg").append("<b>" + "\"" + nameArray[i] + "\"" + "</b>");
                $("#tipMsg").append(" ");
            }
        }
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
        var skuJsonData = eval(filterDatas[i].skuJsonData);
        if ($.inArray(selectSpecValueId, skuJsonData) >= 0) {
            for(var a=0;a<skuJsonData.length;a++){
                canSelects.push(skuJsonData[a]);
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
        var sku = skuData;
        var price = sku.groupBuyPrice;
        if(sku.groupBuyStockQuantity==0){
            alert("该商品缺货");
            return;
        }
        //选择规格的时候显示库存
        $("#store").html("(库存"+sku.groupBuyStockQuantity+"件)");
        $("#stockNum").val(sku.groupBuyStockQuantity);
        //显示价格
        $("#groupBuyPrice").html('￥' + price);
        $(".buy-btn").attr("objectid",sku.groupBuySkuId);
    }
    // 多规格商品
    function settleAccount(obj){
        var objectid = obj.attr("objectid");
        var num = $("#itxt").val();
        var carttype = obj.attr("carttype");
        var handler = obj.attr("handler");
        if(undefined == num || null == num || "" == num || parseInt(num) <= 0){
            alert("请输入购买数量");
            return;
        }
        if($(".m-td").size() != selectSpecValues.length){
            alert("请选择商品规格");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/tuanAdd.json",
            data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
            dataType: "json",
            success:function(data) {
                if(data.success == "true"){
                    window.location.href=webPath.webRoot+"/wap/shoppingcart/orderadd.ac?handler=groupBuy&carttype=groupBuy&isCod=N";
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    }