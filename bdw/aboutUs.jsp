<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(54979)}" var="mainCategory"/>
<%--根据传进来的文章Id取得该文章和该文章分类（面包屑生成）--%>
<c:choose>
    <c:when test="${not empty param.infArticleId}">
        <c:set value="${param.infArticleId}" var="infArticleId"/>
    </c:when>
    <c:otherwise>
        <c:forEach items="${mainCategory.children}" var="oneCategory" varStatus="c">
            <c:forEach items="${sdk:getArticleCategoryById(oneCategory.categoryId).top5}" var="articleProxy" varStatus="s">
                <c:if test="${c.first and s.first}">
                    <c:set value="${articleProxy.infArticleId}" var="infArticleId"/>
                </c:if>
            </c:forEach>
        </c:forEach>
    </c:otherwise>
</c:choose>

<c:set value="${sdk:getArticleById (infArticleId)}" var="article"/>
<c:set value="${article.articleCategoryProxy}" var="articleCategory"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <c:choose>
        <c:when test="${empty article and  empty articleCategory}">
            <title>关于我们-${sdk:getSysParamValue('index_title')}-${webName}</title>
        </c:when>
        <c:otherwise>
            <title>${empty article.metaTitle ? article.title:article.metaTitle}-关于我们-${webName}</title>
            <meta name="keywords" content="${empty article.seoKeywords? article.title:article.seoKeywords}" />
            <meta name="description" content="${empty article.metaDescr ? article.title : article.metaDescr}" />
        </c:otherwise>
    </c:choose>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
    <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/aboutUs.css">
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
    <%--<script type="text/javascript" src="${webRoot}/template/bdw/statics/js/help.js"></script>--%>
    <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/aboutUs.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<!--主体-->
<div class="main-bg">
    <div id="position" class="m1-bg">
        <div class="m1">
            <a href="${webRoot}/index.html">首页</a>

            <c:if test="${empty article}">
                <a href="${webRoot}/aboutUs.ac">${mainCategory.name}</a>
            </c:if>
            <c:if test="${not empty article}">
                <c:forEach items="${articleCategory.categoryPath}" var="category" varStatus="stats" begin="2" end="2">
                    <c:if test="${stats.first}">
                        > <a href="${webRoot}/aboutUs.ac"> ${category.name}</a>
                    </c:if>
                    <c:if test="${not stats.first}">
                        > ${category.name}
                    </c:if>
                </c:forEach>
                > ${article.title}
            </c:if>
        </div>
    </div>
    <div class="main clearfix">
        <div class="main-lt">
            <c:forEach items="${mainCategory.children}" var="oneCategory" varStatus="c">
                <dl>
                    <dt class="title">${oneCategory.name}</dt>
                    <dd>
                        <c:forEach items="${sdk:getArticleCategoryById(oneCategory.categoryId).top20}" var="articleProxy" varStatus="s">
                            <a class="article <c:if test="${articleProxy.infArticleId eq infArticleId}">cur</c:if>" href="${webRoot}/aboutUs-${articleProxy.infArticleId}.html">${articleProxy.title}</a>
                        </c:forEach>
                    </dd>
                </dl>
            </c:forEach>
        </div>
        <c:if test="${not empty infArticleId}">
            <c:choose>
                <c:when test="${not empty article.externalLink}">
                    <div class="help-cont">
                        <div class="mt">${article.title}</div>
                        <div class="mc">
                            <iframe src="${article.externalLink}" style="width:812px; height: 780px; border:none"></iframe>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="help-cont">
                        <div class="mt">${article.title}</div>
                        <div class="mc">
                            <p>${article.articleCont}</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
</div>

<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
