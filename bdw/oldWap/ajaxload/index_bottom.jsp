<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

<c:choose>
    <c:when test="${not empty userProxy}">
        您好，<a href="${webRoot}/wap/module/member/index.ac" style="color: #fff;">${userProxy.bindLoginId}</a><c:if test="${isWeixin!='Y'}">，[<a style="color: #fff;" href="<c:url value='/member/exitMoble.ac?sysUserId=${userProxy.userId}'/>" title="退出">退出</a>]</c:if>
    </c:when>
    <c:otherwise>
        <a href="${webRoot}/wap/login.ac" class="login" id="bottemlogo">登录</a>
        <span class="su">|</span>
        <a href="${webRoot}/wap/regist.ac" class="login">新用户注册</a>
    </c:otherwise>
</c:choose>


