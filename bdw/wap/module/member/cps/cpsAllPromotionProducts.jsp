<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.categoryId ? 1 : param.categoryId}" var="categoryId"/>
<c:set value="${sdk:findAllProductCategory()}" var="mian_cate"/>
<c:set value="${sdk:searchCpsPromotionPrd(6)}" var="productProxy"/>
<%--获取当前用户--%>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>
<c:set value="${webUrl}/wap/product-${param.id}.html?1=1" var="prdHref"/>
<c:set value="${webUrl}/product-${param.id}.html?1=1" var="prdPCHref"/>
<c:if test="${loginUser.isPopularizeMan eq 'Y'}">
    <c:set value="${sdk:getPromoteMemberByUserId()}" var="promoteMember"/>
    <c:set value="${webUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${prdHref}" var="prdHref"/>
    <c:set value="${webUrl}/cps/cpsPromote.ac?unid=${promoteMember.id}&target=${prdPCHref}" var="prdPCHref"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>全品推-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">
    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/cps-all-recommend.css">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/jquery.infinitescroll.min.js"></script>
    <script type="text/javascript">
        var webPath = {
            webRoot: "${webRoot}",
            lastPageNumber: ${productProxy.lastPageNumber}
        };
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/cpsAllPromotionProducts.js"></script>
</head>

<body>

<%--<header class="header">
    <a href="${webRoot}/wap/module/member/cps/cpsIndex.ac" class="back"></a>
    <div class="header-title">全品推-${webName}</div>
</header>--%>
<div class="main" id="main">
    <!-- 搜索 -->
    <div class="search" keyword="${param.keyword}">
        <div class="return" onclick="javascript:history.go(-1);"></div>
        <a href="javascript:;"><i class="icon icon-search"></i>${empty param.keyword ? '搜索商品':param.keyword}</a>
    </div>

    <div class="tab-nav" id="normalDiv">
        <ul>
            <li <c:if test="${empty param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}">默认排序</a>
            </li>
            <li <c:if test="${'rate' eq param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}&order=rate">返现比率</a>
            </li>
            <li <c:if test="${'amount' eq param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}&order=amount">返现佣金</a>
            </li>
            <li>
                <a id="selectCategroy" href="javascript:;">筛选</a>
            </li>
        </ul>
    </div>
    <div class="tab-nav" id="fixedDiv" style="display: none;top:0rem;position: fixed;">
        <ul>
            <li <c:if test="${empty param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}">默认排序</a>
            </li>
            <li <c:if test="${'rate' eq param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}&order=rate">返现比率</a>
            </li>
            <li <c:if test="${'amount' eq param.order}"> class="active"</c:if>>
                <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac?categoryId=${categoryId}&keyword=${param.keyword}&order=amount">返现佣金</a>
            </li>
            <li>
                <a id="selectCategroy1" href="javascript:;">筛选</a>
            </li>
        </ul>
    </div>
    <div class="tab-content">
        <div class="tab-panel">
            <ul class="good-list">
                <c:forEach items="${productProxy.result}" var="product">
                    <li class="media">
                        <a class="media-img" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}">
                            <img src="${product.imageProxy['200X200']}" alt="">
                        </a>
                        <div class="media-cont" onclick="goThisHref('${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}')">
                            <p class="media-name">${product.productNm}</p>
                            <p class="media-desc"> 商品单价&emsp;&yen;<fmt:formatNumber value="${product.unitPrice}" type="number" pattern="#0.00#" /></p>
                            <p class="media-desc"> 佣金比率&emsp;<fmt:formatNumber value="${product.rebateRate}" type="number" pattern="#0.00#" />%</p>
                            <p class="media-price">赚&ensp;<span><small>&yen;</small>${product.ratePriceIntValue}<small>.${product.ratePriceDecimalValue}</small></span></p>
                        </div>

                        <a class="action" href="${webRoot}/wap/product-${product.productId}.html?cps=${product.ratePrice}"  shareId="${product.productId}">分享赚钱</a>
                    </li>
                </c:forEach>

            </ul>
        </div>
    </div>
</div>
<nav id="page-nav">
    <a href="${webRoot}/wap/module/member/cps/loadCpsPrdlist.ac?categoryId=${categoryId}&keyword=${param.keyword}&page=2&order=${param.order}"></a>
</nav>
<!-- 分类筛选 -->
<div class="modal" id="modalCateFilter">
    <div class="modal-dropback"></div>
    <div class="modal-dialog" style="position: fixed;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">分类筛选</h4>
            </div>
            <div class="modal-body">
                <ul class="categroyUl">
                    <li categoryId="1" <c:if test="${empty param.categoryId || param.categoryId eq ''}"> class="active"</c:if>>
                        <a href="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac">全部商品</a>
                    </li>
                    <c:forEach items="${mian_cate}" var="category" varStatus="s">
                        <li categoryId="${category.categoryId}" <c:if test="${category.categoryId eq param.categoryId}">class="active"</c:if>><a href="javascript:;">${category.name}</a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="modal-footer">
                <a id="sureCategroy" categoryId="${param.categoryId}" class="btn-block" href="javascript:;">确&emsp;定</a>
            </div>
        </div>
    </div>
</div>

<div id="loadDiv" >  </div>
</body>

</html>
