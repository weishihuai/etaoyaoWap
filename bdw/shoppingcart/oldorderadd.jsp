<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>填写订单信息-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/css/redmond/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.form.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery.ld.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/orderadd.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidator-4.1.1.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/formValidatorRegex.js"></script>
    <script language="javascript" type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=IMSBZ-M7ZWU-HCVV7-4FRXE-ESSDS-3OFKL"></script>
    <style type="text/css">
        /*自提点样式*/
        .pickedUpListDiv{border-bottom: 1px solid #e5e5e5; background-color: #fff; padding: 5px 0;}
    </style>
    <!--购物劵使用 start-->
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-ui-1.8.13/js/jquery-ui-1.8.13.custom.min.js"></script>
    <!--购物劵使用 end-->

</head>

<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<%
    //当商品在做活动的时候,如果此时将活动商品下架或者时间不是正在进行中，价格不会变化，但是加上该代码对系统的性能有比较大的影响.
    String carttype = (String)pageContext.getAttribute("carttype");
    Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
    if(loginUserId != null){
        if(CartTypeEnum.NORMAL.toCode().equals(carttype)){
            UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
            ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
            ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.NORMAL.toCode());
        }
    }

%>
${sdk:saveOrderParam(carttype)}
<%--检查购物车配送 优先放在取出购物车之前--%>
${sdk:checkCartDelivery(carttype)}
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<c:set value="${empty param.isCod ? 'N' : param.isCod}" var="isCodStr" />
<c:set value="${isCodStr=='N' ? false :true}" var="isCod" />

<script type="text/javascript">
    var orderData = {isCod:${isCod},productTotal:${userCartListProxy.selectCartNum}};
    var invalidCartItems = [];

    var citylocation,map,marker = null;
    <c:forEach items="${userCartListProxy.unSupportDeliveryItemKeys}" var="invalidItemKey" varStatus="s">
    invalidCartItems[${s.index}] = "${invalidItemKey}";
    </c:forEach>
</script>

<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>

<div id="orderAdd" style="margin-top:20px;">
    <ul class="nav">
        <li class="look done"><span>1.查看购物车</span></li>
        <li class="cur"><span>2.填写订单信息</span></li>
        <li><span><c:choose><c:when test="${empty param.isCod || param.isCod=='N'}">3.付款到收银台</c:when><c:otherwise>3.确认货到付款订单信息</c:otherwise></c:choose></span></li>
        <li class="last"><span>4.收货评价</span></li>
    </ul><div class="clear"></div>
    <div class="address">
        <div class="layer">
            <p><a style="text-decoration: none;">确认收货信息</a></p>
            <h3><a target="_blank" href="${webRoot}/module/member/myAddressBook.ac?pitchOnRow=2"><span>管理收货地址</span></a></h3>
        </div>
        <c:forEach items="${userCartListProxy.receiverAddrVoByUserId}" var="receiver" varStatus="status">
            <ul class="selectAddress <c:if test="${receiver.isDefault == 'Y'}">cur</c:if>" receiveAddrId="${receiver.receiveAddrId}">
                <li><c:if test="${receiver.isDefault == 'Y'}"><a style="text-decoration: none;">默认地址</a></c:if></li>
                <p>${receiver.addressPath}( ${receiver.name} 收 )</p>
                <h2>${receiver.addr}<span>联系方式：${receiver.mobile}<c:if test="${not empty receiver.tel}">/${receiver.tel}</c:if></span></h2>
            </ul>
        </c:forEach>


        <div class="clear"></div>
        <div class="btn">
            <p><a href="javascript:" id="addAddress">使用新地址</a></p>
            <p <c:if test="${handler eq 'groupBuy'}">style="display: none;"</c:if>><a href="${webRoot}/shoppingcart/cart.ac?carttype=${carttype}&handler=${handler}&isCod=${param.isCod}">返回购物车</a></p>
        </div><div class="clear"></div>
    </div>

    <form id="orderForm" action="${webRoot}/cart/addOrder.ac" method="get">
        <input name="orderSourceCode" value="0" type="hidden"/>
        <input name="processStatCode" value="0" type="hidden"/>
        <input name="type" id="type" value="${carttype}" type="hidden"/>
        <input id="isNeedInvoice" name="invoice.isNeedInvoice" value="N" type="hidden"/>
        <input id="invoiceTitle" name="invoice.invoiceTitle" class="invoiceTitle" type="hidden" />
        <input name="isCod" value="${empty param.isCod ?  'N' : param.isCod}" type="hidden"/>

        <%--自提点--%>
        <input name="pickUpId" id="pickUpId" value="" type="hidden"/>

    </form>

    <%--自提中心列表 start--%>
    <div class="layer pickedUpDiv" style="width: 978px;display:none;">
        <span style="display: block; font-size: 14px; line-height: 35px; font-weight: bold; padding-left: 10px; color: #333;">自提点</span>
        <div  style="width: 978px; border: 1px solid #e5e5e5;">
            <div class="l_addr pickedUpListDiv">
                <%--这里是通过JS拼装出来的--%>
            </div>
            <div class="l_tips" style="background-color: #fff8d9; width: 978px; color: #333; overflow: hidden; padding: 10px 0;">
                <span style="float: left; line-height: 25px; padding: 0 10px;">注:</span>
                <p style="width: 920px; line-height: 25px; float: left;">
                    <c:set value="${sdk:getSysParamValue('pickedup_info')}" var="pickedup_info"/>
                    ${pickedup_info}
                </p>
            </div>
        </div>
        <%--<p style="background: url('${webRoot}/template/bdw/statics/images/btn.png') no-repeat;height: 25px;margin: 10px 10px 10px 0;text-align: center;width: 95px;">
            <a href="javascript:;" style="line-height: 25px; font-weight: bold; color: #666;">确认订单信息</a>
        </p>--%>
    </div>
    <%--自提中心列表 end--%>

