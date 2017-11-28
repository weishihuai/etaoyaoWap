<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iloosen.imall.client.constant.bdw.IBdwShoppingCart" %>
<%@ page import="com.iloosen.imall.commons.helper.ServiceManagerSafemall" %>
<%@ page import="com.iloosen.imall.commons.util.BigDecimalUtil" %>
<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.core.domain.code.BoolCodeEnum" %>
<%@ page import="com.iloosen.imall.module.promotion.domain.code.RuleTypeCodeEnum" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.BdwShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.vo.AmountDetailVo" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.ShoppingCartProxy" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.proxy.UserCartListProxy" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.service.ShoppingCartProxyService" %>
<%@ page import="java.util.List" %>

<%@ include file="/template/bdw/module/common/taglibs.jsp" %>


<c:set value="${sdk:getLoginUser()}" var="loginUser"/> <%--获取当前用户--%>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="${empty param.carttype ? 'normal' : param.carttype}"/>

<%
    String carttype = (String)pageContext.getAttribute("carttype");
    if(WebContextFactory.getWebContext().getFrontEndUser() != null){
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
        for (ShoppingCart shoppingCart : userCartList.getCarts()){
            ResolverUtils.clacCartMisc(shoppingCart);
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

    //2015-11-30 lhw 因购物车只有在登录的时候才填充，为了避免不同浏览器购物车不同步的情况，当刷新页面时需要重新加载购物车
    Integer loginUserId = WebContextFactory.getWebContext().getFrontEndUserId();
    if(loginUserId != null){
        List<BdwShoppingCart> bdwShoppingCartList = ServiceManagerSafemall.bdwShoppingCartService.findByKey(IBdwShoppingCart.USER_ID, loginUserId);
        if(CartTypeEnum.NORMAL.toCode().equals(carttype)){
            UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), loginUserId);
            ServiceManager.shoppingCartStoreService.removeUserCartList(userCartList);
            if(!bdwShoppingCartList.isEmpty()){
                for(BdwShoppingCart bdwShoppingCart : bdwShoppingCartList){
                    if(bdwShoppingCart.getIsItemSelected().equals(BoolCodeEnum.NO.toCode())){
                        request.setAttribute("selectAll","N");
                        break;
                    }
                    request.setAttribute("selectAll", "Y");
                }
                ServiceManagerSafemall.bdwShoppingCartService.addCart(carttype);
            }
        }
    }
%>
  <c:set value="${sdk:getUserCartListProxy(carttype)}" var="userCartListProxy"/>
<script type="text/javascript">
    var cartObj = {allNum:"${userCartListProxy.allCartNum}"};
    $(function(){
        $("#top_myCart_cartNum").text(cartObj.allNum);
    })
