<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="pageNum"/>                         <%--订单翻页数，默认为第一页--%>
<c:set value="${sdk:searchCpsPromotionPrd(6)}" var="productProxy"/>

<c:if test="${fn:length(productProxy.result)>0}">
    <ul class="good-list">
        <c:forEach items="${productProxy.result}" var="product">
            <li class="media">
                <a class="media-img" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">
                    <img src="${product.imageProxy['200X200']}" alt="">
                </a>
                <div class="media-cont">
                    <p class="media-name"><a href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">${product.productNm}</a></p>
                    <p class="media-desc">商品单价&emsp;&yen;<fmt:formatNumber value="${product.unitPrice}" type="number" pattern="#0.00#" /></p>
                    <p class="media-desc">佣金比率&emsp;<fmt:formatNumber value="${product.rebateRate}" type="number" pattern="#0.00#" />%</p>
                    <p class="media-price">赚&ensp;<span><small>&yen;</small>${product.ratePriceIntValue}<small>.${product.ratePriceDecimalValue}</small></span></p>
                </div>

                <a class="action cpsShare" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}" shareId="${product.productId}">分享赚钱</a>
            </li>
        </c:forEach>
    </ul>
</c:if>