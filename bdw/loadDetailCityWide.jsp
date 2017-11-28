<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/14
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getAllProductProxyByMap(999, param.zoneId, param.lat, param.lng, '',param.productId)}" var="productProxyList"/>
<c:set var="total" value="${fn:length(productProxyList)}"/>
<div class="lt-th">
  共<span>&nbsp;${total}&nbsp;</span>家门店
</div>

<div class="lt-td">
  <c:forEach items="${productProxyList}" var="productProxy" varStatus="s">
    <div class="td-item">
      <a href="${webRoot}/citySend/storeDetail.ac?orgId=${productProxy.sysOrgId}" class="title">${productProxy.shopName}</a>
      <p>${productProxy.storeAddress}</p>
      <div class="num">
        <span>库存</span>
        <em>${productProxy.totalStockNum}</em>
        <span>配送费</span>
        <em>${productProxy.minFee}</em>
      </div>
      <div class="rank">${s.count}</div>
    </div>
  </c:forEach>
</div>