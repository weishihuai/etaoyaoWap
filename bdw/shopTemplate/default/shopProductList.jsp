<%@ taglib prefix="p" uri="/iMallTag" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/shopError.ac"></c:redirect>
</c:if>
<%--<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>--%>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(20)}" var="productProxys"/>

<c:set value="${sdk:getShopRoot(param.shopId)}" var="shopRoot"/>
<c:set value="${param.shopCategoryId==null ? shopRoot : param.shopCategoryId}" var="categoryId"/>
<c:set value="${sdk:getFacet()}" var="facetProxy"/>
<c:set value="${sdk:getChildren(categoryId,param.shopId)}" var="shopCategory"/>
<c:set value="${sdk:getShopCategoryProxyById(categoryId,param.shopId)}" var="shopCategoryCurrent"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="${category.metaKeywords}-${shop.shopNm}-${webName}" /> <%--SEO keywords优化--%>
    <meta name="description" content="${category.metaDescription}-${shop.shopNm}-${webName}" /> <%--SEO description优化--%>
    <title>${webName}-${shop.shopNm}-${empty category.webTitle ? category.name : category.webTitle}-${param.keyword}</title>
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/shopTemplate/default/statics/css/shop_index.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/shopTemplate/default/statics/css/shop_top.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/js/jDialog/jDialog.css" rel="stylesheet" type="text/css"/>
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jDialog/jDialog.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.min.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            totalCount:"${productProxys.lastPageNumber}",
            category:"${categoryId}",
            q:"${param.q}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            shopId:"${param.shopId}",
            shopCategoryId:"${categoryId}",
            minPrice:"${param.minPrice}",
            maxPrice:"${param.maxPrice}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/template/bdw/shopTemplate/default/statics/js/shoplist.js"></script>
</head>

<body>
<c:import url="/template/bdw/shopTemplate/default/include/shopHeader.jsp?p=productList"/>



