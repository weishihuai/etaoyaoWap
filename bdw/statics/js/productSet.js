$(document).ready(function(){

    var selectSpecValues = new Array();
    var allSpecValueIds = new Array();
    var userSpecValueData = new Array();
    var skuData;
    buildData();

    $(".specSelect").find("a").click(function () {

        var data_values = $(this).attr("data-value");
        var data_value = data_values.split(":");
        var specObject = {specId:parseInt(data_value[0]), specValueId:parseInt(data_value[1])};
        var productId= data_value[2];

        for (var p = 0; p < productDatas.length; p++) {
            if (productDatas[p].productId == productId) {
                var thisSelectSpecValues = productDatas[p].selectSpecValues;
                if (thisSelectSpecValues == undefined) {
                    thisSelectSpecValues = new Array();
                    productDatas[p].selectSpecValues = thisSelectSpecValues
                }
                selectSpecValues = thisSelectSpecValues;


                var thisAllSpecValueIds = productDatas[p].allSpecValueIds;
                if (thisAllSpecValueIds == undefined) {
                    thisAllSpecValueIds = new Array();
                    productDatas[p].allSpecValueIds = thisAllSpecValueIds;
                }
                allSpecValueIds = thisAllSpecValueIds;

                var thisUserSpecValueData = productDatas[p].userSpecValueData;
                if (thisUserSpecValueData == undefined) {
                    thisUserSpecValueData = new Array();
                    productDatas[p].userSpecValueData = new Array();
                }
                userSpecValueData = thisUserSpecValueData;

                skuData =  productDatas[p].skuJons ;
            }

        }


        if ($(this).hasClass("lock")) {
            return;
        }

        if ($(this).hasClass("cur")) {
            $(this).removeClass("cur");
        } else {
            $(this).parent().parent().find("a").removeClass("cur");
            $(this).addClass("cur");
        }

        //加入或移除
        pushSelected(specObject);


        var skuDatas = skuData;
         for (var i = 0; i < selectSpecValues.length; i++) {
            //过滤没有包含选择规格值ID的规格组合
            skuDatas = filterSkuDatas(selectSpecValues[i].specValueId, skuDatas);
          }

        $(".lock").removeClass("lock");
        var unSelectSpecValue = new Array();

        var filterSpecValueIds = new Array();
        for (var i = 0; i < selectSpecValues.length; i++) {
            filterSpecValueIds.push(selectSpecValues[i].specValueId);
            filterUnSelectSpecValueIds(unSelectSpecValue,filterSpecValueIds,selectSpecValues[i].specId);
        }

        for (var s = 0; s < unSelectSpecValue.length; s++) {
            $(".productSet_"+productId).find(".specSelect").find("a").each(function () {
                var data_value = $(this).attr("data-value");
                var specValueId = parseInt(data_value.split(":")[1]);
                if (unSelectSpecValue[s] == specValueId) {
                    $(this).addClass("lock");
                }
            });
        }

        if (skuDatas.length == 1 && $(".productSet_"+productId).find(".specSelect").size() == selectSpecValues.length) {
            $("#buyNow_"+productId).attr("skuid",skuDatas[0].sku.skuId);
            $("#buyNow_"+productId).attr("specNm",skuDatas[0].sku.specNm);
            $("#buyNow_"+productId).attr("price",skuDatas[0].price.unitPrice);
            $(".priceValue_"+productId).html(skuDatas[0].price.unitPrice);
        }else{
            $("#buyNow_"+productId).attr("skuid","");
        }
    });


    $(".buyNow").click(function(){
        var skuid=$(this).attr("skuid");
        if(skuid==""){
            alert("请选择商品规格");
            return;
        }
        var productNm=$(this).attr("productNm");
        var specNm=$(this).attr("specNm");
        var price=$(this).attr("price");
        var productId=$(this).attr("productId");
        var num=$("#buyNum_"+productId).val();
        var totalPrice= parseFloat($(".yesTotal").find("span").text())
        totalPrice=totalPrice+(parseFloat(price)*parseInt(num));
        var object=skuid+":"+num;
        var tmpl=' <li><p><a rel="" title="" target="_blank" href="javascript:;">'+productNm+'('+specNm+')</a></p><div class="yesPrice"><a class="yesDelect" href="javascript:;"><em></em><span onclick="clearItem($(this),'+price+','+num+')">移除</span></a>￥'+price+' ×'+num+'</div> <input type="hidden" value="'+object+'"/></li>';
        $(".yesSelectedList").append(tmpl);
        $(".yesTotal").find("span").html(totalPrice);



    })
    $(".batch_addcart").click(function(){
        var carttype=$(this).attr("carttype");
        var handler=$(this).attr("handler");
        var skuIds=new Array();
        $(".yesSelectedList").find("input").each(function(){
            skuIds.push($(this).val());
        });
        if(skuIds.length==0){
            alert("请选择商品");
            return;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/addProductSet.json",
            data:{type:carttype,objectIds:skuIds.join(","),handler:handler},
            dataType: "json",
            success:function(data) {

                window.location.href=webPath.webRoot+"/shoppingcart/cart.ac"
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });

    });



    function buildData(){

        for(var p=0;p<productDatas.length;p++){
            var userSpecData = productDatas[p].userSpecData;
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
                    productDatas[p].allSpecValueIds=allSpecValueIds;
                    productDatas[p].userSpecValueData=userSpecValueData;
                }
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

    //sku过滤器
    function filterSkuDatas(specValueId, skuDatas) {
        var result = new Array();
        for (var i = 0; i < skuDatas.length; i++) {
            if ($.inArray(specValueId, skuDatas[i].specValueIds) >= 0) {
                result.push(skuDatas[i]);
            }
        }
        return result;
    }

    //选择过滤器
    function filterUnSelectSpecValueIds(unSelectSpecValue,selectSpecValueIds,specId) {
        var canSelects = new Array();
        var filterSpecValueIds = new Array();
        if (selectSpecValueIds == undefined) {
            return  unSelectSpecValue;
        }

        for(var us = 0; us < userSpecValueData.length; us++){
            if(userSpecValueData[us].specId!=specId){
                filterSpecValueIds.push(userSpecValueData[us].specValueId);
            }
        }

        for (var i = 0; i < skuData.length; i++) {
            var specValueIds = skuData[i].specValueIds;
            for(var sv=0;sv<selectSpecValueIds.length;sv++){
                if ($.inArray(selectSpecValueIds[sv], specValueIds) >= 0) {
                    for(var a=0;a<specValueIds.length;a++){
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

});
function clearItem(item,price,num){
    item.parent().parent().parent().remove();
    var totalPrice= parseFloat($(".yesTotal").find("span").text())
    totalPrice=totalPrice-(parseFloat(price)*parseInt(num));
    $(".yesTotal").find("span").html(totalPrice);


}