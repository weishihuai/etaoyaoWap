<%@ page import="com.iloosen.imall.commons.util.holder.SpringContextHolder" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="com.iloosen.imall.sdk.shoppingcart.service.ShoppingCartProxyService" %>
<%--
  Created by IntelliJ IDEA.
  User: lhw
  Date: 2016/11/16
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getLoginUser()}" var="user"/>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="store"/>
<jsp:useBean id="dataTime" class="java.util.Date" />
<script type="text/javascript">
    var Top_Path = {webUrl: "${webUrl}", webRoot: "${webRoot}", topParam: "${param.p}", keyword: "${param.keyword}", webName: "${webName}",userId:"${user.userId}",handler : "${handler}",carttype : "${carttype}"};
    $(function(){
        var userId = Top_Path.userId;
        $("#cartLayer").click(function () {

            if(undefined == userId || null == userId || "" == userId) {
                loadHideCart();
                showUserLogin();
            }
        });
        $("#storeCartLayer").click(function () {
            var orgid = $(this).attr("orgid");
            if(undefined == userId || null == userId || "" == userId) {
                loadStoreHideCart(orgid);
                showUserLogin();
            }
        });

    });
</script>
<c:set var="handler" value="${empty param.handler ? 'sku' : param.handler}"/>
<c:set var="carttype" value="store"/>
<style type="text/css">
    .btnLock{ opacity: 0.2; cursor: not-allowed;}
    .storeBtnLock{opacity: 0.4; border:1px solid;cursor: not-allowed;}
</style>
<%
    SpringContextHolder.getBean(ShoppingCartProxyService.class).reloadCartForJSPPage(CartTypeEnum.STORE.toCode());
%>


