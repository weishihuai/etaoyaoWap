<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/29
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="orgId" value="${param.orgId}"/>
<c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="store" var="carttype"/> <%--购物车类型--%>
<c:choose>
    <c:when test="${storeCartProxy.selectedCartItemNum>0}">
        <a href="javascript:void(0)" id="goToAddOrder" class="settlement" style="z-index: 105;" orgid="${orgId}" carttype="${carttype}" onclick="goToAddOrder(this);">去结算</a>
    </c:when>
    <c:otherwise>
        <a href="javascript:" class="settlement" style="background-color: #ccc;z-index: 105;" aria-disabled="true">去结算</a>
    </c:otherwise>
</c:choose>
<a class="cart-toggle" id="storeCartLayer" orgid="${orgId}" href="javascript:">
    <c:choose>
        <c:when test="${empty loginUser}">
            <span>0</span>
        </c:when>
        <c:otherwise>
            <span>${storeCartNum}</span>
        </c:otherwise>
    </c:choose>
</a>
<div class="total">
    <span style="position: relative;top: -1px;"><small>&yen;&nbsp;</small>${storeCartProxy.realProductTotalAmount}</span>
    <p class="price"><small>优惠：&yen;${storeCartProxy.discountAmount}</small></p>
</div>