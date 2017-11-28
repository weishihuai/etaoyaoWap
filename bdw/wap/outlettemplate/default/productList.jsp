<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:if test="${empty param.shopId}">
    <c:redirect url="${webRoot}/wap/index.ac"/>
</c:if>
<%--商品列表数据--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${param.shopId}" var="shopId"/>
<c:set value="6" var="limit"/>
<c:set value="${param.shopCategoryId}" var="shopCategoryId"/>
<c:set value="${sdk:search(limit)}" var="productProxys"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<%--默认每页显示6条数据--%>

<%@ page import="org.apache.commons.lang.StringUtils" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${shop.shopNm}-${webName}</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/list.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            sort:"${param.sort}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            q:"${param.q}",   //q是queryString
            lastPageNumber:"${productProxys.lastPageNumber}",
            isInStore:"${param.isInStore}",
            startPrice:"${param.startPrice}",
            endPrice:"${param.endPrice}",
            shopCategoryId: "${shopCategoryId}",
            shopId: "${shopId}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/productList.js" type="text/javascript"></script>
</head>
<body>
<div class="list-main">
    <div class="list-head">
        <div class="list-head-t">
            <div class="return" onclick="history.go(-1);"></div>
            <div class="search">
                <input id="searchInput" type="text" value="${param.keyword}"/>
            </div>
            <div class="toggle" data-list="true"></div>
        </div>
        <div class="list-head-b">
            <ul class="sp-sort clearfix">
                <c:if test='${param.order ne "minPrice,desc"}'><li class="sp-sort-zh <c:if test="${param.order == '' or param.order == null or param.order eq 'minPrice,asc'}">cur</c:if>"></c:if>
                <c:if test='${param.order eq "minPrice,desc"}'><li class="sp-sort-zh cur high-to-low"></c:if>
                <c:if test="${param.order != 'minPrice,asc' and param.order != 'minPrice,desc'}"><div class="dt">综合</div></c:if>
                <c:if test="${param.order == 'minPrice,asc' or param.order == 'minPrice,desc'}"><div class="dt">价格</div></c:if>
                    <ul class="dd">
                        <li><a data-active="${param.order==""||param.order==null?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">综合</a></li>
                        <li><a data-active="${param.order=='minPrice,asc'?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&order=minPrice,asc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从低到高</a></li>
                        <li><a data-active="${param.order=='minPrice,desc'?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&order=minPrice,desc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从高到低</a></li>
                    </ul>
                </li>
                <c:if test="${param.order=='salesVolume,desc'}">
                    <li class="cur high-to-low"><a href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order=='salesVolume,asc'}">
                    <li class="cur"><a href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,desc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order !='salesVolume,desc' and param.order !='salesVolume,asc'}">
                    <li><a href="${webRoot}/wap/outlettemplate/default/productList.ac?shopId=${shopId}&shopCategoryId=${shopCategoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span>销量</span></a></li>
                </c:if>
                <c:if test="${param.order eq 'lastOnSaleDate,desc'}">
                    <li class="cur high-to-low"><a href="javascript:void(0);" onclick="changeSortByOnSaleDate(this)" style="color: #FF6B00;">新品</a></li>
                </c:if>
                <c:if test="${param.order eq 'lastOnSaleDate,asc'}">
                    <li class="cur"><a href="javascript:void(0);" onclick="changeSortByOnSaleDate(this)" style="color: #FF6B00;">新品</a></li>
                </c:if>
                <c:if test="${param.order ne 'lastOnSaleDate,asc' and param.order ne 'lastOnSaleDate,desc'}">
                    <li><a href="javascript:void(0);" onclick="changeSortByOnSaleDate(this)">新品</a></li>
                </c:if>
            </ul>
        </div>
    </div>

