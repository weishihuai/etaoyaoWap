function submitGoBank(){
    var totalAmount = $("#totalAmount").val();

    if(totalAmount < 0){
        alert("支付金额错误，不能支付！");
        return false;
    }else{
        return true;
    }
}

(function($){

    $(document).ready(function(){
        $(".openOrderDetail").click(function(){
            var o= $(".orderDetail");
            if(o.css("display")=='none'){
                $(this).find("em").text("收起");
            } else{
                $(this).find("em").text("展开");
            }
            $(".orderDetail").toggle();
        });

        $(".check").click(function(){
            var userAmount=$(".userAmount").text();
            var orderTotalAmount=$(".orderTotalAmount").text();
            if($(this).attr("checked")){
                //因为页面格式化金额的原因，所以需要去掉金额中的所有逗号分隔符
                var leftAmount = parseFloat(orderTotalAmount.replace(/,/g,'')) - parseFloat(userAmount.replace(/,/g,''));
                if(leftAmount<=0){
                    leftAmount=0.00;
                    userAmount=orderTotalAmount
                }

                $(".tip").text("使用账号余额支付"+userAmount+"元。剩下"+leftAmount.toFixed(2)+"可以选择其他方式付款")
            }else{
                $(".tip").text("使用账号余额支付"+0.00+"元。剩下"+orderTotalAmount+"可以选择其他方式付款")
            }
        });

        $(".goToPay").click(function(){
            var isUseAccount=false;
            //  alert($(".click").attr("checked"))
            if($(".check").attr("checked")) {
                isUseAccount=true;
                $("#isUseAccount").val(isUseAccount)
            } else{
                isUseAccount=false;
                $("#isUseAccount").val(isUseAccount)
            }
        });
    })
})(jQuery);
