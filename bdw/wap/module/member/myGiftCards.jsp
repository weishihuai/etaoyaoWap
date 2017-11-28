<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>
<c:set value="${empty param.page ? 1 : param.page}" var="page"/>
<c:set value="${pageContext.request.contextPath}" var="webRoot" />
<c:set value="${sdk:getEffectiveCouponPage(5)}" var="unusedCoupon"/>  <%--未使用的--%>
<c:set var="limit" value="5"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>礼品卡</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/coupons.css" media="screen" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>


    <script>

    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1)"></a>
    <span>礼品卡</span>
</div>
<div class="coupons-main">
    <div id="myCouponList" style="padding-bottom: 0;">
        <div class="none-box">
            <img class="none-icon" src="${webRoot}/template/bdw/wap/module/member/statics/images/kongyouhuiquan.png"
                 alt="">
            <p>暂无礼品卡</p>
        </div>
    </div>
</div>


</body>
</html>
