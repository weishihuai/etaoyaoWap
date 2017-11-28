<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/4
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:findCitySendStoreProductPage(param.limit)}" var="productProxys"/>

<c:if test="${productProxys.totalCount != 0}">
    <ul class="search-list">
        <c:forEach items="${productProxys.result}" var="productProxy">
            <li class="media">
                <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">
                    <img src="${productProxy.defaultImage["110X110"]}" alt="">
                </a>
                <div class="media-body">
                    <span class="add-to-cart" onclick="addCart(${productProxy.productId});">加入购物车</span>
                    <a class="media-tit" href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">${productProxy.name}</a>
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
                    <p class="price"><small>¥</small>${intgerPrice}<small>.${decimalPrice}</small></p>
                </div>
            </li>
        </c:forEach>
    </ul>
</c:if>
