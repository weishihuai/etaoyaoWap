<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<c:set value="${bdw:searchProductByType(param.limit,'N')}" var="productProxys"/>

<c:if test="${not empty productProxys.result}">
    <c:forEach items="${productProxys.result}" var="product" varStatus="status" end="9">
        <c:set var="productProxy" value="${sdk:getProductById(product.productId)}"/>
        <%-- 商家正在进行的优惠(赠品，包邮这些) --%>
        <c:set value="${productProxy.availableBusinessRuleList}" var="availableBusinessRuleList" />
        <%--取出商品属性--%>
        <c:set var="attrDicList" value="${productProxy.dicValues}"/>
        <c:set var="attrDicMap" value="${productProxy.dicValueMap}"/>
        <c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
        <div class="item">
            <a class="item-l" href="${webRoot}/wap/product.ac?id=${product.productId}">
                <img src="${product.defaultImage["320X320"]}" alt="${product.name}">
            </a>
            <div class="item-r" <c:if test="${status.last}">style="border-bottom: none"</c:if>>
                <a class="name" href="${webRoot}/wap/product.ac?id=${product.productId}">${product.name}</a>
                <p class="guige">
                    <c:if test="${not empty attrGroupProxyList}">
                        <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                            <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict" end="0">
                                    <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                        <c:if test="${not empty attrGroupProxy.dicValueMap}">
                                            ${attrGroupProxy.dicValueMap['span'].valueString}
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </p>
                <div class="product-character">
                    <c:choose>
                        <c:when test="${product.prescriptionTypeCode eq '甲类OTC'}"><span>甲OTC</span></c:when>
                        <c:when test="${product.prescriptionTypeCode eq 'RX'}"><span>RX</span></c:when>
                        <c:when test="${product.prescriptionTypeCode eq '乙类OTC'}"><span>乙OTC</span></c:when>
                    </c:choose>
                    <c:if test="${not empty availableBusinessRuleList}">
                        <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="status">
                            <c:choose>
                                <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}"><span>折扣</span></c:when>
                                <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}"><span>包邮</span></c:when>
                                <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}"><span>赠品</span></c:when>
                                <c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}"><span>换购</span></c:when>
                                <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}"><span>送券</span></c:when>
                                <c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}"><span>送积分</span></c:when>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="price-yaofang">
                    <c:set value="${product.price.unitPrice}" var="unitPrice"/>
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
                    <p class="price">￥<span>${integerPrice}.</span>${decimalPrice}</p>
                    <a class="yaofang" href="javascript:void(0);">${product.shopInfProxy.shopNm}</a>
                </div>
            </div>
        </div>
    </c:forEach>
</c:if>




