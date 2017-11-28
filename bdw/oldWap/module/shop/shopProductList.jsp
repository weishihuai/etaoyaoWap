<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="f" uri="/iMallTag" %>
<c:set value="${sdk:getLoginUser()}" var="loginUser"/>

<c:set value="${sdk:getShopCategoryProxy(param.shopId)}" var="shopCategory"/>
<c:set value="${empty param.page ? 1 : param.page}" var="_page"/>
<c:set value="${sdk:search(10)}" var="productProxys"/>
<c:set value="${empty param.shopCategoryId ? '' : param.shopCategoryId}" var="shopCategoryId"/>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${webName}-${shop.shopNm}--商品列表</title>
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/base.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/header.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-index.css" type="text/css" rel="stylesheet" />
    <link href="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/css/zepto.alert.css" rel="stylesheet" type="text/css" >
    <link href="${webRoot}/template/bdw/statics/js/easydialog/easydialog.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript">
        var paramData={
            webRoot:"${webRoot}",
            page:"${_page}",
            /*category:"${shopCategoryId}",*/
            keyword:"${param.keyword}",
            order:"${param.order}",
            shopId:"${param.shopId}",
            /*q是queryString*/
            q:"${param.q}",
            shopCategoryId:"${shopCategoryId}"
        };
    </script>
    <script type="text/javascript" src="${webRoot}/iMall/admin/commons/jqGrid/js/jquery-1.7.2.min.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.min.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/Tiny-Alert/js/zepto.alert.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/tinyAlertDialog.js" type="text/javascript"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/shopProductList.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/easydialog/easydialog.js"></script>
</head>

<body>
    <!--头部-->
    <header class="header">
        <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
        <span class="title">商品列表</span>
        <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
    </header>
    <!--中间内容-->
    <div class="main">
        <div class="top-search"><input type="text" placeholder="商品搜索" class="keyword" id="listSearchBtn"></div>
       <c:choose>
           <c:when test="${empty productProxys.result}">
               <div class="mc" style="text-align: center;padding-top: 30px;font-size: 20px;font-weight: 500;margin-bottom: 100px;">
                   亲，找不到任何商品！
               </div>
           </c:when>
           <c:otherwise>
               <div class="mc">
                   <div class="mc-cont" style="margin-top:0px;">
                       <div class="mc-tab">
                           <ul>
                               <li id="defaultOrder" class="cur"><a href="javacript:void(0);">默认排行</a></li>
                               <li id="saleOrder"><a href="javacript:void(0);">销量</a></li>
                               <li id="priceOrder"><a href="javacript:void(0);">价格</a></li>
                           </ul>
                       </div>
                       <div class="tab-cont">
                           <ul id="productUl">
                               <c:forEach items="${productProxys.result}" var="product" varStatus="status" end="9">
                                   <li>
                                       <a href="${webRoot}/wap/product.ac?id=${product.productId}">
                                           <div class="g-pic">
                                               <img class="productPic" src="${product.defaultImage["320X320"]}" alt="${product.name}">
                                           </div>
                                           <div class="g-title">${product.name}</div>
                                       </a>
                                       <div class="g-price">¥ <span>${product.price.unitPrice}</span></div>
                                       <a class="star ${product.collect ? 'cur' : ''}" productId="${product.productId}" isCollect="${product.collect}" href="javascript:"></a>
                                   </li>
                               </c:forEach>
                           </ul>
                           <c:if test="${productProxys.lastPageNumber ne _page}">
                               <a href="javascript:void(0);" class="more">查看更多商品</a>
                           </c:if>
                       </div>
                   </div>
               </div>
           </c:otherwise>
       </c:choose>
    </div>

    <div class="footer">
        <c:if test="${not empty productProxys.result}">
            <div class="footer-logo">
                <img src="${webRoot}/template/bdw/oldWap/module/shop/statics/images/footer-logo.png" alt="亚中e淘">
            </div>
        </c:if>
    </div>

</body>

</html>




