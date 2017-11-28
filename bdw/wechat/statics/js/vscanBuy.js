var openId, accessToken;
var area;
$(document).ready(function () {
    var ua = navigator.userAgent.toLowerCase();
    //判断是否微信游览器
    if (ua.match(/MicroMessenger/i) == "micromessenger") {
        var uslist = ua.split("micromessenger/");
        var num = uslist[1].split(".");
        //判断微信版本号
        if (parseInt(num[0]) < 5) {
            alert("您的微信版本号太低，请进行升级!");
            setTimeout(function () {
                window.location.href = webPath.webRoot + "/wap/index.ac";
            }, 1);
            return;
        }

    } else {
        alert("请用微信进行访问!");
        setTimeout(function () {
            window.location.href = webPath.webRoot + "/wap/index.ac";
        }, 1);
        return;
    }

    $("#addorder").attr("isPayWay","N");
    $("#orderId").val("");
    $("#orderNum").val("");

    //权限参数验证
    tokenVerify();

    //用户登录
    userLogin();

    //货到付款下单
    $("#deliveryOrder").click(function () {
        var receiver = $("#receiver").val();
        if (receiver == '' || receiver == 'N') {
            alert('请选择收货地址');
            return false;
        }
        var deliveryRuleId = $("#deliveryRuleId").val();
        if (deliveryRuleId == '' || deliveryRuleId == null || deliveryRuleId == undefined) {
            alert('请选择配送方式');
            return false;
        }
        $.ajax({
            type:"GET",
            url:webPath.webRoot+"/vScanBuy/isSupportCod.json",
            data:{zoneNm:area,shopInfId:webPath.shopInfId,deliveryRuleId:deliveryRuleId},
            dataType: "json",
            success:function(data) {
                if(data.isSupportCod){
                    weixinOrder(1);
                }else{
                    alert("该区域不支持货到付款!");
                }
            },
            error:function(XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    executeError(result.errorObject.errorText);
                }
            }
        });

    });

    /*购物车商品数量改变*/
    $(".cartNum").bind('input propertychange blur', function () {
        var value = $(this).val();
        var remindVal = $(this).attr("remindVal");
        var reg = new RegExp("^[1-9]\\d*$");
        if (value == undefined || value == "") {
            return;
        }
        if (!reg.test(value)) {
            $(this).val(remindVal);
            rehref();
            return;
        }
        if (value == remindVal) {
            return;//因为是实时监听的，所以只有值改变才能去刷新页面，否则不执行任何操作
        }
        var itemKey = $(this).attr("itemKey");
        var carttype = $(this).attr("carttype");
        var handler = $(this).attr("handler");
        if (value == 0) {
            return;
        }
        updateItemNum(itemKey, carttype, handler, value, webPath.orgId);
    });
    $(".cartNum").bind('blur', function () {
        var value = $(this).val();
        var remindVal = $(this).attr("remindVal");
        if (value == undefined || value == "") {
            $(this).val(remindVal);

        }
    });

    //保存配送方式
    $(".saveDelivery").change(function () {
        var deliveryId = $(this).val();
        if (deliveryId == undefined || deliveryId == "" || deliveryId == "请选择配送方式") {
            alert("请选择配送方式");
            return;
        }
        var carttype = webPath.type;
        $.ajax({
            url: webPath.webRoot + "/cart/saveDeliveryRuleId.json",
            data: {type: carttype, deliveryRuleId: deliveryId, orgId:webPath.orgId},
            dataType: "json",
            success: function (data) {
                var shoppingcart = data.result;
                var orderTotalAmount = data.orderTotalAmoutStr;
                $(".deliveryPrice").html("￥" + data.freightAmount);
                $(".orderAmount").html("￥" + orderTotalAmount);
                $("#deliveryRuleId").val(deliveryId);
            },
            error: function (XMLHttpRequest, textStatus) {
                if (XMLHttpRequest.status == 500) {
                    var result = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(result.errorObject.errorText);
                }
            }
        });
    });
});


document.addEventListener("WeixinJSBridgeReady", function () {
    //使用微信地址本
    document.getElementById("actionAddr").addEventListener("click", function () {
//        alert("进来地址本方法");
        WeixinJSBridge.invoke('editAddress', {
            "appId": config.appid,
            "scope": "jsapi_address",
            "signType": "sha1",
            "addrSign": responParam.addrSign,
            "timeStamp": responParam.timeStamp,
            "nonceStr": "123456"
        }, function (res) {
            var err = res.err_msg;
//                alert(err);
            WeixinJSBridge.log(err);
            //若res 中所带的返回值丌为空，则表示用户选择该返回值作为收货地址。否则若返回空，则表示用户取消了这一次编辑收货地址。
            if (err == 'edit_address:fail') {
                alert("请选择收货地址!");
                return;
            }
            if (res == null || err == 'get_brand_grant_info:fail') {
                alert("地址接口有误，请稍后再试..");
                return;
            }
            if (err == 'edit_address:ok') {
//                alert("成功获取地址，进行设置值!");
                addOrderAddress(res);
                area = res.addressCountiesThirdStageName;
                getDeliveryRuleList(res.addressCountiesThirdStageName);
            }
        });
    }, !1);


    //添加订单
    document.getElementById("addorder").addEventListener("click", function () {
        weixinOrder(30);
    }, !1);
});

