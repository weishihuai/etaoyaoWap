$(document).ready(function(){
    $("#payButtonId").pay();

    if (dataValue.logisticsNum!='') {
        loadTracking();
    }else if(dataValue.isJdOrder){
        loadJdTracking();
    }

})

/*
* 订单物流跟踪
* */
function loadTracking(){
    $("#tracking").html("<div align='center'><img src="+dataValue.webRoot+"/template/bdw/module/member/statics/images/ajax-loader.gif"+"/></div>")
    $("#tracking").load(dataValue.webRoot+"/order/searchLogisticsStatus.ac?_method=post", {orderId:dataValue.orderId}, function(responseText, textStatus, XMLHttpRequest) {
        if (textStatus == 'error') {
        $("#tracking").html("<div align='center' style='padding:10px;'>查询超时，物流承运商为：<b>"+dataValue.logisticsCompany+"</b>，物流单号为：<b>"+dataValue.logisticsNum+"</b>,您可以到<a target='_blank' href="+dataValue.companyHomeUrl+">"+dataValue.companyHomeUrl+"</a>进行查询</div>")
        }
    })
}

function loadJdTracking(){
    $("#tracking").html("<div align='center'><img src="+dataValue.webRoot+"/template/bdw/module/member/statics/images/ajax-loader.gif"+"/></div>");
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
    $.ajax({
        type:"POST",
        url:dataValue.webRoot+"/order/searchJdLogistics.json?orderId="+dataValue.orderId ,
        success:function(data) {
            if (data.success == "true") {
                var htmlStr = '<div style="padding: 3px;">';
                for(var i=0;i<data.result.length;i++){
                    var num = i+1;
                    htmlStr += '<h1>子订单'+num+'(京东单号：'+
                                data.jdOrderId[i]+')</h1><ul style="padding: 10px;height: 120px;overflow-y: auto;">';
                    for(j in data.result[i]) {
                        htmlStr += '<li style="line-height: 15px;padding:5px;"><span style="margin-right: 20px;">'
                        + data.result[i][j].msgTime
                        + '</span><span>'
                        + data.result[i][j].content
                        + '</span></li>'
                    }
                    htmlStr += '</ul>'
                }
                htmlStr += '</div>';
                $("#tracking").html(htmlStr);
            }
        },
        error:function(XMLHttpRequest, textStatus) {
        }
    });
}
/*
* 取消订单
* */
function cancelOrder(orderId){
    if(confirm("您确认要取消此订单么?")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/order/cancel.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.href = dataValue.webRoot+"/module/member/orderDetail.ac?id="+orderId+"&time="+new Date().getMilliseconds();
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

/*
* 确认收货
* */
function buyerSigned(orderId){
    if(confirm("您确认收货了吗?")){
        $('#buyerSignedBtn').attr("onclick", "javascript:;");
        $('#buyerSignedBtn').html("正在提交");
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            url:dataValue.webRoot+"/order/buyerSigned.json?orderId="+orderId ,
            success:function(data) {
                if (data.success == "true") {
                    setTimeout(function(){
                        window.location.href = dataValue.webRoot+"/module/member/orderDetail.ac?id="+orderId+"&time="+new Date().getMilliseconds();
                    },1)
                } else if(data.isSigned == "true"){
                    alert("该订单已经确认收货了");
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
