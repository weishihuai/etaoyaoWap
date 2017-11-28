<!DOCTYPE html>
<html>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<jsp:useBean id="systemTime" class="java.util.Date" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>

<%--门店关注提示layer--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:if test="${isWeixin eq 'Y' && !(not empty loginUser  &&  loginUser.isAttentionWechat == 'Y')}">
    <%@ include file="/template/bdw/wap/wechatAttention.jsp" %>
</c:if>

<%--根据店铺ID查询店铺详情--%>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/shopError.ac"/>
</c:if>
<c:set var="shopId" value="${param.shopId}"/>

<%--查询店铺的商品分类--%>
<c:set value="${sdk:getShopRoot(param.shopId)}" var="shopRoot"/>
<c:set value="${sdk:getChildren(shopRoot,param.shopId)}" var="shopCategory"/>
<%--根据店铺ID查询直降商品--%>
<c:set value="${sdk:findSpecialPriceProductProxy(param.shopId,1, 100)}" var="panicBuyProductProxyList"/>
<c:set value="${sdk:search(4)}" var="productProxys"/>
<c:choose>
    <c:when test="${empty shop.images[0]['']}">
        <c:set var="imgUrl" value="${webRoot}/template/bdw/wap/outlettemplate/default/statics/images/pic460x460.jpg"/>
    </c:when>
    <c:otherwise>
        <c:set var="imgUrl" value="${shop.images[0]['100X100']}"/>
    </c:otherwise>
</c:choose>

<head lang="en">
    <meta charset="utf-8">
    <title>${shop.shopNm}-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/store-index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <c:if test="${isWeixin!='Y'}">
        <link href="${webRoot}/template/bdw/wap/statics/css/product-detail-share.css" type="text/css" rel="stylesheet" />
    </c:if>

    <script type="text/javascript">
        webPath = {
            webRoot:"${webRoot}",
            weixinJsConfig: {
                jsApiList: [
                    'onMenuShareTimeline',      //分享到朋友圈
                    'onMenuShareAppMessage',    //发送给朋友
                    'onMenuShareQQ',            //分享到QQ
                    'onMenuShareQZone'          //分享到 QQ 空间
                ]
            }
        }
        var dataValue = {
            webRoot:"${webRoot}",
            shopId:"${shop.shopInfId}",
            loginUserIsAttention:"${shop.loginUserIsAttention}",
            isWeixin: "${isWeixin}",
            shareUrl: location.href.split('#')[0],
            title: '${shop.shopNm}-${webName}',
            desc: '${sdk:cleanHTML(shop.shopDescrStr, '')}',
            imgUrl: '${imgUrl}',
            systemTime: '<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />'
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <c:if test="${isWeixin=='Y'}">
        <script src="${webRoot}/template/bdw/wap/statics/js/jweixin-1.2.0.js"></script>
        <script src="${webRoot}/template/bdw/wap/statics/js/weixinJsConfigInit.js"></script>
        <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/storeShare.js"></script>
    </c:if>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/outletIndex.js"></script>
</head>
<body>
<div class="m-top">
    <a class="back" href="javascript:history.go(-1)"></a>
    <div class="toggle-box">${shop.shopNm}</div>
<%--    <div class="store-more">
        <a href="javascript:void(0);" class="more"></a>
        <div style="display: none;" class="more-box">
            <a href="javascript:void(0);" class="share" onclick="showOrHideShare()">分享</a>
            <a id="collectStore" href="javascript:void(0);" isCollect="${shop.loginUserIsAttention}" class="collect<c:if test="${shop.loginUserIsAttention == 'true'}">-active</c:if>">收藏店铺</a>
            <a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shop.shopInfId}" class="home-page">首页</a>
            <a href="javascript:void(0);" class="cart">购物车</a>
            <a href="${webRoot}/wap/module/member/index.ac" class="my">我的</a>
        </div>
    </div>--%>
