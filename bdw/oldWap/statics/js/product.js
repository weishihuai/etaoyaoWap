var page;
$(document).ready(function(){

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
                xyPop({content:result.errorObject.errorText,type: "error"});
            }
        }
    });

    //判断商品是否被当前用户收藏，如果被收藏星星为红色
    if(isCollect == "true"){
        $("#AddTomyLikeBtn").css("background-image","url('../template/bdw/wap/statics/images/icon-collect-red.png')");
    }else{
        $("#AddTomyLikeBtn").css("background-image","url('../template/bdw/wap/statics/images/icon-collect.png')");
    }

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



    $(".confirm").click(function(){
        $(".baiduShare").css("display","none");
    });

    //邮件通知按钮
    $("#quehuobtn").click(function(){
        var skuId=   $("#quehuobtn").attr("skuid");
        if(skuId==""){
            popover("quehuobtn","top","温馨提示","请选择商品规格");
        }
        $.ajax({
            url:webPath.webRoot+"/member/saveProductArrivalNotice.json",
            data:{skuId:skuId,userInformWay:"0"},
            dataType: "json",
            success:function(data) {
                var result=data.result;
                if(result=="nologin"){
                    popover("bottemlogo","top","温馨提示","请先登录");
                    goToUrl(webPath.webRoot+"/wap/login.ac");
                    return;

                }
                if(result){
                    popover("quehuobtn","top","温馨提示","登记成功，请耐心等候我们的邮件通知");
                }else{
                    popover("quehuobtn","top","温馨提示","你已登记成功，无须再次登记，请耐心等候我们的邮件通知");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop(result.errorObject.errorText, {type: "error"});
                }
            }
        });


    });
    //短信通知按钮
    $("#mobileMessageBtn").click(function(){
        var skuId=   $("#mobileMessageBtn").attr("skuid");
        if(skuId==""){
            popover("mobileMessageBtn","top","温馨提示","请选择商品规格");
        }
        $.ajax({
            url:webPath.webRoot+"/member/saveProductArrivalNotice.json",
            data:{skuId:skuId,userInformWay:"1"},
            dataType: "json",
            success:function(data) {
                var result=data.result;
                if(result=="nologin"){
                    popover("bottemlogo","top","温馨提示","请先登录");
                    goToUrl(webPath.webRoot+"/wap/login.ac");
                    return;

                }
                if(result){
                    popover("mobileMessageBtn","top","温馨提示","登记成功，请耐心等候我们的短信通知");
                }else{
                    popover("mobileMessageBtn","top","温馨提示","你已登记成功，无须再次登记，请耐心等候我们的短信通知");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    xyPop(result.errorObject.errorText, {type: "error"});
                }
            }
        });


    });
    // 未填手机号弹框
    $("#withoutMobile").click(function(){
        popover("withoutMobile","top","温馨提示","请先到个人资料中填写手机号码");
    });
    $("#withoutEmail").click(function(){
        popover("withoutEmail","top","温馨提示","请先到个人资料中填写电子邮箱");
    });
    //组合套餐按钮
    var comboselect=$(".combo > h5").find("a").click(function(){
        comboselect.removeClass("cur");
        $(this).addClass("cur");
        var comboid=$(this).attr("comboid");
        $(".combobox").hide();
        $("#combos"+comboid).show();
    });

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

    //PC版商品图片用，wap版无用
    /*function mycarousel_initCallback(carousel) {
     $('#mycarousel-next').bind('click', function() {
     carousel.next();
     return false;
     });

     $('#mycarousel-prev').bind('click', function() {
     carousel.prev();
     return false;
     });
     }*/

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
            $("#selectNum").html("0");
            $("#dapei").find("input:checked").attr("checked",false);
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

    if($(".mp2-item").length > 0){
        $(".gg_btn").first().trigger("click");
        //alert($(".gg_btn").first().attr("data-value"));
    }

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

    //收藏商品与取消商品收藏
    $("#AddTomyLikeBtn").click(function(){
        if(webPath.productId == '' || webPath.productId == undefined){
            return ;
        }
        //判断当前用户是否收藏该商品
        if(isCollect == "true"){
            $.ajax({
                type:"POST",url:webPath.webRoot+"/member/delUserProductCollect.json",
                data:{items:webPath.productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        popover('AddTomyLikeBtn','top','商品收藏','成功取消收藏!');
                        $("#AddTomyLikeBtn").css("background-image","url('../template/bdw/wap/statics/images/icon-collect.png')");
                        isCollect = "false";
                    }else{
                        xyPop({content:'系统错误,请刷新重新操作!',type:'error'});
                    }
                }
            });

        }else{
            $.get(webPath.webRoot+"/member/collectionProduct.json?productId="+webPath.productId,function(data){
                if(data.success == "false"){
                    if(data.errorCode == "errors.login.noexist"){
                            window.location.href = webPath.webRoot+"/wap/login.ac";
                        return;
                    }
                    if(data.errorCode == "errors.collection.has"){
                        $("#AddTomyLikeBtn").css("background-image","url('../template/bdw/wap/statics/images/icon-collect-red.png')");    //AddTomyLikeBtn

                    }
                }else if(data.success == true){
                    popover('AddTomyLikeBtn','top','商品收藏','商品收藏成功!');
                    $("#AddTomyLikeBtn").css("background-image","url('../template/bdw/wap/statics/images/icon-collect-red.png')");
                    isCollect = "true";

                }
            });
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
                if (data.success == "false") {
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

    //多规格默认选中(先去掉)
    /*$(".specSelect").each(function(){
     $(this).find("a:first").each(function(){
     this.click();
     });
     });*/
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
    var remainStock = sku.currentNum - sku.safetyStock;
    if(sku.currentNum==0 || sku.currentNum<=sku.safetyStock ){
        $(".addTobuyCar").hide('');
        $(".addcart2").hide('');
        $(".quehuo").show('');
        $(".quehuobtn").attr("skuid",sku.skuId);

        //显示"缺货"的信息
        //$(".quehuoNotify").css("display","block");

        $(".batch_addcart").removeClass("enable");
        $(".batch_addcart").addClass("disable");
        $(".batch_addcart").html("库存不足");
        $("#stock").html("(库存" + 0 + "件)");
        /*$(".combo_addcart").removeClass("enable");
        $(".combo_addcart").addClass("disable");
        $(".combo_addcart").html("商品缺货");*/
        //return;
    }else{
        $(".addTobuyCar").show('');
        $(".addcart2").show('');
        $(".quehuo").hide('');
        if (remainStock != null) {
            if (remainStock > 0) {
                $("#stock").html("(库存" + price.remainStock + "件)");
            }
        }
        //隐藏"缺货"的信息
        $(".quehuoNotify").css("display","none");

        $(".batch_addcart").removeClass("disable");
        $(".batch_addcart").addClass("enable");
        $(".batch_addcart").html("购买搭配套餐");

        /*$(".combo_addcart").removeClass("disable");
        $(".combo_addcart").addClass("enable");
        $(".combo_addcart").html("购买组合套餐");*/
    }

    //显示价格
    $("#price").html("￥"+price.unitPrice);

    //市场价也要随着规格变化
    if(sku.marketPrice !=null && sku.marketPrice != '0' && sku.marketPrice!='0.0'){
        $("#marketPrice").html("¥" + sku.marketPrice);
    }

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

//清空商品的cookie
var clearHistoryProductsCookie = function(divId){
    $.get(webPath.webRoot+"/member/clearProductsCookie.json",function(data){
        $(divId).html("<ul><li style='text-align: center;'>您还未浏览其它商品</li></ul>");
    });
};

function toCompage(pagenumber){
    page = pagenumber;
    loadConment();
}

//加载商品评论
function loadConment(){
    var url =webPath.webRoot+"/wap/productCommentList.ac?id="+webPath.productId+"&page="+page;
    $("#priceM").load(url);
}

//页面四个tab的切换
function showTab(param,object){
    $(object).parent('.tab-nav-item').parent('.tab-nav').children().removeClass("active");
    $(object).parent('.tab-nav-item').addClass("active");
    $('#'+param).parent().children().css("display","none");
    $('#'+param).css("display","block");
    if(param == "priceM"){
        loadConment();
    }
}

//让jiaThis的div在页面垂直居中，不要显示在页面最上端
function centerJiaThis(){
    $('#share').on('show.bs.modal', function (e) {
        $(this).find('.modal-dialog').css({
            'margin-top': function () {
                var modalHeight = $('#share').find('.modal-dialog').height();
                return ($(window).height() / 2 - (modalHeight / 2));
            }
        });
    });
}

function noCustomService(){
    xyPop.msg('此店铺暂时没有配置客服!',{type:'warning',time:2});
}
