<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/23
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="prdProxy" value="${sdk:getProductById(param.id)}"/>
<c:set var="specList" value="${prdProxy.productUserSpecProxyList}"/>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<script type="text/javascript">
  var skuData = eval('${prdProxy.skuJsonData}');
  var userSpecData = eval('${prdProxy.userSpecJsonData}');
  var productId = eval('${prdProxy.productId}');
  var webPath = {
    webRoot: "${webRoot}", page: "${param.page}", productId: "${param.id}", productCollectCount: "${loginUser.productCollectCount}", shopCollectCount: "${loginUser.shopCollectCount}", goBox: "${param.goBox}"
  };
</script>
<script type="text/javascript" src="${webRoot}/template/bdw/citySend/statics/js/spec.js"></script>

<!-- 选规格 -->
<div class="modal" id="multiSpecSel">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="main">
        <div class="main-hd">
          <a class="btn-close" href="javascript:">
            <i class="icon-close"></i>
          </a>
        </div>
        <div class="main-bd">
          <ul>
            <c:forEach varStatus="ig" items="${prdProxy.images}" var="image">
              <li class="ig-item" <c:if test="${ig.index != 0}">style="display: none;"</c:if> id="ig${ig.index}">
                <img src="${image['420X420']}" alt="">
              </li>
            </c:forEach>
          </ul>
        </div>
        <div class="main-ft">
          <ul id="circleli">
            <c:forEach varStatus="s" items="${prdProxy.images}" var="image">
              <li class="<c:if test="${s.index ==0}">active</c:if> circle${s.index}" image-index="${s.index}"></li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="side">
        <p class="name">${prdProxy.name}</p>
        <p class="other">${prdProxy.salePoint}</p>

        <div class="price" >
          <span id="price"><small>&yen;&nbsp;</small>${prdProxy.priceListStr}</span>
          <del class="price01" id="marketPrice">&yen;${prdProxy.marketPrice}</del>
        </div>
        <input type="hidden" id="priceListStr" priceNm="${prdProxy.price.amountNm}" value="${prdProxy.priceListStr}">
        <input type="hidden" id="remainStock" value="${(prdProxy.skus[0].price.remainStock)}">

        <div class="stock">
          <c:choose>
            <c:when test="${prdProxy.price.discountType eq 'PLATFORM_DISCOUNT'}">
              (活动剩余库存${prdProxy.price.remainStock}件)
            </c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${(prdProxy.skus[0].price.remainStock)<=0}">
                  <span><small>库存：</small><em id="stock">${prdProxy.price.remainStock}</em>件</span>
                </c:when>
                <c:otherwise>
                 <span><small>库存：</small><em id="stock">${(prdProxy.skus[0].price.remainStock)}</em>件</span>
                </c:otherwise>
              </c:choose>
              <c:if test="${sdk:getIsPlatformDiscount(param.id)&&!prdProxy.price.isSpecialPrice}">
                ,活动剩余库存0件
              </c:if>
            </c:otherwise>
          </c:choose>
        </div>

        <%--多规格--%>
        <c:if test="${prdProxy.isEnableMultiSpec=='Y'}">
          <c:forEach items="${specList}" var="spec">
            <c:if test="${fn:length(spec.specValueProxyList) > 0}">
              <dl class="b_rows specSelect">
                <dt data-value="${spec.specId}:${specValue.specValueId}" remainStock="${specValue.remainStock}">${spec.name}</dt>
                <dd>
                  <c:forEach items="${spec.specValueProxyList}" var="specValue">
                    <c:if test="${spec.specType eq '0'}">
                      <span title="${specValue.name}" class="item size" title="${specValue.name}" data-value="${spec.specId}:${specValue.specValueId}" remainStock="${specValue.remainStock}">${specValue.value}</span>
                    </c:if>
                    <c:if test="${spec.specType eq '1'}">
                      <span title="${specValue.name}" class="item size" data-value="${spec.specId}:${specValue.specValueId}"><img width='30' height='30' src="${specValue.value}"/></span>
                    </c:if>
                  </c:forEach>
                </dd>
              </dl>
            </c:if>
          </c:forEach>
        </c:if>
        <c:choose>
          <c:when test="${prdProxy.isCanBuy}">
            <button class="btn addStoreCart" style="cursor: pointer;" type="button" skuid="" carttype="store" handler="sku" num="1" orgid="${prdProxy.sysOrgId}">加入购物车</button>
          </c:when>
          <c:otherwise>
            <button class="btn quehuobtn" style="cursor: pointer;" type="button" skuid="${prdProxy.isEnableMultiSpec=='Y' ?  '': prdProxy.skus[0].skuId}">到货通知</button>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
