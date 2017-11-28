$(function(){

    if (webPath.logisticsNum!='') {
        loadTracking();
    }
});

function loadTracking(){
    $.ajax({
        type: "post",
        url: webPath.webRoot+"/order/searchIntegralOrderLogisticsStatus.json?_method=post",
        data:{integralOrderId:webPath.integralOrderId},
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