<%@ page import="com.iloosen.imall.commons.web.WebContextFactory" %>
<%@ page import="com.iloosen.imall.module.promotion.resolver.ResolverUtils" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.ShoppingCart" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.UserCartList" %>
<%@ page import="com.iloosen.imall.module.shoppingcart.domain.code.CartTypeEnum" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/5
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<%--取出商品--%>
<c:set var="productProxy" value="${sdk:getProductById(param.productId)}"/>
<c:if test="${empty productProxy}">
    <c:redirect url="${webRoot}/wap/citySend/index.ac"/>
</c:if>
<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<c:if test="${empty shopInf || empty shopInf.sysOrgId || shopInf.isFreeze == 'Y' || 'Y' != shopInf.isSupportBuy}">
    <c:redirect url="/wap/citySend/index.ac"></c:redirect>
</c:if>

<%--商品评论--%>
<c:set var="commentProxyPage" value="${sdk:findProductComments(param.productId,10)}"/>
<c:set var="commentProxyResult" value="${commentProxyPage.result}"/>
<c:set value="store" var="carttype"/> <%--购物车类型--%>

<%--搭配购买--%>
<c:set value="${productProxy.referSkuList}" var="referProductList"></c:set>
<c:set value="${productProxy.availableBusinessRuleList}"  var="availableBusinessRuleList" />
<c:set value="${empty availableBusinessRuleList?'none':'block'}" var="isDisplayPromotion"/>
<%
    // 清除购物卷，在取出购物车之前
    if (WebContextFactory.getWebContext().getFrontEndUser() != null) {
        String carttype = (String)pageContext.getAttribute("carttype");
        UserCartList userCartList = ServiceManager.shoppingCartStoreService.getUserCartList(CartTypeEnum.fromCode(carttype), WebContextFactory.getWebContext().getFrontEndUser().getSysUserId());
        for (ShoppingCart shoppingCart : userCartList.getCarts()) {
            ResolverUtils.clearCoupon(shoppingCart);
            ResolverUtils.clacCartMisc(shoppingCart);
        }
        ServiceManager.shoppingCartStoreService.saveUserCartList(userCartList);
    }
%>

<html>
<head>
    <meta charset="utf-8">
    <title>商品详情-易淘药健康网</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/swiper.min.css" type="text/css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/base.css" type="text/css"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/citySend/statics/css/city.css" type="text/css"/>
    <style>
        .m-good-detail .store-contact .info li:nth-child(2):after { content: ''; position: absolute;right: 0.25rem; top: 50%; width: 2.5rem; height: 2.5rem; -webkit-transform: translateY(-50%);transform: translateY(-50%); background: none;}
    </style>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/otoo/statics/js/layer-v1.8.4/layer/layer.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/main.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js" ></script>
    <script type="text/javascript">
        var skuData = eval('${productProxy.skuJsonData}');
        var userSpecData = eval('${productProxy.userSpecJsonData}');
        var isCanBuy = eval('${productProxy.isCanBuy}');
        var webPath = {
            webRoot:"${webRoot}",
            userId:"${loginUser.userId}",//是否需要
            orgId:"${shopInf.sysOrgId}",
            productId:"${param.productId}"
        };

    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/citySend/statics/js/product.js"></script>

</head>

