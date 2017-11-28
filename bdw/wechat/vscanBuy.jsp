<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:if test="${empty userProxy}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%
    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
    request.setAttribute("tempContextUrl", tempContextUrl);
%>

<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>

<%--微信配置信息--%>
<c:set value="${weixinSdk:getWinxinConfig()}" var="weixinConfig"/>
<%--初始化购物车 state值即是shopInfId:skuId--%>
<c:if test="${empty param.rd}">
    <c:set value="${weixinSdk:initShoppingCart(param.state, 1)}" var="cartVo"/>
</c:if>
<%--获取资源--%>
<c:set value="wechat" var="authorizedPath"/>
<c:set value="${tempContextUrl}/${authorizedPath}/vscanBuy.ac?showwxpaytitle=1&" var="urlPath"/>
<c:set value="${weixinSdk:getVsanBuyMap(urlPath)}" var="buyMap"/>

<c:set value="${sdk:saveOrderPreferenceToCart(carttype)}" var="isSaveOk"/>
<c:set value="${weixinSdk:getShoppingCartProxy(carttype,param.state)}" var="shoppingCartProxy"/>

<c:set value="${shoppingCartProxy.userOrderPreferenceProxy}" var="preferenceProxy"/>
<c:if test="${empty shoppingCartProxy.cartItemProxyList}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<c:set value="${shoppingCartProxy.cartItemProxyList[0]}" var="cartItemProxy"/>
<c:set value="${cartItemProxy.productProxy}" var="productProxy"/>
<c:set value="${cartItemProxy.supportCod}" var="isSupportCod" />

<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name=apple-mobile-web-app-capable content=yes>
    <meta name=apple-mobile-web-app-status-bar-style content=black>
    <meta name=viewport content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;">
    <meta name=format-detection content="telephone=no, email=no">
    <meta charset=utf-8>
    <title>提交订单</title>

    <link href="${webRoot}/template/bdw/wap/statics/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/wap/statics/css/tjdd2.css" rel="stylesheet" media="screen">
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/common.js"></script>

    <script type="text/javascript">
        var config = {appid: "${weixinConfig.appId}", secret: "${weixinConfig.appSecret}"};
        var webPath = {shopInfId:"${productProxy.shopInfId}",orgId:"${shoppingCartProxy.orgId}", webRoot: "${tempContextUrl}", id: "${param.id}", handler: "${handler}", type: "${carttype}", code: "${param.code}", state: "${param.state}", pageUrl: "${webRoot}/${authorizedPath}/vscanBuy.ac?", authorizedPath:"${authorizedPath}"};
        var responParam = {accessToken: "${buyMap['accessToken']}", openid: "${buyMap['openid']}", addrSign: "${buyMap['addrSign']}", timeStamp: "${buyMap['timeStamp']}", errcode: "${buyMap['errcode']}", errmsg: "${buyMap['errmsg']}"}
    </script>

    <script type="text/javascript" src="${tempContextUrl}/template/bdw/${authorizedPath}/statics/js/vscanBuy.js?version=201411205998"></script>
</head>
<body>
<!--页头-->
<!--中间-->

