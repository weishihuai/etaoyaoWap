/**
 * Created by lhw on 2016/11/19.
 */

var cityLocated,cityGeocoder,cityMap;
function initCityMap() {
    var center = new qq.maps.LatLng(39.916527, 116.397128);
    cityMap = new qq.maps.Map(document.getElementById('addMap'), {
        center: center,
        zoom: 13
    });

    cityGeocoder = new qq.maps.Geocoder({
        complete: function (result) {
            var latLng = result.detail.location;
            cityMap.setCenter(latLng);
            marker = new qq.maps.Marker({
                map: cityMap,
                position: result.detail.location
            });
        }
    });

    //获取城市列表接口设置中心点
    cityLocated = new qq.maps.CityService({
        complete: function (result) {
            var latLng = result.detail.latLng;
            cityMap.setCenter(latLng);
            if(null != paramData.orgLat && null != paramData.orgLng){
                var a = new qq.maps.LatLng(latLng.lat,latLng.lng);
                var b = new qq.maps.LatLng(paramData.orgLat, paramData.orgLng);
                var defaultDistinct = Math.round(qq.maps.geometry.spherical.computeDistanceBetween(a, b))/1000;//km
                $("#defaultDistance").html(defaultDistinct.toFixed(2));
            }
        }
    });
    cityLocated.searchLocalCity();

}


$(function () {

    if(undefined == paramData.lat || null == paramData.lat || "" == paramData.lat || undefined == paramData.lng || null == paramData.lng || "" == paramData.lng || undefined == paramData.distinct || null == paramData.distinct || "" == paramData.distinct){
        initCityMap();
    }

    //点赞,有用评论
    //$(".addHelpful").live("click",function(){
    //    var sysCommentId = $(this).attr("commentId");
    //    $.ajax({
    //        url: paramData.webRoot + "/commentFront/addHelpfulComment.json",
    //        data: {sysCommentId: sysCommentId},
    //        dataType: "json",
    //        success: function (data) {
    //            if (data.success == "true") {
    //                $(".helpful" + sysCommentId).html(data.totalHelpfulCount);
    //                breadJDialog("成功点赞!",1200,"10px",true);
    //            } else {
    //                var errorTxt = data.result;
    //                if(undefined != errorTxt){
    //                    if(errorTxt == 'nologin'){
    //                        showLoginLayer();
    //                        return;
    //                    }
    //                    if(errorTxt == 'already_thumbs'){
    //                        breadJDialog("您已经点赞过了!",1200,"10px",true);
    //                    }
    //                }
    //            }
    //        },
    //        error: function (XMLHttpRequest, textStatus) {
    //            if (XMLHttpRequest.status == 500) {
    //                var result = eval("(" + XMLHttpRequest.responseText + ")");
    //                breadJDialog(result.errorObject.errorText,1300,"20px",true);
    //            }
    //        }
    //    });
    //
    //});

    //搜索门店商品
    $("#searchPrd").click(function () {
        var searchTxt = $.trim($("#searchTxt").val());
        //if(undefined == searchTxt || null == searchTxt || ""==searchTxt){
        //    breadJDialog("请输入关键字",2000,"15px",true);
        //    return;
        //}
        window.location.href = paramData.webRoot+"/citySend/storeDetail.ac?lat="+paramData.lat+"&orgId="+paramData.orgId+"&lng="+paramData.lng+"&shopCategoryId="+paramData.shopCategoryId+"&keyword="+searchTxt;
    });

    /*单规格商品加入购物车 start*/
    $(".addCartBtn").click(function () {
        var addbtn = $(this);
        var skuId = addbtn.attr("skuid");
        var num = addbtn.attr("num");
        var carttype = addbtn.attr("carttype");
        var handler =addbtn.attr("handler");
        var orgid = addbtn.attr("orgid");
        if(skuId==""){
            breadJDialog("请选择商品规格",1300,"10px",true);
            return;
        }
        if(num==""){
            breadJDialog("请填写购买数量",1300,"10px",true);
            return;
        }
        $.ajax({
            url: paramData.webRoot + "/cart/add.json",
            data: {type: carttype, objectId: skuId, quantity: num, handler: handler},
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    breadJDialog("加入购物车成功", 1300, "20px", true);
                    //重新加载当前门店的购物车
                    loadStoreHideCart(orgid);

                } else {
                    showLoginLayer();
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    breadJDialog(result.errorObject.errorText,1300,"20px",true);
                }
            }
        });

    });
    /*加入购物车 end*/
    //商品规格选择框
    //$(".multiSpec").live("click",function () {
    //    var productId = $(this).attr("productId");
    //    $("#modelDialog").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/multiSpecSelected.jsp",{id:productId},function(){});
    //});
    //热销商品中调用hover时，有时候进到门店首页，第一个nav不会被选上，所以增加该操作
    var productAmount = $("#productAmount").val();
    var activeList = $(".nav .active");
    if(productAmount>0 && activeList.length==0){
        $(".nav").trigger("hover");
    }

    //热销商品
    $(".nav").hover(function(){
        var ulCount = $(this).attr("uSec");
        $(".productUl").css("display","none");
        $("#ul"+ulCount).css("display","block");
        $(".nav").removeClass("active");
        $(this).addClass("active");
    });

    /*tab切换*/
    $(".tabLabel").click(function () {
        $(".tabLabel").removeClass("active");
        $(this).addClass("active");
        $(".tabpanel").hide();
        var rel = $(this).attr("rel");
        $(".info" + rel).show();
        if ("2" == rel) {
            loadCommentPage(this);
        }
    });

    $(".tabComment").live('click',function () {
        $(".tabComment").removeClass("active");
        $(this).addClass("active");
        var rel = $(this).attr("rel");
        var orgid = $(this).attr("orgid");
        $("#commentContent").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/comment.jsp",{orgId:orgid,stat:rel},function(){$("#commentNav").hide();});
    });

    //分享店铺
    $("#shareShop").click(function(){
        createShareLayer();
    });
});

