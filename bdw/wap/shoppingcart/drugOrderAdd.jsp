<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="utf-8">
    <title>提交预定</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/order.css" type="text/css" rel="stylesheet" />
</head>

<body>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${empty loginUser}">
    <c:redirect url="/wap/login.ac" />
</c:if>
<c:set var="cartType" value="drug"/>
<c:set var="handler" value="drug"/>
<c:set var="cartList" value="${sdk:getUserCartListProxy(cartType)}" />
<c:set var="receiverAddr" value="${cartList.receiverAddrVo}" />
<div class="m-top">
    <a href="javascript:window.location.href='drugCart.ac?carttype='+webPath.cartType+'&handler='+webPath.handler+'&pIndex=cart'"  class="back"></a>
    <span>提交预定</span>
</div>
<div class="order-main">
    <c:choose>
        <c:when test="${empty receiverAddr}">
        <div class="no-address">
            <a id="addnewAddress"  class="red_btn">
                <i class="newaddIco"></i>
                <span>添加新地址</span>
            </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="users-info">
                <p><span class="name">${receiverAddr.name}</span><span class="phone">${receiverAddr.mobile}</span><c:if test="${receiverAddr.isDefault eq 'Y'}"><span class="moreng">默认</span></c:if></p>
                <p class="site">${receiverAddr.addressPath}${receiverAddr.addr}</p>
                <a class="dingwei" href="javascript:;"></a>
                <em></em>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="reserved-phone"><p>请输入手机号码，药师会通知您预定结果</p><input id="callBackTel" maxlength="11" type="number" value="${empty cartList.drugCallBackTel ? loginUser.mobile : cartList.drugCallBackTel}"/></div>
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
                <div data-is-select-d="${not empty cart.deliveryRuleId}" class="peisong">配送方式<span class="span-r">${cart.deliveryRuleNm}</span></div>
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
                <div class="liuyan"><input data-org-id="${cart.orgId}" value="${cart.remark}" class="remark" type="text" placeholder="我要留言(选填)：对本次交易的说明或要求"><em></em></div>
                <div class="small-scale">
                    <span>共${selectedCartItemNum}件</span>
                    <span>小计:</span>
                    <span class="price">￥<fmt:formatNumber value="${cart.orderTotalAmount}" pattern="#0.00#" /></span>
                    <span class="yunfei">(含运费:¥<fmt:formatNumber value="${cart.freightAmount}" pattern="#0.00#" />)</span>
                </div>
            </div>
             <div style="display: none;" class="distribution-layer">
                    <div class="distribution-layer-inner">
                        <div class="dt">配送方式</div>
                        <div class="dd">
                            <c:set value="${sdk:getDeliveryRuleList(cartType, cart.orgId, true)}" var="deliveryRuleList"/>
                            <c:forEach items="${deliveryRuleList}" var="delivery">
                                <p data-rule-id="${delivery.deliveryRule.deliveryRuleId}" <c:if test="${cart.deliveryRuleId eq delivery.deliveryRule.deliveryRuleId}"> data-is-init="true" class="cur" </c:if> >${delivery.deliveryRuleNm}</p>
                            </c:forEach>
                            <a data-org-id="${cart.orgId}" class="distribution-btn" href="javascript:;">确定</a>
                        </div>
                    </div>
                </div>
        </div>
        </c:if>
    </c:forEach>
    <div class="price-operation">
        <p>商品总金额<span>￥<fmt:formatNumber value="${cartList.allProductTotalAmount}" pattern="#0.00#" /></span></p>
        <p>运费<span>￥<fmt:formatNumber value="${cartList.freightTotalAmount}" type="number" pattern="#0.00#" /></span></p>
        <c:if test="${cartList.allDiscount ne 0}">
            <p>促销优惠<span>￥<fmt:formatNumber value="${cartList.allDiscount}" type="number" pattern="#0.00#" /></span></p>
        </c:if>
    </div>
    <div class="last-price">
        <p>共${cartList.selectCartNum}件 预定金额<span>￥<fmt:formatNumber value="${cartList.allOrderTotalAmount}" type="number" pattern="#0.00#" /></span></p>
        <a class="submit-order-btn" href="javascript:;">提交预定</a>
    </div>
</div>

<form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
    <input name="orderSourceCode" value="${isWeixin eq 'Y' ? '3' : '2'}" type="hidden"/>
    <input name="processStatCode" value="0" type="hidden"/>
    <input name="type" id="type" value="${cartType}" type="hidden"/>
    <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
    <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
    <input id="invoiceTaxPayerNum" name="invoice.invoiceTaxPayerNum" class="invoiceTaxPayerNum" type="hidden" />
    <input id="drugCallBackTel" name="drugCallBackTel" value="" type="hidden"/>
</form>
<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/drugOrderAdd.js"></script>
<script type="text/javascript">
    var webPath = {
        webRoot: '${webRoot}',
        cartType: '${cartType}',
        handler: '${handler}',
        isSelectAddress: ${not empty receiverAddr}
    }
</script>
</body>

</html>
