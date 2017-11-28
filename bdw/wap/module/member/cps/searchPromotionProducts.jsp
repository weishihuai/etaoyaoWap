<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <title>搜索-全品推-${webName}</title>

    <link type="text/css" rel="stylesheet" href="${webRoot}/template/bdw/wap/module/member/cps/statics/css/header.css">

    <script src="${webRoot}/template/bdw/wap/statics/js/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/statics/js/base.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/wap/module/member/cps/statics/js/searchPromotionProducts.js"></script>
    <script type="text/javascript">
        var webPath = {webRoot: "${webRoot}"};
        $(function(){
            $("#searchFields").focus();
        })
    </script>
</head>
<body>
<header class="header">
    <a href="javascript:history.go(-1);" class="back"></a>
    <div class="search-input">
        <form id="searchForm" action="${webRoot}/wap/module/member/cps/cpsAllPromotionProducts.ac">
            <input type="hidden" name="category" value="1"/>
            <c:choose>
                <c:when test="${not empty param.keyword}">
                    <input class="inp" id="searchFields" name="keyword" type="text" value="${param.keyword}" />
                </c:when>
                <c:otherwise>
                    <input id="searchFields" name="keyword" class="inp" type="text"
                           placeholder="请输入商品关键字" autocomplete="off" />
                </c:otherwise>
            </c:choose>
            <a class="op-icon del" href="javascript:;"></a>
        </form>
        <div class="clear"></div>
    </div>
    <a href="javascript:void(0);" class="hr-btn">搜索</a>
</header>
</body>
</html>
