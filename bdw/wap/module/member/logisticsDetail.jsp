<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk" %>
<c:choose>
    <c:when test="${not empty param.id}">
        <c:set value="${sdk:findOrderLogisticsDetail(param.id)}" var="logisticsDetail"/><%--查询订单详细--%>
    </c:when>
    <c:when test="${not empty param.integralOrderId}">
        <c:set value="${sdk:findIntegralOrderLogisticsDetail(param.integralOrderId)}" var="logisticsDetail"/><%--查询积分订单详细--%>
    </c:when>
    <c:when test="${not empty param.logisticsOrderCode}">
        <c:set value="${sdk:findExchangeOrderLogisticsDetail(param.logisticsOrderCode,param.logisticsCompany)}" var="logisticsDetail"/><%--查询换货订单详细--%>
    </c:when>
</c:choose>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>物流详情</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/logistics-detail.css" media="screen" rel="stylesheet"/>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1)"></a>
    <span>物流详情</span>
</div>
<div class="logistics-d-main">
    <div class="top-info">
        <p>物流公司<span>${logisticsDetail.companyNm}</span></p>
        <p>运单编号<span>${logisticsDetail.orderNum}</span></p>
    </div>
    <c:choose>
        <c:when test="${empty logisticsDetail.logisticsItemProxies}">
        </c:when>
        <c:otherwise>
            <c:forEach items="${logisticsDetail.logisticsItemProxies}" var="item" varStatus="status">
                <div class="item">
                        <div class="date"><span>${item.ymdString}</span><span>${item.hmsString}</span></div>
                    <div class="txt">${item.content}</div>
                    <c:choose>
                        <c:when test="${status.first}">
                            <em class="dot dot-c"></em>
                        </c:when>
                        <c:otherwise>
                            <em class="dot"></em>
                        </c:otherwise>
                    </c:choose>
                    <em class="wire"></em>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