<c:choose>
    <c:when test="${not empty productProxys.result}">
        <div id="list_inner" class="list-inner clearfix">
        <c:forEach items="${productProxys.result}" var="product" varStatus="status" end="9">
            <c:set value="${product.availableBusinessRuleList}" var="availableBusinessRuleList" />
            <c:set var="attrDicList" value="${product.dicValues}"/>
            <c:set var="attrDicMap" value="${product.dicValueMap}"/>
            <c:set var="attrGroupProxyList" value="${product.attrGroupProxyList}"/>
            <div class="item">
                <a class="item-l" href="${webRoot}/wap/outlettemplate/default/product.ac?id=${product.productId}">
                    <img src="${product.defaultImage["320X320"]}" alt="${product.name}">
                </a>
                <div class="item-r">
                    <a class="name" href="${webRoot}/wap/outlettemplate/default/product.ac?id=${product.productId}">${product.name}&nbsp;
                        <span class="red">
                                ${product.salePoint}
                        </span>
                    </a>
                    <p class="guige">
                        <c:if test="${not empty attrGroupProxyList}">
                            <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                                <c:if test="${fn:length(attrGroupProxy.dicValues) gt 0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
                                    <c:forEach items="${attrGroupProxy.dicValues}" var="attrDict" end="0">
                                        <c:if test="${not empty attrGroupProxy.dicValueMap[attrDict.innerCode].valueString}">
                                            <c:if test="${not empty attrGroupProxy.dicValueMap}">
                                                ${attrGroupProxy.dicValueMap['span'].valueString}
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </p>
                    <div class="product-character">
                        <c:choose>
                            <c:when test="${product.prescriptionTypeCode eq '甲类OTC'}"><span>甲OTC</span></c:when>
                            <c:when test="${product.prescriptionTypeCode eq 'RX'}"><span>RX</span></c:when>
                            <c:when test="${product.prescriptionTypeCode eq '乙类OTC'}"><span>乙OTC</span></c:when>
                        </c:choose>
                        <c:if test="${not empty availableBusinessRuleList}">
                            <c:forEach items="${availableBusinessRuleList}" var="rule" varStatus="status">
                                <c:choose>
                                    <c:when test="${rule.ruleTypeCode == '1'|| rule.ruleTypeCode == '2'|| rule.ruleTypeCode == '3'}"><span>折扣</span></c:when>
                                    <c:when test="${rule.ruleTypeCode=='4'||rule.ruleTypeCode=='5'||rule.ruleTypeCode=='6'}"><span>包邮</span></c:when>
                                    <c:when test="${rule.ruleTypeCode=='7'||rule.ruleTypeCode=='8'||rule.ruleTypeCode=='9'}"><span>赠品</span></c:when>
                                    <c:when test="${rule.ruleTypeCode=='10'||rule.ruleTypeCode=='11'||rule.ruleTypeCode=='12'}"><span>换购</span></c:when>
                                    <c:when test="${rule.ruleTypeCode=='13'||rule.ruleTypeCode=='14'||rule.ruleTypeCode=='15'||rule.ruleTypeCode=='16'}"><span>送券</span></c:when>
                                    <c:when test="${rule.ruleTypeCode=='20'||rule.ruleTypeCode=='21'||rule.ruleTypeCode=='22'}"><span>送积分</span></c:when>
                                </c:choose>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="price-yaofang">
                        <c:set value="${product.price.unitPrice}" var="unitPrice"/>
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
                        <p class="price">￥<span>${integerPrice}.</span>${decimalPrice}</p>
                        <a class="yaofang elli" href="javascript:void(0);">${product.shopInfProxy.shopNm}</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="none-box">
            <img class="none-icon" src="${webRoot}/template/bdw/wap/statics/images/kongsousuo.png" alt="">
            <p>抱歉，没有找到相关商品</p>
        </div>
    </c:otherwise>
</c:choose>
    </div>
    <div class="bottom-logo"></div>
</div>

<%--下拉加载更多--%>
<nav id="page-nav">
    <a href="${webRoot}/wap/outlettemplate/default/loadMoreProductList.ac?shopId=${shopId}&order=${param.order}&shopCategoryId=${shopCategoryId}&q=${param.q}&keyword=${param.keyword}&startPrice=${param.startPrice}&endPrice=${param.endPrice}&isInStore=${param.isInStore}&page=2&limit=${limit}"></a>
</nav>

</body>
</html>



