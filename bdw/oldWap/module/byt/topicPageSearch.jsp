<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findKeywordByCategoryId(param.category,20)}" var="hotKeywords"/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>搜索-易淘药健康网</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="yes" name="apple-touch-fullscreen" />
    <meta content="telephone=no,email=no" name="format-detection" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>

    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/base.css" />
    <link rel="stylesheet" href="${webRoot}/template/bdw/oldWap/statics/css/search.css">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/xyPop/xyPop.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/module/byt/statics/js/topicPageSearch.js"></script>
    <script type="text/javascript">
        var goToUrl = function(url){
            setTimeout(function(){window.location.href=url},1)
        };
        var Top_Path = {webRoot:"${webRoot}"};
    </script>
</head>
<c:set value="${sdk:findKeywordByCategoryId(param.category,20)}" var="hotKeywords"/>
<body>
<div class="search-header">
    <a class="backtrack" ></a>
    <a class="action" id="search_btn" href="javascript:void(0);">搜索</a>
    <div class="inp-box">
        <i class="icon icon-search"></i>
        <input class="inp-txt" type="text" name="keyword" id="put" placeholder="搜索" />
    </div>
</div>

</div>
<div class="main">
    <%--<dl class="hot-search">
        <dt>热门搜索</dt>
        <c:forEach items="${hotKeywords}" var="hotKeyword" end="9">
            <c:choose>
                <c:when test="${not empty hotKeyword}">
                   <a href="${webRoot}/wap/module/byt/list.ac?keyword=${hotKeyword}&shopId=988"><dd role="button"  title="${hotKeyword}">${hotKeyword}</dd></a>
                </c:when>
            </c:choose>
        </c:forEach>
    </dl>--%>
    <%--<dl class="history-record">
        <dt>
            历史记录
            <span class="clear-history">清空</span>
        </dt>
    </dl>--%>
</div>



<script src="${webRoot}/template/bdw/oldWap/statics/js/base.js"></script>
</body>

</html>
