<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

<%--因为nginx代理问题,所以这里如果不加个时间戳会出现会显示其他用户的登录名,所以这里独立抽离出来--%>

<div class="welcome">
    <c:choose>
        <c:when test="${not empty userProxy}">
            <%--您好，<a href="${webRoot}/module/member/index.ac">${fn:substring(userProxy.loginId,0,15)}</a>，欢迎来到${webName}[<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]--%>
            您好，<a href="${webRoot}/module/member/index.ac">${userProxy.mobile}</a>，欢迎来到${webName}[<a  href="<c:url value='/member/exit.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]
        </c:when>
        <c:otherwise>
            您好，欢迎来到${webName}！[<a class="cur" href="${webRoot}/login.ac" title="登录">登录</a>] [<a class="color" href="${webRoot}/register.ac" title="免费注册">免费注册</a>]
        </c:otherwise>
    </c:choose>
</div>