</div>
<header class="header-wrapper">
    <div class="sc-box1">
        <div class="logo">
            <a href="javascript:void(0);">
                <img src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/images/logo-wt110x36.png" alt="易淘药">
            </a>
        </div>
        <div class="search-form-box" onclick="window.location.href='${webRoot}/wap/shop/newSearch.ac?shopId=${shop.shopInfId}'">
            <span class="search-form-icon"></span>
            <div class="search-form-input">
                <input type="text" placeholder="搜索商品" readonly>
            </div>
        </div>
        <div class="news"><a href="${webRoot}/wap/module/member/myMessage.ac"></a></div>
    </div>
    <div class="sc-box2" style="display: none;">
        <div class="logo">
            <a href="javascript:void(0);">
                <img src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/images/etaoyaoLogo.png" alt="易淘药">
            </a>
        </div>
        <div class="search-form-box" onclick="window.location.href='${webRoot}/wap/shop/newSearch.ac?shopId=${shop.shopInfId}'">
            <span class="search-form-icon"></span>
            <div class="search-form-input">
                <input type="text" placeholder="搜索商品" readonly>
            </div>
        </div>
        <div class="message"><a href="${webRoot}/wap/module/member/myMessage.ac"></a></div>
    </div>
</header>
<div class="store-main">

    <!-- 商品图片 -->
    <div <c:if test="${param.shopEdit eq 'Y'}">style="height: 240px;" </c:if> class="swiper-container m-pic shopEdit" shopInfo="outlet_top_route|640X320">
        <div class="swiper-wrapper" style="height: auto;">
            <c:set var="topRouteAdvtProxy" value="${sdk:findShopPageModuleProxy(shopId, 'outlet_top_route').advt.advtProxy}"/>
            <c:choose>
                <c:when test="${not empty topRouteAdvtProxy}">
                    <c:forEach items="${topRouteAdvtProxy}" var="advt">
                        <div class="swiper-slide">
                            <a href="${advt.link}"><img src="${advt.advUrl}" alt="${advt.title}"></a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${sdk:findPageModuleProxy('wap_index_roteAdv').advt.advtProxy}" var="advtProxys" varStatus="s">
                        <div class="swiper-slide">
                            <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div>

    <div class="ziying-slogan shopEdit" shopInfo="outlet_service_guarantee">
        <c:set value="${sdk:findShopPageModuleProxy(shopId, 'outlet_service_guarantee').links}" var="moduleLinks"/>
        <c:choose>
            <c:when test="${not empty moduleLinks}">
                <c:forEach items="${moduleLinks}" var="links" end="3">
                    <div class="sn-item">
                            ${links.title}
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="sn-item">
                    畅选无忧
                </div>
                <div class="sn-item">
                    正品保证
                </div>
                <div class="sn-item">
                    资质齐全
                </div>
                <div class="sn-item">
                    即省30%
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="box-enter shopEdit" shopInfo="outlet_topic_link">
        <c:set var="topicLinks" value="${sdk:findShopPageModuleProxy(shopId, 'outlet_topic_link').links}"/>
        <c:choose>
            <c:when test="${not empty topicLinks}">
                <c:forEach items="${topicLinks}" var="links" end="3">
                    <a <c:if test="${links.newWin}">target="_blank" </c:if> href="${links.link}" class="quick-entry-link">
                        <span class="pic"><img src="${links.icon['']}"></span>
                        <i>${links.title}</i>
                    </a>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <a href="${webRoot}/wap/shop/shopProductList.ac?shopId=${shopId}" class="quick-entry-link">
                    <span class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/pics.png" alt=""></span>
                    <i>所有商品</i>
                </a>
                <a href="${webRoot}/wap/shop/shopDetail.ac?shopId=${param.shopId}" class="quick-entry-link">
                    <span class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/picx.png" alt=""></span>
                    <i>店铺详情</i>
                </a>
                <a href="${webRoot}/wap/shop/newSearch.ac?shopId=${shop.shopInfId}" class="quick-entry-link">
                    <span class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/picg.png" alt=""></span>
                    <i>店铺代购</i>
                </a>
                <a href="${webRoot}/wap/shop/promotionList.ac?shopId=${param.shopId}" class="quick-entry-link">
                    <span class="pic"><img src="${webRoot}/template/bdw/wap/statics/images/picc.png" alt=""></span>
                    <i>店铺促销</i>
                </a>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 限时抢购 -->
    <c:if test="${not empty panicBuyProductProxyList.result}">
        <div class="time-limit" len="${fn:length(panicBuyProductProxyList.result) > 5 ? 5 : fn:length(panicBuyProductProxyList.result)}">
            <div class="swiper-wrapper" style="height: auto;">
                <c:forEach var="productProxy" varStatus="s" items="${panicBuyProductProxyList.result}" end="4">
                    <c:set var="product" value="${sdk:getProductById(productProxy.productId)}"/>
                    <c:set var="attrDicList" value="${product.dicValues}"/>
                    <c:set var="attrDicMap" value="${product.dicValueMap}"/>
                    <c:set var="attrGroupProxyList" value="${product.attrGroupProxyList}"/>
                    <div class="swiper-slide">
                        <div class="mt">
                            <div class="mt-lt">限时抢购</div>
                            <div id="endDateStr_${s.index}" class="mt-rt" endDateStr="${productProxy.endDateStr}"></div>
                        </div>
                        <div class="mc">
                            <div class="mc-box">
                                <div class="pic">
                                    <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}">
                                        <c:choose>
                                            <c:when test="${not empty productProxy.defaultImage['200X200']}">
                                                <img src="${productProxy.defaultImage['200X200']}" alt="${productProxy.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${webRoot}/template/bdw/statics/images/noPic_200X200.jpg" alt="${productProxy.name}">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                                <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}<br>
                                    <c:if test="${not empty attrGroupProxyList}">
                                        <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                                            <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                                <ul class="attributes">
                                                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict" end="0">
                                                        <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                                            <c:if test="${not empty attrGroupProxy.dicValueMap}">
                                                                ${attrGroupProxy.dicValueMap['span'].valueString}
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                </ul>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </a>
                                <div class="price">
                                    抢购价:
                                    <c:set value="${productProxy.price.unitPrice}" var="unitPrice"/>
                                    <%
                                        Double unitPrice = (Double) pageContext.getAttribute("unitPrice");
                                        String priceStr = String.valueOf(unitPrice);
                                        String[] price = priceStr.split("[.]");
                                        String integerPrice = price[0];
                                        String decimalPrice = price[1];
                                        if (StringUtils.isBlank(decimalPrice)) {
                                            decimalPrice = "00";
                                        } else if (decimalPrice.length() < 2) {
                                            decimalPrice += "0";
                                        }
                                        pageContext.setAttribute("integerPrice", integerPrice);
                                        pageContext.setAttribute("decimalPrice", decimalPrice);
                                    %>
                                    <i>￥</i><span>${integerPrice}</span><i>.</i><em>${decimalPrice}</em>
                                </div>
                                <a href="${webRoot}/wap/product.ac?id=${productProxy.productId}" class="buy-btn">立即抢购</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>
    </c:if>

    <div id="centerAdv" class="choiceness shopEdit" shopInfo="outlet_center_adv|620X220">
        <c:set value="${sdk:findShopPageModuleProxy(shopId, 'outlet_center_adv').advt.advtProxy}" var="centerAdvs"/>
        <c:choose>
            <c:when test="${not empty centerAdvs}">
                <c:forEach items="${centerAdvs}" var="advt" end="7">
                    <div class="cho-item"><a href="${advt.link}"><img src="${advt.advUrl}" alt="${advt.title}"></a></div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="cho-item">
                    <c:forEach items="${sdk:findPageModuleProxy('wap_index_F1_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                        <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
                    </c:forEach>
                </div>
                <div class="cho-item">
                    <c:forEach items="${sdk:findPageModuleProxy('wap_index_F2_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                        <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
                    </c:forEach>
                </div>
                <div class="cho-item">
                    <c:forEach items="${sdk:findPageModuleProxy('wap_index_F3_bottom_banner').advt.advtProxy}" var="advtProxys" varStatus="s" end="0">
                        <a href="${advtProxys.link}"><img src="${advtProxys.advUrl}" alt=""></a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="recommend">
        <div class="mt"><span>为你推荐</span></div>
        <div class="mc shopEdit" shopInfo="outlet_bottom_product_recommend">
            <ul class="rec-ul">
                <c:set value="${sdk:findShopPageModuleProxy(shopId, 'outlet_bottom_product_recommend').recommendProducts}" var="productRecommends"/>
                <c:choose>
                    <c:when test="${not empty productRecommends}">
                        <c:forEach items="${productRecommends}" var="product">
                            <li class="rec-li"><a href="${webRoot}/wap/product-${product.productId}.html">
                                <div class="pic"><img src="${product.defaultImage['320X320']}"></div>
                                <div class="li-bot">
                                    <h5>${product.name}</h5>
                                    <div class="price">
                                        <span>￥</span><i>${product.priceListStr}</i>
                                    </div>
                                </div>
                            </a></li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${productProxys.result}" var="product">
                            <li class="rec-li"><a href="${webRoot}/wap/product-${product.productId}.html">
                                <div class="pic"><img src="${product.defaultImage['320X320']}"></div>
                                <div class="li-bot">
                                    <h5>${product.name}</h5>
                                    <div class="price">
                                        <span>￥</span><i>${product.priceListStr}</i>
                                    </div>
                                </div>
                            </a></li>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
    <div class="loding"><img src="${webRoot}/template/bdw/wap/statics/images/yejiao2x.png"/></div>
