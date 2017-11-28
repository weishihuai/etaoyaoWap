$(document).ready(function(){

    loadTracking();

});


/*
 * 换货物流跟踪
 * */
function loadTracking(){

    //$('.logs-detail').html('<div id="circular"><div id="circular_1" class="circular"></div><div id="circular_2" class="circular"></div><div id="circular_3" class="circular"></div><div id="circular_4" class="circular"></div><div id="circular_5" class="circular"></div><div id="circular_6" class="circular"></div><div id="circular_7" class="circular"></div><div id="circular_8" class="circular"></div><div class="clearfix"></div></div>');
    $.ajax({
        type: "post",
        url: dataValue.webRoot+"/order/searchLogisticsStatus.json?_method=post",
        data:{orderId:dataValue.orderId},
        dataType: "json",
        success: function (data) {
            //$("#loading").hide();
            var statusHtml = "";
            for (var i = 0; i < data.result.length; i++) {
                var rowData = data.result[i];
                var rowHtml = i==0?'<dt>物流跟踪</dt><dd><p>' + rowData.content + '</p><p>'+rowData.dateString+'</p></dd>':'<dd><p>' + rowData.content + '</p><p>'+rowData.dateString+'</p></dd>';
                statusHtml = statusHtml + rowHtml;
            }
            $('#tracking').html(statusHtml);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $("#tracking").html("<dd>查询超时，物流承运商为：<p>"+dataValue.logisticsCompany+"</p>，物流单号为：<p>"+dataValue.logisticsNum+"</p>,您可以到<a target='_blank' href="+dataValue.companyHomeUrl+">"+dataValue.companyHomeUrl+"</a>进行查询</dd>")
        }
    });

}