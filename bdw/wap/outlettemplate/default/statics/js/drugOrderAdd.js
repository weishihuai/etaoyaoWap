$(function () {

    var submitting = false;
    $(".order-main").click(function (e) {
        var layer = $(".distribution-layer");
        var target = $(e.target);
        if(layer.is(":visible") && !target.is(".distribution-layer-inner,.distribution-layer-inner *") && !target.is(".peisong,.peisong *")){
            var obj = $(".distribution-layer:visible");
            obj.find(".dd p").removeClass("cur");
            obj.find(".dd p[data-is-init='true']").addClass("cur");
            layer.hide();
        }
    });

    $(".dd-xiaoji .peisong").click(function () {
        $(this).parents(".dd").find(".distribution-layer").show();
    });

    $(".distribution-layer-inner .dd p").click(function () {
        $(this).parent().find("p").removeClass("cur");
        $(this).addClass("cur");
    });
    
    $(".dd-xiaoji .quan").click(function () {
        if($(this).attr("data-can-use") == "true"){
            window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/couponSelect.ac?handler="+ webPath.handler +"&cartType=" + webPath.cartType + "&sysOrgId=" + $(this).attr("data-org-id");
        }
    });

    $(".users-info").click(function () {
        window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/addrSelect.ac?cartType=" + webPath.cartType + "&time=" + new Date().getTime();
    });
    $(".no-address").click(function () {
        window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/addrSelect.ac?cartType=" + webPath.cartType + "&time=" + new Date().getTime();
    });

    $(".remark").blur(function(){
        var remark=  $(this).val();
        var orgId=$(this).attr("data-org-id");
        $.ajax({
            url:webPath.webRoot+"/cart/saveRemark.json",
            data:({remark: remark, orgId: orgId,type: webPath.cartType}),
            success:function(data){
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    });

    $("#callBackTel").blur(function(){
        var drugCallBackTel=  $(this).val();
        if(!/^1\d{10}$/.test(drugCallBackTel)){
            return false;
        }
        $.ajax({
            url:webPath.webRoot+"/cart/saveDrugCallBackTel.json",
            data:({drugCallBackTel: drugCallBackTel, type: webPath.cartType}),
            success:function(data){
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        })
    });

    $(".sel-box .mc-lt a").click(function () {
        var cls = $(this).attr("data-type");
        $(this).parent().children().removeClass("cur");
        $(this).addClass("cur");
        $(".sel-box .mc-rt").hide();
        $(cls).show();
    });

    $(".sel-box .mc-rt a").click(function () {
        $(".sel-box .mc-rt a").removeClass("cur");
        $(this).addClass("cur");
        var deliveryTimeStr = $(this).html();
        var deliveryDay = $(".sel-box .mc-lt a.cur").html();
        $.ajax({
            url:webPath.webRoot + "/cart/setDeliveryTime.json",
            data:{cartType: webPath.cartType, deliveryTimeStr: deliveryTimeStr, deliveryDay: deliveryDay},
            dataType: "json",
            success:function(data) {
                if (data.success == "true"){
                    window.location.reload();
                }else {
                    alert("设置送达时间失败");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });

    $(".order-info").click(function () {
        $(".sel-time").show();
    });

    //提交订单
    $(".submit-order-btn").click(function(){
        if (submitting){
            return false;
        }
        submitting = true;
        if ($(".p-item").length == 0){
            alert("没有可预定的商品");
            submitting = false;
            return false;
        }
        var isSelectAddress = webPath.isSelectAddress;
        var callBackTel = $("#callBackTel").val();
        if(!isSelectAddress){
            alert("请选择收货地址");
            submitting = false;
            return false;
        }
        if(!/^1\d{10}$/.test(callBackTel)){
            alert("请输入正确的药师回拨电话");
            submitting = false;
            return false;
        }
        if(!webPath.isDeliveryTimeSelect){
            alert("请选择送达时间");
            submitting = false;
            return false;
        }
        $("#drugCallBackTel").val(callBackTel);
        setTimeout(function () {
            $.ajax({
                url:webPath.webRoot+"/cart/addOrder.json",
                data: $("#orderForm").serialize(),
                async: false,
                success:function(data){
                    submitting = false;
                    window.location.href = webPath.webRoot + "/wap/shoppingcart/paySuccess.ac?carttype=" + webPath.cartType;
                },
                error:function(XMLHttpRequest, textStatus) {
                    submitting = false;
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }, 10);
    });

});