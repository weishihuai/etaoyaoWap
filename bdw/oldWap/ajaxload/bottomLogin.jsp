
<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-25
  Time: 下午5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

<%-- 底部登录显示的红条 --%>
<c:if test="${isWeixin!='Y'}">
<div class="col-xs-9" style="text-align:left;" id="login_entry">
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
</div>
<div class="col-xs-3" style="text-align:right;">
    <a href="#" id="toTop" class="login">返回顶部</a>
</div>
</c:if>

<script src="${webRoot}/template/bdw/wap/statics/js/common.js"></script>
