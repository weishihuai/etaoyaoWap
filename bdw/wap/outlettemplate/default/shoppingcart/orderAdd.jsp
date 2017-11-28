<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>提交订单</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js" type="text/javascript"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/md-order.css" rel="stylesheet" media="screen">
</head>
<c:set var="cartType" value="store"/>
<c:set var="handler" value="store"/>
<c:set var="isCod" value="${empty param.isCod ? 'N' : param.isCod}"/>
${sdk:setOutletDeliveryRule(cartType)}
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy(cartType)}"/>
<c:set value="${cartList .selectedReceiverAddrVo}" var="selectedReceiverAddrVo"/>
<body>

<div class="m-top">
    <a href="${webRoot}/wap/outlettemplate/default/shoppingcart/cart.ac?carttype=${cartType}&handler=${handler}" class="back"></a>
    <span>提交订单</span>
</div>
<div class="order-main">
    <c:choose>
        <c:when test="${empty selectedReceiverAddrVo}">
            <div class="no-address">
                <a id="addnewAddress"  class="red_btn">
                    <i class="newaddIco"></i>
                    <span>添加新地址</span>
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="users-info">
                <p><span class="name">${selectedReceiverAddrVo.name}</span><span class="phone">${selectedReceiverAddrVo.mobile}</span><c:if test="${selectedReceiverAddrVo.isDefault eq 'Y'}"><span class="moreng">默认</span></c:if></p>
                <p class="site">${selectedReceiverAddrVo.addressPath}${selectedReceiverAddrVo.addr}</p>
                <a class="dingwei" href="javascript:;"></a>
                <em></em>
            </div>
        </c:otherwise>
    </c:choose>

    <c:forEach items="${cartList.shoppingCartProxyList}" var="cart" >
        <c:set value="${cart.selectedCartItemNum}" var="selectedCartItemNum" />
        <c:if test="${selectedCartItemNum gt 0}">
            <c:set value="${cart.shopInf}" var="shopInf"/>
            <div class="dd p-item">
                <a class="shop-name" href="javascript:;">${shopInf.shopNm}</a>
                <c:forEach items="${cart.cartItemProxyList}" var="item" >
                    <c:if test="${item.itemSelected}">
                        <c:set var="product" value="${item.productProxy}" />
                        <div class="dd-item">
                            <a class="pic" href="${webRoot}/wap/product-${product.productId}.html"><img src="${product.defaultImage['160X160']}"/></a>
                            <a class="name" href="${webRoot}/wap/product-${product.productId}.html">${product.name}</a>
                            <p><span class="price">￥<fmt:formatNumber value="${item.productUnitPrice}" pattern="#0.00#" /></span><span class="number">x${item.quantity}</span></p>
                        </div>
                    </c:if>
                </c:forEach>
                <div class="dd-xiaoji">
                    <c:set value="${sdk:findUserCouponList(cartType, shopInf.sysOrgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
                    <c:set value="${sdk:getCurrSelectCoupons(cartType,shopInf.sysOrgId)}" var="useCoupons"/>     <%--已经选择的购物劵--%>
                    <c:set value="${fn:length(userCouponList) gt 0 || fn:length(useCoupons) gt 0}" var="canUse" />
                    <div data-can-use="${canUse}" data-org-id="${cart.orgId}" class="quan">
                        优惠券
                        <c:if test="${canUse}">
                            <span class="keyong">${fn:length(userCouponList) + fn:length(useCoupons)}张可用</span>
                        </c:if>
                        <c:set value="${cart.totalCouponDiscountAmount}"  var="totalCouponDiscountAmount"/>
                        <span class="span-r">
                       <c:choose>
                           <c:when test="${canUse}">
                               -￥${totalCouponDiscountAmount}
                           </c:when>
                           <c:otherwise>
                               无可用
                           </c:otherwise>
                       </c:choose>
                    </span>
                    </div>
                    <div class="liuyan"><input data-org-id="${cart.orgId}" value="${cart.remark}" class="remark" type="text" maxlength="100" placeholder="对本次交易的说明或要求，限100个字(选填)"><em></em></div>
                    <div class="small-scale">
                        <span>共${selectedCartItemNum}件</span>
                        <span>小计:</span>
                        <span class="price">￥<fmt:formatNumber value="${cart.orderTotalAmount}" pattern="#0.00#" /></span>
                        <span class="yunfei">(含运费:¥<fmt:formatNumber value="${cart.freightAmount}" pattern="#0.00#" />)</span>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <div onclick="javascript:window.location.href='${webRoot}/wap/outlettemplate/default/shoppingcart/invoiceInfo.ac?carttype=${cartType}&handler=${handler}&isCod=${isCod}';" class="order-info">发票信息
        <span class="span-r">${cartList.isNeedInvoice eq 'N' ? '不开发票' : '需要发票'}</span>
    </div>
    <div class="order-info">送达时间<span class="span-r">${cartList.deliveryDay}&nbsp;${cartList.deliveryTimeStr}</span></div>
    <div class="price-operation">
        <p>商品总金额<span>￥<fmt:formatNumber value="${cartList.allProductTotalAmount}" pattern="#0.00#" /></span></p>
        <c:if test="${cartList.allDiscount ne 0}">
            <p>促销优惠<span>￥<fmt:formatNumber value="${cartList.allDiscount}" type="number" pattern="#0.00#" /></span></p>
        </c:if>
        <p>运费<span>￥<fmt:formatNumber value="${cartList.freightTotalAmount}" type="number" pattern="#0.00#" /></span></p>
        <p>赠送积分<span>${cartList.allObtainTotalIntegral}</span></p>
    </div>
    <div class="last-price">
        <p>共${cartList.selectCartNum}件 应付金额<span>￥<fmt:formatNumber value="${cartList.allOrderTotalAmount}" type="number" pattern="#0.00#" /></span></p>
        <a class="submit-order-btn" href="javascript:;">提交订单</a>
    </div>
