<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%--商品列表数据--%>
<c:set value="${bdw:searchProductByType(6,'N')}" var="productProxys"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<%--默认每页显示6条数据--%>
<c:set value="6" var="limit"/>
<%--面包屑搜索--%>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%--全部分类信息--%>
<c:set value="${sdk:findAllProductCategory()}" var="allProductCategory"/>
<c:set value="${param.category==null ? 1 : param.category}" var="categoryId"/>
<c:set value="${sdk:queryChildren(1)}" var="mian_cate"/>
<c:set value="${sdk:queryProductCategoryById(categoryId)}" var="category"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${category.name}-${webName}</title>
    <link href="${webRoot}/template/bdw/wap/statics/css/swiper.min.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/wap/statics/css/list.css" type="text/css" rel="stylesheet" />

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
    <script src="${webRoot}/template/bdw/wap/statics/js/productList.js" type="text/javascript"></script>
</head>
<body>
<div class="list-main">
    <div class="list-head">
        <div class="list-head-t" style="display: block;">
            <div class="return" onclick="history.go(-1);"></div>
            <div class="search" onclick="window.location.href ='${webRoot}/wap/newSearch.ac?category=${categoryId}&q=${param.q}&page=1&order=${param.order}'">
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
                        <li><a data-active="${param.order==""||param.order==null?'true':'false'}" href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">综合</a></li>
                        <li><a data-active="${param.order=='minPrice,asc'?'true':'false'}" href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&order=minPrice,asc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从低到高</a></li>
                        <li><a data-active="${param.order=='minPrice,desc'?'true':'false'}" href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&order=minPrice,desc&keyword=${param.keyword}&isInStore=${param.isInStore}&page=1">价格从高到低</a></li>
                    </ul>
                </li>
                <c:if test="${param.order=='salesVolume,desc'}">
                    <li class="cur high-to-low"><a href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order=='salesVolume,asc'}">
                    <li class="cur"><a href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,desc"><span style="color: #FF6B00;">销量</span></a></li>
                </c:if>
                <c:if test="${param.order !='salesVolume,desc' and param.order !='salesVolume,asc'}">
                    <li><a href="${webRoot}/wap/productList.ac?category=${categoryId}&q=${param.q}&keyword=${param.keyword}&page=1&isInStore=${param.isInStore}&order=salesVolume,asc"><span>销量</span></a></li>
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
                    <div class="dd" id="loadFilter" style="display: none">
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
                                <div class="li-dt">分类<span id="categoryName">全部</span></div>
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
                                                               <p data-active="false" categoryid="${child.categoryId}" name="${child.name}">${child.name}</p>
                                                           </c:forEach>
                                                       </c:if>
                                                   </div>
                                               </li>
                                           </c:forEach>
                                       </c:if>
                                    </ul>
                                </div>
                            </li>
                            <li class="sx-brand" id="brandMenu" style="display: block">
                                <div class="li-dt">品牌<span id="brandName">全部</span></div>
                                <div class="li-dd">
                                    <div class="li-dd-title"><a class="btn-return" href="javascript:void(0);"></a>全部品牌<a id="confirmBrand" class="btn-qued" href="javascript:void(0);">确定</a></div>
                                    <div id="brandDiv">

                                    </div>
                                </div>
                            </li>
                            <li class="sx-jx" id="formMenu" style="display: none">
                                <div class="li-dt">剂型<span id="formName">全部</span></div>
                                <div class="li-dd">
                                    <div class="li-dd-title"><a class="btn-return" href="javascript:void(0);"></a>剂型<a id="confirmDosage" class="btn-qued" href="javascript:void(0);">确定</a></div>
                                    <div id="formDiv">

                                    </div>
                                </div>
                            </li>
                            <li class="btn-box"><a class="btn-reset" href="javascript:void(0);">重置</a><a id="selectResult" class="btn-confirm" href="javascript:void(0);">确定<span></span></a></li>
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
            <c:set var="productProxy" value="${sdk:getProductById(product.productId)}"/>
            <c:set value="${productProxy.availableBusinessRuleList}" var="availableBusinessRuleList" />
            <c:set var="attrDicList" value="${productProxy.dicValues}"/>
            <c:set var="attrDicMap" value="${productProxy.dicValueMap}"/>
            <c:set var="attrGroupProxyList" value="${productProxy.attrGroupProxyList}"/>
            <div class="item">
                <a class="item-l" href="${webRoot}/wap/product.ac?id=${product.productId}">
                    <img src="${product.defaultImage["320X320"]}" alt="${product.name}">
                </a>
                <div class="item-r" <c:if test="${status.last}">style="border-bottom: none"</c:if>>
                    <a class="name" href="${webRoot}/wap/product.ac?id=${product.productId}">${product.name}&nbsp;
                        <span class="red">
                                ${product.salePoint}
                        </span>
                    </a>
                    <p class="guige">
                        <c:if test="${not empty attrGroupProxyList}">
                            <c:forEach items="${attrGroupProxyList}" var="attrGroupProxy">
                                <c:if test="${fn:length(attrGroupProxy.dicValues)>0 && attrGroupProxy.attrGroupNm != '通用属性组'}">
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
                                    <c:when test="${rule.ruleTypeCode=='1'||rule.ruleTypeCode=='2'||rule.ruleTypeCode=='3'}"><span>折扣</span></c:when>
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
    <a href="${webRoot}/wap/loadMoreProductList.ac?order=${param.order}&category=${param.category}&q=${param.q}&keyword=${param.keyword}&startPrice=${param.startPrice}&endPrice=${param.endPrice}&isInStore=${param.isInStore}&page=2&limit=${limit}"></a>
