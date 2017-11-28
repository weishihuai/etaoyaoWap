<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(28)}" var="productProxys"/>
<c:set value="${sdk:getShopRoot(param.shopId)}" var="shopRoot"/>
<c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<c:set value="${sdk:getChildren(categoryId,param.shopId)}" var="shopCategory"/>
<c:set value="${sdk:getShopCategoryProxyById(categoryId,param.shopId)}" var="shopCategoryCurrent"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${category.metaKeywords}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${category.metaDescription}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-${empty category.webTitle ? category.name : category.webTitle}-${param.keyword}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/shopTemplate/default/statics/css/shoplist.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/shopTemplate/default/statics/js/shoplist.js"></script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/shopTemplate/default/statics/js/shopIndex.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            totalCount:"${productProxys.lastPageNumber}",
            category:"${categoryId}",
            q:"${param.q}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            shopId:"${param.shopId}"
        }
    </script>
<title>店铺列表页</title>
<!--[if IE 6]>
<script type="text/javascript" src="script/DD_belatedPNG_0.0.8a-min.js"></script>
<script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
<%--<link href="style/shopindex.css" rel="stylesheet" type="text/css"/>--%>
</head>

<body>
   <c:import url="/template/bdw/module/common/top.jsp"/>
<div id="container">

      <c:import url="/${templateCatalog}/shopTemplate/default/include/shopHeader.jsp?p=list"/>

    <!--    main    -->
	<div id="main">
        <c:import url="/${templateCatalog}/shopTemplate/default/include/shopLeftMenu.jsp?shopId=${param.shopId}"/>
        <div class="main-r">
            <div class="autumn">
            	<p><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${shopCategoryCurrent.categoryId}&shopId=${param.shopId}">${shopCategoryCurrent.name}</a></p>
                <ul>
                    <c:forEach items="${shopCategory}" var="node" varStatus="s">
                        <li>
                            <a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${node.categoryId}&shopId=${param.shopId}">${node.name}</a>
                        </li>
                      </c:forEach>
                </ul>
                <div class="title"><a>共搜索到<span>${productProxys.totalCount}</span>个符合条件的商品</a></div>
            </div>
			<div class="cort-box" style="height: auto">
				<div class="cort">
					<div class="cort-l">
						<p>商品排序：</p>
						<li>
							<a <c:if test="${empty param.order}">class="default" </c:if><c:if test="${param.order=='lastOnSaleDate,desc'}">class='default'</c:if> <c:if test="${param.order=='lastOnSaleDate,asc'}">class='default'</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=<c:choose><c:when test="${param.order=='lastOnSaleDate,asc'}">lastOnSaleDate,desc</c:when><c:when test="${param.order=='lastOnSaleDate,desc'}">lastOnSaleDate,asc</c:when><c:otherwise>lastOnSaleDate,asc</c:otherwise></c:choose>">默认</a>
							<a <c:if test="${param.order=='salesVolume,desc'}">class='default'</c:if><c:if test="${param.order=='salesVolume,asc'}">class='default'</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=<c:choose><c:when test="${param.order=='salesVolume,asc'}">salesVolume,desc</c:when><c:when test="${param.order=='salesVolume,desc'}">salesVolume,asc</c:when><c:otherwise>salesVolume,asc</c:otherwise></c:choose>">销量<c:choose><c:when test="${param.order=='salesVolume,asc'}"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/33.png" /></c:when><c:otherwise><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/35.png" /></c:otherwise></c:choose></a>
							<a <c:if test="${param.order=='minPrice,desc'}">class='default'</c:if><c:if test="${param.order=='minPrice,asc'}">class='default'</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&order=<c:choose><c:when test="${param.order=='minPrice,asc'}">minPrice,desc</c:when><c:when test="${param.order=='minPrice,desc'}">minPrice,asc</c:when><c:otherwise>minPrice,asc</c:otherwise></c:choose>">价格<c:choose><c:when test="${param.order=='minPrice,asc'}"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/33.png" /></c:when><c:otherwise><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/35.png" /></c:otherwise></c:choose></a>
						</li>
					</div>
						<div class="cort-c">

						</div>
					<div class="cort-r">
						<p>${productProxys.thisPageNumber}/${productProxys.lastPageNumber}</p>
						<li>
							<a class="bigpic" id="pageUp" href="javascript:void(0)"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/41.png"/>上一页</a>
							<a id="pageDown" href="javascript:void(0)">下一页<img class="img1" src="${webRoot}/template/bdw/shopTemplate/default/statics/images/42.png" /></a>
						</li>
					</div>
				</div><div class="clear"></div>
				<div class="list">
                    <c:forEach items="${productProxys.result}" var="productProxy">
					<ul>
                        <div class="pic">
                            <a class="cur" href="${webRoot}/product-${productProxy.productId}.html">
                                <img src="${productProxy.defaultImage["160X160"]}" alt="${productProxy.name}"/>
                            </a>
                        </div>
						<li>
							<h2 style="height: 60px;overflow: hidden;"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></h2>
							<h3><a href="${webRoot}/product-${productProxy.productId}.html">销售价<span>${productProxy.price.unitPrice}元</span></a></h3>
							<h4>
                                <a href="${webRoot}/product-${productProxy.productId}.html">已销售
                                    <c:choose>
                                        <c:when test="${not empty productProxy.salesVolume}">
                                            <span>${productProxy.salesVolume}</span>笔
                                        </c:when>
                                        <c:otherwise>
                                            <span>0</span>笔
                                        </c:otherwise>
                                    </c:choose>
                                </a></h4>
						</li>
					</ul>
                    </c:forEach>
				</div>
                <div class="clear"></div>
                <div class="page">
                    <div style="float: right;">
                        <c:if test="${productProxys.lastPageNumber>1}">
                            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}'  totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/shopTemplate/default/shopProductList.ac' frontPath='${webRoot}' displayNum='6' />
                        </c:if>
                    </div>
                </div>
			</div>
        </div>
        <div class="clear"></div>
    </div>

    </div>
   <!--	footer-->
   <c:import url="/template/bdw/module/common/bottom.jsp"/>

</body>
<f:ShopEditTag/>
</html>
