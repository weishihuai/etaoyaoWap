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

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telphone=no, email=no"/>
    <title>收银台</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/vpaycashier.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/footer.css" rel="stylesheet">
    <script type="text/javascript">var webPath = {webRoot: "${tempContextUrl}", orderId: "${param.orderId}"};</script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script type="text/javascript">
        /*document.addEventListener("WeixinJSBridgeReady", function () {
            document.getElementById("weixinPay").addEventListener("click", function () {
//                alert("进行微信支付中.....");
                <%--vpayWay('${param.documentNum}');--%>
            }, !1);
        });*/

        $(function(){
            document.addEventListener("WeixinJSBridgeReady", function () {
                <%--document.getElementById("weixinPay").addEventListener("click", function () {--%>
                <%--vpayWay('${param.documentNum}');--%>
                <%--}, !1);--%>
                vpayWay('${param.documentNum}');
            });
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
<%--页头开始--%>
<c:import url="/template/bdw/wap/module/common/head.jsp?title=微信支付"/>
<%--页头结束--%>

    <!--中间内容-->
    <div class="main m-checkout">
        <img class="vpay_pic" src="${webRoot}/template/bdw/wap/statics/images/vpay.png" />
        <div class="alertMsg">
            正在为您打开微信支付窗口...
        </div>

        <%--<div class="tip">
            <p>共${orderSize}笔订单</p>
        </div>--%>

        <%--<div class="tip">
            <p>流水编号:${param.documentNum}</p>
        </div>

        <div class="tip">
            <p>您需支付:&yen;${cashAmount}</p>
        </div>--%>

        <div class="m-checkout-bd" style="display: none">
                <div class="entry-list">
                    <%--<h2 class="entry-list-title">在线支付</h2>--%>
                    <div class="entry-block">
                        <a href="javascript:void(0);">
                        <span class="img">
                            <img src="${webRoot}/template/bdw/wap/statics/images/pay-wechat.png" alt="">
                        </span>
                            <span class="tit">订单编号:${param.documentNum}</span>
                            <%--<span class="icon-hint"></span>--%>
                        </a>
                    </div>
                    <div class="entry-block">
                        <a href="javascript:void(0);">
                        <span class="img">
                            <img src="${webRoot}/template/bdw/wap/statics/images/pay-wechat.png" alt="">
                        </span>
                            <span class="tit">您需支付:&yen;${cashAmount}</span>
                            <%--<span class="icon-hint"></span>--%>
                        </a>
                    </div>
                </div>

            </div>

        <%--<div class="m-checkout-bd">
            <div class="entry-list">
                <h2 class="entry-list-title">在线支付</h2>
                <div class="entry-block">
                    <a href="javascript:;">
                        <span class="img">
                            <img src="images/pay-aipay.png" alt="">
                        </span>
                        <span class="tit">支付宝</span>
                        <span class="icon-hint"></span>
                    </a>
                </div>
                <div class="entry-block">
                    <a href="javascript:;">
                        <span class="img">
                            <img src="images/pay-wechat.png" alt="">
                        </span>
                        <span class="tit">微信支付</span>
                        <span class="icon-hint"></span>
                    </a>
                </div>
                <div class="entry-block">
                    <a href="javascript:;">
                        <span class="img">
                            <img src="images/pay-bank.png" alt="">
                        </span>
                        <span class="tit">工商银行</span>
                        <span class="icon-hint"></span>
                    </a>
                </div>
            </div>

        </div>--%>

        <div class="m-checkout-ft" style="display: none;">
            <button class="btn-block" type="button" id="weixinPay">确认支付</button>
        </div>
    </div>
</body>

</html>




