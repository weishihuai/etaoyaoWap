<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findGroupBuyProxy(param.id)}" var="groupBuy"/>
<c:set value="${groupBuy.groupBuySpec}" var="specList"/>
<c:set value="${groupBuy.groupBuySpecJson}" var="specJsonData"/>
<c:set value="${groupBuy.groupBuySkuProxyListJson}" var="skuIds"/>
<jsp:useBean id="systemTime" class="java.util.Date" />
<c:set var="productProxy" value="${sdk:getProductById(groupBuy.productId)}"/>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shop"/>
<%-- 获取当前商家 --%>
<c:set value="${sdk:getShopInfProxyById(productProxy.shopInfId)}" var="shopInf"/>
<%-- 获取店铺所有商品的数量 --%>
<c:set value="${bdw:getTotalProductNum(shopInf.sysOrgId)}" var="totalProductNum"/>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>团购-商品详情</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">


    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet" >
    <link href="${webRoot}/template/bdw/oldWap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/css/tg-detail.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div class="main m-good-detail">
    <!-- 商品图片 未完成 -->
    <div class="scroll-imgs swiper-container">
        <ul class="scroll-wrap swiper-wrapper">
            <li class="swiper-slide">
                <img src="${groupBuy.pic['420X420']}" alt="${groupBuy.title}">
            </li>
        </ul>
        <!-- <div class="scroll-page">1/4</div> -->
        <%--<div class="scroll-page swiper-pagination swiper-pagination-fraction">--%>
            <%--<span class="swiper-pagination-current">1</span>/--%>
            <%--<span class="swiper-pagination-total">10</span>--%>
        <%--</div>--%>

        <%--<a class="share-toggle" href="javascript:;">分享</a>--%>
    </div>

    <!-- 商品简要 -->
    <div class="good-part">

        <c:if test="${systemTime.time - groupBuy.startTime.time >= 0}">
            <div class="gp-m1 m1-red">
                <div class="price"><span>￥</span><fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /><del>￥${productProxy.marketPrice}</del></div>
                <div class="time">
                        <span class="countdownTime tuanEnd"></span>
                </div>
            </div>
        </c:if>
        <c:if test="${systemTime.time - groupBuy.startTime.time <= 0}">
            <div class="gp-m1 m1-green">
                <div class="price"><span>￥</span><fmt:formatNumber value="${groupBuy.price.unitPrice}" type="number" pattern="#0.00#" /><del>￥${productProxy.marketPrice}</del></div>
                <div class="time">
                    <span class="countdownTime tuanStart"></span>
                </div>
            </div>
        </c:if>
        <div class="gp-m2">
            <h5>${productProxy.name}</h5>
            <div class="m2-box">
                <div class="m2-lt"><span>折扣</span><fmt:formatNumber  value="${groupBuy.discount}"  pattern="#,###,###,###"/>折</div>
                <div class="m2-ct"><span>节省</span>${groupBuy.orgPrice - groupBuy.price.unitPrice}元</div>
                <c:choose>
                    <c:when test="${systemTime.time - groupBuy.startTime.time <= 0}">
                        <div class="m2-rt"><span>剩余</span>${groupBuy.stockQuantity}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="m2-rt"><span>已抢</span>${groupBuy.soldQuantity}</div>
                    </c:otherwise>

                </c:choose>
            </div>
        </div>
    </div>

    <!-- 选择规格 -->
    <div class="p-props">
            <span id="tipMsg">
                请选择
                <c:forEach items="${specList}" var="spec" varStatus="index">
                    ${spec.name},
                </c:forEach>
            </span>
            <%--<span id="tipMsg">请选择产品规格(活动开始可选)--%>
        <a href="##"></a>
    </div>

    <!--店铺信息-->
    <div class="dp-info">
        <div class="dp-m1">
            <div class="pic"><img src="${shopInf.images[0]["100X100"]}" alt=""></div>
            <a href="##" class="name">${shopInf.shopNm}</a>
        </div>
        <div class="dp-m2">
            <div class="item">
                <span>${totalProductNum}</span>
                <p>全部商品</p>
            </div>
            <div class="item">
                <span>${shopInf.collectdByUserNum}</span>
                <p>收藏人数</p>
            </div>
            <div class="item">
                <span>${groupBuy.soldQuantity}</span>
                <p>成交笔数</p>
            </div>
        </div>
        <div class="dp-m3">
            <a href="javascript:;" class="shopCollect" id="shopCollect" shopId="${shop.shopInfId}" isCollect="${shop.collect}">${shop.collect ? '已收藏' : '收藏店铺'}</a>
            <a href="${webRoot}/wap/module/shop/index.ac?shopId=${shopInf.shopInfId}">进店逛逛</a>
        </div>
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

