<%@ page import="com.iloosen.imall.client.constant.core.ISysPaymentClearingDocument" %>
<%@ page import="com.iloosen.imall.client.commons.StringUtils" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysPaymentClearingDocument" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
    request.setAttribute("tempContextUrl", tempContextUrl);
%>
<!doctype html>
<html>
<head>
    <title>微信支付收银台</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/wap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/member.css" rel="stylesheet">

    <script type="text/javascript">var webPath = {webRoot: "${tempContextUrl}", orderId: "${param.orderId}"};</script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        document.addEventListener("WeixinJSBridgeReady", function () {
            document.getElementById("weixinPay").addEventListener("click", function () {
//                alert("进行微信支付中.....");
                vpayWay('${param.documentNum}');
            }, !1);
        });

        //微信APP支付
        function vpayWay(documentNum) {
            $.ajax({
                url: webPath.webRoot + "wxsdk/wxpay/jspay.json",
                data: {documentNum: documentNum},
                type: "post",
                success: function (data) {
//                    alert("成功生成支付");
//                    alert(data.result);
//                    alert(eval("(" + data.result + ")").appId);
                    if (data.success == "true") {
                        var result = eval("(" + data.result + ")");
                        if(result==null){
                            alert("请求失败，请稍后再进行支付...");
                            result;
                        }
                        var appId = result.appId;
                        var package = result.package;
                        var timestamp = result.timestamp;
                        var noncestr = result.noncestr;
                        var paySign = result.paySign;
                        var signType = result.signType;
                        alert("成功生成支付");
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
                            alert(err);
                         //   alert(res.err_code + res.err_desc);
                            WeixinJSBridge.log(err);
                            if (res == null || err == 'get_brand_wcpay_request:fail') {
                                alert("支付失败!");
                                return;
                            }
                            if (err == 'get_brand_wcpay_request:cancel') {
//                                alert("您已取消该次支付!");
                                return;
                            }
                            if (err == 'get_brand_wcpay_request:ok') {
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

    </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/wap/module/common/head.jsp?title=订单提交成功"/>
<%--页头结束--%>
<div class="container">
    <h5 style="font-weight:bold; padding:10px 0 5px;">请点击按钮进行订单支付</h5>
    <div class="row">

        ${param.documentNum}

                    <div class="col-xs-12">
                        <button class="btn btn-danger btn-block v-qd" id="weixinPay" style="margin:0; height:50px;" type="button">微信支付</button>
                    </div>

    </div>
    <div class="row">
        <div class="col-xs-12">
            <button type="button" class="btn btn-default btn-lg btn-block" style="margin:10px 0; font-size:12px; height: 50px;" onclick="window.location.href='${webRoot}/wap/module/member/orderDetail.ac?id=${param.orderId}';">查看订单详情</button>
        </div>
    </div>
</div>
<%--menu开始--%>
<%--<c:import url="/template/jvan/wap/module/common/menu.jsp"/>--%>
<%--menu结束--%>
</body>
</html>
