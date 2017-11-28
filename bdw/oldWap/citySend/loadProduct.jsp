<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: zxh
  Date: 2016/12/30
  Time: 9:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchProductInCitySend(param.limit)}" var="productProxys"/>
<%--默认商品图片--%>
<c:set var="noProductPic" value="${webRoot}/template/bdw/statics/images/noPic_120X120.jpg"/>

<c:if test="${productProxys.totalCount !=0}">
    <dl class="search-list">
            <%--  <dt>年底特惠专区</dt>--%>
        <c:forEach items="${productProxys.result}" var="productProxy">
            <dd class="media">
                <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">
                    <c:choose>
                        <c:when test="${not empty productProxy.defaultImage['120X120']}">
                            <img src="${productProxy.defaultImage['120X120']}" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                        </c:when>
                        <c:otherwise>
                            <img src="${noProductPic}" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                        </c:otherwise>
                    </c:choose>
                </a>
                <div class="media-body">
                    <span class="add-to-cart" onclick="addCart(${productProxy.productId});">加入购物车</span>
                    <input type="hidden" class="addCartSelector" value="${productProxy.productId}"/>
                    <a class="media-tit" style="max-height: 2.3em;" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">${productProxy.name}</a>
                    <p class="media-desc">
                        <span>已售&nbsp;${productProxy.salesVolume}</span>
                        <span>评论&nbsp;${productProxy.commentQuantity}</span>
                    </p>
                    <c:set value="${productProxy.price.unitPrice}" var="unitPrice"/>
                    <%
                        Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                        String priceStr = String.valueOf(unitPrice);
                        String[] price = priceStr.split("[.]");
                        String intgerPrice = price[0];
                        String decimalPrice = price[1];
                        if (StringUtils.isBlank(decimalPrice)) {
                            decimalPrice = "00";
                        } else if (decimalPrice.length() < 2) {
                            decimalPrice += "0";
                        }
                        pageContext.setAttribute("intgerPrice", intgerPrice);
                        pageContext.setAttribute("decimalPrice", decimalPrice);
                    %>
                    <p class="price"><small>&yen;</small>${intgerPrice}<small>.${decimalPrice}</small></p>
                </div>
            </dd>
        </c:forEach>
    </dl>
</c:if>