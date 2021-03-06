<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>填写订单信息-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/addorder_new.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",
            handler:"${handler}",
            carttype:"${carttype}",
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/myAddressBook_new.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/orderadd_new.js"></script>

</head>


<%--${sdk:saveOrderParam(carttype)}--%>
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<body>
<c:set var="topcart" value="${carttype =='normal'?'cart':'drug'}"/>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/cartTop.jsp?p=${topcart}&sta=2"/>
<%--页头结束--%>

<!--主体-->
<div class="main">
    <p class="title">填写并核对订单信息</p>

    <!-- 收货地址 -->
    <div class="shipping-address">
        <div class="dt"><p>收货地址</p><a href="javascript:;" onclick="showAddressWin()" class="shipping-address-btn">新增收货地址</a></div>
        <c:set value="${userCartListProxy.receiverAddrVoByUserId}" var="receiverList"/>
       <%-- <c:forEach items="${receiverList}" var="receiverAdd" varStatus="status">
            <c:if test="${receiverAdd.receiveAddrId == userCartListProxy.receiveAddrId}">
                <div class="dd dd-cur selectAddress" receiveAddrId="${receiverAdd.receiveAddrId}" >
                    <em class="radio "></em>
                    <p class="name">${receiverAdd.name}</p>
                    <p class="phone">${receiverAdd.mobile}</p>
                    <p class="site">${receiverAdd.addressPath}${receiverAdd.addr}</p>
                    <p class="mr-site" style="display:${receiverAdd.isDefault != 'Y'?'none':'block'}">默认地址</p>
                    <div class="operation">
                        <a href="javascript:;" onclick="editAddressWin(${receiverAdd.receiveAddrId});">编辑</a>
                        <a href="javascript:;" onclick="btnDel(${receiverAdd.receiveAddrId});">删除</a>
                    </div>
            </div>
            </c:if>
        </c:forEach>--%>
        <c:forEach items="${receiverList}" var="receiver" varStatus="status">
            <%--<c:if test="${receiver.receiveAddrId != userCartListProxy.receiveAddrId}">--%>
                <div class="dd selectAddress ${receiver.receiveAddrId == userCartListProxy.receiveAddrId ?'dd-cur':''}" receiveAddrId="${receiver.receiveAddrId}" >
                    <em class="radio "></em>
                    <p class="name">${receiver.name}</p>
                    <p class="phone">${receiver.mobile}</p>
                    <p class="site">${receiver.addressPath}${receiver.addr}</p>
                    <p class="mr-site" style="display:${receiver.isDefault != 'Y'?'none':'block'}">默认地址</p>
                    <div class="operation">
                        <a href="javascript:;" onclick="editAddressWin(${receiver.receiveAddrId});">编辑</a>
                        <a href="javascript:;" onclick="btnDel(${receiver.receiveAddrId});">删除</a>
                    </div>
                </div>
          <%--  </c:if>--%>
        </c:forEach>
        <c:if test="${fn:length(receiverList) > 3}">
            <a class="more-address" href="javascript:;">更多收货地址</a>
        </c:if>
    </div>

    <!-- 购买明细 -->
    <div class="buy-info">
        <div class="dt"><p>购买明细</p><a href="${webRoot}/shoppingcart/cart.ac?carttype=${carttype}&handler=${handler}&isCod=${param.isCod}">返回修改购物车</a></div>
        <div class="dd">
            <ul class="tr-head">
                <li class="sp-info">商品信息</li>
                <li class="price">单价（元）</li>
                <li class="number">数量</li>
                <li class="subtotal">小计（元）</li>
            </ul>

            <c:set var="totalFreight" value="0"/>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                <c:if test="${shoppingCartProxy.selectedCartItemNum>0}">
                <c:set var="shopInfo" value="${shoppingCartProxy.shopInf}"/>
                <c:set var="totalFreight" value="${totalFreight + shoppingCartProxy.freightAmount}"/>
                <div class="tr-dp"><p>店铺：<span>${shopInfo.shopNm}</span></p></div>
                    <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                        <c:if test="${cartItemProxy.itemSelected}">
                            <c:set var="productProxy" value="${cartItemProxy.productProxy}"/>
                            <div class="tr-body">
                                <div class="sp-info">
                                    <a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["80X80"]}" alt=""></a>
                                    <p class="name"><a href="${webRoot}/product-${productProxy.productId}.html" class="good-name">${productProxy.name}</a><c:if test="${cartItemProxy.promotionType eq 'PRESENT'}"><span class="order-gift-t">订单赠品</span></c:if></p>
                                    <c:if test="${!empty productProxy.dicValueMap['factory'].valueString}"><p>生产厂家：${productProxy.dicValueMap["factory"].valueString}</p></c:if>
                                    <c:if test="${!empty productProxy.dicValueMap['span'].valueString}"><p>产品规格：${productProxy.dicValueMap["span"].valueString}</p></c:if>
                                </div>
                                <div class="price"><span>¥${cartItemProxy.productUnitPrice}</span></div>
                                <div class="number"><span>${cartItemProxy.quantity}</span></div>
                                <div class="subtotal"><span>¥${cartItemProxy.productTotalAmount}</span></div>
                            </div>
                        </c:if>
                    </c:forEach>

                <!--购物劵 start-->
                <c:set value="${sdk:findUserCouponList(carttype, shopInfo.sysOrgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
                <c:set value="${sdk:getCurrSelectCoupons(carttype,shopInfo.sysOrgId)}" var="useCoupons"/>     <%--已经选择的购物劵--%>
                <div class="tr-coupon">
                    <div class="coupon-title">
                        <em onclick="couponToggleSelect(this)"></em>
                        <c:if test="${!empty useCoupons}"> <p onclick="">优惠券<span>（${fn:length(useCoupons)}）</span></p></c:if>
                        <c:if test="${empty useCoupons}"> <p onclick="">优惠券<span>（${fn:length(userCouponList)}）</span></p></c:if>
                        <a class="link2" href="javascript:;">[立即绑定优惠券]</a>
                        <a class="link1" href="javascript:;">有优惠券兑换码？</a>
                    </div>
                    <ul class="coupon-inner">
                        <c:set var="totalCoupon" value="0" />
                        <c:forEach items="${userCouponList}" var="userCoupon" varStatus="couponIndex">
                                <%--<c:set var="isSelect" value="N" />--%>
                                <c:forEach items="${useCoupons}" var="selectConpon">
                                    <c:if test="${userCoupon.couponId == selectConpon.couponId}">
                                        <%--<c:set var="isSelect" value="Y" />--%>
                                        <c:set var="totalCoupon" value="${totalCoupon +selectConpon.amount }" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${empty useCoupons}">
                                <li>
                                    <label class="checkbox-box"><input type="checkbox" checked="checked"><em orgId="${shoppingCartProxy.orgId}" couponId="${userCoupon.couponId}" onclick="clickCoupon(this)"  data-checked="false"></em></label>
                                    <p class="name">${userCoupon.batchNm}</p>
                                    <p class="mj">${userCoupon.descr}</p>
                                    <p class="price">¥${userCoupon.amount}</p>
                                    <p class="date">有效期：${userCoupon.startTime} 至 ${userCoupon.endTime}</p>
                                </li>
                                </c:if>
                        </c:forEach>
                        <c:if test="${not empty useCoupons}">
                            <c:forEach items="${useCoupons}" var="selectConpon">
                                <li>
                                    <label class="checkbox-box"><input type="checkbox" checked="checked"><em orgId="${shoppingCartProxy.orgId}" couponId="${selectConpon.couponId}" onclick="clickCoupon(this)"  data-checked="true"></em></label>
                                    <p class="name">${selectConpon.batchNm}</p>
                                    <p class="mj">${selectConpon.descr}</p>
                                    <p class="price">¥${selectConpon.amount}</p>
                                    <p class="date">有效期：${selectConpon.startTime} 至 ${selectConpon.endTime}</p>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <div class="ps-way">
                        <p>配送方式：</p>
                        <c:set value="${sdk:getDeliveryRuleList(carttype,shoppingCartProxy.orgId ,isCod)}" var="deliveryRuleList"/>
                        <select class="saveDelivery"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" >
                             <option value="0">请选择配送方式</option>
                             <c:forEach items="${deliveryRuleList}" var="rule">
                                 <option value="${rule.deliveryRule.deliveryRuleId}"  ${shoppingCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId?'selected':''} data-company-id="${rule.deliveryLogisticsCompanyId}" >${rule.deliveryRuleNm}</option>
                             </c:forEach>
                        </select>
                    </div>
                    <div class="message_liuyan">
                        <p>给卖家留言：</p>
                        <input type="text" class="remark" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" maxlength="100" placeholder="填写对本次交易的说明，限100个字">
                    </div>
                </div>
                </c:if>
            </c:forEach>

        </div>
    </div>

    <!-- 发票 -->
    <div class="invoice">
        <div class="invoice-title">发票信息</div>
        <ul class="invoice-cut clearfix">
            <li invoice="N" onclick="selectiNvoice(this);" class="cur"><em class="radio"></em><span>暂不开发票</span></li>
            <li class="editInvoice" style="width: 300px;" invoice="Y" onclick="selectiNvoice(this);" ><em class="radio"></em><span>普通发票</span></li>
        </ul>
        <div class="invoice-title invoiceWin" style="display:none;">发票信息</div>
        <div class="invoice-i invoiceWin" style="display:none;">
            <select>
                <option value="个人">个人</option>
                <option value="公司">公司</option>
            </select>
            <input type="text" placeholder="请输入发票抬头" id="inputInvoiceTitle" name="inputInvoiceTitle" maxlength="50">
            <input type="text" placeholder="请输入发票税号" id="inputInvoiceTaxPayerNum" name="inputInvoiceTaxPayerNum" maxlength="15">
        </div>
        <a style="display:none;" class="btn invoiceWin" href="javascript:;" onclick="saveInvoice();">保存发票</a>
        <div style="display:none;" class="invoice-i editInvoiceWin" >
            <span style="font-weight:bold;">发票抬头：<label id="textInvoiceTitle"></label> </span>
            <span style="padding-left: 15px;font-weight:bold;">发票税号：<label id="textInvoiceTaxPayerNum"> </label></span>
            <span style="padding-left: 15px;"><a href="javascript:;" onclick="selectiNvoice($('.editInvoice'));" style="color: #3388c7;">修改发票</a> </span>
        </div>
    </div>

    <div class="all-price">
        <p>商品总金额：<span>￥<fmt:formatNumber value="${userCartListProxy.allProductTotalAmount}" type="number" pattern="#0.00#" /></span></p>
        <p>运费：<span>¥<fmt:formatNumber value="${totalFreight}" type="number" pattern="#0.00#" /></span></p>
        <c:if test="${userCartListProxy.allDiscount ne 0}">
            <p>已优惠：<span>-￥<fmt:formatNumber value="${userCartListProxy.allDiscountAbs}" type="number" pattern="#0.00#" /></span></p>
        </c:if>
    </div>
    <div class="zf-price">
        <div class="price-number">待支付金额：<span><i>￥</i><fmt:formatNumber value="${userCartListProxy.allOrderTotalAmount}" type="number" pattern="#0.00#" /></span></div>
        <div class="zf-number"><p>可获得积分${userCartListProxy.allObtainTotalIntegral}点</p><a href="javascript:;" class="btn submitOrder">提交订单</a></div>
    </div>
</div>

<form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
    <input name="orderSourceCode" value="0" type="hidden"/>
    <input name="processStatCode" value="0" type="hidden"/>
    <input name="type" id="type" value="${carttype}" type="hidden"/>
    <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
    <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
    <input id="invoiceTaxPayerNum" name="invoice.invoiceTaxPayerNum" class="invoiceTaxPayerNum" type="hidden" />
    <input name="isCod" value="${empty param.isCod ?  'N' : param.isCod}" type="hidden"/>
</form>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
<c:import url="/template/bdw/module/common/addressWin.jsp"/>
<c:import url="/template/bdw/module/common/couponWin.jsp"/>


</body>
</html>
