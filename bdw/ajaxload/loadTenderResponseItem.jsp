<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/29
  Time: 13:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${param.tnd}" var="tnd"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set var="invitationForBidProxyDetail" value="${bdw:getSyInvitationForBidProxyById(param.tnd)}"/>
<%--获取所有的投标记录--%>
<c:set var="allResponseItemPage" value="${bdw:findResponseItemListByForBidId(param.tnd, _page,5)}"/>
<h5>当前竞标信息<span><em>${invitationForBidProxyDetail.shopCount}</em> 位商家正在竞标</span></h5>
<div class="current">
  <c:if test="${allResponseItemPage.totalCount>0}">
    <ul>
      <c:forEach items="${allResponseItemPage.result}" var="responseItem">
        <li>
          <div class="ct-mt">
            <div class="pic"><img src="${responseItem.shopLogo["100X100"]}" alt="" width="30px" height="30px"></div>
            <span class="name elli">${responseItem.shopName}</span>
            <em><fmt:formatDate value="${responseItem.createTime}" pattern="yyyy-MM-dd"/></em>
          </div>
          <div class="ct-mc">
            <div class="pic"><a href="${webRoot}/product-${responseItem.productId}.html"><img src="${responseItem.productImage["60X60"]}" height="60px" width="60px" alt=""></a></div>
            <a href="${webRoot}/product-${responseItem.productId}.html" class="title">${responseItem.productName}</a>
            <div class="repertory">库存：${responseItem.stockNumRange}件</div>
            <div class="price">￥${responseItem.priceRange}</div>
          </div>
        </li>
      </c:forEach>
    </ul>
    <c:if test="${allResponseItemPage.lastPageNumber>1}">
      <div class="control">
        <c:if test='${!allResponseItemPage.firstPage}'>
          <a title="<c:choose><c:when test='${allResponseItemPage.firstPage}'>目前已是第一页</c:when><c:otherwise>上一页</c:otherwise> </c:choose> " <c:if test='${!allResponseItemPage.firstPage}'> class="control-prev" onclick="syncResponseItemPage(${allResponseItemPage.thisPageNumber-1},${tnd})" </c:if> ></a>
        </c:if>
        <c:forEach var="i" begin="1" end="${allResponseItemPage.lastPageNumber}" step="1">
          <c:set var="displayNumber" value="6"/>
          <c:set var="startNumber" value="${(allResponseItemPage.thisPageNumber -(allResponseItemPage.thisPageNumber mod displayNumber))}"/>
          <c:set var="endNumber" value="${startNumber+displayNumber}"/>
          <c:if test="${(i>=startNumber) && (i<endNumber) }">
            <c:choose>
              <c:when test="${i==allResponseItemPage.thisPageNumber}">
                <a class="cur">${i}</a>
              </c:when>
              <c:otherwise>
                <a onclick="syncResponseItemPage(${i},${tnd})">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:if>
        </c:forEach>
        <c:if test='${!allResponseItemPage.lastPage}'>
          <a title="<c:choose> <c:when test='${allResponseItemPage.lastPage}'>目前已是最后一页</c:when> <c:otherwise>下一页</c:otherwise> </c:choose> " <c:if test='${!allResponseItemPage.lastPage}'> class="control-next" onclick="syncResponseItemPage(${allResponseItemPage.thisPageNumber+1},${tnd})" </c:if> ></a>
        </c:if>
      </div>
    </c:if>
  </c:if>
</div>