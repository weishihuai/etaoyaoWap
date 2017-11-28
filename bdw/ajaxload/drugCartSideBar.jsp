
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:set var="handler" value="drug"/>

<script>
    document.getElementById("scrollTopDiv").scrollTop = GetCookie("drugSidebar");//页面加载时设置scrolltop高度
</script>
<c:if test="${not empty user}">
    <c:set value="${sdk:getUserCartListProxy('drug')}" var="userCartListProxyDrug"/>      <!--药品购物车-->
    <c:set value="${userCartListProxyDrug.allDiscount}" var="allDiscountDrug" />
    <c:set value="${userCartListProxyDrug.allDeliveryDiscount}" var="allDeliveryDiscountDrug" />
</c:if>

    <c:choose>
      <c:when test="${userCartListProxyDrug.allCartNum <= 0}">
        <div  class="mbar-null reservation-mbar-null dd-mbar">
          <div class="mbar-null-box">
            <em></em>
            <p>您的预定清单还没有商品，<br>快去逛逛吧～</p>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <div class="reservation-mbar dd-mbar" style="display: block;">
          <div class="all-select">
            <label class="checkbox-box"><em  onclick="selectAllCart(this)" class="selectAll" carttype="drug" data-checked="false"></em></label> <span>全选</span></div>

            <c:forEach items="${userCartListProxyDrug.shoppingCartProxyList}" var="shoppingCartProxy">

              <div class="same-shop">
              <%--为了解决运费优惠再次命中，需要进入购物车时，清除zoneId--%>
              ${sdk:clearShoppingCartZoneId("normal", shoppingCartProxy.orgId)}
            <c:set var="shopInfo" value="${shoppingCartProxy.shopInf}"/>
            <div class="same-shop-dt">
              <label class="checkbox-box"><em class="checkPro" onclick="checkPro(this)" carttype="drug" data-checked="false"></em></label>
              <span>${shopInfo.shopNm}</span></div>
              <%-- --%>
            <div class="same-shop-dd">
              <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                <c:set var="productProxy" value="${cartItemProxy.productProxy}"/>
                <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                <c:if test="${cartItemProxy.isPresent =='N'}">
                  <div class="item">
                    <label class="checkbox-box">
                      <em onclick="updateSelect(this)" class="updateSelect" productId="${cartItemProxy.productId}" itemKey="${cartItemProxy.itemKey}"  carttype="drug" orgid="${shoppingCartProxy.orgId}" data-checked="${cartItemProxy.itemSelected  ?  "true" : "false"}"></em>
                    </label>
                    <a class="pic" href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["80X80"]}" alt=""></a>
                    <a class="name" href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name} &nbsp; &nbsp; ${productProxy.dicValueMap["span"].valueString}  &nbsp; &nbsp;${productProxy.brand.name} <%-- &nbsp; &nbsp;${productProxy.dicValueMap["factory"].valueString}--%>  </a>
                    <p class="price">¥${ cartItemProxy.productUnitPrice} </p>
                    <div class="number">
                      <div class="add-subtract">
                        <a class="subtract ${cartItemProxy.quantity == 1 ?"btn-off":""}" onclick="subNum(this)"  href="javascript:;" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" carttype="drug" orgid="${shoppingCartProxy.orgId}"  productId="${cartItemProxy.productId}">-</a>
                        <span >${cartItemProxy.quantity}</span>
                        <a class="add " onclick="addNum(this)" href="javascript:;"  itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" carttype="drug"   orgid="${shoppingCartProxy.orgId}" productId="${cartItemProxy.productId}">+</a>
                      </div>
                    </div>
                    <a class="del ${cartItemProxy.itemKey}" onclick="delItem(this)" href="javascript:" carttype="drug" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">删除</a>
                  </div>
                </c:if>
              </c:forEach>
            </div>
          </div>
          </c:forEach>

          <div class="shop-clearing">
            <p>已选<span>${userCartListProxyDrug.selectCartNum}</span>件</p>
            <p class="shop-clearing-price">共计：<span>
                                    <c:choose>
                                      <c:when test="${userCartListProxyDrug.allProductTotalAmount+userCartListProxyDrug.allDiscount < 0}">
                                        <span class="span-price"><em>¥</em><fmt:formatNumber value="0.0" type="number" pattern="#0.00#" /></span>元
                                      </c:when>
                                      <c:otherwise>
                                        <span class="span-price"><em>¥</em><fmt:formatNumber value="${userCartListProxyDrug.allProductTotalAmount + userCartListProxyDrug.allDiscount}" type="number" pattern="#0.00#" /></span>元
                                      </c:otherwise>
                                    </c:choose>
                                </span></p>
            <a class="shop-clearing-btn"   carttype="drug" onclick="addCartResultClick(this)"  href="javascript:;">提交预定</a>
          </div>
        </div>

      </c:otherwise>
    </c:choose>

