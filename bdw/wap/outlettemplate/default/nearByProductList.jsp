<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%--商品列表数据--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:searchNearByOutletProduct(6)}" var="productProxys"/>
<%--默认每页显示6条数据--%>
<c:set value="6" var="limit"/>
<%--面包屑搜索--%>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--全部分类信息--%>
<c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
<c:set value="${empty param.category ? 1 : param.category}" var="categoryId"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>附近门店商品-${webName}</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/outlettemplate/default/statics/css/nearByProductList.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            sort:"${param.sort}",
            category:"${categoryId}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            q:"${param.q}",   //q是queryString
            lastPageNumber:"${productProxys.lastPageNumber}",
            isInStore:"${param.isInStore}",
            startPrice:"${param.startPrice}",
            endPrice:"${param.endPrice}"
        };
    </script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.7.1.min.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/flexible.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/nearByProductList.js" type="text/javascript"></script>
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
                        <li><a data-active="${param.order==""||param.order==null?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">综合</a></li>
                        <li><a data-active="${param.order=='minPrice,asc'?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&order=minPrice,asc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从低到高</a></li>
                        <li><a data-active="${param.order=='minPrice,desc'?'true':'false'}" href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&order=minPrice,desc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从高到低</a></li>
                    </ul>
                </li>
                <c:if test="${param.order=='salesVolume,desc'}">
                    <li class="cur high-to-low"><a href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order=='salesVolume,asc'}">
                    <li class="cur"><a href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,desc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order !='salesVolume,desc' and param.order !='salesVolume,asc'}">
                    <li><a href="${webRoot}/wap/outlettemplate/default/nearByProductList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span>销量</span></a></li>
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
                <li class="sp-sort-sx">
                    <div class="dt">筛选</div>
                    <div class="dd">
                        <ul class="dd-inner">
                            <li class="sx-show">
                                <a id="isInStore" href="javascript:void(0);" class="<c:if test="${param.isInStore == 'Y'}">cur</c:if>">仅显示有货</a>
                            </li>
                            <li class="price-range">
                                <p>价格范围</p>
                                <input type="text" id="minSearchPrice" placeholder="最低价" oninput="checkPrice(this)">
                                <span style="color: #3B3E46">-</span>
                                <input type="text" id="maxSearchPrice" placeholder="最高价" oninput="checkPrice(this)">
                            </li>
                            <li class="sx-class">
                                <div class="li-dt">分类<span>全部</span></div>
                                <div class="li-dd">
                                    <div class="li-dd-title"><a class="btn-return" href="javascript:void(0);"></a>分类</div>
                                    <ul class="li-dd-inner">
                                        <li class="all-class" data-active="true">全部分类</li>
                                       <c:if test="${not empty allProductCategory}">
                                           <c:forEach items="${allProductCategory}" var="category" varStatus="i" end="9">
                                               <li>
                                                   <div class="class-name">${category.name}</div>
                                                   <div class="class-item-box">
                                                       <c:if test="${not empty category.children}">
                                                           <c:forEach items="${category.children}" varStatus="c" var="child">
                                                               <p data-active="false" categoryid="${child.categoryId}">${child.name}</p>
                                                           </c:forEach>
                                                       </c:if>
                                                   </div>
                                               </li>
                                           </c:forEach>
                                       </c:if>
                                    </ul>
                                </div>
                            </li>
                            <li class="sx-brand">
                                <div class="li-dt">品牌</div>
                                <div class="li-dd">
                                    <div class="li-dd-title"><a class="btn-return" href="javascript:void(0);"></a>全部品牌<a id="confirmBrand" class="btn-qued" href="javascript:void(0);">确定</a></div>
                                    <ul class="li-dd-inner">
                                      <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="i">
                                            <c:if test="${fn:length(unSelections.couts) > 0}">
                                                <c:if test="${not empty unSelections.couts[0].name and unSelections.title eq '品牌'}">
                                                    <li>
                                                        <%--<div class="brand-name">A</div>--%>
                                                        <div class="brand-item-box">
                                                            <c:forEach items="${unSelections.couts}" var="count" varStatus="i">
                                                                <c:if test="${not empty count.name}">
                                                                    <p field="${count.field}" fieldValue="${count.value}">${count.name}</p>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </li>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                    <div class="initial-side"><span>A</span><span>B</span><span>C</span><span>D</span><span>E</span><span>F</span><span>G</span><span>H</span><span>I</span><span>J</span><span>K</span><span>L</span><span>M</span><span>N</span><span>O</span><span>P</span><span>Q</span><span>R</span><span>S</span><span>T</span><span>U</span><span>V</span><span>W</span><span>X</span><span>Y</span><span>Z</span></div>
                                    <div class="initial-tips">A</div>
                                </div>
                            </li>
                            <li class="sx-jx">
                                <div class="li-dt">剂型</div>
                                <div class="li-dd">
                                    <div class="li-dd-title"><a class="btn-return" href="javascript:void(0);"></a>剂型<a id="confirmDosage" class="btn-qued" href="javascript:void(0);">确定</a></div>
                                    <div class="li-dd-inner">
                                        <c:forEach items="${facetProxy.unSelections}" var="unSelections" varStatus="s">
                                            <c:if test="${fn:length(unSelections.couts) > 0}">
                                                <c:if test="${not empty unSelections.couts[0].name and unSelections.title eq '剂型'}">
                                                    <c:forEach items="${unSelections.couts}" var="count">
                                                        <c:if test="${not empty count.name}">
                                                            <p field="${count.field}" fieldValue="${count.value}">${count.name}</p>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </li>
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
                                    <c:when test="${rule.ruleTypeCode eq '0'|| rule.ruleTypeCode eq '1'|| rule.ruleTypeCode eq '2'}"><span>折扣</span></c:when>
                                    <c:when test="${rule.ruleTypeCode eq '3'|| rule.ruleTypeCode eq '4'|| rule.ruleTypeCode eq '5'}"><span>包邮</span></c:when>
                                    <c:when test="${rule.ruleTypeCode eq '6'|| rule.ruleTypeCode eq '7'|| rule.ruleTypeCode eq '8'}"><span>赠品</span></c:when>
                                    <c:when test="${rule.ruleTypeCode eq '9'|| rule.ruleTypeCode eq '10'|| rule.ruleTypeCode eq'11'}"><span>换购</span></c:when>
                                    <c:when test="${rule.ruleTypeCode eq '12'|| rule.ruleTypeCode eq '13'|| rule.ruleTypeCode eq '14' || rule.ruleTypeCode eq '15'}"><span>送券</span></c:when>
                                    <c:when test="${rule.ruleTypeCode eq '19'|| rule.ruleTypeCode eq '20'|| rule.ruleTypeCode eq '21'}"><span>送积分</span></c:when>
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
                        <a class="yaofang" href="javascript:void(0);">${product.shopInfProxy.shopNm}</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="none-box">
            <img class="none-icon" src="${webRoot}/template/bdw/wap/statics/images/kongsousuo.png" />
            <p>抱歉，没有找到相关商品</p>
        </div>
    </c:otherwise>
</c:choose>
    </div>
    <div class="bottom-logo"></div>
</div>

<%--下拉加载更多--%>
<nav id="page-nav">
    <a href="${webRoot}/wap/outlettemplate/default/loadMoreNearByProductList.ac?order=${param.order}&category=${param.category}&q=${param.q}&keyword=${param.keyword}&startPrice=${param.startPrice}&endPrice=${param.endPrice}&isInStore=${param.isInStore}&page=2&limit=${limit}"></a>
</nav>

</body>
</html>



