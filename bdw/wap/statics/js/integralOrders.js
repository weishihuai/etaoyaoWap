$(function(){

    // 加载分页
    var readedpage = 1;//当前滚动到的页数
    $("#order-panel").infinitescroll({
        navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
        nextSelector: "#page-nav a",
        itemSelector: ".order-list" ,
        animate: true,
        loading: {
            finishedMsg: '无更多数据'
        },
        extraScrollPx: 50
    }, function(newElements) {
        if(readedpage > webPath.lastPageNumber){//如果滚动到超过最后一页，置成不要再滚动。
            $("#page-nav").remove();
            $("#order-panel").infinitescroll({state:{isDone:true},extraScrollPx: 50});
        }
        readedpage++;
    });

    /* 搜索框显示/隐藏 START*/
    $(".search1").click(function () {
        $(".m-top").fadeOut(200);
        $(".search1-box").fadeIn(200);
    });

    $("body").click(function (e) {
        if($(e.target).is(".search1-box")){
            $(".search1-box").fadeOut(200);
            $(".m-top").fadeIn(200);
        }
    });
    /* 搜索框显示/隐藏 END */

    /* 订单类型切换 */
    (function(){
        var xiala_box = $(".m-top .xiala-box");
        var dt = xiala_box.find(".dt");
        var dd = xiala_box.find(".dd");
        var onoff = true;

        xiala_box.on("touchend", function(){
            fn1();
        });
        dd.find(".dd-inner").on("touchend", function(event){
            event.stopPropagation();
        });

        function fn1() {
            if (onoff) {
                dt.addClass("dt-s").siblings(".dd").stop().fadeIn(200);
                onoff = false;
            }
            else {
                dt.removeClass("dt-s").siblings(".dd").stop().fadeOut(200);
                onoff = true;
            }
        }
    })();

    /* 订单状态切换 */
    (function(){
        var order_class_toggle = $(".order-class-toggle");
        var dd = order_class_toggle.find(".dd");
        var onoff = true;

        order_class_toggle.on("touchend", function(){
            fn2();
        });
        dd.find(".dd-inner").on("touchend", function(event){
            event.stopPropagation();
        });

        function fn2() {
            if (onoff) {
                order_class_toggle.find(".icon-xiala").addClass("icon-xiala-s").siblings(".dd").stop().fadeIn(200);
                onoff = false;
            }
            else {
                order_class_toggle.find(".icon-xiala").removeClass("icon-xiala-s").siblings(".dd").stop().fadeOut(200);
                onoff = true;
            }
        }
    })();
});

function selectIntegralOrder(status){
    if(status == 10){
        //status==10 ,显示所有订单
        window.location.href = webPath.webRoot + 'myIntegralOrders.ac';
    }else{
        window.location.href = webPath.webRoot + 'myIntegralOrders.ac?status=' + status;
    }
}

function searchIntegralOrder(){
    var searchField=$("#searchField").val();
    if(searchField=='商品名称/订单编号'){
        $("#searchField").attr("value",'');
    }
    var selectStatus;
    $("#selectStatus li").each(function () {
        if($(this).hasClass("cur")){
            selectStatus = $(this).attr("status");
            return false;
        }
    });
    if(selectStatus == undefined){
        window.location.href = webPath.webRoot + 'myIntegralOrders.ac?searchField=' + searchField;
    }else{
        window.location.href = webPath.webRoot + 'myIntegralOrders.ac?status=' + selectStatus + '&searchField=' + searchField;
    }
}

function buyerSigned(orderId){
    if(confirm("您确认收货了吗？")){
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/integralOrder/buyerSigned.json?integralOrderId="+orderId,
            success:function(data) {
                if (data.success == "true") {
                    window.location.reload();
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }
    return false;
}