$(document).ready(function () {

});
//function check (){
//    $.ajax({
//        url: webPath.webRoot + '/member/checkUserBindBankCard.json',
//        type: "post",
//        dataType: 'json',
//        success: function (data) {
//            if (data.success == "true") {
//            } else {
//                easyDialog.open({
//                    container : {
//                        header : '提示信息',
//                        content : '检查到您尚未绑定任何银行卡,线下POS机支付时可能无法享受<span style="color: red">优惠活动</span>,立即前往 <a href="/module/member/boundBankCard.ac" style="cursor: pointer">绑定银行卡</a>',
//                        yesFn : true,
//                        notFn:true
//                    },
//                    fixed: true,
//                    lock:false,//esc可以关闭弹出层
//                });
//            }
//        },
//        error: function (XMLHttpRequest, textStatus) {
//            if (XMLHttpRequest.status == 500) {
//                var result = eval("(" + XMLHttpRequest.responseText + ")");
//                var selectRow = layer.alert(result.errorObject.errorText, 3, function () {
//                    layer.close(selectRow);
//                });
//            }
//        }
//
//    });
//}

