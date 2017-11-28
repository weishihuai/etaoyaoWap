<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="defaultProductProxy" value="${bdw:getFirstPromotionProductProxy()}"/>
<c:set var="promotionProductProxies" value="${sdk:findPageModuleProxy('sy_panic_buy').recommendPromotionProducts}"/>

<%--
    限时抢购显示策略：1.商城里没有任何促销商品时不显示
                    2.有促销商品，但是还没装修时，默认显示第一个
                    3.装修之后显示装修的商品
--%>
<c:choose>
    <c:when test="${empty defaultProductProxy}">
        <%--没有促销商品此时促销div不要显示--%>
    </c:when>
    <c:when test="${!empty defaultProductProxy && fn:length(promotionProductProxies) == 0}">
        <%--有促销商品但是还没有装修，默认显示第一个促销商品--%>
        <div class="recommend-box" id="panicBuy">
            <div class="recommend swiper-container">
                <div class="goods-box">
                    <!-- ul宽度为 li个数乘以238px -->
                    <ul class="in-time-goods swiper-wrapper frameEdit" frameInfo="sy_panic_buy" style="width: 238px;" id="promotionUl">
                        <c:set value="${defaultProductProxy.marketingActivity.activityEndTimeString}" var="endDate"/>
                        <li endDate="${endDate}" id="promotion1" class="swiper-slide">
                            <a href="${webRoot}/product-${defaultProductProxy.productId}.html" target="_blank" title="${productProxy.name}">
                                <div class="g-pic">
                                    <img src="${defaultProductProxy.images[0]['160X160']}"  height="160" width="160" alt="${defaultProductProxy.name}">
                                </div>
                                <div class="g-title elli">${defaultProductProxy.name}</div>
                                <div class="g-price"><span class="num"><i>￥</i>${defaultProductProxy.price.unitPrice}</span>
                                    <span class="zhe"><i><fmt:formatNumber  value="${defaultProductProxy.price.unitPrice/defaultProductProxy.price.originalUnitPrice*10}" type="number" pattern="#.#" minFractionDigits="1" /><b>折</b></i></span></div>
                                <div class="last-time" id="promotionDiv1">剩余：<span id="day1"></span><span id="hour1"></span><span id="minute1"></span><span id="second1"></span></div><%--这里要写剩余时间--%>
                            </a>
                            <a href="${webRoot}/product-${defaultProductProxy.productId}.html" class="get-now" target="_blank">立即抢购</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="recommend-box" id="panicBuy">
            <div class="recommend swiper-container">
                <div class="goods-box">
                    <!-- ul宽度为 li个数乘以238px -->
                    <ul class="in-time-goods swiper-wrapper frameEdit" frameInfo="sy_panic_buy" style="width: 1428px;" id="promotionUl">
                        <c:forEach items="${promotionProductProxies}" var="productProxy" varStatus="s">
                            <%--<script>alert("${productProxy.marketingActivity.activityEndTimeString}");</script>--%><%-- 取到的值格式是2016-11-11 12:54:12--%>
                            <c:set value="${productProxy.marketingActivity.activityEndTimeString}" var="endDate"/>
                            <li endDate="${endDate}" id="promotion${s.count}" class="swiper-slide">
                                <a href="${webRoot}/product-${productProxy.productId}.html" target="_blank"  title="${productProxy.name}">
                                    <div class="g-pic">
                                        <img src="${productProxy.images[0]['160X160']}"  height="160" width="160" alt="${productProxy.name}">
                                    </div>
                                    <div class="g-title elli">${productProxy.name}</div>
                                    <div class="g-price"><span class="num"><i>￥</i>${productProxy.price.unitPrice}</span><span class="zhe"><i><fmt:formatNumber  value="${productProxy.price.unitPrice/productProxy.marketPrice*10}" type="number" pattern="#.#" minFractionDigits="1" /><b>折</b></i></span></div>
                                    <div class="last-time" id="promotionDiv${s.count}">剩余：<span id="day${s.count}"></span><span id="hour${s.count}"></span><span id="minute${s.count}"></span><span id="second${s.count}"></span></div><%--这里要写剩余时间--%>
                                </a>
                                <a href="${webRoot}/product-${productProxy.productId}.html" class="get-now" target="_blank">立即抢购</a>
                            </li>
                        </c:forEach>
                    </ul>
                    <c:if test="${fn:length(promotionProductProxies) > 5}">
                        <a href="javascript:void(0);" class="slider-control-prev" id="promotion-prev"></a>
                        <a href="javascript:void(0);" class="slider-control-next" id="promotion-next"></a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>
