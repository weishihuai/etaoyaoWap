<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%-- 如果是在线支付的订单，这个页面是从returnPay.ac跳过来的，会带过来参数isCod="N" --%>
<%-- 如果是货到付款的订单，这个页面是从ShoppingflowController跳过来的，会带过来orderIds参数，不过这个页面没有用这个参数 --%>
<c:set var="isCod" value="${empty param.isCod ? 'Y' : 'N'}"/>
<c:set value="${isCod == 'Y'?'提交':'支付'}" var="payWay"/>
<c:set var="carttype" value="${param.carttype}"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订单提交成功</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/paySuccess.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">var webPath = {webRoot:"${webRoot}"};</script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
</head>

<body>


    <div class="main">
        <h5>订单${payWay}成功</h5>
        <p>您的订单已${payWay}成功，我们会为你尽快处理。</p>
        <c:choose>
            <c:when test="${not empty loginUser.bytUserId}">
                <a href="javascript:void(0);" class="back-index" onclick="window.location.href='${webRoot}/wap/module/byt/topicPage.ac?'+ new Date().getTime()">返回首页</a>
                <a href="javascript:void(0);" class="back-index" onclick="window.location.href='http://app.xiaoyangbao.net/zbtong/#/shopping/home'">返回怡保通</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0);" class="back-index" onclick="window.location.href='${webRoot}/wap/index.ac?'+ new Date().getTime()">返回首页</a>
            </c:otherwise>
        </c:choose>
        <%--<a href="javascript:void(0);" class="order-center" onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?'+ new Date().getTime()">查看订单</a>--%>
        <c:choose>
            <c:when test="${'groupBuy'==carttype}">
                <a href="javascript:void(0);" class="order-center" onclick="window.location.href='${webRoot}/wap/module/member/groupBuyOrders.ac?'+ new Date().getTime()">查看订单</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0);" class="order-center" onclick="window.location.href='${webRoot}/wap/module/member/myOrders.ac?'+ new Date().getTime()">查看订单</a>
            </c:otherwise>
        </c:choose>
    </div>
</body>

</html>




