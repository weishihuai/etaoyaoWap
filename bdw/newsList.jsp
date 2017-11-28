<%--
  Created by IntelliJ IDEA.
  User: GJS
  Date: 2016/3/17
  Time: 下午 7:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(54980)}" var="mainCategory"/>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set value="${sdk:findArticlePageByCategoryId(page,7,param.categoryId)}" var="categoryArticle"/>
<c:set value="${sdk:findArticlePageByKeyword(page,7,param.newsKeyword)}" var="keywordArticle"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="keywords" content="<c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.categoryId eq param.categoryId ? oneCategory.name : ''}</c:forEach>资讯_<c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.categoryId eq param.categoryId ? oneCategory.name : ''}</c:forEach>新闻" /> <%--SEO keywords优化--%>
  <meta name="description" content="${webName}提供<c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.categoryId eq param.categoryId ? oneCategory.name : ''}</c:forEach>有关新闻资讯，同时为医药企业提供医药展会，医药招标查询，医药中标查询，医药资讯，药品数据库等资讯信息。" /> <%--SEO description优化--%>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title> <c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.categoryId eq param.categoryId ? oneCategory.name : ''}</c:forEach>资讯_<c:forEach items="${mainCategory.children}" var="oneCategory">${oneCategory.categoryId eq param.categoryId ? oneCategory.name : ''}</c:forEach>新闻_${webName}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/news-list.css">
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/jquery-1.8.3.min.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/common-func.js"></script>
  <script type="text/javascript" src="${webRoot}/template/bdw/statics/js/newsSearch.js"></script>
  <script type="text/javascript">
    var webPath = {webRoot:"${webRoot}"}
  </script>
</head>
<body>
<%--页头开始--%>
<c:import url="/template/bdw/module/common/top.jsp"/>
<%--页头结束--%>
<!--主体-->
<div class="main">
  <div class="top-nav">
    <div class="mt-cont">
      <div class="nav">
        <a class="" href="${webRoot}/newsIndex.ac">资讯首页<span></span></a>
        <c:forEach items="${mainCategory.children}" var="oneCategory">
          <a ${oneCategory.categoryId eq param.categoryId ? 'class="cur"' : 'class'} href="${webRoot}/newsList-${oneCategory.categoryId}.html">${oneCategory.name}<span></span></a>
        </c:forEach>
      </div>
      <div class="search">
        <a href="javascript:;" class="search-btn"></a>
        <input id="newsKeyword" type="text" placeholder="请输入关键字" value="${param.newsKeyword}" onclick="edit(this)">
        <a id="confirmBtn" class="btn btn-submit" onclick="searchNews()" href="javascript:;" title="">确定</a>
        <a id="cancelBtn" class="btn" onclick="removeEdit(this)" href="javascript:;" title="">取消</a>
      </div>
    </div>
  </div>
  <div class="cont">
    <div class="message-box">
      <c:if test="${not empty param.categoryId && empty param.newsKeyword}">
        <ul>
          <c:forEach items="${categoryArticle.result}" var="article">
            <li>
              <h1 class="title">
                <c:choose>
                  <c:when test="${not empty article.externalLink}">
                    <a href="${article.externalLink}" target="_blank">${article.title}</a>
                  </c:when>
                  <c:otherwise>
                    <a href="${webRoot}/newsDetails-${article.categoryId}-${article.infArticleId}.html" ${article.newWindow ? ' target="_blank"' : ''}>${article.title}</a>
                  </c:otherwise>
                </c:choose>
              </h1>
              <div class="abstract-box">
                作者：${article.author}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                来源：${article.source}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                发布时间：<fmt:formatDate value="${article.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </div>
              <div class="desc">
                <c:choose>
                  <c:when test="${not empty article.externalLink}">
                    <a href="${article.externalLink}" target="_blank">${article.title}</a>
                  </c:when>
                  <c:otherwise>
                    ${sdk:cleanHTML(article.articleCont,"")}
                  </c:otherwise>
                </c:choose>
              </div>
            </li>
          </c:forEach>
        </ul>
      </c:if>
      <c:if test="${empty param.categoryId && not empty param.newsKeyword}">
        <ul>
          <c:forEach items="${keywordArticle.result}" var="article">
            <li>
              <h1 class="title">
                <c:choose>
                  <c:when test="${not empty article.externalLink}">
                    <a href="${article.externalLink}" target="_blank">${article.title}</a>
                  </c:when>
                  <c:otherwise>
                    <a href="${webRoot}/newsDetails-${article.categoryId}-${article.infArticleId}.html"  ${article.newWindow ? ' target="_blank"' : ''}>${article.title}</a>
                  </c:otherwise>
                </c:choose>
              </h1>
              <div class="abstract-box">
                作者：${article.author}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                来源：${article.source}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                发布时间：<fmt:formatDate value="${article.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              </div>
              <div class="desc">
                <c:choose>
                  <c:when test="${not empty article.externalLink}">
                    <a href="${article.externalLink}" target="_blank">${article.title}</a>
                  </c:when>
                  <c:otherwise>
                    ${sdk:cleanHTML(article.articleCont,"")}
                  </c:otherwise>
                </c:choose>
              </div>
            </li>
          </c:forEach>
        </ul>
      </c:if>
    </div>
    <div class="other-message">
      <div class="n-title"><span>热门文章</span></div>
      <div class="some-news">
        <div class="have-pic">
          <div class="pic frameEdit" frameInfo="rightAdv">
            <c:forEach items="${sdk:findPageModuleProxy('rightAdv').advt.advtProxy}" var="advtProxys" end="0">
              <a target="_blank" href="${advtProxys.link}" title="${advtProxys.title}"><img src="${advtProxys.advUrl}" width="280px" height="120px" /></a>
            </c:forEach>
          </div>
        </div>
        <div class="no-pic frameEdit" frameInfo="article_recommend">
          <ul>
            <c:forEach items="${sdk:findPageModuleProxy('article_recommend').recommendArticles}" var="recommendArticles" end="9">
              <li class="elli">
                <c:choose>
                  <c:when test="${not empty recommendArticles.externalLink}">
                    <a href="${recommendArticles.externalLink}" target="_blank">${recommendArticles.title}</a>
                  </c:when>
                  <c:otherwise>
                    <a href="${webRoot}/newsDetails-${recommendArticles.categoryId}-${recommendArticles.infArticleId}.html" target="_blank">${recommendArticles.title}</a>
                  </c:otherwise>
                </c:choose>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="clear"></div>

    <div class="page-box">
      <div class="page-footer">
        <c:if test="${not empty param.categoryId && empty param.newsKeyword}">
          <c:if test="${categoryArticle.lastPageNumber>1}">
            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${categoryArticle.lastPageNumber}' currentPage='${page}'  totalRecords='${categoryArticle.totalCount}' ajaxUrl='${webRoot}/newsList.ac' frontPath='${webRoot}' displayNum='6' />
          </c:if>
        </c:if>
        <c:if test="${empty param.categoryId && not empty param.newsKeyword}">
          <c:if test="${keywordArticle.lastPageNumber>1}">
            <p:PageTag isDisplayGoToPage="true" isDisplaySelect="false" totalPages='${keywordArticle.lastPageNumber}' currentPage='${page}'  totalRecords='${keywordArticle.totalCount}' ajaxUrl='${webRoot}/newsList.ac' frontPath='${webRoot}' displayNum='6' />
          </c:if>
        </c:if>
      </div>
    </div>
  </div>


</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>


