/**
* Created by Administrator on 2016/12/24.
*/

$(function(){
    // 计算距离
    locatedCurrentAddress();

    //加载当前门店的购物车
    reloadHideCart(webPath.orgId);

    // 优惠规则滚动
    $("#textScrollDiv").textScroll();

    // 商品搜索
    $(".search").click(function(){
        var orgId = webPath.orgId;
        window.location.href = webPath.webRoot + "/wap/citySend/productSearch.ac?orgId=" + orgId;
    });

    // 加载商品分页
    var readedpage = 1;//当前滚动到的页数
    $("#mainList").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".search-list" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function(newElements, opt) {
        var rel = $(".toggle-sec").find(".active a").attr("rel");
        if (rel == 1) { // 当前页为商品页才滚动
            if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#mainList").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }
            readedpage++;
        }
    });

    // 加载评论分页
    var readCommentpage = 1;//当前滚动到的页数
    $("#ajaxComment").infinitescroll({
        navSelector: "#page-nav-comment",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav-comment a",
        itemSelector: ".commentList" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function(newElements, opt) {
        var noCommentLength = $(".noComment").length;
        if (noCommentLength > 1) {
            $('.noComment').each(function(i){
                if (i != 0) {
                    $(this).remove();
                }
            });
        }
        var rel = $(".toggle-sec").find(".active a").attr("rel");
        if (rel == 2) { // 当前页为评论页才滚动
            if(readCommentpage > webPath.lastCommentPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav-comment").remove();
                $("#ajaxComment").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }
            readCommentpage++;
        }
    });

    $("#ajaxComment").infinitescroll('pause'); // 先关闭评论滚动

    // 商品、评论、商家信息切换
    $(".toggle-sec .tab-nav").click(function(){
        var rel = $(this).attr("rel");
        $(".toggle-sec li").removeClass("active");
        $(this).parent().addClass("active");
        document.getElementsByTagName('body')[0].scrollTop = 0; // 滚动条回到顶部
        $(".tabpanel").hide();
        $(".info"+rel).show();
        if (rel == 1) { // 商品页开启商品滚动
            $("#ajaxComment").infinitescroll('pause');
            $('#mainList').infinitescroll('resume');
        } else if (rel == 2) { // 评论页开启评论滚动
            $("#mainList").infinitescroll('pause');
            $('#ajaxComment').infinitescroll('resume');
        } else { // 其他页面关闭两个滚动
            $("#ajaxComment").infinitescroll('pause');
            $("#mainList").infinitescroll('pause');
        }
    });

    // 选择评论类型：好评、中评、差评
    $("#com_tab li").live('click',function () {
        $("#com_tab li").removeClass("active");
        $(this).addClass("active");
        var rel = $(this).attr("rel");
        readCommentpage = 1;
        var pathStr = [];
        pathStr[0] = "/wap/citySend/loadComment.ac?page=";
        pathStr[1] = "&orgId=" + webPath.orgId + "&limit=" + webPath.commentLimit + "&stat=" + rel;
        $("#ajaxComment").infinitescroll({state:{currPage:1, isDone:false}}); // 重新设置滚动页数为1，并开启
        $("#ajaxComment").infinitescroll({path:pathStr}); // 重新设置滚动传递的参数
        $(".commentList").remove(); // 清空现有的评论
        // 加载新的评论
        $("#commentCont").load(webPath.webRoot+"/wap/citySend/loadComment.ac",{orgId:webPath.orgId, page:1, limit:webPath.commentLimit, stat:rel},function(data){});
    });

    // 收藏
    $(".collect").click(function(){
        var _this = $(this);
        if ($(this).hasClass("collected")) {
            showError("您已经收藏了该店铺");
            return;
        }
        var shopInfId = $(this).attr("shopInfId");
        if (isEmpty(shopInfId)) {
            showError("数据异常");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/member/collectionShop.json",
            data: {shopId: shopInfId},
            dataType: "json",
            success: function (data) {
                if (data.success == false) {
                    if (data.errorCode == "errors.login.noexist") {
                        showLoginLayer();
                        return;
                    }
                    if (data.errorCode == "errors.collection.has") {
                        showError("您已经收藏了该店铺");

                    }
                } else if (data.success == true) {
                    var collectCount;
                    if (isEmpty(webPath.shopCollectCount)) {
                        collectCount = 1
                    } else {
                        collectCount = parseInt(webPath.shopCollectCount) + 1
                    }
                    _this.addClass("collected");
                    _this.find("em").text(collectCount);
                    showSuccess("成功收藏店铺");
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
            }
        });

    });

    // 选择分类
    $(".categoryUl li").click(function(){
        if(!$(this).hasClass("active")){
            $(".categoryUl").find("li").removeClass("active");
            $(this).addClass("active");
            var categoryId = $(this).attr("nodeId");
            window.location.href = webPath.webRoot + "/wap/citySend/storeIndex.ac?orgId=" + webPath.orgId + "&shopCategoryId=" + categoryId;
        }
    });

    // 确认加入购物车
    $(".addStoreCart").live('click',function () {
        var addbtn = $(this);
        var skuId = addbtn.attr("skuid");
        var num = addbtn.attr("num");
        var carttype = addbtn.attr("carttype");
        var handler =addbtn.attr("handler");
        var orgid = addbtn.attr("orgid");
        if(skuId==""){
            showError("请选择商品规格");
            return;
        }
        if(num==""){
            showError("请填写购买数量");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    $("#ajaxCartSeletor").hide();
                    //重新加载当前门店的购物车
                    reloadHideCart(orgid);
                }else{
                    showLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
            }
        });
    });

    // 展开收起购物车
    $("#storeCartLayer").live('click',function() {
        var display = $("#ajaxLoadShoppingCart").css("display");
        if ("none" == display) {
            var userId = webPath.userId;
            if (isEmpty(userId)) {
                showLoginLayer();
                return;
            }
            loadStoreShowCart(webPath.orgId);
        } else {
            $("#ajaxLoadShoppingCart").css("display","none");
        }
    });

    //去结算
    $("#goToAddOrder").live('click',function(){
        var orgId = $(this).attr("orgid");
        var carttype = $(this).attr("carttype");
        if(undefined == orgId || null == orgId || orgId==""){
            showError("数据异常");
            return;
        }
        if(undefined == carttype || null == carttype || carttype==""){
            showError("数据异常");
            return;
        }
        $.ajax({
            url: webPath.webRoot + "/cart/checkWapCityShopOrder.json",
            data: {type: carttype, orgId: orgId},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    window.location.href = webPath.webRoot+"/wap/citySend/cityCheckout.ac?orgId="+orgId;
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);

                }
            }
        });
    });


});

