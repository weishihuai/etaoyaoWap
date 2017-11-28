var addrSelect;

var feePrice = 0.0;


$(document).ready(function () {


    //加载联动地址栏
    addrSelect = $(".addressSelect").ld(
        {
            ajaxOptions: {"url": webPath.webRoot + "/member/addressBook.json"},
            defaultParentId: 9,
            style: {"width": 100}
        });
    //选择地址栏
    $(".selectAddres").find("input").click(function () {
        var path = $(this).attr("addressPath");
        $(".showAddress_path").val(path);
        var paths = path.split("-");
        var provinceNm = paths[2];
        var cityNm = paths[3];
        var zoneNm = paths[4];
        var name = $(this).attr("addrname");
        var addrmobile = $(this).attr("addrmobile");
        var addrzip = $(this).attr("addrzip");
        var address = $(this).attr("address");
        var addrtel = $(this).attr("addrtel");
        addrSelect.ld("api").selected([$.trim(provinceNm), $.trim(cityNm), $.trim(zoneNm)]);
        $("#receiverName").val(name);
        $("#receiverAddr").val(address);
        $("#receiverMobile").val(addrmobile);
        $("#receiverZipcode").val(addrzip);
        $("#receiverTel").val(addrtel);
    });

    //加载地址表单验证控件
    $.formValidator.initConfig({
        validatorGroup: "2", theme: 'ArrowSolidBox', onError: function (msg) {
            alert(msg)
        }, inIframe: true, ajaxForm: {}
    });

    //邮编
    $("#receiverZipcode").click(function () {
        var cityId = $("#cityId").val();
        if (cityId != null && cityId != "") {
            $("#zipPrompt").load(webPath.webRoot + "/shoppingcart/zipCode.ac?cityId=" + cityId, null, function () {
                $("#zipPrompt").offset({top: $("#receiverZipcode").position().top + 24});
                $("#zipPrompt").show();
            });
        } else {
            $("#zipPrompt").hide();
        }
    });
    $("#ul_zip_prompt").find("li").live('click', function () {
        $("#receiverZipcode").attr("value", $(this).attr("value"));
        $("#zipPrompt").hide();
    });

    //提交订单
    $(".submitOrder").click(function () {
        var hasCurNum = 0;
        var selectAddressList = $(".selectAddress");
        selectAddressList.each(function () {
            var strClass = $(this).attr("class");
            var strs = strClass.split(" ");
            var hasClass = $.inArray("cur", strs);
            if (hasClass != -1) {
                //存在
            } else {
                hasCurNum += 1;//不存在
            }
        });
        if (selectAddressList.length == hasCurNum) {
            alert("请选择收货地址");
            return false;
        }
        //获取积分尚品ID ，商品数量，选中地址的ID
        var integralProductId = $(this).attr("integralProductId");
        //数量
        var num = $(this).attr("num");
        var integralProductNum = $(this).attr("integralProductNum");
        //验证传入数量是否为整数字
        if (isNaN(num) || integralProductNum < num) {
            alert("库存不足!");
            goToUrl(webPath.webRoot + "/integral/integralDetail.ac?integralProductId=" + integralProductId + "&pitchOnRow=18");
        }
        //var convertTotalAmount=num*exchangeAmount;
        //收货地址
        var receiveAddrId = $("#receiveAddrId").attr("receiveAddrId");
        //支付类型
        var integralExchangeType = $("#integralExchangeType").attr("integralExchangeType");

        //保存用户积分商品订单
        $.ajax({
            type: "post",
            url: webPath.webRoot + "/integralOrder/addIntegralOrder.json",
            data: {
                integralProductId: integralProductId,
                receiveAddrId: receiveAddrId,
                num: num,
                paymentConvertTypeCode: integralExchangeType
            },
            async: false,
            dataType: "json",
            success: function (data) {
                if (data.success == "true") {
                    if (integralExchangeType == 0) {
                        alert("订单提交成功");
                        window.location.href = webPath.webRoot + "/module/member/integralOrderList.ac?pitchOnRow=18";
                    } else if (integralExchangeType == 1) {
                        alert("订单提交成功,点击确定后将跳到收银台进行金额支付");
                        window.location.href = webPath.webRoot + "/integral/integralCashier.ac?integralOrderId=" + data.integralOrderId;
                    }
                } else if (data - success == "false") {
                    alert("订单提交失败");
                }
            }
            ,
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });

    /*弹出层*/
    $("#addAddress").click(function () {
        var isLogin = $(this).attr("isLogin");
        if (isLogin == "true") {
            alert("请登录");
            goToUrl(webPath.webRoot + "/login.ac");
            return;
        }
        showMyAddress();
        $("#easyDialogBox").css("margin", "-380.5px 0 0 -493px");
    });

    $(".closeMyAddress").click(function () {
        hideMyAddress()
    });


    var showMyAddress = function () {
        easyDialog.open({
            container: 'myAddress',
            fixed: true,
            /*        yesFn : btnFn,*/
            noFn: true
        });
    };


    var hideMyAddress = function () {
        easyDialog.close();
        $('#userAddrForm')[0].reset();
    };


    /*保存新地址*/
    $("#saveAddress").click(function () {
        if ($("#receiverZipcode").val() == "") {
            setTimeout(function () {
                $("#receiverZipcodeTip").empty();
            }, 30);
        }
        if ($("#receiverTel").val() == "") {
            setTimeout(function () {
                $("#receiverTelTip").empty();
            }, 30);
        }
        //表单提交
        $('#userAddrForm').submit();

        //清空属性值
        $("#receiverName").val("");
        $("#receiverAddr").val("");
        $("#receiverMobile").val("");
        $("#receiverZipcode").val("");
        $("#receiverTel").val("");
    });
    //加载地址表单验证控件
    $.formValidator.initConfig({
        formID: "userAddrForm", theme: 'ArrowSolidBox', onError: function (msg) {
            alert(msg)
        }, inIframe: true, ajaxForm: {
            dataType: "json",
            type: 'POST',
            url: webPath.webRoot + "/cart/saveReceiver.json?type=" + $("#type").val(),
            buttons: $("#saveAddress"),
            async: true,
            error: function (jqXHR, textStatus, errorThrown) {
                alert("服务器没有返回数据，可能服务器忙，请重试" + errorThrown);
            },
            success: function (data) {
                window.location.reload();
//            hideMyAddress();
            }
        }
    });
    /*新地址验证*/
    $("#receiverName").formValidator({
        onShow: "请输入收货人姓名",
        onFocus: "输入收货人的姓名（中文2~5个字，英文4~10个字母）",
        tipCss: {width: 200}
    }).inputValidator({min: 4, max: 10, onError: "请正确输入您的姓名（中文2~5个字，英文4~10个字母）"});

    $("#zone").formValidator({
        onShow: "请输入收货人所在地",
        onFocus: "请输入收货人所在地"
    }).inputValidator({min: 1, onError: "地区信息不完整！"});


    $("#receiverAddr").formValidator({
        onShow: "请输入收货地址",
        onFocus: "请输入收货地址"
    }).inputValidator({min: 1, onError: "收货地址不能为空！"});

    $("#receiverMobile").formValidator({
        onShow: "请输入手机号码"
        , onFocus: "请输入手机号码",
        tipCss: {width: 200}, tipID: "receiverMobileTip"
    }).
        inputValidator({min: 11, max: 11, onError: "手机号码必须是11位的,请确认"}).
        regexValidator({regExp: "mobile", dataType: "enum", onError: "你输入的手机号码格式不正确"});

    $("#receiverTel").formValidator({
        empty: true, onShow: "请输入你的联系电话，可以为空哦",
        onFocus: "格式例如：0577-88888888", tipCss: {width: 200}
    }).regexValidator({regExp: "^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$", onError: "你输入的联系电话格式不正确"});

    $("#receiverZipcode").formValidator({
        empty: true,
        onShow: "请输入正确的邮政编码",
        onFocus: "有助于快速确定送货地址"
    }).inputValidator({min: 6, max: 6, onError: "您输入的邮政编码有误"});
    /*弹出层*/

    /*选择订单收货地址 设置默认地址*/
    $(".selectAddress").click(function () {
        var strClass = $(this).attr("class");
        var strs = strClass.split(" ");
        var hasClass = $.inArray("cur", strs);
        if (hasClass != -1) {
            return false;//存在
        }
        var receiveAddrId = $(this).attr("receiveAddrId");
        var type = $("#type").val();
        var selectAddress = $(this);

        setTimeout(function () {
            selectAddressFun(receiveAddrId, selectAddress, type);
        }, 500);
    });
    $(".selectAddress").hover(function () {
        $(this).css("cursor", "pointer");
    });
});


/*选中订单地址*/
var selectAddressFun = function (receiveAddrId, div, type) {
    var cartType = type;
    var selectAddress = div;
    $("#zoomloader").show();
    $.ajax({
        url: webPath.webRoot + "/cart/updateReceiver.json",
        data: ({type: cartType, receiveAddrId: receiveAddrId, isCod: orderData.isCod}),
        success: function (data) {
            if (data.success == "true") {
                $(".selectAddress").removeClass("cur");
                selectAddress.addClass("cur");
                //配送方式处理
                if (data.result == null) {
                    setTimeout(function () {
                        $("#zoomloader").hide();
                    }, 500);
                    return fasle;
                }
                checkInvalidCartItem(eval(data.unSupportDeliveryItemKeys));
                var deliveryRule = eval(data.result);

                for (var i = 0; i < deliveryRule.length; i++) {
                    var saveDelivery = $(".saveDelivery[orgid=" + deliveryRule[i].orgId + "]");
                    if (deliveryRule[i].deliveryRuleVoList.length == 0) {
                        saveDelivery.hide();
                        saveDelivery.next(".operationMsg").html("该地区不支持货到付款");
                    } else {
                        saveDelivery.show();
                        saveDelivery.next(".operationMsg").hide();
                        var deliveryRuleVoList = deliveryRule[i].deliveryRuleVoList;
                        saveDelivery.empty();
                        saveDelivery.append('<option value="0">请选择配送方式</option>');
                        for (var drListIndex = 0; drListIndex < deliveryRuleVoList.length; drListIndex++) {
                            var drv = deliveryRuleVoList[drListIndex];
                            var valueId = drv.deliveryRule.deliveryRuleId;
                            var valueNm = drv.deliveryRuleNm;
                            saveDelivery.append('<option value="' + valueId + '">' + valueNm + '</option>');
                        }
                    }
                }
                setTimeout(function () {
                    $("#zoomloader").hide();
                }, 500);
                window.location.reload();
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                //var error = eval("(" + result + ")");
                alert(result.errorObject.errorText);
                coupon.attr("checked", false)

            }
        }
    });
};
var checkInvalidCartItem = function (unSupportDeliveryItemKeys) {
    if (invalidCartItems.length != unSupportDeliveryItemKeys.length) {
        window.location.reload();
    }
    //相同数量
    var sameCount = 0;
    for (var i = 0; i < invalidCartItems.length; i++) {
        for (var c = 0; c < unSupportDeliveryItemKeys.length; c++) {
            if (invalidCartItems[i] == unSupportDeliveryItemKeys[c]) {
                sameCount++;
            }
        }
    }
    if (sameCount != unSupportDeliveryItemKeys.length) {
        window.location.reload();
    }
};



