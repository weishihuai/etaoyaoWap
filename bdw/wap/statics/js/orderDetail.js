var countDown;
$(function(){

    fresh();

    countDown =setInterval(function(){
        fresh();
    },1000);

    if (webPath.logisticsNum!='') {
        loadTracking();
    }

    // 提醒发货
    $("#btn-remindOrder").click(function () {
        var $mythis = $(this);
        var orderId = $mythis.attr("data-orderId");
        if(confirm("您确认要提醒发货吗？")) {
            $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
            $.ajax({
                type:"GET",
                url:webPath.webRoot+"/order/remindOrder.json?orderId="+orderId ,
                success:function(data) {
                    if (data.success == "true") {
                        $mythis.replaceWith('<a class="zhifu-btn3" href="javascript:;">已提醒发货</a>');
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    alert("提醒发货失败！");
                }
            });
        }
    });

    //立即支付
    $("#pay-btn").click(function () {
        $("#paymentLoad").load(webPath.webRoot + "/wap/shoppingcart/paymentLoad.ac?orderIds=" + webPath.orderId , afterPaymentLoad);
       // confirmStatus(webPath.orderId);
    });

});


//查询当前的订单状态
function confirmStatus(orderId){
    $.ajax({
        type:"GET" ,url:webPath.webRoot+"/order/confirmOrderStatus.json",
        data:{orderId:orderId},
        dataType:"json",
        success:function(data) {
            if(data.success == "true"){
                if(data.isPayed == "true"){
                    alert("该订单已经支付过了!");
                }else{
                    $("#paymentLoad").load(webPath.webRoot + "/wap/shoppingcart/paymentLoad.ac?orderIds=" + orderId , afterPaymentLoad);
                }
            }else {
                alert("抱歉，系统异常,请重新去支付");
            }
        }
    });
}

function afterPaymentLoad() {
    $(".payment-layer-inner .dt .close").attr('href','javascript:;');
    $(".payment-layer-inner .dt .close").click(function () {
        $(".payment-layer").hide();
    });
}

function loadTracking(){
    $.ajax({
        type: "post",
        url: webPath.webRoot+"/order/searchLogisticsStatus.json?_method=post",
        data:{orderId:webPath.orderId},
        dataType: "json",
        success: function (data) {
            if(data.result.length >=1) {
                var rowData = data.result[data.result.length - 1];
                var rowHtml = '<p class="site">' + rowData.content + '</p><p class="date">' + rowData.dateString + '</p>';
                $('.kuaidi-info').html(rowHtml);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $(".kuaidi-info").html("<p class='site'><p><p class='date'>查询超时，物流承运商为：<b>"+webPath.logisticsCompany+"</b>，物流单号为：<b>"+webPath.logisticsNum+"</b>,您可以到<a target='_blank' href="+webPath.companyHomeUrl+">"+webPath.companyHomeUrl+"</a>进行查询</p>");
        }
    });
}

function fresh(){
    var countDownStr = $("#countDown");
    var payBtn = $("#pay-btn");
    if(countDownStr.attr("lastPayTime") == undefined || countDownStr.attr("lastPayTime") == null || countDownStr.attr("lastPayTime") == ''){
        return false;
    }
    if(payBtn.attr("lastPayTime") == undefined || payBtn.attr("lastPayTime") == null || payBtn.attr("lastPayTime") == ''){
        return false;
    }
    var RemainTime = payBtn.attr("lastPayTime");
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        clearInterval(countDown);
        window.location.reload();
    }else{
        h=toTwo(parseInt((leftsecond/3600)%24));
        m=toTwo(parseInt((leftsecond/60)%60));
        s=toTwo(parseInt(leftsecond%60));
        $("#countDown").html("请在<span>"+h + ":"+ m +":" + s+"</span>内完成支付<br>超时订单自动取消");
        $("#pay-btn").html("立即支付<span>"+h + ":"+ m +":" + s+"</span>");
    }
    function toTwo(n){
        return n < 10 && n > -1 ? '0' + n : '' + n;
    }
}

/*
 * 确认收货
 * */
function buyerSigned(orderId){
    if(confirm("您确认收货了吗？")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/order/buyerSigned.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }
    return false;
}


/*
 * 取消订单
 * */
function cancelOrder(orderId){
    if(confirm("您确认要取消此订单吗？")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/order/cancel.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("取消订单失败！");
            }
        });
    }
    return false;
}

// 删除订单
function orderDelete(orderId){
    if(confirm("您确认要删除此订单吗？")){
        $.ajax({
            url:  webPath.webRoot + '/order/delete.json?orderId='+orderId ,
            type: 'POST',
            success: function(data){
                if(data.success == 'true'){
                    $(".overlay").css('display','block');
                    setTimeout(function(){
                        window.location.href = webPath.webRoot + 'myOrders.ac';
                    },2000)
                }
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    }
}