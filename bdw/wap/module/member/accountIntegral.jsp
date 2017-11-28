<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="6" var="pageSize"/><%--当前用户资料--%>
<c:set value="${sdk:getLastHalfYearIntegralTransactionLogs(pageSize)}" var="integralTransactionLogs"/><%--当前用户积分记录列表--%>
<html>
<head>
    <meta charset="utf-8">
    <title>账户积分</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/account-integral.css" media="screen" rel="stylesheet" />
    <script>
        var dataValue = {
            webPath: "${webRoot}",
            lastPageNumber: ${integralTransactionLogs.lastPageNumber}
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/myAccountIntegral.js"></script>

</head>
<%
    SysUser user = WebContextFactory.getWebContext().getFrontEndUser();
    if(user == null){
        response.sendRedirect("/wap/login.ac");
    }
%>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1);"></a>
    <span>账户积分</span>
</div>

<div class="account-integral-main" id="main">
   <div class="current-integral">当前积分<span><fmt:formatNumber value="${loginUser.integral}" pattern="0"/></span><a class="integral-exchange" href="${webRoot}/wap/integralList.ac">积分兑换商品</a></div>
    <div class="dt">积分记录</div>
    <c:if test="${fn:length(integralTransactionLogs.result) == 0}">
        <div class="row" >
            <div style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
        </div>
    </c:if>
    <div class="dd" id="intergal-list">
        <c:forEach items="${integralTransactionLogs.result}" var="transactionLog">
            <a href="${webRoot}/template/bdw/wap/module/member/integralTransactionDetails.jsp?logId=${transactionLog.accountTransactionLogId}">
                <div class="dd-item">
                    <div class="middle-box">
                        <p class="info">${transactionLog.reason}</p>
                    </div>
                    <p class="price price-add" <c:if test="${transactionLog.transactionAmount > 0}">style="color: red"</c:if>>
                        <fmt:formatNumber value="${transactionLog.transactionAmount}" pattern="0"/>
                    </p>
                    <span class="time">${transactionLog.transactionTime}</span>
                </div>
            </a>
        </c:forEach>
        <nav id="page-nav">
            <a href="${webRoot}/wap/module/member/loadMoreAccountIntegral.ac?page=2&pageSize=${pageSize}"></a>
        </nav>
        <a class="show-more" href="javascript:;">仅显示最近半年交易明细</a>
    </div>
</div>

</body>
</html>