<body>
<div class="main m-good-detail">
    <div class="scroll-imgs swiper-container">
        <ul class="scroll-wrap swiper-wrapper" style="height: 420px;">
            <c:forEach items="${productProxy.images}" var="image" varStatus="s">
                <li class="swiper-slide" >
                    <img src="${image['420X420']}" alt="">
                </li>
            </c:forEach>
        </ul>
        <div class="scroll-page swiper-pagination swiper-pagination-fraction">
        </div>

        <a class="share-toggle" href="javascript:" style="display: none;">分享</a>
    </div>

    <!-- 商品简要 -->
    <div class="good-part">
        <a class="add-to-cart" href="javascript:" onclick="addCart(${param.productId});">加入购物车</a>

        <c:set value="${productProxy.priceListStr}" var="unitPrice"/>
        <%
            String unitPrice = (String)pageContext.getAttribute("unitPrice");
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

        <div class="price">
            <c:if test="${productProxy.price.isSpecialPrice}">
                <span style=" display: inline-block; font-size: 1.3rem; color:#f37913 ">特价</span>
            </c:if>
            <span><small>&yen;</small>${intgerPrice}<small>.${decimalPrice}</small></span>
            <del>&yen;${productProxy.marketPrice}</del>
            <input type="hidden" id="priceListStr" priceNm="${productProxy.price.amountNm}" value="${productProxy.priceListStr}">
        </div>

        <h3 class="name">${productProxy.name}</h3>

        <p class="desc">${productProxy.salePoint}</p>
        <div class="promotion" style="display: ${isDisplayPromotion}">
            <span >促 &nbsp; 销：</span>
            <div class="promotion-content ruleDown" >

                    <div class="pro-item firstBenifit">
                        <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                                <c:choose>
                                    <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">
                                        <i class="label-icon-div">折扣</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">
                                        <i class="label-icon-div">包邮</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">
                                        <i class="label-icon-div">赠品</i>
                                    </c:when>
                                    <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">
                                        <i class="label-icon-div">送券</i>
                                    </c:when>
                                 </c:choose>
                            <%--<c:when test="${rule.ruleTypeCode=='9'||rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'}">换购</c:when>--%>
                            <%--<c:when test="${rule.ruleTypeCode=='16'||rule.ruleTypeCode=='17'||rule.ruleTypeCode=='18'}">用券</c:when>--%>
                            <%--<c:when test="${rule.ruleTypeCode=='19'||rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'}">送积分</c:when>--%>
                        </c:forEach>
                    </div>
                <%-- 这个地方暂时不启用，因为单品赠品显示图片比较简单，订单赠品现实很麻烦；而且订单赠品需要说明获取条件，不能只是简单地显示赠品的 --%>
                <%-- 只考虑单品赠品的情况 --%>
                <%--<c:if test="${not empty productProxy.presentProductList}">
                    <div class="pro-item">
                        <i class="label-icon-div">赠品</i>
                        <c:forEach items="${productProxy.presentProductList}" var="present">
                            <em class="dt-div">
                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${present.productId}"><img src="${bdw:getProductImageUrl(present.productId)}" style="height: 100%;width:100%"></a></div>
                                <a href="${webRoot}/wap/product.ac?id=${present.productId}" class="gift-name elli">${present.productNm}</a>
                            </em>
                        </c:forEach>
                    </div>
                </c:if>--%>

            </div>
            <div class="promotion-content1" style="display: none" >

                <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="i">
                    <c:choose>
                        <c:when test="${rule.ruleTypeCode=='0'||rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'}">
                            <div class="pro-item1 notFirst" >
                                <i class="label-icon-div">折扣</i>
                                <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                    <%--<c:if test="${not empty rule.descr}">--%>
                                        <%--(${rule.descr})--%>
                                    <%--</c:if>--%>
                                </em>
                            </div>
                        </c:when>
                        <c:when test="${rule.ruleTypeCode=='3'||rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'}">
                            <div class="pro-item1 notFirst" >
                                <i class="label-icon-div">包邮</i>
                                <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                    <%--<c:if test="${not empty rule.descr}">--%>
                                        <%--(${rule.descr})--%>
                                    <%--</c:if>--%>
                                </em>
                            </div>
                        </c:when>
                        <c:when test="${rule.ruleTypeCode=='6'||rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'}">
                            <div class="pro-item1 notFirst" >
                                <i class="label-icon-div">赠品</i>
                                <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                    <%--<c:if test="${not empty rule.descr}">--%>
                                        <%--(${rule.descr})--%>
                                    <%--</c:if>--%>
                                </em>

                            </div>
                        </c:when>
                        <c:when test="${rule.ruleTypeCode=='12'||rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'}">
                            <div class="pro-item1 notFirst" >
                                <i class="label-icon-div">送券</i>
                                <em class="dt-div">${rule.businessRuleNm}&nbsp;
                                    <%--<c:if test="${not empty rule.descr}">--%>
                                        <%--(${rule.descr})--%>
                                    <%--</c:if>--%>
                                </em>
                            </div>
                        </c:when>
                    </c:choose>
                </c:forEach>

                <%-- 这个地方暂时不启用，因为单品赠品显示图片比较简单，订单赠品现实很麻烦；而且订单赠品需要说明获取条件，不能只是简单地显示赠品的 --%>
                <%-- 只考虑单品赠品的情况 --%>
                <%--<c:if test="${not empty productProxy.presentProductList}">
                    <div class="pro-item">
                        <i class="label-icon-div">赠品</i>
                        <c:forEach items="${productProxy.presentProductList}" var="present">
                            <em class="dt-div">
                                <div class="pic"><a href="${webRoot}/wap/product.ac?id=${present.productId}"><img src="${bdw:getProductImageUrl(present.productId)}" style="height: 100%;width:100%"></a></div>
                                <a href="${webRoot}/wap/product.ac?id=${present.productId}" class="gift-name elli">${present.productNm}</a>
                            </em>
                        </c:forEach>
                    </div>
                </c:if>--%>

            </div>
        </div>

        <c:if test="${productProxy.isEnableMultiSpec=='Y' && not empty referProductList}">
            <div class="m-step2-box">
                <div class="m-step2 specSelect2">
                    <c:forEach items="${productProxy.productUserSpecProxyList}" var="spec">
                        <div class="mp2-item">
                            <span>${spec.name}：</span>
                            <c:forEach items="${spec.specValueProxyList}" var="specValue">
                                <c:if test="${spec.specType eq '0'}">
                                    <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn">
                                            ${specValue.value}
                                            <%--<c:if test="${spec.specType eq '1'}"><img width='30' height='30' src="${specValue.value}" style="width: 100%;height: 100%"/></c:if>--%>
                                    </a>
                                </c:if>
                                <c:if test="${spec.specType eq '1'}">
                                    <a title="${specValue.name}" href="javascript:" data-value="${spec.specId}:${specValue.specValueId}" class="gg_btn" style="width: 30px;height: 30px;padding: 0;">
                                            <%--<c:if test="${spec.specType eq '0'}">${specValue.value}</c:if>--%>
                                        <img width='30' height='30' src="${specValue.value}" style="width: 100%;height: 100%"/>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <!-- 门店联系信息 -->
    <div class="store-contact">
        <a href="${webRoot}/wap/citySend/storeIndex.ac?orgId=${shopInf.sysOrgId}" class="icon">${shopInf.shopNm}</a>

        <ul class="info">
            <li>${shopInf.mobile} <a class="tel" href="tel:${shopInf.mobile}"></a></li>
            <li>
                <a href="javascript:">${shopInf.outStoreAddress}</a>
            </li>
        </ul>
    </div>

    <!--搭配推荐-->
    <c:if test="${not empty referProductList}">
        <div class="recommend">
            <input type="hidden" id="dapei_skuId" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.skus[0].skuId}</c:if>">
            <input type="hidden" id="dapei_skuprice" value="<c:if test="${productProxy.isEnableMultiSpec=='N'}">${productProxy.price.unitPrice}</c:if>">
            <div class="mt"><span>推荐搭配</span></div>
            <div class="mc" id="refer">
                <div class="mc-top" id="dapei">
                    <c:set value="${fn:length(referProductList)*105+105}" var="divWidth"/>
                    <c:set value="${productProxy.priceListStr}" var="priceStr"/>
                    <ul style="width: ${divWidth}px"><!-- ul的宽度为动态 等于li 的个数乘以 105px -->
                        <li>
                            <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="pic"><img src="${productProxy.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                            <div class="title"><a href="${webRoot}/wap/citySend/product.ac?productId=${productProxy.productId}">${productProxy.name}</a></div>
                            <span id="packagePrice">¥${productProxy.priceListStr}</span>
                        </li>
                        <c:forEach items="${referProductList}" var="refPrd" varStatus="num">
                            <li>
                                <a href="${webRoot}/wap/citySend/product.ac?id=${refPrd.productId}" class="pic"><img src="${refPrd.defaultImage["80X80"]}" style="width: 80px;height: 80px"></a>
                                <div class="title"><a href="${webRoot}/wap/citySend/product.ac?productId=${refPrd.productId}">${refPrd.name}</a></div>
                                <span>¥${refPrd.price.unitPrice}</span>
                                <input type="checkbox" style="-webkit-appearance: checkbox;" class="sel" name="packageItem" skuid="${refPrd.skus[0].skuId}" value="${refPrd.price.unitPrice}"/>
                            </li>
                        </c:forEach>
                    </ul>
                    <script type="text/javascript">
                        var referProductListNoCheck = function () {
                            $("#refer input[type='checkbox']").each(function () {
                                $(this).attr("checked", false);
                            });
                        }();
                    </script>
                </div>
                <div class="mc-bot">
                    <a href="javascript:" class="batch_addcart enable" id="dapeiCart" carttype="store" handler="sku" orgid="${shopInf.sysOrgId}">购买搭配套餐</a>
                    <p>您已购买<i id="selectNum">0</i>个自由搭配组合</p>
                    <p>搭配价：<span><em id="dapeiprice">0.0</em></span></p>
                </div>
            </div>
        </div>
    </c:if>

    <%-- 组合商品 --%>
    <c:set value="${productProxy.combos}" var="combos"/>
    <c:if test="${not empty combos}">
        <div class="recommend">
            <div class="mt"><span>组合套餐</span></div>
            <div class="mc">
                <c:forEach items="${combos}" var="cont_combo" varStatus="cs">
                    <div class="mc-top">
                        <div id="${cont_combo.comboId}" <%--class="tab-pane fade <c:if test="${cs.index eq 0}">in active</c:if>"--%>>
                            <c:set value="${fn:length(cont_combo.skus) * 105 + 5}" var="divWidth"/>
                            <ul style="width: ${divWidth}px;">
                                <c:forEach items="${cont_combo.skus}" var="sku" varStatus="ss">
                                    <li>
                                        <a href="${webRoot}/wap/citySend/product.ac?productId=${sku.productProxy.productId}" class="pic"><img src="${sku.productProxy.defaultImage["120X120"]}" style="width: 80px;height: 80px;"/></a>
                                        <div class="title"><a href="${webRoot}/wap/citySend/product.ac?productId=${sku.productProxy.productId}">${sku.productProxy.name}</a></div>
                                        <span class="comboPrice">￥${sku.price.unitPrice} × ${sku.amountNum}</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <%--组合商品总价计算--%>
                    <div class="mc-bot">
                        <a href="javascript:" class="combo_addcart enable" id="comboAddCart${cs.count}" skuid="${cont_combo.comboId}" handler="combo" carttype="store" num="1" count="${cs.count}" orgid="${shopInf.sysOrgId}">购买组合套餐</a>
                        <p>套餐价格：<span><i>￥</i>${cont_combo.price}</span></p>
                        <p>为您节省：<span><i>￥</i>${cont_combo.saveMoney}</span></p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>

    <!-- 商品评价 -->
    <div class="evaluation">
        <dl>
            <dt style="text-align: center;padding-left: 0;">商品评价(${commentProxyPage.totalCount})</dt>
            <c:forEach items="${commentProxyResult}" var="commentProxy" varStatus="s">
                <dd class="item" <c:if test="${s.index  > 1}">style="display: none"</c:if>>
                    <div class="from">
                        <c:set value="${fn:substring(commentProxy.loginId, 0,3)}" var="mobileHeader"/><%-- 用户名前3位 --%>
                        <c:set value="${fn:substring(commentProxy.loginId, 7,fn:length(commentProxy.loginId))}" var="mobileStern"/><%-- 用户名后4位 --%>
                        <span class="fl">${mobileHeader}****${mobileStern}</span>
                        <span class="fr">${commentProxy.createTimeString}</span>
                    </div>
                    <div class="stars">
                        <c:forEach begin="1" end="${commentProxy.score}">
                            <span class="active"></span>
                        </c:forEach>
                        <c:if test="${commentProxy.score < 5}">
                            <c:forEach begin="${commentProxy.score}" end="4">
                                <span></span>
                            </c:forEach>
                        </c:if>
                    </div>
                    <p class="cont" style="word-wrap: break-word;">${commentProxy.content}</p>
                </dd>
            </c:forEach>
        </dl>
        <a class="btn" href="javascript:" onclick="showAllComment(this)" productId="${param.productId}">查看全部评价</a>
    </div>

    <p class="tip-txt">继续拖动，查看图文详情</p>

    <div class="detail-box">
        <c:choose>
            <c:when test="${not empty productProxy.description}">
                ${productProxy.description}
            </c:when>
            <c:otherwise>
                <p style="font-size: 2rem;text-align: center">暂无数据</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 加入购物车 -->
