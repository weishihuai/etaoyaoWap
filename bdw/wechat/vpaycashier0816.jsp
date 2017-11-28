<%@ page import="com.iloosen.imall.client.commons.StringUtils" %>
<%@ page import="com.iloosen.imall.client.constant.core.ISysPaymentClearingDocument" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysPaymentClearingDocument" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
    request.setAttribute("tempContextUrl", tempContextUrl);

    //获取流水表中的金额
    String documentNum = request.getParameter("documentNum");
    if (StringUtils.isNotBlank(documentNum)) {
        List<SysPaymentClearingDocument> sysPaymentClearingDocumentList = ServiceManager.sysPaymentClearingDocumentService.findByKey(ISysPaymentClearingDocument.CLEARING_DOCUMENT_NUM, documentNum);
        if (sysPaymentClearingDocumentList != null && sysPaymentClearingDocumentList.size() > 0) {
            request.setAttribute("cashAmount", sysPaymentClearingDocumentList.get(0).getCashAmount());
            request.setAttribute("clearType",sysPaymentClearingDocumentList.get(0).getClearingDocumentTypeCode());

        }
    }
%>
<%--加这句话样式会变--%>
<%--<!doctype html>--%>
<html>
<head>
    <title>微信支付收银台</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/wap/statics/css/headerNew.css" rel="stylesheet" media="screen">
 	<link href="${webRoot}/template/bdw/wap/statics/css/buycar2New.css" rel="stylesheet" media="screen">

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
//                        alert("成功生成支付");
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
<header class="row header">
	<div class="col-xs-2"><a href="javascript:void(0);" onclick="history.go(-1);"><img src="${webRoot}/template/bdw/wap/statics/images/wsc_header_icon01New.png" width="27" height="43" /></a></div>
    <div class="col-xs-8">微信支付</div>
</header>

<article class="tips">
    <img src="${webRoot}/template/bdw/wap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
    <em>请点击按钮进行订单支付</em>
</article>

<div class="row ckout-main">
    <div class="col-xs-12 pay-box">
        <div class="col-xs-12 p-mum ">流水编号：<i>${param.documentNum}</i></div>
        <div class="col-xs-12 p-pri ">
            <span>您需支付：</span><em>￥${cashAmount}</em>

        </div>
    </div>
    <div class="col-xs-12 pay-btn"><button type="button" id="weixinPay" class="btn btn-success">微信支付</button></div>
    <c:choose>
        <c:when test="${clearType == '3'}"><%-- 3为积分订单类型 --%>
            <div class="col-xs-12 check-btn"><button type="button" class="btn btn-default" onclick="window.location.href='${webRoot}/wap/module/member/myIntegralOrders.ac';">查看我的订单</button></div>
        </c:when>
        <c:otherwise>
            <div class="col-xs-12 check-btn"><button type="button" class="btn btn-default" onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac';">查看我的订单</button></div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
