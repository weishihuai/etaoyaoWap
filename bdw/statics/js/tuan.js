/*

var selectSpecValues = new Array();
var allSpecValueIds = new Array();
var userSpecValueData = new Array();
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
    $("#countdownTime").imallCountdown('${groupBuy.endTimeString}','tuanSpan',webPath.systemTime);
    if(skuData.length==1){
        $(".addcart").attr("skuid",skuData[0].skuId);
        $("#groupBuyPrice").html(skuData[0].groupBuyPrice);
        $("#countStr").html("请填写您需要团购的商品数量");
        $("#selecSpecAll").html("");
    }
    $("#num").blur(function(){
        if($(this).val()==""){
            alert("数量不能为空");
            return;
        }
        $(".addcart").attr("num",$(this).val());
    })
    $("#addGroup").click(function(){
        $(".box").show();
    })

    $("#closeBox").click(function(){
        $(".box").hide();
    })

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
        var specObject = {specId:parseInt(data_value[0]), specValueId:parseInt(data_value[1])};

        //加入或移除
        pushSelected(specObject);


        var skuDatas = skuData;
        var selectSpecArray = new Array();
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
        var unSelectSpecValue = new Array();

        var filterSpecValueIds = new Array();
        var filterSkuData = skuData;

        for (var i = 0; i < selectSpecValues.length; i++) {
            filterSkuData = filterSkuDatas(selectSpecValues[i].specValueId, filterSkuData);
            var selectSpecIDs = new Array();
            for(var spd=0;spd<=i;spd++){
                selectSpecIDs[spd]=selectSpecValues[spd].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs,unSelectSpecValue,filterSkuData,selectSpecValues[i].specValueId);
        }
        var selectSpecValues1 =  selectSpecValues.reverse();
        var filterSkuData1 = skuData;
        for (var i1 = 0; i1 < selectSpecValues1.length; i1++) {
            filterSkuData1 = filterSkuDatas(selectSpecValues1[i1].specValueId, filterSkuData1);
            var selectSpecIDs1 = new Array();
            for(var spd1=0;spd1<=i1;spd1++){
                selectSpecIDs1[spd1]=selectSpecValues1[spd1].specId;
            }
            filterUnSelectSpecValueIds(selectSpecIDs1,unSelectSpecValue,filterSkuData1,selectSpecValues1[i1].specValueId);
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
        }else{
            $("#selecSpec").html("没有选择规格商品");
        }
    });

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
        var result = new Array();
        for (var i = 0; i < skuDatas.length; i++) {
            var specValueIds = eval(skuDatas[i].skuJsonData);
            if ($.inArray(specValueId,specValueIds) >= 0) {
                result.push(skuDatas[i]);
            }
        }
        return result;
    }

    //选择过滤器
    function filterUnSelectSpecValueIds(selectSpecIds,unSelectSpecValue,filterDatas,selectSpecValueId) {
        var canSelects = new Array();
        var filterSpecValueIds = new Array();
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

    //根据规格ID取出规格值
    function getUseSpecValue(specValueId){
        for(var i=0;i<userSpecValueData.length;i++){
            if(userSpecValueData[i].specValueId==specValueId){
                return userSpecValueData[i];
            }
        }
    }

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

    //多规格默认选中
    $(".specSelect").each(function(){
        $(this).find("a:first").each(function(){
            this.click();
        });
    });

    //显示已选择的规格值
    function displaySelectSpecValue(nameArray){
        $("#selecSpec").html("已选择:");
        $("#specValue").html("");
        for(var i=0;i<nameArray.length;i++){
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
        var sku = skuData;
        var price = sku.groupBuyPrice;
        if(sku.groupBuyStockQuantity==0){
            alert("该商品缺货");
            return;
        }

        //显示价格
        $("#groupBuyPrice").html(price);
        $(".addcart").attr("skuid",sku.groupBuySkuId);
    }
});*/
/**
 * Created by GJS on 2016/3/16.
 */
