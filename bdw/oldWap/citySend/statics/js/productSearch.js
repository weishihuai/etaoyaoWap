/**
 * Created by Administrator on 2017/1/4.
 */
jQuery(function($) {
    $(document).ready(function() {
        // 滚动搜索栏固定
        var divOffsetTop = $(".search-box").offset().top;
        $(window).scroll(function(){
            var scrollTop = $(this).scrollTop();
            if(scrollTop > divOffsetTop){
                $("#searchTxt").css("background-color", "#efefef");
                $(".search-box").attr("style", "position:fixed;top:0;width:100%;padding-right: 6.8rem;z-index:10;");
            }else{
                $("#searchTxt").css("background-color", "white");
                $(".search-box").attr("style", "padding-right: 6.8rem;");
            }
        });

        // 搜索
        $("#searchBtn").click(function(){
            var searchTxt = $.trim($("#searchTxt").val());
            if (isEmpty(searchTxt)) {
                showError("请输入商品名称");
                return;
            }
            $("#searchForm").submit();
        });

        // 加载分页
        var readedpage = 1;//当前滚动到的页数
        $("#mainList").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".good-list" ,
            animate: true,
            loading: {
                finishedMsg: '无更多数据'
            },
            extraScrollPx: 50
        }, function(newElements) {
            if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
                $("#page-nav").remove();
                $("#mainList").infinitescroll({state:{isDone:true},extraScrollPx: 50});
            }
            readedpage++;
        });
    });

    //购物车列表展开与收起
    $("#storeCartLayer").live('click',function() {
        if("none"==$("#ajaxLoadShoppingCart").css("display")) {
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

    //加入购物车
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
});

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}

function addCart(productId){
    $("#ajaxCartSeletor").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartSelector.jsp",{productId:productId},$("#ajaxCartSeletor").show());
}

function reloadHideCart(orgId){
    $("#cart").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartBottom.jsp",{carttype:"store",orgId:orgId},function(){
        $("#ajaxCartSeletor").css("display","none");
    });
}

//登录提示框
function showLoginLayer(){
    showConfirm("请先登录", function(){
        window.location.href = webPath.webRoot + "/wap/login.ac";
    });
}

/*------------购物车页面--------------*/
//数量增加
$(".op-add").live("click",function () {
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
            selectItems.push(itemKey + ':' + orgid);
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
            selectItems.push(itemKey + ':' + orgid);
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
    showConfirm("确定删除商品吗?",function(){
        layer.load();
        var itemKey = _this.attr("itemKey");
        var carttype = _this.attr("carttype");
        var handler = _this.attr("handler");
        var orgId = _this.attr("orgid");
        $.ajax({
            url:webPath.webRoot+"/cart/remove.json",
            data: {type: carttype, itemKey: itemKey, handler: handler, orgId: orgId},
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

//清空购物车
function delStoreAllCartItem(obj){
    showConfirm("确定清空购物车吗?", function(){
        layer.load();
        var carttype = $(obj).attr("carttype");
        var handler = $(obj).attr("handler");
        var orgId = $(obj).attr("orgid");
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

function goToAddOrder(obj){
    var addOrderObj = $(obj);
    var orgId = addOrderObj.attr("orgid");
    var carttype = addOrderObj.attr("carttype");
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
                window.location.href = webPath.webRoot+"cityCheckout.ac?orgId="+orgId;
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


function loadStoreShowCart(orgId){
    $("#ajaxLoadShoppingCart").load(webPath.webRoot + "/template/bdw/wap/citySend/ajaxload/ajaxLoadShoppingCart.jsp", {
        carttype: "store",
        orgId: orgId
    }, function(){
        $("#ajaxLoadShoppingCart").show();
        reloadHideCart(orgId);
    });
}

function reloadHideCart(orgId){
    $("#cart").load(webPath.webRoot+"/template/bdw/wap/citySend/ajaxload/cartBottom.jsp",{carttype:"store",orgId:orgId},function(){
        layer.closeAll();
    });
}

