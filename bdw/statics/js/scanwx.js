$(function(){
    $('#divId').timer({
        duration: '6s',//如果要倒数五分钟三十秒可以写成:5m30s
        callback: function() {
            selectOrder();
        },
        repeat: true, //重复触发callback内容,时间会持续增加
        reset: true //重置时间数,让它从0继续开始
    });
});

//查询订单
var selectOrder = function () {
    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type: "GET",
        url: webPath.webRoot + "/order/selectOrder.json",
        data: {
            documentNum:webPath.documentNum
        },
        dataType: "json",
        success: function (data) {
            if (data.success == "true") {
                $('#divId').timer('pause');
                alert("支付成功，确认之后将返回我的订单");
                window.location.href = webPath.webRoot + "/module/member/orderList.ac";
                return;
            }else if(data.success == "false"){
                $('#divId').timer('resume');
                return;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                $('#divId').timer('pause');
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
                $('#divId').timer('resume');
                return;
            }
        }
    });
}
