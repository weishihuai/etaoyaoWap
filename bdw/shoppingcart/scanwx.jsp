<%@ page import="com.iloosen.imall.client.constant.core.ISysPaymentClearingDocument" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysPaymentClearingDocument" %>
<%@ page import="com.iloosen.imall.module.vmall.wxapi.enums.PayPackageTypeEnum" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="java.util.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>


<%
    /*生成二维码*/
    String documentNum = request.getParameter("documentNum");

    //获取流水表中的金额
    if (StringUtils.isNotBlank(documentNum)) {
        List<SysPaymentClearingDocument> sysPaymentClearingDocumentList = ServiceManager.sysPaymentClearingDocumentService.findByKey(ISysPaymentClearingDocument.CLEARING_DOCUMENT_NUM, documentNum);
        if (sysPaymentClearingDocumentList != null && sysPaymentClearingDocumentList.size() > 0) {
            request.setAttribute("cashAmount", sysPaymentClearingDocumentList.get(0).getCashAmount());
            request.setAttribute("documentCreateTime", sysPaymentClearingDocumentList.get(0).getCreateDateString());

            String payUserIp = "";
            String forwardedStr = request.getHeader("x-forwarded-for");
            if (org.apache.commons.lang.StringUtils.isNotBlank(forwardedStr)) {
                String[] ips = forwardedStr.split(",");
                for (String ip : ips) {
                    if (StringUtils.isNotBlank(ip) && !ip.equals("unknown")) {
                        payUserIp = ip;
                    }
                }
            }
            payUserIp = request.getRemoteAddr();
            String payPatch = ServiceManager.weixinApiService.getPayPackage(PayPackageTypeEnum.SOURCE_CODE_URL, payUserIp, documentNum);
            pageContext.setAttribute("payPatch", payPatch);

            Map<String, String> codeMap = (Map<String, String>) WebContextFactory.getWebContext().getSessionAttr("qrcodeLongCode");
            if (codeMap == null) {
                codeMap = new HashMap<String, String>();
            }
            GregorianCalendar cal = new GregorianCalendar();
            cal.setTime(new Date());
            String uuid = UUID.randomUUID().toString();
            StringBuilder builder = new StringBuilder();
            builder.append(uuid).append(cal.getTimeInMillis());
            codeMap.put(builder.toString(), payPatch);
            WebContextFactory.getWebContext().setSessionAttr("qrcodeLongCode", codeMap);
            pageContext.setAttribute("qrcodelong1", builder.toString());
        }
    }


    /*生成二维码*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>微信扫付-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/wxpay.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",documentNum:"${param.documentNum}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/timer.jquery.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/scanwx.js"></script>
</head>
<body>
<button id="divId" style="display:none;">微信扫付</button>
<c:choose>
    <%--流水号有误--%>
    <c:when test="${empty cashAmount}">
        <div class="header">
            <a href="javascript:"><img src="${webRoot}/template/bdw/statics/images/logo_pay.png" /></a>
        </div>
        <div class="content">
            <div class="mail_box">
                <div class="mail_box_inner">
                    <div class="area">
                        <div class="qr_normal">
                            <div class="msg_default_box">
                                <i></i>
                                <p>
                                    您的流水号有误，请重新操作
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="pay_bill">
                        <div class="bill_hd">
                            <span><i></i></span>
                        </div>
                        <div class="bill_bd">
                            <h3><span>￥</span>${cashAmount}</h3>
                            <div class="pay_bill_unit">
                                <dl>
                                    <dt>${webName}</dt>
                                    <dd>${webName}</dd>
                                </dl>
                                <div class="pay_bill_info">
                                    <p><label>交易单号</label><span>${param.documentNum}</span></p>
                                    <p><label>创建时间</label><span>${documentCreateTime}</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <span class="left_icon"></span>
                <span class="right_icon"></span>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="header">
            <a href="javascript:"><img src="${webRoot}/template/bdw/statics/images/logo_pay.png" /></a>
        </div>
        <div class="content">
            <div class="mail_box">
                <div class="mail_box_inner">
                    <div class="area">
                        <div class="qr_normal">
                            <span>
                                <%--<img src="${webRoot}/template/bdw/statics/images/getpayqrcode.jpg" width="301" height="301" />--%>
                                <img src="${webRoot}/QRCodeServlet?qrcodelong=${qrcodelong1}" width="300" height="300"/>
                                <img class="guide" src="${webRoot}/template/bdw/statics/images/webpay_guide.png" width="282" height="408" style="margin-left: 134px; opacity: 1;" />
                            </span>
                            <div class="msg_default_box">
                                <i></i>
                                <p>
                                    请使用微信扫描<br>
                                    二维码以完成支付
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="pay_bill">
                        <div class="bill_hd">
                            <span><i></i></span>
                        </div>
                        <div class="bill_bd">
                            <h3><span>￥</span>${cashAmount}</h3>
                            <div class="pay_bill_unit">
                                <dl>
                                    <dt>${webName}</dt>
                                    <dd>${webName}</dd>
                                </dl>
                                <div class="pay_bill_info">
                                    <p><label>交易单号</label><span>${param.documentNum}</span></p>
                                    <p><label>创建时间</label><span>${documentCreateTime}</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <span class="left_icon"></span>
                <span class="right_icon"></span>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
