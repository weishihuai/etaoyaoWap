<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.SysUser" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/><%--当前用户资料--%>
<c:set value="6" var="pageSize"/><%--当前用户资料--%>
<c:set value="${sdk:getLastHalfYeayPrestoreTransactionLogs(pageSize)}" var="prestoreTransactionLogs"/>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>账户余额</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" media="screen" rel="stylesheet"  />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" media="screen" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/module/member/statics/css/account-balance.css" media="screen" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/module/member/statics/js/accountBalance.js"></script>
    <script>
        var webParams = {
            webPath: "${webRoot}",
            lastPageNumber: ${prestoreTransactionLogs.lastPageNumber}
        };
    </script>
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
    <span>账户余额</span>
</div>

<div class="account-balance-main" id="main">
    <div class="current-balance">当前余额(元)<span><fmt:formatNumber value="${loginUser.prestore}" type="number" pattern="#,#00.00#"/></span></div>
    <div class="dt">交易明细</div>
    <c:if test="${fn:length(prestoreTransactionLogs.result) == 0}">
        <div class="row" >
            <div style="height:50px; color:#fff; line-height:50px; font-size:16px; font-family:'微软雅黑';text-align:center;margin:10px;border-radius:5px;color:#999;">暂无记录</div>
        </div>
    </c:if>
    <div class="dd" id="account-list">
        <c:forEach items="${prestoreTransactionLogs.result}" var="logs">
            <c:set value="${sdk:abs(logs.transactionAmount)}" var="transactionAmount"/>
            <a href="${webRoot}/template/bdw/wap/module/member/accountTransactionDetails.jsp?logId=${logs.accountTransactionLogId}"><div class="dd-item"><div class="middle-box"><p class="info">${logs.reason}</p></div>
                <p class="price price-add" <c:if test="${logs.transactionAmount > 0}">style="color: red"</c:if>>
                    <c:choose>
                        <c:when test="${logs.transactionAmount > 0}">
                            +¥<fmt:formatNumber value="${logs.transactionAmount}" type="number" pattern="#,#00.00#"/>
                        </c:when>
                        <c:otherwise>
                            -¥<fmt:formatNumber value="${transactionAmount}" type="number" pattern="#,#00.00#"/>
                        </c:otherwise>
                    </c:choose>
                </p>
                <span class="time">${logs.transactionTime}</span></div></a>
        </c:forEach>
        <nav id="page-nav">
            <a href="${webRoot}/wap/module/member/loadMoreAccountBalance.ac?page=2&pageSize=${pageSize}"></a>
        </nav>
        <a class="show-more" href="javascript:;">仅显示最近半年交易明细</a>

    </div>
</div>

</body>
</html>