/*收藏门店*/
var collectCount=paramData.shopCollectCount ;
function collectStore(obj){
    if (obj == '' || obj == undefined) {
        return;
    }
    $.get(paramData.webRoot + "/member/collectionShop.json?shopId=" + obj, function (data) {
        if (data.success == false) {
            if (data.errorCode == "errors.login.noexist") {
                showLoginLayer();

            }
            //if (data.errorCode == "errors.collection.has") {
            //    breadJDialog("您已经收藏了该店铺",1000,"10px",true);
            //}
        } else if (data.success == true) {
            if (paramData.shopCollectCount == '' || paramData.shopCollectCount == undefined) {
                collectCount = 1
            } else {
                if(data.isCancel == true){
                    breadJDialog("取消收藏店铺",1000,"10px",true);
                    collectCount = collectCount -1;
                    $(".user_num").html(collectCount);
                } else{
                    breadJDialog("成功收藏店铺",1000,"10px",true);
                    collectCount = collectCount + 1;
                    $(".user_num").html(collectCount);
                }
            }
        }
    });
}



/*店铺分享弹层*/
var shareLayer;
function createShareLayer(){
    shareLayer = $.layer({
        type: 1,
        fadeIn: 400,
        offset: ['', ''],
        area: ["250px", 'auto'],
        title: false,
        move: false,
        shade: [0.5, '#000'],
        fix: true,
        border: [1, 0.3, '#000'],
        page: {dom: '#shareCont'},
        bgcolor: "#fff",
        zIndex: 19891014,
        shift:'top',
        loading: {
            type: 0
        },
        closeBtn: [0, true]
    });
}

//异步加载评论
function loadCommentPage(obj){
    var orgid = $(obj).attr("orgid");
    $("#commentList").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/comment.jsp",{orgId:orgid,stat:'all'},function(){});
}


//异步分页
function syncCommentPage(page, orgId, stats) {
    $("#commentList").load(paramData.webRoot + "/template/bdw/citySend/ajaxload/comment.jsp", {
        page: page,
        orgId: orgId,
        stat:stats
    }, function () {

    });
}

