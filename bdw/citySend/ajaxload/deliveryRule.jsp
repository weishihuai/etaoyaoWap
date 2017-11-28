<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/25
  Time: 12:24
  To change this template use File | Settings | File Templates.
  暂时无用到
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${param.orgId}" var="orgId"/>
<c:set var="carttype" value="store"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<c:set var="mdCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<c:set value="${sdk:getDeliveryRuleList(carttype,orgId ,isCod)}" var="deliveryRuleList"/>
<select class="saveDelivery"  carttype="${carttype}" orgid="${orgId}" class="delivery">
  <option value="0">请选择配送方式</option>
  <c:forEach items="${deliveryRuleList}" var="rule">
    <option value="${rule.deliveryRule.deliveryRuleId}" data-company-id="${rule.deliveryLogisticsCompanyId}"
       <c:if test="${mdCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}</option>
  </c:forEach>
</select>