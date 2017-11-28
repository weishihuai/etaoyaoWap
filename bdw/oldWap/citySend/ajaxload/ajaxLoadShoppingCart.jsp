<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.service.ShoppingCartProxyService" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/12/26
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set var="orgId" value="${param.orgId}"/>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="store"/>
<%
    SpringContextHolder.getBean(ShoppingCartProxyService.class).reloadCartForJSPPage(CartTypeEnum.STORE.toCode());
%>
<c:set value="${bdw:checkOrgAllSelected(carttype,orgId)}" var="isStoreOrgAllSelected"/>
<c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>

<!-- 查看购物车 -->
<div class="dropback"></div>
<div class="modal-dialog">
    <div class="modal-header">
        <a class="checkbox <c:if test="${isStoreOrgAllSelected == 'Y' && not empty storeCartProxy.cartItemProxyList}">active</c:if>" id="allSelect" carttype="${carttype}" orgid="${orgId}" href="javascript:">全选</a>
        <a class="clear fr" href="javascript:" onclick="delStoreAllCartItem(this);" carttype="${carttype}" orgid="${orgId}">清空</a>
    </div>
    <div class="modal-body">
        <c:choose>
            <c:when test="${not empty storeCartProxy.cartItemProxyList}">
                <ul>
                    <c:forEach items="${storeCartProxy.cartItemProxyList}" var="cartItemProxy">
                        <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                        <c:set var="itemKey" value="${cartItemProxy.itemKey}"/>
                        <c:set var="isSelected" value="${cartItemProxy.itemSelected}"/>
                        <c:set var="promotionType" value="${cartItemProxy.promotionType}"/>
                        <c:set value="${cartItemProxy.productUnitPrice}" var="unitPrice"/>
                        <%
                            Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                            String priceStr = String.valueOf(unitPrice);
                            String[] price = priceStr.split("[.]");
                            String intgerPrice = price[0];
                            String decimalPrice = price[1];
                            if (StringUtils.isBlank(decimalPrice)) {
                                decimalPrice = "00";
                            } else if (decimalPrice.length() < 2) {
                                decimalPrice += "0";
                            }
                            pageContext.setAttribute("intgerPrice", intgerPrice);
                            pageContext.setAttribute("decimalPrice", decimalPrice);
                        %>
                        <c:choose>
                            <c:when test="${cartItemProxy.isDisabled != 'Y'}">
                                <c:choose>
                                    <%--订单赠品--%>
                                    <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                        <li>
                                            <span class="gift">赠品</span>
                                            <div class="media">
                                                <div class="media-img">
                                                    <c:choose>
                                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                            <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="100px" height="100px">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="media-body">
                                                    <p class="media-tit">${cartItemProxy.name}</p>
                                                    <span class="price"><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                    <span class="num">x${cartItemProxy.quantity}</span>
                                                    <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.cartItemMsg}</p>
                                                </div>
                                            </div>
                                        </li>
                                    </c:when>
                                    <%--单品和套餐--%>
                                    <c:otherwise>
                                        <c:choose>
                                            <%--套餐--%>
                                            <c:when test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                <li style="padding-bottom: 3.0rem; ">
                                                    <a class="checkbox updateSelect <c:if test="${isSelected}">active</c:if>" itemKey="${itemKey}" carttype="${carttype}" orgid="${orgId}" href="javascript:"></a>
                                                    <div class="media">
                                                        <div class="media-img">
                                                            <c:choose>
                                                                <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="100px" height="100px">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="media-tit" style="width: 80%;margin-bottom:0.5rem;"><a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}" class="title">${cartItemProxy.name}</a></p>
                                                            <a href="javascript:" class="del" style="position:absolute;right: 0;top: 0;"
                                                               onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a>
                                                            <span class="price" ><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                            <div class="count">
                                                                <c:choose>
                                                                    <c:when test="${cartItemProxy.quantity>1}">
                                                                        <a class="op op-reduce" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="op op-reduce" href="javascript:" ></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <input class="val" id="" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                                                <c:choose>
                                                                    <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                        <a class="op op-add addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="storeBtnLock op op-add addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.cartItemMsg}</p>
                                                        </div>
                                                    </div>
                                                    <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                        <p class="other">
                                                            <span style="float: left;"><img width="20" height="20" src="${bdw:getAllStatusProductById(combo.productId).defaultImage['40X40']}"/></span>
                                                            <span class="fl" style="font-size:1.0rem; ">${combo.name}</span>
                                                            <span class="fr">x${combo.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                    <%--赠品--%>
                                                    <c:forEach items="${cartItemProxy.presents}" var="present">
                                                        <p class="other">
                                                            <span class="fl">[赠品] ${present.name}</span>
                                                            <span class="fr">x${present.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                </li>
                                            </c:when>
                                            <%--单品--%>
                                            <c:otherwise>
                                                <li style="padding-bottom: 3.0rem;">
                                                    <a class="checkbox updateSelect <c:if test="${isSelected}">active</c:if>" itemKey="${itemKey}" carttype="${carttype}" orgid="${orgId}" href="javascript:"></a>
                                                    <div class="media">
                                                        <div class="media-img">
                                                            <a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                                                                <c:choose>
                                                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                        <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="media-tit" style="width: 80%;margin-bottom:0.5rem;"><a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}" class="title">${cartItemProxy.name}</a></p>
                                                            <c:if test="${not empty cartItemProxy.specName}"><p class="media-desc" style="height: 2.2rem;overflow: hidden;margin-bottom: 1rem;">规格:${cartItemProxy.specName}</p></c:if>
                                                            <a href="javascript:" class="del" style="position:absolute;right: 0;top: 0;"
                                                               onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a>
                                                            <c:set value="${cartItemProxy.productUnitPrice}" var="unitPrice"/>
                                                            <span class="price"><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                            <div class="count">
                                                                <c:choose>
                                                                    <c:when test="${cartItemProxy.quantity>1}">
                                                                        <a class="op op-reduce" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="op op-reduce" href="javascript:" ></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <input class="val" id="" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                                                <c:choose>
                                                                    <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                        <a class="op op-add addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="storeBtnLock op op-add addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}"></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.cartItemMsg}</p>
                                                        </div>
                                                    </div>
                                                        <%--单品赠品--%>
                                                    <c:forEach items="${cartItemProxy.presents}" var="present">
                                                        <p class="other" style="font-size: 1.1rem; padding-top: 1.5rem;">
                                                            <span class="fl"><span style="color: red;">[赠品]</span> ${present.name}</span>
                                                            <span class="fr">x${present.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <%--订单赠品--%>
                                    <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                        <li style="padding-bottom: 3.0rem;">
                                            <span class="gift" <%--采用赠品的样式gift--%>>失效</span>
                                            <div class="media">
                                                <div class="media-img">
                                                    <a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                                                        <c:choose>
                                                            <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </div>
                                                <div class="media-body">
                                                    <p class="media-tit" style="width: 80%;margin-bottom:0.5rem;"><a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}" class="title">${cartItemProxy.name}</a></p>
                                                    <c:if test="${not empty cartItemProxy.specName}"><p class="media-desc" style="height: 2.2rem;overflow: hidden;margin-bottom: 1rem;">规格:${cartItemProxy.specName}</p></c:if>
                                                    <a href="javascript:" class="del" style="position:absolute;right: 0;top: 0;"
                                                       onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a>
                                                    <span class="price" ><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                    <div class="count">
                                                        <span style="font-size: 1.2rem; color: #666;">x${cartItemProxy.quantity}</span>
                                                    </div>
                                                    <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.disabledReason}</p>
                                                </div>
                                            </div>
                                                <%--单品赠品--%>
                                            <c:forEach items="${cartItemProxy.presents}" var="present">
                                                <p class="other" style="font-size: 1.2rem; padding-top: 1.5rem;">
                                                    <span class="fl"><span style="color: red;">[赠品]</span> ${present.name}</span>
                                                    <span class="fr">x${present.quantity}</span>
                                                </p>
                                            </c:forEach>
                                        </li>
                                    </c:when>
                                    <%--单品和套餐--%>
                                    <c:otherwise>
                                        <c:choose>
                                            <%--套餐--%>
                                            <c:when test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                <%-- 失效 --%>
                                                <li>
                                                    <span class="gift" <%--采用赠品的样式gift--%>>失效</span>
                                                    <div class="media">
                                                        <div class="media-img">
                                                            <c:choose>
                                                                <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="100px" height="100px">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="media-tit" style="width: 80%;margin-bottom:0.5rem;"><a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}" class="title">${cartItemProxy.name}</a></p>
                                                            <a href="javascript:" class="del" style="position:absolute;right: 0;top: 0;"
                                                               onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a>
                                                            <span class="price" ><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                            <div class="count">
                                                                <span style="font-size: 1.2rem; color: #666;">x${cartItemProxy.quantity}</span>
                                                            </div>
                                                            <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.disabledReason}</p>
                                                        </div>

                                                    </div>
                                                    <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                        <p class="other">
                                                            <span style="float: left;"><img width="20" height="20" src="${bdw:getAllStatusProductById(combo.productId).defaultImage['40X40']}"/></span>
                                                            <span class="fl">${combo.name}</span>
                                                            <span class="fr">x${combo.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                    <%--赠品--%>
                                                    <c:forEach items="${cartItemProxy.presents}" var="present">
                                                        <p class="other">
                                                            <span class="fl">[赠品] ${present.name}</span>
                                                            <span class="fr">x${present.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                </li>
                                            </c:when>
                                            <%--单品--%>
                                            <c:otherwise>
                                                <%-- 失效 --%>
                                                <li style="padding-bottom: 3.0rem;">
                                                    <span class="gift" <%--采用赠品的样式gift--%>>失效</span>
                                                    <div class="media">
                                                        <div class="media-img">
                                                            <a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}">
                                                                <c:choose>
                                                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                        <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${webRoot}/template/bdw/statics/images/noPic_100X100.jpg" alt="${cartItemProxy.name}" style="width: 100%;height: 100%;">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="media-tit" style="width: 80%;margin-bottom:0.5rem;"><a href="${webRoot}/wap/citySend/product.ac?productId=${cartItemProxy.productId}" class="title">${cartItemProxy.name}</a></p>
                                                            <c:if test="${not empty cartItemProxy.specName}"><p class="media-desc" style="height: 2.2rem;overflow: hidden;margin-bottom: 1rem;">规格:${cartItemProxy.specName}</p></c:if>
                                                            <a href="javascript:" class="del" style="position:absolute;right: 0;top: 0;"
                                                               onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a>
                                                            <span class="price" ><small>&yen;&nbsp;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
                                                            <div class="count">
                                                                <span style="font-size: 1.2rem; color: #666;">x${cartItemProxy.quantity}</span>
                                                            </div>
                                                            <p style="font-size: 1rem; color: #cc6600;margin-top: 4px;">${cartItemProxy.disabledReason}</p>
                                                        </div>
                                                    </div>
                                                    <%--单品赠品--%>
                                                    <c:forEach items="${cartItemProxy.presents}" var="present">
                                                        <p class="other" style="font-size: 1.2rem; padding-top: 1.5rem;">
                                                            <span class="fl"><span style="color: red;">[赠品]</span> ${present.name}</span>
                                                            <span class="fr">x${present.quantity}</span>
                                                        </p>
                                                    </c:forEach>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
                <c:if test="${fn:length(storeCartProxy.discountDetails)>0}">
                    <div style="padding:5px 15px; font-size: 1.0rem; color: #333; background-color: #fff4e1; border-bottom: 1px solid #e6e6e6;">
                        <span style="color: #9c8a8a">店铺优惠：</span>
                        <c:forEach items="${storeCartProxy.discountDetails}" var="discount" varStatus="s">
                            <span style="line-height: 30px;color:rgba(156, 138, 138, 0.88)">${discount.amountNm}</span>
                            <c:if test="${!s.last}">,&nbsp;</c:if>
                        </c:forEach>

                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="store-cart-empty">
                    <div class="warp">
                        <i class="icon-normal-cart-empty"></i>
                        <p class="text">购物车还是空滴</p>
                        <a class="shop" href="javascript:" onclick="closeAjaxLoadShoppingCart()">继续购物&gt;&gt;</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

