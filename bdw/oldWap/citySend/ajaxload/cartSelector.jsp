<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/26
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="productProxy" value="${sdk:getProductById(param.productId)}"/>
<c:set var="specList" value="${productProxy.productUserSpecProxyList}"/>

<script type="text/javascript">
    var skuData = eval('${productProxy.skuJsonData}');
    var userSpecData = eval('${productProxy.userSpecJsonData}');
    var dataValue = {webRoot:'${webRoot}',orgId:'${param.orgId}',productId:'${param.productId}'};
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/wap/citySend/ajaxload/js/cartSelector.js"></script>
<!-- 加入购物车 -->
<div class="dropback"></div>
<div class="modal-dialog">
    <div class="modal-header">
        <div class="media">
            <a class="close" href="javascript:;"></a>
            <div class="media-img" style="top: -1.4rem;;">
                <c:choose>
                    <c:when test="${not empty productProxy.defaultImage['200X200']}">
                        <img src="${productProxy.defaultImage['200X200']}" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                    </c:when>
                    <c:otherwise>
                        <img src="${webRoot}/template/bdw/statics/images/noPic_200X200.jpg" alt="${productProxy.name}" style="width: 100%;height: 100%;">
                    </c:otherwise>
                </c:choose>
            </div>
            <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">
            <input type="hidden" id="remainStock" value="${(productProxy.skus[0].price.remainStock)}">
            <div class="media-body">
                <span id="price" style="font-size: 1.2rem;font-weight: 500;"><small>&yen;</small>${productProxy.priceListStr}</span>
                <p class="stock" style="font-size: 1.0rem;color:#414141;font-weight: normal;">
                    <c:choose>
                        <c:when test="${productProxy.price.discountType eq 'PLATFORM_DISCOUNT'}">
                            (活动剩余库存${productProxy.price.remainStock}件)
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${(productProxy.skus[0].price.remainStock)<=0}">
                                    <span style="font-size: 1.0rem;color:#414141;font-weight: normal; "><small style="font-size: 1.0rem;">库存</small><em id="stock" style="font-size: 1.0rem;color:#414141;font-weight: normal;margin: 0px 2px;">${productProxy.price.remainStock}</em>件</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="font-size: 1.0rem;color:#414141;font-weight: normal;"><small style="font-size: 1.0rem;">库存</small><em id="stock" style="font-size: 1.0rem;color:#414141;font-weight: normal;">${(productProxy.skus[0].price.remainStock)}</em>件</span>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${sdk:getIsPlatformDiscount(param.id)&&!productProxy.price.isSpecialPrice}">
                                ,活动剩余库存0件
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
    <div class="modal-body">
        <c:if test="${productProxy.isEnableMultiSpec=='Y'}">
            <%--多规格--%>
            <c:forEach items="${specList}" var="spec">
                <c:if test="${fn:length(spec.specValueProxyList) > 0}">
                    <dl class="specSelect">
                        <dt style="font-size: 1.1rem;" data-value="${spec.specId}:${specValue.specValueId}"
                            remainStock="${specValue.remainStock}">${spec.name}</dt>
                        <dd>
                            <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                <c:if test="${spec.specType eq '0'}">
                                        <span title="${specValue.name}" class="item size" title="${specValue.name}"
                                              data-value="${spec.specId}:${specValue.specValueId}"
                                              remainStock="${specValue.remainStock}">${specValue.value}</span>
                                </c:if>
                                <c:if test="${spec.specType eq '1'}">
                                        <span title="${specValue.name}" class="item size"
                                              data-value="${spec.specId}:${specValue.specValueId}"
                                              remainStock="${specValue.remainStock}" >
                                            <c:choose>
                                                <c:when test="${not empty specValue.value}">
                                                    <img width='30' height='30' src="${specValue.value}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img width='30' height='30'
                                                         src="${webRoot}/template/bdw/statics/images/noPic_40X40.jpg"/>
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                </c:if>
                            </c:forEach>
                        </dd>
                    </dl>
                </c:if>
            </c:forEach>
        </c:if>
        <dt class="amount-tit">数量</dt>
        <dd class="amount-cont">
            <div class="amount">
                <a class="op cartReduce" href="javascript:">&minus;</a>
                <input class="cartInp" type="text" value="1"/>
                <a class="op cartAdd" href="javascript:">&plus;</a>
            </div>
        </dd>
    </div>
    <div class="modal-footer">
        <c:choose>
            <c:when test="${productProxy.isCanBuy}">
                <a href="javascript:" style="cursor: pointer;" class="addStoreCart" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}" carttype="store" handler="sku" num="1" orgid="${productProxy.sysOrgId}">确定</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:" style="cursor: pointer;background:#cccccc;color: #fff;" class="quehuobtn" skuid="${productProxy.isEnableMultiSpec=='Y' ?  '': productProxy.skus[0].skuId}">商品缺货</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>




