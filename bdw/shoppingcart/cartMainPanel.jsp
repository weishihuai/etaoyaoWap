<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.BdwShoppingCart" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.client.constant.bdw.IBdwShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="java.util.List" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/shoppingcart_new.js"></script>

<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>
<%--页头logo--%>
<%
    String carttype = (String)request.getParameter("carttype");
    //2015-11-30 lhw 因购物车只有在登录的时候才填充，为了避免不同浏览器购物车不同步的情况，当刷新页面时需要重新加载购物车
    Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
    if(loginUserId != null){
        List<BdwShoppingCart> bdwShoppingCartList = ServiceManagerSafemall.bdwShoppingCartService.findByKey(IBdwShoppingCart.USER_ID, loginUserId);

        UserCartList normalCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.NORMAL, loginUserId);
        UserCartList drugCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.DRUG, loginUserId);
        ServiceManager.shoppingCartStoreService.removeUserCartList(normalCartList);
        ServiceManager.shoppingCartStoreService.removeUserCartList(drugCartList);

        if(!bdwShoppingCartList.isEmpty()){
            ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.NORMAL.toCode());
            ServiceManagerSafemall.bdwShoppingCartService.addCart(CartTypeEnum.DRUG.toCode());
        }
    }
%>
<c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>      <!--购物车-->

<c:set value="${userCartListProxy.allDiscount}" var="allDiscount" />
<c:set value="${userCartListProxy.allDeliveryDiscount}" var="allDeliveryDiscount" />

