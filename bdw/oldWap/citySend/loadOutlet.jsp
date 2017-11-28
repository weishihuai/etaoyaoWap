<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:searchStore(50, param.zoneId, empty param.lat ? null : param.lat, param.lng, '')}" var="citySendShops"/>

<dl class="store-list">
    <dt>附近门店<small>共找到${fn:length(citySendShops)}家</small></dt>
    <c:set var="noPic" value="${webRoot}/template/bdw/statics/images/noPic_230X230.jpg"/>

    <c:forEach items="${citySendShops}" var="shop" varStatus="s">
        <dd class="store" orgId="${shop.sysOrgId}">
            <a class="store-img" href="javascript:" orgId="${shop.sysOrgId}" isSupportBuy="${shop.isSupportBuy}" onclick="gotoStore(this);">
                <c:choose>
                    <c:when test="${not empty shop.shopPicUrl}">
                        <img src="${webRoot}/upload/${shop.shopPicUrl}" alt="${shop.shopNm}" style="width: 100%; height: 100%;"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${noPic}" alt="${shop.shopNm}" style="width: 100%; height: 100%;"/>
                    </c:otherwise>
                </c:choose>
            </a>
            <div class="store-cont">
                <span class="store-distance">
                    <c:choose>
                        <c:when test="${shop.distinct < 1000}">
                            <%--小于1km则显示m--%>
                            <fmt:formatNumber value="${shop.distinct}" type="number" pattern="#0.00" />m
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${shop.distinct / 1000}" type="number" pattern="#0.00" />km
                        </c:otherwise>
                    </c:choose>
                </span>
                <a class="store-name" href="javascript:" style="line-height: 2.0rem;" orgId="${shop.sysOrgId}" isSupportBuy="${shop.isSupportBuy}" onclick="gotoStore(this);">${shop.shopNm}</a>
                <div class="stars">
                    <c:choose>
                        <c:when test="${empty shop.goodRate || shop.goodRate eq 0}">
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            <span></span>
                            &ensp;0.0%
                        </c:when>
                        <c:otherwise>
                            <c:set value="${shop.goodRate / 20}" var="goodRate"/>
                            <c:forEach begin="1" end="5" varStatus="i">
                                <span class="${goodRate >= i.index ? 'active' : ''}"></span>
                            </c:forEach>
                            &ensp;<fmt:formatNumber value="${shop.goodRate}" pattern="#0"/>%
                        </c:otherwise>
                    </c:choose>
                </div>
                <%--<p class="store-freight">配送费&ensp;&yen;10</p>--%>
                <div class="store-offers">
                    <c:set value="${bdw:getShopBusinessRule(shop.shopInfId)}" var="shopBusinessRule"/> <%--商家优惠规则--%>
                    <c:if test="${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr != ''}">
                        <p><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-mj.png" alt="">${shopBusinessRule.orderOffRuleSaveProxy.orderOffRuleStr}</p>
                    </c:if>
                    <c:if test="${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr != ''}">
                        <p><img src="${webRoot}/template/bdw/wap/citySend/statics/images/p-my.png" alt="">${shopBusinessRule.orderLogisticsSaveProxy.orderLogisticsStr}</p>
                    </c:if>
                </div>
            </div>
        </dd>
    </c:forEach>

</dl>
