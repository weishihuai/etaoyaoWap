<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
${sdk:saveOrderParam(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />
<!doctype html>
<html>
<head>
    <title>填写订单信息-${webName}</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/header.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/orderadd20160816.css" rel="stylesheet" media="screen">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/orderadd.js"></script>
    <script type="text/javascript">
        var orderData = {isCod:${isCod},productTotal:${userCartListProxy.selectCartNum}};
        var webPath = {
            webRoot:"${webRoot}",handler:"${handler}",carttype:"${carttype}"
        };
    </script>
</head>
<body>

<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=购物车"/>
<%--页头结束--%>

<%--选择地址 --%>
<div class="row addr">
    <div class="col-xs-12 selectAddr">
        <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
            <c:if test="${receiver.isDefault == 'Y'}">
                <c:set var="defaultReceiver" value="${receiver}"/>
            </c:if>
        </c:forEach>
        <c:choose>
            <c:when test="${empty defaultReceiver}">
                <input type="hidden" id="isReceiver" value="false">
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货地址：</div>
                    <div class="col-xs-8 rows5_right5">添加新地址</div>
                    <div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right pull-right" style="margin-right:8px;"></span></div>
                </div>
            </c:when>
            <c:otherwise>
                <input type="hidden" id="isReceiver" value="true">
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货信息：</div>
                    <div class="col-xs-9 rows5_right5">${defaultReceiver.name}  &nbsp;${defaultReceiver.mobile}&nbsp;${defaultReceiver.tel}</div>
                </div>
                <div class="row">
                    <div class="col-xs-3 rows5_left5">收货地址：</div>
                    <div class="col-xs-8 rows5_right5">${defaultReceiver.addressPath}&nbsp;${defaultReceiver.addr}</div>
                    <div class="col-xs-1"><span class="glyphicon glyphicon-chevron-right pull-right" style="margin-right:8px;"></span></div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>
<%--选择地址 --%>

<div class="row main">
    <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
        <c:if test="${shoppingCartProxy.selectedCartItemNum>0}">
            <div class="col-xs-12 pay-goods">
                <div class="row g-title shops" data-toggle="collapse" >
                    <div class="col-xs-11 t-left">
                        <span>店铺：<i>${shoppingCartProxy.shopInf.shopNm}</i>（${shoppingCartProxy.selectedCartItemNum}）</span>
                    </div>
                        <%-- <div class="col-xs-4 t-right"><a href="#">全部收起</a></div>--%>
                    <div  class="col-xs-1">
                        <span style="margin-right:22px;margin-top:18px;" class="glyphicon glyphicon-chevron-down pull-right"></span>
                        <span style="margin-right:22px;margin-top:18px;display:none;" class="glyphicon glyphicon-chevron-up pull-right"></span>
                    </div>
                </div>
                <div style="background: none repeat scroll 0% 0% rgb(220, 221, 221); height: auto;" class="in shop">
                    <div class="row sy_rows" style="border:#ddd 5px solid; padding:10px 15px; border-radius:10px; background:#fff;margin-top:0;">
                        <div class="row g-main">
                            <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy" varStatus="s">
                                <c:if test="${cartItemProxy.itemSelected}">
                                    <div class="col-xs-12 gm-box <c:if test="${s.last}">no-bb</c:if>">
                                        <div class="col-xs-5"><a href="#"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="100" height="100" /></a></div>
                                        <div class="col-xs-7 box-right">
                                            <div class="col-xs-12 gm-title" ><c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>${cartItemProxy.name} <c:if test="${not empty cartItemProxy.specName}">规格：${cartItemProxy.specName}</c:if></div>
                                            <div class="col-xs-6 gm-num">数量：X${cartItemProxy.quantity}</div>
                                            <div class="col-xs-6 gm-pri">￥${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                                <%--           <div class="col-xs-12 zp">
                                               <div class="col-xs-3 zp-icon"><span>赠品</span></div>
                                               <div class="col-xs-7 zp-title">新肌遇兰芝热剧同款明星热荐丝润盈彩唇新品好用<span>X<i>1</i></span></div>
                                               <div class="col-xs-2 zp-del"><a href="#"><img src="../images/wsc_byc_icon04.png" width="22" height="22" /></a></div>
                                           </div>--%>
                        </div>
                        <div class="row g-bot">
                            <div class="col-xs-12 sp-me">
                                <em>配送方式：</em>
                                <c:set value="${sdk:getDeliveryRuleList(carttype,shoppingCartProxy.orgId ,isCod)}" var="deliveryRuleList"/>
                                <select class="saveDelivery"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                    <option value="0">请选择配送方式</option>
                                    <c:forEach items="${deliveryRuleList}" var="rule">
                                        <option value="${rule.deliveryRule.deliveryRuleId}" <c:if test="${shoppingCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}</option>
                                    </c:forEach>
                                </select>
                                <div class="operationMsg">
                                    <c:if test="${isCod && fn:length(deliveryRuleList) == 0}">
                                        <span>暂无货到付款配送方式</span>
                                    </c:if>
                                </div>
                            </div>

                            <c:set value="${sdk:findUserCouponList(carttype, shoppingCartProxy.shopInf.sysOrgId)}" var="userCouponList"/>
                            <c:set value="${sdk:getCurrSelectCoupons(carttype,shoppingCartProxy.shopInf.sysOrgId)}" var="useCoupons"/>
                            <div class="col-xs-12 sp-me userPlatformCoupon" id="userPlatformCoupon${shoppingCartProxy.shopInf.sysOrgId}">
                                <em>优惠券：</em>
                                <select class="coupon" carttype="${carttype}" orgId='${shoppingCartProxy.shopInf.sysOrgId}'>
                                    <option value="-1">请选择购物券...</option>
                                    <option value="0">不使用购物劵</option>
                                    <c:forEach items="${userCouponList}" var="userCoupon">
                                        <option value="${userCoupon.couponId}">【${userCoupon.amount}元】${userCoupon.couponNum}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-xs-12" id="useCoupons${shoppingCartProxy.shopInf.sysOrgId}">
                                <c:if test="${not empty useCoupons}">
                                    <ul class="list-unstyled">
                                        <c:forEach items="${useCoupons}" var="useCoupon">
                                            <li style="float:left;background:#61B80D;text-align:center;height:20px;line-height:20px;border-radius:2px;margin:5px;">
                                                <a style="color:#FFF;" href="javascript:" title="${useCoupon.couponNum}">
                                                    ${sdk:cutString(useCoupon.couponNum,40,'')}【${useCoupon.amount}元】
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </div>

                            <div class="col-xs-12 leave-msg"><textarea carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" rows="1" style="color:#999;" class="clear-msg" placeholder="备注内容"></textarea></div>
                            <div class="row">
                                <div class="col-xs-4 g-total">优惠：<em class="discountAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.discountAmount}</em>元</div>
                                <div class="col-xs-3 g-total">运费：<em class="freightAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.freightAmount}</em>元</div>
                                <div class="col-xs-5 g-total">合计：<i class="orderTotalAmout${shoppingCartProxy.orgId}">￥${shoppingCartProxy.orderTotalAmount}</i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <div class="col-xs-12 fp">
        <input class="invoice-radio" type="radio" name="needInvoice" checked="" value="N"/>不开具发票
        <input class="invoice-radio" type="radio" name="needInvoice" value="Y"/>开具发票
        <div class="invoiceTitle title-text"><textarea carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" id="invoice-title" name="invoiceTitle" rows="1" style="color:#999;" class="invoiceTitle" placeholder="发票抬头"></textarea></div>
    </div>

    <div class="col-xs-12 submit">
        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
        <em>实付款：<i id="allOrderTotalAmount">￥${userCartListProxy.allOrderTotalAmount}</i></em>
        <a href="javascript:" class="submitOrder">提交订单</a>
    </div>
    <form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
        <input name="orderSourceCode" value="${isWeixin =='Y'?'4':'3'}" type="hidden"/>
        <input name="processStatCode" value="0" type="hidden"/>
        <input name="type" id="type" value="${carttype}" type="hidden"/>
        <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
        <input id="invoiceType" name="invoice.invoiceType" value="0" type="hidden"/>
        <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
        <input name="isCod" value="${empty param.isCod ?  'N' : param.isCod}" type="hidden"/>
    </form>


    <c:if test="${fn:length(userCartListProxy.unSupportDeliveryItemKeys)>0}">
        <div class="row">
            <div class="col-xs-12 reason" style="background: #fffbe1 none repeat scroll 0 0;">
                <a style="color: #333; font-size: 14px; font-weight: bold; line-height: 51px; margin-left: 10px;">
                    以下商品不支持地区配送,不能购买！</a></div>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                <c:if test="${shoppingCartProxy.unSupportDeliveryCartItemNum>0}">
                    <div class="col-xs-12 pay-goods">
                        <div class="row g-title shops" data-toggle="collapse" >
                            <div class="col-xs-11 t-left">
                                <span>店铺：<i>${shoppingCartProxy.shopInf.shopNm}</i>（${shoppingCartProxy.selectedCartItemNum}）</span>
                            </div>
                                <%-- <div class="col-xs-4 t-right"><a href="#">全部收起</a></div>--%>
                            <div  class="col-xs-1">
                                <span style="margin-right:22px;margin-top:18px;" class="glyphicon glyphicon-chevron-down pull-right"></span>
                                <span style="margin-right:22px;margin-top:18px;display:none;" class="glyphicon glyphicon-chevron-up pull-right"></span>
                            </div>
                        </div>
                        <div style="background: none repeat scroll 0% 0% rgb(220, 221, 221); height: auto;" class="in shop">
                            <div class="row sy_rows" style="border:#ddd 5px solid; padding:10px 15px; border-radius:10px; background:#fff;margin-top:0;">
                                <div class="row g-main">
                                    <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy" varStatus="s">
                                        <c:if test="${!cartItemProxy.supportDelivery}">
                                            <div class="col-xs-12 gm-box <c:if test="${s.last}">no-bb</c:if>">
                                                <div class="col-xs-5"><a href="#"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="100" height="100" /></a></div>
                                                <div class="col-xs-7 box-right">
                                                    <div class="col-xs-12 gm-title" ><c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>${cartItemProxy.name} <c:if test="${not empty cartItemProxy.specName}">规格：${cartItemProxy.specName}</c:if></div>
                                                    <div class="col-xs-6 gm-num">数量：X${cartItemProxy.quantity}</div>
                                                    <div class="col-xs-6 gm-pri">￥${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                        <%--           <div class="col-xs-12 zp">
                                                       <div class="col-xs-3 zp-icon"><span>赠品</span></div>
                                                       <div class="col-xs-7 zp-title">新肌遇兰芝热剧同款明星热荐丝润盈彩唇新品好用<span>X<i>1</i></span></div>
                                                       <div class="col-xs-2 zp-del"><a href="#"><img src="../images/wsc_byc_icon04.png" width="22" height="22" /></a></div>
                                                   </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </c:if>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>

</body>
</html>
