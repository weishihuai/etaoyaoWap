<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="8" var="limit"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${sdk:getMarketingActivityById(param.activityId)}" var="marketActivity"/>
<c:set value="${sdk:getMarketingActivitySignUpProxyList(_page,8,param.activityId)}" var="marketActivityProduct"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>秒优惠详情-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/activityIndex.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}",
            lastPageNumber: "${marketActivityProduct.lastPageNumber}"};
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/activityList.js" type="text/javascript"></script>
</head>
<body>
<c:if test="${isWeixin ne 'Y'}">
    <div class="m-top">
        <a class="back" href="javascript:;" onclick="history.go(-1);"></a>
        <span>秒优惠详情</span>
    </div>
</c:if>

<div class="m-preferential-main" <c:if test="${isWeixin eq 'Y'}">style='padding-top: 0rem;'</c:if>>
    <a class="pic" href="javascript:;"><img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(marketActivity.marketingActivityId,'580X216')}" alt=""></a>
    <p id="countDown" class="time" listPageTime="${marketActivity.activityEndTimeStr}"></p>
    <div class="dd clearfix" id="activity-panel">
        <c:forEach items="${marketActivityProduct.result}" var="activity">
            <c:set var="productProxy" value="${sdk:getProductById(activity.productId)}"/>
            <div class="dd-item activity-list">
                <a class="dd-pic" href="${webRoot}/wap/product.ac?id=${productProxy.productId}">
                    <img src="${productProxy.defaultImage["320X320"]}" alt="">
                </a>
                <p class="price-box">
                    <span class="price">￥<fmt:formatNumber value="${activity.price}" type="number" pattern="#0.00#"/></span>
                    <a class="zhekou" href="javascript:;">${activity.discount}折</a>
                </p>
                <p class="name elli" onclick="window.location.href='${webRoot}/wap/product.ac?id=${productProxy.productId}'">${productProxy.name}</p>
            </div>
        </c:forEach>
    </div>
    <nav id="page-nav">
        <a href="${webRoot}/wap/loadActivityList.ac?activityId=${param.activityId}&page=2&limit=${limit}"></a>
    </nav>
</div>
</body>
</html>