<c:choose>
    <c:when test="${userCartListProxy.allCartNum <= 0}">
        <div class="main-shopping-cart" id="cart">
            <div class="null-cart">
                <div class="icon"></div>
                <div class="null-cart-txt">
                    <p>购物车还是空空的呢，</p>
                    <p>前往<a href="${webRoot}/index.ac">首页</a>逛逛~~</p>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="main-shopping-cart" id="cart">

            <ul class="dt">
                <li class="select"><label class="checkbox-box"><input type="checkbox" checked="checked"><em class="selectAll" carttype="${carttype}" data-checked="false"></em></label><span>全选</span></li>
                <li class="sp-name"><span>商品名称</span></li>
                <li class="price"><span>单价（元）</span></li>
                <li class="number"><span>数量</span></li>
                <li class="subtotal"><span>小计（元）</span></li>
                <li class="operation"><span>操作</span></li>
            </ul>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                <%--为了解决运费优惠再次命中，需要进入购物车时，清除zoneId--%>
                ${sdk:clearShoppingCartZoneId(carttype, shoppingCartProxy.orgId)}
                <c:set var="shopInfo" value="${shoppingCartProxy.shopInf}"/>
                <div class="dd order">
                    <div class="dd-title" style="display: ${shoppingCartProxy.cartNum > 0?'block':'none'}">
                        <label class="checkbox-box"><input type="checkbox"><em class="checkPro"  carttype="${carttype}" data-checked="false"></em></label>
                        <p>店铺：<span>${shopInfo.shopNm}</span></p>
                        <c:choose>
                            <c:when test="${not empty shopInfo.companyQqUrl}">
                                <div class="qq-service-area">
                                    <a class="qq-service" href="javascript:;">QQ客服</a>
                                    <div class="service-box" style="display: none;">
                                        <div class="service-inner">
                                    <a href="${shopInfo.companyQqUrl}" target="_blank" class="sh-service">QQ客服</a>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:set value="${shopInfo.csadInf}" var="csadInfs"/>
                                <c:if test="${!empty csadInfs}">
                                    <div class="qq-service-area">
                                        <a class="qq-service" href="javascript:;">QQ客服</a>
                                        <div class="service-box" style="display: none;">
                                            <div class="service-inner">
                                            <c:forEach items="${csadInfs}" var="csadInf" varStatus="s">
                                                <a href="http://wpa.qq.com/msgrd?v=3&amp;uin=${csadInf}&amp;site=qq&amp;menu=yes" target="_blank" class="sh-service">QQ客服${s.count}</a>
                                            </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="dd-table">
                        <c:set value="" var="currentPresentIndex"/>
                        <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                            <c:set var="productProxy" value="${cartItemProxy.productProxy}"/>
                            <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                            <c:if test="${cartItemProxy.isPresent =='N'}">
                                <div class="tr">
                                    <div class="select">
                                        <label class="checkbox-box"><input type="checkbox" checked="checked">
                                            <em class="updateSelect" handler="${curHandler}" productId="${cartItemProxy.productId}" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" data-checked="${cartItemProxy.itemSelected  ?  "true" : "false"}"></em>
                                        </label>
                                    </div>
                                    <div class="sp-name">
                                        <div class="sp-name-t">
                                            <a href="${webRoot}/product-${productProxy.productId}.html"><img src="${productProxy.defaultImage["80X80"]}" alt=""></a>
                                            <p class="name"><a href="${webRoot}/product-${productProxy.productId}.html">${cartItemProxy.name}</a></p>
                                            <p>生产厂家：${productProxy.dicValueMap["factory"].valueString}</p>
                                            <p>产品规格：${productProxy.dicValueMap["span"].valueString}</p>
                                        </div>
                                        <c:forEach var="presentItem" items="${cartItemProxy.presents}">
                                            <p class="sp-name-b">【赠品】${presentItem.name}  x ${presentItem.quantity}</p>
                                        </c:forEach>
                                    </div>
                                    <c:set var="unitPrice" value="${carttype=='integral' ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}"/>
                                    <div class="price"><span>${carttype=="integral"?"":"￥"}${unitPrice}</span></div>
                                    <div class="number">
                                        <div class="add-subtract">

                                            <a class="add subNum" href="javascript:;" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}"  productId="${cartItemProxy.productId}"></a>
                                            <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" autocomplete="off" maxlength="4" value="${cartItemProxy.quantity}" type="hidden" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" />
                                            <input handler="${curHandler}" autocomplete="off" itemKey="${cartItemProxy.itemKey}" class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" productId="${cartItemProxy.productId}" value="${cartItemProxy.quantity}" type="text"/>
                                            <a class="subtract addNum" href="javascript:;"  itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" carttype="${carttype}"   orgid="${shoppingCartProxy.orgId}" productId="${cartItemProxy.productId}"></a>
                                        </div>
                                    </div>
                                    <div class="subtotal"><span>${carttype=="integral"?"":"￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</span></div>
                                    <div class="operation">
                                        <c:choose>
                                            <c:when test="${productProxy.collect == false}">
                                                <a href="javascript:;" class="oneCollect"  handler="${curHandler}" itemKey="${cartItemProxy.itemKey}">加入收藏</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span>已收藏</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <a class="delItem ${cartItemProxy.itemKey}" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">删除</a>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                <c:set value="${currentPresentIndex+1}" var="currentPresentIndex"/>
                                <c:if test="${currentPresentIndex == '1'}">
                                    <div class="tr order-gift">
                                        <div class="order-gift-t">订单赠品</div>
                                        <p>${cartItemProxy.name}  x${cartItemProxy.quantity}</p>
                                    </div>
                                </c:if>
                                <c:if test="${currentPresentIndex gt '1'}">
                                    <div class="order-gift-more">
                                        <p>${cartItemProxy.name}  x${cartItemProxy.quantity}</p>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
            <!-- 去结算 -->
            <div class="sc-clearing-box">
                <div class="sc-clearing">
                    <div class="fl">
                        <label class="checkbox-box"><input type="checkbox"><em class="selectAll" carttype="${carttype}"  data-checked="false"></em></label><span>全选</span>
                        <a href="javascript:;" class="delSelectedCart" carttype="${carttype}" >批量删除</a>
                        <a href="javascript:;" class="allCollect">加入收藏</a>
                    </div>
                    <div class="fr">
                        <p>已选商品件数：${userCartListProxy.selectCartNum}</p>
                        <p>赠送积分总计：<fmt:formatNumber value="${userCartListProxy.allObtainTotalIntegral}" type="number" pattern="#0.0#"/></p>
                        <p>促销优惠：<fmt:formatNumber value="${-allDiscount+allDeliveryDiscount}" type="number" pattern="#0.00#"/>元 </p>
                        <p>商品金额总计：
                            <c:choose>
                                <c:when test="${userCartListProxy.allProductTotalAmount+userCartListProxy.allDiscount < 0}">
                                    <span class="span-price"><em>¥</em><fmt:formatNumber value="0.0" type="number" pattern="#0.00#" /></span>元
                                </c:when>
                                <c:otherwise>
                                    <span class="span-price"><em>¥</em><fmt:formatNumber value="${userCartListProxy.allProductTotalAmount + userCartListProxy.allDiscount}" type="number" pattern="#0.00#" /></span>元
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <a class="btn" href="javascript:;" id="addCartResult">${carttype == 'normal'?'去结算':'立即预订'}</a>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>


<c:set value="${sdk:getUserCartListProxy('normal')}" var="normalProxy"/>    <!--普通购物车-->
<c:set value="${sdk:getUserCartListProxy('drug')}" var="drugProxy"/>        <!--药品购物车-->
<script>
    var normalCartTotalNum = "${normalProxy.allCartNum}";
    var drugCartTotalNum = "${drugProxy.allCartNum}";
    $("#normalCartTotalNum").html(normalCartTotalNum == 0?'':normalCartTotalNum);
    $("#drugCartTotalNum").html(drugCartTotalNum == 0?'':drugCartTotalNum);
</script>