$(document).ready(function(){
    /* 商品-menu 切换 */
    (function(){
        var minute_menu = $(".minute-menu");
        var minute_cont = minute_menu.siblings(".minute-cont");
        var client_w = document.body.clientWidth;
        var btn_cart = $(".main-content .btn-cart");
        var show_h = minute_menu.offset().top + 1;

        minute_menu.on("click","li",function(){
            var index = $(this).index();
            $(this).addClass("active").siblings().removeClass("active");
            minute_cont.hide().eq(index).show();
            if ($(document).scrollTop() >= show_h) {
                $(document).scrollTop(show_h);
            }
            var rel = $(this).attr("rel");
            if ("2" == rel) {
                loadPage();
            }
        });


        if (client_w > 1190) {
            btn_cart.css("left",(client_w-1190)/2 + 1190 - 191);
        }
        else {
            btn_cart.css({
                "position":"absolute",
                "right":"2px",
                "top":"20px"
            });
        }
        $(window).scroll(function(){
            var TOP = $(document).scrollTop();
            if (TOP >= show_h) {
                minute_menu.addClass("minute-menu-fixed");
                minute_cont.css("margin-top",51);
                btn_cart.show();
            }
            else {
                minute_menu.removeClass("minute-menu-fixed");
                minute_cont.css("margin-top",0);
                btn_cart.hide();
            }
        });
    })();

    $("#isAllowComment").click(function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
        $.ajax({
            type:"GET",url:webPath.webRoot+"/frontend/comment/isAllowComment.json",
            dataType:"json",data:{productId:webPath.productId},
            async: false,//同步
            success:function(data){
                if(data.success == false){
                    if(data.errorCode == "errors.login.noexist"){
                        showPrdCommentUserLogin();
                        return;
                    }
                    if(data.errorCode == "errors.comment.notOrder"){
                        window.location.href=webPath.webRoot+"/comment/cannotComment.ac?id="+webPath.productId;
                    }
                }else if(data.success == true){
                    window.location.href=webPath.webRoot+data.result;
                }
            }
        });
    });


    $.fn.groupDetailCountdown = function(entTime,type,systemTime) {

        var showCoutdown = $(this);
        var sh;
        var endtimeStr = entTime.replace(/-/g, "/");
        var endTime = new Date(endtimeStr);
        var nowtime = new Date(systemTime);
        var leftmsecond=parseInt(endTime.getTime()-nowtime.getTime());
        sh=setInterval(function(){
            fresh(entTime,sh,showCoutdown,type,leftmsecond);
            leftmsecond -= 100;
        },100);
    };
    function fresh(endDate,sh,showCoutdown,type,leftsecond){
        var d = parseInt(leftsecond/1000/3600/24);
        var h = parseInt((leftsecond/1000/3600)%24);
        var m = parseInt((leftsecond/1000/60)%60);
        var s = parseInt(leftsecond/1000%60);
        var ms = leftsecond%1000;
        var h1 = h>=10 ? parseInt(h/10) : 0;
        var h2 = h>=10 ? h%10 : h;
        var m1 = m>=10 ? parseInt(m/10) : 0;
        var m2 = m>=10 ? m%10 : m;
        var s1 = s>=10 ? parseInt(s/10) : 0;
        var s2 = s>=10 ? s%10 : s;
        var ms1 = ms>=100 ? parseInt(ms/100) : 0;
        //var ms2 = ms>=10 ? parseInt(ms/10%10) : 0;
        switch (type){
            case "millis"://展示毫秒
                if(d>=100){
                    showCoutdown.html("<span>"+parseInt(d/100%10)+"</span><span>"+parseInt(d/10%10)+"</span><span>"+d%10+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span><i>:</i><span>"+ms1+"</span>");
                }else{
                    showCoutdown.html("<span>"+parseInt(d/10%10)+"</span><span>"+d%10+"</span><i>:</i><span>"+h1+"</span><span>"+h2+"</span><i>:</i><span>"+m1+"</span><span>"+m2+"</span><i>:</i><span>"+s1+"</span><span>"+s2+"</span><i>:</i><span>"+ms1+"</span>");
                }
                break;
            default:
                showCoutdown.html("剩余时间：<br /><b>"+d+"</b> 天<b>"+h+"</b> 时<b>"+m+"</b> 分 <b>"+s+"</b> 秒");
                break;
        }
        if(leftsecond <= 0){
            switch (type) {
                default :
                    showCoutdown.html("<b>时间已结束</b>");
                    $(".timeLabel").html("距离团购结束：");
                    window.location.reload(true);
                    break;
            }
            clearInterval(sh);
        }
    };
    //倒计时
    if(webPath.isStart){
        $(".time").groupDetailCountdown(webPath.endTime, 'millis', webPath.systemTime);
    }else{
        $(".time").groupDetailCountdown(webPath.startTime, 'millis', webPath.systemTime);
    }

    /*商品详情*/
    $(".minute-menu li").click(function(){
        var rel = $(this).attr("rel");
        $(".minute-menu li").removeClass("cur");
        $(this).addClass("cur");
        $(".fl .floor").hide();
        $("." + rel).show();
        $("html,body").animate({scrollTop: divOffsetTop}, 300);
    })

    var divOffsetTop = $(".minute-menu").offset().top;
    $(window).scroll(function(){
        var scrollTop = $(this).scrollTop();
        if(scrollTop > divOffsetTop){
            $(".minute-menu").attr("style", "position:fixed;top:0;z-index:100;");
        }else{
            $(".minute-menu").attr("style", "");
        }
    })

    //(评价)
    $("#toComment").click(function(){
        if(!isLogin){
            window.location.href=webPath.webRoot+"/login.ac";
            return false;
        }
        window.open(webPath.webRoot+"/module/member/groupOrderList.ac?status=5");
    });

    $("#num").change(function() {
        var num = $(this).val();
        var reg = /^[1-9][0-9]*$/;
        if(!reg.test(num)){
            $(this).val(1);
            num = 1;
        }
        $("#addToCart").attr("num",num);
    });

  /*  $("#addToCart").click(function() {
        if(!isLogin){
            showConfirm("请您先登录后再购买!", function(){
                window.location.href = webPath.webRoot + "/login.ac";
            });
            return;
        }
        var skuId = $(this).attr("skuid");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        var num = $("#num").val();

        buy(carttype, skuId, num, handler);
    });*/

    //延迟加载详情
  /*  $(window).scroll(showDesc);
    showDesc();*/
});