//确定按钮的分页
function syncGoToCommentPage(lastPageNum,orgId, stats) {
    var goToPage =  $.trim($("#inputPage").val());
    if(goToPage<1){
        goToPage = 1;
    }
    if(goToPage>=lastPageNum){
        goToPage = lastPageNum;
    }
    $("#commentList").load(paramData.webRoot + "/template/bdw/citySend/ajaxload/comment.jsp", {
        page: goToPage,
        orgId: orgId,
        stat:stats
    }, function () {
        $("#inputPage").val(goToPage);
    });
}

//价格筛选
function changeSortByPrice(obj){
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/storeDetail.ac?lat="+paramData.lat+"&orgId="+paramData.orgId+"&lng="+paramData.lng+"&shopCategoryId="+paramData.shopCategoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=down&order=minPrice,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/storeDetail.ac?lat="+paramData.lat+"&orgId="+paramData.orgId+"&lng="+paramData.lng+"&shopCategoryId="+paramData.shopCategoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=up&order=minPrice,asc";
    }

}

//销量筛选
function changeSortBySalesVolumn(obj){
    var sort = paramData.sort;
    if(sort==null||sort=="up"||sort=="") {
        window.location.href = paramData.webRoot+"/citySend/storeDetail.ac?lat="+paramData.lat+"&orgId="+paramData.orgId+"&lng="+paramData.lng+"&shopCategoryId="+paramData.shopCategoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=down&order=salesVolume,desc";
    } else {
        window.location.href = paramData.webRoot+"/citySend/storeDetail.ac?lat="+paramData.lat+"&orgId="+paramData.orgId+"&lng="+paramData.lng+"&shopCategoryId="+paramData.shopCategoryId+"&q="+paramData.q+"&page="+paramData.page+"&sort=up&order=salesVolume,asc";
    }
}

function showMoreAttrs(){
    $(".extraAttr").show();//中间的空格必须
    $(".row_m").hide();
    $(".row_h").show();
}

function hideTheAttr(){
    $(".extraAttr").hide();
    $(".row_h").hide();
    $(".row_m").show();
}

//没有标题和按钮的提示框
function breadJDialog(content, autoClose, padding, modal){
    var dialog = jDialog.message(content,{
        autoClose : autoClose,    // 3s(3000)后自动关闭
        padding : padding,    // 设置内部padding
        modal: modal         // 非模态，即不显示遮罩层
    });
    return dialog;
}

function loadHideCart(){
    $("#oldCart").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam},function(){
        $("#cartLayer").css("right", "0px");
        $("#allStoreCart").css("display","none");
        $("#cartContent").css("right","-1260px");
    });
}

function loadStoreHideCart(orgId){
    $("#storeCart").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/mainCartLoad.jsp",{carttype:"store",p:Top_Path.topParam,orgId:orgId},function(){
        $("#storeCartLayer").css("right", "50px");
        $("#singleStoreCart").css("display","none");
    });
}

function showMultiSpecWin(obj){
    var productId = $(obj).attr("productId");
    $("#modelDialog").load(paramData.webRoot+"/template/bdw/citySend/ajaxload/multiSpecSelected.jsp",{id:productId},function(){$("#modelDialog").show()});
}


//登录提示框
function showLoginLayer(){
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

//评论有用js
var enableComment = function(commentId,idStr){
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"GET",url:paramData.webRoot+"/frontend/comment/enable.json",
        data:{commentId:commentId},
        dataType:"json",
        async: false,//同步
        success:function(data){
            if (data.success == true) {
                var eanbleNum = parseInt(data.commentEnableCount);
                var voteStr = "已投票("+eanbleNum+")";
                $(idStr).html(voteStr);
                $(idStr).attr('onclick','')
            }else{
                breadJDialog("对不起，你的操作无效，请刷新页面重试！",1200,"10px",true);
            }
        },
        error:function(msg){
            breadJDialog("您已经投票了",1200,"10px",true);
        }
    });
};