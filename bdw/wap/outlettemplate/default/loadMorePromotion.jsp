<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findSpecialPriceProductProxy(param.shopId, param.page, param.limit)}" var="panicBuyProductProxyList"/>
<c:forEach var="productProxy" varStatus="s" items="${panicBuyProductProxyList.result}">
    <c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
    <div class="time-limit">
        <div class="swiper-slide">
            <div class="mt">
                <div id="endDateStr_${s.index}" class="mt-rt" endDateStr="${productProxy.endDateStr}"></div>
            </div>
            <div class="mc">
                <div class="mc-box">
                    <div class="pic">
                        <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}">
                            <c:choose>
                                <c:when test="${not empty productProxy.defaultImage['200X200']}">
                                    <img src="${productProxy.defaultImage['200X200']}" alt="${productProxy.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${webRoot}/template/bdw/statics/images/noPic_200X200.jpg" alt="${productProxy.name}">
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                    <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}<br>
                        <c:if test="${not empty attrGroupProxyList}">
                            <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                                <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                    <ul class="attributes">
                                        <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict" end="0">
                                            <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                                <c:if test="${not empty attrGroupProxy.dicValueMap}">
                                                    ${attrGroupProxy.dicValueMap['span'].valueString}
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </a>
                    <div class="price">
                        抢购价:
                        <c:set value="${productProxy.price.unitPrice}" var="unitPrice"/>
                        <%
                            Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                            String priceStr = String.valueOf(unitPrice);
                            String[] price = priceStr.split("[.]");
                            String integerPrice = price[0];
                            String decimalPrice = price[1];
                            if (StringUtils.isBlank(decimalPrice)) {
                                decimalPrice = "00";
                            } else if (decimalPrice.length() < 2) {
                                decimalPrice += "0";
                            }
                            pageContext.setAttribute("integerPrice", integerPrice);
                            pageContext.setAttribute("decimalPrice", decimalPrice);
                        %>
                        <i>￥</i><span>${integerPrice}</span><i>.</i><em>${decimalPrice}</em>
                    </div>
                    <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}" class="buy-btn">立即抢购</a>
                </div>
            </div>
        </div>
    </div>
</c:forEach>