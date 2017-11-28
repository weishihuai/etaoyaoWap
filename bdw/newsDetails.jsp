<%--
  Created by IntelliJ IDEA.
  User: GJS
  Date: 2016/3/18
  Time: 上午 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/template/bdw/module/common/taglibs.jsp" %>
<%@ taglib prefix="p" uri="/iMallTag" %>
<%--一级分类--%>
<c:set value="${sdk:getArticleCategoryById(54980)}" var="mainCategory"/>
<c:set value="${sdk:getArticleById(param.infArticleId)}" var="article"/>
<c:if test="${empty article}">
  <c:redirect url="/newsIndex.ac"/>
</c:if>
<c:set var="page" value="${empty param.page ? 1 : param.page}"/>
<c:set value="${sdk:findArticlePageByCategoryId(page,100,param.categoryId)}" var="categoryArticles"/>

<c:set var="defultImg" value="${webRoot}/template/bdw/statics/images/defult_new_xin_wen.jpg"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="keywords" content="${empty article.seoKeywords ? article.title : article.seoKeywords}" /> <%--SEO keywords优化--%>
  <meta name="description" content="${empty article.metaDescr ? article.title : article.metaDescr}" /> <%--SEO description优化--%>
  <meta name="renderer" content="webkit">

  <!--必填-->
  <meta property="og:type" content="news"/>
  <meta property="og:title" content="${article.title}"/>
  <meta property="og:description" content="${empty article.metaDescr ? article.title : article.metaDescr}"/>
  <meta property="og:image" content="${empty article.fieldId?defultImg:article.icon['']}"/>
  <!--选填-->
  <meta property="og:release_date" content="${article.createTime}"/>

  <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge,chrome=1"/>
  <title>${empty article.metaTitle? article.title : article.metaTitle}_${webName}</title>
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/base.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/header.css">
  <link rel="stylesheet" href="${webRoot}/template/bdw/statics/css/news-details.css">
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
        <input id="newsKeyword" type="text" placeholder="请输入关键字" onclick="edit(this)">
        <a id="confirmBtn" class="btn btn-submit" onclick="searchNews()" href="javascript:;" title="">确定</a>
        <a id="cancelBtn" class="btn" onclick="removeEdit(this)" href="javascript:;" title="">取消</a>
      </div>
    </div>
  </div>
  <div class="cont">
    <div class="message-box">
        <div class="mt">
          <h1>${article.title}</h1>
          <div class="abstract-box">
            <span>作者：${article.author}</span>
            <span>来源：${article.source}</span>
            <span>发布时间：<fmt:formatDate value="${article.createTime}" type="both" dateStyle="long" pattern="yyyy.MM.dd" /></span>
          </div>
        </div>
        <div class="mc">
          <p>${article.articleCont}</p>
        </div>
        <div class="mb">
          <c:set value="${sdk:findArticlePageUpAndNextPage(article.infArticleId)}" var="upAndNextPage"/>
          <c:if test="${not empty upAndNextPage['PageUp']}">
            <c:choose>
              <c:when test="${not empty upAndNextPage['PageUp'].externalLink}">
                <a href="${upAndNextPage['PageUp'].externalLink}" target="_blank"  class="prev">上一篇：${upAndNextPage['PageUp'].title}</a>
              </c:when>
              <c:otherwise>
                <a href="${webRoot}/newsDetails-${upAndNextPage['PageUp'].categoryId}-${upAndNextPage['PageUp'].infArticleId}.html" class="prev">上一篇：${upAndNextPage['PageUp'].title}</a>
              </c:otherwise>
            </c:choose>
          </c:if>
          <c:if test="${not empty upAndNextPage['NextPage']}">
            <c:choose>
              <c:when test="${not empty upAndNextPage['NextPage'].externalLink}">
                <a href="${upAndNextPage['NextPage'].externalLink}" target="_blank" class="next">下一篇：${upAndNextPage['NextPage'].title}</a>
              </c:when>
              <c:otherwise>
                <a href="${webRoot}/newsDetails-${upAndNextPage['NextPage'].categoryId}-${upAndNextPage['NextPage'].infArticleId}.html" class="next">下一篇：${upAndNextPage['NextPage'].title}</a>
              </c:otherwise>
            </c:choose>
          </c:if>
        </div>
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
              <li class="elli"><a href="${webRoot}/newsDetails-${recommendArticles.categoryId}-${recommendArticles.infArticleId}.html" target="_blank">${recommendArticles.title}</a></li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>


</div>
<%--页脚开始--%>
<c:import url="/template/bdw/module/common/bottom.jsp"/>
<%--页脚结束--%>
</body>
</html>
<script type="text/javascript">
  /******************页面类型*****************/
  _hmt.push(['_setPageTag', '860', "访问资讯"]);
  /******************页面类型*****************/
</script>
