<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:searchWapShopInfProxy(param.limit)}" var="shopInfPage"/>

<c:forEach items="${shopInfPage.result}" var="shopInf" varStatus="s">
    <div class="item">
        <a class="pic" href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">
            <c:choose>
                <c:when test="${shopInf.defaultImage['100X100'] eq '/template/bdw/statics/images/noPic_100X100.jpg'}">
                    <img src="${webRoot}/template/bdw/wap/statics/images/wutupain_160x160.png" alt="">
                </c:when>
                <c:otherwise>
                    <img src="${shopInf.defaultImage["100X100"]}" alt="">
                </c:otherwise>
            </c:choose>
        </a>
        <a class="name elli" target="_blank" href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}">${shopInf.shopNm}</a>
        <p class="star-number">
            <span class="<c:if test="${shopInf.average>=1}">s</c:if>"></span>
            <span class="<c:if test="${shopInf.average>=2}">s</c:if>"></span>
            <span class="<c:if test="${shopInf.average>=3}">s</c:if>"></span>
            <span class="<c:if test="${shopInf.average>=4}">s</c:if>"></span>
            <span class="<c:if test="${shopInf.average>=5}">s</c:if>"></span>
            <fmt:formatNumber value="${shopInf.average}" type="number" pattern="#0.0"/>
        </p>
        <p class="collect-number">收藏量${shopInf.collectdByUserNum}人 | 成交量${shopInf.orderTotalCount}笔</p>
        <div class="discounts-box">
            <c:if test="${not empty shopInf.discountList ||not empty shopInf.freePostageList||not empty shopInf.presentList||not empty shopInf.certificateList }">
                <em class="icon-z" onclick="showOrHideDiscount(this)" data-onoff="true"></em>
                <div style="overflow: hidden;" class="txt-box">
                    <c:if test="${not empty shopInf.discountList}">
                        <c:forEach items="${shopInf.discountList}" var="discount" end="0">
                            <p class="elli"><span class="zhe">折</span>${discount.businessRuleNm}</p>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty shopInf.freePostageList}">
                        <c:forEach items="${shopInf.freePostageList}" var="freePostage" end="0">
                            <p class="elli"><span class="you">邮</span>${freePostage.businessRuleNm}</p>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty shopInf.presentList}">
                        <c:forEach items="${shopInf.presentList}" var="present" end="0">
                            <p class="elli"><span class="zeng">赠</span>${present.businessRuleNm}</p>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty shopInf.certificateList}">
                        <c:forEach items="${shopInf.certificateList}" var="certificate" end="0">
                            <p class="elli"><span class="jian">券</span>${certificate.businessRuleNm}</p>
                        </c:forEach>
                    </c:if>
                </div>
            </c:if>
            <ul class="sp-list">
                <c:if test="${not empty shopInf.wapShopProductList}">
                    <c:forEach var="productProxy" items="${shopInf.wapShopProductList}">
                        <c:set var="proImg" value="${productProxy.defaultImage['100X100']}"/>
                        <c:if test="${empty productProxy.images}">
                            <c:set var="proImg" value="${webRoot}/template/default/statics/images/noPic_100X100.jpg"/>
                        </c:if>
                        <li><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img src="${proImg}" alt=""><span class="price">￥<fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#"/></span></a></li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
    </div>
</c:forEach>