//微信下单
function weixinOrder(payWayId) {
    var receiver = $("#receiver").val();
    if (receiver == '' || receiver == 'N') {
        alert('请选择收货地址');
        return false;
    }
    var deliveryRuleId = $("#deliveryRuleId").val();
    if (deliveryRuleId == '' || deliveryRuleId == null || deliveryRuleId == undefined) {
        alert('请选择配送方式');
        return false;
    }
    if (payWayId == '' || payWayId == null || payWayId == undefined) {
        alert('请选择支付方式');
        return false;
    }

    var isPayWay = $("#addorder").attr("isPayWay");
    var orderId = $("#orderId").val();
    var orderNum = $("#orderNum").val();

    if (orderId != null && orderId != "" && orderNum != null && orderNum != "" && payWayId==30) {
        //这里应该不会走进来的，因为扫购订单都是还未生成的
        if (isPayWay == "N") {
            vpayWay(documentNum);

        } else {
            alert("您已支付，请查询订单!");

        }
    } else {
        addOrder(payWayId);
    }

}

//生成订单并进行微信支付
function addOrder(payWayId){
    var isCod = "N";
    if(payWayId==1){
        isCod = "Y";
    }
    $.ajax({
        url: webPath.webRoot + "/vScanBuy/addOrder.json",
        data: {
            receiverZoneId: $("#receiverZoneId").val(),
            deliveryRuleId: $("#deliveryRuleId").val(),
            payWayId: payWayId,
            periods: $("#periods").val(),
            type: webPath.type,
            orderSourceCode: "0",
            processStatCode: "0",
            name: $("#name").val(),
            addr: $("#addr").val(),
            mobile: $("#mobile").val(),
            zipcode: $("#zipcode").val(),
            tel: $("#tel").val(),
            shopInfId:webPath.shopInfId,
            isCod:isCod,
            isNeedInvoice:'N',
            zoneNm: $("#zoneNm").val()
        },
        dataType: "json",
        type: "post",
        success: function (data) {
            if (data.success == "true") {
                var orderId = data.orderId;
                var orderNum = data.orderNum;
                var documentNum = data.documentNum;
                if (payWayId == 30) {
                    //进行微信支付
                    vpayWay(documentNum);
                } else {
                    //货到付款
                    setTimeout(function () {
                        window.location.href = webPath.webRoot + "/" + webPath.authorizedPath + "/vpaySuccess.ac?id=" + orderId;
                    }, 1);
                }
            }else {
                alert("添加订单失败，请重试");
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                if ("你的购物车为空。" == result.errorObject.errorText) {
                    if (payWayId == 1) {
                        alert("订单已生成，如需货到付款，请重新扫购!");
                    } else {
                        alert("你的购物车为空。");
                    }
                    setTimeout(function () {
                        window.location.href = webPath.webRoot + "/wap/index.ac";
                    }, 1);
                } else {
                    alert(result.errorObject.errorText);
                }
            }
        }
    });
}

