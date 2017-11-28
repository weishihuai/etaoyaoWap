<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<c:set value="${param.shopId}" var="shopId"/>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${empty shop.shopNm ? '搜索商品' : shop.shopNm}-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/search.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/empty.css">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/wap/outlettemplate/default/statics/js/outletSearch.js"></script>
    <script type="text/javascript">
        var goToUrl = function(url){
            setTimeout(function(){window.location.href=url},1)
        };
        var Top_Path = {
            webRoot:"${webRoot}",
            shopId:"${param.shopId}"
        };
    </script>
</head>
<body>
<div class="search-header">
    <a class="backtrack" href="javascript:history.go(-1)"></a>
    <a class="action" id="search_btn" href="javascript:void(0);">搜索</a>
    <div class="inp-box">
        <i class="icon icon-search"></i>
        <form action="${webRoot}/wap/outlettemplate/default/productList.ac?" method="post">
            <input class="inp-txt" type="text" name="keyword" id="put" placeholder="搜索"/>
            <input type="hidden" value="1" name="category"/>
            <input type="hidden" value="${param.shopId}" name="shopId"/>
        </form>
    </div>
</div>
<script src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>
</html>
