function submitGoBank(){
    var totalAmount = $("#totalAmount").val();

    if(totalAmount < 0){
        alert("支付金额错误，不能支付！");
        return false;
    } else{
        return true;
    }
}

(function($){

    $(document).ready(function(){

        $("#usePrestore").click(function(){
            var isUserPreStore = $(this);
            var userAmount=$(".userAmount").text();
            var orderTotalAmount=$(".orderTotalAmount").text();
            if(isUserPreStore.hasClass("selected")){
                //不使用预存款
                isUserPreStore.removeClass("selected");
                $(".tip").html("使用账号余额支付0.00元。剩下"+ "<span>" + orderTotalAmount + "</span>" + "可以选择其他方式付款");
                $("#otherPayWay").text(orderTotalAmount);
            }else{
                //使用预存款
                isUserPreStore.addClass("selected");
                //因为页面格式化金额的原因，所以需要去掉金额中的所有逗号分隔符
                var leftAmount = parseFloat(orderTotalAmount.replace(/,/g,'')) - parseFloat(userAmount.replace(/,/g,''));
                if(leftAmount <= 0){
                    leftAmount=0.00;
                    userAmount = orderTotalAmount;
                    $(".ter-lt").find("span").removeClass("selected");
                    $(".payWay .item").removeClass("cur");
                    $(".item:first").removeClass("cur");
                }
                $(".tip").html("使用账号余额支付" + userAmount  +"元。剩下" + "<span>" + leftAmount.toFixed(2) + "</span>" + "可以选择其他方式付款");
                $("#otherPayWay").text(leftAmount.toFixed(2));
            }
        });

        $(".item").click(function(){
            var item = $(this);
            if($(".ter-lt").find("span").hasClass("selected")){
                $(".payWay .item").removeClass("cur");
                item.addClass("cur");
            }
        });


        $("#goToPay").click(function(){
            var isUseAccount = false;
            var payWayId = $(".cur").attr("payWayId");
            $(this).attr("payWayId", payWayId);
            $("#payWayId").val(payWayId);
            if($("#usePrestore").hasClass("selected")){
                isUseAccount = true;
                $("#isUseAccount").val(isUseAccount);
            } else {
                $("#isUseAccount").val(isUseAccount);
                if($("#payWayId").val() == null || $("#payWayId").val() == undefined || $("#payWayId").val().trim() == ""){
                    alert("请选择支付方式！");
                    return;
                }
            }
            $("#goBank").submit();
        });

        $(".ter-lt").click(function(){
            var flag = $(this).find("span");
            var userAmount = $(".userAmount").text();
            var orderTotalAmount = $(".orderTotalAmount").text();
            // 用户余额大于订单总价,可直接使用预存款支付
            if(parseFloat(userAmount.replace(/,/g,'')) >= parseFloat(orderTotalAmount.replace(/,/g,''))){
                // 已经选用预存款支付,则其他方式不可点击
                var isUserPreStore = $("#usePrestore");
                if(isUserPreStore.hasClass("selected")){
                    isUserPreStore.removeClass("selected");
                    flag.addClass("selected");
                    $(".tip").html("使用账号余额支付0.00元。剩下" + "<span>" + orderTotalAmount + "</span>" + "可以选择其他方式付款");
                    $("#otherPayWay").text(orderTotalAmount);
                    $(".item:first").addClass("cur");
                } else{
                    if( flag.hasClass("selected")){
                        flag.removeClass("selected");
                        $(".item").removeClass("cur");
                    } else{
                        flag.addClass("selected");
                        $(".item:first").addClass("cur");
                    }
                }
            }
        })

    })
})(jQuery);


function selectScanPay(nowThis){
    $(".scanClass").removeClass("selected");
    $(nowThis).addClass("selected");

    var paymentTypeCode = $(nowThis).attr("paymentTypeCode");
    var payWayId = $(nowThis).attr("payWayId");
    var isUseAccount = true;
    var totalAmount = $("#totalAmount").val();
    var extraData = $("input[name^='extraData']").val();
    var orderType = $("#orderType").val();

    $.ajaxSettings['contentType'] = "application/x-www-form-urlencoded; charset=utf-8";
    $.ajax({
        type:"POST",
        url:webPath.webRoot+"/cashier/goZJPay.json",
        dataType:"json",
        data:{payWayId:payWayId,isUseAccount:isUseAccount,totalAmount:totalAmount,extraData:extraData,orderType:orderType,},
        success:function(data){
            var scanImgUrl =  data.result;
            var zhifubao_img = webPath.webRoot+"/template/bdw/statics/case/zhifubao_scan.jpg";
            var weixin_img = webPath.webRoot+"/template/bdw/statics/case/weixin_scan.jpg";
            var src =webPath.webRoot+"/QRCodeServlet?qrcodelong="+scanImgUrl;
            if(paymentTypeCode == "27"){
                $("#scanImg").attr("src",src);
                $("#scanImgText").text("请使用支付宝扫一扫");
                $("#scanExampleImg").attr("src",zhifubao_img);

            }else if(paymentTypeCode == "28"){
                $("#scanImg").attr("src",src);
                $("#scanImgText").text("请使用微信扫一扫");
                $("#scanExampleImg").attr("src",weixin_img);
            }
            $("#scanDiv").show();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });


}