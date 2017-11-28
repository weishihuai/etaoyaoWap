<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<c:set value="${sdk:queryNearByShop(param.lat, param.lng, param.orderBy)}" var="shopList"/>--%>
<c:set value="${sdk:queryNearByShop(param.lat, param.lng, param.orderBy)}" var="shopList"/>
<c:set value="${webRoot}/template/bdw/wap/statics/images/wutupain_160x160.png" var="noPic"/>
<c:forEach items="${shopList}" var="shop">
    <li>
        <div class="pic">
            <a href="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId=${shop.shopInfId}"><img src="${empty shop.logoUrl ? noPic : shop.logoUrl}" /></a>
            <c:if test="${shop.cartNum gt 0}">
                <span>${shop.cartNum}</span>
            </c:if>
        </div>
        <a href="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId=${shop.shopInfId}" class="title">${shop.shopNm}</a>
        <div class="li-md">
            <i class="comment-item-star"><i class="<c:if test="${shop.shopTotalRating gt 0}">real-star </c:if>comment-stars-width${shop.shopTotalRating}"></i></i>
            <span><i>|</i>月售${shop.salesVolume}单</span>
            <em><fmt:formatNumber value="${shop.distance/1000}" pattern="0.00" maxFractionDigits="2"/>km</em>
        </div>
        <c:set var="promotionList" value="${shop.promotionList}"/>
        <c:if test="${not empty promotionList}">
            <div class="discount">
                <dl style="height: auto;">
                    <c:forEach items="${promotionList}" var="pm" varStatus="s">
                        <c:set var="ruleTypeStr" value="${pm.ruleTypeStr}"/>
                        <c:set var="ruleTypeClass" value=""/>
                        <c:choose>
                            <c:when test="${ruleTypeStr eq '减'}">
                                <c:set var="ruleTypeClass" value="jian"/>
                            </c:when>
                            <c:when test="${ruleTypeStr eq '折'}">
                                <c:set var="ruleTypeClass" value="zhe"/>
                            </c:when>
                            <c:when test="${ruleTypeStr eq '邮'}">
                                <c:set var="ruleTypeClass" value="you"/>
                            </c:when>
                            <c:when test="${ruleTypeStr eq '赠'}">
                                <c:set var="ruleTypeClass" value="zeng"/>
                            </c:when>
                        </c:choose>
                        <dd <c:if test="${s.count gt 2}"> style="display: none;" </c:if> class="elli"><span class="${ruleTypeClass}">${pm.ruleTypeStr}</span>${pm.businessRuleNm}</dd>
                    </c:forEach>
                </dl>
                <c:if test="${fn:length(promotionList) gt 2}">
                    <a href="javascript:;" class="open"></a>
                </c:if>
            </div>
        </c:if>
    </li>
</c:forEach>