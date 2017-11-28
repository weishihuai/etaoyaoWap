<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set value="${empty param.page?1:param.page}" var="pageNum"/> <%--订单翻页数，默认为第一页--%>
<c:set value="${param.orderId}" var="orderId"/>
<c:set value="${bdw:findReturnOrderPageByOrderId(orderId,loginUser.userId,pageNum,8,false)}" var="orderProxyPage"/> <%--获取当前用户普通订单--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>换货商品-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/return.css" type="text/css" rel="stylesheet">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/exchangeOrder.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {webRoot:'${webRoot}'};
    </script>
</head>
<body>
<%--<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=会员中心"/>--%>
<div class="main m-choose">

        <c:forEach items="${orderProxyPage.result}" var="orderProxy" varStatus="status">
            <ul class="good-list">
                <c:forEach items="${orderProxy.orderItemProxyList}" var="orderItemProxy">
                    <c:choose>
                    <c:when test="${orderItemProxy.isCanExchange == true}">
                    <c:if test="${orderItemProxy.promotionType != '赠品商品'}">
                        <li class="good checked">
                        <span class="chk cp" orderItemId="${orderItemProxy.orderItemId}">  </span>
                            <div class="good-img">
                               <c:choose>
                                   <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                       <a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productProxy.productId}"><img src="${orderItemProxy.productProxy.defaultImage["100X100"]}" alt=""></a>
                                   </c:when>
                                   <c:otherwise>
                                       <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html"><img src="${orderItemProxy.productProxy.defaultImage["100X100"]}" alt=""></a>
                                   </c:otherwise>
                               </c:choose>
                            </div>
                            <div class="good-body">
                                <p class="good-name">${fn:substring(orderItemProxy.productProxy.name,0,50)}</p>
                                <div class="good-price">
                                    <span class="fl">&yen;${orderItemProxy.productUnitPrice}</span>
                                    <div class="choose-quantity fr">
                                        <span class="op op-dec" >-</span>
                                        <input class="inp" type="text"  maxlength="4" value="${orderItemProxy.num != null ? orderItemProxy.num : 0}" orderItemId="${orderItemProxy.orderItemId}"  num="${orderItemProxy.num != null ? orderItemProxy.num : 0}"/>
                                        <span class="op op-add">+</span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:if>
                    </c:when>
                    <c:otherwise>
                        <li class="good checked">
                            <%--<span class="chk cp" orderItemId="${orderItemProxy.orderItemId}">  </span>--%>
                            <div class="good-img">
                                <c:choose>
                                    <c:when test="${not empty orderProxy.sysShopInf.shopType && orderProxy.sysShopInf.shopType == '2'}">
                                        <a href="${webRoot}/wap/citySend/product.ac?productId=${orderItemProxy.productProxy.productId}"><img src="${orderItemProxy.productProxy.defaultImage["100X100"]}" alt=""></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${webRoot}/product-${orderItemProxy.productProxy.productId}.html"><img src="${orderItemProxy.productProxy.defaultImage["100X100"]}" alt=""></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="good-body">
                                <p class="good-name">${fn:substring(orderItemProxy.productProxy.name,0,50)}</p>
                                <div class="good-price">
                                    <span class="fl">&yen;${orderItemProxy.productUnitPrice}</span>
                                    <span style="color: rgb(226, 85, 15);  margin-left:1.5rem;">(已申请退换货)</span>
                                </div>
                            </div>
                        </li>
                    </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
            <div class="checkout-bar">
                <span class="chk chk-label fl">全选</span>
                <a class="goto fr" href="javascript:;" onclick="selectPurchase(${orderId})">填写换货单</a>
                <span class=" fr">已选<b>0</b>件商品</span>
            </div>
        </c:forEach>
</div>
<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js" type="text/javascript"></script>
</body>

</html>
