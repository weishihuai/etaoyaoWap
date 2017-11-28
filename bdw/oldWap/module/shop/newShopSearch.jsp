<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<%--获取分类ID--%>
<c:set value="${empty param.shopCategoryId ? '' : param.shopCategoryId}" var="shopCategoryId"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>商品搜索</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/newShop-search.css">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>

    <script type="text/javascript">
        var goToUrl = function(url){
            setTimeout(function(){window.location.href=url},1)
        };
        var Top_Path = {
            webRoot:"${webRoot}",
            page:"${_page}",
            keyword:"${param.keyword}",
            order:"${param.order}",
            shopId:"${param.shopId}",
            q:"${param.q}",
            shopCategoryId:"${shopCategoryId}"
        };
    </script>
    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/newShopSearch.js"></script>
</head>

<body>
<div class="search-header">
    <a class="backtrack" onclick="history.go(-1);">返回</a>
    <a class="action" id="search_btn">搜索</a>
    <div class="inp-box">
        <i class="icon icon-search"></i>
        <input class="inp-txt" type="text" name="keyname" id="put" placeholder="商品搜索" />
    </div>
</div>




<script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/base.js"></script>
</body>

</html>