</div>

<c:set value="${sdk:getDeliveryTimeProxy()}" var="timeProxy"/>
<c:set value="${empty cartList.deliveryDay or cartList.deliveryDay eq timeProxy.today}" var="isToday"/>
<!-- 送达时间 -->
<div style="display: none;" class="sel-time">
    <div class="sel-box">
        <div class="mt"><span>送达时间</span><a href="javascript: $('.sel-time').hide();" class="close"></a></div>
        <div class="mc">
            <div class="mc-lt">
                <c:if test="${fn:length(timeProxy.todayTimeList) gt 0}">
                    <a href="javascript:;" data-type=".today" <c:if test="${empty cartList.deliveryDay or isToday}">class="cur"</c:if>>${timeProxy.today}</a>
                </c:if>
                <a href="javascript:;" <c:if test="${!isToday}">class="cur"</c:if> data-type=".tomorrow">${timeProxy.tomorrow}</a>
            </div>
            <div <c:if test="${!isToday}">style="display: none;"</c:if> class="mc-rt today">
                <c:forEach items="${timeProxy.todayTimeList}" var="t">
                    <a href="javascript:;" <c:if test="${isToday and t eq cartList.deliveryTimeStr}">class="cur"</c:if>>${t}</a>
                </c:forEach>
            </div>
            <div <c:if test="${isToday}">style="display: none;"</c:if> class="mc-rt tomorrow">
                <c:forEach items="${timeProxy.tomorrowTimeList}" var="t">
                    <a href="javascript:;" <c:if test="${!isToday and t eq cartList.deliveryTimeStr}">class="cur"</c:if>>${t}</a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- 选择支付方式 -->
<div id="paymentLoad">

</div>
<form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
    <input name="orderSourceCode" value="${isWeixin eq 'Y' ? '3' : '2'}" type="hidden"/>
    <input name="processStatCode" value="0" type="hidden"/>
    <input name="type" id="type" value="${cartType}" type="hidden"/>
    <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="${cartList.isNeedInvoice}" type="hidden"/>
    <input id="invoiceTitle" value="${cartList.invoiceTitle}" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
    <input id="invoiceTaxPayerNum" value="${cartList.invoiceTaxPayerNum}" name="invoice.invoiceTaxPayerNum" class="invoiceTaxPayerNum" type="hidden" />
    <input name="isCod" value="${isCod}" type="hidden"/>
</form>
</body>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/orderAdd.js"></script>
<script type="text/javascript">
    var webPath = {
                webRoot: '${webRoot}',
                cartType: '${cartType}',
                handler: '${handler}',
                isCod: '${isCod}',
                isSelectAddress: ${not empty cartList.receiveAddrId},
                isDeliveryTimeSelect: ${not empty cartList.deliveryTimeStr}
            }
</script>
</html>
