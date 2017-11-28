<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<%-- 右上角的消息记录页面 --%>
<c:choose>
    <c:when test="${loginUser == null}">
        <div class="yz-search-login">
            <a href="${webRoot}/wap/login.ac" class="login" ></a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="yz-search-login">
            <a href="${webRoot}/wap/mySystemMsg.ac" class="login" >
                <span class="yz-msg">${fn:length(loginUser.userMsgListBySystem)}</span>
            </a>
        </div>
    </c:otherwise>
</c:choose>