//减号方法
function productNumSub(){
    var productNum = $("#num");
    var value=   productNum.val();
    if(value==1){
        $(".sub").addClass("disabled");
        return;
    }
    var num=parseInt(value)-1;
    productNum.val(num);
    if(num==1){
        $(".sub").addClass("disabled");
    }
    $("#addToCart").attr("num",num);
}

//加号方法
function productNumAdd(obj, daima){
    var productNum = $("#num");
    var value=   productNum.val();
    var num=parseInt(value)+1;
    productNum.val(num);
    $(".sub").removeClass("disabled");
    $("#addToCart").attr("num",num);
}

//收藏供应商
function addPurchaseShop(isPurchaseShop,nowThis){
    if(webPath.shopId == '' || webPath.shopId == undefined){
        return ;
    }
    if(isPurchaseShop=='Y'){
        showSuccessWin("商家已收藏");
        return false;
    }
    $.get(webPath.webRoot+"/member/collectionShop.json?shopId="+webPath.shopId,function(data){
        if(data.success == false){
            if(data.errorCode == "errors.login.noexist"){
                showConfirm("您尚未登陆，请登陆!",function(){
                    window.location.href=webPath.webRoot+"/login.ac";
                })
                return;
            }
            if(data.errorCode == "errors.collection.has"){
                showErrorWin("您已经收藏了此供应商！");
                return;
            }
        }else if(data.success == true){
            $(nowThis).text("已收藏");
            return;
        }
    });
}

