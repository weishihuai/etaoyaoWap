<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--获取店铺信息--%>
<c:set value="${sdk:getShopInfProxyById(param.shopId)}" var="shop"/>
<%--获取分类ID--%>
<c:set value="${empty param.shopCategoryId ? '' : param.shopCategoryId}" var="shopCategoryId"/>
<c:if test="${empty shop || shop.isFreeze == 'Y'}">
    <c:redirect url="/wap/index.ac"></c:redirect>
</c:if>

<%--因为店铺没有统计关键字，所以查找平台的关键字--%>
<%--<c:set value="${sdk:findKeywordByCategoryId(1,20)}" var="hotKeywords"/>--%>
<!Doctype html>
<html>
<head>
    <title>商品搜索</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/module/shop/statics/css/shop-search.css" rel="stylesheet">

    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
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
    <script src="${webRoot}/template/bdw/oldWap/module/shop/statics/js/shopSearch.js"></script>
</head>
<body>
<!--头部-->
<c:if test="${isWeixin!='Y'}">
<header class="header">
    <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
    <span class="title">商品搜索</span>
    <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
</header>
</c:if>

<div class="container">
    <div class="row">
        <div class="col-xs-12">
           <%-- <c:set value="${bdw:getSearchFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>--%>
            <form id="searchForm" action="">
                <div class="input-group" style="margin:10px 0;">
                    <div class="search-big-box" style="margin-right: 10px;">
                        <input name="keyword" type="text" id="put" placeholder="商品搜索" class="form-control" style="border-radius: 4px;">
                    </div>
                    <span class="input-group-btn" style="margin-left: 10px;">
                        <button class="btn btn-default" style="font-weight: bold;border-radius: 6px;color: #555;" type="button" id="search_btn">搜 索</button>
                    </span>
                </div>
                <div class="alert alert-warning sr-only"id="alert">请输入搜索关键字!</div>
            </form>
        </div>
    </div>
   <%-- <div class="row i_row">
        <div class="col-xs-12">
            <c:forEach items="${hotKeywords}" var="hotKeyword">
                <c:choose>
                    <c:when test="${not empty hotKeyword}">
                        <a class="btn btn-default btn-default23" role="button" href="${webRoot}/wap/module/shop/shopProductList.ac?shopId=${param.shopId}&shopCategoryId=${param.shopCategoryId}&keyword=${hotKeyword}" title="${hotKeyword}">${hotKeyword}</a>
                    </c:when>
                </c:choose>
            </c:forEach>
        </div>
    </div>--%>
</div>
</body>
</html>