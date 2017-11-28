<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${bdw:getShopInfProxyByOrgId(param.orgId)}" var="storeProxy"/>
<c:set value="${storeProxy.sysOrgId}" var="orgId"/>
<c:set var="carttype" value="store"/>

<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}

<c:set var="mdCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<c:set var="mdCartNum" value="${mdCartProxy.selectedCartItemNum}" />
${sdk:saveOrderParam(carttype)}
<%--默认商品图片--%>
<c:set var="noProductPic" value="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg"/>
<span class="bg"></span>
<dl>
  <dt>
  <h3>购物清单</h3>
  <a href="${webRoot}/citySend/storeDetail.ac?orgId=${storeProxy.sysOrgId}" title="返回门店">返回门店修改</a>
  </dt>
  <dd>
    <ul>
      <c:forEach items="${mdCartProxy.cartItemProxyList}" var="ocartItemProxy">
        <c:set var="ocurHandler" value="${ocartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
        <c:set var="oitemKey" value="${ocartItemProxy.itemKey}"/>
        <c:set var="oisSelected" value="${ocartItemProxy.itemSelected}"/>
        <c:set var="opromotionType" value="${ocartItemProxy.promotionType}"/>
        <c:if test="${ocartItemProxy.itemSelected}">
          <li class="media">
            <a href="${webRoot}/product-${ocartItemProxy.productId}.html">
              <div class="media-left">
                <c:choose>
                  <c:when test="${not empty ocartItemProxy.productProxy.defaultImage['80X80']}">
                    <img src="${ocartItemProxy.productProxy.defaultImage["80X80"]}" alt="${ocartItemProxy.name}" width="80px" height="80px">
                  </c:when>
                  <c:otherwise>
                    <img src="${noProductPic}" alt="${ocartItemProxy.name}" width="80px" height="80px">
                  </c:otherwise>
                </c:choose>
              </div>
            </a>
            <div class="media-body">
              <p class="media-heading">
                <c:if test="${opromotionType == 'COMBINED_PRODUCT'}">
                  <label style="color:red;">[套餐]</label>
                </c:if>
                <c:if test="${opromotionType == 'PRESENT'}">
                  <label style="color:red;">[赠品]</label>
                </c:if>
                <a href="${webRoot}/product-${ocartItemProxy.productId}.html">
                   ${ocartItemProxy.name}
                </a>
              </p>
              <c:if test="${null != ocartItemProxy.combos}">
                <p>
                    <c:forEach items="${ocartItemProxy.combos}"  var="combo">
                      <a href="${webRoot}/product-${combo.productId}.html">
                       <h4><img width="30" height="30" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/>${combo.name}<span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                      </a>
                    </c:forEach>
                </p>
              </c:if>
              <c:if test="${null != ocartItemProxy.presents}">
                <c:forEach items="${ocartItemProxy.presents}"  var="combo">
                 <a href="${webRoot}/product-${combo.productId}.html">
                  <h4><img width="30" height="30" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/><span style="color:red;">[赠品]</span>${combo.name}<span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                 </a>
                </c:forEach>
              </c:if>
              <p>
                <em>x${ocartItemProxy.quantity}</em>
              </p>
              <p>
                <c:if test="${not empty ocartItemProxy.specName}">
                  <span>规格: ${ocartItemProxy.specName}</span>
                </c:if>
                <em>&yen;${ocartItemProxy.productUnitPrice}</em>
              </p>
            </div>
          </li>
        </c:if>
      </c:forEach>
    </ul>
    <div class="total">
      <p>共${mdCartNum}件商品</p>
      <p>
        <span class="fl">商品总金额</span>
        <em class="fr">&yen;&nbsp;${mdCartProxy.productTotalAmount}</em>
      </p>
    </div>
  </dd>
</dl>