<form id="orderForm" action="${tempContextUrl}/vScanBuy/addOrder.ac" method="post">

    <input id="receiver" value="N" type="hidden"/><%--收货地址--%>
    <input name="deliveryRuleId" id="deliveryRuleId" value="" type="hidden"/><%--配送方式--%>

    <input name="processStatCode" value="0" type="hidden"/>
    <%--<input name="payWayId" id="payWayId" value="30" type="hidden"/>--%>
    <input name="type" id="type" value="${carttype}" type="hidden"/>
    <input name="periods" id="periods" value="" type="hidden"/>

    <input name="shopInfId" id="shopInfId" value="${productProxy.shopInfId}" type="hidden"/>

    <input type="hidden" name="invoice.invoiceTitle" value="">
    <input type="hidden" name="invoice.isNeedInvoice" value="N"/>
    <input type="hidden" name="invoice.invoiceType" class="invoiceType" value="0"/>
    <input type="hidden" name="invoice.invoiceCont" class="invoiceCont" value=""/>

    <%--地址--%>
    <input id="name" name="name" value="" type="hidden"/>
    <input id="addr" name="addr" value="" type="hidden"/>
    <input id="mobile" name="mobile" value="" type="hidden"/>
    <input id="zipcode" name="zipcode" value="" type="hidden"/>
    <input id="tel" name="tel" value="" type="hidden"/>
    <input id="zoneNm" name="zoneId" value="" type="hidden"/>

    <div class="container tjdd">

        <div class="row row2">
            <div class="col-xs-4 img1">
                <img src="${productProxy.defaultImage["100X100"]}" width="80" height="80"/>
            </div>
            <div class="col-xs-8 row2_r">
                <div class="row">
                    <div class="col-xs-12" style=" height:40px; line-height: 20px; overflow: hidden;">
                        ${cartItemProxy.name}
                    </div>
                    <div class="col-xs-8 pir">微信价：<i>${cartItemProxy.productUnitPrice}</i></div>
                    <div class="col-xs-3">
                        <c:choose>
                            <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                <input style="padding-top:0" type="number" class="form-control con_put" value="${cartItemProxy.quantity}" readonly>
                            </c:when>
                            <c:otherwise>
                                <input remindVal="${cartItemProxy.quantity}" handler="${handler}" itemKey="${cartItemProxy.itemKey}" maxlength="4" type="number" class="form-control con_put cartNum" carttype="${carttype}" value="${cartItemProxy.quantity}">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="row d_rows6" id="actionAddr">
            <div class="addrBox" style="display: none;">
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货信息：</div>
                    <div class="col-xs-9 rows5_right5">
                        <span class="userName"></span>&nbsp;&nbsp;
                        <span class="telNum"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货地址：</div>
                    <div class="col-xs-8 rows5_right5 addrDetail"></div>
                    <div class="col-xs-1"><span style="color:#C5C5C5;" class="glyphicon glyphicon-chevron-right"></span></div>
                </div>
            </div>

            <div class="row defAddrBox"style="line-height: 34px;">
                <div class="col-xs-3 rows5_left5" style="padding-top:0px;padding-left:12px;">收货信息：</div>
                <div class="col-xs-8 rows5_right5" style="padding-top:0px;">
                    请选择收货信息！
                </div>
                <div class="col-xs-1"><span style="color:#C5C5C5;" class="glyphicon glyphicon-chevron-right"></span></div>
            </div>
        </div>


        <div class="row row4">
            <div class="col-xs-3" style="line-height: 34px;">配送方式：</div>
            <div class="col-xs-9">
                <div class="defSelectDelivery" style="padding-top: 8px;">请您先选择收货信息！</div>
                <select class="form-control saveDelivery" id="selectDelivery" style="display: none;">
                    <%--<option>请选择配送方式</option>
                    <c:set var="logisticsDiscountDetailMsg" value="${shoppingCartProxy.logisticsDiscountDetailMsg }"/>
                    <c:forEach items="${shoppingCartProxy.weixinDeliveryRuleFrontEndVoList}" var="rule">
                        <option <c:if test="${preferenceProxy.deliveryRuleId==rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> value="${rule.deliveryRule.deliveryRuleId}">${rule.deliveryRuleNm}</option>
                    </c:forEach>--%>
                </select>
            </div>
        </div>
        <div class="row row5">
            <div class="col-xs-3" style=" font-size:16px; font-weight:bold;">总金额：</div>
            <div class="col-xs-3 m1 orderAmount">￥${shoppingCartProxy.orderTotalAmount}</div>
            <div class="col-xs-6 m2">（含运费<i class="deliveryPrice">￥<fmt:formatNumber value="${shoppingCartProxy.deliveryRule.deliveryPrice}" type="number" pattern="#0.00#" /></i>元）</div>
        </div>
        <div class="row row6" style="margin-top:30px;">
            <div class="col-xs-10 wxp col-xs-push-1"><a href="javascript:" class="btn btn-primary bd_btn btn-block" id="addorder" role="button" payWayId="30" isPayWay="N">微信支付</a></div>
        </div>
        <div class="row row7" style="display: ${isSupportCod?'block':'none'}">
            <div class="col-xs-10 df col-xs-push-1"><a href="javascript:" class="btn btn-primary bd_btn btn-block" id="deliveryOrder" role="button" payWayId="1">货到付款</a></div>
        </div>
        <div class="row row6">
            <div class="col-xs-10 wxp col-xs-push-1"><a href="${tempContextUrl}/wap/index.ac" class="btn btn-primary bd_btn btn-block" id="returnindex" role="button">返回商城</a></div>
        </div>
    </div>
</form>
<input name="orderId" value="" id="orderId" type="hidden"/>
<input name="orderNum" value="" id="orderNum" type="hidden"/>
</body>
</html>
