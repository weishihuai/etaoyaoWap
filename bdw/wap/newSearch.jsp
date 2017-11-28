<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>

<%--根据商品分类ID查询热门搜索关键字信息--%>
<c:set value="${sdk:findKeywordByCategoryId(param.category,20)}" var="hotKeywords"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>搜索-${webName}</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/search.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/wap/statics/css/empty.css">
    <script src="${webRoot}/template/bdw/wap/statics/js/jquery.js"></script>
    <%--此处如果使用jquery-1.6.1.min.js,那么xyPop插件将不起作用--%>
    <%--<script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>--%>
    <script src="${webRoot}/template/bdw/wap/statics/js/xyPop/xyPop.js"></script>
    <script src="${webRoot}/template/bdw/wap/statics/js/newSearch.js"></script>
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
        <form action="${webRoot}/wap/productList.ac?" method="post">
            <input class="inp-txt" type="text" name="keyword" id="put" placeholder="搜索"/>
            <input type="hidden" value="1" name="category"/>
            <input type="hidden" value="${param.shopId}" name="shopId"/>
        </form>
    </div>
</div>
<div class="main">
    <dl class="hot-search">
        <dt>热门搜索</dt>
        <c:forEach items="${hotKeywords}" var="hotKeyword" end="9">
            <c:choose>
                <c:when test="${not empty hotKeyword}">
                   <a href="${webRoot}/wap/productList.ac?keyword=${hotKeyword}"><dd role="button" title="${hotKeyword}">${hotKeyword}</dd></a>
                </c:when>
            </c:choose>
        </c:forEach>
    </dl>
    <dl class="history-record">
        <dt>
            历史记录
            <span class="clear-history">清空</span>
        </dt>
    </dl>
</div>

<script src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
</body>
</html>
