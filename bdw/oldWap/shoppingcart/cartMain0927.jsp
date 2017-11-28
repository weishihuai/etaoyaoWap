<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
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
<!doctype html>
<html>
<%
    String carttype = (String)pageContext.getAttribute("carttype");
    Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
    if(loginUserId != null){
        if(CartTypeEnum.NORMAL.toCode().equals(carttype)){
            UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
            ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
            ServiceManagerSafemall.bdwShoppingCartService.addCart();
        }
    }
%>

<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/><%--必须放在以上java代码的下面--%>
<body>
<c:choose>
    <c:when test="${userCartListProxy.allCartNum==0}">
    <c:if test="${empty userProxy}">
    <article class="tips">
        <div class="tips-text">
            <i></i>
            <em>购物更便捷,马上前往<a href="${webRoot}/wap/login.ac">登录</a></em>
        </div>
    </article>
    </c:if>
    <section class="no-goods">
        <p>购物车暂无商品</p>
        <a href="${webRoot}/wap/index.ac">马上去逛逛</a>
    </section>

    </c:when>

    <c:otherwise>
        <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
        <c:if test="${shoppingCartProxy.cartNum>0}">
        <section class="container goods order">
            <div class="row sc">
                <div class="col-xs-2 s-left">
                    <c:set value="${bdw:checkWapOrgSelected(carttype,userProxy.userId,shoppingCartProxy.shopInf.sysOrgId)}" var="checkWapOrgSelected" />
                    <a href="javascript:void(0)" onclick="checkPro(this);" class="checkPro <c:if test="${checkWapOrgSelected == 'Y'}">cur</c:if>"  ${checkWapOrgSelected eq 'Y'? "checked='true'" : "checked='false'"} carttype="${carttype}"></a>
                        <%--
                                                        <input class="put checkPro" type="checkbox"  style="vertical-align:middle" checked="checked" carttype="${carttype}"/>
                        --%>
                </div>
                <div class="col-xs-8 s-mid"><span>${shoppingCartProxy.shopInf.shopNm}</span></div>
                <div class="col-xs-1 s-right">
                    <a class="clearShop" onclick="clearShop(this);" href="javascript:" carttype="${carttype}" handler="${shoppingCartProxy.cartItemProxyList[0].promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}" orgid="${shoppingCartProxy.orgId}" itemKey="${shoppingCartProxy.cartItemProxyList[0].itemKey}">
                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon04.png" width="22" height="22" />
                    </a>
                </div>
            </div>

            <div class="row good-main">
                <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                    <c:choose>
                        <%--套餐商品--%>
                        <c:when test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                            <div class="row good-main" style="margin-bottom:10px;">
                                <c:choose>
                                    <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                        <div class="col-xs-12 good-one">
                                            <div class="col-xs-2 sel"><span class="text-danger" style="font-size: 16px;"><strong>失效</strong></span></div>
                                                <%--<div class="col-xs-3 pic"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="80" height="80" /></div>--%>
                                            <div class="col-xs-4 cm-right">
                                                <div class="col-xs-12 title">
                                                    <a href="javascript:">
                                                        <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}
                                                    </a>
                                                    <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                        <img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/>${combo.name}
                                                        <span style="line-height: 22px;">× ${combo.quantity}</span><br>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="col-xs-5 cm-right">
                                                <div class="col-xs-12 pri"><span>&yen;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span></div>
                                                <div class="col-xs-12 " style="font-family: Verdana; font-size: 16px; margin-bottom: 5px;"><span>套餐数量:</span></div>
                                                <div class="col-xs-9 num">${cartItemProxy.quantity}</div>
                                                <div class="col-xs-3 del">
                                                    <a class="delItem" onclick="delItem(this);" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">
                                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon04.png" width="22" height="22" />
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12" style="height:30px;color:#f40;">
                                            <div class="col-xs-5 col-xs-offset-7">${cartItemProxy.cartItemMsg}</div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-xs-12 good-one">
                                            <div class="col-xs-2 sel"><a href="javascript:void(0);" onclick="updateSelect(this)" class="updateSelect ${cartItemProxy.itemSelected?"cur":""}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}"></a></div>
                                                <%--<div class="col-xs-3 pic"><a href="${webRoot}/wap/product.ac?id=${cartItemProxy.productId}"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="80" height="80" /></a></div>--%>
                                            <div class="col-xs-4 cm-right">
                                                <div class="col-xs-12 title">
                                                    <a href="${webRoot}/wap/product.ac?id=${cartItemProxy.productProxy.productId}">
                                                        <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}
                                                    </a>
                                                    <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                        <img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/>${combo.name}
                                                        <span style="line-height: 22px;">× ${combo.quantity}</span><br>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="col-xs-5 cm-right">
                                                <div class="col-xs-12 pri" ><span>${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span></div>
                                                    <%--<div class="col-xs-12 inf"><c:if test="${not empty cartItemProxy.specName}">规格：${cartItemProxy.specName}</c:if></div>--%>
                                                <div class="col-xs-12 " style="font-family: Verdana; font-size: 16px; margin-bottom: 5px;"><span>套餐数量:</span></div>
                                                <div class="col-xs-9 num">
                                                    <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                                    <a href="javascript:" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" productId="${cartItemProxy.productId}"  class="subNum" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon07.png" width="27" height="28" />
                                                    </a>
                                                    <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" productId="${cartItemProxy.productId}" maxlength="4" value="${cartItemProxy.quantity}" type="text" onchange="cartNum(this);"  class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                                    <a href="javascript:" carttype="${carttype}" handler="${curHandler}" productId="${cartItemProxy.productId}" class="addNum" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}">
                                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon08.png" width="27" height="28" />
                                                    </a>
                                                </div>
                                                <div class="col-xs-3 del">
                                                    <a class="delItem" onclick="delItem(this);" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">
                                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon04.png" width="22" height="22" />
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12" style="height:30px;color:#f40;">
                                            <div class="col-xs-5 col-xs-offset-7">${cartItemProxy.cartItemMsg}</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>
                        <%--普通商品--%>
                        <c:otherwise>
                            <div class="row good-main" style="margin-bottom:10px;">
                                <c:choose>
                                    <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                        <div class="col-xs-12 good-one">
                                            <div class="col-xs-2 sel"><span class="text-danger" style="font-size: 16px;"><strong>失效</strong></span></div>
                                            <div class="col-xs-3 pic"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="80" height="80" /></div>
                                            <div class="col-xs-7 cm-right">
                                                <div class="col-xs-12 title">
                                                    <c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>${cartItemProxy.name}
                                                </div>
                                                <div class="col-xs-12 pri"><span>&yen;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span></div>
                                                <div class="col-xs-12 inf"><c:if test="${not empty cartItemProxy.specName}">规格：${cartItemProxy.specName}</c:if></div>
                                                <div class="col-xs-9 num">${cartItemProxy.quantity}</div>
                                                <div class="col-xs-3 del">
                                                    <a class="delItem" onclick="delItem(this);" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">
                                                        <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon04.png" width="22" height="22" />
                                                    </a></div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12" style="height:30px;color:#f40;">
                                            <div class="col-xs-5 col-xs-offset-7">${cartItemProxy.cartItemMsg}</div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="col-xs-12 good-one">
                                            <div class="col-xs-2 sel"><a href="javascript:void(0);" onclick="updateSelect(this);" class="updateSelect ${cartItemProxy.itemSelected?"cur":""}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}"></a></div>
                                            <div class="col-xs-4 pic"><a href="${webRoot}/wap/product.ac?id=${cartItemProxy.productId}"><img src="${cartItemProxy.productProxy.defaultImage["100X100"]}" width="80" height="80" /></a></div>
                                            <div class="col-xs-5 cm-right">
                                                <div class="col-xs-12 title">
                                                    <a href="${webRoot}/wap/product.ac?id=${cartItemProxy.productProxy.productId}">
                                                        <c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>${cartItemProxy.name}
                                                    </a>
                                                </div>
                                                <div class="col-xs-12 pri"><span>&yen;${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</span></div>
                                                <div class="col-xs-12 inf"><c:if test="${not empty cartItemProxy.specName}">规格：${cartItemProxy.specName}</c:if></div>
                                                <div class="col-xs-12">
                                                    <div class="col-xs-9 num">
                                                        <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                                        <a href="javascript:" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" productId="${cartItemProxy.productId}" class="subNum" onclick="subNum(this);" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}">
                                                            <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon07.png" width="27" height="28" />
                                                        </a>
                                                        <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" productId="${cartItemProxy.productId}" maxlength="4" value="${cartItemProxy.quantity}" type="text" onchange="cartNum(this)"  class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                                        <c:choose>
                                                            <c:when test="${!cartItemProxy.btnIsCanAdd}">
                                                                <a href="javascript:" class="lock"><img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon08.png" width="27" height="28" class="lock"/></a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="javascript:" carttype="${carttype}" handler="${curHandler}" productId="${cartItemProxy.productId}" class="addNum" onclick="addNum(this);" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}">
                                                                    <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon08.png" width="27" height="28" />
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </div>
                                                    <div class="col-xs-3 del">
                                                        <a class="delItem" onclick="delItem(this);" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">
                                                            <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon04.png" width="22" height="22" />
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12" style="height:30px;padding:5px 0px;color:#f40;">
                                            <div class="col-xs-5 col-xs-offset-7">${cartItemProxy.cartItemMsg}</div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

                <%-- <div class="row zp">
                     <div class="col-xs-3 zp-icon"><span>赠品</span></div>
                     <div class="col-xs-7 zp-title">新肌遇兰芝热剧同款明星热荐丝润盈彩唇新品好用<span>X<i>1</i></span></div>
                     <div class="col-xs-2 zp-del"><a href="#"><img src="${webRoot}/template/jvan/wap/statics/images/wsc_byc_icon04.png" width="22" height="22" /></a></div>
                 </div>--%>
        </section>
            <div class="row" style="margin-bottom: 10px">
                <c:forEach items="${shoppingCartProxy.discountDetails}" var="discount" varStatus="s">
                    <c:choose>
                        <c:when test="${s.index==0}">
                            <div class="col-xs-4">&nbsp;&nbsp;&nbsp;&nbsp;店铺优惠：</div>
                        </c:when>
                        <c:otherwise>
                            <div class="col-xs-4"></div>
                        </c:otherwise>
                    </c:choose>
                    <div class="col-xs-8">
                            ${discount.amountNm}
                    </div>
                </c:forEach>
            </div>
        </c:if>
        </c:forEach>

        <article class="tips" style="${userCartListProxy.checkedCod and userCartListProxy.unSupportCodNum>0?"display: block":"display: none"};">
            <img src="${webRoot}/template/bdw/oldWap/statics/images/wsc_byc_icon03.png" width="22" height="22" />
            <em> 有&nbsp;<span id="noCodNum"  style="color :#CC0000;font-weight: bold;">${userCartListProxy.unSupportCodNum}</span>&nbsp;种宝贝因不支持货到付款从结果中移除。</em>
        </article>
        <article class="row pay-btn" style="margin-bottom: 10px;">
            <div class="col-xs-6 h-left">
                <div class="row">
                    <div class="col-xs-3"><a href="javascript:" onclick="isCod(this);" class="select isCod  ${param.isCod == "Y" ? "cur" :""}" carttype="${carttype}" handler="${handler}"></a></div>
                    <div class="col-xs-9"><em>使用货到付款</em></div>
                </div>
                <div class="row" style="margin-top: 5px;"><div class="col-xs-12 total"><span>合计：<i id="allProductTotalAmount">￥${userCartListProxy.finalAmount}</i></span></div></div>
            </div>
                <%--<div class="col-xs-6 h-right"><a href="javascript:;" style="text-decoration: none;" onclick="goToOrderAdd('${webRoot}/wap/shoppingcart/orderadd.ac?carttype=${carttype}&handler=${handler}&isCod=${userCartListProxy.checkedCod?'Y':'N'}&time='+ new Date().getTime())">去结算</a></div>--%>
            <div class="col-xs-6 h-right"><a href="javascript:void(0);" onclick="addCartResultClick(this);" id="wapAddCartResult" carttype="${carttype}" handler="${handler}" isCod="${param.isCod == 'Y'?'Y':'N'}" style="text-decoration: none;">结    算</a></div>
        </article>
    </c:otherwise>
</c:choose>