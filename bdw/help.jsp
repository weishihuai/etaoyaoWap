<%--
  Created by IntelliJ IDEA.
  User: GJS
  Date: 2016/3/22
  Time: 下午 5:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(60000)}" var="mainCategory"/>
<%--根据传进来的文章Id取得该文章和该文章分类（面包屑生成）--%>
<c:if test="${not empty param.infArticleId}">
  <c:set value="${sdk:getArticleById (param.infArticleId)}" var="article"/>
  <c:set value="${article.articleCategoryProxy}" var="articleCategory"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <c:choose>
    <c:when test="${empty article and  empty articleCategory}">
      <title>帮助中心-${sdk:getSysParamValue('index_title')}-${webName}</title>
    </c:when>
    <c:otherwise>
      <title>${empty article.metaTitle ? article.title : article.metaTitle}-帮助中心-${webName}</title>
      <meta name="keywords" content="${empty article.seoKeywords? article.title:article.seoKeywords}" />
      <meta name="description" content="${empty article.metaDescr ? article.title : article.metaDescr}" />
    </c:otherwise>
  </c:choose>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/help.css">
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/help.js"></script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>

<!--主体-->
<div class="main-bg">
  <div class="past">
    <a class="links" href="${webRoot}/index.ac">${webName}</a>
    <i class="crumbs-arrow">></i>
    <c:if test="${empty article}">
      <a class="links" href="javascript:void(0);">${mainCategory.name}</a>
    </c:if>
    <c:if test="${not empty article}">
      <c:forEach items="${articleCategory.categoryPath}" var="category" varStatus="stats" begin="1" end="2">
        <c:if test="${stats.first}">
          <a class="links" href="javascript:void(0);">${category.name}</a>
        </c:if>
        <c:if test="${not stats.first}">
          <span>${category.name}</span>
        </c:if>
        <i class="crumbs-arrow">></i>
      </c:forEach>
      <span>${article.title}</span>
    </c:if>
  </div>
  <div class="main clearfix">
    <div class="main-lt">
      <c:forEach items="${mainCategory.children}" var="oneCategory">
        <dl>
          <dt class="title">${oneCategory.name}</dt>
          <dd>
            <c:forEach items="${sdk:getArticleCategoryById(oneCategory.categoryId).top20}" var="articleProxy">
              <a class="article <c:if test="${articleProxy.infArticleId eq param.infArticleId}">cur</c:if>" href="${webRoot}/help-${articleProxy.infArticleId}.html">${articleProxy.title}</a>
            </c:forEach>
          </dd>
        </dl>
      </c:forEach>
    </div>
    <c:if test="${not empty param.infArticleId}">
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

