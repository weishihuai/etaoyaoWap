
/*
* 确认收货
* */
function buyerSigned(integralOrderId){
    if(confirm("您确认收货了吗?")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type:"GET",
            dataType: "json",
            url:Top_Path.webRoot+"/integralOrder/buyerSigned.json?integralOrderId="+integralOrderId ,
            success:function(data) {
                if (data.success == "true") {
                    window.location.reload();
                    //setTimeout(function(){
                    //    window.location.href = Top_Path.webRoot+"/module/member/integralOrderDetail.ac?id="+integralOrderId+"&time="+new Date().getMilliseconds();
                    //},1)
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                alert("确认收货失败！");
            }
        });
    }
    return false;
}
function goToPay(integralOrderId){
    window.location.href =  Top_Path.webRoot+"/integral/IntegralCashier.ac?integralOrderId=" + integralOrderId;
}

/**
 *  取消订单
 */

function cancelIntegralOrder(integralOrderId){
    if(confirm("您确定要取消订单?")){
        $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8;";
        $.ajax({
            type : "GET",
            dateType : "json",
            url : Top_Path.webRoot + "/integralOrder/orderCanceled.json?integralOrderId=" + integralOrderId,

            success : function(data){
                if(data.success == "true"){
                    window.location.reload();
                    /*setTimeout(function(){
                        window.location.href = dataValue.webRoot+"/module/member/integralOrderDetail.ac?id=" + integralOrderId;
                    })*/
                }
            },
            error : function(XmlHttpRequest, textStatus){
                alert("取消订单失败");
            }
        })
    }
    return false;
}

