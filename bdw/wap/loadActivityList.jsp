<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>  <%--获取页码--%>
<c:set value="${sdk:getMarketingActivitySignUpProxyList(_page,8,param.activityId)}" var="marketActivityProduct"/>

<c:forEach items="${marketActivityProduct.result}" var="activity">
    <c:set var="productProxy" value="${sdk:getProductById(activity.productId)}"/>
    <div class="dd-item activity-list">
        <a class="dd-pic" href="${webRoot}/wap/product.ac?id=${productProxy.productId}">
            <img src="${productProxy.defaultImage["320X320"]}" alt="">
        </a>
        <p class="price-box">
            <span class="price">￥<fmt:formatNumber value="${activity.price}" type="number" pattern="#0.00#"/></span>
            <a class="zhekou" href="javascript:;">${activity.discount}折</a>
        </p>
        <p class="name elli" onclick="window.location.href='${webRoot}/wap/product.ac?id=${productProxy.productId}'">${productProxy.name}</p>
    </div>
</c:forEach>