</script>
    <c:choose>
        <c:when test="${empty userCartListProxy.shoppingCartProxyList}">
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

        </c:when>
        <c:otherwise>
            <ul class="nav">
                <li class="done"><span>1.查看购物车</span></li>
                <li><span>2.填写订单信息</span></li>
                <li><span><c:choose><c:when test="${param.isCod eq 'Y'}">3.确认货到付款订单信息</c:when><c:otherwise>3.付款到收银台</c:otherwise></c:choose></span></li>
                <li class="last"><span>4.收货评价</span></li>
            </ul>
            <div class="clear"></div>
            <div class="all"><input class="put selectAll" autocomplete="off" type="checkbox" style="vertical-align:middle" <c:if test="${selectAll == 'Y'}">checked="checked"</c:if> carttype="${carttype}" onclick="selectAll(this);"/> 全选</div>
            <c:forEach items="${userCartListProxy.shoppingCartProxyList}" var="shoppingCartProxy">
                <%--为了解决运费优惠再次命中，需要进入购物车时，清除zoneId--%>
                ${sdk:clearShoppingCartZoneId(carttype, shoppingCartProxy.orgId)}
                <c:if test="${shoppingCartProxy.cartNum>0}">
                    <div class="order">
                        <div class="nav">
                            <div class="shop">
                                <c:set value="${bdw:checkOrgSelected(carttype,shoppingCartProxy.orgId)}" var="isSelected"/>

                                <c:if test="${isSelected != null}">
                                    <input class="put checkPro" autocomplete="off" type="checkbox"  style="vertical-align:middle" <c:if test="${isSelected =='Y'}">checked="checked"</c:if> carttype="${carttype}" onclick="checkPro(this)"/>
                                </c:if>
                                <img src="${webRoot}/template/bdw/statics/images/96.png" style="vertical-align:middle;<c:if test="${empty isSelected}">margin-left:20px;</c:if>"/>
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
                                <c:if test="${not empty shoppingCartProxy.shopInf.qRCodeFileId}">
                                    <div  id="bigQrCode${shoppingCartProxy.shopInf.shopInfId}"class="bigQrCode" style="display:none;width: 200px;height: auto;" onmouseout="hide('${shoppingCartProxy.shopInf.shopInfId}')" >
                                        <img src="${shoppingCartProxy.shopInfProxy.qrDefaultImage}" width="200" height="200"/>
                                        <span id="qrTips">打开微信扫一扫，添加商家个人微信</span>
                                    </div>
                                    <img src="${webRoot}/template/bdw/statics/images/weixin001.png" width="26px" id="smallQrCode${shoppingCartProxy.shopInf.shopInfId}" onmouseover="show('${shoppingCartProxy.shopInf.shopInfId}')"/>
                                </c:if>

                            </div>
                            <div class="num"><span>数量</span></div>
                            <div class="price"><span>单价</span></div>
                            <div class="subtotal"><span>小计</span></div>
                            <div class="operation"><span>操作</span></div>
                        </div>
                        <div class="box">
                            <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                                <c:choose>
                                    <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                        <div class="info layer lostPro">
                                            <div class="left ">
                                                <ul>
                                                    <span class="put" style="margin-top: 14px; color: #6d0002;font-weight: bold">失效</span>
                                                    <c:if test="${cartItemProxy.promotionType!='COMBINED_PRODUCT'}">
                                                        <h2><img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></h2>
                                                    </c:if>
                                                    <li>
                                                        <h3>
                                                            <c:if test="${cartItemProxy.promotionType=='PRESENT'}"><span style="color: red">[赠品]</span></c:if>
                                                            <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}"><span style="color: red">[套餐]</span></c:if>${cartItemProxy.name}
                                                            <c:if test="${not empty cartItemProxy.specName}">（${cartItemProxy.specName})</c:if>
                                                        </h3>
                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                            <h4><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></h4>
                                                        </c:forEach>
                                                        <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                            <%--<h4><a href="${webRoot}/product-${combo.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a> <a href="${webRoot}/product-${combo.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span></h4>--%>
                                                            <h4><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/>${combo.name}<span style="line-height: 22px;">× ${combo.quantity}</span></h4>
                                                        </c:forEach>
                                                        <h4 style="color: darkred;margin-top: 4px;margin-bottom: 10px;">
                                                            <c:choose>
                                                                <c:when test="${not empty cartItemProxy.disabledReason}">
                                                                    ${cartItemProxy.disabledReason}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    该商品不能购买，请联系卖家
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </h4>
                                                    </li>
                                                </ul><div class="clear"></div>
                                            </div>
                                            <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                            <c:choose>
                                                <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                                    <div class="num">
                                                        <span style="margin-left: 55px;">${cartItemProxy.quantity}</span>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="num">
                                                        <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                            <label>套餐数量：</label>
                                                        </c:if>
                                                        <span style="margin-left: 55px;">${cartItemProxy.quantity}</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="price"><a style="text-decoration: none;">${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</a></div>
                                            <div class="subtotal"><a style="text-decoration: none;">${carttype=="integral" ?  "" : "￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</a></div>
                                            <div class="operation">
                                                    <%--<a href="#">寄存收藏夹</a>--%>
                                                <a class="delItem" onclick="delItem(this)" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}">删除此商品</a>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="info layer">
                                            <div class="left ">
                                                <ul>
                                                        <%--不是赠品才显示勾选框--%>
                                                    <c:if test="${cartItemProxy.promotionType!='PRESENT'}">
                                                        <input class="put updateSelect" autocomplete="off" itemKey="${cartItemProxy.itemKey}"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" type="checkbox" name="" style="vertical-align:middle" ${cartItemProxy.itemSelected  ?  "checked=true" : ""} onclick="updateSelect(this)"/>
                                                    </c:if>
                                                    <c:if test="${cartItemProxy.promotionType!='COMBINED_PRODUCT'}">
                                                        <%--<h2 <c:if test="${cartItemProxy.promotionType=='PRESENT'}">style="margin-left:42px;"</c:if>><a href="${webRoot}/product-${cartItemProxy.productId}.html"><img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></a></h2>--%>
                                                        <h2 style="position: relative;"<c:if test="${cartItemProxy.promotionType=='PRESENT'}">style="margin-left:42px;"</c:if>>
                                                        <%--判断是否是京东商品--%>
                                                        <c:if test="${cartItemProxy.productProxy.jdProductCode != null}">
                                                            <div style="position:absolute;z-index:5;width: 24px;left: 22px;top: -1px;border-radius:4px;border:#dbe0cb 1px solid;padding:3px;background-color:#ffa800;">京东</div>
                                                        </c:if>
                                                        <a href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                            <img src="${cartItemProxy.productProxy.defaultImage["50X50"]}" /></a></h2>
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
                                                            <%--<h4><img w  idth="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/><span style="line-height: 22px;">× ${combo.quantity}</span></h4>--%>
                                                        </c:forEach>
                                                    </li>
                                                </ul><div class="clear"></div>
                                            </div>
                                            <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                            <c:choose>
                                                <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                                    <div class="num">
                                                        <c:choose>
                                                            <c:when test="${cartItemProxy.promotionType!='PRESENT'}">
                                                                <input handler="${handler}" itemKey="${cartItemProxy.itemKey}" readonly="" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onchange="cartNum(this)" productId="${cartItemProxy.productId}"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="num" style="margin-top:8px;">
                                                                    <span style="margin-left: 55px;">${cartItemProxy.quantity}</span>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="num">
                                                        <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                            <label>套餐数量：</label>
                                                        </c:if>
                                                        <c:choose>
                                                            <c:when test="${cartItemProxy.promotionType=='PLATFORM_DISCOUNT'}">
                                                                <input handler="${curHandler}" itemKey="${cartItemProxy.itemKey}" autocomplete="off" maxlength="4" value="${cartItemProxy.quantity}" type="text"  class="text cartNum ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onchange="cartNum(this)" productId="${cartItemProxy.productId}"/>
                                                                <c:choose>
                                                                    <c:when test="${!cartItemProxy.btnIsCanAdd}">
                                                                        <a href="javascript:" class="lock"><img src="${webRoot}/template/bdw/statics/images/100.png" /></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="javascript:" itemKey="${cartItemProxy.itemKey}" handler="${curHandler}" class="addNum"  carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onclick="addNum(this);"><img src="${webRoot}/template/bdw/statics/images/100.png" /></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <a href="javascript:" carttype="${carttype}" handler="${curHandler}" class="subNum"  itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}" onclick="subNum(this);"><img src="${webRoot}/template/bdw/statics/images/101.png" /></a>
                                                                <div class="alertMessage" style="color:#f40;margin: 3px 0px;width: 128px">${cartItemProxy.cartItemMsg}</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input value="${cartItemProxy.quantity}" handler="${curHandler}" autocomplete="off" itemKey="${cartItemProxy.itemKey}" class="text cartNum2 ${cartItemProxy.itemKey}" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onchange="cartNum2(this);" productId="${cartItemProxy.productId}"/>
                                                                <c:choose>
                                                                    <c:when test="${!cartItemProxy.btnIsCanAdd}">
                                                                        <a href="javascript:" class="lock"><img src="${webRoot}/template/bdw/statics/images/100.png" /></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="javascript:" itemKey="${cartItemProxy.itemKey}"  handler="${curHandler}" class="addNum2" name="add" carttype="${carttype}" orgid="${shoppingCartProxy.orgId}" onclick="addNum(this);"><img src="${webRoot}/template/bdw/statics/images/100.png" /></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <a href="javascript:" carttype="${carttype}" handler="${curHandler}" class="subNum" itemKey="${cartItemProxy.itemKey}" orgid="${shoppingCartProxy.orgId}" onclick="subNum(this);"><img src="${webRoot}/template/bdw/statics/images/101.png" /></a>
                                                                <div class="alertMessage" style="color:#f40;margin: 3px 0px;">${cartItemProxy.cartItemMsg}</div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="price"><a style="text-decoration: none;">${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productUnitPrice}</a></div>
                                            <div class="subtotal"><a style="text-decoration: none;">${carttype=="integral" ?  "" : "￥"}${carttype=="integral" ? cartItemProxy.useUnitIntegral : cartItemProxy.productTotalAmount}</a></div>
                                            <div class="operation">
                                                    <%--<a href="#">寄存收藏夹</a>--%>
                                                    <%--不是赠品才显示删除商品链接--%>
                                                <c:if test="${cartItemProxy.promotionType!='PRESENT'}">
                                                    <a class="delItem ${cartItemProxy.itemKey}" href="javascript:" carttype="${carttype}" handler="${curHandler}" orgid="${shoppingCartProxy.orgId}" itemKey="${cartItemProxy.itemKey}" onclick="delItem(this);">删除此商品</a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
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
                    <input class="put selectAll" type="checkbox" name="" style="vertical-align:middle" <c:if test="${selectAll == 'Y'}">checked="checked"</c:if> carttype="${carttype}"  onclick="selectAll(this)"/>全选
                    <a href="javascript:;" class="delSelectedCart" carttype="${carttype}" handler="${handler}"><span>批量删除</span></a>
                    <a style="text-decoration: none;">商品件数总计：<span id="allCartNum">${userCartListProxy.selectCartNum}</span></a>
                    <a style="text-decoration: none;">赠送积分总计：<span id="allObtainTotalIntegral">${userCartListProxy.allObtainTotalIntegral}</span></a>
                    <a style="text-decoration: none;">促销优惠：<span id="allDiscount">${allDiscount}</span>元</a>
                    <a style="text-decoration: none;">商品金额总计：
                            <%--<em id="allProductTotalAmount">${userCartListProxy.allProductTotalAmount+userCartListProxy.allDiscount}</em>元--%>
                        <c:choose>
                            <c:when test="${userCartListProxy.allProductTotalAmount+allDiscount<0}">
                                <em id="allProductTotalAmount"><fmt:formatNumber value="0.0" type="number" pattern="#0.00#" /></em>元
                            </c:when>
                            <c:otherwise>
                                <em id="allProductTotalAmount"><fmt:formatNumber value="${userCartListProxy.allProductTotalAmount+allDiscount}" type="number" pattern="#0.00#" /></em>元
                            </c:otherwise>
                        </c:choose>
                    </a>
                </p>
                <div class="kd-popup" id="codTip" style="${userCartListProxy.checkedCod and userCartListProxy.unSupportCodNum>0?"display: block":"display: none"};">
                    <div class="box">
                        <div class="bd">
                            购物车中有&nbsp;<span id="noCodNum"  style="color :#CC0000;font-weight: bold;">${userCartListProxy.unSupportCodNum}</span>&nbsp;种宝贝不支持货到付款。
                        </div>
                        <a  class="m-close" id="m-close"  href="javascript:void(0);"></a>
                    </div>
                    <i class="bottom"></i>
                </div>
                <div class="settlement">
                        <%--货到付款--%>
                    <%--<div class="pay">
                        <div style="_margin-top:10px;">
                            <img src="${webRoot}/template/bdw/statics/images/95.png" style="vertical-align:middle"/>
                                &lt;%&ndash;<input class="put isCod" type="checkbox" name="" ${userCartListProxy.checkedCod ? "checked=checked" :""}  carttype="${carttype}" handler="${handler}" style="vertical-align:middle"/><a style="text-decoration: none;">使用货到付款</a>&ndash;%&gt;
                            <input class="put isCod" onclick="isCod(this)" type="checkbox" name="" <c:if test="${param.isCod eq 'Y'}">checked="checked"</c:if> carttype="${carttype}" handler="${handler}" style="vertical-align:middle"/><a style="text-decoration: none;">使用货到付款</a>
                        </div>
                    </div>--%>
                        <%--<div class="btn"><a href="javascript:;" style="text-decoration: none;" onclick="goToOrderAdd('${webRoot}/shoppingcart/orderadd.ac?carttype=${carttype}&handler=${handler}&isCod=${userCartListProxy.checkedCod?'Y':'N'}')">结    算</a></div>--%>
                    <div class="btn"><a href="javascript:void(0);" id="addCartResult" onclick="addCartResultClick(this)" carttype="${carttype}" handler="${handler}" isCod="${param.isCod == 'Y' ? 'Y' : 'N'}" style="text-decoration: none;">结    算</a></div>
                </div>
            </div>
        </c:otherwise>
</c:choose>
