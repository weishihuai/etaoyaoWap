$(function () {

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

    $("a.distribution-btn").click(function () {
        var _this = $(this);
        var deliveryRuleId = _this.siblings(".cur").attr("data-rule-id");
        if(!deliveryRuleId){
            return false;
        }
        var orgId = _this.attr("data-org-id");
        $.ajax({
            url:webPath.webRoot + "/cart/saveDeliveryRuleId.json",
            data:{type: webPath.cartType, deliveryRuleId: deliveryRuleId, orgId: orgId},
            dataType: "json",
            success:function(data) {
                window.location.reload(true);
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });
    
    $(".dd-xiaoji .quan").click(function () {
        if($(this).attr("data-can-use") == "true"){
            window.location.href = webPath.webRoot + "/wap/shoppingcart/couponSelect.ac?cartType=" + webPath.cartType + "&sysOrgId=" + $(this).attr("data-org-id") + "&time=" + new Date().getTime();
        }
    });

    $(".users-info").click(function () {
          window.location.href = webPath.webRoot + "/wap/shoppingcart/addrSelect.ac?cartType=" + webPath.cartType + "&handler=" + webPath.handler + "&isCod=" + webPath.isCod + "&time=" + new Date().getTime();
    });
    $(".no-address").click(function () {
        var url = encodeURIComponent(window.location.href);
        window.location.href = webPath.webRoot + "/wap/module/member/addrAdd.ac?redirectUrl=" + url ;
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

    //提交订单
    $(".submit-order-btn").click(function(){
        if ($(".p-item").length == 0){
            alert("没有可下单的商品");
            return false;
        }
        var isSelectAddress = webPath.isSelectAddress;
        if(!isSelectAddress){
            alert("请选择收货地址");
            return false;
        }
        var flag = true;
        $(".peisong").each(function () {
             if($(this).attr("data-is-select-d") == "false"){
                 flag = false;
                 return false;
             }
        });
        if (!flag){
            alert("配送方式未选择");
            return false;
        }
        setTimeout(function () {
            $.ajax({
                url:webPath.webRoot+"/cart/addOrder.json",
                data: $("#orderForm").serialize(),
                success:function(data){
                    $("#paymentLoad").load(webPath.webRoot + "/wap/shoppingcart/paymentLoad.ac?cartType="+ webPath.cartType +"&orderIds=" + data.orderIds);
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        alert(result.errorObject.errorText);
                    }
                }
            });
        }, 10)
    });

});