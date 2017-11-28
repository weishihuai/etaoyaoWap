<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/29
  Time: 13:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--查找出所有商品--%>
<c:set value="${bdw:searchProductByOrgId(2)}" var="productProxyPage"/>

<div class="dt">
  <span>选择已有商品</span>
  <em>选择已在易淘药平台上架或下架的商品进行竞标</em>
  <a href="javascript:void(0);" class="btn" id="searchProductBtn">搜索</a>
  <input type="text" id="searchTxt" placeholder="请输入商品名称或编码">
</div>
<div class="dd">
  <div class="dd-th">
    <a href="javascript:void(0);" class="sel-btn" aria-disabled="true"></a>
    <span style="float: left; margin-left: 18px; ">商品信息</span>
    <span style="margin-right:20px;">实际库存</span>
    <span style="margin-right: 130px;">商品价格</span>
  </div>
  <div class="dd-td">
    <c:forEach items="${productProxyPage.result}" var="productProxy">
      <div class="item">
        <a href="javascript:void(0)" class="sel-btn box${productProxy.productId}" productId="${productProxy.productId}" onclick="toggleCheckBox(${productProxy.productId})"></a>
        <div class="pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["50X50"]}" alt="" width="50px" height="50px;"></a></div>
        <a href="${webRoot}/product-${productProxy.productId}.html" class="title">${productProxy.name}</a>
        <div class="num">${productProxy.stockRange}</div>
        <div class="price">${productProxy.priceRange}</div>
      </div>
    </c:forEach>
  </div>
</div>
<c:if test="${productProxyPage.lastPageNumber>1}">
  <div class="control">
    <c:if test='${!productProxyPage.firstPage}'>
      <a title="<c:choose><c:when test='${commentProxyResult.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!productProxyPage.firstPage}'> class="control-prev" onclick="syncProductPage(${productProxyPage.thisPageNumber-1})" </c:if> ></a>
    </c:if>
    <c:forEach var="i" begin="1" end="${productProxyPage.lastPageNumber}" step="1">
      <c:set var="displayNumber" value="6"/>
      <c:set var="startNumber" value="${(productProxyPage.thisPageNumber -(productProxyPage.thisPageNumber mod displayNumber))}"/>
      <c:set var="endNumber" value="${startNumber+displayNumber}"/>
      <c:if test="${(i>=startNumber) && (i<endNumber) }">
        <c:choose>
          <c:when test="${i==productProxyPage.thisPageNumber}">
            <a class="cur">${i}</a>
          </c:when>
          <c:otherwise>
            <a onclick="syncProductPage(${i})">${i}</a>
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:forEach>
    <c:if test='${!productProxyPage.lastPage}'>
      <a title="<c:choose> <c:when test='${commentProxyResult.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " <c:if test='${!productProxyPage.lastPage}'> class="control-next" onclick="syncProductPage(${productProxyPage.thisPageNumber+1})" </c:if> ></a>
    </c:if>
  </div>
</c:if>