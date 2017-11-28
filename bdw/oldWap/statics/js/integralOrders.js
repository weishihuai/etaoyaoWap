/*
 * 确认收货
 * */
function buyerSigned(orderId){
    confirm("您确认收货了吗?",{onSuccess:function(){
            $('#buyerSignedBtn').attr("onclick", "javascript:;");
            $('#buyerSignedBtn').html("正在提交");
            $.ajax({
                type:"GET",
                url:dataValue.webRoot+"/integralOrder/buyerSigned.json?integralOrderId="+orderId,
                success:function(data) {
                    alert("success");
                    if (data.success == "true") {
                        alert("true");
                        window.location.reload();
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    alert("error");
                    alert("确认收货失败！");
                }
            });
        }});
    return false;
}