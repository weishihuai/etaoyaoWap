<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.domain.code.RuleTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.vo.AmountDetailVo" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.ShoppingCartProxy" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.UserCartListProxy" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.service.ShoppingCartProxyService" %>

<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>购物车-${webName}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/buyCar.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">
        var webPath = {webRoot:"${webRoot}"};
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/tuanShoppingcart.js"></script>
</head>
<c:set var="handler" value="${empty param.handler ? 'groupBuy' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'groupBuy' : param.carttype}"/>
<%--页头logo--%>
<%
    String carttype = (String)pageContext.getAttribute("carttype");
    if(WebContextFactory.getWebContext().getFrontEndUser() != null){
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
        for (ShoppingCart shoppingCart : userCartList.getCarts()){
            ResolverUtils.clearCoupon(shoppingCart);
        }
        ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);

        UserCartListProxy userCartListProxy = SpringContextHolder.getBean(ShoppingCartProxyService.class).getUserCartListProxy(carttype);
        Double discount=0.0;
        for(ShoppingCartProxy proxy : userCartListProxy.getShoppingCartProxyList()){
            for(AmountDetailVo vo : proxy.getDiscountDetails()){
                if(vo.getRuleType() != null && (vo.getRuleType().equals(RuleTypeCodeEnum.PRODUCT_LOGISTICS_OFF)
                        || (vo.getRuleType().equals(RuleTypeCodeEnum.CATEGORY_BRAND_LOGISTICS_OFF)) || (vo.getRuleType().equals(RuleTypeCodeEnum.ORDER_LOGISTICS_OFF)) )){
                    continue;
                }
                if(vo.getUnitPrice() != null){
                    discount=BigDecimalUtil.add(discount,vo.getUnitPrice());
                }
            }

        }
        request.setAttribute("allDiscount",discount);
    }else{
        request.setAttribute("allDiscount",0.0);
    }
