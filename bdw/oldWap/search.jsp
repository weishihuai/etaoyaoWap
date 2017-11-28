<%--
  Created by IntelliJ IDEA.
  User: liuray
  Date: 13-11-28
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:set value="${sdk:findKeywordByCategoryId(param.category,20)}" var="hotKeywords"/>
<!Doctype html>
<html>
<head>
    <title>商品搜索</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/list.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/index.css" rel="stylesheet">
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var goToUrl = function(url){
            setTimeout(function(){window.location.href=url},1)
        };
        var Top_Path = {webRoot:"${webRoot}"};
    </script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/search.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/oldWap/module/common/head.jsp?title=商品搜索"/>
<%--页头结束--%>
<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <c:set value="${bdw:getSearchFromCookie(pageContext.request,pageContext.response)}" var="productFromCookies"/>
            <form id="searchForm" action="${webRoot}/wap/list.ac" method="get">
                <div class="input-group" style="margin:10px 0;">
                    <div class="search-big-box">
                        <input name="keyword" type="text" id="put" placeholder="输入商品关键字" class="form-control">
                        <div class="search-box">
                            <c:choose>
                                <c:when test="${ not empty productFromCookies}">
                                    <ul class="search-list" style="display: none;" id="search-list">
                                        <c:forEach items="${productFromCookies}" var="p">
                                            <li><a href="#">${p}</a></li>
                                        </c:forEach>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <ul class="search-list" style="display: none;" id="no-search-list">
                                        <li><a href="javascript:" style="text-decoration: none">无搜索记录</a></li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>


                    <span class="input-group-btn">
                        <button class="btn btn-default btn-danger" type="button" id="search_btn"><span class="glyphicon glyphicon-search"/></button>
                    </span>
                </div>
                <input type="hidden" name="category" value="1"/>
                <div class="alert alert-warning sr-only"id="alert">请输入搜索关键字!</div>
            </form>
        </div>
    </div>
    <div class="row i_row">

        <div class="col-xs-12">

            <c:forEach items="${hotKeywords}" var="hotKeyword">
                <c:choose>
                <c:when test="${not empty hotKeyword}">
                <a class="btn btn-default btn-default23" role="button" href="${webRoot}/wap/list.ac?keyword=${hotKeyword}" title="${hotKeyword}">${hotKeyword}</a>
                </c:when>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</div>
<%--menu开始--%>
<%--<c:import url="/template/bdw/oldWap/module/common/menu.jsp"/>--%>
<%--menu结束--%>
</body>
</html>