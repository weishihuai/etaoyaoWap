<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/ajaxload/js/product_detail_dapei_info.js"></script>
<c:set var="productProxy" value="${sdk:getProductById(param.id)}"/>
<c:set value="${productProxy.referSkuList}" var="referProductList"></c:set>

<input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
<input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">
<div class="mt"><span>推荐搭配</span></div>
<div class="mc" id="refer">
    <div class="mc-top" id="dapei">
        <c:set value="${fn:length(referProductList)*105+105}" var="divWidth"/>
        <c:set value="${productProxy.priceListStr}" var="priceStr"/>
        <ul style="width: ${divWidth}px"><!-- ul的宽度为动态 等于li 的个数乘以 105px -->
            <li>
                <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="pic"><img src="${productProxy.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                <div class="title"><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">${productProxy.name}</a></div>
                <%--<c:choose>
                    <c:when test="${fn:indexOf(priceStr,'-')>0}">
                        <span id="packagePrice">¥${fn:substringBefore(priceStr,"-")}起</span>
                    </c:when>
                    <c:otherwise>
                        <span id="packagePrice">¥${productProxy.priceListStr}</span>
                    </c:otherwise>
                </c:choose>--%>
                <span id="packagePrice">¥${productProxy.priceListStr}</span>
            </li>
            <c:forEach items="${referProductList}" var="refPrd" varStatus="num">
                <li>
                    <a href="${webRoot}/wap/product.ac?id=${refPrd.productId}" class="pic"><img src="${refPrd.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                    <div class="title"><a href="${webRoot}/wap/product.ac?id=${refPrd.productId}">${refPrd.name}</a></div>
                    <span>¥${refPrd.price.unitPrice}</span>
                    <input type="checkbox" class="sel" name="packageItem" skuid="${refPrd.skus[0].skuId}" value="${refPrd.price.unitPrice}"></input>
                </li>
            </c:forEach>
        </ul>
        <script type="text/javascript">
            var referProductListNoCheck = function () {
                $("#refer input[type='checkbox']").each(function () {
                    $(this).attr("checked", false);
                });
            }();
        </script>
    </div>
    <div class="mc-bot">
        <a href="javascript:" class="batch_addcart" id="dapeiCart" carttype="normal" handler="sku">购买搭配套餐</a>
        <p>您已购买<i id="selectNum">0</i>个自由搭配组合</p>
        <p>搭配价：<span><em id="dapeiprice">0.0</em></span></p>
    </div>
</div>