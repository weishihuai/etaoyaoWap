<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--如果用户未登录重定向到登录页面--%>
<c:if test="${empty loginUser}">
    <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--获取订单项信息--%>
<c:set var="orderItemProxy" value="${sdk:getOrderItemProxyById(param.id)}"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>选择售后类型-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/after-sale.css" type="text/css" rel="stylesheet"/>

    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:window.history.back(-1);"></a>
    <div class="toggle-box">选择售后类型</div>
</div>

<div class="af-main">
    <div class="mt">
        <div class="pic"><a href="javascript:;"><img src="${orderItemProxy.productProxy.defaultImage['200X200']}" alt=""></a></div>
        <a href="javascript:;" class="title">${orderItemProxy.productProxy.name}</a>
    </div>
    <div class="mc">
        <c:if test="${orderItemProxy.isCanExchange}">
            <div class="item exchange"><a href="${webRoot}/wap/module/member/applyExchange.ac?id=${orderItemProxy.orderItemId}">仅换货</a></div>
        </c:if>
        <c:if test="${orderItemProxy.isCanReturn}">
            <div class="item return"><a href="${webRoot}/wap/module/member/applyReturn.ac?id=${orderItemProxy.orderItemId}">退货退款</a></div>
        </c:if>
    </div>
</div>

</body>
</html>
