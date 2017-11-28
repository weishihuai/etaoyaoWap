
$(document).ready(function(){

    loadTracking();

});

/*
 * 订单物流跟踪
 * */
function loadTracking(){

    $('#tracking').html('<div id="circular"><div id="circular_1" class="circular"></div><div id="circular_2" class="circular"></div><div id="circular_3" class="circular"></div><div id="circular_4" class="circular"></div><div id="circular_5" class="circular"></div><div id="circular_6" class="circular"></div><div id="circular_7" class="circular"></div><div id="circular_8" class="circular"></div><div class="clearfix"></div></div>');
    $.ajax({
        type: "post",
        url: dataValue.webRoot+"/order/searchLogisticsStatus.json?_method=post",
        data:{orderId:dataValue.orderId},
        dataType: "json",
        success: function (data) {
            $("#loading").hide();
            var statusHtml = "";
            for (var i = 0; i < data.result.length; i++) {
                var rowData = data.result[i];
                var rowHtml = '<div class="row"><div class="col-xs-1"><img src='+(i==0?dataValue.webRoot+"/template/bdw/wap/statics/images/timer-active.png":dataValue.webRoot+"/template/bdw/wap/statics/images/timer.png")+'></div><div class="col-xs-11 wl_right"><p>' + rowData.dateString + '</p><p>' + rowData.content + '</p></div></div>';
                statusHtml = statusHtml + rowHtml;
            }
            $('#tracking').html(statusHtml);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $("#tracking").html("<div align='center' style='padding:10px;'>查询超时，物流承运商为：<b>"+dataValue.logisticsCompany+"</b>，物流单号为：<b>"+dataValue.logisticsNum+"</b>,您可以到<a target='_blank' href="+dataValue.companyHomeUrl+">"+dataValue.companyHomeUrl+"</a>进行查询</div>")
        }
    });

}