<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
  <c:redirect url="${webRoot}/wap/login.ac"/>
</c:if>
<%--主要参数--%>
<c:set value="store" var="carttype"/> <%--购物车类型--%>
<c:set value="${param.orgId}" var="orgId"/> <%--机构ID--%>
<c:set value="${empty param.isCod || 'Y' != param.isCod ? 'N' : 'Y'}" var="isCod" /> <%--是否货到付款--%>
<c:if test="${empty orgId}">
  <c:redirect url="${webRoot}/wap/citySend/index.ac"/>
</c:if>

<%
  // 清除购物卷，在取出购物车之前
  String carttype = (String)pageContext.getAttribute("carttype");
  UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
  for (ShoppingCart shoppingCart : userCartList.getCarts()) {
    ResolverUtils.clearCoupon(shoppingCart);
    ResolverUtils.clacCartMisc(shoppingCart);
  }
  ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);
%>

<%--同城送支持的收货地址列表--%>
<c:set value="${bdw:findCitySendAddr(loginUser.userId, orgId, true)}" var="citySendAddrList"/>
<%--找出默认地址--%>
<c:forEach items="${citySendAddrList}" var="addr" varStatus="r">
  <c:if test="${addr.citySendSupport}">
    <c:if test="${'Y' == addr.isDefault}">
      <c:set value="${addr}" var="receiveAddr"/>
    </c:if>
  </c:if>
</c:forEach>

<%--商家信息--%>
<c:set value="${bdw:getShopInfProxyByOrgId(orgId)}" var="storeProxy"/>
<c:if test="${empty storeProxy || storeProxy.isFreeze == 'Y' || 'Y' != storeProxy.isSupportBuy}">
  <c:redirect url="${webRoot}/wap/citySend/index.ac"></c:redirect>
</c:if>
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}
<%--将该收货地址保存进购物车--%>
<c:if test="${not empty receiveAddr}">
  ${bdw:saveOrderReceiver(carttype, receiveAddr.receiveAddrId)}
</c:if>
<%--同城送购物车--%>
<c:set var="cityCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
<%--购物车商品为空则返回店铺页--%>
<c:if test="${empty cityCartProxy.cartItemProxyList || fn:length(cityCartProxy.cartItemProxyList) < 1}">
  <c:redirect url="${webRoot}/wap/citySend/storeIndex.ac?orgId=${orgId}"></c:redirect>
</c:if>
<%--商品总数--%>
<c:set var="cityCartNum" value="${cityCartProxy.selectedCartItemNum}" />
<%--默认商品图片--%>
<c:set var="noProductPic" value="${webRoot}/template/bdw/statics/images/noPic_180X180.jpg"/>
<%--配送方式列表--%>
<c:set value="${sdk:getDeliveryRuleList(carttype, orgId , isCod)}" var="deliveryRuleList"/>
<%--获取购物车的配送方式--%>
<c:if test="${not empty cityCartProxy.deliveryRuleId}">
  <c:forEach items="${deliveryRuleList}" var="delivery">
    <c:if test="${delivery.deliveryRule.deliveryRuleId == cityCartProxy.deliveryRuleId}">
      <c:set value="${delivery}" var="cartDeliveryRule" />
    </c:if>
  </c:forEach>
