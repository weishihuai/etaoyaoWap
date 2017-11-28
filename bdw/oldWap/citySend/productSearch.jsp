<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/4
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="10" var="limit"/>
<c:set value="${bdw:findCitySendStoreProductPage(limit)}" var="productProxyPage"/>
<c:set value="store" var="carttype"/> <%--购物车类型--%>
<%
    // 清除购物卷，在取出购物车之前
    if (WebContextFactory.getWebContext().getFrontEndUser() != null) {
        String carttype = (String)pageContext.getAttribute("carttype");
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
        for (ShoppingCart shoppingCart : userCartList.getCarts()) {
            ResolverUtils.clearCoupon(shoppingCart);
            ResolverUtils.clacCartMisc(shoppingCart);
        }
        ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);
    }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>搜索-易淘药健康网</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" type="text/css"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css"/>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath={
            webRoot:"${webRoot}", //当前路径
            lastPageNumber: "${productProxyPage.lastPageNumber}",
            userId:"${loginUser.userId}",
            orgId: "${param.orgId}",
            keyword: "${param.keyword}",
            limit: "${limit}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/citySend/statics/js/productSearch.js" type="text/javascript"></script>

</head>

<body>
<div class="main m-search m-good-search">
    <div class="search-box">
        <form action="" method="get" id="searchForm">
            <a class="submit" href="javascript:" id="searchBtn">搜索</a>
            <div class="search search-light active">
                <input class="search-inp" type="text" placeholder="搜索店铺商品" id="searchTxt" name="keyword" value="${param.keyword}" style="padding-right: 1.8rem;">
                <input type="hidden" name="orgId" value="${param.orgId}"/>
                <input type="hidden" name="limit" value="${limit}"/>
                <a class="search-action" href="javascript:"><i class="icon-search"></i>搜索店铺商品</a>
            </div>
        </form>
    </div>

    <div id="mainList">
        <c:if test="${productProxyPage.totalCount != 0}">
            <ul class="good-list">
                <c:forEach items="${productProxyPage.result}" var="prdProxy">
                    <li class="media">
                        <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${prdProxy.productId}">
                            <img src="${prdProxy.defaultImage["110X110"]}" alt="">
                        </a>
                        <div class="media-body">
                            <span class="add-to-cart" onclick="addCart(${prdProxy.productId});">加入购物车</span>
                            <a class="media-tit" style="font-size: 1.1rem;" href="${webRoot}/wap/citySend/product.ac?productId=${prdProxy.productId}">${prdProxy.name}</a>
                            <p class="media-desc">
                                <span>已售&nbsp;${prdProxy.salesVolume}</span>
                                <span>评论&nbsp;${prdProxy.commentQuantity}</span>
                            </p>
                            <c:set value="${prdProxy.price.unitPrice}" var="unitPrice"/>
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
    </div>
</div>

<!-- 搜索-无 -->
<div class="search-null" style="${not empty param.keyword && productProxyPage.totalCount == 0 ? 'display:block;' : 'display: none;'}">
    <img src="${webRoot}/template/bdw/wap/citySend/statics/images/search-null.png" alt="">
    <p>查询不到相关数据</p>
</div>

<!-- 加入购物车 -->
<div class="modal modal-add-cart" style="display: none;" id="ajaxCartSeletor">

</div>

<!-- 查看购物车 -->
<div class="modal modal-view-cart" style="display: none;" id="ajaxLoadShoppingCart">

</div>

<c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(param.orgId)}"/>
<c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />

<!-- 底部结算 -->
<div class="bottom-bar" id="cart" style="z-index:105;">
    <c:choose>
        <c:when test="${storeCartProxy.selectedCartItemNum>0}">
            <%--<a href="${webRoot}/wap/citySend/cityCheckout.ac?orgId=${param.orgId}" onclick="goToAddOrder(this)" class="settlement" orgid="${param.orgId}" carttype="${carttype}">去结算</a>--%>
            <a  id="goToAddOrder" href="javascript:void(0);" class="settlement" orgid="${shopInf.sysOrgId}"   style="z-index: 105;"  carttype="${carttype}" onclick="goToAddOrder(this);">去结算</a>

        </c:when>
        <c:otherwise>
            <a href="javascript:" class="settlement" style="background-color: #ccc;" aria-disabled="true">去结算</a>
        </c:otherwise>
    </c:choose>
    <a class="cart-toggle" id="storeCartLayer" orgid="${param.orgId}" href="javascript:">
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
        <span><small>&yen;&nbsp;</small>${storeCartProxy.realProductTotalAmount}</span>
    </div>
</div>

<nav id="page-nav">
    <a href="${webRoot}/wap/citySend/loadProductSearch.ac?orgId=${param.orgId}&keyword=${param.keyword}&page=2&limit=${limit}"></a>
</nav>
<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>

</body>
</html>
