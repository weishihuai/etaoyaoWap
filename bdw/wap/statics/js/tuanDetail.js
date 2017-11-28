var skuData = eval(webPath.skuIds);
var rate = '';
var readedpage = 1;//当前滚动到的页数
$(function(){

    loadProductComments(1,'');

    $("#shareUrl").text(webPath.shareUrl);
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

    $("#buy-now").attr("objectid",skuData[0].groupBuySkuId);
    $("#buy-now").click(function(){
        // 结算
        $.ajax({
            url: webPath.webRoot + "/cart/canTuan.json",
            type: 'POST',
            success: function (data) {
                if (data.success == "true") {
                    // 进行结算
                    settleAccount($("#buy-now"));
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

});

//商品
function settleAccount(obj){
    var objectid = obj.attr("objectid");
    var num = 1;//团购商品数量默认为1
    var carttype = obj.attr("carttype");
    var handler = obj.attr("handler");
    if(undefined == num || null == num || "" == num || parseInt(num) <= 0){
        alert("请输入购买数量");
        return;
    }
    $.ajax({
        url:webPath.webRoot+"/cart/tuanAdd.json",
        data:{type:carttype,objectId:objectid,quantity:num,handler:handler},
        dataType: "json",
        success:function(data) {
            if(data.success == "true"){
                window.location.href=webPath.webRoot+"/wap/shoppingcart/orderAdd.ac?handler=groupBuy&carttype=groupBuy&isCod=N";
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

function timer(intDiff,type){
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
            return ;
        }
        if (day <= 9) day = '0' + day;
        if (hour <= 9) hour = '0' + hour;
        if (minute <= 9) minute = '0' + minute;
        if (second <= 9) second = '0' + second;
        if(type == 'groupBuyIN'){
            $("#timeBox1").html("距团购结束剩余<br><span>"+ day +"</span><i>天</i><span>" + hour + "</span><i>:</i><span>" + minute + "</span><i>:</i><span>" + second +"</span>");
        }else if(type =='previewGroupBuy'){
            $("#timeBox2").html("距团购开始剩余<br><span>"+ day +"</span><i>天</i><span>" + hour + "</span><i>:</i><span>" + minute + "</span><i>:</i><span>" + second +"</span>");
        }
        intDiff--;
    }, 1000);
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