</c:if>
<%--获取可以使用的购物劵--%>
<c:set value="${sdk:findUserCouponList(carttype, orgId)}" var="userCouponList"/>
<%--可用劵数量--%>
<c:set value="${fn:length(userCouponList)}" var="userCouponListLength"/>
<%--已经选择的购物劵--%>
<c:set value="${sdk:getCurrSelectCoupons(carttype,orgId)}" var="useCoupons"/>
<c:set value="${useCoupons[0]}" var="usedCoupon"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>提交订单-${webName}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" />
  <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" />
  <style type="text/css">
    .popup{width: 100%; height: 100%; position: fixed; z-index: 21; background-color: rgba(0,0,0,0.5); left: 0; top:0; bottom: 0;}
    .select-layer{padding: 20px 0 65px; width: 100%; background-color: #fff; position: absolute; left: 0; bottom: 0;}
    .select-layer .mt{width: 100%; padding: 0 12px; height: 20px; color: #0c1828; line-height: 20px; font-size: 16px; font-weight: bold;}
    .select-layer .mc{width: 100%; height: 180px; margin-top: 20px; overflow: hidden; overflow-y: auto; }
    .select-layer .mc li label{display: block; width: 100%; height: 45px; padding: 0 50px 0 12px; line-height: 45px; position: relative; color: #0c1828; font-size: 16px; overflow: hidden;}
    .select-layer .mc .icon{position: absolute; right: 15px; top:50%; margin-top: -10px;}
    .select-layer .confirm{display: block; width: 100%; height: 45px; line-height: 45px; text-align: center;  color: #fff; font-size: 16px; background-color: #e7141a; position: absolute; left: 0; bottom: 0;}
    .select-layer .close{position: absolute;top: 20px; right: 1.5rem;width: 1.3rem; height: 1.3rem;background: url(${webRoot}/template/bdw/wap/citySend/statics/images/store-icons.png) no-repeat -5.65rem -18.2rem / 7.5rem 22.5rem;}

    .radioLabel {color: #666; font-size: 12px; line-height: 20px; }
    .radioLabel .icon {position: relative; display: inline-block; box-sizing: border-box; width: 20px; height: 20px; border: 1px solid #a6a6a6; border-radius: 50%; background-color: #fff; vertical-align: middle; }
    .radioLabel .icon:before {content: ''; position: absolute; top: 50%; left: 50%; width: 10px; height: 6px; box-sizing: border-box; border-bottom: 2px solid #fff; border-left: 2px solid #fff; -webkit-transform: translate(-50%, -60%) rotate(-45deg); transform: translate(-50%, -60%) rotate(-45deg); }
    .radioLabel input:checked ~ .icon {border-color: #c10c00; background-color: #c10c00; }

    .m-checkout .comboMedia {position: relative; padding: 1.5rem 1.0rem; overflow: hidden;}
    .m-checkout .comboMedia:after { content: ''; position: absolute; bottom: 0; left: 1.2rem; right: 1.2rem; height: 1px; background-color: #eee; }
    .m-checkout .comboMedia:last-child:after {height: 0;background: none;}
    .m-checkout .comboMedia .price { font-size: 1.5rem; color: #e7141a; letter-spacing: 0.1rem; }
    .m-checkout .comboMedia .price small { font-size: .8em; }
    .m-checkout .comboMedia .num { position: absolute; right: 0; bottom: 0; font-size: 1.3rem; color: #666; }
  </style>

  <script type="text/javascript">
    var webPath = {
      webRoot:"${webRoot}",
      orgId:'${orgId}',
      userId:"${loginUser.userId}",
      carttype:"${carttype}",
      isCod:"${isCod}",
      userCouponListLength:"${userCouponListLength}"
    };
  </script>
  <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
  <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/wap/citySend/statics/js/cityCheckout.js"></script>
</head>

<body>
<div class="main m-checkout">
  <!-- 收货地址 -->
  <div class="addr">
    <a href="${webRoot}/wap/citySend/cityAddrSelect.ac?orgId=${orgId}&isCod=${isCod}">
      <c:choose>
        <c:when test="${not empty receiveAddr}">
          <p class="stress receiveAddr" receiveAddrId="${receiveAddr.receiveAddrId}">${receiveAddr.name}&emsp;${receiveAddr.mobile}</p>
          <p style="word-break: break-all;">${receiveAddr.addressPath}&nbsp;${receiveAddr.addressStr}</p>
        </c:when>
        <c:otherwise>
          <p class="receiveAddr">请选择收货地址</p>
        </c:otherwise>
      </c:choose>
    </a>
  </div>

  <!-- 清单 -->
  <dl class="cart-list">
    <dt>
      <a href="javascript:" orgId="${storeProxy.sysOrgId}" isSupportBuy="${storeProxy.isSupportBuy}" onclick="gotoStore(this);">${storeProxy.shopNm}</a>
    </dt>

    <c:forEach items="${cityCartProxy.cartItemProxyList}" var="cartItemProxy">
      <c:if test="${cartItemProxy.itemSelected}">
        <c:choose>
          <%-- 套餐商品 --%>
          <c:when test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
            <dd class="media">
              <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                <c:choose>
                  <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                    <%--<img src="${cartItemProxy.productProxy.defaultImage['200X200']}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>--%>
                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="200px" height="200px" style="width: 100%;height: 100%;">
                  </c:when>
                  <c:otherwise>
                    <img src="${noProductPic}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>
                  </c:otherwise>
                </c:choose>
              </a>
              <div class="media-body">
                <span class="num">x${cartItemProxy.quantity}</span>
                <a class="media-tit" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">${cartItemProxy.name}</a>
                <c:if test="${not empty cartItemProxy.specName}">
                  <div class="media-desc">
                    <span style="float: left;margin-right: 0;">规格:</span><div style="margin-left: 3rem;">${cartItemProxy.specName}</div>
                  </div>
                </c:if>
                <c:set value="${cartItemProxy.productUnitPrice}" var="unitPrice"/>
                <%
                  Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                  String priceStr = String.valueOf(unitPrice);
                  String[] price = priceStr.split("[.]");
                  String intgerPrice = price[0];
                  String decimalPrice = price[1];
                  if (StringUtils.isBlank(decimalPrice)) {
                    decimalPrice = "00";
                  } else if (decimalPrice.length() < 2) {
                    decimalPrice += "0";
                  }
                  pageContext.setAttribute("intgerPrice", intgerPrice);
                  pageContext.setAttribute("decimalPrice", decimalPrice);
                %>
                <p class="price"><small>¥</small>${intgerPrice}<small>.${decimalPrice}</small></p>
              </div>

                <%--套餐内的商品--%>
              <div style="float: left;width: 100%;">
                <c:forEach items="${cartItemProxy.combos}" var="combo" varStatus="com">
                  <c:set value="${bdw:getAllStatusProductById(combo.productId)}" var="comboProduct"/>
                  <div class="comboMedia" style="padding: 1.0rem;">
                    <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${combo.productId}" style="width: 5.0rem;height: 5.0rem;">
                      <c:choose>
                        <c:when test="${not empty combo.images.imageValueEntryList && not empty combo.images.imageValueEntryList[0].sysFileUrl}">
                          <%--<img src="${comboProduct.defaultImage['100X100']}" alt="${combo.name}" style="width: 100%;height: 100%;"/>--%>
                          <img src="${combo.images.imageValueEntryList[0].sysFileUrl}" alt="${combo.name}" style="width: 100%;height: 100%;">
                        </c:when>
                        <c:otherwise>
                          <img src="${noProductPic}" alt="${combo.name}" style="width: 100%;height: 100%;"/>
                        </c:otherwise>
                      </c:choose>
                    </a>
                    <div class="media-body" style="margin-left: 6.0rem;">
                      <span class="num">x${combo.quantity}</span>
                      <a class="media-tit" href="${webRoot}/wap/citySend/product.ac?productId=${combo.productId}">${combo.name}</a>
                      <c:if test="${not empty combo.specName}">
                        <div class="media-desc">
                          <span style="float: left;margin-right: 0;">规格:</span><div style="margin-left: 3rem;">${combo.specName}</div>
                        </div>
                      </c:if>
                      <c:set value="${combo.productUnitPrice}" var="comboUnitPrice"/>
                      <%
                        Double comboUnitPrice = (Double) pageContext.getAttribute("comboUnitPrice");
                        String comboPriceStr = String.valueOf(comboUnitPrice);
                        String[] comboPrice = comboPriceStr.split("[.]");
                        String comboIntgerPrice = comboPrice[0];
                        String comboDecimalPrice = comboPrice[1];
                        if (StringUtils.isBlank(comboDecimalPrice)) {
                          comboDecimalPrice = "00";
                        } else if (comboDecimalPrice.length() < 2) {
                          comboDecimalPrice += "0";
                        }
                        pageContext.setAttribute("comboIntgerPrice", comboIntgerPrice);
                        pageContext.setAttribute("comboDecimalPrice", comboDecimalPrice);
                      %>
                      <p class="price"><small>¥</small>${comboIntgerPrice}<small>.${comboDecimalPrice}</small></p>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </dd>
          </c:when>
          <%-- 订单赠品 --%>
          <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
            <dd class="media">
              <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                <c:choose>
                  <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                    <%--<img src="${cartItemProxy.productProxy.defaultImage['200X200']}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>--%>
                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="200px" height="200px" style="width: 100%;height: 100%;">
                  </c:when>
                  <c:otherwise>
                    <img src="${noProductPic}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>
                  </c:otherwise>
                </c:choose>
              </a>
              <div class="media-body">
                <span class="num">x${cartItemProxy.quantity}</span>
                <a class="media-tit" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">${cartItemProxy.name}</a>
                <p class="media-desc" style="${not empty cartItemProxy.specName ? 'margin-bottom:1.0rem;' : ''}">[订单赠品]</p>
                <c:if test="${not empty cartItemProxy.specName}">
                  <div class="media-desc">
                    <span style="float: left;margin-right: 0;">规格:</span><div style="margin-left: 3rem;">${cartItemProxy.specName}</div>
                  </div>
                </c:if>
                <c:set value="${cartItemProxy.productUnitPrice}" var="unitPrice"/>
                <%
                  Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                  String priceStr = String.valueOf(unitPrice);
                  String[] price = priceStr.split("[.]");
                  String intgerPrice = price[0];
                  String decimalPrice = price[1];
                  if (StringUtils.isBlank(decimalPrice)) {
                    decimalPrice = "00";
                  } else if (decimalPrice.length() < 2) {
                    decimalPrice += "0";
                  }
                  pageContext.setAttribute("intgerPrice", intgerPrice);
                  pageContext.setAttribute("decimalPrice", decimalPrice);
                %>
                <p class="price"><small>¥</small>${intgerPrice}<small>.${decimalPrice}</small></p>
              </div>
            </dd>
          </c:when>
          <%-- 普通商品 --%>
          <c:otherwise>
            <dd class="media">
              <a class="media-img" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                <c:choose>
                  <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                    <%--<img src="${cartItemProxy.productProxy.defaultImage['200X200']}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>--%>
                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="200px" height="200px" style="width: 100%;height: 100%;">
                  </c:when>
                  <c:otherwise>
                    <img src="${noProductPic}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;"/>
                  </c:otherwise>
                </c:choose>
              </a>
              <div class="media-body">
                <span class="num">x${cartItemProxy.quantity}</span>
                <a class="media-tit" href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">${cartItemProxy.name}</a>
                <c:if test="${fn:length(cartItemProxy.presents) > 0}">
                  <div style="${not empty cartItemProxy.specName ? ' margin-bottom: 1.0rem;' : ''}">
                    <c:forEach items="${cartItemProxy.presents}" var="present" varStatus="p">
                      <p class="media-desc" style="margin-bottom: 0rem;height: 1.8rem;">
                        <span style="float:left;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;max-width: 85%;line-height: 1.8rem;">[赠品] ${present.name}</span>
                        <span style="position: absolute;right: 0;font-size: 1.3rem;color: #666;margin-right: 0;line-height: 1.8rem;">x${present.quantity}</span>
                      </p>
                    </c:forEach>
                  </div>
                </c:if>
                <c:if test="${not empty cartItemProxy.specName}">
                  <div class="media-desc">
                    <span style="float: left;margin-right: 0;">规格:</span><div style="margin-left: 3rem;">${cartItemProxy.specName}</div>
                  </div>
                </c:if>
                <c:set value="${cartItemProxy.productUnitPrice}" var="unitPrice"/>
                <%
                  Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                  String priceStr = String.valueOf(unitPrice);
                  String[] price = priceStr.split("[.]");
                  String intgerPrice = price[0];
                  String decimalPrice = price[1];
                  if (StringUtils.isBlank(decimalPrice)) {
                    decimalPrice = "00";
                  } else if (decimalPrice.length() < 2) {
                    decimalPrice += "0";
                  }
                  pageContext.setAttribute("intgerPrice", intgerPrice);
                  pageContext.setAttribute("decimalPrice", decimalPrice);
                %>
                <p class="price"><small>¥</small>${intgerPrice}<small>.${decimalPrice}</small></p>
              </div>
            </dd>
          </c:otherwise>
        </c:choose>
      </c:if>
    </c:forEach>

    <%--配送方式--%>
    <div class="view-cell">
      <a href="javascript:" id="selectDelivery" cartDeliveryRuleId="${cityCartProxy.deliveryRuleId}">
        <span class="lab">配送方式</span>
        <span class="val text-light">
          <c:if test="${not empty cartDeliveryRule}">
            ${cartDeliveryRule.deliveryRuleNm}
          </c:if>
        </span>
      </a>
    </div>
    <!-- 发票信息，优惠券 -->
    <div class="view-cell" style="margin-bottom: 2rem;padding-right: 1.2rem;">
      <span class="lab" style="line-height: 2.5rem;">发票信息</span>
      <label class="switch" style="float: right;" >
        <input type="checkbox" id="isNeedInvoice">
        <span class="icon"></span>
      </label>
    </div>
    <div class="msg-form" style="display: none;" id="invoiceDiv">
      <span class="lab">发票抬头</span>
      <div class="inp-wrap">
        <input class="inp-txt" type="text" id="invoiceTitle" value="" placeholder="请输入发票抬头" maxlength="64" />
      </div>
    </div>
    <div class="view-cell">
      <a href="javascript:" id="selectCoupon">
        <span class="lab">优惠券</span>
        <span class="val text-light" id="selectCouponTxt">
          <c:choose>
            <c:when test="${not empty usedCoupon}">
              优惠${usedCoupon.amount}元
            </c:when>
            <c:otherwise>
              <c:choose>
                <c:when test="${userCouponListLength > 0}">
                  ${userCouponListLength}张可用
                </c:when>
                <c:otherwise>
                  暂无可用券
                </c:otherwise>
              </c:choose>
            </c:otherwise>
          </c:choose>
        </span>
      </a>
    </div>

    <!-- 买家留言 -->
    <div class="msg-form">
      <span class="lab">买家留言</span>
      <div class="inp-wrap">
        <input class="inp-txt" type="text" value="" placeholder="选填" id="orderRemark" maxlength="255"/>
      </div>
    </div>
    <c:set value="${cityCartProxy.productTotalAmount}" var="productTotalAmount"/>
    <%
      Double productTotalAmount = (Double) pageContext.getAttribute("productTotalAmount");
      String productTotalAmountStr = String.valueOf(productTotalAmount);
      String[] productTotalAmounts = productTotalAmountStr.split("[.]");
      String productTotalAmountIntgerPrice = productTotalAmounts[0];
      String productTotalAmountDecimalPrice = productTotalAmounts[1];
      if (StringUtils.isBlank(productTotalAmountDecimalPrice)) {
        productTotalAmountDecimalPrice = "00";
      } else if (productTotalAmountDecimalPrice.length() < 2) {
        productTotalAmountDecimalPrice += "0";
      }
      pageContext.setAttribute("productTotalAmountIntgerPrice", productTotalAmountIntgerPrice);
      pageContext.setAttribute("productTotalAmountDecimalPrice", productTotalAmountDecimalPrice);
    %>
    <div class="sub-total">共${cityCartNum}件&ensp;合计:&nbsp;<span><small>&yen;</small>${productTotalAmountIntgerPrice}<small>.${productTotalAmountDecimalPrice}</small></span></div>

    <%--<!-- 预存款 -->--%>
    <%--<div class="pre-deposit">--%>
    <%--<span class="lab">使用预存款</span>--%>
    <%--<label class="switch">--%>
    <%--<input type="checkbox" >--%>
    <%--<span class="icon"></span>--%>
    <%--</label>--%>
    <%--<span class="val">-&yen;12.50</span>--%>
    <%--</div>--%>

    <div class="bg-light">
    <ul class="total-detail">
      <li>
        <span class="lab">商品金额</span>
        <span class="val">&yen;${cityCartProxy.productTotalAmount}</span>
      </li>
      <li>
        <span class="lab">运费</span>
        <span class="val">&yen;<em id="freightAmount">${cityCartProxy.freightAmount}</em></span>
      </li>
      <li>
        <span class="lab">促销优惠</span>
        <span class="val">&yen;<em id="discountAmount">${cityCartProxy.discountAmount}</em></span>
      </li>
      <li>
        <span class="lab">赠送积分</span>
        <span class="val"><em id="obtainTotalIntegral">${cityCartProxy.obtainTotalIntegral}</em></span>
      </li>
    </ul>
    <div class="to-addr">
      <p>送至：
        <c:if test="${not empty receiveAddr}">
          ${receiveAddr.addressPath}&nbsp;${receiveAddr.addressStr}
        </c:if>
      </p>
    </div>
    <c:set value="${cityCartProxy.orderTotalAmount}" var="orderTotalAmount"/>
    <%
      Double orderTotalAmount = (Double) pageContext.getAttribute("orderTotalAmount");
      String orderTotalAmountStr = String.valueOf(orderTotalAmount);
      String[] orderTotalAmounts = orderTotalAmountStr.split("[.]");
      String orderTotalAmountIntgerPrice = orderTotalAmounts[0];
      String orderTotalAmountDecimalPrice = orderTotalAmounts[1];
      if (StringUtils.isBlank(orderTotalAmountDecimalPrice)) {
        orderTotalAmountDecimalPrice = "00";
      } else if (orderTotalAmountDecimalPrice.length() < 2) {
        orderTotalAmountDecimalPrice += "0";
      }
      pageContext.setAttribute("orderTotalAmountIntgerPrice", orderTotalAmountIntgerPrice);
      pageContext.setAttribute("orderTotalAmountDecimalPrice", orderTotalAmountDecimalPrice);
    %>
    <div class="total" id="orderTotalAmount">共<em>${cityCartNum}</em>件&ensp;总金额:&nbsp;<span><small>&yen;</small><em class="intgerPrice">${orderTotalAmountIntgerPrice}</em><small class="decimalPrice">.${orderTotalAmountDecimalPrice}</small></span></div>
    <a class="btn-block" href="javascript:" id="submitOrder">提交订单</a>
  </div>
  </dl>
</div>

<!--配送方式弹出层-->
<div class="popup saveDelivery" id="deliveryDiv" style="display: none;">
  <div class="select-layer">
    <div class="mt">配送方式<a class="close" href="javascript:"></a></div>
    <div class="mc">
      <ul>
        <c:forEach items="${deliveryRuleList}" var="rule">
          <li>
            <label class="radioLabel">
                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
              <input type="radio" name="deliveryRuleList" class="hide deliveryRule_${rule.deliveryRule.deliveryRuleId}" value="${rule.deliveryRule.deliveryRuleId}">
              <span class="icon"></span>
            </label>
          </li>
        </c:forEach>
      </ul>
    </div>
    <a href="javascript:void(0);" class="confirm" id="confirmDeliverWay">确定</a>
  </div>
</div>

<!--购物券弹出层-->
<div class="popup saveCoupon" id="couponDiv" style="display:none;">
  <div class="select-layer">
    <div class="mt">购物券<a class="close" href="javascript:"></a></div>
    <div class="mc">
      <ul>
        <c:forEach items="${userCouponList}" var="userCoupon" >
          <li><label class="radioLabel">
            【${userCoupon.amount}元】${userCoupon.couponNum}
            <input type="radio" name="couponList" class="hide coupon_${userCoupon.couponId}" value="${userCoupon.couponId}" amount="${userCoupon.amount}">
            <span class="icon"></span>
          </label></li>
        </c:forEach>
        <li><label class="radioLabel" couponId="0">
          不使用购物券
          <input type="radio" name="couponList" class="hide coupon_0}" value="0">
          <span class="icon"></span>
        </label></li>
      </ul>
    </div>
    <a href="javascript:void(0);" class="confirm" id="confirmCoupon" >确定</a>
  </div>
</div>

<form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
  <input id="submitOrderSourceCode" name="orderSourceCode" value="${isWeixin =='Y'?'4':'3'}" type="hidden"/>
  <input id="submitProcessStatCode" name="processStatCode" value="0" type="hidden"/>
  <input id="submitCarttype" name="type" value="${carttype}" type="hidden"/>
  <input id="submitOrgId" name="sysOrgId" value="${orgId}" type="hidden"/>
  <input id="submitIsCod" name="isCod" value="${isCod}" type="hidden"/>
  <input id="submitIsNeedInvoice" name="invoice.isNeedInvoice" type="hidden"/>
  <input id="submitInvoiceTitle" name="invoice.invoiceTitle" type="hidden" />
  <input id="submitRemark" name="remark" type="hidden"/>
</form>

<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js"></script>
</body>
</html>