//微信APP支付
function vpayWay(documentNum) {
    $.ajax({
        url: webPath.webRoot + "/wxsdk/wxpay/jspay.json",
        data: {documentNum: documentNum},
        type: "post",
        success: function (data) {
            if (data.success == "true") {
                var result = eval("(" + data.result + ")");
                if (result == null) {
                    alert("请求失败，请稍后再进行支付...");
                    result;
                }
                var appId = result.appId;
                var package = result.package;
                var timestamp = result.timestamp;
                var noncestr = result.noncestr;
                var paySign = result.paySign;
                var signType = result.signType;

//                alert("进行微信支付");
                //微信app支付
                WeixinJSBridge.invoke('getBrandWCPayRequest', {
                    "appId": appId,
                    "timeStamp": timestamp,
                    "nonceStr": noncestr,
                    "package": package,
                    "signType": signType,
                    "paySign": paySign
                }, function (res) {
                    // 返回 res.err_msg,取值
                    // get_brand_wcpay_request:cancel 用户取消
                    // get_brand_wcpay_request:fail 发送失败
                    // get_brand_wcpay_request:ok 发送成功

                    var err = res.err_msg;
//                            alert(err);
//                            alert(res.err_code + res.err_desc);
                    WeixinJSBridge.log(err);
                    if (res == null || err == 'get_brand_wcpay_request:fail') {
                        alert("支付失败!");
                        setOrderParam(orderId,orderNum);
                        return;
                    }
                    if (err == 'get_brand_wcpay_request:cancel') {
//                        alert("您已取消该次支付!");
                        setOrderParam(orderId,orderNum);
                        return;
                    }
                    if (err == 'get_brand_wcpay_request:ok') {
                        $("#addorder").attr("isPayWay","Y");
                        setTimeout(function () {
                            window.location.href = webPath.webRoot + "/wap/shoppingcart/returnPay.ac" ;
                        }, 1);
                    }
                });
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}

function setOrderParam(orderId,orderNum){
    $("#orderId").val(orderId);
    $("#orderNum").val(orderNum);
}


function updateItemNum(itemKey, carttype, handler, value, orgId) {
    $.ajax({
        url: webPath.webRoot + "/cart/update.json",
        data: {quantity: value, itemKey: itemKey, type: carttype, handler: handler, orgId: orgId},
        dataType: "json",
        success: function (data) {
            rehref();
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    })
}

function rehref() {
    var carttype = getUrlParamValue("carttype");
    var handler = getUrlParamValue("handler");
    var showwxpaytitle = getUrlParamValue("showwxpaytitle");
    var code = getUrlParamValue("code");
    var state = getUrlParamValue("state");
    var url = webPath.pageUrl;
    if (carttype == '') {
        url = url + "carttype=" + carttype;
    }
    if (handler == '') {
        var separator = carttype != "" ? "&" : "";
        url = url + separator + "handler=" + handler;
    }
    if (showwxpaytitle == '') {
        var separator = handler != "" ? "&" : "";
        url = url + separator + "showwxpaytitle=" + showwxpaytitle;
    }
    if (code == '') {
        var separator = showwxpaytitle != "" ? "&" : "";
        url = url + separator + "code=" + code;
    }
    if (state == '') {
        var separator = code != "" ? "&" : "";
        url = url + separator + "state=" + state;
    }
    window.location.href = url + "&rd=" + Math.random();
}

function getUrlParamValue(param){
    var url = location.href;
    var paraString = url.substring(url.indexOf("?")+1,url.length).split("&");
    var paraObj = {};
    for (var i=0; i < paraString.length; i++){
        var j=paraString[i];
        if(j.substring(0,j.indexOf("=")).toLowerCase() == param.toLowerCase()){
            paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
        }
    }
    var returnValue = paraObj[param.toLowerCase()];
    if(typeof(returnValue)=="undefined"){
        return "";
    }else{
        return returnValue;
    }
}


//同步微信收货地址到订单
function addOrderAddress(addrData) {
    $(".defAddrBox").hide();
    $(".addrBox").show();
    $("#name").val(addrData.userName);
    $("#addr").val(addrData.addressDetailInfo);
    $("#mobile").val(addrData.telNumber);
    $("#zipcode").val(addrData.addressPostalCode);
    $("#tel").val(addrData.telNumber);
    $("#zoneNm").val(addrData.addressCountiesThirdStageName);

    //更新页面状态
    $(".addrDetail").html(addrData.addressDetailInfo);
    $(".userName").html(addrData.userName);
    $(".telNum").html(addrData.telNumber);
    $(".defAddr").hide();
    $(".weixinAddr").show();
    $("#receiver").val("Y");
}

//获取配送方式
function getDeliveryRuleList(zoneNm) {
    $.ajax({
        url: webPath.webRoot + "/vScanBuy/getDeliveryRule.json",
        data: {type: webPath.type,zoneNm: zoneNm, shopInfId: webPath.shopInfId},
        dataType: "json",
        type: "post",
        success: function (data) {
            if (data.success == "true") {
                var deliveryRuleList = data.deliveryRuleList;
                var str = $("#selectDelivery");
                $("#selectDelivery").empty();
                $("#selectDelivery").append('<option>请选择配送方式</option>');
                $.each(deliveryRuleList, function (key, rule) {
                    str.append('<option class="" value="' + rule.deliveryRule.deliveryRuleId + '">' + rule.deliveryRuleNm + '</option>');
                });
                $(".defSelectDelivery").hide();
                $(".saveDelivery").show();

            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}

//权限验证
function tokenVerify() {
    if (responParam.accessToken == '' || responParam.openid == '') {
        if (responParam.errcode == '' || responParam.errmsg == '') {
            alert("请求错误，请稍后再试...");
        } else {
            alert("错误码：" + responParam.errcode + "说明：" + responParam.errmsg);
        }

    }
//    alert(responParam.accessToken + "---------" + responParam.openid);
}

//用户登录
function userLogin() {
    $.ajax({
        url: webPath.webRoot + "/vScanBuy/login.json",
        data: {vuserId: responParam.openid},
        dataType: "json",
        type: "post",
        success: function (data) {
            if (data.success == "true") {
//                alert("登录成功");
            }else{
                //alert("登录失败!");
                location.href= webPath.webRoot + "/wechat/vregorbind.ac?id=" + responParam.openid;
            }
        },
        error: function (XMLHttpRequest, textStatus) {
            if (XMLHttpRequest.status == 500) {
                var result = eval("(" + XMLHttpRequest.responseText + ")");
                alert(result.errorObject.errorText);
            }
        }
    });
}
