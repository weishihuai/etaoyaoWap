<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getAccountTransactionDetailById(param.logId)}" var="detail"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>账户余额-交易详情-退货充值</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/transaction-details.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1);"></a>
    <div class="toggle-box">交易详情</div>
</div>

<div class="transaction-details-main">
    <c:set value="${sdk:abs(detail.transactionAmount)}" var="transactionAmount"/>
    <div class="item income-price">收入金额<span><c:choose><c:when test="${detail.transactionAmount > 0}">+¥${transactionAmount}</c:when><c:otherwise>-¥${transactionAmount}</c:otherwise></c:choose></span></div>
    <div class="item">交易类型<span><c:choose><c:when test="${detail.transactionAmount > 0}">充值</c:when><c:otherwise>支出</c:otherwise></c:choose></span></div>
    <c:if test="${not empty detail.orderNum}">
        <div class="item">订单编号<span>${detail.orderNum}</span></div>
    </c:if>
    <div class="item">交易时间<span>${detail.transactionTimeString}</span></div>
    <div class="item">余额<span>¥<fmt:formatNumber value="${detail.transactionEndAmount}" pattern="0"/></span></div>
</div>

</body>
</html>