// 弹出输入数量框
function addCart(productId){
    $("#ajaxCartSeletor").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartSelector.jsp",{productId:productId},function(){
        $("#cart").hide();
        $("#ajaxCartSeletor").show();
    });
}

// 重新加载底部
function reloadHideCart(orgId){
    $("#cart").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartBottom.jsp",{carttype:"store",orgId:orgId},function(){
        $("#ajaxCartSeletor").hide();
        $("#cart").show();
        layer.closeAll();
    });
}

/*------------购物车页面 START--------------*/
//数量增加
$(".addNum").live("click",function () {
    addStoreNum(this);
});

//填写数量
$(".val").live("change",function () {
    cartStoreNum(this);
});

//数量减少
$(".op-reduce").live("click",function () {
    subStoreNum(this);
});

//复选框-----------------
//cartItem勾选
$(".updateSelect").live("click",function () {
    updateStoreSelect(this);
});

//全选
$("#allSelect").live("click",function(){
    var selectItems = [];
    var carttype = $(this).attr("carttype");
    var sysOrgId = $(this).attr("orgid");
    if($(this).hasClass("active")){//去掉全选
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                selectItems.push(itemKey + ':' + orgid);
            }
        });
        if(selectItems.length<=0){
            return;
        }
        updateSingleStoreSelectCartItems(selectItems, carttype, false, sysOrgId);
    }else{
        //全选
        $(".updateSelect").each(function () {
            var itemKey = $(this).attr("itemKey");
            var orgid = $(this).attr("orgid");
            if(undefined != itemKey && null != itemKey && itemKey != "" && undefined != orgid && null != orgid && orgid != ''){
                selectItems.push(itemKey + ':' + orgid);
            }
        });
        if(selectItems.length<=0){
            return;
        }
        updateSingleStoreSelectCartItems(selectItems, carttype, true,sysOrgId);
    }
});

//移除商品
function delStoreIndexCartItem(obj){
    var _this = $(obj);
    showConfirm("确定删除商品吗?",function() {
        layer.load();
        var itemKey = _this.attr("itemKey");
        var carttype = _this.attr("carttype");
        var handler = _this.attr("handler");
        var orgId = _this.attr("orgid");
        $.ajax({
            url: webPath.webRoot + "/cart/remove.json",
            data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
            dataType: "json",
            success: function (data) {
                loadStoreShowCart(orgId);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
                layer.closeAll();
            }
        });
    });
}

//清空购物车
function delStoreAllCartItem(obj){
    if ($("#ajaxLoadShoppingCart").find("li").length <= 0) {
        return;
    }
    var _this = $(obj);
    showConfirm("确定清空购物车吗?", function() {
        layer.load();
        var carttype = _this.attr("carttype");
        var handler = _this.attr("handler");
        var orgId = _this.attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/removeAll.json",
            data: {type: carttype, handler: handler, orgId: orgId},
            dataType: "json",
            success:function(data){
                loadStoreShowCart(orgId);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    showError(result.errorObject.errorText);
                }
                layer.closeAll();
            }
        });
    });
}

