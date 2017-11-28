$(document).ready(function(){
    $(".imall_pay").click(function(){
        var formList = $("form");
        if(formList.length > 0){
            $("form")[0].submit();
        }else{
            alert("网站支付配置错误，请联系客服人员处理");
        }
    });
});