</nav>

<script type="text/javascript">
    var startPrice = '${param.startPrice}';
    var endPrice = '${param.endPrice}';
    var category = '${param.category}';

    /*动态加载品牌、剂型信息*/
    loadFilterBrand(category);
    loadFilterForm(category);

    $(document).ready(function () {
        //当前筛选条件有价格，则赋值到筛选面板上
        if (startPrice) {
            $("#minSearchPrice").val(startPrice);
        }

        if (endPrice) {
            $("#maxSearchPrice").val(endPrice);
        }

        /*当前筛选条件有价格，则赋值到筛选面板上*/
        if (1 == category || '' == category) {
            $("#categoryName").text("全部");
        } else {
            var categoryName = '';
            $(".sp-sort-sx").find(".sx-class .li-dd-inner").find(".class-item-box").children().each(function () {
                if (category == $(this).attr("categoryid")) {
                    $(".all-class").attr("data-active", "false");
                    $(this).attr("data-active", "true");
                    categoryName = $(this).attr("name");
                }
            });
            $("#categoryName").text(categoryName);
        }

        var q = '${param.q}';
        /*页面元素渲染完成之后才执行，否则找不到相应的dom元素*/
        var brandNameArr = [];
        var formNameArr = [];
        setTimeout(function () {
            if (q) {
                var curQMap = parsingQ(q);
                for (var i = 0; i < curQMap.size(); i++) {
                    var key = curQMap.elements[i].key;
                    var value = curQMap.elements[i].value.split(',');
                    for (var j = 0; j < value.length; j++) {
                        $("#" + key + "-" + value[j]).attr("data-active", "true");
                        if (key == "brandId"){
                            brandNameArr.push($("#" + key + "-" + value[j]).text());
                        } else if(key == "form_t") {
                            formNameArr.push($("#" + key + "-" + value[j]).text());
                        }
                    }
                }
                showSelectedBrandOrFormName("#brandName",brandNameArr);
                showSelectedBrandOrFormName("#formName",formNameArr);
            }
        }, 1000);

    });
</script>
</body>
</html>



