<%@ taglib prefix="f" uri="/iMallTag" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<c:set value="${sdk:isShowAdvAndRecommend()}" var="isShowAdvAndRecommend"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>首页-${shop.shopNm}-${webName}</title>
    <!--[if IE 6]>
    <script type="text/javascript" src="script/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('div,ul,li,a,h1,h2,h3,input,img,span,dl, background');</script><![endif]-->
    <link href="${webRoot}/${templateCatalog}/shopTemplate/default/statics/css/shopindex.css" rel="stylesheet" type="text/css" />
    <link href="${webRoot}/template/bdw/statics/css/header.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="${webRoot}/${templateCatalog}/statics/js/jquery-1.6.1.min.js"></script>
    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}"
        }
    </script>
    <script type="text/javascript" src="${webRoot}/${templateCatalog}/shopTemplate/default/statics/js/shopIndex.js"></script>
</head>

<body>
<!--	header-->
<c:import url="/template/bdw/module/common/top.jsp"/>
<div id="container">

<c:import url="/${templateCatalog}/shopTemplate/default/include/shopHeader.jsp?p=index"/>

<div class="shopEdit" shopInfo="shop_top_custom1">
    <c:set var="defineHtml1" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom1').pageModuleObjects[0].userDefinedContStr}"/>
    <div style="${empty defineHtml1 ? "display:none" : "display:block"}">
        ${empty defineHtml1 ? "自定义区块":(defineHtml1)}
    </div>
</div>

<div class="shopEdit" shopInfo="shop_top_custom2">
    <c:set var="defineHtml2" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom2').pageModuleObjects[0].userDefinedContStr}"/>
    <div style="${empty defineHtml2 ? "display:none" : "display:block"}">
        ${empty defineHtml2? "自定义区块":(defineHtml2)}
    </div>
</div>

<div class="shopEdit" shopInfo="shop_top_custom3">
    <c:set var="defineHtml3" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_top_custom3').pageModuleObjects[0].userDefinedContStr}"/>
    <div style="${empty defineHtml3 ? "display:none" : "display:block"}">
        ${empty defineHtml3 ? "自定义区块":defineHtml3}
    </div>
</div>

