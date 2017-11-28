/**
 * Created by Administrator on 14-12-3.
 */
$(document).ready(function(){
    $("#showOrder").click(
        function() {
            $(this).toggleClass("cur");
            $(".showMyOrder").toggleClass("hideThis");
        }
    );

    $(".payment").click(function(){
        if(webPath.orderIds!="") {
            window.location.href = webPath.webRoot + "/wap/shoppingcart/payWay.ac?orderIds=" + webPath.orderIds+"&type="+webPath.type;
        }
    });

    /*$(".entry-block").click(function(){
        var payWayId = $(this).attr("payWayId");
        //$(".pay").removeClass("icon-hint");
        //$("#pay"+payWayId).addClass("icon-hint");
        webPath.payWayId = payWayId;
        $("#payWayId").val(payWayId);
        $("#goToPay").trigger("click");
    });*/

    $(".entry-block").click(function(){
        if($(this).hasClass("active")){
            return;
        }
        $(this).parent().children().removeClass("active");
        $(this).addClass("active");
        var payWayId = $(this).attr("payWayId");
        webPath.payWayId = payWayId;
        $("#payWayId").val(payWayId);
    });

    //是否使用预存款
    $(".payStoreIcon").click(function(){
        var isUsePreStore = $("#usePreStore").val();
        //使用预存款
        if(isUsePreStore=="N"){
            $("#usePreStore").val("Y");
            $("#isUseAccount").val("true");
            $(".useStorePay").css("display","block");
            if($("#prestoreEnough").attr("result") == "Y"){
                $(".pay-list").css("display","none");
                $("#payWayId").val(3);
                webPath.payWayId = 3;
                $(".entry-block").removeClass("active");
            }
        }
        //不使用预存款
        else{
            $("#usePreStore").val("N");
            $("#isUseAccount").val("false");
            $(".useStorePay").css("display","none");
            /*if($("#prestoreEnough").val("result") == "Y"){
                $(".pay-list").css("display","block");
                $("#payWayId").val(null);
                webPath.payWayId = null;
                $(".entry-block").removeClass("active");
            }*/
            $(".pay-list").css("display","block");
            $("#payWayId").val(null);
            webPath.payWayId = null;
            $(".entry-block").removeClass("active");
        }
    });
});

function goToPay(){
    if (webPath.payWayId==null||webPath.payWayId=="") {
        alert("请选择支付方式");
        return false;
    }

    //开元尚品卡支付
    if ( webPath.payWayId== 100) {
        window.location.href = webPath.webRoot + "/wap/shoppingcart/xkyCardLogin.ac?orderIds=" + webPath.orderIds;
        return;
    }
    $("#goToPay").pay({payButtonId:"goToPay",formId:"goBank"});
}