function addStoreNum(obj){
    layer.load();
    var object = $(obj);
    var value = object.prev("input").val();
    var num = parseInt(value) + 1;
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                object.prev("input").val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

function cartStoreNum(obj){
    var obj = $(obj);
    var itemKey = obj.attr("itemKey");
    var carttype = obj.attr("carttype");
    var handler = obj.attr("handler");
    var orgId = obj.attr("orgid");
    var productId = obj.attr("productId");
    var value = obj.val();
    var reg = new RegExp("^[1-9]\\d*$");
    if (!reg.test(value)) {
        loadStoreShowCart(orgId);
        return;
    }
    if (0 >= value) {
        return;
    }
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == "false"){
                obj.val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

function subStoreNum(obj){
    var object = $(obj);
    var value = object.next("input").val();
    var itemKey = object.attr("itemKey");
    var carttype = object.attr("carttype");
    var handler = object.attr("handler");
    var orgId = object.attr("orgid");
    var productId = object.attr("productId");
    var num = parseInt(value) - 1;
    if (num == 0) {
        return;
    }
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: num, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId,productId:productId},
        dataType: "json",
        success: function (data) {
            if(data.success == false){
                object.next("input").val(data.currentNum);
                if (!isEmpty(data.cartAlertMsg)) {
                    layer.closeAll();
                    showError(data.cartAlertMsg);
                    return;
                }
            }
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

function updateStoreSelect(obj){
    layer.load();
    var isSelected = true;
    var updateSelectList = $(obj).parents(".modal-body").find(".updateSelect");
    if (!$(obj).hasClass("active")) {
        isSelected = true;
    } else {
        isSelected = false;
        var updateSelectNum = 0;
        updateSelectList.each(function () {
            if ($(this).hasClass("active")) {
                updateSelectNum += 1;
            }
        });
    }

    var itemKey = $(obj).attr("itemKey");
    var carttype = $(obj).attr("carttype");
    var orgId = $(obj).attr("orgid");
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItem.json",
        data: {itemKey: itemKey, type: carttype, isSelected: isSelected, orgId: orgId},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
}

var updateSingleStoreSelectCartItems = function (itemKeys, carttype, isSelected,orgId) {//多个商品keys
    if (itemKeys == undefined) {
        return false;
    }
    layer.load();
    $.ajax({
        url: webPath.webRoot + "/cart/updateSelectItems.json",
        data: {itemKeys: itemKeys.join(","), type: carttype, isSelected: isSelected},
        dataType: "json",
        success: function (data) {
            loadStoreShowCart(orgId);
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
            layer.closeAll();
        }
    })
};

function loadStoreShowCart(orgId){
    $("#ajaxLoadShoppingCart").load(webPath.webRoot + "/template/bdw/wap/citySend/ajaxload/ajaxLoadShoppingCart.jsp", {
        carttype: "store",
        orgId: orgId
    }, function() {
        $("#ajaxLoadShoppingCart").show();
        reloadHideCart(orgId);
    });
}

// 继续购物
function closeAjaxLoadShoppingCart(){
    $("#ajaxLoadShoppingCart").hide();
}
/*------------购物车页面 END--------------*/


// 弹出登录提示框
function showLoginLayer(){
    showConfirm("请先登录", function(){
        window.location.href = webPath.webRoot + "/wap/login.ac";
    });
}

// 定位计算距离
function locatedCurrentAddress(){
    var geolocation = new qq.maps.Geolocation("IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL", "myapplication");
    geolocation.getLocation(function(data){
        var lat = data.lat;//纬度
        var lng = data.lng;//经度
        var city = data.city;
        var addr = data.addr;
        if(undefined == addr || addr == ""){
            console.log("请开启浏览器定位服务");
        }
        var selectAddress = city + addr;
        $("#shopDistinct").attr("lat",lat);
        $("#shopDistinct").attr("lng",lng);
        loadShopDistinct();
    },function(){
        //定位失败
        $("#shopDistinct").text("定位失败");
        showError("定位失败");
    });
}

// 计算距离
function loadShopDistinct(){
    var lat = $("#shopDistinct").attr("lat");
    var lng = $("#shopDistinct").attr("lng");
    var shopInfId = $("#shopDistinct").attr("shopInfId");
    if (isEmpty(lat) || isEmpty(lng) || isEmpty(shopInfId)) {
        return;
    }
    $.ajax({
        url: webPath.webRoot + "/citySend/getShopDistinct.json",
        data: {shopInfId: shopInfId, lat: lat, lng: lng},
        type: "get",
        dataType: "json",
        success: function (data) {
             if (data.success == "true") {
                 var distinct;
                 if (data.distinct < 1000) {
                     distinct = data.distinct.toFixed(2) + "m";
                 } else {
                     distinct = (data.distinct / 1000).toFixed(2) + "km";
                 }
                 $("#shopDistinct").text(distinct);
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                showError(result.errorObject.errorText);
            }
        }
    });
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}

$.fn.textScroll=function(){
    var speed=40; // 值越大，速度越快
    var flag=null,tt,that=$(this),child=that.children();
    var p_w=that.width(), w=child.width();
    child.css({left:p_w});
    var t=(w+p_w)/speed * 1000;
    function play(m){
        var tm= m==undefined ? t : m;
        child.animate({left:-w},tm,"linear",function(){
            $(this).css("left",p_w);
            play();
        });
    }
    child.on({
        mouseenter:function(){
            var l=$(this).position().left;
            $(this).stop();
            tt=(-(-w-l)/speed)*1000;
        },
        mouseleave:function(){
            play(tt);
            tt=undefined;
        }
    });
    play();
};