<%--    <div class="layer">
        <p><a style="text-decoration: none;">确认订单信息</a></p>
    </div>--%>


    <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
        <c:if test="${shoppingCartProxy.selectedCartItemNum>0}">
            <div class="order">

                <div class="nav">
                    <div class="shop"><span>店铺商品</span></div>
                    <div class="num" style="width: 145px"><span>数量</span></div>
                    <div class="price" style="width: 141px"><span>单价</span></div>
                    <div class="subtotal" style="width:220px;"><span>小计</span></div>
                    <%--<div class="operation"><span>配送方式</span></div>--%>
                </div>
                <div class="box">
                    <ul class="discount">
                        <div class="discount-l">
                            <img src="${webRoot}/template/bdw/statics/images/96.png" style="vertical-align:middle"/>
                            <a style="text-decoration: none;" href="${webRoot}/shopTemplate/default/shopIndex.ac?shopId=${shoppingCartProxy.shopInf.shopInfId}">${shoppingCartProxy.shopInf.shopNm}</a>
                            <c:set value="${sdk:getShopInfProxyById(shoppingCartProxy.shopInf.shopInfId).csadInfList}" var="csadInfList"/>

                            <c:choose>
                                <c:when test="${not empty shoppingCartProxy.shopInf.companyQqUrl}">
                                    <a href="${shoppingCartProxy.shopInf.companyQqUrl}" target="_blank"><img src="${webRoot}/template/bdw/statics/images/qq.png"/></a>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${csadInfList}" var="caadInf" end="0">
                                        <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${caadInf}&amp;site=qq&amp;menu=yes" target="_blank"><img src="${webRoot}/template/bdw/statics/images/qq.png"/></a>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <div class="discount-r shopDiscountMsg${shoppingCartProxy.shopInf.sysOrgId}">
                            <a style="text-decoration: none;"><span>店铺优惠：</span><c:forEach items="${shoppingCartProxy.discountDetails}" var="discount">${discount.amountNm},</c:forEach></a>
                        </div>
                    </ul>
                    <div class="clear"></div>


                    <div class="info">
                        <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                            <c:if test="${cartItemProxy.itemSelected}">
                                <div class="left" style="width: 980px">
                                    <ul>
                                            <h2 style="position: relative;"<c:if test="${cartItemProxy.promotionType=='PRESENT'}">style="margin-left:42px;"</c:if>>
                                                    <%--判断是否是京东商品--%>
                                                <c:choose>
                                                <c:when test="${cartItemProxy.productProxy.jdProductCode != null}">
                                                <div style="position:absolute;z-index:5;width: 24px;left: 22px;top: -1px;border-radius:4px;border:#dbe0cb 1px solid;padding:3px;background-color:#ffa800;">京东</div>
                                                <a href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                    <img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></a></h2>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                    <img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></a></h2>
                                            </c:otherwise>
                                            </c:choose>
                                        <li>
                                            <h3><a href="${webRoot}/product-${cartItemProxy.productId}.html"><c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if> <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}<c:if test="${not empty cartItemProxy.specName}">（${cartItemProxy.specName})</c:if></a></h3>
                                            <c:forEach items="${cartItemProxy.presents}" var="present">
                                                <h4><a style="text-decoration: none;"><span>赠品：</span>${present.name}<em>X ${present.quantity}</em></a></h4>
                                            </c:forEach>
                                            <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                <h4><a href="${webRoot}/product-${combo.productId}.html"><%--<span>套餐：</span>--%>${combo.name}</a></h4>
                                            </c:forEach>
                                        </li>
                                    </ul>
                                    <div class="num" style="margin-left: 10px;width: 131px"><a style="text-decoration: none;">${cartItemProxy.quantity}</a></div>
                                    <div class="price" style="width: 147px"><a style="text-decoration: none;">${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</a></div>
                                    <div class="subtotal" style="width: 213px"><a style="text-decoration: none;">${carttype=="integral" ?  "" : "￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</a></div>
                                </div>
                            </c:if>
                        </c:forEach>

                    </div>

                    <!--购物劵 start-->
                    <c:set value="${sdk:findUserCouponList(carttype, shoppingCartProxy.shopInf.sysOrgId)}" var="userCouponList"/> <%--可以使用的购物劵--%>
                    <c:set value="${sdk:getCurrSelectCoupons(carttype,shoppingCartProxy.shopInf.sysOrgId)}" var="useCoupons"/> <%--已经选择的购物劵--%>

                    <div class="info" style="border-top: 1px dashed #80B2FF;">
                        <div style="line-height:36px; margin-left:19px; font-weight:bold; color: #cc0000; margin-top:2px;">
                            <div class="">
                                选择使用的配送方式：
                                <c:set value="${sdk:getDeliveryRuleList(carttype,shoppingCartProxy.orgId ,isCod)}" var="deliveryRuleList"/>
                                <select class="saveDelivery"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" style="border: 1px solid #cccccc; height: 28px">
                                    <option value="0">请选择配送方式</option>
                                    <c:forEach items="${deliveryRuleList}" var="rule">
                                        <option value="${rule.deliveryRule.deliveryRuleId}" data-company-id="${rule.deliveryLogisticsCompanyId}"
                                                <c:if test="${shoppingCartProxy.deliveryRuleId == rule.deliveryRule.deliveryRuleId}">selected="selected"</c:if> >${rule.deliveryRuleNm}</option>
                                    </c:forEach>
                                </select>

                                <div class="operationMsg">
                                    <c:if test="${isCod && fn:length(deliveryRuleList) == 0}">
                                        <span>暂无货到付款配送方式</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="info" style="border-top: 1px dashed #80B2FF;">
                        <div style="line-height:30px; margin-left:19px; font-weight:bold; color: #cc0000; margin-top:5px;">
                            <div style="float:left;font-weight:bold;">
                                选择要使用的购物劵：
                            </div>
                            <div style="float:left;margin-left:3px;" id="userPlatformCoupon${shoppingCartProxy.shopInf.sysOrgId}" class="userPlatformCoupon" orgId="${shoppingCartProxy.shopInf.sysOrgId}">
                                <select name="couponIds" class="coupon put couponIds" style="border: 1px solid #cccccc; height: 28px; margin-bottom: 5px" carttype="${carttype}" orgId='${shoppingCartProxy.shopInf.sysOrgId}'>
                                    <option value="-1">暂无购物券可用</option>
                                    <%--<option value="0">不使用购物劵</option>--%>
                                    <c:forEach items="${userCouponList}" var="userCoupon" varStatus="couponIndex">
                                        <c:if test="${empty useCoupons}"><%--已经选择的其他可用券都不显示--%>
                                            <c:choose>
                                                <c:when test="${couponIndex.first}">
                                                    <option  selected="true" value="${userCoupon.couponId}">${userCoupon.batchNm}【${userCoupon.amount}元】</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${userCoupon.couponId}">${userCoupon.batchNm}【${userCoupon.amount}元】</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div style="margin-left: 19px;margin-bottom: 10px;width:950px;" id="useCoupons${shoppingCartProxy.shopInf.sysOrgId}">
                            <c:if test="${not empty useCoupons}">
                                <div style="float:left;font-weight:bold;margin-top:5px;margin-left:5px;">
                                    使用的购物劵：
                                </div>
                                <ul>
                                    <c:forEach items="${useCoupons}" var="useCoupon">
                                        <li style="float:left;background:#61B80D;text-align:center;height:20px;line-height:20px;border-radius:2px;margin:5px;margin-left:0px;">
                                            <a style="color:#FFF;" href="javascript:" title="${useCoupon.couponNum}">${sdk:cutString(useCoupon.couponNum,40,'')}【${useCoupon.amount}元】</a>
                                            <%--<a class="cancelUseCoupon cp1${shoppingCartProxy.shopInf.sysOrgId}" style="float:right;font-weight:bold;font-size:16px;width:20px;background:#EEBD11;color:#FFF;" href="javascript:" couponId="${useCoupon.couponId}"  carttype="${carttype}" orgId="${shoppingCartProxy.shopInf.sysOrgId}">X</a>--%>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </div>
                    <!--购物劵 end-->


                    <div class="message">
                        <div class="message-r">
                            <a style="text-decoration: none;">赠送积分总计：<span class="integral${shoppingCartProxy.orgId}">${shoppingCartProxy.obtainTotalIntegral}</span></a>
                            <a style="text-decoration: none;">促销优惠：<em class="discountAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.discountAmount}</em>元</a>
                            <a style="text-decoration: none;">运费：<em class="freightAmount${shoppingCartProxy.orgId}">${shoppingCartProxy.freightAmount}</em>元</a>
                            <a style="text-decoration: none;">店铺合计（含运费）：<strong class="orderTotalAmout${shoppingCartProxy.orgId}">${shoppingCartProxy.orderTotalAmount}</strong></a>
                        </div>
                        <div class="message-l">给卖家留言：<input class="text remark" type="text" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" maxlength="45"/></div>
                    </div>
                </div>


            </div>
        </c:if>
    </c:forEach>
    <div class="submit">
        <div class="return" <c:if test="${handler eq 'groupBuy'}">style="display: none;"</c:if>><a href="${webRoot}/shoppingcart/cart.ac?carttype=${carttype}&handler=${handler}&isCod=${param.isCod}"><img src="${webRoot}/template/bdw/statics/images/102.PNG" style="vertical-align:middle"/>返回购物车</a></div>
        <ul>
            <div style="height: 30px;">
                <div style="float: left;margin-left: 25px;margin-top: 10px">
                    <label> 发票：</label>
                    <span id="invoiceCont"></span>
                    <a href="javascript:void(0);" id="editInvoiceBtn" style="color: #2652A5;"> [编辑] </a>
                </div>
            </div>
            <p><a style="text-decoration: none;">商品件数总计：${userCartListProxy.selectCartNum}</a><a style="text-decoration: none;">赠送积分总计：${userCartListProxy.allObtainTotalIntegral}</a><a style="text-decoration: none;">促销优惠：${userCartListProxy.allDiscount}元</a><a style="text-decoration: none;">实付款：<span id="allOrderTotalAmount">${userCartListProxy.allOrderTotalAmount}</span>元</a></p>
            <div class="btn"><a class="submitOrder" style="text-decoration: none;"  href="javascript:">提交订单</a></div>
        </ul><div class="clear"></div>
    </div>

    <c:if test="${fn:length(userCartListProxy.unSupportDeliveryItemKeys)>0}">
        <div class="reason"><a>以下商品已不能购买，请查看不能购买该商品的原因，或重新购买！</a></div>
        <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
            <c:if test="${shoppingCartProxy.unSupportDeliveryCartItemNum>0}">
                <div class="order">
                    <div class="nav">
                        <div class="shop"><span>店铺商品</span></div>
                        <div class="num"><span>数量</span></div>
                        <div class="price"><span>单价</span></div>
                        <div class="subtotal"><span>小计</span></div>
                        <div class="operation"><span>配送方式</span></div>
                    </div>
                    <div class="box">
                        <ul  class="discount bg border">
                            <div class="discount-l">
                                <img style="vertical-align:middle" src="${webRoot}/template/bdw/statics/images/96.png">
                                <a style="text-decoration: none;">${shoppingCartProxy.shopInf.shopNm}</a>
                                <img style="vertical-align:middle" src="${webRoot}/template/bdw/statics/images/49.gif">
                            </div>
                        </ul><div class="clear"></div>
                        <div class="info bg">
                            <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                                <c:if test="${!cartItemProxy.supportDelivery}">
                                    <div class="left">
                                        <ul style="margin-top: 20px">
                                            <h2><a href="${webRoot}/product-${cartItemProxy.productId}.html"><img src="${cartItemProxy.productProxy.defaultImage["50X50"]}"></a></h2>
                                            <li>
                                                <h3><a href="${webRoot}/product-${cartItemProxy.productId}.html"><c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if> <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}<c:if test="${not empty cartItemProxy.specName}">（${cartItemProxy.specName})</c:if></a></h3>
                                                <c:forEach items="${cartItemProxy.presents}" var="present">
                                                    <h4><a style="text-decoration: none;"><span>赠品：</span>${present.name}<em>X ${present.quantity}</em></a></h4>
                                                </c:forEach>
                                                <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                    <h4><a href="${webRoot}/product-${combo.productId}.html"><%--<span>套餐：</span>--%>${combo.name}</a></h4>
                                                </c:forEach>
                                            </li>
                                        </ul>
                                        <div class="num" style="line-height: 50px"><a style="text-decoration: none;">${cartItemProxy.quantity}</a></div>
                                        <div class="price" style="line-height: 50px"><a style="text-decoration: none;">${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</a></div>
                                        <div class="subtotal" style="line-height: 50px"><a style="text-decoration: none;">${carttype=="integral" ?  "" : "￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</a></div>
                                        <div class="operation" style="width: 125px; color: red;line-height: 0px">商品不支持该地区配送</div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
</div>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>

<div id="editInvoice" style="background:#ffffff;width:320px;height: 145px;border-width:3px;border-color:#FFEC9F;display: none;">
    <a href="javascript:" id="closeEditInvoice" style="float: right;margin: 5px">
        <img src="${webRoot}/template/bdw/statics/images/btn_box_close.JPG">
    </a>

    <div style="padding-top: 15px;padding-left:13px">
        <div style="margin: 10px">
            <label style="font-size: 14px">是否需要发票：</label><input type="radio" class="needInvoice" name="needInvoice"
                                                                 value="Y" checked=""/> 开具发票 &nbsp;&nbsp;
            <input class="needInvoice" name="needInvoice" value="N" type="radio"/> 不需要发票
        </div>
        <div style="margin: 10px" id="titleBox">
            <label style="font-size: 14px"><span style="color: red">*</span>发票抬头：</label>
            <input id="edictInvoiceTitle" type="text"
                   style="border-color: #8AB6DD;border-width:1px;;width: 180px;height: 23px" maxlength="64"/>
        </div>
        <ol style="margin-top:20px">
            <div class="btn1 saveInvoice"><a href="javascript:">确定</a></div>
            <div class="btn2 closeInvoice"><a style="text-decoration: none;" href="javascript:">取消</a></div>
        </ol>
    </div>
</div>

<div id="myAddress">
    <form id="userAddrForm" method="get">
        <div class="box" style="position: relative;">
            <input type="hidden" id="receiverZoneId" name="receiverZoneId">
            <%--经度--%>
            <input type="hidden" class="put" id="addrLng" name="addrLng" maxlength="6">
            <%--维度--%>
            <input type="hidden" class="put" id="addrLat" name="addrLat" maxlength="6" >
            <div class="new-ad">
                <h2><a href="javascript:" class="closeMyAddress"><img src="${webRoot}/template/bdw/statics/images/btn_box_close.JPG"></a></h2>
                <p>使用新地址</p>
                <ul class="province selT">
                    <li><span>*</span><em>省：</em>
                        <select class="addressSelect" id="province" name="" onchange="proviceSelected(this);">
                            <option>请选择</option>
                        </select>
                    </li>
                    <li>市：
                        <select class="addressSelect" id="city" name="" onchange="citySelected(this);">
                            <option>请选择</option>
                        </select>
                    </li>
                    <li>区：
                        <select class="addressSelect" id="country" name="" onchange="areaSelected(this);">
                            <option>请选择</option>
                        </select>
                    </li>
                    <li>街道：
                        <select class="addressSelect" id="zone" onchange="areaSelected(this);">
                            <option>请选择</option>
                        </select>
                    </li>
                    <div id="zoneTip" style="float: left"></div>
                </ul>
                <ol class="zip">
                    <li><a style="text-decoration: none;">邮政编码：</a><input type="text" class="put" id="receiverZipcode" name="receiverZipcode" maxlength="6" onblur="removeTheSign(this,'receiverZipcodeTip')"><div id="receiverZipcodeTip" style="float: left"></div></li>
                </ol>
               <%-- <div class="clear"></div>
                <ol class="zip">
                    <li><a style="text-decoration: none;"><span>*</span>经度：</a><input readonly="readonly"  type="text" class="put" id="addrLng" name="addrLng" maxlength="6"><div id="addrLngTip" style="float: left"></div></li>
                </ol>
                <div class="clear"></div>
                <ol class="zip">
                    <li><a style="text-decoration: none;"><span>*</span>纬度：</a><input readonly="readonly" type="text" class="put" id="addrLat" name="addrLat" maxlength="6" ><div id="addrLatTip" style="float: left"></div></li>
                </ol>--%>
                <div class="clear"></div>
                <div class="address">
                    <div style="float: left;">
                        <span>*</span>街道地址：<input type="text" id="receiverAddr" name="receiverAddr" maxlength="255" style="width: 250px;height:85px;" onblur="analyzeOrderAddAddress();">
                    </div>
                    <div id="receiverAddrTip" style="float: left"></div>
                </div>
                <%--<div class="clear"></div>
                <ol class="zip" style="height: 38px;">
                    <div class="btn1"><a style="text-decoration: none;" id="location"  href="javascript:">定位</a></div>
                </ol>--%>

                <ol class="info">
                    <li style="display: inline-block;"><a style="text-decoration: none;"><span>*</span>收货人姓名：</a><input type="text" id="receiverName" name="receiverName"><div id="receiverNameTip" style="float: left"></div></li>
                    <li><a style="text-decoration: none;"><span>*</span>手机：</a><input type="text" id="receiverMobile" name="receiverMobile"><div id="receiverMobileTip" style="float: left"></div></li>
                    <li><a style="text-decoration: none;">电话：</a><input type="text" class="code" id="receiverTel" name="receiverTel" onblur="removeTheSign(this,'receiverTelTip')"><div id="receiverTelTip" style="float: left"></div></li>
                    <div class="btn1"><a style="text-decoration: none;" id="saveAddress"  href="javascript:">确定</a></div>
                    <div class="btn2 closeMyAddress"><a style="text-decoration: none;"  href="javascript:">取消</a></div>
                </ol>
            </div>

            <div style="width: 424px;height: 396px; position: absolute; right: 32px; top:40px;" id="addMap">
            </div>
        </div>
    </form>
</div>
<div id="zoomloader">
    <div align="center"><span><img src="${webRoot}/template/bdw/statics/images/zoomloader.gif"/></span><span style="font-size: 18px">正在提交...</span></div>
</div>
</body>
</html>
