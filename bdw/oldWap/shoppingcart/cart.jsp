<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<c:set value="${sdk:getLoginUser()}" var="userProxy"/>
<c:if test="${empty userProxy}">
    <c:redirect url="${webRoot}/wap/login.ac"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>

<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="format-detection" content="telphone=no, email=no" />
    <title>购物车</title>
    <link href="${webRoot}/template/bdw/oldWap/statics/css/headerForCart.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/baseForCart.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/module/member/statics/css/common.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/buycars.css" type="text/css" rel="stylesheet" />
    <style>
        .alertMsg{
            margin-top: 14px;
            text-align: right;
            font-size: 12px;
            color:orangered;
        }
    </style>

    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/main.js" type="text/javascript"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot:"${webRoot}",handler : "${empty param.handler ? 'sku' : param.handler}",carttype : "${empty param.carttype ? 'normal' : param.carttype}",pageUrl:"${webRoot}/wap/shoppingcart/cart.ac?"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/wapcart.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
</head>

<%
    String carttype = (String)pageContext.getAttribute("carttype");
    Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
    if(loginUserId != null){
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
        for (ShoppingCart shoppingCart : userCartList.getCarts()){
            ResolverUtils.clacCartMisc(shoppingCart);
            ResolverUtils.clearCoupon(shoppingCart);
        }
        ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
        ServiceManagerSafemall.bdwShoppingCartService.addCart(carttype);
    }
%>

<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/><%--必须放在以上java代码的下面--%>

<body>
<!-- 头部 -->
<header class="header">
    <a class="action fl goBack" href="javascript:history.go(-1);">
        <span class="icon-back"></span>
        返回
    </a>
    <span class="title">购物车</span>
    <a class="action-link fr edit" href="javascript:void(0);">编辑</a>
</header>

