//roload之后不起效果
//var change = false;

$(document).ready(function(){
    $(".imall_pay").click(function(){
        var formList = $("form");
        if(formList.length > 0){
            $("form")[0].submit();
        }else{
            alert("网站支付配置错误，请联系客服人员处理");
        }
    });


    $(".countDown").each(function() {
        fresh($(this));
    });

    countDown=setInterval(function(){
        $(".countDown").each(function() {
            fresh($(this));
        });
    },1000);

});

function fresh(t){
    var RemainTime = t.attr("lastPayTime");
    var orderId = t.attr("orderId");
    var endtimeStr = RemainTime.replace(/-/g,"/");
    var endtime=new Date(endtimeStr);
    var nowtime = new Date();
    var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
    if(leftsecond<=0){
        clearInterval(countDown);
        window.location.reload();
    }else{
        d=parseInt(leftsecond/3600/24);
        h=parseInt((leftsecond/3600)%24);
        m=parseInt((leftsecond/60)%60);
        s=parseInt(leftsecond%60);
        $("#orderId"+orderId).html("<span>支付还剩：</span><b class='timeColor'>" + h + "</b> 时<b class='timeColor'>" + m + "</b> 分 <b class='timeColor'>" + s + "</b> 秒");
    }
}

/*
 * 取消订单
 * */
function cancelOrder(orderId){
    confirm("您确认要取消此订单么？",{onSuccess:function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/order/cancel.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    //roload之后不起效果
                    //change = true;
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("取消订单失败！");
            }
        });
    }});
    return false;
}

/*
 * 确认收货
 * */
function buyerSigned(orderId){
    confirm("您确认收货了吗？",{onSuccess:function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/order/buyerSigned.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    //roload之后不起效果
                    //change = true;
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }});
    return false;
}
/**
 *订单详情中返回
 */
function detailBack(){
    //roload之后不起效果
    /*if(change){
        alert(change);
        change = false;
        //window.location.href='javascript:history.go(-2);' ;
        setTimeout(function(){
            window.location.href = dataValue.webRoot+'/wap/module/member/myOrders.ac';
        },1)
    }else{
        alert(change);
        //window.location.href='javascript:history.go(-1);location.reload();' ;
    }*/
    window.location.href = dataValue.webRoot+'/oldWap/module/member/myOrders.ac';
}

//查询当前的订单状态
function confirmStatus(orderId){
    $.ajax({
        type:"GET" ,url:dataValue.webRoot+"/order/confirmOrderStatus.json",
        data:{orderId:orderId},
        dataType:"json",
        success:function(data) {
            if(data.success == "true"){
                if(data.isPayed == "true"){
                    alert("该订单已经支付过了!");
                }else{
                    location.href = dataValue.webRoot+"/oldWap/shoppingcart/cashier.ac?orderIds="+orderId;
                }
            }else {
                alert("抱歉，系统异常,请重新去支付");
            }
        }
    });
}


/**
 * 取消积分订单
 * @param integralOrderId
 * @returns {boolean}
 */

/*
 * 取消订单
 * */
function cancelIntegralOrder(integralOrderId){
    confirm("您确认要取消此订单么？",{onSuccess:function(){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/integralOrder/orderCanceled.json?integralOrderId=" + integralOrderId,
            success:function(data) {
                if (data.success == "true") {
                    //roload之后不起效果
                    //change = true;
                    setTimeout(function(){
                        window.location.reload();
                    },1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("取消订单失败！");
            }
        });
    }});
    return false;
}

// 删除订单
function orderDelete(orderId){
    $.ajax({
        url:  dataValue.webRoot + '/order/delete.json?orderId='+orderId ,
        type: 'POST',
        success: function(data){
            if(data.success == 'true'){
                $(".overlay").css('display','block');
                setTimeout(function(){
                    window.location.reload();
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


//function cancelIntegralOrder(integralOrderId){
//    if(confirm("您确定要取消订单?")){
//        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
//        $.ajax({
//            type : "GET",
//            dateType : "json",
//            url : Top_Path.webRoot + "/integralOrder/orderCanceled.json?integralOrderId=" + integralOrderId,
//
//            success : function(data){
//                if(data.success == "true"){
//                    setTimeout(function(){
//                        window.location.href = dataValue.webRoot+"/module/member/integralOrderDetail.ac?id=" + integralOrderId;
//                    })
//                }
//            },
//            error : function(XmlHttpRequest, textStatus){
//                alert("取消订单失败");
//            }
//        })
//    }
//    return false;
//}