</div>
<div class="store-nav">
    <div class="str-detail"><a href="${webRoot}/wap/shop/shopIndex.ac?shopId=${param.shopId}">店铺首页</a></div>
    <div class="str-classify">
        <c:choose>
            <c:when test="${empty shopCategory}">
                <a href="${webRoot}/wap/shop/shopProductList.ac?shopId=${shopId}" class="classify">商品分类</a>
            </c:when>
            <c:otherwise>
                <a href="javascript:void(0);" class="classify">商品分类</a>
            </c:otherwise>
        </c:choose>
        <div style="display: none;" class="csf-box">
             <c:if test="${not empty shopCategory}">
                 <c:forEach items="${shopCategory}" var="node" varStatus="s" end="4">
                     <a href="${webRoot}/wap/shop/shopProductList.ac?shopId=${shopId}&shopCategoryId=${node.categoryId}">${node.name}</a>
                 </c:forEach>
             </c:if>
        </div>
    </div>
    <div class="str-detail str-cat"><a href="${webRoot}/wap/shoppingcart/cart.ac?pIndex=cart">购物车</a></div>
    <div class="str-seller"><a href="${webRoot}/wap/module/member/index.ac?pIndex=member">我的</a></div>
</div>

<div id="tipsDiv" class="rem-get" style="display: none;" ><span id="tipsSpan"></span></div>

