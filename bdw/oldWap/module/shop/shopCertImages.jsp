<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>

<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>


<c:if test="${!empty shop.certifiedImages}">
    <c:forEach items="${shop.certifiedImages}" var="certImages" varStatus="status">
        <img src="${certImages[""]}" style="height: 100%;width: 100%">
    </c:forEach>
</c:if>





