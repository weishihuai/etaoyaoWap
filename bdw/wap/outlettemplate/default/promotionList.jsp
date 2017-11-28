<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${param.shopId}" var="shopId"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <title>${empty shop.shopNm ? '限时促销' : shop.shopNm}-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/store-index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/jquery-2.1.4.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
</head>
<%--根据店铺ID查询直降商品--%>
<c:set value="5" var="limit"/>

<c:set value="${sdk:findSpecialPriceProductProxy(shopId, 1, limit)}" var="panicBuyProductProxyList"/>
<body>
<div class="m-top">
    <a href="javascript:history.go(-1);" class="back"></a>
    <span>限时促销</span>
</div>
<div id="list-inner" class="store-main">
<c:forEach var="productProxy" varStatus="s" items="${panicBuyProductProxyList.result}">
    <c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
   <div class="time-limit">
            <div class="swiper-slide">
                <div class="mt">
                    <div id="endDateStr_${s.index}" class="mt-rt" endDateStr="${productProxy.endDateStr}"></div>
                </div>
                <div class="mc">
                    <div class="mc-box">
                        <div class="pic">
                            <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}">
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
                        <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}" class="title">${productProxy.name}<br>
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
                        <a href="${webRoot}/wap/outlettemplate/default/product.ac?id=${productProxy.productId}" class="buy-btn">立即抢购</a>
                    </div>
                </div>
            </div>
</div>
</c:forEach>
</div>
<nav id="page-nav">
    <a href="${webRoot}/wap/outlettemplate/default/loadMorePromotion.ac?shopId=${shopId}&page=2&limit=${limit}"></a>
</nav>
<script type="text/javascript">
    $(function () {
        $("#list-inner").infinitescroll({
            navSelector: "#page-nav",     //页面分页元素--成功后自动隐藏
            nextSelector: "#page-nav a",
            itemSelector: ".time-limit" , //选择的是你要加载的那一个块（每次载入的数据放的地方）
            animate: true,
            loading: {
                finishedMsg: '无更多数据',
                finished: function() {
                    $("#infscr-loading").remove();
                }
            },
            extraScrollPx: 50,
            maxPage:${panicBuyProductProxyList.lastPageNumber}
        });
    });

</script>
</body>
</html>