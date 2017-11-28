<%--
  Created by IntelliJ IDEA.
  User: xws
  Date: 12-7-12
  Time: 下午2:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getUserCartListProxy('normal')}" var="cart"/>
<c:choose>
    <c:when test="${cart.allCartNum==0}">
        <div class="item" align="center">
            您的购物车内没有商品，快去选购吧!
        </div>
    </c:when>
    <c:otherwise>
        <h2>最新加入的商品</h2>
        <c:forEach items="${cart.shoppingCartProxyList}" var="cartProxy">
            <c:forEach items="${cartProxy.cartItemProxyList}" var="p">
                <div class="item">

                    <div class="pic"><a href="${webRoot}/product-${p.productId}.html"><img src="${p.productProxy.defaultImage["50X50"]}" /></a></div>
                    <div class="title"><a href="${webRoot}/product-${p.productId}.html">${p.name}</a></div>
                    <div class="mub">
                        <p><span>${p.productUnitPrice}</span>×${p.quantity}</p>
                        <%--<p><a href="${webRoot}/shoppingcart/cart.ac">删除</a></p>--%>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </c:forEach>
        <div class="sub">
            <p>共 <span>${cart.allCartNum}</span> 件商品 共计 <b>${cart.allProductTotalAmount}</b></p>
            <p><a href="${webRoot}/shoppingcart/cart.ac">去购物车${cart.allProductTotalAmount}结算</a></p>
        </div>
    </c:otherwise>
</c:choose>