<c:if test="${param.p != 'index'}">
    <%--购物车--%>
    <c:if test="${param.p == 'storeList' || param.p == 'productList' || param.p == 'prdDetail'}">
        <c:set var="citySendUserCartListProxy" value="${bdw:getCitySendShoppingCartProxy()}"/>
        <c:set var="cartNum" value="${citySendUserCartListProxy.allCartNum}" />
        <%--所有门店的购物车--%>
        <!-- 购物车-图标-->
        <div class="cart-toggle" id="cartLayer">
            <i class="icon-cart"></i>
            <span>购物车</span>
            <c:choose>
                <c:when test="${empty user}">
                    <em>0</em>
                </c:when>
                <c:otherwise>
                    <em>${cartNum}</em>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- 购物车-内容 -->
        <div class="cart-target" id="allStoreCart">
            <div class="cart-content" id="cartContent">
                <h2>淘药店购物车<em>(${cartNum})</em></h2>
                <c:choose>
                    <c:when test="${not empty citySendUserCartListProxy.shoppingCartProxyList && citySendUserCartListProxy.allCartNum>0}">
                        <c:set value="${citySendUserCartListProxy.shoppingCartProxyList}" var="shoppingCartProxyList"/>
                        <%--购物车中有商品--%>
                        <ul class="cart-th">
                            <li class="th th-chk">
              <span class="checkbox" aria-disabled="true">
                <i class="icon lock"></i>&emsp;勾选
              </span>
                            </li>
                            <li class="th th-detail">商品信息</li>
                            <li class="th th-price">会员价</li>
                            <li class="th th-count">数量</li>
                            <li class="th th-opera">操作</li>
                        </ul>
                        <div class="order-list">
                            <c:forEach items="${shoppingCartProxyList}" var="shoppingCartProxy">
                                <c:set value="${shoppingCartProxy.orgId}" var="sysorgid"/>
                                <c:set value="${bdw:checkOrgSelected(carttype,shoppingCartProxy.orgId)}" var="isOrgSelected"/>
                                <c:set value="${bdw:checkOrgAllSelected(carttype,shoppingCartProxy.orgId)}" var="isOrgAllSelected"/>
                                ${sdk:clearShoppingCartZoneId(carttype, sysorgid)}
                                <c:if test="${fn:length(shoppingCartProxy.cartItemProxyList)>0}">
                                    <div class="order-holder">
                                        <div class="shop">
                                            <h3>
                      <span class="<c:if test="${isOrgSelected == 'Y'}">active</c:if> checkbox cbox${sysorgid}" carttype="${carttype}" orgid="${sysorgid}" onclick="selectAll(this,'${sysorgid}')">
                        <i class="icon"></i>
                      </span>&emsp;
                                                <a href="${webRoot}/citySend/storeDetail.ac?orgId=${sysorgid}" title="${shoppingCartProxy.shopInf.shopNm}">${shoppingCartProxy.shopInf.shopNm}&ensp;<i>&gt;</i></a>
                                            </h3>
                                        </div>
                                        <div class="order-content">
                                            <ul class="bundle">
                                                <c:forEach items="${shoppingCartProxy.cartItemProxyList}" var="cartItemProxy">
                                                    <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                                    <c:set var="itemKey" value="${cartItemProxy.itemKey}"/>
                                                    <c:set var="isSelected" value="${cartItemProxy.itemSelected}"/>
                                                    <c:set var="promotionType" value="${cartItemProxy.promotionType}"/>
                                                    <c:choose>
                                                        <%--失效商品--%>
                                                        <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                                            <c:choose>
                                                                <%--赠品--%>
                                                                <c:when test="${cartItemProxy.promotionType=='PRESENT' || cartItemProxy.promotionType=='REDEMPTION'}">
                                                                    <li class="item">
                                                                            <%--不要显示复选框--%>
                                                                        <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                                                            <%--商品名称--%>
                                                                        <div class="td td-detail">
                                                                            <div class="item-img">
                                                                                <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                                                                    <c:choose>
                                                                                        <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                            <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </a>
                                                                            </div>
                                                                            <div class="item-info">
                                                                                <p class="item-base-info"><a href="javascript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                            </div>
                                                                        </div>
                                                                            <%--商品价格--%>
                                                                        <div class="td td-price">
                                                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        </div>
                                                                            <%--数量显示即可，不需要任何操作--%>
                                                                        <div class="td td-count">
                                                                            <div class="amount" style="text-align: center;border: 0px">${cartItemProxy.quantity}</div>
                                                                            <p>
                                                                                <c:choose>
                                                                                    <c:when test="${not empty cartItemProxy.disabledReason}">
                                                                                        ${cartItemProxy.disabledReason}
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        该商品不能购买，请联系卖家
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </div>
                                                                        <div class="td td-opera">
                                                                                <%--<a href="javascript:" title="移到收藏夹">移到收藏夹</a>--%>
                                                                            <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                                                        </div>
                                                                    </li>
                                                                </c:when>
                                                                <%--单品和套餐--%>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <%--套餐--%>
                                                                        <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                                                            <li class="item">
                                                                                    <%--复选框--%>
                                                                                <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                                                                    <%--商品名称--%>
                                                                                <div class="td td-detail">
                                                                                    <div class="item-img">
                                                                                        <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                                                                            <c:choose>
                                                                                                <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="item-info">
                                                                                        <p class="item-base-info"><a href="javascript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                            <%--套餐单项商品--%>
                                                                                        <c:if test="${cartItemProxy.promotionType=='COMBINED_PRODUCT'}">
                                                                                            <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                                                <p class="item-other-info elli">
                                                                                                    <a href="javascript:void(0);"><img width="20" height="20" src="${bdw:getAllStatusProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                                                                    <a href="javascript:void(0);">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                                                                </p>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                            <%--赠品--%>
                                                                                        <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                                                            <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                                                <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                            <%--规格--%>
                                                                                        <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                                    </div>
                                                                                </div>
                                                                                    <%--  <div class="td td-standard">
                                                                                        <span>10ml*10支</span>
                                                                                      </div>--%>
                                                                                    <%--商品价格--%>
                                                                                <div class="td td-price">
                                                                                    <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                                </div>
                                                                                    <%--数量操作--%>
                                                                                <div class="td td-count">
                                                                                    <div class="amount" style="text-align: center;border: 0px">${cartItemProxy.quantity}</div>
                                                                                        <%--提示信息--%>
                                                                                    <p>${cartItemProxy.disabledReason}</p>
                                                                                </div>
                                                                                    <%--订单项操作--%>
                                                                                <div class="td td-opera">
                                                                                        <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                                                                    <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                                                                </div>
                                                                            </li>
                                                                        </c:when>
                                                                        <%--单品--%>
                                                                        <c:otherwise>
                                                                            <li class="item">
                                                                                    <%--复选框--%>
                                                                                <div class="td td-chk" style="color: #bbb;font-size: 13px;">失效</div>
                                                                                    <%--商品名称--%>
                                                                                <div class="td td-detail">
                                                                                    <div class="item-img">
                                                                                        <a href="javascript:void(0);" title="${cartItemProxy.name}">
                                                                                            <c:choose>
                                                                                                <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                                    <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="item-info">
                                                                                        <p class="item-base-info"><a href="javaScript:void(0);" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                            <%--赠品--%>
                                                                                        <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                                                            <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                                                <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                            <%--规格--%>
                                                                                        <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                                    </div>
                                                                                </div>
                                                                                    <%--  <div class="td td-standard">
                                                                                        <span>10ml*10支</span>
                                                                                      </div>--%>
                                                                                    <%--商品价格--%>
                                                                                <div class="td td-price">
                                                                                    <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                                </div>
                                                                                    <%--数量操作--%>
                                                                                <div class="td td-count">
                                                                                    <div class="amount" style="text-align: center;border:0px;">${cartItemProxy.quantity}</div>
                                                                                        <%--提示信息--%>
                                                                                    <p>${cartItemProxy.disabledReason}</p>
                                                                                </div>
                                                                                    <%--订单项操作--%>
                                                                                <div class="td td-opera">
                                                                                        <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                                                                    <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                                                                </div>
                                                                            </li>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <%--有效商品--%>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <%--订单赠品--%>
                                                                <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                                                    <li class="item">
                                                                            <%--不要显示复选框--%>
                                                                        <div class="td td-chk"></div>
                                                                            <%--商品名称--%>
                                                                        <div class="td td-detail">
                                                                            <div class="item-img">
                                                                                <a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                                                                    <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                                                                </a>
                                                                            </div>
                                                                            <div class="item-info">
                                                                                <p class="item-base-info"><a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                                <p class="item-other-info elli"><span>订单赠品</span></p>
                                                                            </div>
                                                                        </div>
                                                                            <%--商品价格--%>
                                                                        <div class="td td-price">
                                                                            <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        </div>
                                                                            <%--数量显示即可，不需要任何操作--%>
                                                                        <div class="td td-count">
                                                                            <div class="amount" style="border:0;text-align: center;">${cartItemProxy.quantity}</div>
                                                                                <%--不要提示信息--%>
                                                                            <p>${cartItemProxy.cartItemMsg}</p>
                                                                        </div>
                                                                            <%--不要订单项操作--%>
                                                                        <div class="td td-opera">
                                                                                <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                                                                <%-- <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>--%>
                                                                        </div>
                                                                    </li>

                                                                </c:when>
                                                                <%--单品和套餐--%>
                                                                <c:otherwise>
                                                                    <c:choose>
                                                                        <%--套餐--%>
                                                                        <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                                                            <li class="item">
                                                                                    <%--复选框--%>
                                                                                <div class="td td-chk">
                                      <span class="checkbox item${sysorgid} updateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${sysorgid}">
                                        <i class="icon"></i>
                                      </span>
                                                                                </div>
                                                                                    <%--商品名称--%>
                                                                                <div class="td td-detail">
                                                                                    <div class="item-img">
                                                                                        <a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                                                                            <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="item-info">
                                                                                        <p class="item-base-info"><a href="${webRoot}/product=${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                            <%--规格--%>
                                                                                        <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                                            <%--套餐单项商品--%>
                                                                                        <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                                            <p class="item-other-info elli">
                                                                                                <a href="${webRoot}/product-${combo.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                                                                <a href="${webRoot}/product-${combo.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                                                            </p>
                                                                                        </c:forEach>
                                                                                            <%--赠品--%>
                                                                                        <c:if test="${cartItemProxy.promotionType=='PRESENT'}">
                                                                                            <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                                                <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                                                            </c:forEach>
                                                                                        </c:if>
                                                                                    </div>
                                                                                </div>
                                                                                    <%--商品价格--%>
                                                                                <div class="td td-price">
                                                                                    <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                                </div>
                                                                                    <%--数量操作--%>
                                                                                <div class="td td-count">
                                                                                    <div class="amount">
                                                                                        <c:choose>
                                                                                            <c:when test="${cartItemProxy.quantity>1}">
                                                                                                <a class="amount-opera subNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}" productId="${cartItemProxy.productId}">&minus;</a>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <a class="amount-opera btnLock" href="javascript:">&minus;</a>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                        <input class="amount-inp cartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">
                                                                                        <c:choose>
                                                                                            <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                                                <a class="amount-opera addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">&plus;</a>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <a class="amount-opera btnLock" href="javascript:" >&plus;</a>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                        <%--提示信息--%>
                                                                                    <p>${cartItemProxy.cartItemMsg}</p>
                                                                                </div>
                                                                                    <%--订单项操作--%>
                                                                                <div class="td td-opera">
                                                                                        <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                                                                    <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                                                                </div>
                                                                            </li>
                                                                        </c:when>
                                                                        <%--单品--%>
                                                                        <c:otherwise>
                                                                            <li class="item">
                                                                                    <%--复选框--%>
                                                                                <div class="td td-chk">
                                      <span class="checkbox item${sysorgid} updateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${sysorgid}">
                                        <i class="icon"></i>
                                      </span>
                                                                                </div>
                                                                                    <%--商品名称--%>
                                                                                <div class="td td-detail">
                                                                                    <div class="item-img">
                                                                                        <a href="${webRoot}/product-${cartItemProxy.productId}.html" title="${cartItemProxy.name}">
                                                                                            <img src="${cartItemProxy.productProxy.defaultImage["80X80"]}" alt="${cartItemProxy.name}">
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="item-info">
                                                                                        <p class="item-base-info"><a href="${webRoot}/product-${cartItemProxy.productId}.html" title="${cartItemProxy.name}">${cartItemProxy.name}</a></p>
                                                                                            <%--规格--%>
                                                                                        <c:if test="${cartItemProxy.specName}"><p class="item-other-info elli">规格：${cartItemProxy.specName}</p></c:if>
                                                                                            <%--赠品--%>
                                                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                                            <p class="item-other-info elli">赠品：${present.name}<em>× ${present.quantity}</em></p>
                                                                                        </c:forEach>
                                                                                    </div>
                                                                                </div>
                                                                                    <%--  <div class="td td-standard">
                                                                                        <span>10ml*10支</span>
                                                                                      </div>--%>
                                                                                    <%--商品价格--%>
                                                                                <div class="td td-price">
                                                                                    <span>&yen;${cartItemProxy.productUnitPrice}</span>
                                                                                </div>
                                                                                    <%--数量操作--%>
                                                                                <div class="td td-count">
                                                                                    <div class="amount">
                                                                                        <c:choose>
                                                                                            <c:when test="${cartItemProxy.quantity>1}">
                                                                                                <a class="amount-opera subNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}" productId="${cartItemProxy.productId}">&minus;</a>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <a class="amount-opera btnLock" href="javascript:">&minus;</a>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                        <input class="amount-inp cartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">
                                                                                        <c:choose>
                                                                                            <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                                                <a class="amount-opera addNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${sysorgid}">&plus;</a>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <a class="amount-opera btnLock" href="javascript:" >&plus;</a>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                        <%--提示信息--%>
                                                                                    <p>${cartItemProxy.cartItemMsg}</p>
                                                                                </div>
                                                                                    <%--订单项操作--%>
                                                                                <div class="td td-opera">
                                                                                        <%-- <a href="javascript:;" title="移到收藏夹">移到收藏夹</a>--%>
                                                                                    <a href="javascript:" class="delItem" style="margin-left: 11px;" title="删除" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${sysorgid}" onclick="delItem(this)">删除</a>
                                                                                </div>
                                                                            </li>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </ul>
                                            <div class="total clearfix">
                    <span class="<c:if test="${isOrgAllSelected=='Y'}">active</c:if> checkbox fl" orgid="${sysorgid}" carttype="${carttype}" onclick="selectAll(this,'${sysorgid}')">
                        <i class="icon"></i>&emsp;全选
                    </span>
                                                <a class="btn-link fl" href="javascript:" onclick="delSelectedItem(this);" carttype="${carttype}" orgid="${sysorgid}">删除选中的商品</a>
                                                    <%-- <a class="btn-link fl" href="javascript:">移到收藏夹</a>--%>
                                                <a class="btn-link fl" href="${webRoot}/citySend/index.ac">继续购物</a>
                                                <c:choose>
                                                    <c:when test="${shoppingCartProxy.selectedCartItemNum>0}">
                                                        <a class="btn-checkout fr addCartResult" href="javascript:" carttype="${carttype}" handler="${handler}" orgid="${sysorgid}">确认结算</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="btn-checkout fr" href="javascript:" style="background-color: #ccc;" aria-disabled="true">确认结算</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <p class="fr">已选商品&ensp;<em id="allCartNum">${shoppingCartProxy.selectedCartItemNum}</em>&ensp;件；商品金额合计（不含运费）：<strong><small>&yen;&nbsp;</small><em id="allProductTotalAmount"><fmt:formatNumber value="${shoppingCartProxy.realProductTotalAmount}" type="number" pattern="#0.00#" /></em></strong></p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="cart-empty">
                            <div class="warp">
                                <i class="icon-normal-cart-empty"></i>
                                <p class="text">购物车还是空滴</p>
                                <a class="shop" href="${webRoot}/citySend/index.ac">继续购物&gt;&gt;</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <%--购物车伸缩动画--%>
        <script>
            $(function() {
                var $cartToggle = $('.cart-toggle'),
                        $cartTarget = $('.cart-target'),
                        $cartContent = $cartTarget.find('.cart-content'),
                        iW = $cartContent.width();
                $cartToggle.toggle(function() {
                    if($("#cartLayer").css("right")=='1260px'){
                        $(this).animate({
                            'right': '0'
                        }, 1000);

                        $cartContent.animate({
                            'right': '-1260px'
                        }, 1000, function() {
                            $cartTarget.hide('slow');

                            $('body').css({
                                overflow: 'auto'
                            });
                        });
                    }else{
                        $('body').css({
                            overflow: 'hidden'
                        });

                        $(this).animate({
                            'right': '1260px'
                        }, 1000);

                        $cartTarget.show('slow');

                        $cartContent.animate({
                            'right': '0'
                        }, 1000);
                    }
                }, function() {
                    if($("#cartLayer").css("right")=='1260px'){
                        $(this).animate({
                            'right': '0'
                        }, 1000);

                        $cartContent.animate({
                            'right': '-1260px'
                        }, 1000, function() {
                            $cartTarget.hide('slow');

                            $('body').css({
                                overflow: 'auto'
                            });
                        });
                    }else{
                        $('body').css({
                            overflow: 'hidden'
                        });

                        $(this).animate({
                            'right': '1260px'
                        }, 1000);

                        $cartTarget.show('slow');

                        $cartContent.animate({
                            'right': '0'
                        }, 1000);
                    }
                });
            });
        </script>
    </c:if>

    <c:if test="${param.p == 'storeDetail'}">
        <c:set var="orgId" value="${param.orgId}"/>
        <c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(orgId)}"/>
        <c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />
        <%--单门店的购物车--%>
        <!-- 购物车入口 -->
        <div class="cart-toggle storeCartToggle" id="storeCartLayer" orgid="${orgId}">
            <a href="javascript:" title="购物车" id="toggleCart" orgid="${orgId}">
                <c:choose>
                    <c:when test="${empty user}">
                        <span>0</span>
                    </c:when>
                    <c:otherwise>
                        <span>${storeCartNum}</span>
                    </c:otherwise>
                </c:choose>
                <i class="icon-cart-lg"></i>
            </a>
        </div>
        <!-- 购物车内容-->
        <c:set value="${bdw:checkOrgSelected(carttype,orgId)}" var="isStoreOrgSelected"/>
        <c:set value="${bdw:checkOrgAllSelected(carttype,orgId)}" var="isStoreOrgAllSelected"/>
        ${sdk:clearShoppingCartZoneId(carttype, orgId)}
        <div class="cart-target storeCartTarget" id="singleStoreCart">
            <div class="cart-content" id="singleCartContent">
                <dl>
                    <dt>
                        <c:if test="${not empty storeCartProxy && storeCartNum>0}">
             <span class="<c:if test="${isStoreOrgAllSelected == 'Y'}">active</c:if> checkbox" id="allSelect" carttype="${carttype}" orgid="${orgId}">
            <i class="icon"></i> 全选
          </span>
                        </c:if>
                        <c:if test="${storeCartNum > 0}">
                            <a class="delete-selected" href="javascript:;" onclick="deleSelectedItemInOneMerchant(this);" carttype="${carttype}" orgid="${orgId}">删除选中的商品</a>
                        </c:if>
                    </dt>
                    <dd>
                        <ul>
                            <c:choose>
                                <c:when test="${empty storeCartProxy || storeCartNum<=0}">
                                    <div class="store-cart-empty">
                                        <div class="warp">
                                            <i class="icon-normal-cart-empty"></i>
                                            <p class="text">购物车还是空滴</p>
                                            <a class="shop" href="${webRoot}/citySend/index.ac">继续购物&gt;&gt;</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${storeCartProxy.cartItemProxyList}" var="cartItemProxy">
                                        <c:set var="curHandler" value="${cartItemProxy.promotionType=='COMBINED_PRODUCT' ? 'combo' : handler}"/>
                                        <c:set var="itemKey" value="${cartItemProxy.itemKey}"/>
                                        <c:set var="isSelected" value="${cartItemProxy.itemSelected}"/>
                                        <c:set var="promotionType" value="${cartItemProxy.promotionType}"/>
                                        <c:choose>
                                            <%--失效--%>
                                            <c:when test="${cartItemProxy.isDisabled == 'Y'}">
                                                <c:choose>
                                                    <%--订单赠品--%>
                                                    <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                                        <li class="media">
                                                            <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">失效</span>
                                                            <a class="media-left" href="javascript:void(0);">
                                                                <c:choose>
                                                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                        <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                            <div class="media-body">
                                                                <a class="media-heading" href="javascript:void(0);">${cartItemProxy.name}<span style="color: red;;">(订单赠品)</span></a>
                                                                <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                                                <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                            </div>
                                                            <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                                                        </li>
                                                    </c:when>
                                                    <%--单品与套餐--%>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <%--套餐--%>
                                                            <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                                                <li class="media">
                                <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">
                                   失效
                                </span>
                                                                    <a class="media-left" href="javascript:void(0);">
                                                                        <c:choose>
                                                                            <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                    <div class="media-body">
                                                                        <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                                                        <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                            <%--套餐单项品--%>
                                                                        <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                            <p>
                                                                                <a href="javascript:void(0);"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                                                <a href="javascript:void(0);">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                                            </p>
                                                                        </c:forEach>
                                                                            <%--赠品--%>
                                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                            <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                                                        </c:forEach>
                                                                        <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                                                        <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                                                                    </div>
                                                                </li>
                                                            </c:when>
                                                            <%--单品--%>
                                                            <c:otherwise>
                                                                <li class="media">
                                <span class="checkbox sitem${orgId}" style="color: #bbb;font-size: 12px;">
                                   失效
                                </span>
                                                                    <a class="media-left" href="javascript:void(0);">
                                                                        <c:choose>
                                                                            <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                    <div class="media-body">
                                                                        <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                                                        <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                            <%--赠品--%>
                                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                            <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                                                        </c:forEach>
                                                                        <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                                                        <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.disabledReason}</p>
                                                                    </div>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <%--有效--%>
                                            <c:otherwise>
                                                <c:choose>
                                                    <%--订单赠品--%>
                                                    <c:when test="${promotionType=='PRESENT' || promotionType=='REDEMPTION'}">
                                                        <li class="media">
                                                            <span class="checkbox sitem${orgId} supdateSelect"></span>
                                                            <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                <c:choose>
                                                                    <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                        <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                            <div class="media-body">
                                                                <a class="media-heading" href="${webRoot}/product-${cartItemProxy.productId}.html">${cartItemProxy.name}<span style="color: red;;">(订单赠品)</span></a>
                                                                <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                <div class="amount" style="margin-left: 34px;border: 0px;">${cartItemProxy.quantity}</div>
                                                                <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                                <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                                            </div>
                                                        </li>
                                                    </c:when>
                                                    <%--单品与套餐--%>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <%--套餐--%>
                                                            <c:when test="${promotionType=='COMBINED_PRODUCT'}">
                                                                <li class="media">
                                <span class="checkbox sitem${orgId} supdateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${orgId}">
                                    <i class="icon"></i>
                                </span>
                                                                    <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                        <c:choose>
                                                                            <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                    <div class="media-body">
                                                                        <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                                                        <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                            <%--套餐单项品--%>
                                                                        <c:forEach items="${cartItemProxy.combos}" var="combo">
                                                                            <p>
                                                                                <a href="${webRoot}/product-${cartItemProxy.productId}.html"><img width="20" height="20" src="${bdw:getProductById(combo.productId).defaultImage['40X40']}"/></a>
                                                                                <a href="${webRoot}/product-${cartItemProxy.productId}.html">${combo.name}</a><span style="line-height: 22px;">× ${combo.quantity}</span>
                                                                            </p>
                                                                        </c:forEach>
                                                                            <%--赠品--%>
                                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                            <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                                                        </c:forEach>

                                                                        <div class="amount">
                                                                            <c:choose>
                                                                                <c:when test="${cartItemProxy.quantity>1}">
                                                                                    <a class="amount-opera ssubNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">−</a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a class="amount-opera storeBtnLock" href="javascript:">−</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <input class="amount-inp scartNum" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                                                            <c:choose>
                                                                                <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                                    <a class="amount-opera saddNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">+</a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a class="amount-opera storeBtnLock" href="javascript:">+</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                                                    </div>
                                                                </li>
                                                            </c:when>
                                                            <%--单品--%>
                                                            <c:otherwise>
                                                                <li class="media">
                                <span class="checkbox sitem${orgId} supdateSelect <c:if test="${isSelected}">active</c:if>" autocomplete="off" itemKey="${itemKey}"  carttype="${carttype}" orgid="${orgId}">
                                    <i class="icon"></i>
                                </span>
                                                                    <a class="media-left" href="${webRoot}/product-${cartItemProxy.productId}.html">
                                                                        <c:choose>
                                                                            <c:when test="${not empty cartItemProxy.images.imageValueEntryList && not empty cartItemProxy.images.imageValueEntryList[0].sysFileUrl}">
                                                                                <img src="${cartItemProxy.images.imageValueEntryList[0].sysFileUrl}" alt="${cartItemProxy.name}" width="80px" height="80px">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <img src="${webRoot}/template/bdw/statics/images/noPic_80X80.jpg" alt="${cartItemProxy.name}">
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                    <div class="media-body">
                                                                        <p class="media-heading"> <a href="${webRoot}/product-${cartItemProxy.productId}.html" class="title">${cartItemProxy.name}</a><a href="javascript:void(0);" class="del" onclick="delStoreIndexCartItem(this);" itemKey="${itemKey}" carttype="${carttype}" handler="${curHandler}" orgid="${orgId}">删除</a></p>
                                                                        <c:if test="${not empty cartItemProxy.specName}"><p>规格: ${cartItemProxy.specName}</p></c:if>
                                                                            <%--赠品--%>
                                                                        <c:forEach items="${cartItemProxy.presents}" var="present">
                                                                            <p><a><span>赠品：</span>${present.name}<em>× ${present.quantity}</em></a></p>
                                                                        </c:forEach>

                                                                        <div class="amount">
                                                                            <c:choose>
                                                                                <c:when test="${cartItemProxy.quantity>1}">
                                                                                    <a class="amount-opera ssubNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">−</a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a class="amount-opera storeBtnLock" href="javascript:" >−</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <input class="amount-inp scartNum" id="" type="text" autocomplete="off" value="${cartItemProxy.quantity}" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">
                                                                            <c:choose>
                                                                                <c:when test="${cartItemProxy.btnIsCanAdd}">
                                                                                    <a class="amount-opera saddNum" href="javascript:" handler="${curHandler}" itemKey="${itemKey}" maxlength="4" carttype="${carttype}" orgid="${orgId}">+</a>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <a class="amount-opera storeBtnLock" href="javascript:">+</a>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <span class="price">&yen;${cartItemProxy.productUnitPrice}</span>
                                                                        <p style="color: #ff8d12;  font-size: 12px;">${cartItemProxy.cartItemMsg}</p>
                                                                    </div>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>

                        <div class="checkout">
                            <span><small>&yen;</small>${storeCartProxy.realProductTotalAmount}</span>
                            <c:choose>
                                <c:when test="${storeCartProxy.selectedCartItemNum>0}">
                                    <a href="javascript:" class="addStoreCartResult" orgid="${orgId}" carttype="${carttype}">去结算</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="javascript:" style="background-color: #ccc;" aria-disabled="true">去结算</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </dd>
                </dl>
            </div>
        </div>
        <script>
            $(function() {
                var $cartToggle = $('.storeCartToggle'), $cartTarget = $('.storeCartTarget');
                $cartToggle.toggle(function () {
                    if($("#storeCartLayer").css("right")=='290px'){
                        $cartTarget.slideUp(400,function () {
                            $cartToggle.animate({
                                right: 50
                            },300);
                        });
                    }else{
                        $(this).animate({
                            right: 290
                        },300,function () {
                            $cartTarget.slideDown(400);
                        });
                    }
                },function () {
                    if($("#storeCartLayer").css("right")=='290px'){
                        $cartTarget.slideUp(400,function () {
                            $cartToggle.animate({
                                right: 50
                            },300);
                        });
                    }else{
                        $(this).animate({
                            right: 290
                        },300,function () {
                            $cartTarget.slideDown(400);
                        });
                    }
                });
            });
        </script>
    </c:if>
</c:if>
