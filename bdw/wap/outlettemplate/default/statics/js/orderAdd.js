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
            window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/couponSelect.ac?cartType=" + webPath.cartType + "&sysOrgId=" + $(this).attr("data-org-id") + "&time=" + new Date().getTime();
        }
    });

    $(".users-info").click(function () {
          window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/addrSelect.ac?cartType=" + webPath.cartType + "&handler=" + webPath.handler + "&isCod=" + webPath.isCod + "&time=" + new Date().getTime();
    });
    $(".no-address").click(function () {
          window.location.href = webPath.webRoot + "/wap/outlettemplate/default/shoppingcart/addrSelect.ac?cartType=" + webPath.cartType + "&handler=" + webPath.handler + "&isCod=" + webPath.isCod + "&time=" + new Date().getTime();
    });

    $(".remark").blur(function(){
        var remark=  $(this).val();
        if(remark.length > 100){
            alert("交易的说明或要求 字数超过上限！");
            return false;
        }
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

    $(".sel-box .mc-lt a").click(function () {
        var cls = $(this).attr("data-type");
        $(this).parent().children().removeClass("cur");
        $(this).addClass("cur");
        $(".sel-box .mc-rt").hide();
        $(cls).show();
    });

    //提交订单
    $(".submit-order-btn").click(function(){
        if (submitting){
            return false;
        }
        submitting = true;
        if ($(".p-item").length == 0){
            alert("没有可下单的商品");
            submitting = false;
            return false;
        }
        var isSelectAddress = webPath.isSelectAddress;
        if(!isSelectAddress){
            alert("请选择收货地址");
            submitting = false;
            return false;
        }
        if(!webPath.isDeliveryTimeSelect){
            alert("请选择送达时间");
            submitting = false;
            return false;
        }
        setTimeout(function () {
            $.ajax({
                url:webPath.webRoot+"/cart/addOrder.json",
                data: $("#orderForm").serialize(),
                success:function(data){
                    submitting = false;
                    $("#paymentLoad").load(webPath.webRoot + "/wap/shoppingcart/paymentLoad.ac?cartType="+ webPath.cartType +"&orderIds=" + data.orderIds);
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