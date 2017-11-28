<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@taglib uri="http://www.iloosen.com/sdk" prefix="dk"%>
<c:set var="limit" value="5"/>
<c:set value="${sdk:searchWapShopInfProxy(limit)}" var="shopInfPage"/>

<html>
<head lang="en">
    <meta charset="utf-8">
    <title>店铺街</title>
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript"src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/shop-street.js"></script>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet"/>
    <link href="${webRoot}/template/bdw/wap/statics/css/shop-street.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript">
        var Top_Path = {
            webRoot:"${webRoot}",
            sortType:"${param.sortType}",
            keyword:"${param.keyword}",
            lastPageNumber:"${param.lastPageNumber}"
        };
    </script>
</head>
<body>
<div class="m-top">
    <a class="back" href="${webRoot}/wap/index.ac"></a>
    <div class="search-box">
        <input class="search" type="text" value="${param.keyword}" onkeydown="enterSearch()">
        <c:if test="${ empty param.keyword}">
            <p class="search-p"><em class="search-icon"></em>搜索店铺名称</p>
        </c:if>
    </div>
</div>
<div class="shop-street-main" >
    <div class="dt"><span class="${ empty param.sortType ||"COMPREHENSIVE" eq param.sortType ? 'cur':'' }">
            <a href="${webRoot}/wap/shopStreet.ac?keyword=${param.keyword}&page=1&sortType=COMPREHENSIVE">综合排序</a>
        </span><span class="${"SALES_VOLUME" eq param.sortType ? 'cur':'' }" >
            <a href="${webRoot}/wap/shopStreet.ac?keyword=${param.keyword}&page=1&sortType=SALES_VOLUME">销量最高</a>
        </span><span class="${"EVALUATE" eq param.sortType? 'cur':'' }" >
            <a href="${webRoot}/wap/shopStreet.ac?keyword=${param.keyword}&page=1&sortType=EVALUATE">好评优先</a>
        </span></div>

    <div class="dd" id="shopInfList">
        <c:choose>
            <c:when test="${empty shopInfPage.result}">
                <div class="none-box">
                    <img class="none-icon" src="${webRoot}/template/bdw/wap/statics/images/kongsousuo.png" alt="">
                    <p>抱歉，没有找到相关店铺</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${shopInfPage.result}" var="shopInf" varStatus="s">
                    <div class="item">
                        <a class="pic" href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}" target="_blank">
                            <c:choose>
                                <c:when test="${shopInf.defaultImage['100X100'] eq '/template/bdw/statics/images/noPic_100X100.jpg'}">
                                    <img src="${webRoot}/template/bdw/wap/statics/images/wutupain_160x160.png" alt="">
                                </c:when>
                                <c:otherwise>
                                    <img src="${shopInf.defaultImage["100X100"]}" alt="">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <a class="name elli" target="_blank" href="${webRoot}/wap/shop/shopIndex.ac?shopId=${shopInf.shopInfId}">${shopInf.shopNm}</a>
                        <p class="star-number">
                            <span class="<c:if test="${shopInf.average>=1}">s</c:if>"></span>
                            <span class="<c:if test="${shopInf.average>=2}">s</c:if>"></span>
                            <span class="<c:if test="${shopInf.average>=3}">s</c:if>"></span>
                            <span class="<c:if test="${shopInf.average>=4}">s</c:if>"></span>
                            <span class="<c:if test="${shopInf.average>=5}">s</c:if>"></span>
                            <fmt:formatNumber value="${shopInf.average}" type="number" pattern="#0.0"/>
                        </p>
                        <p class="collect-number">收藏量${shopInf.collectdByUserNum}人 | 成交量${shopInf.orderTotalCount}笔</p>
                        <div class="discounts-box">
                            <c:if test="${not empty shopInf.discountList ||not empty shopInf.freePostageList||not empty shopInf.presentList||not empty shopInf.certificateList }">
                                <em class="icon-z" onclick="showOrHideDiscount(this)" data-onoff="true"></em>
                                <div style="overflow: hidden;" class="txt-box">
                                   <c:if test="${not empty shopInf.discountList}">
                                       <c:forEach items="${shopInf.discountList}" var="discount" end="0">
                                           <p class="elli"><span class="zhe">折</span>${discount.businessRuleNm}</p>
                                       </c:forEach>
                                   </c:if>
                                    <c:if test="${not empty shopInf.freePostageList}">
                                        <c:forEach items="${shopInf.freePostageList}" var="freePostage" end="0">
                                            <p class="elli"><span class="you">邮</span>${freePostage.businessRuleNm}</p>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${not empty shopInf.presentList}">
                                        <c:forEach items="${shopInf.presentList}" var="present" end="0">
                                            <p class="elli"><span class="zeng">赠</span>${present.businessRuleNm}</p>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${not empty shopInf.certificateList}">
                                        <c:forEach items="${shopInf.certificateList}" var="certificate" end="0">
                                            <p class="elli"><span class="jian">券</span>${certificate.businessRuleNm}</p>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </c:if>
                            <ul class="sp-list">
                                <c:if test="${not empty shopInf.wapShopProductList}">
                                    <c:forEach var="productProxy" items="${shopInf.wapShopProductList}">
                                        <c:set var="proImg" value="${productProxy.defaultImage['100X100']}"/>
                                        <c:if test="${empty productProxy.images}">
                                            <c:set var="proImg" value="${webRoot}/template/default/statics/images/noPic_100X100.jpg"/>
                                        </c:if>
                                        <li><a href="${webRoot}/wap/product.ac?id=${productProxy.productId}"><img src="${proImg}" alt=""><span class="price">￥<fmt:formatNumber value="${productProxy.price.unitPrice}" type="number" pattern="#0.00#"/></span></a></li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>


        <nav id="page-nav">
            <a href="${webRoot}/wap/loadMoreShopStreet.ac?keyword=${param.keyword}&page=2&limit=${limit}&sortType=${param.sortType}"></a>
        </nav>
    </div>

    <div class="bottom-logo"></div>
</div>


</body>
</html>