<div class="modal modal-add-cart" style="display: none;" id="ajaxCartSeletor">

</div>

<!-- 查看购物车 -->
<div class="modal modal-view-cart" style="display: none;" id="ajaxLoadShoppingCart">

</div>

<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set var="storeCartProxy" value="${bdw:getCitySendShoppingCartProxyByOrgId(shopInf.sysOrgId)}"/>
<c:set var="storeCartNum" value="${storeCartProxy.cartNum}" />
<!-- 底部结算 -->
<div class="bottom-bar" id="cart" style="z-index:105;">
    <c:choose>
        <c:when test="${storeCartProxy.selectedCartItemNum>0}">
            <a  id="goToAddOrder" href="javascript:void(0);" class="settlement" orgid="${shopInf.sysOrgId}"   style="z-index: 105;"  carttype="${carttype}" onclick="goToAddOrder(this);">去结算</a>
        </c:when>
        <c:otherwise>
            <a href="javascript:" class="settlement" style="background-color: #ccc;" aria-disabled="true">去结算</a>
        </c:otherwise>
    </c:choose>
    <a class="cart-toggle" id="storeCartLayer" orgid="${shopInf.sysOrgId}" href="javascript:">
        <c:choose>
            <c:when test="${empty loginUser}">
                <span>0</span>
            </c:when>
            <c:otherwise>
                <span>${storeCartNum}</span>
            </c:otherwise>
        </c:choose>
    </a>
    <div class="total">
        <span style="position: relative;top: -1px;"><small>¥&nbsp;</small>${storeCartProxy.realProductTotalAmount}</span>
        <p class="price"><small  style="font-size: 1.0rem">优惠：&yen;${storeCartProxy.discountAmount}</small></p>
    </div>
</div>

<script src="${webRoot}/template/bdw/wap/citySend/statics/js/base.js" type="text/javascript"></script>

<script>
    var goodImgs = new Swiper('.scroll-imgs', {
        /*轮播图*/
        slidesPerView: 1,/*分页器*/
        paginationClickable: true,/*点击那几个小点*/
        pagination: '.swiper-pagination',
        autoplay : 3000,
        loop : true,
        paginationType: 'fraction'
    });
</script>

</body>

</html>

