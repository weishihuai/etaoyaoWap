<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/14
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchStore(999, param.zoneId, param.lat, param.lng, '')}" var="citywides"/>
<c:set var="total" value="0"/>
<c:forEach items="${citywides}" var="cw">
  <c:set var="total" value="${total + cw.productTotalCount}"/>
</c:forEach>
<div class="pr-th">
  <span addr="${param.keyword}" lng="${param.lng}" lat="${param.lat}">共找到 <em id="total">${fn:length(citywides)}</em> 家门店,经营 <em>${total}</em> 种商品</span>
  <c:if test="${fn:length(citywides) gt 0}"> <a target="_blank" href="${webRoot}/citySend/storeList.ac?lat=${param.lat}&lng=${param.lng}" title="查看全部">查看全部</a></c:if>
</div>

<div class="pr-td">
  <ul>
    <c:forEach items="${citywides}" var="citywide" varStatus="s">
      <li class="item shops-w" lat="${citywide.outletLat}" lng="${citywide.outletLng}" orgId="${citywide.sysOrgId}" isSupport="${citywide.isSupportBuy}">
        <a href="javascript:void(0);" class="title" isSupport="${citywide.isSupportBuy}">${citywide.shopNm}</a>
        <p>${citywide.outStoreAddress}</p>
        <div class="num">商品数量<span>${citywide.productTotalCount}</span></div>
        <div class="rank">${s.count}</div>
      </li>
    </c:forEach>
  </ul>
</div>