<!--    main    -->
<div id="main">

    <c:import url="/${templateCatalog}/shopTemplate/default/include/shopLeftMenu.jsp"/>

    <!--        main-r-->
    <div class="main-r">
        <%--头部广告 start--%>
        <c:if test="${isShowAdvAndRecommend}">
            <div class="shopEdit" shopInfo="shop_top_adv|780X90" style="margin-bottom: 10px;">
                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId, 'shop_top_adv').advt.advtProxy}" var="adv" end="0" varStatus="s">
                    <a href="${adv.link}" title="${adv.title}" target="_blank"><img  src="${adv.advUrl}" alt="${adv.hint}" title="${adv.title}"  width="780px" height="90px" /></a>
                </c:forEach>
            </div>
        </c:if>
        <%--头部广告 end--%>

        <%--掌柜推荐 start--%>
        <c:set value="${sdk:findShopPageModuleProxy(param.shopId,'shop_right1').recommendProducts}" var="prd"/>
        <c:choose>
            <c:when test="${not empty prd}">
                <div class="recom">
                    <p class="shopEdit" shopInfo="shop_link1">
                        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link1').links}" var="pageLinks" end="0" varStatus="s">
                            <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                        </c:forEach>
                    </p>
                    <div class="title shopEdit" shopInfo="shop_right1" >
                        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right1').recommendProducts}" var="prd" end="7">
                            <ul>
                                <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                <li><a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}">${prd.name}</a></li>
                                <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                            </ul>
                        </c:forEach>
                    </div><div class="clear"></div>
                    <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${isShowAdvAndRecommend}">
                    <div class="recom">
                        <p class="shopEdit" shopInfo="shop_link1">
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link1').links}" var="pageLinks" end="0" varStatus="s">
                                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                            </c:forEach>
                        </p>
                        <div class="title shopEdit" shopInfo="shop_right1" >
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right1').recommendProducts}" var="prd" end="7">
                                <ul>
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                    <li><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                    <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                    <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                                </ul>
                            </c:forEach>
                        </div><div class="clear"></div>
                        <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
        <%--掌柜推荐 end--%>

        <%--人气推荐 start--%>
        <c:set value="${sdk:findShopPageModuleProxy(param.shopId,'shop_right2').recommendProducts}" var="prd"/>
        <c:choose>
            <c:when test="${not empty prd}">
                <div class="recom">
                        <%--      <p><a href="#">人气推荐</a></p>--%>
                    <p class="shopEdit" shopInfo="shop_link2">
                        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link2').links}" var="pageLinks" end="0" varStatus="s">
                            <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                        </c:forEach>
                    </p>
                    <div class="title">
                        <div class="title shopEdit" shopInfo="shop_right2" >
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right2').recommendProducts}" var="prd" end="7">
                                <ul>
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                    <li><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                    <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                    <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                                </ul>
                            </c:forEach>


                        </div><div class="clear"></div>
                    </div><div class="clear"></div>
                    <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${isShowAdvAndRecommend}">
                    <div class="recom">
                            <%--      <p><a href="#">人气推荐</a></p>--%>
                        <p class="shopEdit" shopInfo="shop_link2">
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link2').links}" var="pageLinks" end="0" varStatus="s">
                                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                            </c:forEach>
                        </p>
                        <div class="title">
                            <div class="title shopEdit" shopInfo="shop_right2" >
                                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right2').recommendProducts}" var="prd" end="7">
                                    <ul>
                                        <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                        <li><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                        <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                        <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                                    </ul>
                                </c:forEach>


                            </div><div class="clear"></div>
                        </div><div class="clear"></div>
                        <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
        <%--人气推荐 end--%>

        <%--新品上架 start--%>
        <c:set value="${sdk:findShopPageModuleProxy(param.shopId,'shop_right3').recommendProducts}" var="prd"/>
        <c:choose>
            <c:when test="${not empty prd}">
                <div class="recom">
                        <%--  <p><a href="#">新品上架</a></p>--%>
                    <p class="shopEdit" shopInfo="shop_link3">
                        <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link3').links}" var="pageLinks" end="0" varStatus="s">
                            <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                        </c:forEach>
                    </p>
                    <div class="title">
                        <div class="title shopEdit" shopInfo="shop_right3" >
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right3').recommendProducts}" var="prd" end="7">
                                <ul>
                                    <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                    <li><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                    <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                    <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                                </ul>
                            </c:forEach>


                        </div><div class="clear"></div>
                    </div><div class="clear"></div>
                    <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${isShowAdvAndRecommend}">
                    <div class="recom">
                            <%--  <p><a href="#">新品上架</a></p>--%>
                        <p class="shopEdit" shopInfo="shop_link3">
                            <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_link3').links}" var="pageLinks" end="0" varStatus="s">
                                <a title="${pageLinks.title}" target="_blank" href="${pageLinks.link}">${pageLinks.title}</a>
                            </c:forEach>
                        </p>
                        <div class="title">
                            <div class="title shopEdit" shopInfo="shop_right3" >
                                <c:forEach items="${sdk:findShopPageModuleProxy(param.shopId,'shop_right3').recommendProducts}" var="prd" end="7">
                                    <ul>
                                        <a href="${webRoot}/product-${prd.productId}.html" title="${prd.name}" target="_blank"><img alt="${prd.name}" src="${empty prd.images ? prd.defaultImage['160X160'] : prd.images[0]['160X160']}" width="160px" height="160px"/></a>
                                        <li><a href="${webRoot}/product-${prd.productId}.html">${prd.name}</a></li>
                                        <h2><a href="javascript:void(0);">销售价<span>${prd.price.unitPrice}元</span></a></h2>
                                        <h3><a href="javascript:void(0);">已销售<span>${prd.salesVolume}</span>笔</a></h3>
                                    </ul>
                                </c:forEach>


                            </div><div class="clear"></div>
                        </div><div class="clear"></div>
                        <div class="botton"><a href="${webRoot}/shopTemplate/default/shopProductList.ac?shopId=${param.shopId}">更多宝贝</a></div>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
        <%--新品上架 end--%>


        <div class="shopEdit" shopInfo="shop_bottom_custom1">
            <c:set var="defineHtml4" value="${sdk:findShopPageModuleProxy(param.shopId,'shop_bottom_custom1').pageModuleObjects[0].userDefinedContStr}"/>
            <div style="${empty defineHtml4 ? "display:none" : "display:block"}">
                ${empty defineHtml4 ? "自定义区块":defineHtml4}
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