function buy(carttype, skuId, num, handler){
    $.ajax({
        url: webPath.webRoot + "/cart/add.json",
        data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
        dataType: "json",
        success: function (data) {
            window.location.href = webPath.webRoot + "/shoppingcart/cart.ac?carttype=" + carttype + "&handler=" + handler + "&rd=" + Math.random();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showErrorWin(result.errorObject.errorText);
            }
        }
    });
}
function slideShow(target){
    var showDiv = $(target).parent().parent().parent().next();
    var srcUrl ="";
    if( $(target).is("img") ){
        srcUrl = $(target).attr("src");
    }else{
        srcUrl = $(target).prev().attr("src");
    }


    if( $(showDiv).is(":hidden")) {
        var maxLength =showDiv.find(".shareOrder ul li").length;
        var sIndex = 0;
        var divLi = new Array();

        var isOpen1 = false;
        for(var i = 0;i< maxLength; i++) {
            var thisLi = showDiv.find(".shareOrder ul li")[i];
            var showImgUrl = $(thisLi).find("img").attr("src");
            if(showImgUrl == srcUrl ){
                isOpen1 = true;
            }
            if(isOpen1) {
                divLi.push(thisLi);
            }
        }


        var isOpen2 = true;
        for(var i = 0;i< maxLength; i++) {
            var thisLi = showDiv.find(".shareOrder ul li")[i];
            var showImgUrl = $(thisLi).find("img").attr("src");
            if(showImgUrl == srcUrl ){
                isOpen2 = false;
            }
            if(isOpen2) {
                divLi.push(thisLi);
            }
        }

        showDiv.find(".shareOrder ul li").remove();
        for(var i = 0;i< divLi.length;i++) {
            showDiv.find(".shareOrder ul").append(divLi[i]);
        }
    }
    $(target).parent().parent().parent().next().slideToggle();

}
/*//图片放大镜效果
$(function(){
    $(".jqzoom").jqueryzoom({xzoom:450,yzoom:410});
});*/

//图片预览小图移动效果,页面加载时触发
$(function(){
    var tempLength = 0; //临时变量,当前移动的长度
    var viewNum = 5; //设置每次显示图片的个数量
    var moveNum = 2; //每次移动的数量
    var moveTime = 300; //移动速度,毫秒
    var scrollDiv = $(".spec-scroll .items ul"); //进行移动动画的容器
    var scrollItems = $(".spec-scroll .items ul li"); //移动容器里的集合
    var moveLength = scrollItems.eq(0).width() * moveNum; //计算每次移动的长度
    var countLength = (scrollItems.length - viewNum) * scrollItems.eq(0).width(); //计算总长度,总个数*单个长度

});


/*function showDesc(){

    var sTop = $(window).scrollTop(); //滚动条距离顶部位置

    var descTop = $('#groupDesc').offset().top; //选择模块距离顶部位置

    var windowsHeight = $(window).height(); //窗口高度

    var Who = descTop-windowsHeight;

    if(sTop>=Who){
        if(webPath.isLoaded == 'N'){
            $.get(webPath.webRoot + "/loadProductDesc.ac", {groupBuyId:webPath.groupBuyId}, function (data) {
                $("#groupDesc").append(data);
            });
            webPath.isLoaded = 'Y';
        }
    }
}*/


function CollectShop(obj){
    var collectCount2=webPath.shopCollectCount;
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
        } else if (data.success == true) {
            if (webPath.shopCollectCount == '' || webPath.shopCollectCount == undefined) {
                collectCount2 = 1
            } else {
                if(data.isCancel == true){
                    collectCount2 = parseInt(collectCount2)- 1 ;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已取消收藏！");
                    $(".AddShopTomyLikeLayer").show();
                } else{
                    collectCount2 = parseInt(collectCount2)+ 1;
                    $("#shopCollectCount").html(collectCount2);
                    $(".AddShopTomyLikeLayer .showTip .succe h3").html("店铺已成功收藏！");
                    $(".AddShopTomyLikeLayer").show();
                    $("#collectState").text("已收藏");
                    $("#collectState").removeAttr("onclick");
                }
            }
        }
    });
}


function goToPage(obj){
    var page = $(".inputPage").val();
    if(parseInt(page) > parseInt($(obj).attr("lastPage"))){
        return ;
    }
    $(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}

function loadPage() {
    $(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {id: productId}, function () {
    });
}

//异步分页
function syncPage(page, productId) {
    $(".comment-list").load(webPath.webRoot + "/template/bdw/module/common/includeProductComment.jsp", {
        page: page,
        id: productId
    }, function () {

    });
}
