var rate = '';
var readedpage = 1;//当前滚动到的页数

$(function(){
    loadProductComments(1,'');

    var swiper = new Swiper('.product-tab', {
        pagination: '.swiper-pagination',
        slidesPerView: 1,
        centeredSlides: true,
        loop: true,
        autoplay: 5000,
        paginationClickable: true
    });

    var swiper03 = new Swiper('.coupon-redemption',{
        freeMode : true,
        slidesPerView : 'auto'
    });

    $("#shareUrl").text(location.href.split('#')[0]);

    //收藏商品与取消商品收藏
    $("#collect").click(function(){
        if(webPath.productId == '' || webPath.productId == undefined){
            return ;
        }

        //判断当前用户是否收藏该商品
        if(webPath.isCollect == "true"){
            $.ajax({
                type:"POST",url:webPath.webRoot+"/member/delUserProductCollect.json",
                data:{items:webPath.productId},
                dataType:"json",
                success:function(data){
                    if (data.success == "true") {
                        showTips('取消成功');
                        $("#collect").removeClass('collect-active');
                        webPath.isCollect = "false";
                    }else{
                        showTips('系统错误,请刷新重新操作');
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
                        $("#collect").addClass('collect-active');
                    }
                }else if(data.success == true){
                    showTips('收藏成功');
                    $("#collect").addClass('collect-active');
                    webPath.isCollect = "true";
                }
            });
        }
    });

    //收藏店铺
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
                    $(obj).addClass("selected");
                    obj.attr("isCollect","true");
                    obj.html("已收藏");
                    showTips('店铺收藏成功');
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
                        obj.removeClass("selected");
                        obj.attr("isCollect","false");
                        obj.html("收藏店铺");
                        showTips('已取消店铺收藏');
                    }else{
                        showTips('系统错误,请刷新重新操作');
                    }
                }
            });
        }
    });

    //快速导航
    $("#navBtn").click(function () {
        var display = $($(".nav-block")[0]).css('display');
        if(display=='none'){
            $(".nav-block").fadeIn(200);
        }else{
            $(".nav-block").fadeOut(200);
        }
    });

    $("#shareBtn").click(function () {
        showOrHideShare();
    });

    //按 好评 中评 等筛选
    $(".pingjia-box .mt a").click(function () {
        rate = $(this).attr("rel");
        $(this).addClass("cur").siblings().removeClass("cur");
        loadProductComments(1, rate);
    });

    $("#commentDiv").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".item",
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function (newElements) {
        readedpage++;
        if (readedpage > webPath.lastPageNumber) {//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#commentDiv").infinitescroll({state: {isDone: true}, extraScrollPx: 20});
        }
    });

    var swiper3 = new Swiper('.big-pic-box', {
        pagination: '.swiper-pagination3',
        slidesPerView: 1,
        observer:true,
        observeParents:true
    });

    $("body").on('click',".cm-pic .pic-box",function () {
        var _this = $(this);
        var index = _this.index();
        var object =$("#wrapperId");
        var html;
        var picValues = _this.parent().find(".bigPic");
        picValues.each(function () {
            var htmlItemValue=$(this).val();
            html = "<div class='swiper-slide' style=' z-index: 2;' onclick='closeBigPic(this)'><img src='" +
                htmlItemValue+
                "' ></div>";
            object.append(html);
        });
        $("#bigPicLayer").css("display","block");

        swiper3.slideTo(index, 0, true);
    });



});

function timer(intDiff){
    window.setInterval(function(){
        var day=0,
            hour=0,
            minute=0,
            second=0;//时间默认值
        if(intDiff > 0){
            day = Math.floor(intDiff / (60 * 60 * 24));
            hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
            minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
            second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
        }else{
            $("#remTime").hide();
            return;
        }
        if (day <= 9) day = '0' + day;
        if (hour <= 9) hour = '0' + hour;
        if (minute <= 9) minute = '0' + minute;
        if (second <= 9) second = '0' + second;
        $("#timeBox").html("距结束剩余<br><span>"+ day +"</span><i>天</i><span>" + hour + "</span><i>:</i><span>" + minute + "</span><i>:</i><span>" + second +"</span>");
        intDiff--;
    }, 1000);
}

function closeBigPic() {
    $("#bigPicLayer").css("display","none");
    $("#wrapperId").html("");
}
function showTips(tips) {
    $("#tipsSpan").text(tips);
    $("#tipsDiv").show();
    setTimeout(function () {
        $("#tipsDiv").hide();
    }, 1000);
}

function showOrHideShare() {
    var obj = null;
    if(webPath.isWeixin=='Y'){
        obj = $("#share");
    }else{
        obj = $("#sysMsg");
    }

    var display = $(obj).css('display');
    if(display=='none'){
        $(obj).show();
    }else{
        $(obj).hide();
    }
}

//页面四个tab的切换
function showTab(param,object){
    $(object).parent('ul').children().removeClass("cur");
    $(object).addClass("cur");
    var obj = $('#'+param);
    obj.parent().children().css("display","none");
    obj.css("display","block");
    if(param == "productComment"){
        loadProductComments(1,'');
    }
}

//领券
function receiveCoupon(ruleLinke) {
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url: webPath.webRoot+"/member/getCoupon.json",
        data:{
            ruleLinke: ruleLinke
        },
        dataType: "json",
        success: function(data) {
            if (data.success == true) {
                showTips("领取成功!");
            }
        },
        error:function(XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
                return;
            }
        }
    });
}
// 购物车加数量
function addCartNum() {
    var value = $('.cartNum').html();
    if(parseInt(value) > 999 || (isNaN(value))){
        value = "..."
    }else{
        value = parseInt(value) + 1
    }
    $('.cartNum').html(value);
}

//加入购物车
function addToCartOrBuyNow(obj, isBuyNow){
    var skuId = $(obj).attr("skuid");
    var num = $(obj).attr("num");
    var carttype = $(obj).attr("carttype");
    var handler = $(obj).attr("handler");

    $.ajax({
        url: webPath.webRoot + "/cart/add.json",
        data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                if(isBuyNow){
                    if(carttype == 'normal'){//普通购物车
                        window.location.href = webPath.webRoot+ "/wap/outlettemplate/default/shoppingcart/cart.ac";
                    }else if(carttype == 'store'){
                        window.location.href = webPath.webRoot+ "/wap/outlettemplate/default/shoppingcart/cart.ac";
                    } else{
                        window.location.href = webPath.webRoot+ "/wap/outlettemplate/default/shoppingcart/drugCart.ac?carttype=store_drug&handler=store_drug";
                    }
                }else{
                    showTips("您已经成功添加商品到购物车!");
                    addCartNum();
                }
            } else {
                window.location.href = webPath.webRoot + "/wap/login.ac";
            }

        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showTips(result.errorObject.errorText);
            }
        }
    });
}

function loadProductComments(page, rate) {
    var commentDiv = $("#commentDiv");
    $.get(webPath.webRoot + "/wap/loadProductComments.ac", {
        id: webPath.productId,
        page: page,
        commentStatistics: rate
    }, function (data) {
        commentDiv.html('');
        commentDiv.append(data);
    });
    readedpage = 1;
    var curpath = "/wap/loadProductComments.ac?id="+webPath.productId+"&commentStatistics="+rate+"&page=";
    commentDiv.infinitescroll({state: {isDone: false}, extraScrollPx: 20});

    commentDiv.infinitescroll('update', {
        path: [curpath],
        state: {
            currPage: 1
        }
    });
}

function isEmpty(value) {
    if(value==undefined || value==null || value.length==0){
        return true;
    }else{
        return false
    }
}