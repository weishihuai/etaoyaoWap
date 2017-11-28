<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getAccountTransactionDetailById(param.logId)}" var="detail"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>账户积分-交易详情-兑换</title>
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
    <div class="item spending-price">交易积分<span><fmt:formatNumber value="${detail.transactionAmount}" pattern="0"/></span></div>
    <div class="item">交易类型<span><c:choose><c:when test="${detail.transactionAmount > 0}">收入</c:when><c:otherwise>支出</c:otherwise></c:choose></span></div>
    <div class="item">交易时间<span>${detail.transactionTimeString}</span></div>
    <div class="item">剩余积分<span><fmt:formatNumber value="${detail.transactionEndAmount}" pattern="0"/></span></div>
</div>

</body>
</html>
