<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/1/1
  Time: 17:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<c:if test="${not empty param.articleId}">
    <c:set value="${sdk:getArticleById (param.articleId)}" var="article"/>
    <c:set value="${sdk:getArticleCategoryById(article.categoryId)}" var="articleCategory"/>
</c:if>
<html>
<head>
    <title>${article.title}-${webName}触屏版</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- Bootstrap -->
    <link href="${webRoot}/template/bdw/oldWap/statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/footer.css" rel="stylesheet" media="screen">
    <link href="${webRoot}/template/bdw/oldWap/statics/css/article.css" rel="stylesheet" media="screen">
    <style>
        img{width: 100%;}
    </style>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/jquery.js"></script>
    <script src="${webRoot}/template/bdw/oldWap/statics/js/bootstrap.min.js"></script>
</head>
<body>
<%--头部--%>
<header class="header">
    <a onclick="history.go(-1);" href="javascript:void(0);" class="back"></a>
    <span class="title" title="${article.title}">${article.title}</span>
    <a href="javascript:void(0);" class="home" onclick="window.location.href='${webRoot}/wap/index.ac?time='+ new Date().getTime()"></a>
</header>

<%--内容--%>
<div style="width: 94%;margin:15px auto 80px;">
    ${article.articleCont}
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/oldWap/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
