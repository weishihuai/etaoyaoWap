<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.ShoppingCartProxy" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.UserCartListProxy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<%
    String carttype = (String)pageContext.getAttribute("carttype");
    if(WebContextFactory.getWebContext().getFrontEndUser() != null) {
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
        for (ShoppingCart shoppingCart : userCartList.getCarts()) {
            ResolverUtils.clearCoupon(shoppingCart);
            ResolverUtils.clacCartMisc(shoppingCart);
            /*if(shoppingCart.)*/
        }
        ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);
    }

%>

${sdk:saveOrderParam(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>

<%-- 当选择了物流之后再修改收货地址，导致地区配送不支持的时候，要把选择的物流清空，并让订单金额和商品金额显示设成0 --%>
<%
    UserCartListProxy userCartListProxy = (UserCartListProxy)(pageContext.getAttribute("userCartListProxy"));
    for(ShoppingCartProxy shoppingCartProxy:userCartListProxy.getShoppingCartProxyList()){
        if(shoppingCartProxy.getUnSupportDeliveryCartItemNum() > 0){
            shoppingCartProxy.setDeliveryRuleId(null);
            shoppingCartProxy.setFreightAmount(0d);
            shoppingCartProxy.setOrderTotalAmount(0d);
            //去掉这句setProductTotalAmount对显示没用影响，不过为了以防万一还是加上
            shoppingCartProxy.setProductTotalAmount(0d);
        }
    }
%>

<c:set value="${empty param.isCod || 'Y' != param.isCod ? 'N' : 'Y'}" var="isCod" />

<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telphone=no, email=no" />
    <title>填写订单信息-${webName}</title>
    <%--<link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >--%>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/orderadd.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css" >

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/orderadd.js"></script>

    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>

    <script type="text/javascript">
        var orderData = {isCod:"${isCod}",productTotal:${userCartListProxy.selectCartNum}};
        var webPath = {
            webRoot:"${webRoot}",handler:"${handler}",carttype:"${carttype}"
        };
        /*var allProductsPrice = 0.0;
        var allFreightFee = 0.0;*/
    </script>
</head>

<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=填写订单信息"/>
<%--页头结束--%>

    <!-- 主体 -->
    <div class="main m-order-submit">

        <%-- 地址开始，差点击跳转到修改地址的页面 --%>
        <div class="selectAddr">
            <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
                <c:if test="${receiver.isDefault == 'Y'}">
                    <c:set var="defaultReceiver" value="${receiver}"/>
                </c:if>
            </c:forEach>
            <c:choose>
                <c:when test="${empty defaultReceiver}">
                    <input type="hidden" id="isReceiver" value="false">
                    <div class="entry-block addr mar-btm">
                        <a href="javascript:void(0);">
                            <h3 class="title" style="text-align: center;color: red;font-weight:900;">添加收货地址</h3>
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <input type="hidden" id="isReceiver" value="true">
                    <div class="entry-block addr mar-btm">
                        <a href="javascript:void(0);">
                            <h3 class="title">${defaultReceiver.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${defaultReceiver.mobile}</h3>
                            <p class="content" style="word-break: break-all;">${defaultReceiver.addressPath}&nbsp;${defaultReceiver.addr}</p>
                            <span class="icon-hint"></span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%-- 地址结束，差点击跳转到修改地址的页面 --%>

        <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy" varStatus="shoppingIndex">
            <c:if test="${shoppingCartProxy.selectedCartItemNum>0}">
                <%-- bundle包括一个店的所有信息 --%>
                <div class="bundle">
                    <div class="shop">
                        <span class="shop-img">
                            <img src="${webRoot}/template/bdw/oldWap/statics/images/shop-icon.png" alt="">
                        </span>
                        <a class="shop-tit elli" href="javascript:void(0);">${shoppingCartProxy.shopInf.shopNm}</a>
                    </div>
                    <%-- group包括店里的商品和赠品 --%>
                    <div class="group">
                        <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy" varStatus="s">
                            <c:if test="${cartItemProxy.itemSelected}">
                                <%-- cartItemProxy是普通的商品而不是赠品时使用的样式 --%>
                                <c:choose>
                                    <c:when test="${cartItemProxy.promotionType != 'PRESENT'}">
                                        <div class="item">
                                            <div class="item-detail">
                                                <a class="item-img" href="javascript:void(0);">
                                                    <img src="${cartItemProxy.productProxy.defaultImage["100X100"]}">
                                                </a>
                                                <a class="item-name" href="javascript:void(0);">${cartItemProxy.name}</a>
                                                <c:if test="${not empty cartItemProxy.specName}">
                                                    <p class="item-desc elli">规格:${cartItemProxy.specName}</p>
                                                </c:if>
                                                <div class="item-amount">
                                                    <%--<script>
                                                        <c:if test="${carttype == 'integral'}">
                                                            allProductsPrice = allProductsPrice + ${cartItemProxy.useUnitIntegral} * ${cartItemProxy.quantity};
                                                        </c:if>
                                                        <c:if test="${carttype != 'integral'}">
                                                            allProductsPrice = allProductsPrice + ${cartItemProxy.productUnitPrice} * ${cartItemProxy.quantity};
                                                        </c:if>
                                                    </script>--%>
                                                    <span class="item-price">&yen;&nbsp;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span>
                                                    <span class="item-count">X${cartItemProxy.quantity}</span>
                                                    <%--<br/>--%>
                                                    <%-- 这里计算每个商品的单价X数量   --%>
                                                    <%--<c:set var="totalPrice" value="${carttype=='integral'?cartItemProxy.useUnitIntegral*cartItemProxy.quantity:cartItemProxy.productUnitPrice*cartItemProxy.quantity}"/>
                                                    <span class="item-price" style="/*font-weight:bold;*/ color:red">
                                                        &yen;&nbsp;${totalPrice}
                                                    </span>--%>
                                                </div>
                                            </div>
                                        </div>
                                        <%--单品赠品--%>
                                        <c:if test="${not empty cartItemProxy.presents}">
                                            <c:forEach items="${cartItemProxy.presents}" var="presents">
                                                <div class="gift">
                                                    <em style="color:red">单品赠品</em>
                                                    <a class="elli" href="javascript:void(0);">${presents.name} <c:if test="${not empty presents.specName}">&nbsp;&nbsp;&nbsp;${presents.specName}</c:if></a>
                                                    <span>X${presents.quantity}</span>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </c:when>
                                    <%-- cartItemProxy是赠品(订单满赠)时使用的样式 --%>
                                    <c:when test="${cartItemProxy.promotionType == 'PRESENT'}">
                                        <div class="gift">
                                            <em style="color:red">订单满赠</em>
                                            <a class="elli" href="javascript:void(0);">${cartItemProxy.name} <c:if test="${not empty cartItemProxy.specName}">&nbsp;&nbsp;&nbsp;${cartItemProxy.specName}</c:if></a>
                                            <span>X${cartItemProxy.quantity}</span>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                    </div>

                    <div class="entry-block">
                        <a href="javascript:void(0);">
                            <span class="lab">配送方式</span>
                            <%--<span class="val">
                                <c:set value="${sdk:getDeliveryRuleList(carttype,shoppingCartProxy.orgId ,isCod == 'Y')}" var="deliveryRuleList"/>
                                <select class="saveDelivery sel" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                    <c:choose>
                                        <c:when test="${isCod=='Y'}">
                                            &lt;%&ndash;<option value="0">请选择配送方式</option>&ndash;%&gt;
                                            <c:choose>
                                                <c:when test="${fn:length(deliveryRuleList)>0}">
                                                    <c:forEach items="${deliveryRuleList}" var="rule">
                                                        <c:if test="${rule.deliveryRule.isSupportCod == 'Y'}">
                                                            <option value="${rule.deliveryRule.deliveryRuleId}" <c:if test="${shoppingCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="0">此店铺不支持货到付款</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            &lt;%&ndash;<option value="0">请选择配送方式</option>&ndash;%&gt;
                                            <c:forEach items="${deliveryRuleList}" var="rule">
                                                <c:if test="${!fn:contains(rule.deliveryRuleNm,'货到付款')}">
                                                    <option value="${rule.deliveryRule.deliveryRuleId}" <c:if test="${shoppingCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </span>--%>
                            <span class="val selectDeliverWay" shoppingIndex="${shoppingIndex.index}" id="selectDeliverWay${shoppingIndex.index}">请选择配送方式</span>
                            <span class="icon-hint"></span>
                        </a>
                    </div>

                    <!--配送方式弹出层-->
                    <c:set value="${sdk:getDeliveryRuleList(carttype,shoppingCartProxy.orgId ,isCod == 'Y')}" var="deliveryRuleList"/>
                    <div class="popup saveDelivery" id="saveDelivery${shoppingIndex.index}" shoppingIndex="${shoppingIndex.index}" style="display:none" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                        <div class="select-layer">
                            <c:choose>
                                <c:when test="${fn:length(userCartListProxy.receiverAddrVoByUserId) > 0}">
                                    <div class="mt">配送方式</div>
                                    <div class="mc">
                                            <ul>
                                                    <%--<li><label class="checkbox">
                                                        顺丰快递:￥10.00
                                                        <input type="radio" name="express" checked="" class="hide">
                                                        <span class="icon"></span>
                                                    </label></li>
                                                    <li><label class="checkbox">
                                                        圆通快递:￥8.00
                                                        <input type="radio" name="express" class="hide">
                                                        <span class="icon"></span>
                                                    </label></li>--%>
                                                    <%--<li>
                                                        <label class="checkbox">
                                                            此店铺不支持货到付款
                                                        </label>
                                                    </li>--%>
                                                <c:choose>
                                                    <c:when test="${isCod=='Y'}">
                                                        <c:choose>
                                                            <c:when test="${fn:length(deliveryRuleList)>0 && fn:length(deliveryRuleList)<5}">
                                                                <c:forEach items="${deliveryRuleList}" var="rule" >
                                                                    <c:if test="${rule.deliveryRule.isSupportCod == 'Y'}">
                                                                        <li>
                                                                            <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                    ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                                <c:choose>
                                                                                    <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                        <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <span class="icon"></span>
                                                                            </label>
                                                                        </li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:when test="${fn:length(deliveryRuleList)>4}">
                                                                <c:forEach items="${deliveryRuleList}" var="rule" end="2">
                                                                    <%--<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">--%>
                                                                    <li class="moreDeliverWay1">
                                                                        <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                            <c:choose>
                                                                                <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <span class="icon"></span>
                                                                        </label>
                                                                    </li>
                                                                    <%--</c:if>--%>
                                                                </c:forEach>
                                                                <li id="moreDeliverWays" style="text-align: center;line-height: 45px;"><%--V∨∨∨▽ⅴ--%>︾</li>
                                                                <c:forEach items="${deliveryRuleList}" var="rule" begin="3">
                                                                    <%--<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">--%>
                                                                    <li class="moreDeliverWay" style="display: none;">
                                                                        <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                            <c:choose>
                                                                                <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <span class="icon"></span>
                                                                        </label>
                                                                    </li>
                                                                    <%--</c:if>--%>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li value="${rule.deliveryRule.deliveryRuleId}">
                                                                    <label class="checkbox">
                                                                        本店铺暂未设置支持货到付款的物流方式
                                                                    </label>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${fn:length(deliveryRuleList)>4}">
                                                                <c:forEach items="${deliveryRuleList}" var="rule" end="2">
                                                                    <%--<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">--%>
                                                                    <li class="moreDeliverWay1">
                                                                        <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                            <c:choose>
                                                                                <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <span class="icon"></span>
                                                                        </label>
                                                                    </li>
                                                                    <%--</c:if>--%>
                                                                </c:forEach>
                                                                <li id="moreDeliverWays" style="text-align: center;line-height: 45px;"><%--V∨∨∨▽ⅴ--%>︾</li>
                                                                <c:forEach items="${deliveryRuleList}" var="rule" begin="3">
                                                                    <%--<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">--%>
                                                                    <li class="moreDeliverWay" style="display: none;">
                                                                        <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                            <c:choose>
                                                                                <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <span class="icon"></span>
                                                                        </label>
                                                                    </li>
                                                                    <%--</c:if>--%>
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach items="${deliveryRuleList}" var="rule">
                                                                    <%--<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">--%>
                                                                    <li>
                                                                        <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                            <c:choose>
                                                                                <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <span class="icon"></span>
                                                                        </label>
                                                                    </li>
                                                                    <%--</c:if>--%>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <%--<c:forEach items="${deliveryRuleList}" var="rule">
                                                            &lt;%&ndash;<c:if test="${rule.deliveryRule.isSupportCod != 'Y'}">&ndash;%&gt;
                                                                <li>
                                                                    <label class="checkbox" deliverWayId="${rule.deliveryRule.deliveryRuleId}" deliverWay="${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}">
                                                                                ${rule.deliveryRuleNm}:&yen;${rule.deliveryPrice}
                                                                                <c:choose>
                                                                                    <c:when test="${not empty shoppingCartProxy.deliveryRuleId}">
                                                                                        <input type="radio" name="express${shoppingIndex.index}" class="hide" <c:if test="${rule.deliveryRule.deliveryRuleId == shoppingCartProxy.deliveryRuleId}">checked</c:if> >
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <input type="radio" name="express${shoppingIndex.index}" class="hide">
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                        <span class="icon"></span>
                                                                    </label>
                                                                </li>
                                                            &lt;%&ndash;</c:if>&ndash;%&gt;
                                                        </c:forEach>--%>
                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="mt" style="text-align: center;color: red;font-weight:900;">请先设置收货地址</div>
                                </c:otherwise>
                            </c:choose>
                            <a href="javascript:void(0);" class="confirm confirmDeliver" shoppingIndex="${shoppingIndex.index}"<%--id="confirmDeliverWay"--%>>确定</a>
                        </div>
                    </div>

                    <c:set value="${sdk:findUserCouponList(carttype, shoppingCartProxy.shopInf.sysOrgId)}" var="userCouponList"/>
                    <c:set value="${sdk:getCurrSelectCoupons(carttype,shoppingCartProxy.shopInf.sysOrgId)}" var="useCoupons"/>
                    <c:if test="${fn:length(userCouponList) > 0}">
                        <div class="entry-block">
                            <a href="javascript:void(0);">
                                 <span class="lab">购物券</span>
                                 <span class="mark">${fn:length(userCouponList)}张可用</span>
                                 <span class="val selectCoupon" shoppingIndex="${shoppingIndex.index}" id="selectCoupon${shoppingIndex.index}">请选择购物券</span>
                                       <%--<select class="coupon sel" carttype="${carttype}" orgId='${shoppingCartProxy.shopInf.sysOrgId}'>
                                       <option value="-1">请选择购物券</option>
                                       <option value="0">不使用购物劵</option>
                                       <c:forEach items="${userCouponList}" var="userCoupon">
                                               <option value="${userCoupon.couponId}">【${userCoupon.amount}元】${userCoupon.couponNum}</option>
                                       </c:forEach>
                                       </select>--%>
                                 <span class="icon-hint"></span>
                            </a>
                        </div>
                    </c:if>

                    <!--购物券弹出层-->
                    <div class="popup saveCoupon" id="saveCoupon${shoppingIndex.index}" shoppingIndex="${shoppingIndex.index}" style="display:none" carttype="${carttype}" orgId="${shoppingCartProxy.shopInf.sysOrgId}">
                        <div class="select-layer">
                            <div class="mt">购物券</div>
                            <div class="mc">
                                <ul>
                                    <%--<li><label class="checkbox">
                                        5555WERTYUIDFGHJK
                                        <input type="radio" name="coupon" checked="" class="hide">
                                        <span class="icon"></span>
                                    </label></li>
                                    <li><label class="checkbox">
                                        7777DFGHJKDFGHJKF
                                        <input type="radio" name="coupon" class="hide">
                                        <span class="icon"></span>
                                    </label></li>--%>
                                    <c:forEach items="${userCouponList}" var="userCoupon" >
                                        <li><label class="checkbox" couponAmount="${userCoupon.amount}" couponNm="${userCoupon.couponNum}" couponId="${userCoupon.couponId}">
                                            【${userCoupon.amount}元】${userCoupon.couponNum}
                                            <input type="radio" name="coupon${shoppingIndex.index}" class="hide">
                                            <span class="icon"></span>
                                        </label></li>
                                    </c:forEach>
                                        <li><label class="checkbox" couponId="0">
                                            不使用购物券
                                            <input type="radio" name="coupon${shoppingIndex.index}" class="hide">
                                            <span class="icon"></span>
                                        </label></li>
                                </ul>
                            </div>
                            <a href="javascript:void(0);" class="confirm confirmCoupon" shoppingIndex="${shoppingIndex.index}">确定</a>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label">买家留言</label>
                        <div class="input-group">
                            <input type="text" class="form-control clear-msg" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" placeholder="选填" maxlength="45">
                        </div>
                    </div>
                    <div class="total">
                        <%--<span>运费:&yen;<span class="freightAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.freightAmount}</span></span>
                        <span>&nbsp;&nbsp;优惠:&yen;<span class="discountAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.discountAmount}</span></span>--%>
                        <span>&nbsp;&nbsp;共${shoppingCartProxy.selectedCartItemNum}件商品</span>
                        <span>合计:<em><span class="orderTotalAmout${shoppingCartProxy.orgId}">&yen;${shoppingCartProxy.orderTotalAmount}</span></em></span>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <div class="check-sec">
           <%-- <div class="entry-block">
                <a href="javascript:;">
                    <span class="lab">优惠券</span>
                    <span class="mark">2张可用</span>
                    <span class="val">未使用</span>
                    <span class="icon-hint"></span>
                </a>
            </div>--%>
            <%--<div class="entry-block">
                <a href="javascript:;">
                    <span class="lab">预存款支付</span>
                    <span class="val"><em>已支付：¥10.00</em></span>
                    <span class="icon-hint"></span>
                </a>
            </div>--%>
            <div class="select-box invoice">
                <span class="lab">开具发票</span>
                <label class="switch">
                    <input class="hide" type="checkbox" id="needInvoice" value="N">
                    <span class="invoiceIcon icon"></span>
                </label>
            </div>
            <%--<div class="select-box">
                <span class="lab">类型</span>
                <label class="radio">
                    <input class="hide" type="radio" checked="" name="type">
                    <span class="icon"></span>个人
                </label>
                <label class="radio">
                    <input class="hide" type="radio" name="type">
                    <span class="icon"></span>公司
                </label>
            </div>--%>
            <div class="form-group title-text" style="display: none">
                <label class="control-label">抬头</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="invoice-title" value="" placeholder="请输入抬头内容">
                </div>
            </div>
        </div>

        <div class="checkout-detail">
            <ul class="list">
                <li class="item">
                    <span class="lab">商品金额</span>
                    <span class="val">¥${userCartListProxy.allProductTotalAmount}</span>
                </li>
                <li class="item">
                    <span class="lab">运费</span>
                    <span class="val">¥<span id="freightTotalAmount">${userCartListProxy.freightTotalAmount}</span></span>
                </li>
                <%--<li class="item">
                    <span class="lab">预存款支付</span>
                    <span class="val">-¥30.00</span>
                </li>--%>
                <li class="item allDiscound" style="display:<c:if test="${userCartListProxy.allDiscountAbs == 0}">none</c:if>">
                    <span class="lab">优惠</span>
                    <span class="val">-¥<span id="allDiscount">${userCartListProxy.allDiscountAbs}</span></span>
                </li>
                <%--<li class="item">
                    <span class="lab">使用购物券</span>
                    <span class="val">-¥20.00</span>
                </li>--%>
                <li class="item">
                    <span class="lab">实际付款(含运费)</span>
                    <span class="val"><em>&yen;<span id="totalPrice">${userCartListProxy.allOrderTotalAmount}</span></em></span>
                </li>
            </ul>
        </div>

            <c:if test="${fn:length(userCartListProxy.unSupportDeliveryItemKeys)>0}">
                <div>
                    <div style="background: #fffbe1">
                        <a style="color: #333; font-size: 14px; font-weight: bold; line-height: 51px;">
                            <center><span>以下商品不支持地区配送,不能购买！</span></center>
                        </a>
                    </div>

                    <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                        <c:if test="${shoppingCartProxy.unSupportDeliveryCartItemNum>0}">
                            <div class="bundle">
                                <div class="shop">
                                <span class="shop-img">
                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/shop-icon.png" alt="">
                                </span>
                                    <a class="shop-tit elli" href="javascript:void(0);">${shoppingCartProxy.shopInf.shopNm}</a>
                                </div>
                                <%-- group包括店里的商品和赠品 --%>
                                <div class="group">
                                    <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy" varStatus="s">
                                        <c:if test="${!cartItemProxy.supportDelivery}">
                                            <%-- cartItemProxy是普通的商品而不是赠品时使用的样式 --%>
                                            <c:choose>
                                                <c:when test="${cartItemProxy.promotionType != 'PRESENT'}">
                                                    <div class="item">
                                                        <div class="item-detail">
                                                            <a class="item-img" href="javascript:void(0);">
                                                                <img src="${cartItemProxy.productProxy.defaultImage["100X100"]}">
                                                            </a>
                                                            <a class="item-name" href="javascript:void(0);">${cartItemProxy.name}</a>
                                                            <c:if test="${not empty cartItemProxy.specName}">
                                                                <p class="item-desc elli">规格:${cartItemProxy.specName}</p>
                                                            </c:if>
                                                            <div class="item-amount">
                                                                <span class="item-price">&yen;&nbsp;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span>
                                                                <span class="item-count">X${cartItemProxy.quantity}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--单品赠品--%>
                                                    <c:if test="${not empty cartItemProxy.presents}">
                                                        <c:forEach items="${cartItemProxy.presents}" var="presents">
                                                            <div class="gift">
                                                                <em style="color:red">单品赠品</em>
                                                                <a class="elli" href="javascript:void(0);">${presents.name} <c:if test="${not empty presents.specName}">&nbsp;&nbsp;&nbsp;${presents.specName}</c:if></a>
                                                                <span>X${presents.quantity}</span>
                                                            </div>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:when>
                                                <%-- cartItemProxy是赠品(订单满赠)时使用的样式 --%>
                                                <c:when test="${cartItemProxy.promotionType == 'PRESENT'}">
                                                    <div class="gift">
                                                        <em>赠品</em>
                                                        <a class="elli" href="javascript:void(0);">${cartItemProxy.name} <c:if test="${not empty cartItemProxy.specName}">&nbsp;&nbsp;&nbsp;${cartItemProxy.specName}</c:if></a>
                                                        <span>X${cartItemProxy.quantity}</span>
                                                    </div>
                                                </c:when>
                                            </c:choose>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                </div>
            </c:if>

        <div class="bottom-checkout">
            <button class="action submitOrder" type="button">提交订单</button>
            <span class="sum">合计：<em><small>¥</small><span id="allOrderTotalAmount">${userCartListProxy.allOrderTotalAmount}</span></em></span>
        </div>

        <%-- 点击提交订单时提交的表单 --%>
        <form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
            <input name="orderSourceCode" value="${isWeixin =='Y'?'4':'3'}" type="hidden"/>
            <input name="processStatCode" value="0" type="hidden"/>
            <input name="type" id="type" value="${carttype}" type="hidden"/>
            <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
            <input id="invoiceType" name="invoice.invoiceType" value="0" type="hidden"/>
            <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
            <input name="isCod" value="${isCod}" type="hidden"/>
        </form>


    </div>

</body>

</html>
