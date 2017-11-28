<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="handler" value="${empty param.handler ? 'store' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'store' : param.carttype}"/>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<c:set value="${userCartListProxy.allDiscount}" var="allDiscount" />
<c:set value="${userCartListProxy.allDeliveryDiscount}" var="allDeliveryDiscount" />
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>

  <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
      <c:if test="${shoppingCartProxy.cartNum gt 0}">
          <div class="cart order">
              <c:set var="shopInfo" value="${shoppingCartProxy.shopInf}"/>
              <c:set value="${bdw:checkWapOrgSelected(carttype,userProxy.userId,shoppingCartProxy.shopInf.sysOrgId)}" var="checkWapOrgSelected" />
              <div class="dt"><div class="dt-inner"><em class="checkPro checkbox  ${checkWapOrgSelected == "Y"? "checkbox-active" : ""}" carttype="${carttype}" onclick="checkPro(this)"></em><a href="${webRoot}/wap/outlettemplate/default/outletIndex.ac?shopId=${shopInfo.shopInfId}">${shopInfo.shopNm}</a></div></div>
              <div class="dd">
                  <c:forEach items="${shoppingCartProxy.discountDetails}" var="discount" varStatus="s">
                      <div class="dd-h"><span>折扣</span>${discount.amountNm}</div>
                  </c:forEach>
                  <c:set value="${shoppingCartProxy.cartItemProxyList}" var="shppingCartItemProxy"/>
                  <c:forEach items="${shppingCartItemProxy}" var="cartItemProxy">
                      <c:if test="${cartItemProxy.isPresent =='N'}">
                          <c:set var="productProxy" value="${cartItemProxy.productProxy}"/>
                          <div class="dd-item">
                              <em class="updateSelect checkbox ${cartItemProxy.itemSelected?"checkbox-active":""}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onclick="updateSelect(this)" ></em>
                              <a class="pic" href="${webRoot}/wap/outlettemplate/default/product.ac?id=${cartItemProxy.productId}"><img src="${productProxy.defaultImage["160X160"]}" alt=""></a>
                              <a class="name" href="${webRoot}/wap/outlettemplate/default/product.ac?id=${cartItemProxy.productId}">${productProxy.name}</a>
                              <p class="price">￥${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</p>
                              <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                              <div class="add-subtract">
                                  <a class="add subNum" href="javascript:;" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}" handler="${curHandler}" carttype="${carttype}" productId="${cartItemProxy.productId}">-</a>
                                  <input type="text" value="${cartItemProxy.quantity}" class="text cartNum ${cartItemProxy.itemKey}" handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" productId="${cartItemProxy.productId}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                  <a class="subtract addNum" href="javascript:;" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}" handler="${curHandler}" carttype="${carttype}" productId="${cartItemProxy.productId}">+</a>
                              </div>
                          </div>
                      </c:if>
                  </c:forEach>

                  <c:set var="hasPresent" value="N"/>
                  <c:forEach items="${shppingCartItemProxy}" var="cartItemProxy">
                      <c:if test="${cartItemProxy.promotionType!='PRESENT' and !empty cartItemProxy.presents}">
                          <c:set var="hasPresent" value="Y"/>
                      </c:if>
                      <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                          <c:set var="hasPresent" value="Y"/>
                      </c:if>
                  </c:forEach>
                  <c:if test="${hasPresent == 'Y'}">
                      <div class="dd-b">
                          <span class="title">赠品</span>
                          <c:forEach items="${shppingCartItemProxy}" var="cartItemProxy">
                              <c:if test="${cartItemProxy.promotionType!='PRESENT'}">
                                  <c:forEach var="presentItem" items="${cartItemProxy.presents}">
                                      <p class="elli">${presentItem.name}<span>x${presentItem.quantity}</span></p>
                                  </c:forEach>
                              </c:if>
                              <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                  <p class="elli">${cartItemProxy.name}<span>x${cartItemProxy.quantity}</span></p>
                              </c:if>
                          </c:forEach>
                      </div>
                  </c:if>
              </div>
          </div>
      </c:if>
  </c:forEach>
  <c:if test="${userCartListProxy.allCartNum gt 0}">
      <div class="clearing-fixed priceDiv" style="bottom: 1.5625rem; border-bottom: 0.015625rem solid #ddd;">
          <label><em class="checkProSelectAll checkbox selectAll <c:if test='${userCartListProxy.selectCartNum == userCartListProxy.allCartNum}'>checkbox-active </c:if>" carttype="${carttype}" onclick="selectAllPro(this)"></em><span>全选</span></label>
          <p class="heji">合计：<span>¥${userCartListProxy.finalAmount}</span></p>
          <p class="youhui">已优惠<span>￥<fmt:formatNumber value="${-allDiscount+allDeliveryDiscount}" type="number" pattern="#0.00#"/></span>&nbsp;&nbsp;赠送<span>${userCartListProxy.allObtainTotalIntegral}</span>积分</p>
          <c:set value="${userCartListProxy.selectCartNum}" var="selectCartNum" />
          <c:choose>
              <c:when test="${carttype eq 'store_drug'}">
                  <a class="clearing-btn" <c:if test="${selectCartNum gt 0}">href="${webRoot}/wap/outlettemplate/default/shoppingcart/drugOrderAdd.ac" </c:if>>立即预定<span>(${userCartListProxy.selectCartNum})</span></a>
              </c:when>
              <c:otherwise>
                  <a class="clearing-btn" <c:if test="${selectCartNum gt 0}">href="${webRoot}/wap/outlettemplate/default/shoppingcart/orderAdd.ac?carttype=${carttype}&handler=${handler}"</c:if>>去结算<span>(${userCartListProxy.selectCartNum})</span></a>
              </c:otherwise>
          </c:choose>
      </div>
  </c:if>

 <input class="hasSelected" style="display: none" hasSelected="${userCartListProxy.selectCartNum}" type="hidden"/>
 <div class="clearing-fixed hide editDiv" style="bottom: 1.5625rem; border-bottom: 0.015625rem solid #ddd;">
     <label><em class="checkbox selectAll <c:if test='${userCartListProxy.selectCartNum == userCartListProxy.allCartNum}'>checkbox-active </c:if>"  carttype="${carttype}" onclick="selectAllPro(this)"></em><span>全选</span></label>
     <a class="join-collect-btn collect" href="javascript:;" carttype="${carttype}">加入收藏夹</a>
     <a class="del-btn delete" href="javascript:;" carttype="${carttype}">删除</a>
 </div>

 <!-- 删除弹窗 -->
 <div class="del-product-layer" style="display: none;">
     <div class="del-product-box">
         <span class="title">删除商品</span>
         <p class="content"></p>
         <div class="btn-box"><a href="javascript:;" class="del-cancel">取消</a><a href="javascript:;" class="del-product" >删除</a></div>
     </div>
 </div>

 <div class="message-product-layer" style="display: none;">
     <div class="message-product-box">
         <span class="title">提示</span>
         <div class="btn-box"><a href="javascript:;" class="message-btn">确定</a></div>
     </div>
 </div>


<%--底部导航--%>
<c:import url="../../../footer.jsp"/>

<c:set value="${sdk:getUserCartListProxy('store')}" var="normalProxy"/>    <!--普通购物车-->
<c:set value="${sdk:getUserCartListProxy('store_drug')}" var="drugProxy"/>        <!--药品购物车-->
<script>
    var normalCartTotalNum = "${normalProxy.allCartNum}";
    var drugCartTotalNum = "${drugProxy.allCartNum}";
    $("#normalCartTotalNum").html(normalCartTotalNum == 0?'':normalCartTotalNum);
    $("#drugCartTotalNum").html(drugCartTotalNum == 0?'':drugCartTotalNum);
</script>