<!-- 主体 -->
<div class="main m-cart">
    <c:choose>
        <c:when test="${userCartListProxy.allCartNum==0}">
            <section class="no-goods">
                <p>购物车暂无商品</p>
                <a href="${webRoot}/wap/index.ac">马上去逛逛</a>
            </section>
            <%--如果购物车为空的话，右上角的"编辑"按钮隐藏掉--%>
            <script>
                <%--占位隐藏--%>
                $(".edit").css("visibility","hidden");
            </script>
        </c:when>
        <c:otherwise>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy" varStatus="s">
                <c:if test="${shoppingCartProxy.cartNum>0}">
                    <div class="cart">
                        <div class="bundle order">
                            <div class="shop">
                                <c:set value="${bdw:checkWapOrgSelected(carttype,userProxy.userId,shoppingCartProxy.shopInf.sysOrgId)}" var="checkWapOrgSelected" />
                                <div class="checkbox checkPro ${checkWapOrgSelected == "Y"? "cur" : ""}" carttype="${carttype}" checked="${checkWapOrgSelected == "Y"? "true" : "false"}">
                                    <span class="icon"></span>
                                    <b></b>
                                </div>
                                <span class="shop-img">
                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/shop-icon.png" alt="">
                                </span>
                                <a class="shop-tit elli" href="javascript:void(0);">${shoppingCartProxy.shopInf.shopNm}</a>
                            </div>

                            <div class="group">
                                <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                                    <c:choose>
                                        <%--套餐商品--%>
                                        <c:when test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                            <c:choose>
                                                <c:when test="${cartItemProxy.isDisabled != 'Y'}">
                                                    <div class="item">
                                                        <div style="font-size: 13px;height: 24px;line-height: 24px;padding-left: 50px;background-color: #f3f3f3;margin-top: 1px;">
                                                            <span style="color: red">[套餐]</span>${cartItemProxy.name}
                                                        </div>
                                                        <div class="item-detail">
                                                            <div class="checkbox updateSelect ${cartItemProxy.itemSelected?"cur":""}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                                                <%--<input class="hide" type="checkbox" checked>--%>
                                                                <span class="icon"></span>
                                                                <b></b>
                                                            </div>
                                                            <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                <div style="height: 65px;">
                                                                <a class="item-img" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                    <img src="${bdw:getProductById(combo.productId).defaultImage['100X100']}">
                                                                </a>
                                                                <a class="item-name" href="${webRoot}/product-${cartItemProxy.productId}.html">${combo.name}</a>
                                                                <c:if test="${not empty combo.specName}">
                                                                    <p class="item-desc elli">${combo.specName}</p>
                                                                </c:if>
                                                                <p class="item-desc elli" style="color: #333; padding-right: 10px; text-align: right;">x${combo.quantity}</p>
                                                                </div>
                                                            </c:forEach>
                                                            <div class="item-amount" style="padding-top: 5px">
                                                                <span class="item-price">&yen;&ensp;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span>
                                                                <div class="quantity">
                                                                    <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                                                    <a href="javascript:void(0)" class="action subNum" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" productId="${cartItemProxy.productId}">&minus;</a>
                                                                    <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum ${cartItemProxy.itemKey}" productId="${cartItemProxy.productId}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                                                    <c:choose>
                                                                        <c:when test="${!cartItemProxy.btnIsCanAdd}">
                                                                            <a href="javascript:void(0)" class="action" onclick="xyPop('库存不足！', {type: 'error',title:false});">&plus;</a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a href="javascript:void(0)" carttype="${carttype}" handler="${curHandler}" productId="${cartItemProxy.productId}" class="action addNum" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}">&plus;</a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                            <p class="alertMsg">${cartItemProxy.cartItemMsg}</p>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <%--套餐商品如果失效的话--%>
                                                    <div class="item">
                                                        <div style="font-size: 13px;height: 24px;line-height: 24px;padding-left: 50px;background-color: #f3f3f3;margin-top: 1px;">
                                                            <span style="color: red">[套餐]</span>${cartItemProxy.name}
                                                        </div>
                                                        <div class="item-detail">
                                                            <div class="fail">
                                                                失效
                                                            </div>
                                                            <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                <div style="height: 65px;">
                                                                    <a class="item-img" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                        <img src="${bdw:getProductById(combo.productId).defaultImage['100X100']}">
                                                                    </a>
                                                                    <a class="item-name" href="${webRoot}/product-${cartItemProxy.productId}.html">${combo.name}</a>
                                                                    <c:if test="${not empty combo.specName}">
                                                                        <p class="item-desc elli">${combo.specName}</p>
                                                                    </c:if>
                                                                    <p class="item-desc elli" style="color: #333; padding-right: 10px; text-align: right;">x${combo.quantity}</p>
                                                                </div>
                                                            </c:forEach>
                                                            <p class="alertMsg">${cartItemProxy.disabledReason}</p>
                                                        </div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <%--普通商品--%>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${cartItemProxy.isDisabled != 'Y'}">
                                                    <div class="item">
                                                        <c:choose>
                                                            <c:when test="${cartItemProxy.promotionType!='PRESENT'}">
                                                                <div class="item-detail">
                                                                    <div class="checkbox updateSelect ${cartItemProxy.itemSelected?"cur":""}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                                                        <%--<input class="hide" type="checkbox">--%>
                                                                        <span class="icon"></span>
                                                                        <b></b>
                                                                    </div>
                                                                    <a class="item-img" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                        <img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="75" height="75">
                                                                    </a>
                                                                    <a class="item-name" href="${webRoot}/product-${cartItemProxy.productId}.html">${cartItemProxy.name}</a>
                                                                    <c:if test="${not empty cartItemProxy.specName}">
                                                                        <p class="item-desc elli">${cartItemProxy.specName}</p>
                                                                    </c:if>
                                                                    <div class="item-amount">
                                                                        <span class="item-price">&yen;&ensp;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span>
                                                                        <div class="quantity">
                                                                            <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                                                            <a href="javascript:void(0);" class="action subNum" itemKey="${cartItemProxy.itemKey}" productId="${cartItemProxy.productId}"  handler="${curHandler}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">&minus;</a>
                                                                            <input handler="${curHandler}" productId="${cartItemProxy.productId}" itemKey="${cartItemProxy.itemKey}" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                                                            <c:choose>
                                                                                <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                                    <a href="javascript:void(0);" class="action addNum" carttype="${carttype}" handler="${curHandler}" productId="${cartItemProxy.productId}" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}">&plus;</a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a href="javascript:void(0)" class="action" onclick="xyPop('库存不足！', {type: 'error',title:false});">&plus;</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                    </div>
                                                                    <p class="alertMsg">${cartItemProxy.cartItemMsg}</p>
                                                                </div>
                                                                <c:if test="${fn:length(cartItemProxy.presents)>0}">
                                                                    <c:forEach items="${cartItemProxy.presents}" var="present" varStatus="s">
                                                                        <div class="gift">
                                                                            <em>单品赠品</em>
                                                                            <a class="elli" href="${webRoot}/product-${cartItemProxy.productId}.html">${present.name}</a>
                                                                            <span>X${present.quantity}</span>
                                                                        </div>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </c:when>
                                                            <%--<c:otherwise>
                                                                <div class="gift">
                                                                    <em>全场满增</em>
                                                                    <a class="elli" href="javascript:void(0);">${cartItemProxy.name}</a>
                                                                    <span>X${cartItemProxy.quantity}</span>
                                                                </div>
                                                            </c:otherwise>--%>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <%--失效商品--%>
                                                    <div class="item">
                                                        <c:choose>
                                                            <c:when test="${cartItemProxy.promotionType!='PRESENT'}">
                                                                <div class="item-detail">
                                                                    <div class="fail">
                                                                        失效
                                                                    </div>
                                                                    <c:choose>
                                                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                            <a class="item-img">
                                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" width="75" height="75">
                                                                            </a>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <a class="item-img">
                                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" width="75" height="75">
                                                                            </a>
                                                                        </c:otherwise>
                                                                   </c:choose>
                                                                    <a class="item-name">${cartItemProxy.name}</a>
                                                                    <c:if test="${not empty cartItemProxy.specName}">
                                                                        <p class="item-desc elli">${cartItemProxy.specName}</p>
                                                                    </c:if>
                                                                    <div class="item-amount">
                                                                        <span class="item-price">&yen;&ensp;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span>
                                                                        <div class="quantity" style="font-size: 14px;border: 0px;background-color:#f3f3f3;margin-right: 35px;">${cartItemProxy.quantity}</div>
                                                                    </div>
                                                                    <p class="alertMsg">${cartItemProxy.disabledReason}</p>
                                                                </div>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <%--当cartItem是赠品的时候，不管是不是失效的都要显示出来--%>
                                            <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                <div class="single-gift">
                                                    <em>订单满赠</em>
                                                    <a class="elli" href="${webRoot}/product-${cartItemProxy.productId}.html">${cartItemProxy.name}</a>
                                                    <span>X${cartItemProxy.quantity}</span>
                                                </div>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <c:if test="${fn:length(shoppingCartProxy.discountDetails)>0}">
                                <div class="tip">
                                    <p>店铺优惠：
                                        <c:forEach items="${shoppingCartProxy.discountDetails}" var="discount" varStatus="s">
                                            <c:choose>
                                                <c:when test="${!s.last}">
                                                    <span>${discount.amountNm},</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>${discount.amountNm}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <div class="hasSelected" style="display: none" hasSelected="${userCartListProxy.selectCartNum}"></div>

            <!-- 结算：普通状态 -->
            <div class="bottom-checkout priceDiv">
                <%--lhw 2016年12月22日 暂时隐藏--%>
               <%-- <a class="checkbox receivePay isCod ${param.isCod == "Y" ? "cur" :""}" carttype="${carttype}" handler="${handler}" enable="${userCartListProxy.selectCartNum == 0?'N':'Y'}">
                    &lt;%&ndash;<input class="hide" type="checkbox">&ndash;%&gt;
                    <span class="icon"></span>
                    <i>货到<br>付款</i>
                    <b></b>
                </a>--%>
                <button class="action" type="button" id="wapAddCartResult" carttype="${carttype}" handler="${handler}" isCod="${param.isCod == 'Y'?'Y':'N'}">去结算<%--(<span id="selectedCartNum">${userCartListProxy.selectCartNum}</span>)--%></button>
                <div class="detail">
                    <span class="total">合计：<em><small>¥</small><span id="finalAmount">${userCartListProxy.finalAmount}</span></em></span>
                    <span class="discount">总额:￥<span id="allProductTotalAmount">${userCartListProxy.allProductTotalAmount}</span>&ensp;已减:￥<span id="allDiscount">${userCartListProxy.allDiscountAbs}</span></span>
                </div>
            </div>
            <!-- 结算：编辑状态 -->
            <div class="bottom-checkout hide editDiv">
                <a class="checkbox selectAll <c:if test="${userCartListProxy.selectCartNum == userCartListProxy.allCartNum}">cur</c:if>" style="font-size:0.8rem;" carttype="${carttype}">
                    <%--<input class="hide" type="checkbox">--%>
                    <span class="icon"></span>
                    &ensp;全选
                    <b></b>
                </a>
                <c:if test="${userCartListProxy.hasInvalidProduct}">
                    <button class="btn btn-default deleteInvalid" style="font-size: 0.65rem;" type="button" carttype="${carttype}">移除失效商品</button>
                </c:if>
                <button class="btn btn-default delete" style="font-size: 0.65rem;" type="button" carttype="${carttype}">删除</button>
                <button class="btn btn-outline collect" style="font-size: 0.65rem;" type="button" carttype="${carttype}">移入收藏夹</button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:choose>
    <c:when test="${empty userProxy.bytUserId}">
        <%--页脚开始--%>
        <c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
        <%--页脚结束--%>
    </c:when>
</c:choose>
</body>

</html>
