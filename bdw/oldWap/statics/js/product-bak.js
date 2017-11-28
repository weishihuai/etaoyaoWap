var page;
$(document).ready(function(){
//    $( "#openDescription" ).on( "click", function(){
//        $("#productDescription").show();
//        $("#descriptionAlert").hide();
//    } );

    //判断商品是否被当前用户收藏，如果被收藏星星为红色
    if(isCollect == "true"){
        $("#AddTomyLikeBtn").css("color","red");
    }else{
        $("#AddTomyLikeBtn").css("color","#fff");
    }

    //图片展示开始
    $(".main_visual").hover(function(){
        $("#btn_prev,#btn_next").fadeIn()
    },function(){
        $("#btn_prev,#btn_next").fadeOut()
    });
    $dragBln = false;
    $(".main_image").touchSlider({
        roll:false,
        flexible : true,
        speed : 400,
        counter : function (e) {
            $("#slider").text(e.current+"/"+ e.total);
        }
    });
    $(".main_image").bind("mousedown", function() {
        $dragBln = false;
    });
    $(".main_image").bind("dragstart", function() {
        $dragBln = true;
    });
    $(".main_image a").click(function() {
        if($dragBln) {
            return false;
        }
    });

    $(".main_image").bind("touchstart", function() {
        clearInterval(timer);
    }).bind("touchend", function() {
            timer = setInterval(function() { $("#btn_next").click();}, 5000);
    });
    //图片展示结束

    $(".proList").each(function(){
        var width=580;
        $(this).find(".skuList").each(function(i){
            if(i>3){
                width=width+150;
            }
        });
        $(this).css("width",width+"px");
    });
    var productWidth=400;
    $("#referProductList").find(".productList").each(function(i){
        if(i>2){
            productWidth=productWidth+150;
        }
    });
    $("#referProductList").css("width",productWidth+"px");

    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var activeOrder = $(e.target).attr('href');

        if('#priceM'==activeOrder){
            loadConment();
        }

    });

    $(".quehuobtn").click(function(){
        var skuId=   $(".quehuobtn").attr("skuid");
        if(skuId==""){
//            alert("请选择商品规格");
            popover("quehuobtn","top","温馨提示","请选择商品规格");
        }
        $.ajax({
                    url:webPath.webRoot+"/member/saveProductArrivalNotice.json",
                    data:{skuId:skuId},
                    dataType: "json",
                    success:function(data) {
                        var result=data.result;
                        if(result=="nologin"){
//                            alert("请先登录1");
                            popover("bottemlogo","top","温馨提示","请先登录");
                            goToUrl(webPath.webRoot+"/login.ac?isFromLoginButton=no");
                            return;

                        }
                        if(result){
//                            alert("登记成功，请耐心等候我们的邮件通知");
                            popover("quehuobtn","top","温馨提示","登记成功，请耐心等候我们的邮件通知");
                        }else{
//                            alert("登记成功，请耐心等候我们的邮件通知");
                            popover("quehuobtn","top","温馨提示","登记成功，请耐心等候我们的邮件通知");
                        }
                    },
                    error:function(XMLHttpRequest, textStatus) {
                        if (XMLHttpRequest.status == 500) {
                            var result = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(result.errorObject.errorText);
                        }
                    }
                });


    });

    var comboselect=$(".combo > h5").find("a").click(function(){
        comboselect.removeClass("cur");
        $(this).addClass("cur");
        var comboid=$(this).attr("comboid");
        $(".combobox").hide();
        $("#combos"+comboid).show();
    });

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

    $("#dapei").find("input").click(function(){
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
        $("#dapeiprice").html(p.toFixed(2));
        $("#selectNum").html(num);
    });

    function mycarousel_initCallback(carousel) {
        $('#mycarousel-next').bind('click', function() {
            carousel.next();
            return false;
        });

        $('#mycarousel-prev').bind('click', function() {
            carousel.prev();
            return false;
        });
    }
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
            $(this).parent().parent().find(".gg_btn").removeClass("g_cur");
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
        displaySelectSpecValue(selectSpecArray);

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

        if (skuDatas.length == 1 && $(".specSelect").size() == selectSpecValues.length) {
            selectSku(skuDatas[0]);
        }else{
            $("#dapei_skuId").val("");
            $("#dapei_skuprice").val("");
            $("#dapeiprice").html("￥0.0");
            $("#price").html("销售价：￥<em>" + $("#priceListStr").val() + "</em>");
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
                        alert("取消收藏！");
                        $("#AddTomyLikeBtn").css("color","#fff");
                        isCollect = "false";
                    }else{
                        alert("系统错误,请刷新重新操作!");
                    }
                }
            });

        }else{
            $.get(webPath.webRoot+"/member/collectionProduct.json?productId="+webPath.productId,function(data){
            if(data.success == "false"){
                if(data.errorCode == "errors.login.noexist"){
                    confirm("您尚未登陆，请登陆!",{onSuccess:function(){
                        window.location.href = webPath.webRoot+"/wap/login.ac?isFromLoginButton=no";
                    }});
                    return;
                }
                if(data.errorCode == "errors.collection.has"){
                    $("#AddTomyLikeBtn").css("color","red");

                }
            }else if(data.success == true){
                alert("收藏成功！");
                $("#AddTomyLikeBtn").css("color","red");
                isCollect = "true";

            }
            });
        }

    });


    //多规格默认选中
    $(".specSelect").each(function(){
        $(this).find("button:first").each(function(){
            this.click();
        });
    });
});

//显示规格关联图片
function displaySpecRefPic(pic){
    $("#mycarousel").find("a").each(function(){
        var rel = eval("(" + $.trim($(this).attr('rel')) + ")");
        if(pic==$(this).attr("picId")){
            $("#bigsrc").attr("src",rel.smallimage);
            $(".jqzoom").attr("href",rel.largeimage);
        }
    });
}

//显示已选择的规格值
function displaySelectSpecValue(nameArray){
    $("#selecSpec").html("选择规格:");
    $("#specValue").html("");
    for(var i=0;i<nameArray.length;i++){
        if (i != 0) {
//            $("#selecSpec").append("、");
            $("#specValue").append("、");
        }
//        $("#selecSpec").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
        $("#specValue").append("  <b>" + "\"" + nameArray[i] + "\"" + " </b> ");
    }
}

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
    $("#price").html("销售价：￥<em>" + price.unitPrice + "</em>");
    $("#dapeiprice").html("￥<b>" + price.unitPrice + "</b>");
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

function tabChance(clickObj,showObj){
    $(".tabTitle").removeClass("cur");
    $(clickObj).addClass("cur");
    $(".tabBox").hide();
    $(showObj).show();
}

jQuery(function($) {
    $(document).ready( function() {
        //enabling stickUp on the '.navbar-wrapper' class
        $('.sort').stickUp();
    });
});
function toCompage(pagenumber){
    page = pagenumber;
    loadConment();
}
function loadConment(){
    var url =webPath.webRoot+"/wap/productCommentList.ac?id="+webPath.productId+"&page="+page;
    $("#priceM").load(url);
}