<div class="shop_m2">
    <c:import url="/template/bdw/shopTemplate/default/include/shopLeftMenu.jsp?p=shoplist"/>
    <div class="m2_r">
        <div class="r_box01">
    	<!--店铺分类-->
            <div class="b_layer">
                <a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${shopCategoryCurrent.categoryId}&shopId=${param.shopId}">${shopCategoryCurrent.name}</a>
                <a><i>共搜索到<span>${productProxys.totalCount}</span>个符合条件的商品</i></a>
            </div>
              <div class="b_fl">
                  <%--显示分类下子分类未实施--%>
                  <c:forEach items="${shopCategory}" var="node" varStatus="s">
                      <a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopCategoryId=${node.categoryId}&shopId=${param.shopId}">${node.name}</a>
                  </c:forEach>
              </div>
        </div>
        <!--end 店铺分类-->
        <div class="r_box02">
        	<div class="sort">
            	<ul class="sort_l">
                	<li class="mr"><a <c:if test="${empty param.order}">class="default" style="color: #fff;" </c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}<%--&order=<c:choose><c:when test="${param.order=='lastOnSaleDate,asc'}">lastOnSaleDate,desc</c:when><c:when test="${param.order=='lastOnSaleDate,desc'}">lastOnSaleDate,asc</c:when><c:otherwise>lastOnSaleDate,asc</c:otherwise></c:choose>--%>">默认</a></li>
                    <li class="tab"><a <c:if test="${param.order=='lastOnSaleDate,desc'}">class='default' style="color: #fff;"</c:if><c:if test="${param.order=='lastOnSaleDate,asc'}">class='default' style="color: #fff;"</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&order=<c:choose><c:when test="${param.order=='lastOnSaleDate,asc'}">lastOnSaleDate,desc</c:when><c:when test="${param.order=='lastOnSaleDate,desc'}">lastOnSaleDate,asc</c:when><c:otherwise>lastOnSaleDate,asc</c:otherwise></c:choose>">新品<c:choose><c:when test="${param.order=='lastOnSaleDate,asc'}"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/33.png" /></c:when><c:otherwise><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/35.png" /></c:otherwise></c:choose></a></li>
                    <li class="tab cur"><a <c:if test="${param.order=='salesVolume,desc'}">class='default' style="color: #fff;"</c:if><c:if test="${param.order=='salesVolume,asc'}">class='default' style="color: #fff;"</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&order=<c:choose><c:when test="${param.order=='salesVolume,asc'}">salesVolume,desc</c:when><c:when test="${param.order=='salesVolume,desc'}">salesVolume,asc</c:when><c:otherwise>salesVolume,asc</c:otherwise></c:choose>">销量<c:choose><c:when test="${param.order=='salesVolume,asc'}"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/33.png" /></c:when><c:otherwise><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/35.png" /></c:otherwise></c:choose></a></li>
                    <li class="tab2"><a <c:if test="${param.order=='minPrice,desc'}">class='default' style="color: #fff;"</c:if><c:if test="${param.order=='minPrice,asc'}">class='default' style="color: #fff;"</c:if> href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${categoryId}&q=${param.q}&keyword=${param.keyword}&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&order=<c:choose><c:when test="${param.order=='minPrice,asc'}">minPrice,desc</c:when><c:when test="${param.order=='minPrice,desc'}">minPrice,asc</c:when><c:otherwise>minPrice,asc</c:otherwise></c:choose>">价格<c:choose><c:when test="${param.order=='minPrice,asc'}"><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/33.png" /></c:when><c:otherwise><img src="${webRoot}/template/bdw/shopTemplate/default/statics/images/35.png" /></c:otherwise></c:choose></a></li>
                    <li class="xz cur" id="selectPrice">
                    	<div class="xz_price">
                        	<input type="text" class="put searchBox" id="s-minPrice" value="${param.minPrice}">
                            <div class="text">-</div>
                            <input type="text" class="put searchBox" id="s-maxPrice" value="${param.maxPrice}">
                        </div>
                        <div class="xz_btn" id="xz_btn" style="display: none">
                        	<div class="qc"><a href="javascript:" class="searchBoxQk">清空</a></div>
                            <div class="qd"><a href="javascript:" class="searchBoxQd">确定</a></div>
                        </div>
                    </li>
                </ul>
            	<div class="page">
                    <div class="text"><i>${productProxys.thisPageNumber}</i>/${productProxys.lastPageNumber}页</div>
                    <div class="next"><a href="javascript:" id="pageUp"></a></div>
                    <div class="next2"><a href="javascript:" id="pageDown"></a></div>
                    <div class="clear"></div>
                </div>
            </div>

            <div  class="b_box" style="width:976px;">
                <c:forEach items="${productProxys.result}" var="productProxy" end="19" varStatus="status">
                   <ul class="b_info">
                                    <li class="i_pic"><a href="${webRoot}/product-${productProxy.productId}.html"><img width="200" height="200" src="${productProxy.defaultImage["200X200"]}" alt="${productProxy.name}"></a></li>
                                    <li class="i_title"><a href="${webRoot}/product-${productProxy.productId}.html">${productProxy.name}</a></li>
                                    <li class="i_price">
                                        <i>￥</i>${productProxy.price.unitPrice}
                                        <em>￥${productProxy.marketPrice}</em>
                                    </li>

                                     <%--2015-06-03,zch,由于现在销量少,所以暂时先不显示--%>
                                    <%--<li class="i_yx">已销售
                                        <c:choose>
                                              <c:when test="${not empty productProxy.salesVolume}">
                                                        <i>${productProxy.salesVolume}</i>笔
                                              </c:when>
                                              <c:otherwise>
                                                  <i>0</i>笔
                                              </c:otherwise>
                                        </c:choose>
                                    </li>--%>
                   </ul>
                </c:forEach>
            </div>
            <div class="clear"></div>
        </div>
        <div class="new-page-footer">
            <div style="float: right;">
                <c:if test="${productProxys.lastPageNumber>1}">
                    <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${productProxys.lastPageNumber}' currentPage='${_page}'  totalRecords='${productProxys.totalCount}' ajaxUrl='${webRoot}/shopTemplate/default/shopProductList.ac' frontPath='${webRoot}' displayNum='6' />
                </c:if>
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>


<c:import url="/template/bdw/module/common/bottom.jsp"/>
</body>
<f:ShopEditTag/>
</html>
