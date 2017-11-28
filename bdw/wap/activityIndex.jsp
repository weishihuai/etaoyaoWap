<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${sdk:getMarketingActivityProxyList(page,16,'Y','N','N')}" var="processMarketActivity"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>秒优惠-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">

    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/activityIndex.css" rel="stylesheet" media="screen">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/activityIndex.js" type="text/javascript"></script>

</head>
<body>
<c:if test="${isWeixin ne 'Y'}">
    <div class="m-top">
        <a class="back" href="javascript:;" onclick="history.go(-1);"></a>
        <span>秒优惠</span>
    </div>
</c:if>

<div class="m-preferential-main" <c:if test="${isWeixin eq 'Y'}">style='padding-top: 0rem;'</c:if>>
    <c:forEach items="${processMarketActivity.result}" var="activity" varStatus="num">
        <div class="item" onclick="window.location.href='${webRoot}/wap/activityList.ac?activityId=${activity.marketingActivityId}'">
            <a class="pic" href="javascript:;"><img src="${sdk:getAdvtUrlByMarketingActivityIdSpec(activity.marketingActivityId,'580X216')}" alt=""></a>
            <p class="zhekou">${activity.discountRequirement}<span>折起</span></p>
            <p class="name">${activity.activityNm}</p>
            <p class="time" listPageTime="${activity.activityEndTimeStr}" id="marketingActivityId${activity.marketingActivityId}" marketingActivityId="${activity.marketingActivityId}"></p>
        </div>
    </c:forEach>
</div>
</body>
</html>