%>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<body  style="background:url('${webRoot}/template/bdw/statics/images/header_line_top.gif') repeat-x scroll 0 0 #FFFFFF">
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp?p=list"/>
<%--页头结束--%>
<c:choose>
    <c:when test="${userCartListProxy.allCartNum==0}">
        <div id="cart">
                <%--<div class="emptyCart">--%>
                <%--您的购物车中没有商品，请您先--%>
                <%--<c:choose>--%>
                <%--<c:when test="${carttype == 'integral'}">--%>
                <%--<a href="${webRoot}/integral.html">选购商品»</a>--%>
                <%--</c:when>--%>
                <%--<c:otherwise>--%>
                <%--<a href="${webRoot}/index.ac">选购商品»</a>--%>
                <%--</c:otherwise>--%>
                <%--</c:choose>--%>
                <%--</div>--%>
                <%--lml 2015/4/11--%>
            <div class="middle">
                <div class="middle_c">
                    <ul style="float:left;">
                        <li><img src="${webRoot}/template/bdw/statics/images/kgwc02.jpg"/></li>
                        <c:choose>
                            <c:when test="${carttype == 'integral'}">
                                <li><a href="${webRoot}/integral.html"><img
                                        src="${webRoot}/template/bdw/statics/images/kgwc03.jpg"/></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${webRoot}/index.ac"><img
                                        src="${webRoot}/template/bdw/statics/images/kgwc03.jpg"/></a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                        <span style="float:right; padding-top:70px;"><img
                                src="${webRoot}/template/bdw/statics/images/kgwc01.png"/></span>
                </div>
            </div>
                <%--lml 2015/4/11--%>
        </div>
    </c:when>
    <c:otherwise>
        <div id="cart" style="margin-top:20px;">
            <ul class="nav">
                <li class="done"><span>1.查看购物车</span></li>
                <li><span>2.填写订单信息</span></li>
                <li><span><c:choose><c:when test="${userCartListProxy.checkedCod}">3.付款到收银台</c:when><c:otherwise>3.确认货到付款订单信息</c:otherwise></c:choose></span></li>
                <li class="last"><span>4.收货评价</span></li>
            </ul>
            <div class="clear"></div>
            <div class="all"><input class="put selectAll" type="checkbox" style="vertical-align:middle" <c:if test="${userCartListProxy.allCartNum == userCartListProxy.selectCartNum}"> checked="checked"</c:if> carttype="${carttype}" /> 全选</div>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                <%--为了解决运费优惠再次命中，需要进入购物车时，清除zoneId--%>
                ${sdk:clearShoppingCartZoneId(carttype, shoppingCartProxy.orgId)}
                <c:if test="${shoppingCartProxy.cartNum>0}">
                    <div class="order">
                        <div class="nav">
                            <div class="shop">
                                <input class="put checkPro" type="checkbox"  style="vertical-align:middle" <c:if test="${shoppingCartProxy.cartNum == shoppingCartProxy.selectedCartItemNum}"> checked="checked" </c:if>  carttype="${carttype}"/>
                                <img src="${webRoot}/template/bdw/statics/images/96.png" style="vertical-align:middle"/>
                                <a href="${webRoot}/${shoppingCartProxy.shopInf.shopTemplateCatalog}/shopIndex.ac?shopId=${shoppingCartProxy.shopInf.shopInfId}">${shoppingCartProxy.shopInf.shopNm}</a>
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
                            <div class="num"><span>数量</span></div>
                            <div class="price"><span>单价</span></div>
                            <div class="subtotal"><span>小计</span></div>
                            <div class="operation"><span>操作</span></div>
                        </div>
                        <div class="box">
                            <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                                <div class="info layer">
                                    <div class="left ">
                                        <ul>
                                            <input class="put updateSelect" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" type="checkbox" name="" style="vertical-align:middle" ${cartItemProxy.itemSelected  ?  "checked=true" : ""}/>
                                            <c:if test="${cartItemProxy.promotionType!='COMBINED_PRODUCT'}">
                                                <h2><a href="${webRoot}/product-${cartItemProxy.productId}.html"><img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></a></h2>
                                            </c:if>
                                            <li>
                                                <h3><a href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                    <c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>
                                                    <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}
                                                    <c:if test="${not empty cartItemProxy.specName}">（${cartItemProxy.specName})</c:if></a></h3>
                                                <c:forEach items="${cartItemProxy.presents}" var="present">
                                                    <h4><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></h4>
                                                </c:forEach>
                                                <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                    <h4><a href="${webRoot}/product-${combo.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a> <a href="${webRoot}/product-${combo.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                                                </c:forEach>
                                            </li>
                                        </ul><div class="clear"></div>
                                    </div>
                                    <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                    <c:choose>
                                        <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                            <div class="num">
                                                <input handler="${handler}" itemKey="${cartItemProxy.itemKey}" readonly="" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="num">
                                                <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                    <label>套餐数量：</label>
                                                </c:if>
                                                <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                                <a href="javascript:" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" class="addNum" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}"><img src="${webRoot}/template/bdw/statics/images/100.png" /></a>
                                                <a href="javascript:" carttype="${carttype}" handler="${curHandler}" class="subNum" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}"><img src="${webRoot}/template/bdw/statics/images/101.png" /></a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="price"><a style="text-decoration: none;">${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</a></div>
                                    <div class="subtotal"><a style="text-decoration: none;">${carttype=="integral" ?  "" : "￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</a></div>
                                    <div class="operation">
                                            <%--<a href="#">寄存收藏夹</a>--%>
                                        <a class="delItem" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">删除此商品</a>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="clear"></div>
                            <div class="discount"><a href="#"><span>店铺优惠：</span><c:forEach items="${shoppingCartProxy.discountDetails}" var="discount">${discount.amountNm},</c:forEach></a></div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <div class="clear"></div>
            <div class="total">
                <p>
                    <input class="put selectAll" type="checkbox" name="" style="vertical-align:middle"<c:if test="${userCartListProxy.allCartNum == userCartListProxy.selectCartNum}"> checked="checked" </c:if>  carttype="${carttype}" />全选
                        <%-- <a style="text-decoration: none;" class="clearAllCart" carttype="${carttype}" handler="${handler}"><span>批量删除</span></a>--%>
                    <a style="text-decoration: none;">商品件数总计：<span id="allCartNum">${userCartListProxy.allCartNum}</span></a>
                    <a style="text-decoration: none;">赠送积分总计：<span id="allObtainTotalIntegral">${userCartListProxy.allObtainTotalIntegral}</span></a>
                    <a style="text-decoration: none;">促销优惠：<span id="allDiscount">${allDiscount}</span>元</a>
                    <a style="text-decoration: none;">商品金额总计：
                            <%--<em id="allProductTotalAmount">${userCartListProxy.allProductTotalAmount+userCartListProxy.allDiscount}</em>元--%>
                        <em id="allProductTotalAmount"><fmt:formatNumber value="${userCartListProxy.allProductTotalAmount+allDiscount}" type="number" pattern="#0.00#" /></em>元
                    </a>
                </p>
                <div class="kd-popup" id="codTip" style="${userCartListProxy.checkedCod and userCartListProxy.unSupportCodNum>0?"display: block":"display: none"};">
                    <div class="box">
                        <div class="bd">
                            有&nbsp;<span id="noCodNum"  style="color :#CC0000;font-weight: bold;"> <fmt:formatNumber value="${userCartListProxy.unSupportCodNum+allDiscount}" type="number" pattern="#0.00#" />
                            </span>&nbsp;种宝贝因不支持货到付款从结果中移除。
                        </div>
                        <a  class="m-close" id="m-close"  href="javascript:void(0);"></a>
                    </div>
                    <i class="bottom"></i>
                </div>
                <div class="settlement" style="width: 98px;">
                        <%--2015-01-07 暂时bdw那边不要货到付款的功能--%>
                        <%--<div class="pay">
                            <div style="_margin-top:10px;">
                                <img src="${webRoot}/template/bdw/statics/images/95.png" style="vertical-align:middle"/>
                                <input class="put isCod" type="checkbox" name="" ${userCartListProxy.checkedCod ? "checked=checked" :""}  carttype="${carttype}" handler="${handler}" style="vertical-align:middle"/><a style="text-decoration: none;">使用货到付款</a>
                            </div>
                        </div>--%>
                        <%--<div class="btn"><a href="javascript:;" style="text-decoration: none;" onclick="goToOrderAdd('${webRoot}/shoppingcart/orderadd.ac?carttype=${carttype}&handler=${handler}&isCod=${userCartListProxy.checkedCod?'Y':'N'}')">结    算</a></div>--%>
                    <div class="btn"><a href="${webRoot}/shoppingcart/orderadd.ac?carttype=${carttype}&handler=${handler}&isCod=${userCartListProxy.checkedCod?'Y':'N'}" style="text-decoration: none;" onclick="return;
                    goToOrderAdd()">结    算</a></div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页头结束--%>
</body>
</html>
