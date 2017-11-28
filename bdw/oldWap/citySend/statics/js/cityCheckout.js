/**
 * Created by lhw on 2016/12/29.
 */
jQuery(function($) {
    $(document).ready(function () {
        var isUseCoupon = false; // 是否使用购物卷

        // 选择收货地址
        $("#isNeedInvoice").click(function(){
            if ("none" == $("#invoiceDiv").css("display")){
                $("#invoiceTitle").val("");
                $("#invoiceDiv").show();
            } else {
                $("#invoiceDiv").hide();
            }
        });

        // 弹出配送方式选择框
        $("#selectDelivery").click(function(){
            $("input[name=deliveryRuleList]").attr("checked", false);
            var cartDeliveryRuleId = $(this).attr("cartDeliveryRuleId");
            if (!isEmpty(cartDeliveryRuleId)) {
                $("#deliveryDiv").find(".deliveryRule_" + cartDeliveryRuleId).attr("checked", true);
            }
            $("#deliveryDiv").show();
        });

        // 关闭配送方式选择框
        $("#deliveryDiv").find(".close").click(function(){
            $("#deliveryDiv").hide();
        });

        // 确认选择配送方式
        $("#confirmDeliverWay").click(function(){
            var deliveryRuleId = $("input[name=deliveryRuleList]:checked").val();
            if (isEmpty(deliveryRuleId)) {
                showError("请选择配送方式");
                return;
            }
            if (isEmpty(webPath.carttype) || isEmpty(webPath.orgId)) {
                showError("数据异常，请刷新后重试");
                return;
            }
            $.ajax({
                url:webPath.webRoot + "/cart/saveDeliveryRuleId.json",
                data:{type:webPath.carttype, deliveryRuleId:deliveryRuleId, orgId:webPath.orgId},
                dataType: "json",
                success:function(data) {
                    if (data.success == 'true') {
                        window.location.reload();
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        showError(result.errorObject.errorText);
                    }
                }
            });
        });

        // 弹出购物券选择框
        $("#selectCoupon").click(function(){
            if (isEmpty(webPath.userCouponListLength) || webPath.userCouponListLength == 0) {
                return;
            }
            // 没有使用购物卷则清除选中
            if (!isUseCoupon) {
                $("input[name=couponList]").attr("checked", false);
            }
            $("#couponDiv").show();
        });

        // 关闭购物券选择框
        $("#couponDiv").find(".close").click(function(){
            $("#couponDiv").hide();
        });

        // 确认选择购物卷
        $("#confirmCoupon").click(function(){
            var selectCoupon = $("input[name=couponList]:checked");
            var couponId = selectCoupon.val();
            if (isEmpty(couponId)) {
                showError("请选择购物卷");
                return;
            }
            if (isEmpty(webPath.carttype) || isEmpty(webPath.orgId)) {
                showError("数据异常，请刷新后重试");
                return;
            }
            var couponIds = [];
            couponIds.push(couponId);
            $.ajax({
                type: "POST",
                url:webPath.webRoot + "/member/couponFront/useCoupons.json",
                traditional: true,
                data:{couponIds: eval(couponIds), orgId: webPath.orgId, type: webPath.carttype},
                dataType: "json",
                success:function(data) {
                    if (data.success == 'true') {
                        isUseCoupon = true;
                        var selectCouponTxt = "优惠" + selectCoupon.attr("amount") + "元";
                        if (couponId == '0') {
                            selectCouponTxt = webPath.userCouponListLength + "张可用";
                        }
                        $("#selectCouponTxt").text(selectCouponTxt);
                        var orderTotalAmount = data.orderTotalAmoutStr; // 总金额
                        var orderTotalDiscount = data.discountAmount; // 总折扣
                        var orderTotalIntegral = data.integral; // 总积分
                        var orderFreightAmount = data.freightAmount; // 运费
                        var orderTotalAmountStr = orderTotalAmount.split(".");
                        var intgerPrice = orderTotalAmountStr[0];
                        var decimalPrice = orderTotalAmountStr[1];
                        if (isEmpty(decimalPrice)) {
                            decimalPrice = "00";
                        } else if (decimalPrice.length == 1) {
                            decimalPrice += "0";
                        }
                        $("#orderTotalAmount").find(".intgerPrice").text(intgerPrice);
                        $("#orderTotalAmount").find(".decimalPrice").text("." + decimalPrice);
                        $("#discountAmount").text(orderTotalDiscount);
                        $("#obtainTotalIntegral").text(orderTotalIntegral);
                        $("#freightAmount").text(orderFreightAmount);
                        $("#couponDiv").hide();
                    }
                },
                error:function(XMLHttpRequest, textStatus) {
                    if (XMLHttpRequest.status == 500) {
                        var result = eval("(" + XMLHttpRequest.responseText + ")");
                        showError(result.errorObject.errorText);
                    }
                }
            });
        });

        // 提交订单
        $("#submitOrder").click(function(){
            // 收货地址
            var receiveAddrId = $(".receiveAddr").attr("receiveAddrId");
            if (isEmpty(receiveAddrId)) {
                showError("请选择收货地址");
                return;
            }
            // 配送方式
            var deliveryRuleId = $("#selectDelivery").attr("cartDeliveryRuleId");
            if (isEmpty(deliveryRuleId)) {
                showError("请选择配送方式");
                return;
            }
            // 是否需要发票
            if ($("#isNeedInvoice").attr("checked")) {
                if (isEmpty($("#invoiceTitle").val())) {
                    showError("请输入发票抬头");
                    return;
                }
                $("#submitIsNeedInvoice").val("Y");
                $("#submitInvoiceTitle").val($("#invoiceTitle").val());
            } else {
                $("#submitIsNeedInvoice").val("N");
                $("#submitInvoiceTitle").val("");
            }
            // 备注留言
            if (isEmpty($("#orderRemark").val())) {
                $("#submitRemark").val("");
            } else {
                $("#submitRemark").val($("#orderRemark").val());
            }
            // 主要参数
            if (isEmpty($("#submitOrderSourceCode").val()) || isEmpty($("#submitProcessStatCode").val()) || isEmpty($("#submitCarttype").val()) || isEmpty($("#submitOrgId").val()) || isEmpty($("#submitIsCod").val())) {
                showError("数据异常，请刷新后重试");
                return;
            }
            // 提交订单
            setTimeout($("#orderForm").submit(),10);
        });
    });
});

// 跳转到店铺
function gotoStore(obj){
    var orgId = $(obj).attr("orgId");
    var isSupportBuy = $(obj).attr("isSupportBuy");
    if (isEmpty(orgId)) {
        return;
    }
    if (isEmpty(isSupportBuy) || 'Y' != isSupportBuy) {
        showError("该店铺不支持购买");
        return;
    }
    window.location.href = webPath.webRoot + "/wap/citySend/storeIndex.ac?orgId=" + orgId;
}

function isEmpty(val) {
    if (val == undefined || val == null || $.trim(val) == "") {
        return true;
    } else {
        return false;
    }
}