<c:choose>
    <c:when test="${isWeixin=='Y'}">
        <div class="share-layer"  style="display: none;" id="share" onclick="showOrHideShare()">
            <div class="share-box"><img src="${webRoot}/template/bdw/wap/statics/images/share390x186.png" alt=""></div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="copy-modal copy-fade copy-in" id="sysMsg" style="display: none;">
            <div class="copy-modal-dropback"></div>
            <div class="copy-modal-dialog">
                <div class="copy-modal-content">
                    <div class="copy-modal-header">
                        <h4 class="copy-modal-title">长按复制链接</h4>
                    </div>
                    <div class="copy-modal-body" id="shareUrl"></div>
                    <div class="copy-modal-footer">
                        <a class="copy-btn-link" href="javascript:$('#sysMsg').hide();">关闭</a>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<div class="back-top" style="display: none;"><a href="javascript:;" onclick="scrollToTop()"><img src="${webRoot}/template/bdw/wap/statics/images/zhiding.png" alt=""></a></div>

<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js"></script>
<script src="${webRoot}/template/bdw/wap/statics/js/swiper.min.js"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay: 5000,
        loop: true,
        slidesPerView: 1,
    });
    var swiper = new Swiper('.time-limit', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        autoplay: 5000,
        loop: true,
        slidesPerView: 1
    });
</script>

<script type="text/javascript">
    $(document).ready(function () {
        //限时抢购倒计时
        $(".mt-rt").each(function () {
            var panicBuyTime = $(this).attr("endDateStr");
            if (null != panicBuyTime && '' != $.trim(panicBuyTime)) {
                var endTime = new Date(Date.parse(panicBuyTime.replace(/-/g,"/"))).getTime();
                timer($(this), (endTime - new Date().getTime()) / 1000);
            }
        });
    });
</script>

</body>
<f:ShopEditTag/>
</html>