<!--规格-->
<div class="overlay" style="display: none;">
    <div class="bar-cont">
        <a href="javascript:;" class="close"></a>
        <div class="cont-top">
            <div class="pic"><img src="${groupBuy.pic['180X180']}" alt=""></div>
            <p id="groupBuyPrice"><i>￥</i>${groupBuy.price.unitPrice}</p>
            <span id="store">库存${groupBuy.stockQuantity}件</span>
        </div>

        <div class="item">
            <c:forEach items="${specList}" var="spec">
                <div class="m-th">${spec.name}</div>
                <div class="m-td" >
                    <c:forEach items="${spec.specValueProxyList}" var="specValue">
                        <c:if test="${spec.specType eq '0'}">
                            <a href="javascript:;" data-value="${spec.specId}:${specValue.specValueId}">${specValue.name}</a>
                        </c:if>
                        <c:if test="${spec.specType eq '1'}">
                            <a href="javascript:;" data-value="${spec.specId}:${specValue.specValueId}">
                                <c:choose>
                                    <c:when test="${not empty specValue.relPictId}">
                                        <img width='30' height='30' src="${specValue.relPictId}" />
                                    </c:when>
                                    <c:otherwise>
                                        <img width='30' height='30' src="${webRoot}/template/bdw/statics/images/noPic_40X40.jpg" />
                                    </c:otherwise>
                                </c:choose>

                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
        <div class="quantity-form">
            <div class="form-lt">数量</div>
            <div class="form-rt">
                <a href="##" class="decrement disabled">-</a>
                <input type="text" class="itxt" value="1" id="itxt">
                <a href="##" class="increment">+</a>
            </div>
        </div>
        <span class="msg"></span>

            <a class="buy-btn" href="javascript:;" objectid="" carttype="groupBuy" handler="groupBuy">立即团购</a>
    </div>
</div>

<!-- 底部结算 -->

<c:if test="${systemTime.time - groupBuy.startTime.time >= 0}">
    <div class="bottom-bar">
        <a class="buy-btn" href="javascript:;">立即团购</a>
    </div>
</c:if>
<script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/swiper.min.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
<script>

    var webPath = {
        webRoot : '${webRoot}',
    };
    var goodImgs = new Swiper('.scroll-imgs', {
        pagination: '.swiper-pagination',
        paginationType: 'fraction'
    });
    var pageData = {
        specJsonData : '${specJsonData}',
        skuIds : '${skuIds}',
        groupBy : '${groupBuy}',
        endTimeStr : '${groupBuy.endTimeString}',
        systemTime:"<fmt:formatDate value="${systemTime}" type="both" dateStyle="long" pattern="yyyy/MM/dd HH:mm:ss" />",
        gapTime : ${systemTime.time - groupBuy.startTime.time},
    }
</script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/common.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
<script type="text/javascript" src="${webRoot}/template/bdw/oldWap/statics/js/wap-countdown.js"></script>
<script src="${webRoot}/template/bdw/oldWap/statics/js/tuanDetail.js"></script>
</body>

</html>
